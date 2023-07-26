pageextension 50358 "Bank Acc. Reconciliation Lines" extends "Bank Acc. Reconciliation Lines"
{
    layout
    {
        addbefore("Applied Amount")
        {

            field("Approval Code"; Rec."Approval Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Approval Code field.';
            }
        }
    }
}
