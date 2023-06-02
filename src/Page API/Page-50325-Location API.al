page 50325 "Location API"
{
    APIGroup = 'Location';
    APIPublisher = 'Pacific';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'locationAPI';
    DelayedInsert = true;
    EntityName = 'Location';
    EntitySetName = 'Locations';
    PageType = API;
    SourceTable = Location;
    ODataKeyFields = SystemId;
    // SourceTableView = where(Store = filter(true));
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(SystemId; Rec.SystemId)
                {
                    Caption = 'SystemID';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(gstRegistrationNo; Rec."GST Registration No.")
                {
                    Caption = 'GST Registration No.';
                }
                field(useAsInTransit; Rec."Use As In-Transit")
                {
                    Caption = 'Use As In-Transit';
                }
                field(startupMenu; Rec."Startup Menu ")
                {
                    Caption = 'Startup Menu ';
                }
            }
        }
    }
}
