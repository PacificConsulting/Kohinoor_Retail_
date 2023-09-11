page 50803 Tax_Information
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Tax Transaction Value";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;

                }
                field("Column Value"; Rec."Column Value")
                {

                }
                field("Currency Code"; Rec."Currency Code")
                {

                }
                field("Tax Record ID"; Rec."Tax Record ID")
                {

                }
                field("Tax Type"; Rec."Tax Type")
                {

                }
                field(Percent; Rec.Percent)
                {

                }
                field(ID; Rec.ID)
                {

                }
                field("Value ID"; Rec."Value ID")
                {

                }
                field("Table ID Filter"; Rec."Table ID Filter")
                {

                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}