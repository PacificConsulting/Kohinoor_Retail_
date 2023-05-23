table 50306 "Tender Declartion Header"
{
    DataClassification = ToBeClassified;
    Caption = 'Tender Declartion';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                // "No." := NoSeriesMgt.GetNextNo(SalesRec."Tender Declartion No Series", Today, true)
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
            Editable = false;

        }
        field(3; "Store Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date';
            Editable = false;

        }
        field(4; "Staff ID"; code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Staff ID';
            TableRelation = "Staff Master".ID;
            trigger OnValidate()
            var
                StaffMaster: Record "Staff Master";
                TenderHdr: Record "Tender Declartion Header";
                PagetenderCard: page "Tender Declartion Card";
                TenderInit: Record "Tender Declartion Header";
                TenderInitLine: Record "Tender Declartion Line ";
                Paymethod: Record "Payment Method";
                TenderInitLineNew: Record "Tender Declartion Line ";
                PageTenderSubform: Page "Tender Declartion Subform";
            begin
                SalesRec.Get();
                IF StaffMaster.Get("Staff ID") then begin
                    "No." := NoSeriesMgt.GetNextNo(SalesRec."Tender Declartion No Series", Today, true);
                    "Store No." := StaffMaster."Store No.";
                    "Store Date" := Today;
                    Rec.Insert();
                    Commit();
                    Paymethod.Reset();
                    Paymethod.SetRange(Tender, true);
                    IF Paymethod.FindSet() then
                        repeat
                            TenderInitLine.Init();
                            TenderInitLine."Document No." := "No.";
                            TenderInitLine."Store No." := "Store No.";
                            TenderInitLine."Store Date" := Today;
                            TenderInitLine."Staff ID" := "Staff ID";

                            TenderInitLineNew.Reset();
                            TenderInitLineNew.SetRange("Store No.", TenderInitLine."Store No.");
                            TenderInitLineNew.SetRange("Store Date", TenderInitLine."Store Date");
                            TenderInitLineNew.SetRange("Staff ID", TenderInitLine."Staff ID");
                            IF TenderInitLineNew.FindLast() then
                                TenderInitLine."Line No." := TenderInitLineNew."Line No." + 10000
                            else
                                TenderInitLine."Line No." := 10000;

                            TenderInitLine.Insert();
                            TenderInitLine."Payment Method code" := Paymethod.Code;
                            TenderInitLine.Modify();
                        until Paymethod.Next() = 0;
                    Commit();
                    // TenderInitLine.Reset();
                    // TenderInitLine.SetRange("Staff ID", "Staff ID");
                    // TenderInitLine.SetRange("Store No.", "Store No.");
                    // TenderInitLine.SetRange("Store Date", "Store Date");
                    // IF TenderInitLine.FindFirst() then begin
                    //     PageTenderSubform.SetTableView(TenderInitLine);
                    //     PageTenderSubform.Update(true);
                    // end;

                end;
            end;
        }
        field(5; Status; Enum "Tender Header Dec.Status")
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }
        field(6; "No. Series"; Code[20])
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
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HasInventorySetup: Boolean;
        InvtSetup: Record "Inventory Setup";
        TenderDecHdr: Record "Tender Declartion Header";
        SalesRec: Record "Sales & Receivables Setup";


    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        TendLine: Record "Tender Declartion Line ";
    begin
        TendLine.Reset();
        TendLine.SetRange("Staff ID", "Staff ID");
        TendLine.SetRange("Store No.", "Store No.");
        TendLine.SetRange("Store Date", "Store Date");
        IF TendLine.FindSet() then
            repeat
                TendLine.Delete();
            until TendLine.Next() = 0;
    end;

    trigger OnRename()
    begin

    end;

    local procedure GetNoSeriesCode(): Code[20]
    var
        NoSeriesCode: Code[20];
        IsHandled: Boolean;

    begin
        SalesRec.Get();
        IsHandled := false;
        if IsHandled then
            exit;
        NoSeriesCode := SalesRec."Tender Declartion No Series";
        exit(NoSeriesCode);
    end;

    procedure AssistEdit(OldReqTenderHdr: Record "Tender Declartion Header"): Boolean
    begin
        with TenderDecHdr do begin
            TenderDecHdr := Rec;
            SalesRec.Get();
            SalesRec.TestField("Tender Declartion No Series");
            if NoSeriesMgt.SelectSeries(GetNoSeriesCode(), OldReqTenderHdr."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := TenderDecHdr;
                exit(true);
            end;
        end;
    end;//


}