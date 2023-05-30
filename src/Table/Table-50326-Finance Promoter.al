table 50326 "Finance Promoter "
{
    Caption = 'Finance Promoter ';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Cnt: Integer;
            begin
                Cnt := StrLen("Phone No.");
                IF (Cnt > 10) OR (Cnt < 10) then
                    Error('Phone No. required 10 digit only.');
            end;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
