tableextension 50307 "Payment Method" extends "Payment Method"
{
    fields
    {
        field(50301; Tender; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50302; "Payment Type"; Enum "Payment Type Ext")
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}