page 50354 "Shift Logs"
{
    ApplicationArea = All;
    Caption = 'Shift Logs';
    PageType = List;
    SourceTable = "Shift Details";
    UsageCategory = Lists;
    //Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Entry Details"; Rec."Entry Details")
                {
                    ToolTip = 'Specifies the value of the Entry Details field.';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Shift Type"; Rec."Shift Type")
                {
                    ToolTip = 'Specifies the value of the Shift Type field.';
                }
                field("Staff ID"; Rec."Staff ID")
                {
                    ToolTip = 'Specifies the value of the Staff ID field.';
                }
                field("Store No."; Rec."Store No.")
                {
                    ToolTip = 'Specifies the value of the Store No. field.';
                }
            }
        }
    }
}
