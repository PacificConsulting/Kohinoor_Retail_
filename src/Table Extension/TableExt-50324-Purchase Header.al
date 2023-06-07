tableextension 50324 "Purchase Header Retail" extends "Purchase Header"
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
