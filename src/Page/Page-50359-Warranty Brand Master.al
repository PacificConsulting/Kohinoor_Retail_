page 50359 "Warranty Brand Master"
{
    ApplicationArea = All;
    Caption = 'Warranty Brand Master';
    PageType = List;
    SourceTable = "Warranty Barnd Master";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Brand Code"; Rec."Brand Code")
                {
                    ToolTip = 'Specifies the value of the Brand Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}
