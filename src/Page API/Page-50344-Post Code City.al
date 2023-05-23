page 50344 "Post Code/City API"
{
    APIGroup = 'PostcodeGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'postCodeCity';
    DelayedInsert = true;
    EntityName = 'PostCodeCity';
    EntitySetName = 'PostCodeCitys';
    PageType = API;
    SourceTable = "Post Code";
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
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field(county; Rec.County)
                {
                    Caption = 'County';
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(stateCode; Rec."State Code")
                {
                    Caption = 'State Code';
                }
            }
        }
    }
}
