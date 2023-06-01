pageextension 50323 "Sales Order List" extends "Sales Order List"
{
    layout
    {

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
    }
}
