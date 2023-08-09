tableextension 50338 GLRegisterExt1 extends "G/L Register"
{
    fields
    {
        field(50301; "Staff Id"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Staff Master".ID;
        }
    }

    var
        myInt: Integer;
}