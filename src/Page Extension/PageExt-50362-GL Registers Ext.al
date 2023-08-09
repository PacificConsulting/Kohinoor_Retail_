pageextension 50362 "G/L Register Ext1" extends "G/L Registers"
{
    layout
    {
        addafter("User ID")
        {


            field("Staff Id"; Rec."Staff Id")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Staff Id field.';
                Editable = false;
            }
        }
    }
}
