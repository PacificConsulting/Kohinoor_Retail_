table 50309 "Bank Drop Entry"
{
    DataClassification = ToBeClassified;
    Caption = 'Bank Drop Entry';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    NoSeriesMgt.TestManual(GetNoSeriesCode());
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Store No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Store No.';
            //Editable = false;
            // trigger OnValidate()
            // var
            //     Loc: Record Location;
            // begin
            //     IF Loc.Get("Store No.") then begin
            //         "Cash Account" := Loc."Cash Account No.";
            //         "Bank Account" := loc."Bank Account No.";
            //     end;
            // end;
        }
        field(3; "Store Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date';
            //Editable = false;


        }
        field(4; "Staff ID"; code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Staff ID';
            TableRelation = "Staff Master".ID;
            trigger OnValidate()
            var
                STFM: Record "Staff Master";
            begin
                IF STFM.Get("Staff ID") then begin
                    "Store No." := STFM."Store No.";
                end;
            end;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';

        }
        field(6; Status; Enum "Bank Drop Status")
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }
        field(7; Description; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(8; "Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No." where(Tender = filter(false));
            Caption = 'Bank Account';
        }
        field(9; "Cash Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
            Caption = 'Cash Account';
        }
        field(10; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    var
        SR: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BankD: Record "Bank Drop Entry";

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

    local procedure GetNoSeriesCode(): Code[20]
    var
        NoSeriesCode: Code[20];
        IsHandled: Boolean;

    begin
        SR.Get();
        IsHandled := false;
        if IsHandled then
            exit;
        NoSeriesCode := SR."Bank Drop No Series";
        exit(NoSeriesCode);
    end;

    procedure AssistEdit(OldBankdrop: Record "Bank Drop Entry"): Boolean
    begin
        with BankD do begin
            BankD := Rec;
            SR.Get();
            SR.TestField("Bank Drop No Series");
            if NoSeriesMgt.SelectSeries(GetNoSeriesCode(), OldBankdrop."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := BankD;
                exit(true);
            end;
        end;
    end;//


}