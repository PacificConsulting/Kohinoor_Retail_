table 50322 "Warranty Master new"
{
    Caption = 'Warranty Master new';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Brand; Code[20])
        {
            Caption = 'Brand';
            DataClassification = ToBeClassified;
            TableRelation = "Warranty Barnd Master"."Brand Code";
        }
        field(2; Months; Integer)
        {
            Caption = 'Months';
            DataClassification = ToBeClassified;
            TableRelation = "Warranty Month Master"."Month Code";
        }
        field(3; "From Value"; Decimal)
        {
            Caption = 'From Value';
            DataClassification = ToBeClassified;
        }
        field(4; "To Value"; Decimal)
        {
            Caption = 'To Value';
            DataClassification = ToBeClassified;
        }
        field(5; "EW Prices"; Decimal)
        {
            Caption = 'EW Prices';
            DataClassification = ToBeClassified;
        }
        field(6; Description; Text[60])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(7; "From Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "TO Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Warranty Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Brand, Months, "From Value", "To Value", "From Date", "TO Date")
        {
            Clustered = true;
        }
    }
}
