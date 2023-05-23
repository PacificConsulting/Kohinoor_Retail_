tableextension 50315 Customer_ext extends Customer
{
    fields
    {
        field(50301; "Customer Reference"; Code[10])
        {
            Caption = 'Customer Reference';
            DataClassification = ToBeClassified;
            TableRelation = "Customer Reference".Code;
        }
    }
}
