tableextension 50315 Customer_ext extends Customer
{
    fields
    {
        modify("P.A.N. No.")
        {
            trigger OnAfterValidate()
            var
                Cnt: Integer;

            begin
                Cnt := StrLen("P.A.N. No.");
                IF (Cnt > 10) /*OR (Cnt < 10)*/ then
                    Error('P.A.N No. required 10 Character only.');
            end;
        }
        field(50301; "Customer Reference"; Code[10])
        {
            Caption = 'Customer Reference';
            DataClassification = ToBeClassified;
            TableRelation = "Customer Reference".Code;

        }

    }
}
