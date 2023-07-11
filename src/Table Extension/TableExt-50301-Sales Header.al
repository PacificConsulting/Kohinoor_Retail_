tableextension 50301 Sales_Header_AmttoCust extends "Sales Header"
{
    fields
    {
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                RecLoc: Record Location;
            begin
                /*
                IF RecLoc.Get("Location Code") then begin
                    IF RecLoc.Store then
                        "Store No." := "Location Code";
                end;
                */
                IF rec."Store No." <> '' then begin
                    If RecLoc.get(Rec."Store No.") then begin
                        Validate("Shortcut Dimension 1 Code", RecLoc."Global Dimension 1 Code");
                        Validate("Shortcut Dimension 2 Code", RecLoc."Global Dimension 2 Code");
                    end;
                end else begin
                    If RecLoc.get(Rec."Location Code") then begin
                        Validate("Shortcut Dimension 1 Code", RecLoc."Global Dimension 1 Code");
                        Validate("Shortcut Dimension 2 Code", RecLoc."Global Dimension 2 Code");
                    end;
                end;

            end;
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                ShiptoAdd: record 222;
                Cust: Record 18;
            begin
                IF rec."POS Released Date" <> 0D then
                    Error('You can not change the Customer when order is Confirmed');

                IF Cust.get("Sell-to Customer No.") then begin
                    If Cust."GST Customer Type" = Cust."GST Customer Type"::" " then
                        Error('GST Customer type should not be blank for Customer No. %1', Cust."No.");
                end;
                ShiptoAdd.Reset();
                ShiptoAdd.SetRange("Customer No.", Rec."Sell-to Customer No.");
                IF ShiptoAdd.FindFirst() then begin
                    Validate(Rec."Ship-to Code", ShiptoAdd.Code);
                end
            end;
        }
        field(50301; "Amount To Customer"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Amount To Customer';
            AutoFormatType = 1;
        }
        field(50302; "Store No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Store No.';
            TableRelation = Location.Code;
            trigger OnValidate()
            var
                RecLoc: Record Location;
            begin
                IF "Store No." <> '' then begin
                    RecLoc.Reset();
                    RecLoc.SetRange(Store, true);
                    RecLoc.SetRange(Code, "Store No.");
                    IF RecLoc.FindFirst() then begin
                        Validate("Location Code", RecLoc.Code);
                    end;
                end;
            end;
        }
        field(50303; "Staff Id"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Staff Master".ID;
        }
        field(50304; "POS Released Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50305; "Order Reference"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50306; "Posted By"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Staff Master".ID;
            Editable = false;
        }
        field(50307; "Allow for Credit Bill"; Boolean)
        {
            Caption = 'Allow for Credit Bill';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50308; "Allow for Credit Bill By"; Code[50])
        {
            Caption = 'Allow for Credit Bill By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50309; "Allow for Credit Bill at"; DateTime)
        {
            Caption = 'Allow for Credit Bill At';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50310; "Allow for Cheque Clearance"; Boolean)
        {
            Caption = 'Allow for Cheque Clearance';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50311; "Allow for Cheque Clearance By"; Code[50])
        {
            Caption = 'Allow for Cheque Clearance By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50312; "Allow for Cheque Clearance at"; DateTime)
        {
            Caption = 'Allow for Cheque Clearance At';
            DataClassification = ToBeClassified;
            Editable = false;
        }

    }

    var
        myInt: Integer;



    trigger OnDelete()
    var
        PayLine: Record "Payment Lines";
        SalesLine: Record "Sales Line";
        ReservEntry: Record 337;
    begin
        SalesLine.Reset();
        SalesLine.SetRange("Document No.", "No.");
        SalesLine.SetRange("Document Type", "Document Type");
        IF SalesLine.FindSet() then
            repeat
                IF SalesLine."Approval Status" = SalesLine."Approval Status"::"Pending for Approval" then begin
                    Error('You can not modify Header if Approval Status of Line is Pending for Approval ');
                end;
            until SalesLine.Next() = 0;

        PayLine.Reset();
        PayLine.SetRange("Document No.", "No.");
        PayLine.SetRange("Document Type", "Document Type");
        IF PayLine.FindSet() then
            repeat
                PayLine.Delete();
            until PayLine.Next() = 0;

        SalesLine.Reset();
        SalesLine.SetRange("Document No.", "No.");
        SalesLine.SetRange("Document Type", "Document Type");
        IF SalesLine.FindSet() then
            repeat
                ReservEntry.RESET;
                ReservEntry.SetRange("Source ID", SalesLine."Document No.");
                ReservEntry.SetRange("Source Ref. No.", SalesLine."Line No.");
                if ReservEntry.Findset() then
                    repeat
                        ReservEntry.Delete();
                    until ReservEntry.Next() = 0;
            until SalesLine.Next() = 0;
    end;

    trigger OnModify()
    var
        SalesLine: Record "Sales Line";
    Begin
        SalesLine.Reset();
        SalesLine.SetRange("Document No.", "No.");
        SalesLine.SetRange("Document Type", "Document Type");
        IF SalesLine.FindSet() then
            repeat
                IF SalesLine."Approval Status" = SalesLine."Approval Status"::"Pending for Approval" then begin
                    Error('You can not modify Header if Approval Status of Line is Pending for Approval ');
                end;
            until SalesLine.Next() = 0;

    End;
}