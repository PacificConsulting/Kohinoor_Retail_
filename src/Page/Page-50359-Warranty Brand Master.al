page 50359 "Warranty Brand Master"
{
    ApplicationArea = All;
    Caption = 'Warranty Brand Master';
    PageType = List;
    SourceTable = "Warranty Barnd Master";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Brand Code"; Rec."Brand Code")
                {
                    ToolTip = 'Specifies the value of the Brand Code field.';
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
