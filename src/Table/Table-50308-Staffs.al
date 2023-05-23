table 50308 "Staff Master"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "E-Mail"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Store No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(5; "Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // var
            //     Char: DotNet Char;
            //     i: Integer;
            //     PhoneNoCannotContainLettersErr: Label 'must not contain letters';
            // begin
            //     for i := 1 to StrLen("Phone No.") do
            //         if Char.IsLetter("Phone No."[i]) then
            //             FieldError("Phone No.", PhoneNoCannotContainLettersErr);
            // end;
        }
        field(6; "POS User ID"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}