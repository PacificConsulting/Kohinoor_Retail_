codeunit 50301 "Event and Subscribers"
{
    trigger OnRun()
    begin

    end;


    //START**********************************CU-5708*******************************************
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Transfer Document", 'OnAfterReleaseTransferDoc', '', false, false)]
    local procedure OnAfterReleaseTransferDoc(var TransferHeader: Record "Transfer Header")
    var
        TL: Record "Transfer Line";
    begin
        TL.Reset();
        TL.SetRange("Document No.", TransferHeader."No.");
        IF TL.FindSet() then
            repeat
                TL.Validate("Qty. to Ship", 0);
                TL.Modify();
            until TL.Next() = 0;
    end;
    //END**********************************CU-5708*******************************************

    //START**********************************Table-37*******************************************
    //[EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterUpdateAmountsDone', '', false, false)]
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterUpdateUnitPrice', '', false, false)]
    local procedure OnAfterUpdateUnitPrice(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CalledByFieldNo: Integer; CurrFieldNo: Integer)
    begin
        // if not SalesLine."Price Inclusive of Tax" then
        //     exit;
        IF SalesLine."Unit Price" <> 0 then begin
            SalesLine."GST Tax Amount" := (SalesLine."Unit Price Incl. of Tax" - SalesLine."Unit Price") * SalesLine.Quantity;
            //Message('Amt %1- %2- %3 ', SalesLine."Unit Price Incl. of Tax", SalesLine."Unit Price", SalesLine."GST Tax Amount");
        end;

    end;

    //END**********************************Table-37*********************************************


    //START**********************************Codeunit-80***************************************
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvLineInsert', '', false, false)]
    local procedure OnAfterSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; ItemLedgShptEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean; CommitIsSuppressed: Boolean; var SalesHeader: Record "Sales Header"; var TempItemChargeAssgntSales: Record "Item Charge Assignment (Sales)" temporary; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; PreviewMode: Boolean)
    var
        PostedPayemntLine: Record "Posted Payment Lines";
        PaymentLine: Record "Payment Lines";
    begin
        PostedPayemntLine.Reset();
        PostedPayemntLine.SetRange("Document No.", SalesInvHeader."No.");
        IF not PostedPayemntLine.Find() then begin
            PaymentLine.Reset();
            PaymentLine.SetRange("Document Type", SalesHeader."Document Type");
            PaymentLine.SetRange("Document No.", SalesHeader."No.");
            if PaymentLine.FindSet() then
                repeat
                    PostedPayemntLine.InitFromPaymentLine(PostedPayemntLine, PaymentLine, SalesInvHeader);
                until PaymentLine.Next() = 0;
            DeletePayemntLines(SalesHeader, PaymentLine);
        end;
    end;

    //[EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSetPostingFlags', '', false, false)]

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeCheckPostingFlags', '', false, false)]
    local procedure OnBeforeCheckPostingFlags(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            IF SalesHeader."Store No." <> '' then begin
                SalesHeader.Ship := true;
                SalesHeader.Invoice := true;
            end
        end;
    end;
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeCheckHeaderPostingType', '', false, false)]
    // local procedure OnBeforeCheckHeaderPostingType(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    // begin
    //     SalesHeader.Ship := true;
    //     SalesHeader.Invoice := true;
    // end;


    //[EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeFinalizePosting', '', false, false)]
    local procedure OnBeforeFinalizePosting(var SalesHeader: Record "Sales Header"; var TempSalesLineGlobal: Record "Sales Line" temporary; var EverythingInvoiced: Boolean; SuppressCommit: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    Var
        ItemJ: record 83;
        ItemJInit: record 83;
        SalesLine: record 37;
        SalesInvLine: record 113;
        ReservEntryInit: Record 337;
        ReservEntry: Record 337;
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
        SR: Record "Sales & Receivables Setup";
    begin
        //<<***********Auto Postive Item Journal Line Created and Post*************

        SR.Get();
        SalesLine.reset();
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::"G/L Account");
        SalesLine.SetRange("No.", SR."Exchange Item G/L");
        SalesLine.SetFilter("Exchange Item No.", '<>%1', '');
        IF SalesLine.findset() then
            repeat
                // IF SalesLine."Exchange Item No." <> '' then begin
                ItemJInit.Init();
                ItemJInit."Journal Template Name" := 'ITEM';
                ItemJInit."Journal Batch Name" := 'TEST';
                ItemJ.Reset();
                ItemJ.SetRange("Journal Template Name", 'ITEM');
                ItemJ.SetRange("Journal Batch Name", 'TEST');
                IF ItemJ.FindLast() then
                    ItemJInit."Line No." := ItemJ."Line No." + 10000
                else
                    ItemJInit."Line No." := 10000;

                ItemJInit."Document No." := SalesHeader."No."; //SalesInvHdrNo;
                ItemJInit.Validate("Posting Date", Today);
                ItemJInit."Entry Type" := ItemJInit."Entry Type"::"Positive Adjmt.";
                ItemJInit.Validate("Item No.", SalesLine."Exchange Item No.");
                ItemJInit.Validate("Location Code", SalesLine."Location Code");
                ItemJInit.Validate("Bin Code", 'BACKPACK');
                ItemJInit.validate(Quantity, SalesLine.Quantity);
                ItemJInit.Validate("Unit of Measure Code", SalesLine."Unit of Measure Code");
                ItemJInit.Validate("Unit Amount", ABS(SalesLine."Unit Price"));
                ItemJInit.Validate("Shortcut Dimension 1 Code", SalesLine."Shortcut Dimension 1 Code");
                ItemJInit.Validate("Shortcut Dimension 2 Code", SalesLine."Shortcut Dimension 2 Code");
                ItemJInit.Insert();

                //<<******Reservation Creat for item Journal Line************
                ReservEntry.Reset();
                ReservEntry.LockTable();
                if ReservEntry.FindLast() then;
                ReservEntryInit.Init();
                ReservEntryInit."Entry No." := ReservEntry."Entry No." + 1;
                ReservEntryInit."Item No." := ItemJInit."Item No.";
                ReservEntryInit."Location Code" := ItemJInit."Location Code";
                ReservEntryInit.validate("Quantity (Base)", ItemJInit.Quantity);
                ReservEntryInit."Reservation Status" := ReservEntryInit."Reservation Status"::Prospect;
                ReservEntryInit."Source Type" := DATABASE::"Item Journal Line";
                ReservEntryInit."Source Subtype" := 2;
                ReservEntryInit."Source ID" := ItemJInit."Journal Template Name";
                ReservEntryInit."Source Batch Name" := ItemJInit."Journal Batch Name";
                ReservEntryInit."Source Ref. No." := ItemJInit."Line No.";
                ReservEntryInit."Creation Date" := Today;
                ReservEntryInit."Created By" := UserId;
                ReservEntryInit."Serial No." := SalesLine."Serial No.";
                ReservEntryInit."Expected Receipt Date" := Today;
                ReservEntryInit.Positive := true;
                ReservEntryInit."Item Tracking" := ReservEntryInit."Item Tracking"::"Serial No.";
                ReservEntryInit.Insert();
                ItemJnlPostBatch.Run(ItemJInit);
            //end;
            until SalesLine.next() = 0;

    end;
    //END**********************************Codeunit-80***************************************

    //START**********************************Codeunit-90***************************************
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeCheckReceiveInvoiceShip', '', false, false)]
    // local procedure OnBeforeCheckReceiveInvoiceShip(var PurchHeader: Record "Purchase Header"; var IsHandled: Boolean)
    // begin
    //     IF PurchHeader."Document Type" = PurchHeader."Document Type"::Order then begin
    //         PurchHeader.Receive := true;
    //         PurchHeader.Invoice := false;
    //     end;
    // end;

    //[EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterSetPostingFlags', '', false, false)]
    // local procedure OnAfterSetPostingFlags(var PurchHeader: Record "Purchase Header")
    // begin
    //     IF PurchHeader."Document Type" = PurchHeader."Document Type"::Order then begin
    //         PurchHeader.Receive := true;
    //         PurchHeader.Invoice := false;
    //     end;
    // end;
    //START**********************************Codeunit-5704***************************************
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeTransferOrderPostShipment', '', false, false)]
    local procedure OnBeforeTransferOrderPostShipment(var TransferHeader: Record "Transfer Header"; var CommitIsSuppressed: Boolean)
    begin

    end;
    //END**********************************Codeunit-5704***************************************

    //START**********************************Table-18***************************************
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeValidatePostCode', '', false, false)]
    local procedure OnBeforeValidatePostCode(var Customer: Record Customer; var PostCodeRec: Record "Post Code"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        // Customer."State Code" := PostCodeRec."State Code";
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterLookupPostCode', '', false, false)]
    local procedure OnAfterLookupPostCode(var Customer: Record Customer; xCustomer: Record Customer; var PostCodeRec: Record "Post Code")
    begin
        //Customer."State Code" := PostCodeRec."State Code";
    end;

    //END**********************************Table-18***************************************

    //******************* Local Function Created ***************************************
    local procedure DeletePayemntLines(salesHeaderRec: record "Sales Header"; RecPaymentLine: Record "Payment Lines")
    var
    begin
        RecPaymentLine.Reset();
        RecPaymentLine.SetRange("Document Type", salesHeaderRec."Document Type");
        RecPaymentLine.SetRange("Document No.", salesHeaderRec."No.");
        if RecPaymentLine.FindFirst() then
            RecPaymentLine.DeleteAll();
    end;

    var

}