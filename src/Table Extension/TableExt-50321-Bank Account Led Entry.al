tableextension 50321 "Bank Account Led. Entry" extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50301; "Approval Code"; Code[30])
        {
            Caption = 'Approval Code';
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(50302; "Card No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Card No.';
        }
        field(50303; "Customer Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Cust. Ledger Entry"."Customer Name" where("Document No." = field("Document No.")));
        }
        field(50304; "Vendor Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Vendor Ledger Entry"."Vendor Name" where("Document No." = field("Document No.")));
        }
    }
}
