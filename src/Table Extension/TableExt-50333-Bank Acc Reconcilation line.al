tableextension 50333 "Bank Acc Reconsilation line" extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        field(50301; "Approval Code"; Code[30])
        {
            Caption = 'Approval Code';
            DataClassification = ToBeClassified;
        }
        field(50302; "External Document No."; Code[35])
        {
            DataClassification = ToBeClassified;
        }
        field(50303; "Debit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF "Debit Amount" <> 0 then
                    if "Credit Amount" <> 0 then
                        Error('You can either add amount in credit or debit ');
                IF "Debit Amount" <> 0 then
                    Validate("Statement Amount", "Debit Amount");
            end;
        }
        field(50304; "Credit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF "Credit Amount" <> 0 then
                    IF "Debit Amount" <> 0 then
                        Error('You can either add amount in credit or debit');
                if "Credit Amount" <> 0 then
                    Validate("Statement Amount", "Credit Amount" * -1);
            end;
        }
        field(50305; "Isledgerexist"; Boolean)
        {
            Caption = 'IsAmtmatchline';
            DataClassification = ToBeClassified;
        }
    }
}
