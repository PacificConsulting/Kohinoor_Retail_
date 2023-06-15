page 50341 "Customer List API"
{
    APIGroup = 'CustomerGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'customerList';
    DelayedInsert = true;
    EntityName = 'CustomerList';
    EntitySetName = 'CustomerLists';
    PageType = API;
    SourceTable = Customer;
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(SystemId; Rec.SystemId)
                {
                    Caption = 'SystemID';
                }
                field(No; Rec."No.")
                {
                    Caption = 'No.';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        NoSeries: Codeunit NoSeriesManagement;
                        SR: Record "Sales & Receivables Setup";
                    begin
                        SR.Get();
                        SR.TestField("Customer Nos.");
                        Rec."No." := NoSeries.GetNextNo(SR."Order Nos.", Today, true);
                        Rec.Modify();
                    end;
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(Address1; Rec.Address)
                {
                    Caption = 'Address 1';
                }
                field(Address2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                }
                field(City; Rec.City)
                {
                    Caption = 'City';
                }
                field(State; Rec."State Code")
                {
                    Caption = 'State Code';
                }
                field(Country; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(ZipCode; Rec."Post Code")
                {
                    Caption = 'Post Code';
                }
                field(GSTINNumber; Rec."GST Registration No.")
                {
                    Caption = 'GST Registration No.';
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'Email';
                }
                field(PanNo; Rec."P.A.N. No.")
                {
                    Caption = 'P.A.N. No.';
                }
                field(shipToCode; Rec."Ship-to Code")
                {
                    Caption = 'Ship-to Code';
                }
                field(gstCustType; Rec."GST Customer Type")
                {
                    Caption = 'GST Customer Type';
                }
                field(searchName; Rec."Search Name")
                {
                    Caption = 'Search Name';
                }
                field(mobilePhoneNo; Rec."Mobile Phone No.")
                {
                    Caption = 'Mobile Phone No.';
                    trigger OnValidate()
                    var
                        Cust: Record Customer;
                    begin
                        Cust.Reset();
                        Cust.SetRange("Mobile Phone No.", rec."Mobile Phone No.");
                        IF Cust.FindFirst() then
                            Error('Given Mobile No. already Exist for Customer No. %1', Cust."No.");
                    end;
                }
                field(balanceLCY; Rec."Balance (LCY)")
                {
                    Caption = 'Balance (LCY)';
                }
                field(customerReference; Rec."Customer Reference")
                {
                    Caption = 'Customer Reference';
                }

            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        Cust: record 18;
    begin

        Rec."Gen. Bus. Posting Group" := 'DOMESTIC';
        Rec."Customer Posting Group" := 'GOODS';
        //ShipToAddressInsert(Rec); // This code is comment due to This functionality create by kamal in Powerapps
    end;

    local procedure ShipToAddressInsert(Cust: Record Customer)
    var
        ShipToAddInit: record "Ship-to Address";
        SR: record 311;
        NoSeries: Codeunit NoSeriesManagement;
    begin
        SR.Get();
        ShipToAddInit.init;
        ShipToAddInit."Customer No." := Rec."No.";
        SR.TestField("Ship To address No Series");
        ShipToAddInit.Code := NoSeries.GetNextNo(SR."Ship To address No Series", Today, true);
        ShipToAddInit.Name := rec.Name;
        ShipToAddInit.Address := Rec.Address;
        ShipToAddInit."Address 2" := rec."Address 2";
        ShipToAddInit.Validate(City, rec.City);
        ShipToAddInit.validate("Post Code", rec."Post Code");
        ShipToAddInit.Validate("Country/Region Code", Rec."Country/Region Code");
        ShipToAddInit."E-Mail" := Rec."E-Mail";
        ShipToAddInit."Phone No." := Rec."Phone No.";
        ShipToAddInit."Address Type" := ShipToAddInit."Address Type"::Primary;
        ShipToAddInit.Validate("GST Registration No.", rec."GST Registration No.");
        ShipToAddInit.Insert();
    end;
}
