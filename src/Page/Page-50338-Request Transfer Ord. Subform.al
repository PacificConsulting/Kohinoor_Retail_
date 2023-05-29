page 50338 "Request Tranfer Ord. Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Request Transfer Line";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Description field.';
                }
                // field("Line No."; Rec."Line No.")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Line No. field.';
                //     Editable = false;
                // }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transfer-from Code field.';
                }
                field("Transfer-from Name"; Rec."Transfer-from Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transfer-from Name field.';
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                // field("Line Created"; Rec."Line Created")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Line Created field.';
                // }
                // field("Unit of Measure Code"; Rec."Unit of Measure Code")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                // }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
            }
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