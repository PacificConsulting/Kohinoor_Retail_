tableextension 50334 PurchCrMemohdrExt extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        field(50301; "Posted By"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Staff Master".ID;
            Editable = false;
        }
    }

    var
        myInt: Integer;
}