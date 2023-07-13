pageextension 50350 "Journal Voucher Ext" extends "Journal Voucher"
{
    layout
    {
        moveafter("Document No."; "Account Type")
        moveafter("Account Type"; "Account No.")
        moveafter("Account No."; AccountName)
        moveafter(AccountName; "Bal. Account Type")
        moveafter("Bal. Account Type"; "Bal. Account No.")
        moveafter("Bal. Account No."; "Debit Amount")
        moveafter("Debit Amount"; "Credit Amount")
        moveafter("Applies-to Ext. Doc. No."; "Shortcut Dimension 1 Code")
        moveafter("Shortcut Dimension 1 Code"; "Shortcut Dimension 2 Code")
        moveafter("Shortcut Dimension 2 Code"; "Party Type")
    }
}
