tableextension 50309 "Ship To Address Ext" extends "Ship-to Address"
{
    fields
    {

        field(50301; "Address Type"; Enum "Ship To Address Type")
        {
            Caption = 'Address Type';
            DataClassification = ToBeClassified;
        }

    }
}
