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
        field(50303; "Trade Agreement Access"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50304; "Warranty Access"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50305; "Allow Cheque Clearance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}
