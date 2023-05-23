page 50328 "Menu Line API"
{
    APIGroup = 'MenuLineGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v17.0';
    ApplicationArea = All;
    Caption = 'MenuLineAPI';
    DelayedInsert = true;
    EntityName = 'MenuLineAPI';
    EntitySetName = 'MenuLineAPIs';
    PageType = API;
    SourceTable = "Menu Line";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(menuID; Rec."Menu ID")
                {
                    Caption = 'Menu ID';
                }
                field(menuLine; Rec."Menu Line")
                {
                    Caption = 'Menu Line';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(MenuName; Rec."Menu Name")
                {
                    Caption = 'Menu Name';
                }

                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field("action"; Rec."Action")
                {
                    Caption = 'Action';
                }
                field(parameter; Rec.Parameter)
                {
                    Caption = 'Parameter';
                }
                field(parameter2; Rec."Parameter 2")
                {
                    Caption = 'Parameter 2';
                }
                field(IsVisible; Rec."Is Visible")
                {
                    Caption = 'Is Visible';
                }
            }
        }
    }
}
