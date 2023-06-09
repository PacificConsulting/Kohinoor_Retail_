page 50381 ItemTrackingTransferShip
{
    APIGroup = 'ItemTrackingGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'ItemTrackingTransferShip';
    DelayedInsert = true;
    EntityName = 'ItemTrackingTransferShip';
    EntitySetName = 'ItemTrackingTransferShips';
    PageType = API;
    SourceTable = "Reservation Entry";
    ODataKeyFields = SystemId;
    SourceTableView = where("Source Type" = filter(5741), Positive = filter(true));

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
                field(documentNo; Rec."Source ID")
                {
                    Caption = 'Source ID';
                }
                field(lineNo; Rec."Source Ref. No.")
                {
                    Caption = 'Source Ref. No.';
                }
            }
        }
    }
}
