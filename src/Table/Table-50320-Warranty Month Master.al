table 50320 "Warranty Month Master"
{
    Caption = 'Warranty Month Master';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Month Code"; Integer)
        {
            Caption = 'Month Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Month Code")
        {
            Clustered = true;
        }
    }
}
