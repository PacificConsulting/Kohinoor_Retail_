codeunit 50301 "Event and Subscribers"
{
    trigger OnRun()
    begin

    end;


    //<<<<<<<START********************************CU-80*****************************************
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean; PreviewMode: Boolean)
    var
        ABSBlobClient: Codeunit "ABS Blob Client";
        Authorization: Interface "Storage Service Authorization";
        ABSCSetup: Record "Azure Storage Container Setup";
        StorageServiceAuth: Codeunit "Storage Service Authorization";
        Instrm: InStream;
        OutStrm: OutStream;
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
        SIH: record 112;
        Recref: RecordRef;
        VResult: Text;
        B64: Codeunit "Base64 Convert";
    begin
        //*********Report SaveasPDF code********
        SIH.RESET;
        SIH.SETRANGE("No.", SalesInvHdrNo);
        IF SIH.FINDFIRST THEN;
        Recref.GetTable(SIH);
        TempBlob.CreateOutStream(OutStrm);
        Report.SaveAs(Report::"Tax Invoice", '', ReportFormat::Pdf, OutStrm, Recref);
        TempBlob.CreateInStream(Instrm);
        VResult := B64.ToBase64(Instrm);
        UploadonAzurBlobStorage(SIH."No." + '.PDF', VResult);
        /*
        //*************Azure upload Code**************
        ABSCSetup.Get();
        ABSCSetup.TestField("Container Name Invoice");
        Authorization := StorageServiceAuth.CreateSharedKey(ABSCSetup."Access key");
        ABSBlobClient.Initialize(ABSCSetup."Account Name", ABSCSetup."Container Name Invoice", Authorization);
        FileName := SIH."No." + '.' + 'pdf';
        // ABSBlobClient.
        ABSBlobClient.PutBlobBlockBlobStream(FileName, Instrm);
        ABSBlobClient.PutBlobPageBlob(FileName, 'application/pdf');//Sourav-New code added
        */

    end;
    //<<<<<<<END********************************CU-80*****************************************

    //<<<<<<<START********************************CU-12*****************************************
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitBankAccLedgEntry', '', false, false)]
    local procedure OnAfterInitBankAccLedgEntry(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        IF GenJournalLine."Approval Code" <> '' then begin
            BankAccountLedgerEntry."Approval Code" := GenJournalLine."Approval Code";
            //BankAccountLedgerEntry.Modify();
        end;
    end;
    //<<<<<<<END********************************CU-12*****************************************

    //<<<<<<<START********************************CU-90*****************************************
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterInsertReceiptHeader', '', false, false)]
    local procedure OnAfterInsertReceiptHeader(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; WhseReceive: Boolean; CommitIsSuppressed: Boolean)
    begin

        // PurchRcptHeader."Vendor Invoice No." := TempWhseRcptHeader."Vendor Invoice No.";
        // PurchRcptHeader."LR No." := TempWhseRcptHeader."LR No.";
        // PurchRcptHeader."LR Date" := TempWhseRcptHeader."LR Date";
        // PurchRcptHeader.Modify();
    end;
    //<<<<<<<END********************************CU-90*****************************************

    //START**********************************CU-5708*******************************************
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Transfer Document", 'OnAfterReleaseTransferDoc', '', false, false)]
    local procedure OnAfterReleaseTransferDoc(var TransferHeader: Record "Transfer Header")
    var
        TL: Record "Transfer Line";
    begin
        // TL.Reset();
        // TL.SetRange("Document No.", TransferHeader."No.");
        // IF TL.FindSet() then
        //     repeat
        //         TL.Validate("Qty. to Ship", 0);
        //         TL.Modify();
        //     until TL.Next() = 0;
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
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterInsertTransShptHeader', '', false, false)]
    local procedure OnAfterInsertTransShptHeader(var TransferHeader: Record "Transfer Header"; var TransferShipmentHeader: Record "Transfer Shipment Header")
    begin
        TransferShipmentHeader."Posted By" := TransferHeader."Posted By";
        TransferShipmentHeader.Modify();
    end;
    //END**********************************Codeunit-5704***************************************

    //START**********************************Codeunit-5705***************************************
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnAfterInsertTransRcptHeader', '', false, false)]
    local procedure OnAfterInsertTransRcptHeader(var TransRcptHeader: Record "Transfer Receipt Header"; var TransHeader: Record "Transfer Header")
    begin
        TransRcptHeader."Posted By" := TransHeader."Posted By";
        TransRcptHeader.Modify();
    end;
    //END**********************************Codeunit-5705***************************************


    //START**********************************Table-23***************************************

    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterLookupPostCode', '', false, false)]
    local procedure OnAfterLookupPostCode(var Vendor: Record Vendor; var PostCodeRec: Record "Post Code")
    begin
        IF PostCodeRec.get(Vendor."Post Code", Vendor.City) then
            Vendor."State Code" := PostCodeRec."State Code";
    end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterValidatePostCode', '', false, false)]
    local procedure OnAfterValidatePostCode(var Vendor: Record Vendor)
    var
        PostCodeRec: Record "Post Code";
    begin
        IF PostCodeRec.get(Vendor."Post Code", Vendor.City) then
            Vendor."State Code" := PostCodeRec."State Code"
    end;

    //END**********************************Table-23***************************************

    //START**********************************Table-224***************************************

    [EventSubscriber(ObjectType::Table, Database::"Order Address", 'OnAfterLookupPostCode', '', false, false)]
    local procedure OnAfterLookupPostCodeOrderAddress(var OrderAddress: Record "Order Address"; var PostCode: Record "Post Code"; FieldNo: Integer)
    begin
        IF PostCode.get(OrderAddress."Post Code", OrderAddress.City) then
            OrderAddress."State" := PostCode."State Code";
    end;

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

    local procedure UploadonAzurBlobStorage(FileName: Text; Base64: Text)

    Var
        client: HttpClient;
        cont: HttpContent;
        header: HttpHeaders;
        response: HttpResponseMessage;
        Jobject: JsonObject;
        tmpString: Text;
        token: Text;
        URL: text;
        AzurBlobSetup: Record "Azure Storage Container Setup";
    Begin
        AzurBlobSetup.Get();
        AzurBlobSetup.TestField("Azure Invoice URL");
        URL := AzurBlobSetup."Azure Invoice URL";//'https://prod-05.centralindia.logic.azure.com:443/workflows/c6dd57d4a8814ad0bd3e43bae6ecd6fe/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=dq8NlkzznvjIz9F1aYbWcaxHyGAgqaWBQjkCczmrLeg';
        //Jobject.Add('ApiToken', 'testapi');
        Jobject.Add('Document', Base64);
        Jobject.Add('FileName', FileName);
        Jobject.WriteTo(tmpString);
        cont.WriteFrom(tmpString);
        cont.ReadAs(tmpString);
        cont.GetHeaders(header);
        header.Remove('Content-Type');
        header.Add('Content-Type', 'application/json');
        client.Post(URL, cont, response);
    end;
}