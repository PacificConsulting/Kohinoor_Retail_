pageextension 50354 "Sales Journal Ext1" extends "Sales Journal"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {

            field("GST in Journal"; Rec."GST in Journal")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the GST in Journal field.';
            }
        }
    }
}
