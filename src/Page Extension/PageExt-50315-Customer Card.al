pageextension 50315 Cust_card extends "Customer Card"
{
    layout
    {
        modify("GST Customer Type")
        {
            trigger OnAfterValidate()
            var
                ShipAdd: Record "Ship-to Address";
            begin

                ShipAdd.Reset();
                ShipAdd.SetRange("Customer No.", Rec."No.");
                ShipAdd.SetRange("Address Type", ShipAdd."Address Type"::Primary);
                IF ShipAdd.FindFirst() then begin
                    ShipAdd."Ship-to GST Customer Type" := rec."GST Customer Type";
                    ShipAdd.Modify();
                end;

            end;
        }
        modify("GST Registration No.")
        {
            trigger OnAfterValidate()
            var
                ShipAdd: Record "Ship-to Address";
            begin
                ShipAdd.Reset();
                ShipAdd.SetRange("Customer No.", Rec."No.");
                ShipAdd.SetRange("Address Type", ShipAdd."Address Type"::Primary);
                IF ShipAdd.FindFirst() then begin
                    ShipAdd."GST Registration No." := rec."GST Registration No.";
                    ShipAdd.Modify();
                end;

            end;
        }
        modify("Search Name")
        {
            Visible = true;
        }
        // modify("Phone No.")
        // {
        //     trigger OnAfterValidate()
        //     begin
        //         Rec.TestField(Name);
        //         Rec.TestField(Address);
        //         Rec.TestField("Address 2");
        //         Rec.TestField(City);
        //         Rec.TestField("Post Code");
        //         Rec.TestField("Country/Region Code");
        //         Rec.TestField("E-Mail");
        //         Rec.TestField("GST Registration No.");
        //         ShipToAddressInsert(Rec);

        //     end;
        // }
        addafter("Salesperson Code")
        {
            field("Customer Reference"; Rec."Customer Reference")
            {
                ApplicationArea = all;
                Caption = 'Customer Reference';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

        rec.TestField(Name);
        rec.TestField(Address);
        rec.TestField(City);
        rec.TestField("Post Code");
        rec.TestField("Country/Region Code");
        rec.TestField("Phone No.");
        ShipToAddressInsert(Rec);

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
            ShipToAddInit.State := rec."State Code";
            ShipToAddInit.validate("Post Code", rec."Post Code");
            ShipToAddInit.Validate("Country/Region Code", Rec."Country/Region Code");
            ShipToAddInit."E-Mail" := Rec."E-Mail";
            ShipToAddInit."Phone No." := Rec."Phone No.";
            ShipToAddInit."Address Type" := ShipToAddInit."Address Type"::Primary;
            ShipToAddInit.Validate("GST Registration No.", rec."GST Registration No.");
            ShipToAddInit.Insert();
        end;
    end;

    var
        myInt: Integer;
}