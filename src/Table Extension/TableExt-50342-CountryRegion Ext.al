tableextension 50342 County_Region_Ext extends "Country/Region"
{
    fields
    {
        field(50000; "Country New"; code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'PCPL-064 26oct2-23';
        }
        // Add changes to table fields here
    }

    var
        myInt: Integer;
}