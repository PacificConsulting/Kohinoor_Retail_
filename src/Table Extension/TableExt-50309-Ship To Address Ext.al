tableextension 50309 "Ship To Address Ext" extends "Ship-to Address"
{
    fields
    {

        field(50301; "Address Type"; Enum "Ship To Address Type")
        {
            Caption = 'Address Type';
            DataClassification = ToBeClassified;
        }
        // modify("Post Code")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         PostCodeRec: Record "Post Code";
        //     begin
        //         PostCodeRec.Reset();
        //         PostCodeRec.SetRange(Code, Rec.Code);
        //         PostCodeRec.SetRange(City, Rec.City);
        //         IF PostCodeRec.FindFirst() then
        //             rec.State := PostCodeRec."State Code";

        //     end;

        // }

    }
}
