tableextension 50333 "Bank Acc Reconsilation line" extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        field(50301; "Approval Code"; Code[30])
        {
            Caption = 'Approval Code';
            DataClassification = ToBeClassified;
        }
    }
}
