tableextension 50323 "Sales Ship Header" extends "Sales Shipment Header"
{
    fields
    {
        field(50306; "Posted By"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Staff Master".ID;
            Editable = false;
        }
    }
}
