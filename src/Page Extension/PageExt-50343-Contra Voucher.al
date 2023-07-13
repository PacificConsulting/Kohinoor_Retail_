pageextension 50343 "Contra Voucher Ext" extends "Contra Voucher"
{
    layout
    {

        addafter("Credit Amount")
        {
            field("Approval Code"; Rec."Approval Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Approval Code field.';
            }
        }
        moveafter(AccountName; "Bal. Account Type")
        moveafter("Bal. Account Type"; "Bal. Account No.")
        moveafter("Bal. Account No."; "Debit Amount")
        moveafter("Debit Amount"; "Credit Amount")
        moveafter("Approval Code"; "Shortcut Dimension 1 Code")
        moveafter("Shortcut Dimension 1 Code"; "Shortcut Dimension 2 Code")
        addafter("Shortcut Dimension 2 Code")
        {
            field("External Document No.1"; Rec."External Document No.")
            {
                ApplicationArea = All;
                Caption = 'External Document No.';
            }
        }
    }
}
