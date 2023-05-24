table 50325 "Block Item List"
{
    Caption = 'Block Item List';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Store No."; Code[20])
        {
            Caption = 'Store No.';
            DataClassification = ToBeClassified;
            TableRelation = Location.Code where(Store = filter(true));
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
        }
    }
    keys
    {
        key(PK; "Store No.", "Item No.")
        {
            Clustered = true;
        }
    }
}
