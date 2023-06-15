page 50392 "Item Component"
{
    ApplicationArea = All;
    Caption = 'Item configuration';
    PageType = List;
    SourceTable = "Item Component";
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Item Child No."; Rec."Item Child No.")
                {
                    ToolTip = 'Specifies the value of the Item Child No. field.';
                }
                field("Child Discription"; Rec."Child Description")
                {
                    ToolTip = 'Specifies the value of the Child Discription field.';
                }
            }
        }
    }
}
