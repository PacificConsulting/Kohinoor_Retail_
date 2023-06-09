tableextension 50327 "Transfer Header" extends "Transfer Header"
{
    fields
    {
        modify("Transfer-from Code")
        {
            trigger OnAfterValidate()
            var
                recLoc: Record 14;
            begin
                IF Recloc.get("Transfer-from Code") then begin
                    Validate("Shortcut Dimension 1 Code", recLoc."Global Dimension 1 Code");
                    Validate("Shortcut Dimension 2 Code", recLoc."Global Dimension 2 Code");
                end;
            end;
        }
        field(50301; "Posted By"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Staff Master".ID;
            Editable = false;
        }
    }
}
