pageextension 50314 "Bank Acc Card Ext" extends "Bank Account Card"
{
    layout
    {
        addafter(Blocked)
        {
            field(Tender; Rec.Tender)
            {
                ApplicationArea = all;
                Caption = 'Tender';
            }
        }
    }
}
