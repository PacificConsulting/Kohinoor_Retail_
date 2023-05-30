tableextension 50321 "Bank Account Led. Entry" extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50301; "Approval Code"; Code[30])
        {
            Caption = 'Approval Code';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
}
