tableextension 50318 "Transfer Line Retail" extends "Transfer Line"
{
    fields
    {
        field(50301; Remarks; Text[150])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }

        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin

            end;
        }
    }
}
