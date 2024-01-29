page 50804 "Serial NoMovement"
{
    PageType = Worksheet;
    ApplicationArea = All;
    Caption = 'Serial No Movement';
    SourceTable = "Item Ledger Entry";
    UsageCategory = Tasks;
    layout
    {
        area(Content)
        {
            field(Name; SerialNo)
            {
                Caption = 'Serial No';
                ApplicationArea = All;

                trigger OnValidate()
                var
                    ILE: Record 32;
                begin
                    if SerialNo <> '' then begin
                        Rec.FilterGroup(2);
                        Rec.SetRange("Serial No.", SerialNo);
                        Rec.FilterGroup(0);
                    end

                    else
                        Rec.Reset();

                    CurrPage.Update(false);
                end;

            }

            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the posting date for the entry.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    Caption = 'Entry Type';

                }

                field("Purchase Document No"; PurchaseInvoiceNo)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies  related document No  created.';

                }
                field("Sales Document No"; SalesInvoiceNo)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies  related document No  created.';

                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Description2; descr2)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = all;
                }
                field("Unit Cost"; UnitCost)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Bin Code"; BinCode)
                {
                    ApplicationArea = All;
                }
                field("Vendor No"; VendorNo)
                {
                    Caption = 'Vendor No';
                    ApplicationArea = all;
                }
                field("Vendor Name"; VendorName)
                {
                    Caption = 'Vendor Name';
                    ApplicationArea = all;
                }
                field("Customer No"; CustomerNo)
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; CustomerName)
                {
                    Caption = 'Customer Name';
                    ApplicationArea = All;
                }
                field("Vendor Invoice No"; VendorInvoiceNo)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Vendor Invoice Date"; VendorInvoiceDate)
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field(Rec; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field(Category1; Category1)
                {
                    ApplicationArea = all;
                }
                field(Category2; Category2)
                {
                    ApplicationArea = all;
                }
                field(category3; category3)
                {
                    ApplicationArea = all;
                }
                field("Document Date"; DocumentDate)
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
            }
        }

    }


    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnOpenPage()
    begin

    end;

    trigger OnAfterGetRecord()
    var

    begin
        Clear(VendorInvoiceNo);
        Clear(VendorInvoiceDate);
        Clear(UnitCost);
        valueentry.Reset();
        valueentry.SetRange("Item Ledger Entry No.", Rec."Entry No.");
        if valueentry.FindSet then
            repeat
                //DocumentType := valueentry."Document Type";
                if (valueentry."Source Type" = valueentry."Source Type"::Customer) and (valueentry."Document Type" =
                    valueentry."Document Type"::"Sales Invoice") then begin
                    CustomerNo := valueentry."Source No.";
                    if Cust.get(valueentry."Source No.") then
                        CustomerName := Cust.Name;
                    SalesInvoiceNo := valueentry."Document No.";
                    Clear(VendorNo);
                    Clear(VendorName);
                    Clear(PurchaseInvoiceNo);
                end else
                    if (valueentry."Source Type" = valueentry."Source Type"::Vendor) and (valueentry."Document Type" = valueentry."Document Type"::"Purchase Invoice") then begin

                        VendorNo := valueentry."Source No.";
                        if Vendor.get(valueentry."Source No.") then
                            VendorName := Vendor.Name;
                        PurchaseInvoiceNo := valueentry."Document No.";

                        VendorInvoiceNo := valueentry."External Document No.";
                        VendorInvoiceDate := valueentry."Document Date";
                        UnitCost := valueentry."Cost per Unit";
                        Clear(CustomerNo);
                        Clear(CustomerName);
                        Clear(SalesInvoiceNo);
                    end else
                        if (valueentry."Source Type" = valueentry."Source Type"::" ") or (valueentry."Source Type" = valueentry."Source Type"::Item) then begin
                            Clear(CustomerNo);
                            Clear(CustomerName);
                            Clear(SalesInvoiceNo);
                            Clear(VendorNo);
                            Clear(VendorName);
                            Clear(PurchaseInvoiceNo);
                        end;
            until valueentry.Next = 0;
        DocumentDate := valueentry."Document Date";
        WareEntry.Reset();
        WareEntry.SetRange("Reference No.", Rec."Document No.");
        WareEntry.SetRange("Registering Date", Rec."Posting Date");
        WareEntry.SetRange("Serial No.", SerialNo);
        if WareEntry.FindFirst then
            BinCode := WareEntry."Bin Code"
        else
            Clear(BinCode);

        if item.Get(Rec."Item No.") then;
        descr2 := item."Description 2";
        Category1 := item."Category 1";
        Category2 := item."Category 2";
        category3 := item."Category 3";

        //until valueentry.Next = 0;
        begin

        end;
    end;

    procedure OnSerialNo()
    begin
        Rec.SetRange("Serial No.", Rec."Serial No.");

    end;

    var
        myInt: Integer;
        SerialNo: Code[20];
        BinCode: Code[20];
        VendorNo: Code[20];
        VendorName: Text[100];
        CustomerNo: Code[20];
        CustomerName: Text[100];
        DocumentDate: Date;
        valueentry: Record "Value Entry";
        Vendor: Record 23;
        Cust: Record 18;

        warehouseship: Record "Warehouse Shipment Header";
        WareEntry: Record "Warehouse Entry";
        item: Record 27;
        descr2: Text[100];
        Category1: Text[50];
        Category2: Code[30];
        category3: Code[30];
        DocumentType: Enum "Item Ledger Document Type";

        PurchaseInvoiceNo: Code[20];
        SalesInvoiceNo: Code[20];
        VendorInvoiceNo: Code[50];
        VendorInvoiceDate: Date;
        UnitCost: Decimal;








}