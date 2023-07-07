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
        field(50303; "Reco. Account Type"; enum "Payment Balance Account Type")
        {
            Caption = 'Reco. Account Type';

        }
        field(50304; "Reco. Account No."; Code[20])
        {
            Caption = 'Reco. Account No.';
            TableRelation = IF ("Reco. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Reco. Account Type" = CONST("Bank Account")) "Bank Account" where(Tender = filter(false));
        }



    }
}
