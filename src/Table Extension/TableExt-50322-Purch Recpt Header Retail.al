tableextension 50322 "Purch Recpt Header Retail" extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50301; Attachment; Text[100])
        {
            Caption = 'Attachment';
            DataClassification = ToBeClassified;
        }
    }
}
