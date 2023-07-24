pageextension 50356 Posted_Transfer_Shipment_Ext1 extends "Posted Transfer Shipment"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("&Print")
        {
            action("Transfer Order Print")
            {
                ApplicationArea = all;
                Promoted = true;
                Image = Print;
                trigger OnAction()
                var
                    TSH: Record "Transfer Shipment Header";
                begin
                    TSH.Reset();
                    TSH.SetRange("No.", rec."No.");
                    if TSH.FindFirst() then
                        Report.RunModal(50314, true, false, TSH);
                end;

            }
        }
    }

    var
        myInt: Integer;
}