pageextension 50325 "Posted Transfer Shipment Lines" extends "Posted Transfer Shipment Lines"
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
