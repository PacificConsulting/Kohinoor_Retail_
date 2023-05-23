table 50302 "Posted Payment Lines"
{
    DataClassification = ToBeClassified;
    Caption = 'Posted Payment Lines';
    Extensible = false;

    fields
    {
        field(1; "Document Type"; Enum "Payment Document Type")
        {
            Caption = 'Document Type';
            Editable = false;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FIELD("Document Type"));
            Editable = false;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(4; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
            Editable = false;

        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
        }
        field(7; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
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

        }
        field(11; "Card Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Card Expiry Date';
        }
        field(12; "Approval Code"; Code[10])
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

        }
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
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }


    procedure InitFromPaymentLine(PostedpaymentLine: Record "Posted Payment Lines"; PaymentLine: Record "Payment Lines"; SalesInvHdr: Record "Sales Invoice Header")
    begin
        PostedpaymentLine.Init();
        PostedpaymentLine.TransferFields(PaymentLine);
        PostedpaymentLine."Document No." := SalesInvHdr."No.";
        PostedpaymentLine.Insert();
    end;

    var
        myInt: Integer;

    trigger OnInsert()
    begin

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