page 50366 "Warranty Month"
{
    APIGroup = 'WarrantyMonth';
    APIPublisher = 'Pacific';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'warrantyMonth';
    DelayedInsert = true;
    EntityName = 'WarrantyMonth';
    EntitySetName = 'WarrantyMonths';
    PageType = API;
    SourceTable = "Warranty Month Master";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(monthCode; Rec."Month Code")
                {
                    Caption = 'Month Code';
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
