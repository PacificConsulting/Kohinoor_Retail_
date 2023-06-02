pageextension 50326 "Posted Transfer receipt Line" extends "Posted Transfer Receipt Lines"
{
    layout
    {
        addafter(Quantity)
        {

            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remarks field.';
            }
        }
    }
}
