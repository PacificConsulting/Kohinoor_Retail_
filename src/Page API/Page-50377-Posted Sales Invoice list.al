page 50377 PostedSalesInvoicelist
{
    APIGroup = 'InvoiceGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'PostedSalesInvoicelist';
    DelayedInsert = true;
    EntityName = 'PostedSalesInvoicelist';
    EntitySetName = 'PostedSalesInvoicelists';
    PageType = API;
    SourceTable = "Sales Invoice Header";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }

                field(sellToCustomerNo; Rec."Sell-to Customer No.")
                {
                }
                field(sellToCustomerName; Rec."Sell-to Customer Name")
                {
                    Caption = 'Sell-to Customer Name';
                }
                field(sellToAddress; Rec."Sell-to Address")
                {
                    Caption = 'Sell-to Address';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(staffId; Rec."Staff Id")
                {
                    Caption = 'Staff Id';
                }
                field(storeNo; Rec."Store No.")
                {
                    Caption = 'Store No.';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(shipmentMethodCode; Rec."Shipment Method Code")
                {
                    Caption = 'Shipment Method Code';
                }
                field(SelltoEMail; Rec."Sell-to E-Mail")
                {
                    Caption = 'Sell to Email';
                }
                field(SelltoPhoneNo; Rec."Sell-to Phone No.")
                {
                    Caption = 'Sell to Phone No.';

                }
                field(shipToCode; Rec."Ship-to Code")
                {
                    Caption = 'Ship-to Code';
                }
            }
        }
    }
}
