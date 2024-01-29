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
        field(50305; "Value Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Bank Acc. Reconciliation Line"."Value Date" where("Bank Account No." = field("Bank Account No."), "Statement No." = field("Statement No."), "Statement Line No." = field("Statement Line No.")));
            Enabled = false;
        }
        field(50306; "Contra Lines"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
    }
}
