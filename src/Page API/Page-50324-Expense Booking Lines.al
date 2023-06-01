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
                field(maxAllowedExpAmount; Rec."Max Allowed Exp.Amount")
                {
                    Caption = 'Expense Limit Amount';
                }
                field(Status; Status)
                {
                    Caption = 'Status';
                }
                field(remarks; Rec.Remarks)
                {
                    Caption = 'Remarks';
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        EXPLine: Record "Expense Booking Lines";
    begin
        EXPLine.reset;
        EXPLine.SetRange("Store No.", Rec."Store No.");
        EXPLine.SetRange("Staff ID", Rec."Staff ID");
        EXPLine.SetRange(Date, Rec.Date);
        IF EXPLine.findlast then
            Rec."Line No." := EXPLine."Line No." + 10000
        else
            Rec."Line No." := 10000;
    end;

    trigger OnAfterGetRecord()
    var
        EH: Record "Expense Booking Header";
    begin
        EH.Reset();
        EH.SetRange("Store No.", rec."Store No.");
        EH.SetRange("Staff ID", Rec."Staff ID");
        EH.SetRange(Date, Rec.Date);
        IF EH.FindFirst() then
            Status := EH.Status;
    end;


    var
        Status: Enum "Bank Drop Status";
}
