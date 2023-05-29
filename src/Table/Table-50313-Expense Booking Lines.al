table 50313 "Expense Booking Lines"
{
    Caption = 'Expense Booking Lines';
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

        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; "Expense Type"; Text[20])
        {
            Caption = 'Expense Type';
            DataClassification = ToBeClassified;
            TableRelation = "Expense Type".Name;
            trigger OnValidate()
            var
                StoreExp: Record "Store Expense Configration";
                ExpHeader: Record "Expense Booking Header";
            begin
                StoreExp.Reset();
                StoreExp.SetRange("Expense Type", "Expense Type");
                IF StoreExp.FindFirst() then
                    "Max Allowed Exp.Amount" := StoreExp."Max Allowed Exp. Amount";

            end;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF "Max Allowed Exp.Amount" < Amount then
                    Error('Please Contact to HO department for Approve Amount');
            end;
        }
        field(7; "Max Allowed Exp.Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Expense Limit Amount';
            // Editable = false;
        }
        field(8; Remarks; Text[150])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Store No.", Date, "Staff ID", "Line No.")
        {
            Clustered = true;
        }
    }
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

    trigger OnInsert()
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
