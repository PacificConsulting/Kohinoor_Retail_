table 50316 "Shift Details"
{
    Caption = 'Shift Details';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            Editable = false;
            AutoIncrement = true;

        }
        field(2; "Shift Type"; Option)
        {
            Caption = 'Shift Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Start,End';
            OptionMembers = "Start","End";
        }
        field(3; "Staff ID"; Code[10])
        {
            Caption = 'Staff ID';
            DataClassification = ToBeClassified;
            TableRelation = "Staff Master".ID;
        }
        field(4; "Store No."; Code[20])
        {
            Caption = 'Store No.';
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(5; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(6; "Entry Details"; DateTime)
        {
            Caption = 'Entry Details';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        SD: Record 50316;
    begin

        //"Entry No." := "Entry No." + 1


    end;
}
