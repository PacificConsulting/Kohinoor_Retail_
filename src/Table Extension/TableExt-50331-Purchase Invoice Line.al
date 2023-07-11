tableextension 50331 "Purchase Invoice Line" extends "Purch. Inv. Line"
{
    fields
    {
        field(50301; "Warranty Parent Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50302; "No. 2"; Text[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item."No. 2" where("No." = field("No.")));
            Editable = false;
        }
    }
}
