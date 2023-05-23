table 50312 "Expense Booking Header"
{
    Caption = 'Expense Booking Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Store No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Store No.';
            Editable = false;

        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Store Date';
            Editable = false;

        }
        field(3; "Staff ID"; code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Staff ID';
            TableRelation = "Staff Master".ID;
            trigger OnValidate()
            var
                Staff: Record "Staff Master";
            begin
                IF Staff.Get("Staff ID") then begin
                    "Store No." := Staff."Store No.";
                    Date := Today;

                end;
            end;

        }
        field(4; Status; Enum "Bank Drop Status")
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
    }
    keys
    {
        key(Key1; "Store No.", Date, "Staff ID")
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        ExpLine: Record "Expense Booking Lines";
    begin
        ExpLine.Reset();
        ExpLine.SetRange("Staff ID", "Staff ID");
        ExpLine.SetRange("Store No.", "Store No.");
        ExpLine.SetRange(Date, Date);
        IF ExpLine.FindSet() then
            repeat
                ExpLine.Delete();
            until ExpLine.Next() = 0;
    end;

    trigger OnModify()
    var
        ExpBook: Record "Expense Booking Header";
    begin
        ExpBook.Reset();
        ExpBook.SetRange("Staff ID", rec."Staff ID");
        ExpBook.SetRange("Store No.", rec."Store No.");
        ExpBook.SetRange(Date, Rec.Date);
        ExpBook.SetRange(Status, ExpBook.Status::Released);
        IF ExpBook.FindFirst() then begin
            Error('You can not modify Expense Book after Released Status');
        end;
    end;

}
