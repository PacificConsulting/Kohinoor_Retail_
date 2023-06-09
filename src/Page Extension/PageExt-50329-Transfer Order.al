pageextension 50329 "Transfer Order" extends "Transfer Order"
{
    layout
    {

    }
    actions
    {
        modify("Re&lease")
        {
            Trigger OnAfterAction()
            var
                transferLine: record "Transfer Line";
                Reservation: Record 337;
            begin
                transferLine.Reset();
                transferLine.SetRange("Document No.", Rec."No.");
                IF transferLine.FindSet() then
                    repeat
                        Reservation.Reset();
                        Reservation.SetRange("Source ID", Rec."No.");
                        Reservation.SetRange("Source Ref. No.", transferLine."Line No.");
                        Reservation.SetRange(Positive, false);
                        IF Reservation.FindSet() then
                            repeat
                                transferLine."Qty. to Ship" += ABS(Reservation."Quantity (Base)");
                            until Reservation.Next() = 0;
                        transferLine.Validate("Qty. to Ship");
                        transferLine.Modify();
                    until transferLine.Next() = 0;
            end;
        }
    }
}
