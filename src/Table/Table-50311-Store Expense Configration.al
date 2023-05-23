table 50311 "Store Expense Configration"
{
    Caption = 'Store Expense Configration';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Store ID"; Code[20])
        {
            Caption = 'Store No.';
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;

        }
        field(4; "Expense Type"; Text[20])
        {
            Caption = 'Expense Type';
            DataClassification = ToBeClassified;
            TableRelation = "Expense Type".Name;
        }
        field(5; "Max Allowed Exp. Amount"; Decimal)
        {
            Caption = 'Max Allowed Exp. Amount';
            DataClassification = ToBeClassified;
        }
        field(6; "Expense G/L Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where("Income/Balance" = filter("Income Statement"), "Direct Posting" = filter(true));
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }

    }
}
