table 50324 "Azure Storage Container Setup"
{
    Caption = 'Azure Storage Container Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Account Name"; Text[250])
        {
            Caption = 'Account Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Container Name"; Text[250])
        {
            Caption = 'Container Name';
            DataClassification = ToBeClassified;
        }
        field(4; "Access key"; Text[250])
        {
            Caption = 'Access key';
            DataClassification = ToBeClassified;
        }
        field(5; "Container Name Invoice"; Text[250])
        {
            Caption = 'Container Name Invoice';
            DataClassification = ToBeClassified;
        }
        field(6; "Azure Invoice URL"; Text[1024])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Azure Order URL"; Text[1024])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Azure Transfer Order URL"; Text[1024])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Azure Payment Receipt URL"; Text[1024])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Container Name Demo"; Text[250])
        {
            Caption = 'Container Name Demo';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
