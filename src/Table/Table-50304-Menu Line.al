table 50304 "Menu Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Menu ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Menu Line"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Name; Text[30])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                MH: Record "Menu Header";
            begin
                MH.Reset();
                MH.SetRange("Menu ID", "Menu ID");
                IF MH.FindFirst() then begin
                    "Menu Name" := MH."Menu Name";
                end;
            end;
        }
        field(4; Description; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(5; Action; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "POS Action Master".Code;
        }
        field(6; Parameter; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Menu Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Is Visible"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Parameter 2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Menu ID", "Menu Line")
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