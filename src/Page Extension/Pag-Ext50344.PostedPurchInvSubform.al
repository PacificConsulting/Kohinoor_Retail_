pageextension 50344 "Posted Purch Inv Subform" extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter("No.")
        {

            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the No. 2 field.';
            }
        }
    }
}
