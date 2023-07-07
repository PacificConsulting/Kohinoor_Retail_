page 50358 "Warranty Master List"
{
    ApplicationArea = All;
    Caption = 'Warranty Master List';
    PageType = List;
    SourceTable = "Warranty Master new";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Brand; Rec.Brand)
                {
                    ToolTip = 'Specifies the value of the Brand field.';
                }
                field(Months; Rec.Months)
                {
                    ToolTip = 'Specifies the value of the Months field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("From Date"; Rec."From Date")
                {
                    ToolTip = 'Specifies the value of the From Date field.';
                }
                field("TO Date"; Rec."TO Date")
                {
                    ToolTip = 'Specifies the value of the TO Date field.';
                }
                field("From Value"; Rec."From Value")
                {
                    ToolTip = 'Specifies the value of the From Value field.';
                }
                field("To Value"; Rec."To Value")
                {
                    ToolTip = 'Specifies the value of the To Value field.';
                }

                field("EW Prices"; Rec."EW Prices")
                {
                    ToolTip = 'Specifies the value of the EW Prices field.';
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
