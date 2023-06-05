table 50301 "Payment Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Enum "Payment Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            // TableRelation = "Sales Header"."No." WHERE("Document Type" = FIELD("Document Type"));
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
            trigger OnValidate()
            var
                PayMeth: Record "Payment Method";
            begin
                TestField("Payment Method Code");
                IF PayMeth.Get(Rec."Payment Method Code") then begin
                    Description := PayMeth.Description;
                end;
            end;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(7; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(8; "Card Type"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Card Type';
        }
        field(9; "Owner Name"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner Name';
        }
        field(10; "Credit Card No. Last 4 digit"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner Name';
            // trigger OnValidate()
            // var
            //     Icount: integer;
            // begin
            //     Icount := StrLen(Format("Credit Card No. Last 4 digit"));
            //     IF Icount <> 4 then
            //         error('Last 4 digit of credit card is allowed only')
            // end;
        }
        field(11; "Card Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Card Expiry Date';
        }
        field(12; "Approval Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Approval Code';
        }
        field(13; "Approval Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Approval Date';
        }
        field(14; "DO Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'DO Number';
        }
        field(15; "Subvention by Dealer"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Subvention by Dealer';
        }
        field(16; "MFR Sub. to be born by Dealer"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'MFR Subvention Borne to be born by Dealer';
        }
        field(17; "Deliver Order Copy Upload"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Deliver Order Copy Upload';
        }
        field(18; "Cheque No 6 Digit"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque No 6 Digit';
            // trigger OnValidate()
            // var
            //     Icount: Integer;
            // begin
            //     Icount := StrLen(Format("Cheque No 6 Digit"));
            //     IF Icount <> 6 then
            //         error('6 digit of Cheque No. is allowed only')
            // end;
        }//
        field(19; "Store No."; Code[20])
        {
            Caption = 'Store No.';
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;

        }
        field(20; "Staff Id"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Staff Master".ID;
        }
        field(21; "Payment Attachment"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Transaction ID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";//.Code where("Global Dimension 2 Code" = field("Shortcut Dimension 2 Code"));
            trigger OnValidate()
            var
                SP: Record "Salesperson/Purchaser";
            begin
                IF SP.Get(Rec."Salesperson Code") then
                    "Salesperson Name" := SP.Name;
            end;
        }
        field(24; "Salesperson Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(25; Attachment; Text[250])
        {
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(26; "Finance Promoter"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Finance Promoter ".Code;
            trigger OnValidate()
            var
                FP: Record "Finance Promoter ";
            begin
                IF FP.Get("Finance Promoter") then
                    "Finance Promoter Name" := FP.Name;
            end;
        }
        field(27; "Finance Promoter Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }


    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    procedure PaymentLinesEditable() IsEditable: Boolean;
    var
        SalesHdr: Record 36;
    begin
        SalesHdr.Reset();
        SalesHdr.SetRange("No.", "Document No.");
        SalesHdr.SetRange("Document Type", "Document Type");
        SalesHdr.SetRange(Status, SalesHdr.Status::Released);
        if SalesHdr.FindFirst() then
            IsEditable := false
        else
            IsEditable := true;


    end;

    var
        myInt: Integer;

    trigger OnInsert()
    var
        PL: record "Payment Lines";
        SH: Record "Sales Header";
    begin
        PL.reset;
        PL.SETRANGE("Document No.", "Document No.");
        IF PL.findlast then
            "Line No." := PL."Line No." + 10000
        else
            "Line No." := 10000;

        SH.Reset();
        SH.SetRange("No.", "Document No.");
        IF SH.FindFirst() then begin
            "Store No." := SH."Store No.";
            "Staff Id" := sh."Staff Id";
        end;

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}