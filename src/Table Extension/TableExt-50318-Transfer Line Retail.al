tableextension 50318 "Transfer Line Retail" extends "Transfer Line"
{
    fields
    {
        field(50301; Remarks; Text[150])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(50302; "Warranty Parent Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                ItemConfig: Record "Link Item";
                TLInit: Record "Transfer Line";
                TranLineFilter: Record "Transfer Line";
                TransferLine: Record "Transfer Line";
            begin

                // IF Rec.Type <> rec.Type::" " then begin
                IF Rec.Quantity > 0 then begin
                    ItemConfig.Reset();
                    ItemConfig.SetRange("Item No.", rec."Item No.");
                    IF ItemConfig.FindSet() then
                        repeat
                            TranLineFilter.Reset();
                            TranLineFilter.SetRange("Document No.", "Document No.");
                            // TranLineFilter.SetRange("Item No.", ItemConfig."Item Child No.");
                            TranLineFilter.SetRange("Warranty Parent Line No.", "Line No.");
                            if not TranLineFilter.FindFirst() then begin
                                //*********New Line Insert*******
                                TLInit.Init();
                                TLInit."Document No." := rec."Document No.";

                                TransferLine.Reset();
                                TransferLine.SetRange("Document No.", "Document No.");
                                if TransferLine.FindLast() then
                                    TLInit."Line No." := TransferLine."Line No." + 10000;

                                TLInit.Insert();
                                TLInit.Validate("Item No.", ItemConfig."Item Child No.");
                                TLInit.Validate(Quantity, Rec.Quantity);
                                TLInit.Validate("Transfer-to Code", TransferLine."Transfer-to Code");
                                //TLInit.Validate("Store No.", TransferLine."Store No.");
                                //TLInit.Validate("Salesperson Code", TransferLine."Salesperson Code");
                                TLInit.Validate("Shortcut Dimension 1 Code", TransferLine."Shortcut Dimension 1 Code");
                                TLInit.Validate("Shortcut Dimension 2 Code", TransferLine."Shortcut Dimension 2 Code");
                                TLInit."Warranty Parent Line No." := TransferLine."Line No.";
                                TLInit.Modify();
                            end else begin
                                //**********Modify Qty only**********
                                TranLineFilter.Validate(Quantity, Rec.Quantity);
                                TranLineFilter.Modify();
                            end;
                        until ItemConfig.Next() = 0;
                end;
                //end;

            end;
        }
    }
}
