tableextension 50314 "Post Code" extends "Post Code"
{
    fields
    {
        field(50301; "State Code"; Code[10])
        {
            Caption = 'State Code';
            DataClassification = ToBeClassified;
            TableRelation = State.Code;
        }
    }
}
