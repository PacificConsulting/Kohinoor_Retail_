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
        }
    }
}
