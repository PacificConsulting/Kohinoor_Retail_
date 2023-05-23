pageextension 50319 "Posted Transfer Shipment List" extends "Posted Transfer Shipments"
{
    layout
    {
        addafter("Transfer-to Code")
        {

            field("Transfer Order No."; Rec."Transfer Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of the related transfer order.';
            }
        }
    }
}
