tableextension 50330 "Bank Acc. Reconciliation Ext" extends "Bank Acc. Reconciliation"
{
    fields
    {
        modify("Bank Account No.")
        {
            trigger OnAfterValidate()
            var
                BA: Record "Bank Account";
            begin
                IF BA.get("Bank Account No.") then
                    IF BA.Tender = false then
                        Error('This Bank Account is not as Tender Account');
            end;
        }

        field(50301; Tender; Boolean)
        {
            Caption = 'Tender';
            DataClassification = ToBeClassified;
        }


    }
}
