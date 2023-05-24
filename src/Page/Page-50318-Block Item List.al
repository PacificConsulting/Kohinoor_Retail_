page 50318 "Block Item List"
{
    ApplicationArea = All;
    Caption = 'Block Item List';
    PageType = List;
    SourceTable = "Block Item List";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Store No."; Rec."Store No.")
                {
                    ToolTip = 'Specifies the value of the Store No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
            }
        }
    }
}
