page 50335 "Transfer Order List"
{
    APIGroup = 'Transfer';
    APIPublisher = 'PC';
    APIVersion = 'v4.0';
    ApplicationArea = All;
    Caption = 'transferOrderList';
    DelayedInsert = true;
    EntityName = 'TransferOrderList';
    EntitySetName = 'TransferOrderLists';
    PageType = API;
    SourceTable = "Transfer Header";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("area"; Rec."Area")
                {
                    Caption = 'Area';
                }
                field(staffId; Rec."Staff Id")
                {
                    Caption = 'Staff Id';
                }
                field(assignedUserID; Rec."Assigned User ID")
                {
                    Caption = 'Assigned User ID';
                }
                field(billOfEntryDate; Rec."Bill Of Entry Date")
                {
                    Caption = 'Bill Of Entry Date';
                }
                field(billOfEntryNo; Rec."Bill Of Entry No.")
                {
                    Caption = 'Bill Of Entry No.';
                }
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                field(completelyReceived; Rec."Completely Received")
                {
                    Caption = 'Completely Received';
                }
                field(completelyShipped; Rec."Completely Shipped")
                {
                    Caption = 'Completely Shipped';
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                }
                field(directTransfer; Rec."Direct Transfer")
                {
                    Caption = 'Direct Transfer';
                }
                field(distanceKm; Rec."Distance (Km)")
                {
                    Caption = 'Distance (Km)';
                }
                field(entryExitPoint; Rec."Entry/Exit Point")
                {
                    Caption = 'Entry/Exit Point';
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(hasShippedLines; Rec."Has Shipped Lines")
                {
                    Caption = 'Has Shipped Lines';
                }
                field(inTransitCode; Rec."In-Transit Code")
                {
                    Caption = 'In-Transit Code';
                }
                field(inboundWhseHandlingTime; Rec."Inbound Whse. Handling Time")
                {
                    Caption = 'Inbound Whse. Handling Time';
                }
                field(lrRRDate; Rec."LR/RR Date")
                {
                    Caption = 'LR/RR Date';
                }
                field(lrRRNo; Rec."LR/RR No.")
                {
                    Caption = 'LR/RR No.';
                }
                field(lastReceiptNo; Rec."Last Receipt No.")
                {
                    Caption = 'Last Receipt No.';
                }
                field(lastShipmentNo; Rec."Last Shipment No.")
                {
                    Caption = 'Last Shipment No.';
                }
                field(loadUnrealProfAmtOnInvt; Rec."Load Unreal Prof Amt on Invt.")
                {
                    Caption = 'Load Unreal Prof Amt on Invt.';
                }
                field(modeOfTransport; Rec."Mode of Transport")
                {
                    Caption = 'Mode of Transport';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        NoSeries: Codeunit NoSeriesManagement;
                        InvtSetup: Record "Inventory Setup";
                    begin
                        InvtSetup.Get();
                        InvtSetup.TestField("Transfer Order Nos.");
                        Rec."No." := NoSeries.GetNextNo(InvtSetup."Transfer Order Nos.", rec."Posting Date", true);
                        Rec.Modify();
                    end;
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(outboundWhseHandlingTime; Rec."Outbound Whse. Handling Time")
                {
                    Caption = 'Outbound Whse. Handling Time';
                }
                field(partnerVATID; Rec."Partner VAT ID")
                {
                    Caption = 'Partner VAT ID';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(postingFromWhseRef; Rec."Posting from Whse. Ref.")
                {
                    Caption = 'Posting from Whse. Ref.';
                }
                field(receiptDate; Rec."Receipt Date")
                {
                    Caption = 'Receipt Date';
                }
                field(shipmentDate; Rec."Shipment Date")
                {
                    Caption = 'Shipment Date';
                }
                field(shipmentMethodCode; Rec."Shipment Method Code")
                {
                    Caption = 'Shipment Method Code';
                }
                field(shippingAdvice; Rec."Shipping Advice")
                {
                    Caption = 'Shipping Advice';
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
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(timeOfRemoval; Rec."Time of Removal")
                {
                    Caption = 'Time of Removal';
                }
                field(transactionSpecification; Rec."Transaction Specification")
                {
                    Caption = 'Transaction Specification';
                }
                field("transactionType"; Rec."Transaction Type")
                {
                    Caption = 'Transaction Type';
                }
                field(transferFromAddress; Rec."Transfer-from Address")
                {
                    Caption = 'Transfer-from Address';
                }
                field(transferFromAddress2; Rec."Transfer-from Address 2")
                {
                    Caption = 'Transfer-from Address 2';
                }
                field(transferFromCity; Rec."Transfer-from City")
                {
                    Caption = 'Transfer-from City';
                }
                field(transferFromCode; Rec."Transfer-from Code")
                {
                    Caption = 'Transfer-from Code';
                    trigger OnValidate()
                    var
                        InvtSetup: Record "Inventory Setup";
                        NoSeries: Codeunit NoSeriesManagement;
                    begin
                        InvtSetup.Get();
                        InvtSetup.TestField("Transfer Order Nos.");
                        Rec."No." := NoSeries.GetNextNo(InvtSetup."Transfer Order Nos.", rec."Posting Date", true);
                        Rec.Modify();
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        InvtSetup: Record "Inventory Setup";
                        NoSeries: Codeunit NoSeriesManagement;
                    begin
                        InvtSetup.Get();
                        InvtSetup.TestField("Transfer Order Nos.");
                        Rec."No." := NoSeries.GetNextNo(InvtSetup."Transfer Order Nos.", rec."Posting Date", true);
                        Rec.Modify();
                    end;
                }
                field(transferFromContact; Rec."Transfer-from Contact")
                {
                    Caption = 'Transfer-from Contact';
                }
                field(transferFromCounty; Rec."Transfer-from County")
                {
                    Caption = 'Transfer-from County';
                }
                field(transferFromName; Rec."Transfer-from Name")
                {
                    Caption = 'Transfer-from Name';
                }
                field(transferFromName2; Rec."Transfer-from Name 2")
                {
                    Caption = 'Transfer-from Name 2';
                }
                field(transferFromPostCode; Rec."Transfer-from Post Code")
                {
                    Caption = 'Transfer-from Post Code';
                }
                field(transferToAddress; Rec."Transfer-to Address")
                {
                    Caption = 'Transfer-to Address';
                }
                field(transferToAddress2; Rec."Transfer-to Address 2")
                {
                    Caption = 'Transfer-to Address 2';
                }
                field(transferToCity; Rec."Transfer-to City")
                {
                    Caption = 'Transfer-to City';
                }
                field(transferToCode; Rec."Transfer-to Code")
                {
                    Caption = 'Transfer-to Code';
                }
                field(transferToContact; Rec."Transfer-to Contact")
                {
                    Caption = 'Transfer-to Contact';
                }
                field(transferToCounty; Rec."Transfer-to County")
                {
                    Caption = 'Transfer-to County';
                }
                field(transferToName; Rec."Transfer-to Name")
                {
                    Caption = 'Transfer-to Name';
                }
                field(transferToName2; Rec."Transfer-to Name 2")
                {
                    Caption = 'Transfer-to Name 2';
                }
                field(transferToPostCode; Rec."Transfer-to Post Code")
                {
                    Caption = 'Transfer-to Post Code';
                }
                field(transportMethod; Rec."Transport Method")
                {
                    Caption = 'Transport Method';
                }
                field(trsfFromCountryRegionCode; Rec."Trsf.-from Country/Region Code")
                {
                    Caption = 'Trsf.-from Country/Region Code';
                }
                field(trsfToCountryRegionCode; Rec."Trsf.-to Country/Region Code")
                {
                    Caption = 'Trsf.-to Country/Region Code';
                }
                field(vehicleNo; Rec."Vehicle No.")
                {
                    Caption = 'Vehicle No.';
                }
                field(vehicleType; Rec."Vehicle Type")
                {
                    Caption = 'Vehicle Type';
                }
                field(vendorInvoiceNo; Rec."Vendor Invoice No.")
                {
                    Caption = 'Vendor Invoice No.';
                }
                field(vendorNo; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        InvtSetup: Record "Inventory Setup";
        NoSeries: Codeunit NoSeriesManagement;
    begin
        InvtSetup.Get();
        InvtSetup.TestField("Transfer Order Nos.");
        Rec."No." := NoSeries.GetNextNo(InvtSetup."Transfer Order Nos.", rec."Posting Date", true);
    end;

}
