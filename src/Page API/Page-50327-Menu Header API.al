page 50327 "Menu Header API"
{
    APIGroup = 'MenuHdrGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v16.0';
    ApplicationArea = All;
    Caption = 'menuHeaderAPI';
    DelayedInsert = true;
    EntityName = 'MenuHeaderAPI';
    EntitySetName = 'MenuHeaderAPIs';
    PageType = API;
    SourceTable = "Menu Header";
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
                field(menuName; Rec."Menu Name")
                {
                    Caption = 'Menu Name';
                }
                field(creationID; Rec."Creation ID")
                {
                    Caption = 'Creation ID';
                }
                field(creationDate; Rec."Creation Date")
                {
                    Caption = 'Creation Date';
                }
            }
        }
    }
}
