tableextension 50331 "Purchase Invoice Line" extends "Purch. Inv. Line"
{
    fields
    {
        field(50301; "Warranty Parent Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
}
