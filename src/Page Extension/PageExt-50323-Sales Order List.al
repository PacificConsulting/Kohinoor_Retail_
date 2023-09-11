pageextension 50323 "Sales Order List" extends "Sales Order List"
{
    layout
    {
        modify("Assigned User ID")
        {
            Visible = false;
        }
    }
    actions
    {
        addfirst(processing)
        {
            action("Bulk Upload Data")
            {
                Caption = 'Bulk Upload Data';
                PromotedCategory = New;
                PromotedIsBig = true;
                Promoted = true;
                ApplicationArea = all;
                Image = UpdateXML;
                trigger OnAction()
                var
                    SO: XmlPort 50302;
                begin
                    So.Run();
                end;
            }
        }
        modify(Reopen)
        {
            trigger OnBeforeAction()
            var

            begin
                if Rec."Completely Shipped" then
                    Error('You can not reopen completly shipped order');
            end;
        }
    }


}
