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
                IF RecLoc.Get("Location Code") then begin
                    IF RecLoc.Store then
                        "Store No." := "Location Code";
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

    }

    var
        myInt: Integer;



    trigger OnDelete()
    var
        PayLine: Record "Payment Lines";
        SalesLine: Record "Sales Line";
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