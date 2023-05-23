tableextension 50310 "Gen. Journal Line Ext" extends "Gen. Journal Line"
{
    fields
    {
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
            RecLoc:Record 14;
            begin
                IF RecLoc.Get("Location Code") then begin
                    Validate("Shortcut Dimension 1 Code",RecLoc."Global Dimension 1 Code");
                    Validate("Shortcut Dimension 2 Code",RecLoc."Global Dimension 2 Code");
                end;
            end;
        }
    }
}
