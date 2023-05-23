page 50352 "Sales Order List API"
{
    APIGroup = 'SalesGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'salesOrderListAPI';
    DelayedInsert = true;
    EntityName = 'SalesOrderList';
    EntitySetName = 'SalesOrderLists';
    PageType = API;
    SourceTable = "Sales Header";
    ODataKeyFields = SystemId;
    // SourceTableView = where("Document Type" = filter(Order));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        NoSeries: Codeunit NoSeriesManagement;
                        SR: Record "Sales & Receivables Setup";
                    begin
                        SR.Get();
                        SR.TestField("Order Nos.");
                        Rec."No." := NoSeries.GetNextNo(SR."Order Nos.", rec."Posting Date", true);
                        Rec.Modify();
                    end;
                }
                field(DocumentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
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
                field(status; Rec.Status)
                {
                    Caption = 'Status';
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
    var
        Cust: Record 18;
        ID: Text[100];

    trigger OnAfterGetRecord()
    begin
        IF Cust.get(rec."Sell-to Customer No.") then begin
            ID := Cust.SystemId;
        end;
    end;



}
