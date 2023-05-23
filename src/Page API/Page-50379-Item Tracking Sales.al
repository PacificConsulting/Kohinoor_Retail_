page 50379 ItemTrackingSales
{
    APIGroup = 'ItemTrackingGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'itemTrackingSales';
    DelayedInsert = true;
    EntityName = 'ItemTrackingSales';
    EntitySetName = 'ItemTrackingSaless';
    PageType = API;
    SourceTable = "Reservation Entry";
    ODataKeyFields = SystemId;
    SourceTableView = where("Source Type" = filter(37));

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
                field(serialNo; Rec."Serial No.")
                {
                    Caption = 'Serial No.';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
            }
        }
    }
}
