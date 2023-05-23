page 50343 "Country List"
{
    APIGroup = 'CountryGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'countryList';
    DelayedInsert = true;
    EntityName = 'CountryList';
    EntitySetName = 'CountryLists';
    PageType = API;
    SourceTable = "Country/Region";
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
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(countyName; Rec."County Name")
                {
                    Caption = 'County Name';
                }
                field(euCountryRegionCode; Rec."EU Country/Region Code")
                {
                    Caption = 'EU Country/Region Code';
                }
                field(intrastatCode; Rec."Intrastat Code")
                {
                    Caption = 'Intrastat Code';
                }
                field(addressFormat; Rec."Address Format")
                {
                    Caption = 'Address Format';
                }
                field(contactAddressFormat; Rec."Contact Address Format")
                {
                    Caption = 'Contact Address Format';
                }
                field(isoNumericCode; Rec."ISO Numeric Code")
                {
                    Caption = 'ISO Numeric Code';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
