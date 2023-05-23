page 50322 "Store Expesne Configration"
{
    APIGroup = 'StoreExGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v12.0';
    ApplicationArea = All;
    Caption = 'storeExpesneConfigration';
    DelayedInsert = true;
    EntityName = 'StoreExpesneConfigration';
    EntitySetName = 'StoreExpesneConfigrations';
    PageType = API;
    SourceTable = "Store Expense Configration";
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
                field(id; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(expenseType; Rec."Expense Type")
                {
                    Caption = 'Expense Type';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(storeID; Rec."Store ID")
                {
                    Caption = 'Store ID';
                }
                field(maxAllowedExpAmount; Rec."Max Allowed Exp. Amount")
                {
                    Caption = 'Max Allowed Exp. Amount';
                }
            }
        }
    }
}
