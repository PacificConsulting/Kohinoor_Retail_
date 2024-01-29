tableextension 50343 State_ext extends State
{
    fields
    {
        field(50000; "State New"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'PCPL-064 26oct2023';
        }

        // Add changes to table fields here
    }

    var
        myInt: Integer;
}