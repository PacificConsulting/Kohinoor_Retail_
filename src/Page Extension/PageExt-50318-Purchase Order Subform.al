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
        }


    }
}
