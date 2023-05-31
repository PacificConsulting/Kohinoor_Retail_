page 50333 "Purchase Order List API"
{
    APIGroup = 'PurchasGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v3.0';
    ApplicationArea = All;
    Caption = 'PurchaseOrderList';
    DelayedInsert = true;
    EntityName = 'PurchaseOrderList';
    EntitySetName = 'PurchaseOrderLists';
    PageType = API;
    SourceTable = "Purchase Header";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(SystemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(buyFromVendorNo; Rec."Buy-from Vendor No.")
                {
                    Caption = 'Buy-from Vendor No.';
                }
                field(buyFromVendorName; Rec."Buy-from Vendor Name")
                {
                    Caption = 'Buy-from Vendor Name';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(amountIncludingVAT; Rec."Amount Including VAT")
                {
                    Caption = 'Amount Including VAT';
                }
                field(vendorInvoiceNo; Rec."Vendor Invoice No.")
                {
                    Caption = 'Vendor Invoice No.';
                }
                field(lrNo; Rec."LR No.")
                {
                    Caption = 'LR No.';
                }
                field(lrDate; Rec."LR Date")
                {
                    Caption = 'LR Date';
                }
                field(remarks; Rec.Remarks)
                {
                    Caption = 'Remarks';
                }
                field(receive; Rec.Receive)
                {
                    Caption = 'Receive';
                }

            }
        }
    }
}
