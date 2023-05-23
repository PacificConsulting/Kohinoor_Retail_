page 50373 "Expense Bookings"
{
    ApplicationArea = All;
    Caption = 'Expense Bookings';
    PageType = List;
    SourceTable = "Expense Booking Header";
    UsageCategory = Lists;
    CardPageId = "Expense Booking";
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Staff ID"; Rec."Staff ID")
                {
                    ToolTip = 'Specifies the value of the Staff ID field.';
                }
                field("Store No."; Rec."Store No.")
                {
                    ToolTip = 'Specifies the value of the Store No. field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Store Date field.';
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action("Delete")
            {
                ApplicationArea = All;
                //Caption = 'Caption', comment = '="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Image;

                trigger OnAction()
                var
                    ExpLine: Record "Expense Booking Lines";
                begin
                    ExpLine.Reset();
                    IF ExpLine.FindSet() then
                        repeat
                            ExpLine.Delete();
                        until ExpLine.Next() = 0;
                end;
            }
        }

    }
}
