page 50355 "Store Card"
{
    ApplicationArea = All;
    Caption = 'Store Card';
    PageType = Card;
    SourceTable = Location;
    SourceTableView = where(Store = filter(True));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies a location code for the warehouse or distribution center where your items are handled and stored before being sold.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name or address of the location.';
                }
                field(Store; Rec.Store)
                {
                    ToolTip = 'Specifies the value of the Store field.';
                }
                field("Use As In-Transit"; Rec."Use As In-Transit")
                {
                    ToolTip = 'Specifies that this location is an in-transit location.';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the location address.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the city of the location.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region of the address.';
                }
                field(County; Rec.County)
                {
                    ToolTip = 'Specifies the value of the County field.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the email address of the location.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the telephone number of the location.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {

                }
            }
        }
    }
}
