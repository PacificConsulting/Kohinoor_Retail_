tableextension 50315 Customer_ext extends Customer
{
    fields
    {

        modify("P.A.N. No.")
        {
            trigger OnAfterValidate()
            var
                Cnt: Integer;

            begin
                Cnt := StrLen("P.A.N. No.");
                IF (Cnt > 10) /*OR (Cnt < 10)*/ then
                    Error('P.A.N No. required 10 Character only.');
            end;
        }
        modify("GST Customer Type")
        {
            trigger OnAfterValidate()
            var
                ShipAdd: Record "Ship-to Address";
            begin
                /*
                ShipAdd.Reset();
                ShipAdd.SetRange("Customer No.", Rec."No.");
                ShipAdd.SetRange("Address Type", ShipAdd."Address Type"::Primary);
                IF ShipAdd.FindFirst() then begin
                    ShipAdd."Ship-to GST Customer Type" := rec."GST Customer Type";
                end;
                */
            end;
        }
        modify("GST Registration No.")
        {
            trigger OnAfterValidate()
            var
                ShipAdd: Record "Ship-to Address";
            begin
                /*
                ShipAdd.Reset();
                ShipAdd.SetRange("Customer No.", Rec."No.");
                ShipAdd.SetRange("Address Type", ShipAdd."Address Type"::Primary);
                IF ShipAdd.FindFirst() then begin
                    ShipAdd."GST Registration No.":=rec."GST Registration No.";
                end;
                */
            end;
        }

        field(50301; "Customer Reference"; Code[10])
        {
            Caption = 'Customer Reference';
            DataClassification = ToBeClassified;
            TableRelation = "Customer Reference".Code;
        }
        field(50302; "Customer Group"; Enum "Trade Customer Group")
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Group';
        }

    }
    trigger OnInsert()
    begin

    end;

    local procedure ShipToAddressInsert(Cust: Record Customer)
    var
        ShipToAddInit: record "Ship-to Address";
        SR: record 311;
        NoSeries: Codeunit NoSeriesManagement;
        ShipAdd: Record "Ship-to Address";
    begin
        ShipAdd.Reset();
        ShipAdd.SetRange("Customer No.", Rec."No.");
        ShipAdd.SetRange("Address Type", ShipAdd."Address Type"::Primary);
        IF not ShipAdd.FindFirst() then begin
            SR.Get();
            ShipToAddInit.init;
            ShipToAddInit."Customer No." := Rec."No.";
            SR.TestField("Ship To address No Series");
            ShipToAddInit.Code := NoSeries.GetNextNo(SR."Ship To address No Series", Today, true);
            ShipToAddInit.Name := rec.Name;
            ShipToAddInit.Address := Rec.Address;

            ShipToAddInit."Address 2" := rec."Address 2";
            ShipToAddInit.Validate(City, rec.City);
            // ShipToAddInit.State := rec."State Code";
            ShipToAddInit.validate("Post Code", rec."Post Code");
            ShipToAddInit.Validate("Country/Region Code", Rec."Country/Region Code");
            ShipToAddInit."E-Mail" := Rec."E-Mail";
            ShipToAddInit."Phone No." := Rec."Phone No.";
            ShipToAddInit."Address Type" := ShipToAddInit."Address Type"::Primary;
            ShipToAddInit.Validate("GST Registration No.", rec."GST Registration No.");
            ShipToAddInit.Insert();
        end;
    end;
}
