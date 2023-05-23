page 50356 Stores
{
    ApplicationArea = All;
    Caption = 'Stores';
    PageType = List;
    SourceTable = Location;
    UsageCategory = Lists;
    CardPageId = "Store Card";
    SourceTableView = where(Store = filter(True));

    layout
    {
        area(content)
        {
            repeater(General)
            {
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
            }
        }
    }
}
