page 50382 ItemTrackingTransferReceive
{
    APIGroup = 'ItemTrackingGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'ItemTrackingTransferReceive';
    DelayedInsert = true;
    EntityName = 'ItemTrackingTransferReceive';
    EntitySetName = 'ItemTrackingTransferReceives';
    PageType = API;
    SourceTable = "Reservation Entry";
    ODataKeyFields = SystemId;
    SourceTableView = where("Source Type" = filter(5747), Positive = filter(true));

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
                field(lineNo; rec."Source Prod. Order Line")
                {
                    Caption = 'Source Ref. No.';
                }
            }
        }
    }

}
