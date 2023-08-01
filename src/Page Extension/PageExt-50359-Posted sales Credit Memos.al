pageextension 50359 "Posted sales Credit Memos" extends "Posted Sales Credit Memos"
{
    layout
    {
        addafter("No. Printed")
        {
            field("Customer GST Reg. No."; Rec."Customer GST Reg. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the GST registration number of the customer specified on the Sales document.';
            }
            field("Ship-to GST Reg. No."; Rec."Ship-to GST Reg. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the ship to GST registration number of the customer specified on the Sales document.';
            }
            field("Store No."; Rec."Store No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Store No. field.';
            }

        }
    }
}
