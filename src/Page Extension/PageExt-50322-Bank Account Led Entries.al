pageextension 50322 "Bank Account Led Entries" extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter("Cheque Date")
        {
            field("Approval Code"; Rec."Approval Code")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Card No."; Rec."Card No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Card No. field.';
            }

        }
    }
}
