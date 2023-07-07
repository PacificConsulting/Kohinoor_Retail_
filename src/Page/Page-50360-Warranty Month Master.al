page 50360 "Warranty Month Master"
{
    ApplicationArea = All;
    Caption = 'Warranty Month Master';
    PageType = List;
    SourceTable = "Warranty Month Master";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Month Code"; Rec."Month Code")
                {
                    ToolTip = 'Specifies the value of the Month Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
    trigger OnModifyRecord(): Boolean
    begin
        IF US.Get(UserId) then begin
            IF not Us."Warranty Access" then
                Error('You do not have access to modify the data.');
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        IF US.Get(UserId) then begin
            IF not Us."Warranty Access" then
                Error('You do not have access to modify the data.');
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF US.Get(UserId) then begin
            IF not Us."Warranty Access" then
                Error('You do not have access to modify the data.');
        end;
    end;

    var
        US: Record 91;

}
