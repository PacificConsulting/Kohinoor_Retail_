tableextension 50330 "Bank Acc. Reconciliation Ext" extends "Bank Acc. Reconciliation"
{
    fields
    {
        field(50301; Tender; Boolean)
        {
            Caption = 'Tender';
            DataClassification = ToBeClassified;
        }
    }
}
