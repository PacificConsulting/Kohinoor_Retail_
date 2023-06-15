page 50306 "Ship To Address API"
{
    APIGroup = 'Master';
    APIPublisher = 'Pacific';
    APIVersion = 'v3.0';
    ApplicationArea = All;
    Caption = 'shipToAddressAPI';
    DelayedInsert = true;
    EntityName = 'ShipToAddress';
    EntitySetName = 'ShipToAddresss';
    PageType = API;
    SourceTable = "Ship-to Address";
    ODataKeyFields = systemId;
    //

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';//
                }
                field(arnNo; Rec."ARN No.")
                {
                    Caption = 'ARN No.';
                }
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(address2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(consignee; Rec.Consignee)
                {
                    Caption = 'Consignee';
                }
                field(contact; Rec.Contact)
                {
                    Caption = 'Contact';
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(county; Rec.County)
                {
                    Caption = 'County';
                }
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    trigger OnValidate()
                    Var
                        SR: record 311;
                        NoSeries: Codeunit NoSeriesManagement;
                    begin
                        SR.Get();
                        SR.TestField("Ship To address No Series");
                        Rec.code := NoSeries.GetNextNo(SR."Ship To address No Series", Today, true);
                        //Rec.Modify();
                    end;
                }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'Email';
                }
                field(faxNo; Rec."Fax No.")
                {
                    Caption = 'Fax No.';
                }
                field(gln; Rec.GLN)
                {
                    Caption = 'GLN';
                }
                field(gstRegistrationNo; Rec."GST Registration No.")
                {
                    Caption = 'GST Registration No.';
                }
                field(homePage; Rec."Home Page")
                {
                    Caption = 'Home Page';
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(name2; Rec."Name 2")
                {
                    Caption = 'Name 2';
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
                field(placeOfExport; Rec."Place of Export")
                {
                    Caption = 'Place of Export';//
                }
                field(postCode; Rec."Post Code")
                {
                    Caption = 'Post Code';//Temp
                }
                field(serviceZoneCode; Rec."Service Zone Code")
                {
                    Caption = 'Service Zone Code';
                }
                field(shipToGSTCustomerType; Rec."Ship-to GST Customer Type")
                {
                    Caption = 'Ship-to GST Customer Type';
                }

                field(shipmentMethodCode; Rec."Shipment Method Code")
                {
                    Caption = 'Shipment Method Code';
                }
                field(shippingAgentCode; Rec."Shipping Agent Code")
                {
                    Caption = 'Shipping Agent Code';
                }
                field(shippingAgentServiceCode; Rec."Shipping Agent Service Code")
                {
                    Caption = 'Shipping Agent Service Code';
                }
                field(state; Rec.State)
                {
                    Caption = 'State';
                }
                field(AddressType; Rec."Address Type")
                {
                    Caption = 'Address Type';
                }

            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //  Rec."Address Type" := rec."Address Type"::Secondary;
    end;
}
