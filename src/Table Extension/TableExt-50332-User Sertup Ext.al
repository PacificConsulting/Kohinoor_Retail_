tableextension 50332 "User Sertup Ext" extends "User Setup"
{
    fields
    {
        field(50301; "Allow for Credit Bill"; Boolean)
        {
            Caption = 'Allow for Credit Bill';
            DataClassification = ToBeClassified;
        }
        field(50302; "Admin Access"; Boolean)
        {
            Caption = 'Admin Access';
            DataClassification = ToBeClassified;
        }
    }
}
