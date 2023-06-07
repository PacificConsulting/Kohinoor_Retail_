tableextension 50329 "Transfer Shipment Header" extends "Transfer Shipment Header"
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
