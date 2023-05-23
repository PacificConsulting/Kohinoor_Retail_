page 50334 "Purchase Order Subform API"
{
    APIGroup = 'PurchasGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v3.0';
    ApplicationArea = All;
    Caption = 'purchaseOrderSubformAPI';
    DelayedInsert = true;
    EntityName = 'PurchaseOrderSubform';
    EntitySetName = 'PurchaseOrderSubforms';
    PageType = API;
    SourceTable = "Purchase Line";
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
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(buyFromVendorNo; Rec."Buy-from Vendor No.")
                {
                    Caption = 'Buy-from Vendor No.';
                }
                field(VendorName; VendorName)
                {
                    Caption = 'Vendor Name';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(qtyToReceive; Rec."Qty. to Receive")
                {
                    Caption = 'Qty. to Receive';
                }
                field(quantityReceived; Rec."Quantity Received")
                {
                    Caption = 'Quantity Received';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(LocationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }

            }
        }
    }
    trigger OnAfterGetRecord()
    var
        Vend: record Vendor;
    begin
        IF Vend.Get(Rec."Buy-from Vendor No.") then begin
            VendorName := Vend.Name;
        end;
    end;


    var
        VendorName: text[100];
}
