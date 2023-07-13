pageextension 50346 "Purchase Invoices Ext retail" extends "Purchase Invoices"
{
    layout
    {
        addafter("No.")
        {
            field("Posting Date1"; Rec."Posting Date")
            {
                ApplicationArea = All;
                Caption = 'Posting Date';
            }
        }
        addafter(Amount)
        {
            field("Shortcut Dimension 1 Code1"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 1 Code';
            }
            field("Shortcut Dimension 2 Code2"; Rec."Shortcut Dimension 2 Code")
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 2 Code';
            }
        }
    }
}
