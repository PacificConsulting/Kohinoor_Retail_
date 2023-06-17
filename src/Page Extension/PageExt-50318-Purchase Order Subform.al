pageextension 50318 "Purchase Order Subform Ext" extends "Purchase Order Subform"
{
    layout
    {
        modify("Gen. Prod. Posting Group")
        {
            Visible = true;
        }
        addafter(Quantity)
        {
            field("Outstanding Quantity"; Rec."Outstanding Quantity")
            {
                ApplicationArea = all;
            }
            field("Warranty Parent Line No."; Rec."Warranty Parent Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Warranty Parent Line No. field.';
            }
        }


    }
}
