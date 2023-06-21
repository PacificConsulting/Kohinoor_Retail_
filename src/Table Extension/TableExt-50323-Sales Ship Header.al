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
        field(50307; "Allow for Credit Bill"; Boolean)
        {
            Caption = 'Allow for Credit Bill';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50308; "Allow for Credit Bill By"; Code[50])
        {
            Caption = 'Allow for Credit Bill By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50309; "Allow for Credit Bill at"; DateTime)
        {
            Caption = 'Allow for Credit Bill At';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
}
