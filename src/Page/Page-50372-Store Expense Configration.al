page 50372 "Store Expense Configration"
{
    ApplicationArea = All;
    Caption = 'Store Expense Configration';
    PageType = List;
    SourceTable = "Store Expense Configration";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.';
                    Visible = false;
                }
                field("Store ID"; Rec."Store ID")
                {
                    ToolTip = 'Specifies the value of the Store ID field.';
                }
                field("Expense Type"; Rec."Expense Type")
                {
                    ToolTip = 'Specifies the value of the Expense Type field.';
                }
                field("Max Allowed Exp. Amount"; Rec."Max Allowed Exp. Amount")
                {
                    ToolTip = 'Specifies the value of the Max Allowed Exp. Amount field.';
                }
                field("Expense G/L Account"; Rec."Expense G/L Account")
                {
                    ToolTip = 'Specifies the value of the Expense G/L Account field.';
                }
            }
        }
    }
}
