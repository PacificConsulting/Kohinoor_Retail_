tableextension 50330 "Bank Acc. Reconciliation Ext" extends "Bank Acc. Reconciliation"
{
    fields
    {
        modify("Bank Account No.")
        {
            trigger OnAfterValidate()
            var

            begin

            end;
        }

        field(50301; Tender; Boolean)
        {
            Caption = 'Tender';
            DataClassification = ToBeClassified;
        }


    }
}
