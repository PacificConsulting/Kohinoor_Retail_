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
        field(50302; "Card No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Card No.';
        }
    }
}
