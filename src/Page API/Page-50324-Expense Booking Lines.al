page 50324 "Expense Booking Lines"
{
    APIGroup = 'ExpbookLinesGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v14.0';
    ApplicationArea = All;
    Caption = 'expenseBookingLines';
    DelayedInsert = true;
    EntityName = 'ExpenseBookingLine';
    EntitySetName = 'ExpenseBookingLines';
    PageType = API;
    SourceTable = "Expense Booking Lines";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(storeNo; Rec."Store No.")
                {
                    Caption = 'Store No.';
                }
                field(staffID; Rec."Staff ID")
                {
                    Caption = 'Staff ID';
                }
                field("date"; Rec."Date")
                {
                    Caption = 'Store Date';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(expenseType; Rec."Expense Type")
                {
                    Caption = 'Expense Type';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
            }
        }
    }

}
