page 50332 "Transport Method Master"
{
    APIGroup = 'TransportMethodGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'transportMethodMaster';
    DelayedInsert = true;
    EntityName = 'TransportMethodMaster';
    EntitySetName = 'TransportMethodMasters';
    PageType = API;
    SourceTable = "Transport Method";
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
