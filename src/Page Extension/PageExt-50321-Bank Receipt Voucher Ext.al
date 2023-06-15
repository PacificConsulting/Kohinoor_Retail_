pageextension 50321 "Bank Receipt Voucher Ext" extends "Bank Receipt Voucher"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Approval Code"; Rec."Approval Code")
            {
                ApplicationArea = all;
            }
            field("Card No."; Rec."Card No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Card No. field.';
            }
        }
    }
}
