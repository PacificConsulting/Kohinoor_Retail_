pageextension 50303 "Sales Invoice Retail" extends "Sales Invoice"
{
    layout
    {
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Bill Of Export No.")
        {
            Visible = false;
        }
        modify("Bill Of Export Date")
        {
            Visible = false;
        }
        modify("Payment Date")
        {
            Visible = false;
        }
        modify("E-Commerce Customer")
        {
            Visible = false;
        }

        modify("E-Comm. Merchant Id")
        {
            Visible = false;
        }
        modify("GST Without Payment of Duty")
        {
            Visible = false;
        }
        modify("Transaction Specification")
        {
            Visible = false;
        }
        modify("Transaction Type")
        {
            Visible = false;
        }
        modify("Transport Method")
        {
            Visible = false;
        }
        modify("Exit Point")
        {
            Visible = false;
        }
        modify("Area")
        {
            Visible = false;
        }

        addafter(SalesLines)
        {
            part(PaymentLine; "Payment Lines Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
                Editable = IsPaymentLineeditable;
            }
        }
        addafter(Status)
        {
            field("Amount To Customer"; Rec."Amount To Customer")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Store No."; Rec."Store No.")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                SL: Record "Sales Line";
                SR: Record "Sales & Receivables Setup";
            begin
                Rec.TestField("Store No.");
                SL.Reset();
                SL.SetRange("Document No.", rec."No.");
                SL.SetRange(Type, SL.Type::Item);
                IF SL.FindSet() then
                    repeat
                        //IF (SL.Type <> SL.Type::" ") or (SL."No." <> SR."Exchange Item G/L") then
                        SL.TestField("Salesperson Code");
                    until SL.Next() = 0;

            end;
        }
        modify(PostAndSend)
        {
            trigger OnBeforeAction()
            var
                SL: Record "Sales Line";
                SR: Record "Sales & Receivables Setup";
            begin
                Rec.TestField("Store No.");
                SL.Reset();
                SL.SetRange("Document No.", rec."No.");
                SL.SetRange(Type, SL.Type::Item);
                IF SL.FindSet() then
                    repeat
                        // IF (SL.Type <> SL.Type::" ") or (SL."No." <> SR."Exchange Item G/L") then
                        SL.TestField("Salesperson Code");
                    until SL.Next() = 0;

            end;
        }
        modify(Statistics)
        {
            Trigger OnAfterAction()
            begin
                clear(TotalGSTAmount1);
                Clear(TotalTCSAmt);
                Clear(TotalAmt);
                GetGSTAmountTotal(Rec, TotalGSTAmount1);
                GetTCSAmountTotal(Rec, TotalTCSAmt);
                GetSalesorderStatisticsAmount(Rec, TotalAmt);
                Rec."Amount To Customer" := TotalAmt + TotalGSTAmount1 + TotalTCSAmt;
                Rec.Modify();
            end;
        }
        addafter(Post)
        {
            action("Allow for Credit Bill.")
            {
                ApplicationArea = All;
                Caption = 'Allow for Credit Bill';
                Image = Allocations;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Userset: Record "User Setup";
                begin
                    If Userset.Get(UserId) then begin
                        IF Userset."Allow for Credit Bill" then begin
                            Rec."Allow for Credit Bill" := true;
                            //Rec."Allow for Credit Bill By" := UserId;
                            Rec."Allow for Credit Bill at" := CurrentDateTime;
                            rec.Modify();
                            Message('Access Granted for Allow Credit Bill');
                        end else
                            Error('You do not have permission to allow credit bill activate');
                    end;

                end;
            }
            action("Payment Post")
            {
                ApplicationArea = all;
                Image = PostedPayment;
                Caption = 'Payment Post';
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    PaymentLine: Record "Payment Lines";
                    TotalPayemtamt: Decimal;
                    SalesHdr: Record 36;
                begin
                    if not Confirm('Do you want to post payment receipt', true) then begin
                        clear(TotalGSTAmount1);
                        Clear(TotalTCSAmt);
                        Clear(TotalAmt);

                        GetGSTAmountTotal(Rec, TotalGSTAmount1);
                        GetTCSAmountTotal(Rec, TotalTCSAmt);
                        GetSalesorderStatisticsAmount(Rec, TotalAmt);
                        Rec."Amount To Customer" := TotalAmt + TotalGSTAmount1 + TotalTCSAmt;
                        Rec.Modify();

                        Clear(TotalPayemtamt);
                        PaymentLine.Reset();
                        PaymentLine.SetRange("Document No.", Rec."No.");
                        if PaymentLine.FindSet() then
                            repeat
                                TotalPayemtamt := PaymentLine.Amount;
                            until PaymentLine.Next() = 0;

                        IF TotalPayemtamt <> Rec."Amount To Customer" then
                            Error('Sales Order amount is not match with Payment amount')
                        else begin
                            BankPayentReceiptAutoPost(Rec);
                            SalesHdr.Reset();
                            SalesHdr.SetRange("No.", rec."No.");
                            If SalesHdr.FindFirst() then begin
                                SalesHdr.Status := SalesHdr.Status::Released;
                                SalesHdr.Modify();
                            end;
                        end;

                    end;
                end;
            }
        }
    }




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

    local procedure BankPayentReceiptAutoPost(Salesheader: Record "Sales Header")
    var
        GenJourLine: Record 81;
        NoSeriesMgt: Codeunit 396;
        BankAcc: Record 270;
        PaymentLine: Record 50301;
    begin
        PaymentLine.Reset();
        PaymentLine.SetRange("Document Type", Rec."Document Type");
        PaymentLine.SetRange("Document No.", Rec."No.");
        if PaymentLine.FindSet() then
            repeat
                GenJourLine.Reset();
                GenJourLine.SetRange("Journal Template Name", 'BANKRCPTY');
                GenJourLine.SetRange("Journal Batch Name", 'USER-A');
                GenJourLine.Init();
                GenJourLine."Document No." := NoSeriesMgt.GetNextNo('BANKRCPTV', Rec."Posting Date", false);
                GenJourLine."Posting Date" := Today;
                IF GenJourLine.FindLast() then
                    GenJourLine."Line No." := GenJourLine."Line No." + 10000
                else
                    GenJourLine."Line No." := 10000;

                GenJourLine."Journal Template Name" := 'BANKRCPTY';
                GenJourLine."Journal Batch Name" := 'USER-A';
                GenJourLine."Account Type" := GenJourLine."Account Type"::"Bank Account";
                GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::Customer;
                GenJourLine.Validate("Bal. Account No.", rec."Sell-to Customer No.");
                GenJourLine.validate("Account No.", 'GIRO');
                GenJourLine."GST Group Code" := 'Goods';
                GenJourLine.validate(Amount, PaymentLine.Amount);
                GenJourLine.Comment := 'Auto Post';
                GenJourLine.Insert(true);
            Until PaymentLine.Next() = 0;
        // IF CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJourLine) then begin
        //     PaymentLine.Reset();
        //     PaymentLine.SetRange("Document Type", Rec."Document Type");
        //     PaymentLine.SetRange("Document No.", Rec."No.");
        //     if PaymentLine.FindSet() then
        //         repeat
        //             PaymentLine.Posted := True;
        //             PaymentLine.Modify();
        //             IsPaymentLineeditable := PaymentLine.PaymentLinesEditable()
        //         Until PaymentLine.Next() = 0;
        // end;
    end;

    trigger OnAfterGetRecord()
    begin

    end;

    var
        AmountToCust: decimal;
        TotalGSTAmount1: Decimal;
        TotalAmt: Decimal;
        TotalTCSAmt: Decimal;
        IsPaymentLineeditable: Boolean;
}