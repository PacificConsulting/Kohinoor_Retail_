tableextension 50341 TDSEntries extends "TDS Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Vendor Name"; Text[50])
        {
            Caption = 'Vendor Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No.")));
        }
    }

    var
        myInt: Integer;
}