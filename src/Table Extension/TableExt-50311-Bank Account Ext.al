tableextension 50311 "Bank Acc. Ext" extends "Bank Account"
{
    fields
    {
        field(50301; Tender; Boolean)
        {
            Caption = 'Tender';
            DataClassification = ToBeClassified;
        }
        modify("Post Code")
        {
            trigger OnAfterValidate()
            var
                recPostCode: Record "Post Code";
            begin
                IF recPostCode.Get("Post Code", City) then
                    "State Code" := recPostCode."State Code";
            end;


        }
    }
}
