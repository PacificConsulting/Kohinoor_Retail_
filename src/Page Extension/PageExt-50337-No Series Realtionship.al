pageextension 50337 "No. Series Realtionship" extends "No. Series Relationships"
{
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
