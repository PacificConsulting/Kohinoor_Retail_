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
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
