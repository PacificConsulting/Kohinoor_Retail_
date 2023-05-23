page 50330 "POS Acrion Master"
{
    APIGroup = 'POSmasGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v18.0';
    ApplicationArea = All;
    Caption = 'posAcrionMaster';
    DelayedInsert = true;
    EntityName = 'POSActionMaster';
    EntitySetName = 'POSActionMasters';
    PageType = API;
    SourceTable = "POS Action Master";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
