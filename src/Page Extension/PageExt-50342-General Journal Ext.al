pageextension 50342 "General Journal Ext1" extends "General Journal"
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
