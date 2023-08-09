tableextension 50335 SalesCrMemoHdrExt extends "Sales Cr.Memo Header"
{
    fields
    {
        field(50306; "Posted By"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Staff Master".ID;
            Editable = false;
        }
        field(50301; "Amount To Customer"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50302; "Store No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Store No.';
            // Editable = false;
        }
        field(50303; "Staff Id"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Staff Master".ID;
        }
        field(50304; "POS Released Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50305; "Order Reference"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50307; "Allow for Credit Bill"; Boolean)
        {
            Caption = 'Allow for Credit Bill';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50308; "Allow for Credit Bill By"; Code[50])
        {
            Caption = 'Allow for Credit Bill By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50309; "Allow for Credit Bill at"; DateTime)
        {
            Caption = 'Allow for Credit Bill At';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50310; "Allow for Cheque Clearance"; Boolean)
        {
            Caption = 'Allow for Cheque Clearance';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50311; "Allow for Cheque Clearance By"; Code[50])
        {
            Caption = 'Allow for Cheque Clearance By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50312; "Allow for Cheque Clearance at"; DateTime)
        {
            Caption = 'Allow for Cheque Clearance At';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50313; "WH Confirmation Remark"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

    }

    var
        myInt: Integer;
}