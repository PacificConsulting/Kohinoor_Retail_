/* reportextension 50301 Aged_Account_Receivable_Ext extends "Aged Accounts Receivable"
{
    dataset
    {
        add("Cust. Ledger Entry")
        {
            column(Salesperson_Code; "Salesperson Code")
            {

            }
            column(StoreNo; StoreNo)
            {

            }
            column(NewEnddate; NewEnddate)
            {

            }
            column(NoDays; NoDays)
            {

            }

        }
        modify(TempCustLedgEntryLoop)
        {
            trigger OnAfterAfterGetRecord()
            var
                SIH: Record "Sales Invoice Header";
                SIL: Record "Sales Invoice Line";
                SCMH: Record "Sales Cr.Memo Header";
                SCML: Record "Sales Cr.Memo Line";
            begin
                Clear(StoreNo);
                if "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::Invoice then begin
                    SIH.Reset();
                    SIH.SetRange("No.", "Cust. Ledger Entry"."Document No.");
                    if SIH.FindFirst() then begin
                        StoreNo := SIH."Store No."
                    end
                end
                else
                    if "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::"Credit Memo" then begin
                        SCMH.Reset();
                        SCMH.SetRange("No.", "Cust. Ledger Entry"."Document No.");
                        if SCMH.FindFirst() then begin
                            StoreNo := SCMH."Store No."
                        end else
                            if "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::Payment then begin
                                StoreNo := "Cust. Ledger Entry"."Global Dimension 2 Code";
                            end;

                        NoDays := Today - "Cust. Ledger Entry"."Posting Date";
                    end;
            end;
        }


    }

    requestpage
    {
        layout
        {
            addafter(AgedAsOf)
            {
                field(AsofNew; NewEnddate)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    var
        NoDays: Integer;
        SalesPersonCode: Code[20];
        StoreNo: code[20];
        NewEnddate: date;

    trigger OnPreReport()
    var
        myInt: Integer;
        SIH: Record "Sales Invoice Header";
    begin
        // NoDays := "Cust. Ledger Entry".GetFilter("Cust. Ledger Entry".EndingDate)
    end;

}

 */