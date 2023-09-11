pageextension 50358 "Bank Acc. Reconciliation Lines" extends "Bank Acc. Reconciliation Lines"
{
    layout
    {
        addbefore("Applied Amount")
        {
            field("Debit Amount"; Rec."Debit Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Debit Amount field.';
            }
            field("Credit Amount"; Rec."Credit Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Credit Amount field.';
            }
            field("Approval Code"; Rec."Approval Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Approval Code field.';
            }

        }
    }
}
