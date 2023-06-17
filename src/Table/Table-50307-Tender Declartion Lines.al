table 50307 "Tender Declartion Line "
{
    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document No.';

        }
        field(2; "Store No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Store No.';

        }
        field(3; "Store Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Store Date';

        }
        field(4; "Staff ID"; code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Staff ID';
            TableRelation = "Staff Master".ID;
        }
        field(5; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line No.';
        }

        field(6; "Payment Method code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Method code';
            TableRelation = "Payment Method".Code;
        }
        field(7; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
            trigger OnValidate()
            var
                TD: Record "Tender Declartion Header";
            begin
                TD.Reset();
                TD.SetRange("No.", "Document No.");
                TD.SetRange(Status, TD.Status::Released);
                IF TD.FindFirst() then
                    Error('You cannot change the amount after tender is released');
            end;
        }
        field(8; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }


    var
        myInt: Integer;
}