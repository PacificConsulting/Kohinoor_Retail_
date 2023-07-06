page 50310 Staffs
{
    ApplicationArea = All;
    Caption = 'Staffs';
    PageType = List;
    SourceTable = "Staff Master";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field("Store No."; Rec."Store No.")
                {
                    ToolTip = 'Specifies the value of the Store No. field.';
                }
                field("POS User ID"; Rec."POS User ID")
                {
                    ToolTip = 'Specifies the value of the POS User ID field.';
                }
                field("Customer Enquiry Access"; Rec."Customer Enquiry Access")
                {
                    ToolTip = 'Specifies the value of the Customer Enquiry Access field.';
                }
                field("Customer View"; Rec."Customer View")
                {
                    ToolTip = 'Specifies the value of the Customer View field.';
                }
                field("Direct Transfer Access"; Rec."Direct Transfer Access")
                {
                    ToolTip = 'Specifies the value of the Direct Transfer Access field.';
                }
                field("Expense Booking Access"; Rec."Expense Booking Access")
                {
                    ToolTip = 'Specifies the value of the Expense Booking Access field.';
                }
                field("Invoice List View"; Rec."Invoice List View")
                {
                    ToolTip = 'Specifies the value of the Invoice List View field.';
                }
                field("GRN Access"; Rec."GRN Access")
                {
                    ToolTip = 'Specifies the value of the GRN Access field.';
                }
                field("Item requisition Access"; Rec."Item requisition Access")
                {
                    ToolTip = 'Specifies the value of the Item requisition Access field.';
                }
                field("Sales Shipment Access"; Rec."Sales Shipment Access")
                {
                    ToolTip = 'Specifies the value of the Sales Shipment Access field.';
                }
                field("Tender Declaration Access"; Rec."Tender Declaration Access")
                {
                    ToolTip = 'Specifies the value of the Tender Declaration Access field.';
                }
                field("Transfer Receipt Access"; Rec."Transfer Receipt Access")
                {
                    ToolTip = 'Specifies the value of the Transfer Receipt Access field.';
                }
                field("Transfer Shipment Access"; Rec."Transfer Shipment Access")
                {
                    ToolTip = 'Specifies the value of the Transfer Shipment Access field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    Editable = false;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                    Editable = false;
                }
            }
        }
    }
    trigger OnModifyRecord(): Boolean
    begin
        IF US.Get(UserId) then begin
            IF not Us."Admin Access" then
                Error('You do not have access to modify the data.');
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        IF US.Get(UserId) then begin
            IF not Us."Admin Access" then
                Error('You do not have access to modify the data.');
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF US.Get(UserId) then begin
            IF not Us."Admin Access" then
                Error('You do not have access to modify the data.');
        end;
    end;

    var
        US: Record 91;
}
