pageextension 50340 "Location List Ext" extends "Location List"
{
    trigger OnDeleteRecord(): Boolean
    begin
        IF US.Get(UserId) then begin
            IF not Us."Admin Access" then
                Error('You do not have access to modify the data.');
        end;
    end;

    var
        US: Record "User Setup";
}
