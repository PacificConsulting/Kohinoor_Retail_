page 50323 "Expense Booking header"
{
    APIGroup = 'ExpBookGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v13.0';
    ApplicationArea = All;
    Caption = 'expenseBookingHeader';
    DelayedInsert = true;
    EntityName = 'ExpenseBookingHeader';
    EntitySetName = 'ExpenseBookingHeaders';
    PageType = API;
    SourceTable = "Expense Booking Header";
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
                field(staffID; Rec."Staff ID")
                {
                    Caption = 'Staff ID';
                }
                field(storeNo; Rec."Store No.")
                {
                    Caption = 'Store No.';
                }
                field("date"; Rec."Date")
                {
                    Caption = 'Store Date';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
            }
        }
    }



}
