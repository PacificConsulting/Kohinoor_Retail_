tableextension 50337 "Detailed GST Ledger Entry" extends "Detailed GST Ledger Entry"
{
    fields
    {
        field(50301; "Party Name"; Text[100])
        {
            Caption = 'Party Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50302; "Vendor Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

    }
}
