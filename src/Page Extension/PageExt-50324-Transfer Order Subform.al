pageextension 50324 "Transfer Order Subform" extends "Transfer Order Subform"
{
    layout
    {
        addafter("HSN/SAC Code")
        {
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = all;
            }
        }
    }
}
