page 50315 "Sales Order Subform API"
{
    APIGroup = 'SalesLineGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v7.0';
    ApplicationArea = All;
    Caption = 'SalesOrdSubformAPI';
    DelayedInsert = true;
    EntityName = 'SalesorderSubform';
    EntitySetName = 'SalesorderSubforms';
    PageType = API;
    SourceTable = "Sales Line";
    ODataKeyFields = SystemId;
    //SourceTableView = WHERE(Type = FILTER(Item | "G/L Account"));


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document ID';
                    // trigger OnValidate()
                    // var
                    //     SalesLine: record 37;
                    // begin
                    //     SalesLine.reset;
                    //     SalesLine.SETRANGE("Document No.", Rec."Document No.");
                    //     IF SalesLine.findlast then begin
                    //         Rec."Line No." := SalesLine."Line No." + 10000;
                    //         Rec.modify;
                    //     end
                    //     else begin
                    //         Rec."Line No." := 10000;
                    //         Rec.modify;
                    //     end;
                    // end;
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                    // trigger OnValidate()
                    // var
                    //     SalesLine: record 37;
                    // begin
                    //     SalesLine.reset;
                    //     SalesLine.SETRANGE("Document No.", Rec."Document No.");
                    //     IF SalesLine.findlast then begin

                    //         Rec."Line No." := SalesLine."Line No." + 10000;
                    //         Rec.modify;
                    //     end
                    //     else begin
                    //         Rec."Line No." := 10000;
                    //         Rec.modify;
                    //     end;
                    // end;
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
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
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(tcsNatureOfCollection; Rec."TCS Nature of Collection")
                {
                    Caption = 'TCS Nature of Collection';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                field(unitPrice; Rec."Unit Price")
                {
                    Caption = 'Unit Price';
                }
                field(unitPriceInclOfTax; Rec."Unit Price Incl. of Tax")
                {
                    Caption = 'Unit Price Incl. of Tax';
                }
                field(lineAmount; Rec."Line Amount")
                {
                    Caption = 'Line Amount';
                }
                field(lineDiscount; Rec."Line Discount %")
                {
                    Caption = 'Line Discount %';
                }
                field(lineDiscountAmount; Rec."Line Discount Amount")
                {
                    Caption = 'Line Discount Amount';
                }
                field(lineDiscountCalculation; Rec."Line Discount Calculation")
                {
                    Caption = 'Line Discount Calculation';
                }

                field(gstGroupCode; Rec."GST Group Code")
                {
                    Caption = 'GST Group Code';
                }
                field(gstGroupType; Rec."GST Group Type")
                {
                    Caption = 'GST Group Type';
                }
                field(hsnSACCode; Rec."HSN/SAC Code")
                {
                    Caption = 'HSN/SAC Code';
                }
                field(gstPlaceOfSupply; Rec."GST Place Of Supply")
                {
                    Caption = 'GST Place of Supply';
                }
                field(gstJurisdictionType; Rec."GST Jurisdiction Type")
                {
                    Caption = 'GST Jurisdiction Type';
                }
                field(qtyToShip; Rec."Qty. to Ship")
                {
                    Caption = 'Qty. to Ship';
                }
                field(qtyToInvoice; Rec."Qty. to Invoice")
                {
                    Caption = 'Qty. to Invoice';
                }
                field(qtyToShipBase; Rec."Qty. to Ship (Base)")
                {
                    Caption = 'Qty. to Ship (Base)';
                }
                field(qtyToInvoiceBase; Rec."Qty. to Invoice (Base)")
                {
                    Caption = 'Qty. to Invoice (Base)';
                }
                field(atoWhseOutstandingQty; Rec."ATO Whse. Outstanding Qty.")
                {
                    Caption = 'ATO Whse. Outstanding Qty.';
                }
                field(atoWhseOutstdQtyBase; Rec."ATO Whse. Outstd. Qty. (Base)")
                {
                    Caption = 'ATO Whse. Outstd. Qty. (Base)';
                }
                field(allowInvoiceDisc; Rec."Allow Invoice Disc.")
                {
                    Caption = 'Allow Invoice Disc.';
                }
                field(allowItemChargeAssignment; Rec."Allow Item Charge Assignment")
                {
                    Caption = 'Allow Item Charge Assignment';
                }
                field(allowLineDisc; Rec."Allow Line Disc.")
                {
                    Caption = 'Allow Line Disc.';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(amountIncludingVAT; Rec."Amount Including VAT")
                {
                    Caption = 'Amount Including VAT';
                }
                field(applFromItemEntry; Rec."Appl.-from Item Entry")
                {
                    Caption = 'Appl.-from Item Entry';
                }
                field(applToItemEntry; Rec."Appl.-to Item Entry")
                {
                    Caption = 'Appl.-to Item Entry';
                }
                field(approvalStatus; Rec."Approval Status")
                {
                    Caption = 'Approval Status';
                }
                field("area"; Rec."Area")
                {
                    Caption = 'Area';
                }
                field(assesseeCode; Rec."Assessee Code")
                {
                    Caption = 'Assessee Code';
                }
                field(attachedDocCount; Rec."Attached Doc Count")
                {
                    Caption = 'Attached Doc Count';
                }
                field(attachedToLineNo; Rec."Attached to Line No.")
                {
                    Caption = 'Attached to Line No.';
                }
                field(bomItemNo; Rec."BOM Item No.")
                {
                    Caption = 'BOM Item No.';
                }
                field(billToCustomerNo; Rec."Bill-to Customer No.")
                {
                    Caption = 'Bill-to Customer No.';
                }
                field(binCode; Rec."Bin Code")
                {
                    Caption = 'Bin Code';
                }
                field(blanketOrderLineNo; Rec."Blanket Order Line No.")
                {
                    Caption = 'Blanket Order Line No.';
                }
                field(blanketOrderNo; Rec."Blanket Order No.")
                {
                    Caption = 'Blanket Order No.';
                }
                field(completelyShipped; Rec."Completely Shipped")
                {
                    Caption = 'Completely Shipped';
                }
                field(copiedFromPostedDoc; Rec."Copied From Posted Doc.")
                {
                    Caption = 'Copied From Posted Doc.';
                }
                // field(crossReferenceNo; Rec."Cross-Reference No.")
                // {
                //     Caption = 'Cross-Reference No.';
                // }
                // field(crossReferenceType; Rec."Cross-Reference Type")
                // {
                //     Caption = 'Cross-Reference Type';
                // }
                // field(crossReferenceTypeNo; Rec."Cross-Reference Type No.")
                // {
                //     Caption = 'Cross-Reference Type No.';
                // }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(customerDiscGroup; Rec."Customer Disc. Group")
                {
                    Caption = 'Customer Disc. Group';
                }
                field(customerPriceGroup; Rec."Customer Price Group")
                {
                    Caption = 'Customer Price Group';
                }
                field(deferralCode; Rec."Deferral Code")
                {
                    Caption = 'Deferral Code';
                }
                field(deprUntilFAPostingDate; Rec."Depr. until FA Posting Date")
                {
                    Caption = 'Depr. until FA Posting Date';
                }
                field(depreciationBookCode; Rec."Depreciation Book Code")
                {
                    Caption = 'Depreciation Book Code';
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                }
                field(dropShipment; Rec."Drop Shipment")
                {
                    Caption = 'Drop Shipment';
                }
                field(duplicateInDepreciationBook; Rec."Duplicate in Depreciation Book")
                {
                    Caption = 'Duplicate in Depreciation Book';
                }
                field(exempted; Rec.Exempted)
                {
                    Caption = 'Exempted';
                }
                field(exitPoint; Rec."Exit Point")
                {
                    Caption = 'Exit Point';
                }
                field(faPostingDate; Rec."FA Posting Date")
                {
                    Caption = 'FA Posting Date';
                }
                field(gstAssessableValueFCY; Rec."GST Assessable Value (FCY)")
                {
                    Caption = 'GST Assessable Value (FCY)';
                }
                field(gstAssessableValueLCY; Rec."GST Assessable Value (LCY)")
                {
                    Caption = 'GST Assessable Value (LCY)';
                }
                field(gstCredit; Rec."GST Credit")
                {
                    Caption = 'GST Credit';
                }
                field(gstOnAssessableValue; Rec."GST On Assessable Value")
                {
                    Caption = 'GST On Assessable Value';
                }
                field(gstRoundingLine; Rec."GST Rounding Line")
                {
                    Caption = 'GST Rounding Line';
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group';
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group';
                }
                field(grossWeight; Rec."Gross Weight")
                {
                    Caption = 'Gross Weight';
                }
                field(icItemReferenceNo; Rec."IC Item Reference No.")
                {
                    Caption = 'IC Item Reference No.';
                }
                field(icPartnerCode; Rec."IC Partner Code")
                {
                    Caption = 'IC Partner Code';
                }
                field(icPartnerRefType; Rec."IC Partner Ref. Type")
                {
                    Caption = 'IC Partner Ref. Type';
                }
                field(icPartnerReference; Rec."IC Partner Reference")
                {
                    Caption = 'IC Partner Reference';
                }
                field(invDiscAmountToInvoice; Rec."Inv. Disc. Amount to Invoice")
                {
                    Caption = 'Inv. Disc. Amount to Invoice';
                }
                field(invDiscountAmount; Rec."Inv. Discount Amount")
                {
                    Caption = 'Inv. Discount Amount';
                }
                field(invoiceType; Rec."Invoice Type")
                {
                    Caption = 'Invoice Type';
                }
                field(itemCategoryCode; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code';
                }
                field(itemChargeQtyToHandle; Rec."Item Charge Qty. to Handle")
                {
                    Caption = 'Item Charge Qty. to Handle';
                }
                field(itemReferenceNo; Rec."Item Reference No.")
                {
                    Caption = 'Item Reference No.';
                }
                field(itemReferenceType; Rec."Item Reference Type")
                {
                    Caption = 'Item Reference Type';
                }
                field(itemReferenceTypeNo; Rec."Item Reference Type No.")
                {
                    Caption = 'Item Reference Type No.';
                }
                field(itemReferenceUnitOfMeasure; Rec."Item Reference Unit of Measure")
                {
                    Caption = 'Reference Unit of Measure';
                }
                field(jobContractEntryNo; Rec."Job Contract Entry No.")
                {
                    Caption = 'Job Contract Entry No.';
                }
                field(jobNo; Rec."Job No.")
                {
                    Caption = 'Job No.';
                }
                field(jobTaskNo; Rec."Job Task No.")
                {
                    Caption = 'Job Task No.';
                }
                field(netWeight; Rec."Net Weight")
                {
                    Caption = 'Net Weight';
                }
                field(nonGSTLine; Rec."Non-GST Line")
                {
                    Caption = 'Non-GST Line';
                }
                field(nonstock; Rec.Nonstock)
                {
                    Caption = 'Catalog';
                }
                field(originallyOrderedNo; Rec."Originally Ordered No.")
                {
                    Caption = 'Originally Ordered No.';
                }
                field(originallyOrderedVarCode; Rec."Originally Ordered Var. Code")
                {
                    Caption = 'Originally Ordered Var. Code';
                }
                field(outOfStockSubstitution; Rec."Out-of-Stock Substitution")
                {
                    Caption = 'Out-of-Stock Substitution';
                }
                field(outboundWhseHandlingTime; Rec."Outbound Whse. Handling Time")
                {
                    Caption = 'Outbound Whse. Handling Time';
                }
                field(outstandingAmount; Rec."Outstanding Amount")
                {
                    Caption = 'Outstanding Amount';
                }
                field(outstandingAmountLCY; Rec."Outstanding Amount (LCY)")
                {
                    Caption = 'Outstanding Amount (LCY)';
                }
                field(outstandingQtyBase; Rec."Outstanding Qty. (Base)")
                {
                    Caption = 'Outstanding Qty. (Base)';
                }
                field(outstandingQuantity; Rec."Outstanding Quantity")
                {
                    Caption = 'Outstanding Quantity';
                }
                field(planned; Rec.Planned)
                {
                    Caption = 'Planned';
                }
                field(plannedDeliveryDate; Rec."Planned Delivery Date")
                {
                    Caption = 'Planned Delivery Date';
                }
                field(plannedShipmentDate; Rec."Planned Shipment Date")
                {
                    Caption = 'Planned Shipment Date';
                }
                field(pmtDiscountAmount; Rec."Pmt. Discount Amount")
                {
                    Caption = 'Pmt. Discount Amount';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(postingGroup; Rec."Posting Group")
                {
                    Caption = 'Posting Group';
                }
                field(prepayment; Rec."Prepayment %")
                {
                    Caption = 'Prepayment %';
                }
                field(prepaymentAmount; Rec."Prepayment Amount")
                {
                    Caption = 'Prepayment Amount';
                }
                field(prepaymentLine; Rec."Prepayment Line")
                {
                    Caption = 'Prepayment Line';
                }
                field(prepaymentTaxAreaCode; Rec."Prepayment Tax Area Code")
                {
                    Caption = 'Prepayment Tax Area Code';
                }
                field(prepaymentTaxGroupCode; Rec."Prepayment Tax Group Code")
                {
                    Caption = 'Prepayment Tax Group Code';
                }
                field(prepaymentTaxLiable; Rec."Prepayment Tax Liable")
                {
                    Caption = 'Prepayment Tax Liable';
                }
                field(prepaymentVAT; Rec."Prepayment VAT %")
                {
                    Caption = 'Prepayment VAT %';
                }
                field(prepaymentVATDifference; Rec."Prepayment VAT Difference")
                {
                    Caption = 'Prepayment VAT Difference';
                }
                field(prepaymentVATIdentifier; Rec."Prepayment VAT Identifier")
                {
                    Caption = 'Prepayment VAT Identifier';
                }
                field(prepmtAmtDeducted; Rec."Prepmt Amt Deducted")
                {
                    Caption = 'Prepmt Amt Deducted';
                }
                field(prepmtAmtToDeduct; Rec."Prepmt Amt to Deduct")
                {
                    Caption = 'Prepmt Amt to Deduct';
                }
                field(prepmtVATDiffDeducted; Rec."Prepmt VAT Diff. Deducted")
                {
                    Caption = 'Prepmt VAT Diff. Deducted';
                }
                field(prepmtVATDiffToDeduct; Rec."Prepmt VAT Diff. to Deduct")
                {
                    Caption = 'Prepmt VAT Diff. to Deduct';
                }
                field(prepmtAmountInvLCY; Rec."Prepmt. Amount Inv. (LCY)")
                {
                    Caption = 'Prepmt. Amount Inv. (LCY)';
                }
                field(prepmtAmountInvInclVAT; Rec."Prepmt. Amount Inv. Incl. VAT")
                {
                    Caption = 'Prepmt. Amount Inv. Incl. VAT';
                }
                field(prepmtAmtInclVAT; Rec."Prepmt. Amt. Incl. VAT")
                {
                    Caption = 'Prepmt. Amt. Incl. VAT';
                }
                field(prepmtAmtInv; Rec."Prepmt. Amt. Inv.")
                {
                    Caption = 'Prepmt. Amt. Inv.';
                }
                field(prepmtLineAmount; Rec."Prepmt. Line Amount")
                {
                    Caption = 'Prepmt. Line Amount';
                }
                field(prepmtPmtDiscountAmount; Rec."Prepmt. Pmt. Discount Amount")
                {
                    Caption = 'Prepmt. Pmt. Discount Amount';
                }
                field(prepmtVATAmountInvLCY; Rec."Prepmt. VAT Amount Inv. (LCY)")
                {
                    Caption = 'Prepmt. VAT Amount Inv. (LCY)';
                }
                field(prepmtVATBaseAmt; Rec."Prepmt. VAT Base Amt.")
                {
                    Caption = 'Prepmt. VAT Base Amt.';
                }
                field(prepmtVATCalcType; Rec."Prepmt. VAT Calc. Type")
                {
                    Caption = 'Prepmt. VAT Calc. Type';
                }
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                    Caption = 'Price Calculation Method';
                }
                field(priceInclusiveOfTax; Rec."Price Inclusive of Tax")
                {
                    Caption = 'Price Inclusive of Tax';
                }
                field(profit; Rec."Profit %")
                {
                    Caption = 'Profit %';
                }
                field(promisedDeliveryDate; Rec."Promised Delivery Date")
                {
                    Caption = 'Promised Delivery Date';
                }
                field(purchOrderLineNo; Rec."Purch. Order Line No.")
                {
                    Caption = 'Purch. Order Line No.';
                }
                field(purchaseOrderNo; Rec."Purchase Order No.")
                {
                    Caption = 'Purchase Order No.';
                }
                field(purchasingCode; Rec."Purchasing Code")
                {
                    Caption = 'Purchasing Code';
                }
                field(qtyAssigned; Rec."Qty. Assigned")
                {
                    Caption = 'Qty. Assigned';
                }
                field(qtyInvoicedBase; Rec."Qty. Invoiced (Base)")
                {
                    Caption = 'Qty. Invoiced (Base)';
                }
                field(qtyRoundingPrecision; Rec."Qty. Rounding Precision")
                {
                    Caption = 'Qty. Rounding Precision';
                }
                field(qtyRoundingPrecisionBase; Rec."Qty. Rounding Precision (Base)")
                {
                    Caption = 'Qty. Rounding Precision (Base)';
                }
                field(qtyShippedBase; Rec."Qty. Shipped (Base)")
                {
                    Caption = 'Qty. Shipped (Base)';
                }
                field(qtyShippedNotInvdBase; Rec."Qty. Shipped Not Invd. (Base)")
                {
                    Caption = 'Qty. Shipped Not Invd. (Base)';
                }
                field(qtyShippedNotInvoiced; Rec."Qty. Shipped Not Invoiced")
                {
                    Caption = 'Qty. Shipped Not Invoiced';
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                    Caption = 'Qty. per Unit of Measure';
                }
                field(qtyToAsmToOrderBase; Rec."Qty. to Asm. to Order (Base)")
                {
                    Caption = 'Qty. to Asm. to Order (Base)';
                }
                field(qtyToAssembleToOrder; Rec."Qty. to Assemble to Order")
                {
                    Caption = 'Qty. to Assemble to Order';
                }
                field(qtyToAssign; Rec."Qty. to Assign")
                {
                    Caption = 'Qty. to Assign';
                }
                field(quantityBase; Rec."Quantity (Base)")
                {
                    Caption = 'Quantity (Base)';
                }
                field(quantityInvoiced; Rec."Quantity Invoiced")
                {
                    Caption = 'Quantity Invoiced';
                }
                field(quantityShipped; Rec."Quantity Shipped")
                {
                    Caption = 'Quantity Shipped';
                }
                field(recalculateInvoiceDisc; Rec."Recalculate Invoice Disc.")
                {
                    Caption = 'Recalculate Invoice Disc.';
                }
                field(requestedDeliveryDate; Rec."Requested Delivery Date")
                {
                    Caption = 'Requested Delivery Date';
                }
                field(reserve; Rec.Reserve)
                {
                    Caption = 'Reserve';
                }
                field(reservedQtyBase; Rec."Reserved Qty. (Base)")
                {
                    Caption = 'Reserved Qty. (Base)';
                }
                field(reservedQuantity; Rec."Reserved Quantity")
                {
                    Caption = 'Reserved Quantity';
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                }
                field(retQtyRcdNotInvdBase; Rec."Ret. Qty. Rcd. Not Invd.(Base)")
                {
                    Caption = 'Ret. Qty. Rcd. Not Invd.(Base)';
                }
                field(returnQtyRcdNotInvd; Rec."Return Qty. Rcd. Not Invd.")
                {
                    Caption = 'Return Qty. Rcd. Not Invd.';
                }
                field(returnQtyReceived; Rec."Return Qty. Received")
                {
                    Caption = 'Return Qty. Received';
                }
                field(returnQtyReceivedBase; Rec."Return Qty. Received (Base)")
                {
                    Caption = 'Return Qty. Received (Base)';
                }
                field(returnQtyToReceive; Rec."Return Qty. to Receive")
                {
                    Caption = 'Return Qty. to Receive';
                }
                field(returnQtyToReceiveBase; Rec."Return Qty. to Receive (Base)")
                {
                    Caption = 'Return Qty. to Receive (Base)';
                }
                field(returnRcdNotInvd; Rec."Return Rcd. Not Invd.")
                {
                    Caption = 'Return Rcd. Not Invd.';
                }
                field(returnRcdNotInvdLCY; Rec."Return Rcd. Not Invd. (LCY)")
                {
                    Caption = 'Return Rcd. Not Invd. (LCY)';
                }
                field(returnReasonCode; Rec."Return Reason Code")
                {
                    Caption = 'Return Reason Code';
                }
                field(returnReceiptLineNo; Rec."Return Receipt Line No.")
                {
                    Caption = 'Return Receipt Line No.';
                }
                field(returnReceiptNo; Rec."Return Receipt No.")
                {
                    Caption = 'Return Receipt No.';
                }
                field(returnsDeferralStartDate; Rec."Returns Deferral Start Date")
                {
                    Caption = 'Returns Deferral Start Date';
                }
                field(sellToCustomerNo; Rec."Sell-to Customer No.")
                {
                    Caption = 'Sell-to Customer No.';
                }
                field(shipmentDate; Rec."Shipment Date")
                {
                    Caption = 'Shipment Date';
                }
                field(shipmentLineNo; Rec."Shipment Line No.")
                {
                    Caption = 'Shipment Line No.';
                }
                field(shipmentNo; Rec."Shipment No.")
                {
                    Caption = 'Shipment No.';
                }
                field(shippedNotInvLCYNoVAT; Rec."Shipped Not Inv. (LCY) No VAT")
                {
                    Caption = 'Shipped Not Invoiced (LCY)';
                }
                field(shippedNotInvoiced; Rec."Shipped Not Invoiced")
                {
                    Caption = 'Shipped Not Invoiced';
                }
                field(shippedNotInvoicedLCY; Rec."Shipped Not Invoiced (LCY)")
                {
                    Caption = 'Shipped Not Invoiced (LCY) Incl. VAT';
                }
                field(shippingAgentCode; Rec."Shipping Agent Code")
                {
                    Caption = 'Shipping Agent Code';
                }
                field(shippingAgentServiceCode; Rec."Shipping Agent Service Code")
                {
                    Caption = 'Shipping Agent Service Code';
                }
                field(shippingTime; Rec."Shipping Time")
                {
                    Caption = 'Shipping Time';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field(specialOrder; Rec."Special Order")
                {
                    Caption = 'Special Order';
                }
                field(specialOrderPurchLineNo; Rec."Special Order Purch. Line No.")
                {
                    Caption = 'Special Order Purch. Line No.';
                }
                field(specialOrderPurchaseNo; Rec."Special Order Purchase No.")
                {
                    Caption = 'Special Order Purchase No.';
                }
                field(storeNo; Rec."Store No.")
                {
                    Caption = 'Store No.';
                }
                field(substitutionAvailable; Rec."Substitution Available")
                {
                    Caption = 'Substitution Available';
                }
                field(subtype; Rec.Subtype)
                {
                    Caption = 'Subtype';
                }
                field(systemCreatedEntry; Rec."System-Created Entry")
                {
                    Caption = 'System-Created Entry';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(taxAreaCode; Rec."Tax Area Code")
                {
                    Caption = 'Tax Area Code';
                }
                field(taxCategory; Rec."Tax Category")
                {
                    Caption = 'Tax Category';
                }
                field(taxGroupCode; Rec."Tax Group Code")
                {
                    Caption = 'Tax Group Code';
                }
                field(taxLiable; Rec."Tax Liable")
                {
                    Caption = 'Tax Liable';
                }
                field(totalUPITAmount; Rec."Total UPIT Amount")
                {
                    Caption = 'Total UPIT Amount';
                }
                field(transactionSpecification; Rec."Transaction Specification")
                {
                    Caption = 'Transaction Specification';
                }
                field("transactionType"; Rec."Transaction Type")
                {
                    Caption = 'Transaction Type';
                }
                field(transportMethod; Rec."Transport Method")
                {
                    Caption = 'Transport Method';
                }
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';
                }
                field(unitCostLCY; Rec."Unit Cost (LCY)")
                {
                    Caption = 'Unit Cost (LCY)';
                }
                field(unitVolume; Rec."Unit Volume")
                {
                    Caption = 'Unit Volume';
                }
                field(unitOfMeasure; Rec."Unit of Measure")
                {
                    Caption = 'Unit of Measure';
                }
                // field(unitOfMeasureCrossRef; Rec."Unit of Measure (Cross Ref.)")
                // {
                //     Caption = 'Unit of Measure (Cross Ref.)';
                // }
                field(unitsPerParcel; Rec."Units per Parcel")
                {
                    Caption = 'Units per Parcel';
                }
                field(useDuplicationList; Rec."Use Duplication List")
                {
                    Caption = 'Use Duplication List';
                }
                field(vat; Rec."VAT %")
                {
                    Caption = 'VAT %';
                }
                field(vatBaseAmount; Rec."VAT Base Amount")
                {
                    Caption = 'VAT Base Amount';
                }
                field(vatBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                    Caption = 'VAT Bus. Posting Group';
                }
                field(vatCalculationType; Rec."VAT Calculation Type")
                {
                    Caption = 'VAT Calculation Type';
                }
                field(vatClauseCode; Rec."VAT Clause Code")
                {
                    Caption = 'VAT Clause Code';
                }
                field(vatDifference; Rec."VAT Difference")
                {
                    Caption = 'VAT Difference';
                }
                field(vatIdentifier; Rec."VAT Identifier")
                {
                    Caption = 'VAT Identifier';
                }
                field(vatProdPostingGroup; Rec."VAT Prod. Posting Group")
                {
                    Caption = 'VAT Prod. Posting Group';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field(whseOutstandingQty; Rec."Whse. Outstanding Qty.")
                {
                    Caption = 'Whse. Outstanding Qty.';
                }
                field(whseOutstandingQtyBase; Rec."Whse. Outstanding Qty. (Base)")
                {
                    Caption = 'Whse. Outstanding Qty. (Base)';
                }
                field(workTypeCode; Rec."Work Type Code")
                {
                    Caption = 'Work Type Code';
                }
                field(priceDescription; Rec."Price description")
                {
                    Caption = 'Price description';
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        SalesLine: record 37;
    begin
        SalesLine.reset;
        SalesLine.SETRANGE("Document No.", Rec."Document No.");
        IF SalesLine.findlast then begin
            Rec."Document Type" := Rec."Document Type"::Order;
            Rec."Document No." := SalesLine."Document No.";
            Rec."Line No." := SalesLine."Line No." + 10000;
            rec.Insert();
            //Rec.modify;
        end
        else begin
            Rec."Document Type" := Rec."Document Type"::Order;
            Rec."Document No." := rec."Document No.";
            Rec."Line No." := 10000;
            rec.Insert();
            //Rec.modify;
        end;
    end;
}
