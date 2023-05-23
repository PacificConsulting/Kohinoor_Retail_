table 50319 "Warranty Barnd Master"
{
    Caption = 'Warranty Barnd Master';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Brand Code"; Code[20])
        {
            Caption = 'Brand Code';
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
        key(PK; "Brand Code")
        {
            Clustered = true;
        }
    }
}
