pageextension 50334 "Bank Payment Voucher Ext" extends "Bank Payment Voucher"
{
    layout
    {

        addafter("Shortcut Dimension 2 Code")
        {

            field("Approval Code"; Rec."Approval Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Approval Code field.';
            }
        }
    }
}
