codeunit 50302 "POS Event and Subscriber"
{
    Access = Public;
    trigger OnRun()
    begin

    end;

    procedure POSAction(documentno: text; lineno: Integer; posaction: text; parameter1: Text; input: Text; parameter2: Text): Text
    var
        POSProcedure: Codeunit 50303;
        IsResult: Text;
    begin

        case posaction of
            'VOIDL':  //<<<<** Sales Line Delete Function **>>>>
                begin
                    Clear(IsResult);
                    IsResult := POSProcedure.SalesLineDeletion(documentno, lineno);
                    IF IsResult = '' then
                        exit('Success');
                    //Else
                    //  exit(IsResult);
                end;
            'VOIDT':  //<<<<** Complete Sales Order Delete **>>>>
                begin
                    Clear(IsResult);
                    IsResult := POSProcedure.SalesOrderDeletion(documentno);
                    IF IsResult = '' then
                        exit('Success');
                    //Else
                    //  exit(IsResult);
                end;
            'VOIDP':  //<<<<** Payment Line Delete Function **>>>>
                begin
                    Clear(IsResult);
                    IsResult := POSProcedure.PaymentLineDeletion(documentno, lineno);
                    IF IsResult = '' then
                        exit('Success');
                    //Else
                    //  exit(IsResult);
                end;
            'INVDISC':  //<<<<** Complete Sales order Discount Function **>>>>
                begin
                    IsResult := POSProcedure.InvoiceDiscount(documentno, input);
                    IF IsResult = '' then
                        exit('Success')
                    Else
                        exit('Invoice Discount Value not updated.');
                end;
            'LINEDISC':  //<<<<** Sales Line Discount Function **>>>>
                begin
                    IsResult := POSProcedure.LineDiscount(documentno, lineno, input);
                    IF IsResult = '' then
                        exit('Success')
                    Else
                        exit('Line Discount not updated.');
                end;
            'ADJADV':  //Not used this Function
                begin
                    IsResult := POSProcedure.AdjustAdvance(documentno);
                    IF IsResult = '' then
                        exit('Success')
                    Else
                        exit(IsResult);
                end;
            'INVLINE':  //<<<<** Sales Order's Perticuller line Ship and Invoice **>>>>
                begin
                    IsResult := POSProcedure.InvoiceLine(documentno, lineno, parameter1, input);
                    IF IsResult = '' then
                        exit('Success');
                    // Else
                    //   exit(IsResult);
                end;
            'RECEIPT': //<<<<** Purchase Order or Tranfer Order Receive Function **>>>>
                begin
                    IsResult := POSProcedure.ItemReceipt(documentno, lineno, input);
                    IF IsResult = '' then
                        exit('Success')
                    Else
                        exit(IsResult);
                end;
            'DELDET':  //<<<<** Sales Order Transport Method Update Function **>>>>
                begin
                    IsResult := POSProcedure.DeliveryDetails(documentno, input);
                    IF IsResult = '' then
                        exit('Success')
                    Else
                        exit(IsResult);
                end;
            'CUPSL':  //<<<<** Sales Line Unit Price Change Function **>>>>
                begin
                    IsResult := POSProcedure.ChangeUnitPrice(documentno, lineno, input);
                    IF IsResult = '' then
                        exit('Success')
                    Else
                        exit(IsResult);

                end;
            'EXITEM':  //<<<<** Exchange Item with new GL Line Created on Sales Order Function **>>>>
                begin
                    IsResult := POSProcedure.ExchangeItem(documentno, input, parameter1, parameter2);
                    IF IsResult = '' then
                        exit('Success')
                    Else
                        exit(IsResult);

                end;
            'STRCK':  //<<<<** Item Tracking for Sales Line,Transfer Line and GRN Function **>>>>
                begin
                    IsResult := POSProcedure.SerialItemTracking(documentno, lineno, input);
                    IF IsResult = '' then
                        exit('Success')
                    Else
                        exit(IsResult);

                end;
            'SDTRCK':  //<<<<** Item Tracking for Sales Line,Transfer Line and GRN Function **>>>>
                begin
                    IsResult := POSProcedure.SerialTrackingDeallocation(documentno, lineno, input);
                    IF IsResult = '' then
                        exit('Success')
                    Else
                        exit(IsResult);

                end;
            'ORDWH':  //<<<<** Order Confirm for Warehouse **>>>>
                begin
                    IsResult := POSProcedure.OrderConfirmationforWH(documentno);
                    IF IsResult = '' then
                        exit('Success')
                    Else
                        exit(IsResult);

                end;
            'ORDDEL':  //<<<<** Order Confirm for Delivery **>>>>
                begin
                    IsResult := POSProcedure.OrderConfirmationforDelivery(documentno);
                    IF IsResult = '' then
                        exit('Success');
                    //Else
                    //  exit(IsResult);

                end;
            'INVCOM':  //<<<<** compelete Invoice Auto Qty to ship Update **>>>>
                begin
                    IsResult := POSProcedure.InvoiceComplete(documentno);
                    IF IsResult = '' then
                        exit('Success');
                    // Else
                    //   exit(IsResult);

                end;
            'ADDCOM':  //<<<<** Add Comment on Live level new Line Insert With type comment**>>>>
                begin
                    IsResult := POSProcedure.AddComment(documentno, parameter1);
                    IF IsResult = '' then
                        exit('Success');
                    // Else
                    //   exit(IsResult);

                end;
            'CANNEW':  //<<<<** Add Comment on Live level new Line Insert **>>>>
                begin
                    IsResult := POSProcedure.CancelNewSO(documentno);
                    IF IsResult = '' then
                        exit('Success')
                    Else
                        exit(IsResult);

                end;
            'SOPRINT':  //<<<<** Add Comment on Live level new Line Insert **>>>>
                begin
                    IsResult := POSProcedure.SOPrint(documentno);
                    IF IsResult = '' then
                        exit('Success')
                    Else
                        exit(IsResult);

                end;
        end;

    end;



    procedure POSEvent(documentno: text; linno: Integer; posaction: text; parameter: Text; input: Text): Text
    var
        Recref: RecordRef;
        recCust: Record 18;
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        Instr: InStream;
        FileManagement_lCdu: Codeunit "File Management";
        NewStr: text;
        POSProcedure: Codeunit 50303;
        IsResult: Text;
    begin

        // Recref.GetTable(recCust);
        // TempBlob.CreateOutStream(OutStr);
        // Report.SaveAs(Report::"Customer - List", '', ReportFormat::Pdf, OutStr, Recref);
        // TempBlob.CreateInStream(InStr);
        // FileManagement_lCdu.BLOBExport(TempBlob, STRSUBSTNO('Proforma_%1.Pdf', recCust."No."), TRUE);
        // // exit('PC Request received for document No' + documentno);
        // Evaluate(NewStr, FORMAT(OutStr));

        // exit(NewStr);
        recCust.get(10000);
        //CustReport.Run();
        Report.Run(101, false, false, recCust);
    end;

    //Add Warranty
    procedure AddWarranty(documentno: Code[20]; lineno: Integer; brand: Code[20]; month: text): Text
    var
        SalesLine: Record "Sales Line";
        Saleslineinit: record "Sales Line";
        SR: Record "Sales & Receivables Setup";
        WarrMaster: Record "Warranty Master new";
        SH: Record "Sales Header";
        SL: Record "Sales Line";
        MonthInt: Integer;
    begin
        IF month <> '' then
            Evaluate(MonthInt, month);

        SR.Get();
        sr.TestField("Warranty G/L Code");

        SH.Reset();
        SH.SetRange("No.", documentno);
        IF SH.FindFirst() then;

        SalesLine.Reset();
        SalesLine.SetCurrentKey("Document No.", "Line No.");
        SalesLine.SetRange("Document No.", documentno);
        SalesLine.SetRange("Line No.", lineno);
        IF SalesLine.FindFirst() then begin
            Saleslineinit.Init();
            Saleslineinit."Document Type" := SalesLine."Document Type";
            Saleslineinit."Document No." := SalesLine."Document No.";

            SL.Reset();
            SL.SetRange("Document No.", documentno);
            IF SL.FindLast() then
                Saleslineinit."Line No." := SL."Line No." + 10000;

            Saleslineinit.Insert();
            Saleslineinit.Type := Saleslineinit.Type::Item;
            Saleslineinit.Validate("No.", SR."Warranty G/L Code");
            Saleslineinit.Validate("Location Code", SalesLine."Location Code");
            Saleslineinit.Validate("Unit of Measure Code", 'PCS');
            Saleslineinit."Warranty Parent Line No." := SalesLine."Line No.";
            Saleslineinit."Store No." := SalesLine."Store No.";
            Saleslineinit.Validate("Salesperson Code", SalesLine."Salesperson Code");
            WarrMaster.Reset();
            WarrMaster.SetCurrentKey(Brand, Months, "From Date", "TO Date", "From Value", "To Value");
            WarrMaster.SetRange(Brand, brand);
            WarrMaster.SetRange(Months, MonthInt);
            WarrMaster.SetFilter("From Date", '<=%1', SH."Posting Date");
            WarrMaster.SetFilter("To Date", '>=%1', SH."Posting Date");
            WarrMaster.SetFilter("From Value", '<=%1', SalesLine."Unit Price Incl. of Tax");
            WarrMaster.SetFilter("TO Value", '>=%1', SalesLine."Unit Price Incl. of Tax");
            IF WarrMaster.FindFirst() then begin
                Saleslineinit.Validate("Unit Price Incl. of Tax", WarrMaster."EW Prices");
                Saleslineinit."Price Inclusive of Tax" := true;
                Saleslineinit.Validate(Quantity, 1);
                Saleslineinit.Description := WarrMaster.Description;
            end else
                Error('Warranty not found');
            Saleslineinit.Modify();
        End else begin
            SalesLine.Reset();
            SalesLine.SetCurrentKey("Document No.", "Line No.");
            SalesLine.SetRange("Document No.", documentno);
            SalesLine.SetRange("Line No.", 0);
            IF SalesLine.FindFirst() then begin
                Saleslineinit.Init();
                Saleslineinit."Document Type" := SalesLine."Document Type";
                Saleslineinit."Document No." := SalesLine."Document No.";

                SL.Reset();
                SL.SetRange("Document No.", documentno);
                IF SL.FindLast() then
                    Saleslineinit."Line No." := SL."Line No." + 10000;

                Saleslineinit.Insert();
                Saleslineinit.Type := Saleslineinit.Type::Item;
                Saleslineinit.Validate("No.", SR."Warranty G/L Code");
                Saleslineinit.Validate("Location Code", SalesLine."Location Code");
                Saleslineinit.Validate("Unit of Measure Code", 'PCS');
                //Saleslineinit."Warranty Parent Line No." := SalesLine."Line No.";
                Saleslineinit."Store No." := SalesLine."Store No.";
                Saleslineinit.Validate("Salesperson Code", SalesLine."Salesperson Code");
                WarrMaster.Reset();
                WarrMaster.SetCurrentKey(Brand, Months, "From Date", "TO Date", "From Value", "To Value");
                WarrMaster.SetRange(Brand, brand);
                WarrMaster.SetRange(Months, MonthInt);
                // WarrMaster.SetFilter("From Date", '<=%1', SH."Posting Date");
                // WarrMaster.SetFilter("To Date", '>=%1', SH."Posting Date");
                // WarrMaster.SetFilter("From Value", '<=%1', SalesLine."Unit Price Incl. of Tax");
                // WarrMaster.SetFilter("TO Value", '>=%1', SalesLine."Unit Price Incl. of Tax");
                IF WarrMaster.FindFirst() then begin
                    Saleslineinit.Validate("Unit Price Incl. of Tax", 1);
                    Saleslineinit."Price Inclusive of Tax" := true;
                    Saleslineinit.Validate(Quantity, 1);
                    Saleslineinit.Description := WarrMaster.Description;
                    Saleslineinit.modify();
                end;
            end;
        end;
    end;

    /// <summary>
    /// Post Shipment TO Line
    /// </summary>
    procedure ShipTransferLine(documentno: Code[20]; lineno: Integer; inputdata: Text): text
    var
        TransferHeaderShip: record "Transfer Header";
        TransferlineShip: Record "Transfer Line";
        Transpostship: Codeunit "TransferOrder-Post Shipment";
        Transferrelease: codeunit "Release Transfer Document";
    begin
        TransferHeaderShip.Reset();
        TransferHeaderShip.SetCurrentKey("No.");
        TransferHeaderShip.SetRange("No.", DocumentNo);
        IF TransferHeaderShip.FindFirst() then begin
            Transpostship.Run(TransferHeaderShip);
            Transferrelease.Run(TransferHeaderShip);
        end;
    end;



    /// <summary>
    /// Update Tender Status Update to released as Submited
    /// </summary>
    procedure TenderSubmit(entryno: code[20]): Text
    var
        TenderHdr: Record "Tender Declartion Header";
        Vdate: date;
    begin
        //exit('Sucess');
        TenderHdr.Reset();
        TenderHdr.SetCurrentKey("No.");
        TenderHdr.SetRange("No.", entryno);
        IF TenderHdr.FindFirst() then begin
            TenderHdr.Status := TenderHdr.Status::Released;
            TenderHdr.Modify();
        end;
    end;


    /// <summary>
    /// Customer Advance Payment Without Sales Order
    /// </summary>
    procedure CustomerAdvancePayment(customerno: Code[20]; documentno: Code[20]): Text
    var
        GenJourLine: Record 81;
        GenJourLineInit: record 81;
        NoSeriesMgt: Codeunit 396;
        BankAcc: Record 270;
        PaymentLine: Record 50301;
        PaymentMethod: record "Payment Method";
        SR: record "Sales & Receivables Setup";
        RecLocation: Record Location;
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        PaymentFilter: record "Payment Lines";
        GenBatch: Record 232;
    begin

        PaymentFilter.Reset();
        PaymentFilter.SetCurrentKey("Document No.");
        PaymentFilter.SetRange("Document No.", documentno);
        If PaymentFilter.FindFirst() then;

        IF RecLocation.Get(PaymentFilter."Store No.") then begin
            RecLocation.TestField("Payment Journal Template Name");
            RecLocation.TestField("Payment Journal Batch Name");
        end;

        IF GenBatch.Get(RecLocation."Payment Journal Template Name", RecLocation."Payment Journal Batch Name") then;

        PaymentLine.Reset();
        PaymentLine.SetCurrentKey(Posted, "Document No.");
        PaymentLine.SetRange(Posted, false);
        PaymentLine.SetRange("Document No.", documentno);
        if PaymentLine.FindSet() then begin
            repeat
                GenJourLine.Reset();
                GenJourLine.SetRange("Journal Template Name", RecLocation."Payment Journal Template Name");
                GenJourLine.SetRange("Journal Batch Name", RecLocation."Payment Journal Batch Name");
                GenJourLineInit.Init();
                GenJourLineInit."Document No." := documentno;//NoSeriesMgt.GetNextNo(GenBatch."No. Series", today, true);
                GenJourLineInit.validate("Posting Date", Today);
                IF GenJourLine.FindLast() then
                    GenJourLineInit."Line No." := GenJourLine."Line No." + 10000
                else
                    GenJourLineInit."Line No." := 10000;

                GenJourLineInit.validate("Journal Template Name", RecLocation."Payment Journal Template Name");
                GenJourLineInit.validate("Journal Batch Name", RecLocation."Payment Journal Batch Name");
                GenJourLineInit."Document Type" := GenJourLineInit."Document Type"::Payment;
                // GenJourLineInit.Insert();

                //*******Condition Add With Payment Method code*********
                IF PaymentMethod.Get(PaymentLine."Payment Method Code") then begin
                    IF PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::"G/L Account" then
                        GenJourLineInit."Account Type" := GenJourLineInit."Account Type"::"G/L Account"
                    else
                        IF PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::"Bank Account" then
                            GenJourLineInit."Account Type" := GenJourLineInit."Account Type"::"Bank Account";
                    GenJourLineInit.validate("Account No.", PaymentMethod."Bal. Account No.");
                end;

                GenJourLineInit."Bal. Account Type" := GenJourLine."Bal. Account Type"::Customer;
                GenJourLineInit.Validate("Bal. Account No.", customerno);
                GenJourLineInit."External Document No." := documentno;

                GenJourLineInit."GST Group Code" := 'Goods';
                GenJourLineInit.validate(Amount, PaymentLine.Amount);
                GenJourLineInit.Validate("Shortcut Dimension 1 Code", RecLocation."Global Dimension 1 Code");
                GenJourLineInit.Validate("Shortcut Dimension 2 Code", RecLocation."Global Dimension 2 Code");
                GenJourLineInit.Comment := 'Auto Post';
                GenJourLineInit.Validate("Posting No. Series", GenBatch."Posting No. Series");
                GenJourLineInit.Insert();
            Until PaymentLine.Next() = 0;
        end else
            Error('Payment line not found.');
        GenJnlPostBatch.Run(GenJourLineInit);
        PaymentLine.Reset();
        PaymentLine.SetCurrentKey("Document No.");
        PaymentLine.SetRange("Document No.", documentno);
        if PaymentLine.FindSet() then
            repeat
                PaymentLine.Posted := True;
                PaymentLine.Modify();
            Until PaymentLine.Next() = 0;
        exit('Success');
    end;



    /// <summary>
    /// Bank Drop Submit Function
    /// </summary>
    procedure Bankdropsubmit(entryno: Code[20]): Text
    var
        BanKdrop: Record "Bank Drop Entry";
        Storedate: Date;
    begin
        //exit('Success');
        //Evaluate(Storedate, Format(sdate));
        BanKdrop.Reset();
        BanKdrop.SetRange("No.", entryno);
        IF BanKdrop.FindFirst() then begin
            BanKdrop.Status := BanKdrop.Status::Released;
            BanKdrop.Modify();
            IF BanKdrop.Status = BanKdrop.Status::Open then
                exit('Failed');
        end;

    end;




    /// <summary>
    /// Request Transfer Header Status Update Function
    /// </summary>
    procedure RequestTransferStatusUpdate(no: code[20]): text
    var
        RequestTranHdr: Record "Request Transfer Header";
    begin
        RequestTranHdr.Reset();
        RequestTranHdr.SetRange("No.", no);
        IF RequestTranHdr.FindFirst() then begin
            RequestTranHdr.Status := RequestTranHdr.Status::"Pending for Approval";
            RequestTranHdr.Modify();
            Exit('Success');
        end;
        IF RequestTranHdr.Status <> RequestTranHdr.Status::"Pending for Approval" then
            exit('Failed');
    end;

    /// <summary>
    /// Tranfer Order Ship Function
    /// </summary>
    procedure TransferOrderShipment(no: code[20]): Text
    var
        TranHdr: Record "Transfer Header";
        TransShip: Codeunit "TransferOrder-Post Shipment";
    begin
        TranHdr.Reset();
        TranHdr.SetRange("No.", no);
        IF TranHdr.FindFirst() then begin
            IF TranHdr.Status = TranHdr.Status::Open then begin
                TranHdr.Status := TranHdr.Status::Released;
                TranHdr.Modify(true);
            end;
            IF not TransShip.Run(TranHdr) then
                exit('Failed');

        end;
    end;

    /// <summary>
    /// Update Ship to Code on Sales Order
    /// </summary>
    procedure UpdateShiptoCodeOnSalesHeader(documentno: Code[20]; shiptocode: code[10]): Text
    var
        SalesHeader: record 36;
        ShiptoAdd: record 222;
    begin
        SalesHeader.Reset();
        SalesHeader.SetCurrentKey("No.");
        SalesHeader.SetRange("No.", DocumentNo);
        IF SalesHeader.FindFirst() then begin
            IF SalesHeader.Status = SalesHeader.Status::Released then begin
                SalesHeader.Status := SalesHeader.Status::Open;
                SalesHeader.Modify();
            end;

            ShiptoAdd.Reset();
            ShiptoAdd.SetRange(Code, shiptocode);
            IF not ShiptoAdd.FindFirst() then
                exit('Failed');

            SalesHeader.Validate("Ship-to Code", shiptocode);
            SalesHeader.Modify(true);
            IF SalesHeader."Ship-to Code" <> shiptocode then
                exit('Failed');
        end;
    end;




    // end;

    // procedure POSActionEx(DocumentNo: Text; LineNo: integer; POSAction: Text; Parameter: Text; Input: Text): Text
    // var
    //     POSProcedure: Codeunit 50303;
    // begin
    //     case POSAction of
    //         'VOIDL':
    //             exit('Request received for document No' + DocumentNo);
    //         //POSProcedure.SalesLineDeletion(DocumentNo, LineNo);
    //         'VOIDT':
    //             POSProcedure.SalesOrderDeletion(DocumentNo);
    //         'VOIDP':
    //             POSProcedure.PaymentLineDeletion(DocumentNo, LineNo);
    //         'INVDISC':
    //             POSProcedure.InvoiceDiscount(DocumentNo, Input);
    //         'LINEDISC':
    //             POSProcedure.LineDiscount(DocumentNo, LineNo, Input);
    //         'SHIPLINE':
    //             POSProcedure.ShipLine(DocumentNo, LineNo, Input);
    //         'INVLINE':
    //             POSProcedure.InvoiceLine(DocumentNo, LineNo, Input);
    //         'RECEIPT':
    //             POSProcedure.ItemReceipt(DocumentNo, LineNo, Input);
    //         'DELDET':
    //             POSProcedure.DeliveryDetails(DocumentNo, Input);
    //     end;
    //     exit('Request received for document No' + DocumentNo);
    // end;

    // procedure Ping(): Text
    // begin
    //     exit('Pong');
    // end;

    // procedure Addition(number1: Integer; number2: Integer): Integer
    // begin
    //     exit(number1 + number2);
    // end;


    // procedure Capitalize(input: Text): Text
    // begin
    //     exit(input.ToUpper);
    // end;

    //<<<<<******************************** Local function created depending on original function*************
    procedure GetGSTAmountTotal(
     SalesHeader: Record 36;
     var GSTAmount: Decimal)
    var
        SalesLine: Record 37;
    begin
        Clear(GSTAmount);
        SalesLine.SetRange("Document no.", SalesHeader."No.");
        if SalesLine.FindSet() then
            repeat
                GSTAmount += GetGSTAmount11(SalesLine.RecordId());
            until SalesLine.Next() = 0;
    end;

    local procedure GetGSTAmount11(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then begin
            TaxTransactionValue.CalcSums(Amount);
            TaxTransactionValue.CalcSums(Percent);

        end;
        exit(TaxTransactionValue.Amount);
    end;

    procedure GetTCSAmountTotal(
           SalesHeader: Record 36;
           var TCSAmount: Decimal)
    var
        SalesLine: Record 37;
        TCSManagement: Codeunit "TCS Management";
        i: Integer;
        RecordIDList: List of [RecordID];
    begin
        Clear(TCSAmount);
        // Clear(TCSPercent);

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document no.", SalesHeader."No.");
        if SalesLine.FindSet() then
            repeat
                RecordIDList.Add(SalesLine.RecordId());
            until SalesLine.Next() = 0;

        for i := 1 to RecordIDList.Count() do begin
            TCSAmount += GetTCSAmount(RecordIDList.Get(i));
        end;

        TCSAmount := TCSManagement.RoundTCSAmount(TCSAmount);
    end;

    local procedure GetTCSAmount(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        TCSSetup: Record "TCS Setup";
    begin
        if not TCSSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetRange("Tax Type", TCSSetup."Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            TaxTransactionValue.CalcSums(Amount);

        exit(TaxTransactionValue.Amount);
    end;

    //Salesperson Update
    //
    procedure UpdateSalesPerson(DocumentNo: Code[20]; LineNo: Integer; SPCode: Code[20]): Text
    var

        RecSalesLine: Record 37;


    begin
        RecSalesLine.Reset();
        RecSalesLine.SetCurrentKey("Document No.", "Line No.");
        RecSalesLine.SetRange("Document No.", DocumentNo);
        RecSalesLine.SetRange("Line No.", LineNo);
        IF RecSalesLine.FindFirst() then begin
            RecSalesLine."Salesperson Code" := SPCode;
            RecSalesLine.Modify();
            exit('Success')
        end
        Else
            exit('Document Line not found');

    end;







    procedure GetSalesorderStatisticsAmount(
            SalesHeader: Record 36;
            var TotalInclTaxAmount: Decimal)
    var
        SalesLine: Record 37;
        RecordIDList: List of [RecordID];
        GSTAmount: Decimal;
        TCSAmount: Decimal;
    begin
        Clear(TotalInclTaxAmount);

        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindSet() then
            repeat
                RecordIDList.Add(SalesLine.RecordId());
                TotalInclTaxAmount += SalesLine.Amount;
            until SalesLine.Next() = 0;


        TotalInclTaxAmount := TotalInclTaxAmount + GSTAmount + TCSAmount;
    end;




    //>>>>>>******************************** Local function created depending on original function*************

    var
        //GenericApiCalls: Codeunit GenericApiCalls;

        Recref: RecordRef;
        recCust: Record 18;
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        Instr: InStream;
        CustReport: Report "Customer - List";




}