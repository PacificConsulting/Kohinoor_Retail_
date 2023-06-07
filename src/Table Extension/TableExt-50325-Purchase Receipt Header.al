tableextension 50325 "Purchase Receipt Header" extends "Purch. Rcpt. Header"
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
