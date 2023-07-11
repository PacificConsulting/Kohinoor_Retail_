pageextension 50341 "Apply Bank Acc. Ledger Entries" extends "Apply Bank Acc. Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
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
            field("Approval Code"; Rec."Approval Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Approval Code field.';
            }
        }
    }
}

