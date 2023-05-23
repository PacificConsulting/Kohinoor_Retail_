table 50310 "Expense Type"
{
    Caption = 'Expense Type';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; Name; Text[20])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;

        }
    }
    keys
    {
        key(PK; ID, Name)
        {
            Clustered = true;
        }
        // key(K2; Name)
        // {

        // }
    }
}
