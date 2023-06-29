pageextension 50314 "Bank Acc Card Ext" extends "Bank Account Card"
{
    layout
    {
        // addafter(Blocked)
        // {
        //     field(Tender; Rec.Tender)
        //     {
        //         ApplicationArea = all;
        //         Caption = 'Tender';
        //     }
        // }

        modify("Post Code")
        {
            trigger OnAfterAfterLookup(Selected: RecordRef)
            var
                recPostCode: Record "Post Code";
            begin
                IF recPostCode.Get(Rec."Post Code", Rec.City) then begin
                    Rec."State Code" := recPostCode."State Code";
                    Rec.Modify();
                end;
            end;

            trigger OnAfterValidate()
            var
                recPostCode: Record "Post Code";
            begin
                IF recPostCode.Get(Rec."Post Code", Rec.City) then begin
                    Rec."State Code" := recPostCode."State Code";
                    Rec.Modify();
                end;
            end;


        }
    }
}
