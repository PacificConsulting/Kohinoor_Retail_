codeunit 50301 "Event and Subscribers"
{
    trigger OnRun()
    begin

    end;

    //<<<<<<<START********************************CU-370*****************************************
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Bank Acc. Reconciliation Post", 'OnBeforeFinalizePost', '', false, false)]
    local procedure OnBeforeFinalizePost(var BankAccReconciliation: Record "Bank Acc. Reconciliation")
    var
        BankAccLedEntry: Record "Bank Account Ledger Entry";
        GenJnlInit: Record 81;
        GenJnl: Record 81;
        GL: Record 98;
        Amount: Decimal;
        BanKposting: Record "Bank Account Posting Group";
        Location: Record Location;
        PayMethod: Record "Payment Method";
        GenBatch: Record 232;
        BankAccRecLine: Record "Bank Acc. Reconciliation Line";
        BankAccRecLineTmp: Record "Bank Acc. Reconciliation Line" temporary;
    begin
        BankAccRecLineTmp.DeleteAll();
        BankAccRecLine.Reset();
        BankAccRecLine.SetRange("Bank Account No.", BankAccReconciliation."Bank Account No.");
        BankAccRecLine.SetRange("Statement No.", BankAccReconciliation."Statement No.");
        IF BankAccRecLine.FindSet() then
            repeat
                BankAccRecLineTmp.Init();
                BankAccRecLineTmp.TransferFields(BankAccRecLine);
                BankAccRecLineTmp.Insert();
            until BankAccRecLine.Next() = 0;
        IF GenBatch.Get(BankAccReconciliation."Journal Template Name", BankAccReconciliation."Journal Batch Name") then;
        IF PayMethod.Get(BankAccReconciliation."Bank Account No.") then begin
            if (PayMethod."Payment Type" in [PayMethod."Payment Type"::Card, PayMethod."Payment Type"::UPI, PayMethod."Payment Type"::Wallet]) then begin
                Location.Reset();
                Location.SetCurrentKey(Store);
                Location.SetRange(Store, true);
                IF Location.Findset() then
                    repeat
                        Clear(Amount);
                        GL.Get();
                        BankAccReconciliation.TestField("Journal Template Name");
                        BankAccReconciliation.TestField("Journal Batch Name");
                        BankAccReconciliation.TestField("Reco. Account No.");
                        BankAccReconciliation.TestField("Reco. Account Type");
                        BankAccLedEntry.Reset();
                        BankAccLedEntry.SetCurrentKey("Bank Account No.", "Statement No.", "Global Dimension 2 Code");
                        BankAccLedEntry.SetRange("Bank Account No.", BankAccReconciliation."Bank Account No.");
                        BankAccLedEntry.SetRange("Statement No.", BankAccReconciliation."Statement No.");
                        BankAccLedEntry.SetRange("Global Dimension 2 Code", Location.Code);
                        IF BankAccLedEntry.FindSet() then
                            repeat
                                Amount += BankAccLedEntry.Amount;
                            until BankAccLedEntry.Next() = 0;

                        //******** Postive Amount with bank Account Debit*********
                        IF Amount <> 0 then begin
                            GenJnl.Reset();
                            GenJnl.SetRange("Journal Template Name", BankAccReconciliation."Journal Template Name");
                            GenJnl.SetRange("Journal Batch Name", BankAccReconciliation."Journal Batch Name");
                            GenJnlInit.Init();
                            GenJnlInit."Journal Template Name" := BankAccReconciliation."Journal Template Name";
                            GenJnlInit.validate("Journal Batch Name", BankAccReconciliation."Journal Batch Name");
                            GenJnlInit.Validate("Posting Date", Today);

                            IF GenJnl.FindLast() then
                                GenJnlInit."Line No." := GenJnl."Line No." + 10000
                            else
                                GenJnlInit."Line No." := 10000;

                            GenJnlInit."Document No." := 'TENDREC' + format(BankAccLedEntry."Statement No.");
                            GenJnlInit."Document Type" := GenJnlInit."Document Type"::Payment;
                            IF BankAccReconciliation."Reco. Account Type" = BankAccReconciliation."Reco. Account Type"::"Bank Account" then begin
                                GenJnlInit.validate("Account Type", GenJnlInit."Account Type"::"Bank Account");
                                GenJnlInit.Validate("Account No.", BankAccReconciliation."Reco. Account No.");
                            end else begin
                                IF BankAccReconciliation."Reco. Account Type" = BankAccReconciliation."Reco. Account Type"::"G/L Account" then begin
                                    GenJnlInit.validate("Account Type", GenJnlInit."Account Type"::"G/L Account");
                                    GenJnlInit.Validate("Account No.", BankAccReconciliation."Reco. Account No.");
                                end;
                            end;
                            GenJnlInit.Validate(Amount, Amount);
                            GenJnlInit.Validate("Shortcut Dimension 1 Code", BankAccLedEntry."Global Dimension 1 Code");
                            GenJnlInit.Validate("Shortcut Dimension 2 Code", BankAccLedEntry."Global Dimension 2 Code");
                            GenJnlInit.Validate("Posting No. Series", GenBatch."Posting No. Series");
                            GenJnlInit.Insert(true);
                            //******** Negative Amount with G/L Account Credit*********
                            IF BanKposting.Get(BankAccReconciliation."Bank Account No.") then;
                            GenJnl.Reset();
                            GenJnl.SetRange("Journal Template Name", BankAccReconciliation."Journal Template Name");
                            GenJnl.SetRange("Journal Batch Name", BankAccReconciliation."Journal Batch Name");
                            GenJnlInit.Init();
                            GenJnlInit."Journal Template Name" := BankAccReconciliation."Journal Template Name";
                            GenJnlInit.validate("Journal Batch Name", BankAccReconciliation."Journal Batch Name");
                            GenJnlInit.Validate("Posting Date", Today);

                            IF GenJnl.FindLast() then
                                GenJnlInit."Line No." := GenJnl."Line No." + 10000
                            else
                                GenJnlInit."Line No." := 10000;

                            GenJnlInit."Document No." := 'TENDERRECO' + format(BankAccLedEntry."Statement No.");
                            GenJnlInit."Document Type" := GenJnlInit."Document Type"::Payment;
                            GenJnlInit.validate("Account Type", GenJnlInit."Account Type"::"G/L Account");
                            GenJnlInit.Validate("Account No.", BanKposting."G/L Account No.");
                            GenJnlInit.Validate(Amount, -Amount);
                            GenJnlInit.Validate("Shortcut Dimension 1 Code", BankAccLedEntry."Global Dimension 1 Code");
                            GenJnlInit.Validate("Shortcut Dimension 2 Code", BankAccLedEntry."Global Dimension 2 Code");
                            GenJnlInit.Validate("Posting No. Series", GenBatch."Posting No. Series");
                            //GenJnlInit."Approval Code":=BankAccRecLineTmp."External Document No.";
                            GenJnlInit.Insert(true);
                        end;
                    until Location.Next() = 0;
            end;
        end;
        //*******************************For Finance*************************************
        IF PayMethod.Get(BankAccReconciliation."Bank Account No.") then begin
            GL.Get();
            BankAccReconciliation.TestField("Journal Template Name");
            BankAccReconciliation.TestField("Journal Batch Name");
            BankAccReconciliation.TestField("Reco. Account No.");
            BankAccReconciliation.TestField("Reco. Account Type");
            if (PayMethod."Payment Type" in [PayMethod."Payment Type"::Finance]) then begin
                BankAccLedEntry.Reset();
                BankAccLedEntry.SetCurrentKey("Bank Account No.", "Statement No.", "Global Dimension 2 Code");
                BankAccLedEntry.SetRange("Bank Account No.", BankAccReconciliation."Bank Account No.");
                BankAccLedEntry.SetRange("Statement No.", BankAccReconciliation."Statement No.");
                IF BankAccLedEntry.FindSet() then
                    repeat
                        BankAccRecLineTmp.Reset();
                        BankAccRecLineTmp.SetCurrentKey("Bank Account No.", "Statement No.", "Statement Line No.", "Approval Code");
                        BankAccRecLineTmp.SetRange("Bank Account No.", BankAccLedEntry."Bank Account No.");
                        BankAccRecLineTmp.SetRange("Statement No.", BankAccLedEntry."Statement No.");
                        BankAccRecLineTmp.SetRange("Statement Line No.", BankAccLedEntry."Statement Line No.");
                        BankAccRecLineTmp.SetRange("Approval Code", BankAccLedEntry."Approval Code");
                        IF BankAccRecLineTmp.FindFirst() then begin
                            GenJnl.Reset();
                            GenJnl.SetRange("Journal Template Name", BankAccReconciliation."Journal Template Name");
                            GenJnl.SetRange("Journal Batch Name", BankAccReconciliation."Journal Batch Name");
                            GenJnlInit.Init();
                            GenJnlInit."Journal Template Name" := BankAccReconciliation."Journal Template Name";
                            GenJnlInit.validate("Journal Batch Name", BankAccReconciliation."Journal Batch Name");

                            IF GenJnl.FindLast() then
                                GenJnlInit."Line No." := GenJnl."Line No." + 10000
                            else
                                GenJnlInit."Line No." := 10000;

                            GenJnlInit."Document No." := 'TENDERREC' + format(BankAccRecLineTmp."Statement No.") + Format(BankAccRecLineTmp."Value Date");
                            GenJnlInit."Document Type" := GenJnlInit."Document Type"::Payment;
                            GenJnlInit.Validate("Posting Date", BankAccRecLineTmp."Value Date");
                            IF BankAccReconciliation."Reco. Account Type" = BankAccReconciliation."Reco. Account Type"::"Bank Account" then begin
                                GenJnlInit.validate("Account Type", GenJnlInit."Account Type"::"Bank Account");
                                GenJnlInit.Validate("Account No.", BankAccReconciliation."Reco. Account No.");
                            end else begin
                                IF BankAccReconciliation."Reco. Account Type" = BankAccReconciliation."Reco. Account Type"::"G/L Account" then begin
                                    GenJnlInit.validate("Account Type", GenJnlInit."Account Type"::"G/L Account");
                                    GenJnlInit.Validate("Account No.", BankAccReconciliation."Reco. Account No.");
                                end;
                            end;
                            GenJnlInit.Validate(Amount, BankAccRecLineTmp."Statement Amount");
                            GenJnlInit.Validate("Shortcut Dimension 1 Code", BankAccLedEntry."Global Dimension 1 Code");
                            GenJnlInit.Validate("Shortcut Dimension 2 Code", BankAccLedEntry."Global Dimension 2 Code");
                            GenJnlInit.Validate("Posting No. Series", GenBatch."Posting No. Series");
                            GenJnlInit."External Document No." := BankAccRecLineTmp."External Document No.";
                            GenJnlInit."Approval Code" := BankAccRecLineTmp."External Document No.";
                            GenJnlInit.Insert(true);

                            //******** Negative Amount with G/L Account Credit*********
                            IF BanKposting.Get(BankAccReconciliation."Bank Account No.") then;
                            GenJnl.Reset();
                            GenJnl.SetRange("Journal Template Name", BankAccReconciliation."Journal Template Name");
                            GenJnl.SetRange("Journal Batch Name", BankAccReconciliation."Journal Batch Name");
                            GenJnlInit.Init();
                            GenJnlInit."Journal Template Name" := BankAccReconciliation."Journal Template Name";
                            GenJnlInit.validate("Journal Batch Name", BankAccReconciliation."Journal Batch Name");
                            IF GenJnl.FindLast() then
                                GenJnlInit."Line No." := GenJnl."Line No." + 10000
                            else
                                GenJnlInit."Line No." := 10000;

                            GenJnlInit.Validate("Posting Date", BankAccRecLineTmp."Value Date");
                            GenJnlInit."Document No." := 'TENDERREC' + format(BankAccRecLineTmp."Statement No.") + Format(BankAccRecLineTmp."Value Date");
                            GenJnlInit."Document Type" := GenJnlInit."Document Type"::Payment;
                            GenJnlInit.validate("Account Type", GenJnlInit."Account Type"::"G/L Account");
                            GenJnlInit.Validate("Account No.", BanKposting."G/L Account No.");
                            GenJnlInit.Validate(Amount, (BankAccRecLineTmp."Statement Amount" * -1));
                            GenJnlInit.Validate("Shortcut Dimension 1 Code", BankAccLedEntry."Global Dimension 1 Code");
                            GenJnlInit.Validate("Shortcut Dimension 2 Code", BankAccLedEntry."Global Dimension 2 Code");
                            GenJnlInit.Validate("Posting No. Series", GenBatch."Posting No. Series");
                            GenJnlInit."External Document No." := BankAccRecLineTmp."External Document No.";
                            GenJnlInit."Approval Code" := BankAccRecLineTmp."External Document No.";
                            GenJnlInit.Insert(true);
                        end;
                    until BankAccLedEntry.Next() = 0;
            end;
        end;
    end;
    //<<<<<<<END********************************CU-370*****************************************

    //<<<<<<<START********************************CU-12*****************************************
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitBankAccLedgEntry', '', false, false)]
    local procedure OnAfterInitBankAccLedgEntry(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        IF GenJournalLine."Approval Code" <> '' then
            BankAccountLedgerEntry."Approval Code" := GenJournalLine."Approval Code";
        if GenJournalLine."Card No." <> 0 then
            BankAccountLedgerEntry."Card No." := GenJournalLine."Card No.";
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
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnRunOnBeforeFinalizePosting', '', false, false)]
    local procedure OnRunOnBeforeFinalizePosting(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        CommitIsSuppressed: Boolean;
        GenJnlLineExtDocNo: Code[35]; var
                                          EverythingInvoiced: Boolean;
                                          GenJnlLineDocNo: Code[20];
                                          SrcCode: Code[10])
    var
        CalcStatistics: Codeunit "Calculate Statistics";
        TotalInvoiceAmt: Decimal;
        TotalPaymentAmt: Decimal;
        PostedPayemntLine: Record "Posted Payment Lines";
        SIH: Record 112;
        GLSetup: Record "General Ledger Setup";
        PaymentLine: Record "Payment Lines";
    begin
        //*****************New Code for Check Payment Should not be more then Invoice Amt ******

        CalcStatistics.GetPostedsalesInvStatisticsAmount(SalesInvoiceHeader, TotalInvoiceAmt);
        PaymentLine.Reset();
        PaymentLine.SetRange("Document No.", SalesHeader."No.");
        PaymentLine.SetRange(Posted, true);
        //PaymentLine.SetFilter("Payment Method Code", '<>%1', 'CHEQUE');
        IF PaymentLine.FindSet() then
            repeat
                IF PaymentLine."Payment Method Code" <> 'CHEQUE' then
                    TotalPaymentAmt += PaymentLine.Amount;
            until PaymentLine.Next() = 0;
        IF (SalesHeader."Allow for Credit Bill" = false) AND (SalesHeader."Allow for Cheque Clearance" = false) then begin
            IF TotalInvoiceAmt > TotalPaymentAmt then
                Error('You can not generate Invoice when Invoice Amt. %1 more than payment amt. %2', TotalInvoiceAmt, TotalPaymentAmt);
        end;
        // IF EverythingInvoiced = true then
        //   DeletePayemntLines(SalesHeader, PaymentLine);

        PostedPayemntLine.Reset();
        PostedPayemntLine.SetRange("Document No.", SalesInvoiceHeader."No.");
        IF not PostedPayemntLine.Find() then begin
            PaymentLine.Reset();
            PaymentLine.SetRange("Document No.", SalesHeader."No.");
            if PaymentLine.FindSet() then
                repeat
                    PostedPayemntLine.InitFromPaymentLine(PostedPayemntLine, PaymentLine, SalesInvoiceHeader);
                until PaymentLine.Next() = 0;
            // DeletePayemntLines(SalesHeader, PaymentLine); //Code commented ask by sourav for issue of partial order.

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnDeleteAfterPostingOnAfterSalesLineDeleteAll', '', false, false)]
    local procedure OnDeleteAfterPostingOnAfterSalesLineDeleteAll(SalesHeader: Record "Sales Header"; SalesInvoiceHeader: Record "Sales Invoice Header"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; CommitIsSuppressed: Boolean; EverythingInvoiced: Boolean)
    var
        PaymentLine: Record "Payment Lines";
    begin
        /*
        PaymentLine.Reset();
        PaymentLine.SetRange("Document No.", SalesHeader."No.");
        IF PaymentLine.FindFirst() then
            PaymentLine.DeleteAll();
            */
    end;
    /*
    local procedure OnAfterSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; ItemLedgShptEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean; CommitIsSuppressed: Boolean; var SalesHeader: Record "Sales Header"; var TempItemChargeAssgntSales: Record "Item Charge Assignment (Sales)" temporary; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; PreviewMode: Boolean)
    var
        PostedPayemntLine: Record "Posted Payment Lines";
        PaymentLine: Record "Payment Lines";
        CalcStatistics: Codeunit "Calculate Statistics";
        TotalInvoiceAmt: Decimal;
        TotalPaymentAmt: Decimal;
        SL: Record "Sales Line";

    begin
        /*
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
            // DeletePayemntLines(SalesHeader, PaymentLine); //Code commented ask by sourav for issue of partial order.
            */

    //end;

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
        GL: Record "General Ledger Setup";
    begin
        //<<***********Auto Postive Item Journal Line Created and Post For Sales Order*************
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            GL.Get();
            GL.TestField("Exchange Batch");
            SR.Get();
            SalesLine.reset();
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.SetRange(Type, SalesLine.Type::"G/L Account");
            SalesLine.SetRange("No.", SR."Exchange Item G/L");
            SalesLine.SetFilter("Exchange Item No.", '<>%1', '');
            IF SalesLine.findset() then
                IF SalesLine.Quantity <> SalesLine."Quantity Invoiced" then begin
                    repeat
                        // IF SalesLine."Exchange Item No." <> '' then begin
                        ItemJInit.Init();
                        ItemJInit."Journal Template Name" := 'ITEM';
                        ItemJInit."Journal Batch Name" := GL."Exchange Batch";
                        ItemJ.Reset();
                        ItemJ.SetRange("Journal Template Name", 'ITEM');
                        ItemJ.SetRange("Journal Batch Name", GL."Exchange Batch");
                        IF ItemJ.FindLast() then
                            ItemJInit."Line No." := ItemJ."Line No." + 10000
                        else
                            ItemJInit."Line No." := 10000;

                        ItemJInit."Document No." := SalesHeader."No."; //SalesInvHdrNo;
                        ItemJInit.Validate("Posting Date", SalesHeader."Posting Date");
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
                    until SalesLine.next() = 0;
                end;
        end;
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" then begin
            //SuppressCommit := true;
            GL.Get();
            GL.TestField("Exchange Batch");
            SR.Get();
            SalesLine.reset();
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.SetRange(Type, SalesLine.Type::"G/L Account");
            SalesLine.SetRange("No.", SR."Exchange Item G/L");
            SalesLine.SetFilter("Exchange Item No.", '<>%1', '');
            IF SalesLine.findset() then
                IF SalesLine.Quantity <> SalesLine."Quantity Invoiced" then begin
                    repeat
                        // IF SalesLine."Exchange Item No." <> '' then begin
                        ItemJInit.Init();
                        ItemJInit."Journal Template Name" := 'ITEM';
                        ItemJInit."Journal Batch Name" := GL."Exchange Batch";
                        ItemJ.Reset();
                        ItemJ.SetRange("Journal Template Name", 'ITEM');
                        ItemJ.SetRange("Journal Batch Name", GL."Exchange Batch");
                        IF ItemJ.FindLast() then
                            ItemJInit."Line No." := ItemJ."Line No." + 10000
                        else
                            ItemJInit."Line No." := 10000;

                        ItemJInit."Document No." := SalesHeader."No."; //SalesInvHdrNo;
                        ItemJInit.Validate("Posting Date", SalesHeader."Posting Date");
                        ItemJInit."Entry Type" := ItemJInit."Entry Type"::"Negative Adjmt.";
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
                        ReservEntryInit.validate("Quantity (Base)", ItemJInit.Quantity * -1);
                        ReservEntryInit."Reservation Status" := ReservEntryInit."Reservation Status"::Prospect;
                        ReservEntryInit."Source Type" := DATABASE::"Item Journal Line";
                        ReservEntryInit."Source Subtype" := 3;
                        ReservEntryInit."Source ID" := ItemJInit."Journal Template Name";
                        ReservEntryInit."Source Batch Name" := ItemJInit."Journal Batch Name";
                        ReservEntryInit."Source Ref. No." := ItemJInit."Line No.";
                        ReservEntryInit."Creation Date" := Today;
                        ReservEntryInit."Created By" := UserId;
                        ReservEntryInit."Serial No." := SalesLine."Serial No.";
                        ReservEntryInit."Shipment Date" := Today;
                        ReservEntryInit.Positive := false;
                        ReservEntryInit."Item Tracking" := ReservEntryInit."Item Tracking"::"Serial No.";
                        ReservEntryInit.Insert();
                        ItemJnlPostBatch.SetSuppressCommit(true);//Sourav New line added PCPL/NSW/07
                        ItemJnlPostBatch.Run(ItemJInit);
                    until SalesLine.next() = 0;
                end;
        end;

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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterTransferOrderPostShipment', '', false, false)]
    local procedure OnAfterTransferOrderPostShipment(var TransferHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean; var TransferShipmentHeader: Record "Transfer Shipment Header"; InvtPickPutaway: Boolean)
    var
        TSH: Record "Transfer Shipment Header";
        Instrm: InStream;
        OutStrm: OutStream;
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
        Recref: RecordRef;
        VResult: Text;
        B64: Codeunit "Base64 Convert";
        ReturnData: Text;
    begin
        //*********Report SaveasPDF code********
        /*
        TSH.RESET;
        TSH.SETRANGE("No.", TransferShipmentHeader."No.");
        IF TSH.FINDFIRST THEN;
        Recref.GetTable(TSH);
        TempBlob.CreateOutStream(OutStrm);
        Report.SaveAs(Report::"Sales Order", '', ReportFormat::Pdf, OutStrm, Recref);
        TempBlob.CreateInStream(Instrm);
        VResult := B64.ToBase64(Instrm);
        UploadonAzurBlobStorageTransferreport(TSH."No." + '.PDF', VResult);
        */
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
        SL: Record 37;
    begin
        // SL.Reset();
        // SL.SetRange("Document No.", salesHeaderRec."No.");
        // IF SL."Qty. to Invoice" <> 0 then begin
        RecPaymentLine.Reset();
        RecPaymentLine.SetRange("Document Type", salesHeaderRec."Document Type");
        RecPaymentLine.SetRange("Document No.", salesHeaderRec."No.");
        if RecPaymentLine.FindFirst() then
            RecPaymentLine.DeleteAll();
        //end;
    end;

    procedure UploadonAzurBlobStorageTransferreport(FileName: Text; Base64: Text): Text

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
        AzurBlobSetup.TestField("Azure Transfer Order URL");
        URL := AzurBlobSetup."Azure Transfer Order URL";//'https://prod-05.centralindia.logic.azure.com:443/workflows/c6dd57d4a8814ad0bd3e43bae6ecd6fe/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=dq8NlkzznvjIz9F1aYbWcaxHyGAgqaWBQjkCczmrLeg';
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