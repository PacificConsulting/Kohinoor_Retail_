page 50369 "Expense Type List"
{
    ApplicationArea = All;
    Caption = 'Expense Type';
    PageType = List;
    SourceTable = "Expense Type";
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.';
                    Editable = false;
                    Visible = false;

                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
            }
        }
    }
}
