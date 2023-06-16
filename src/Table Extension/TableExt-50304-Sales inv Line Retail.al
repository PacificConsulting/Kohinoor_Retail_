tableextension 50304 "Sales inv. Line Retail" extends "Sales Invoice Line"
{
    fields
    {
        field(50301; "Store No."; Code[20])
        {
            Caption = 'Store No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50302; "Approval Status"; Enum "Sales Line Approval Status")
        {
            DataClassification = ToBeClassified;

        }
        field(50303; "Approval Sent By"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50304; "Approval Sent On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50305; "Approved By"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50306; "Approved On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50307; "Old Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50308; "Exchange Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
        }
        field(50309; "Serial No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50310; "GST Tax Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50311; "Salesperson Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50312; "Salesperson Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50313; "Warranty Parent Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50314; "Exchange Comment"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }



    }
}
