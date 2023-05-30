page 50331 "Staff Master"
{
    APIGroup = 'StaffMasterGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v19.0';
    ApplicationArea = All;
    Caption = 'staffMaster';
    DelayedInsert = true;
    EntityName = 'StaffMaster';
    EntitySetName = 'StaffMasters';
    PageType = API;
    SourceTable = "Staff Master";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'E-Mail';
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
                field(storeNo; Rec."Store No.")
                {
                    Caption = 'Store No.';
                }
                field(PosUserID; Rec."POS User ID")
                {
                    Caption = 'POS User ID';
                }
                field(customerEnquiryAccess; Rec."Customer Enquiry Access")
                {
                    Caption = 'Customer Enquiry Access';
                }
                field(directTransferAccess; Rec."Direct Transfer Access")
                {
                    Caption = 'Direct Transfer Access';
                }
                field(expenseBookingAccess; Rec."Expense Booking Access")
                {
                    Caption = 'Expense Booking Access';
                }
                field(customerView; Rec."Customer View")
                {
                    Caption = 'Customer View';
                }
                field(grnAccess; Rec."GRN Access")
                {
                    Caption = 'GRN Access';
                }
                field(invoiceListView; Rec."Invoice List View")
                {
                    Caption = 'Invoice List View';
                }
                field(itemRequisitionAccess; Rec."Item requisition Access")
                {
                    Caption = 'Item requisition Access';
                }
                field(salesShipmentAccess; Rec."Sales Shipment Access")
                {
                    Caption = 'Sales Shipment Access';
                }
                field(tenderDeclarationAccess; Rec."Tender Declaration Access")
                {
                    Caption = 'Tender Declaration Access';
                }
                field(transferReceiptAccess; Rec."Transfer Receipt Access")
                {
                    Caption = 'Transfer Receipt Access';
                }
                field(transferShipmentAccess; Rec."Transfer Shipment Access")
                {
                    Caption = 'Transfer Shipment Access';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
