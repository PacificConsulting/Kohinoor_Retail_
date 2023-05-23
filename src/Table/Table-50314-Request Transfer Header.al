table 50314 "Request Transfer Header"
{
    Caption = 'Request Transfer Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    GetInventorySetup();
                    NoSeriesMgt.TestManual(GetNoSeriesCode());
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Transfer-from Code"; Code[10])
        {
            Caption = 'Transfer-from Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
            trigger OnValidate()
            var
                RecLoc: Record 14;
            begin
                IF RecLoc.Get("Transfer-from Code") then begin
                    "Transfer-From Name" := RecLoc.Name;
                end;
            end;
        }
        field(3; "Transfer-to Code"; Code[10])
        {
            Caption = 'Transfer-to Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
            trigger OnValidate()
            var
                RecLoc: Record 14;
            begin
                IF RecLoc.Get("Transfer-to Code") then begin
                    "Transfer-to Name" := RecLoc.Name;
                end;
            end;

        }
        field(4; "Transfer-from Name"; Text[100])
        {
            Caption = 'Transfer-from Name';
            Editable = false;
        }
        field(5; "Transfer-to Name"; Text[100])
        {
            Caption = 'Transfer-to Name';
            Editable = false;
        }
        field(6; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting Date';
        }
        field(7; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(8; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Pending for Approval,Released';
            OptionMembers = Open,"Pending for Approval",Released;
        }
        field(9; "Staff ID"; Code[10])
        {
            Caption = 'Staff ID';
            TableRelation = "Staff Master".ID;
            trigger OnValidate()
            var
                StaffMaster: Record "Staff Master";
                RecLoc: Record Location;
            begin
                IF StaffMaster.Get("Staff ID") then begin
                    Validate("Transfer-to Code", StaffMaster."Store No.");
                end;


            end;
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        RTL: Record "Request Transfer Line";
    begin
        RTL.Reset();
        RTL.SetRange("Document No.", "No.");
        IF RTL.FindSet() then
            repeat
                RTL.Delete();
            until RTL.Next() = 0;

    end;

    trigger OnInsert()
    var
        NoSeries: Codeunit NoSeriesManagement;
        InvtSetup: Record "Inventory Setup";
    begin
        InvtSetup.Get();
        InvtSetup.TestField("Request Tran. Order Nos.");
        Rec."No." := NoSeries.GetNextNo(InvtSetup."Request Tran. Order Nos.", rec."Posting Date", true);
        //Rec.Modify();
    end;


    local procedure GetInventorySetup()
    begin
        if not HasInventorySetup then begin
            InvtSetup.Get();
            HasInventorySetup := true;
        end;
    end;

    var
        Item: Record 27;
        Location: Record 14;
        GetSalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HasInventorySetup: Boolean;
        InvtSetup: Record "Inventory Setup";
        ReqTransHeader: Record "Request Transfer Header";

    local procedure GetNoSeriesCode(): Code[20]
    var
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
    begin
        GetInventorySetup();
        IsHandled := false;
        if IsHandled then
            exit;

        // NoSeriesCode := InvtSetup."Transfer Order Nos.";
        NoSeriesCode := InvtSetup."Request Tran. Order Nos.";
        exit(NoSeriesCode);
    end;

    procedure AssistEdit(OldReqTransHeader: Record "Request Transfer Header"): Boolean
    begin
        with ReqTransHeader do begin
            ReqTransHeader := Rec;
            GetInventorySetup();

            InvtSetup.TestField("Request Tran. Order Nos.");
            if NoSeriesMgt.SelectSeries(GetNoSeriesCode(), OldReqTransHeader."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := ReqTransHeader;
                exit(true);
            end;
        end;
    end;//



}
