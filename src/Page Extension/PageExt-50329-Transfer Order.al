pageextension 50329 "Transfer Order" extends "Transfer Order"
{
    layout
    {
        addafter("In-Transit Code")
        {

            field("Staff Id"; Rec."Staff Id")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Staff Id field.';
                Editable = false;
            }
        }
    }
    actions
    {
        addafter("Re&lease")
        {
            action(QtyShip)
            {
                ApplicationArea = all;
                Image = AddAction;
                Visible = false;
                trigger OnAction()
                var
                    CU: Codeunit 50302;
                begin
                    CU.TransferShipQtyUpdate(Rec."No.");
                end;
            }
            action(TO)
            {
                ApplicationArea = all;
                Image = AddAction;
                Visible = false;
                trigger OnAction()
                var
                    CU: Codeunit 50302;
                begin
                    CU.CreateTransferHeader(rec."Transfer-from Code", rec."Transfer-to Code", Today, 'E003412');
                end;
            }
        }

        modify("Re&lease")
        {
            Trigger OnAfterAction()
            var
                transferLine: record "Transfer Line";
                Reservation: Record 337;
                found: Boolean;
            begin
                transferLine.Reset();
                transferLine.SetRange("Document No.", Rec."No.");
                IF transferLine.FindSet() then
                    repeat
                        Clear(found);
                        Reservation.Reset();
                        Reservation.SetRange("Source ID", Rec."No.");
                        Reservation.SetRange("Source Ref. No.", transferLine."Line No.");
                        Reservation.SetRange(Positive, false);
                        IF Reservation.FindSet() then
                            repeat
                                Found := true;
                                transferLine."Qty. to Ship" += ABS(Reservation."Quantity (Base)");
                            until Reservation.Next() = 0;
                        IF Found then begin
                            transferLine.Validate("Qty. to Ship");
                            transferLine.Modify();
                        end;
                    until transferLine.Next() = 0;
            end;
        }
    }
}
