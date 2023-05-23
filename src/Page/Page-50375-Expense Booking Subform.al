page 50375 "Expense Booking Subform"
{
    ApplicationArea = All;
    Caption = 'Expense Booking Subform';
    PageType = ListPart;
    SourceTable = "Expense Booking Lines";
    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Staff ID"; Rec."Staff ID")
                {
                    ToolTip = 'Specifies the value of the Staff ID field.';
                    Visible = false;
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Store Date field.';
                    Visible = false;
                }
                field("Store No."; Rec."Store No.")
                {
                    ToolTip = 'Specifies the value of the Store No. field.';
                    Visible = false;
                }
                field("Expense Type"; Rec."Expense Type")
                {
                    ToolTip = 'Specifies the value of the Expense Type field.';
                }
                field("Max Allowed Exp.Amount"; Rec."Max Allowed Exp.Amount")
                {
                    ToolTip = 'Specifies the value of the Expense Amount field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
            }
        }
    }
}
