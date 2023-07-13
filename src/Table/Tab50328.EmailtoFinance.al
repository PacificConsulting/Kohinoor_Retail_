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
        field(2; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
        }
    }
    keys
    {
        key(PK; "Payment Method", "E-Mail")
        {
            Clustered = true;
        }
    }
}
