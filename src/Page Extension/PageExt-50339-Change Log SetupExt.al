pageextension 50339 "Change Log Setup Ext" extends "Change Log Setup"
{
    trigger OnModifyRecord(): Boolean
    begin
        IF US.Get(UserId) then begin
            IF not Us."Admin Access" then
                Error('You do not have access to modify the data.');
        end;
    end;

    var
        US: Record 91;
}
