pageextension 50353 Item_Replacement_List_Ext extends "Item Journal Replace Data List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addfirst(Creation)
        {
            action("Item Replacment Challan")
            {
                ApplicationArea = all;
                Image = Print;

                PromotedCategory = Process;
                //PromotedIsBig = true;
                Promoted = true;
                //PromotedOnly = true;
                trigger OnAction()
                var
                    myInt: Integer;
                    IRD: Record "Item Journal Replace Data";
                begin
                    IRD.Reset();
                    IRD.SetRange("Document No.", Rec."Document No.");
                    //IRD.SetFilter("Item No.", '<>%1', '');
                    if IRD.FindFirst() then
                        Report.RunModal(50313, true, false, IRD);
                end;

            }

        }
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        IRD: Record "Item Journal Replace Data";
    begin
        IRD.Reset();
        IRD.SetFilter("Item No.", '%1', '');
        IRD.SetRange(Quantity, 0);
        IF IRD.FindSet() then
            repeat
                IRD.Delete();
            until IRD.Next() = 0;
    end;
}
