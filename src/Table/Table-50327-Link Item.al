table 50327 "Link Item"
{
    Caption = 'Link Item';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
        }
        field(2; "Item Child No."; Code[20])
        {
            Caption = 'Item Child No.';
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
            trigger OnValidate()
            var
                Item: Record 27;
            begin
                IF Item.Get("Item Child No.") then
                    "Child Description" := Item.Description;
            end;
        }
        field(3; "Child Description"; Text[100])
        {
            Caption = 'Child Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Item No.", "Item Child No.")
        {
            Clustered = true;
        }
    }
}
