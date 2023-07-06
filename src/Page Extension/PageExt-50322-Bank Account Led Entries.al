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
            field("Customer Name"; Rec."Customer Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Name field.';
            }

            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Name field.';
            }

        }
    }
}
