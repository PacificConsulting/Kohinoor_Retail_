pageextension 50309 "Payment Methods" extends "Payment Methods"
{
    layout
    {
        addafter(Description)
        {
            field(Tender; Rec.Tender)
            {
                ApplicationArea = all;
            }
            field("Payment Type"; Rec."Payment Type")
            {
                ApplicationArea = all;
            }
        }
        addafter("Bal. Account No.")
        {

            field("Reco. Account Type"; Rec."Reco. Account Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bal. Account Type field.';
            }
            field("Reco. Account No."; Rec."Reco. Account No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bal. Account No. field.';
            }
        }

    }


    actions
    {
        // Add changes to page actions here
    }

    trigger OnModifyRecord(): Boolean
    begin
        IF US.Get(UserId) then begin
            IF not Us."Admin Access" then
                Error('You do not have access to modify the data.');
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        IF US.Get(UserId) then begin
            IF not Us."Admin Access" then
                Error('You do not have access to modify the data.');
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF US.Get(UserId) then begin
            IF not Us."Admin Access" then
                Error('You do not have access to modify the data.');
        end;
    end;

    var
        US: Record "User Setup";

}