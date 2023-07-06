pageextension 50338 "Chanage Log Setup List" extends "Change Log Setup (Table) List"
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
