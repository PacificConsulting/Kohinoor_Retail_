page 50339 "Request Transfer Orders"
{
    ApplicationArea = All;
    Caption = 'Request Transfer Orders';
    CardPageID = "Request Transfer Order";
    Editable = false;
    PageType = List;
    SourceTable = "Request Transfer Header";
    UsageCategory = Lists;


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                // field("Transfer-from Code"; Rec."Transfer-from Code")
                // {
                //     ToolTip = 'Specifies the value of the Transfer-from Code field.';
                // }
                // field("Transfer-from Name"; Rec."Transfer-from Name")
                // {
                //     ToolTip = 'Specifies the value of the Transfer-from Name field.';
                // }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    ToolTip = 'Specifies the value of the Transfer-to Code field.';
                }
                field("Transfer-to Name"; Rec."Transfer-to Name")
                {
                    ToolTip = 'Specifies the value of the Transfer-to Name field.';
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