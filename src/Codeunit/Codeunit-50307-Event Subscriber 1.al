codeunit 50307 "Event & Subscriber 1"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"Ship-to Address", 'OnAfterLookupPostCode', '', false, false)]
    local procedure OnAfterLookupPostCode(var ShipToAddress: Record "Ship-to Address"; var PostCodeRec: Record "Post Code"; xShipToAddress: Record "Ship-to Address");
    var
        PC: Record "Post Code";
    begin

        IF PC.Get(ShipToAddress."Post Code", ShipToAddress.City) then begin
            ShipToAddress.State := PC."State Code";
            ShipToAddress.Modify();
        end;
        //ShipToAddress.State := PostCodeRec."State Code";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Ship-to Address", 'OnAfterValidatePostCode', '', false, false)]
    local procedure OnAfterValidatePostCode(var ShipToAddress: Record "Ship-to Address"; var PostCode: Record "Post Code");
    var
        PC: Record "Post Code";
    begin
        IF PC.Get(ShipToAddress."Post Code", ShipToAddress.City) then begin
            ShipToAddress.State := PC."State Code";
            ShipToAddress.Modify();
        end;
        //ShipToAddress.State := PostCode."State Code";
    end;
}