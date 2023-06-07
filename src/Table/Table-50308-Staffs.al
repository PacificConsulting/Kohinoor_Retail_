table 50308 "Staff Master"

{

    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
            trigger
            OnValidate()
            begin
                IF recEmployee.Get(ID) then
                    Name := recEmployee.FullName();
            end;
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
        field(7; "Customer View"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Expense Booking Access"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Item requisition Access"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "GRN Access"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Transfer Shipment Access"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Transfer Receipt Access"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Tender Declaration Access"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Customer Enquiry Access"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Direct Transfer Access"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Sales Shipment Access"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Invoice List View"; Boolean)
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
        recEmployee: Record Employee;

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