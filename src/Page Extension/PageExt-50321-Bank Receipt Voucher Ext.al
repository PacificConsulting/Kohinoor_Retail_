pageextension 50321 "Bank Receipt Voucher Ext" extends "Bank Receipt Voucher"
{
    layout
    {
        addafter("Credit Amount")
        {
            field("Approval Code"; Rec."Approval Code")
            {
                ApplicationArea = all;
            }
            field("Card No."; Rec."Card No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Card No. field.';
            }
        }
        moveafter("Document Type"; "Document No.")
        moveafter("Document No."; "Account Type")
        moveafter("Account Type"; "Account No.")
        moveafter("Shortcut Dimension 2 Code"; "T.A.N. No.")
        moveafter("T.A.N. No."; "TDS Certificate Receivable")
        moveafter("TDS Section Code"; "Amount Excl. GST")
        moveafter("Account No."; AccountName)
        moveafter(AccountName; "Bal. Account Type")
        moveafter("Bal. Account Type"; "Bal. Account No.")
        moveafter("Bal. Account No."; "Debit Amount")
        moveafter("Debit Amount"; "Credit Amount")
        moveafter("Approval Code"; "Shortcut Dimension 1 Code")
        moveafter("Shortcut Dimension 1 Code"; "Shortcut Dimension 2 Code")
        moveafter("Location Code"; "Check Printed")
    }
}
