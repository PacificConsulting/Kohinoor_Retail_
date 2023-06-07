tableextension 50322 "OrderAddress Ext" extends "Order Address"
{
    fields
    {
        modify("Post Code")
        {
            trigger OnAfterValidate()
            var
                recPostCode: Record "Post Code";
            begin
                IF recPostCode.Get("Post Code", City) then
                    State := recPostCode."State Code";
            end;
        }
    }
}
