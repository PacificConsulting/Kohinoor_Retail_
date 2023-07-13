pageextension 50342 "General Journal Ext1" extends "General Journal"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Approval Code"; Rec."Approval Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Approval Code field.';
            }
        }
        moveafter("Document No."; "Account Type")
        moveafter("Account Type"; "Account No.")
        moveafter("Account No."; AccountName)
        moveafter(AccountName; "Bal. Account Type")
        moveafter("Bal. Account Type"; "Bal. Account No.")
        moveafter("Bal. Account No."; "Debit Amount")
        moveafter("Debit Amount"; "Credit Amount")
        moveafter("Credit Amount"; "Shortcut Dimension 1 Code")
        moveafter("Shortcut Dimension 1 Code"; "Shortcut Dimension 2 Code")
        addafter("Approval Code")
        {
            field("External Document No.2"; Rec."External Document No.")
            {
                ApplicationArea = All;
                Caption = 'External Document No.2';
            }
        }
    }
}
