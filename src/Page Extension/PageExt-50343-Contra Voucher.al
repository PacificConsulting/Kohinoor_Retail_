pageextension 50343 "Contra Voucher Ext" extends "Contra Voucher"
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
