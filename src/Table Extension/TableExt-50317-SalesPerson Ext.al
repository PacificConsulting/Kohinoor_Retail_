tableextension 50317 "SalesPerson Ext" extends "Salesperson/Purchaser"
{
    fields
    {
        field(50301; "Store No."; Code[20])
        {
            Caption = 'Store No.';
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;

        }
    }
}
