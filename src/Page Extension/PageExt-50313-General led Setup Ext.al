pageextension 50313 "General led Setup Ext" extends "General Ledger Setup"
{
    layout
    {
        addafter(EnableDataCheck)
        {

            field("Exchange Batch"; Rec."Exchange Batch")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exchange Batch field.';
            }
        }
        addafter("Tax Information")
        {

            Group("Bank Drop")
            {
                field("Bank Drop Batch"; Rec."Bank Drop Batch")
                {
                    ApplicationArea = all;
                    Caption = 'Bank Drop Batch';
                }
                field("Cash Expense Account"; Rec."Cash Expense Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cash Expense Account field.';
                }
            }
            group("Slab Approval Users")
            {
                field("Slab Approval User 1"; Rec."Slab Approval User 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Slab Approval User 1 field.';
                }
                field("Slab Approval User 2"; Rec."Slab Approval User 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Slab Approval User 2 field.';
                }
                field("Slab Approval User 3"; Rec."Slab Approval User 3")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Slab Approval User 3 field.';
                }
                field("Slab Approval User 4"; Rec."Slab Approval User 4")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Slab Approval User 4 field.';
                }
                field("Slab Approval User 5"; Rec."Slab Approval User 5")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Slab Approval User 5 field.';
                }
                field("Slab Approval User 6"; Rec."Slab Approval User 6")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Slab Approval User 6 field.';
                }
                field("Slab Approval User 7"; Rec."Slab Approval User 7")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Slab Approval User 7 field.';
                }

            }
        }
    }
}
