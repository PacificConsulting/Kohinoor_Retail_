tableextension 50326 "Purchase Inv. Header" extends "Purch. Inv. Header"
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
}
