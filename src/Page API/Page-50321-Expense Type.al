page 50321 "Expense Type"
{
    APIGroup = 'ExpenseTypeGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v11.0';
    ApplicationArea = All;
    Caption = 'expenseType';
    DelayedInsert = true;
    EntityName = 'ExpenseType';
    EntitySetName = 'ExpenseTypes';
    PageType = API;
    SourceTable = "Expense Type";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
