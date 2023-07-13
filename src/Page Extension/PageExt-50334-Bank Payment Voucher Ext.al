pageextension 50334 "Bank Payment Voucher Ext" extends "Bank Payment Voucher"
{
    layout
    {

        addafter("Debit Amount")
        {
            field("Approval Code"; Rec."Approval Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Approval Code field.';
            }
        }
        moveafter("Account No."; AccountName)
        moveafter(AccountName; "Debit Amount")
        moveafter(AccountName; "Credit Amount")
        moveafter(AccountName; "Bal. Account Type")
        moveafter("Bal. Account Type"; "Bal. Account No.")
        moveafter("Shortcut Dimension 1 Code"; "GST on Advance Payment")
        moveafter("Shortcut Dimension 1 Code"; "Shortcut Dimension 2 Code")
        moveafter("Shortcut Dimension 2 Code"; "T.A.N. No.")
        moveafter("T.A.N. No."; "TDS Section Code")
        moveafter("Approval Code"; "Shortcut Dimension 1 Code")
    }
}
