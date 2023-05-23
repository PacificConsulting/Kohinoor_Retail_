page 50337 "Transfer Order Subform API"
{
    APIGroup = 'Transfer';
    APIPublisher = 'Pacific';
    APIVersion = 'v3.0';
    ApplicationArea = All;
    Caption = 'transferOrderSubform';
    DelayedInsert = true;
    EntityName = 'TransferOrderSubform';
    EntitySetName = 'TransferOrderSubforms';
    PageType = API;
    SourceTable = "Transfer Line";
    ODataKeyFields = SystemId;
    SourceTableView = where("Derived From Line No." = filter(0));

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
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(transferPrice; Rec."Transfer Price")
                {
                    Caption = 'Transfer Price';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(qtyToShip; Rec."Qty. to Ship")
                {
                    Caption = 'Qty. to Ship';
                }
                field(qtyToReceive; Rec."Qty. to Receive")
                {
                    Caption = 'Qty. to Receive';
                }
                field(quantityReceived; Rec."Quantity Received")
                {
                    Caption = 'Quantity Received';
                }
                field(quantityShipped; Rec."Quantity Shipped")
                {
                    Caption = 'Quantity Shipped';
                }
                field(shipmentDate; Rec."Shipment Date")
                {
                    Caption = 'Shipment Date';
                }
                field(receiptDate; Rec."Receipt Date")
                {
                    Caption = 'Receipt Date';
                }
                field(gstGroupCode; Rec."GST Group Code")
                {
                    Caption = 'GST Group Code';
                }
                field(hsnSACCode; Rec."HSN/SAC Code")
                {
                    Caption = 'HSN/SAC Code';
                }
            }
        }
    }
}
