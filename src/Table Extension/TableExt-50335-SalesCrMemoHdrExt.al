tableextension 50335 SalesCrMemoHdrExt extends "Sales Cr.Memo Header"
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

    var
        myInt: Integer;
}