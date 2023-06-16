page 50392 "Link Item"
{
    ApplicationArea = All;
    Caption = 'Link Item';
    PageType = List;
    SourceTable = "Link Item";
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
