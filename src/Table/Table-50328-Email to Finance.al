table 50328 "Email to Finance"
{
    Caption = 'Email to Finance';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Payment Method"; Code[10])
        {
            Caption = 'Payment Method';
            TableRelation = "Payment Method" where("Payment Type" = filter('Finance'));
        }
        field(2; "E-Mail"; Text[50])
        {
            Caption = 'E-Mail';
        }
        field(3; "Store No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Store No.';
            TableRelation = Location.Code where(Store = filter(true));
        }
    }
    keys
    {
        key(PK; "Payment Method", "E-Mail", "Store No.")
        {
            Clustered = true;
        }
    }
}
