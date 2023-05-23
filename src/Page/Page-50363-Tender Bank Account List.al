page 50363 "Tender Bank Account List"
{
    ApplicationArea = All;
    Caption = 'Tender Bank Account List';
    PageType = List;
    SourceTable = "Bank Account";
    UsageCategory = Lists;
    InsertAllowed = false;
    SourceTableView = where(Tender = filter(true));
    CardPageId = "Tender Bank Account Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the bank where you have the bank account.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the telephone number of the bank where you have the bank account.';
                }
                field(Balance; Rec.Balance)
                {
                    ToolTip = 'Specifies the bank account''s current balance denominated in the applicable foreign currency.';
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ToolTip = 'Specifies the bank account''s current balance in LCY.';
                }
                field(Tender; Rec.Tender)
                {
                    ToolTip = 'Specifies the value of the Tender field.';
                }
            }
        }
    }
}
