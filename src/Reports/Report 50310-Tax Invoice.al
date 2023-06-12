report 50310 "Tax Invoice"
{
    //PCPL-064
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Report Layout/Tax Invoice -4.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    EnableHyperlinks = true;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Posting Date";
            column(SIH_No_; "Sales Invoice Header"."No.")
            {

            }
            column(CompName; Compinfo.Name)
            {

            }

            column(CompName2; Compinfo.Name + '' + Compinfo."Name 2")
            {

            }
            // column(CompAddress; Compinfo.Address + '' + Compinfo."Address 2" + '' + Compinfo.City + '' + Compinfo."Post Code" + '' + Compinfo."Country/Region Code")
            // {
            // }
            // column(CompPhone; Compinfo."Phone No.")
            // {

            // }
            // column(Compinfo_GSTINNo; Compinfo."Registration No.")
            // {

            // }
            column(ComPAN; Compinfo."P.A.N. No.")
            {

            }
            column(ComHomepage; Compinfo."Home Page")
            {

            }

            column(StoreAddress1; Reclocation.Address + '' + Reclocation."Address 2" + '' + Reclocation.City + ',' + Reclocation."Post Code" + ',' + 'PANNO.' + Compinfo."P.A.N. No." + ',' + Reclocation."State Code" + ',' + Reclocation."Country/Region Code")
            {

            }
            column(StoreGSTIN; Reclocation."GST Registration No.")
            {

            }
            column(Order_No_; "Order No.")
            {

            }
            column(Order_Date; "Order Date")
            {

            }
            column(Bill_to_Name; "Bill-to Name")
            {

            }
            column(Bill_to_Address; "Bill-to Address" + '' + "Bill-to Address 2" + ',' + "Bill-to City" + ',' + "Bill-to Post Code" + ',' + "Bill-to Country/Region Code")
            {

            }

            column(Bill_to_Customer_No_; "Bill-to Customer No.")
            {

            }

            column(Cust_EMail; Mail)
            {

            }
            column(Cust_PhoneNo; PhoneNo)
            {

            }
            column(ShiptoName; "Ship-to Name")
            {

            }

            column(ShiptoAdd; ShiptoAdd)
            {

            }
            column(Shiptocity; Shiptocity)
            {

            }
            column(Shipment_Date; "Shipment Date")
            {

            }
            column(Ship_to_GST_Reg__No_; "Ship-to GST Reg. No.")
            {

            }
            column(ShiptoGSTIN; ShiptoGSTIN)
            {

            }
            column(CustGSTIN; CustGSTIN)
            {

            }
            column(Salesperson_Code; "Salesperson Code")
            {

            }
            column(Notext; Notext)
            {

            }
            column(Paymentmethod; Paymentmethod)
            {

            }
            column(ReLocation; ReLocation."Payment QR")
            {

            }

            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Sales Invoice Header";

                column(SrNo; SrNo)
                {

                }
                column(Line_No_; "Line No.")
                {

                }
                column(Item_No_; "Sales Invoice Line"."No.")
                {

                }
                column(Document_No_; "Document No.")
                {

                }
                column(Description; Description)
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_Price; "Unit Price")
                {

                }
                column(Amount; Amount)
                {

                }
                column(TotalAmount; TotalAmount)
                {
                }
                column(AmountInWords1; AmountInWords1[1])
                {
                }
                column(HSNSACCode_SalesInvoiceLine; "Sales Invoice Line"."HSN/SAC Code")
                {

                }
                column(SGST; SGST)
                {

                }
                column(SGSTPer; SGSTPer)
                {

                }
                column(CGST; CGST)
                {

                }
                column(CGSTPer; CGSTPer)
                {

                }
                column(IGST; IGST)
                {

                }
                column(IGSTPer; IGSTPer)
                {

                }
                column(WithSerialNo; WithSerialNo)
                {

                }

                dataitem("Value Entry"; "Value Entry")
                {
                    DataItemLink = "Document No." = FIELD("Document No."),
                    "Document Line No." = FIELD("Line No.");
                    dataitem("Item Ledger Entry"; "Item Ledger Entry")
                    {
                        //DataItemLink = "Entry No." = FIELD();
                        DataItemLink = "Entry No." = FIELD("Item Ledger Entry No.");
                        column(Serial_No_; "Serial No.")
                        {

                        }
                    }
                }


                trigger OnAfterGetRecord() //SIL
                begin
                    SrNo += 1;
                    CGST := 0;
                    IGST := 0;
                    SGST := 0;
                    CGSTPer := 0;
                    SGSTPer := 0;
                    IGSTPer := 0;
                    Clear(CGST);
                    Clear(IGST);
                    Clear(SGST);

                    //GST Calculate
                    DGLE.Reset();
                    DGLE.SetRange("Document No.", "Document No.");
                    DGLE.SetRange("Document Line No.", "Line No.");
                    DGLE.SetRange(DGLE."HSN/SAC Code", "Sales Invoice Line"."HSN/SAC Code");
                    //DGLE.SetRange("No.", "No.");
                    DGLE.SetRange("Transaction Type", DGLE."Transaction Type"::sales);
                    DGLE.SetRange("Document Type", DGLE."Document Type"::Invoice);
                    if DGLE.findset then begin
                        repeat
                            IF DGLE."GST Component Code" = 'SGST' THEN BEGIN
                                SGST := ABS(DGLE."GST Amount");
                                SGSTPer := DGLE."GST %";
                            END

                            ELSE
                                IF DGLE."GST Component Code" = 'CGST' THEN BEGIN
                                    CGST := ABS(DGLE."GST Amount");
                                    CGSTPer := DGLE."GST %";
                                END

                                ELSE
                                    IF DGLE."GST Component Code" = 'IGST' THEN BEGIN
                                        IGST := ABS(DGLE."GST Amount");
                                        IGSTPer := DGLE."GST %";

                                    END
                        until DGLE.Next() = 0;
                    end;
                    //AoumntInWords
                    TotalAmount += Amount + SGST + CGST + IGST;
                    AmountInwords.InitTextVariable();
                    AmountInwords.FormatNoText(AmountInWords1, ROUND(TotalAmount), '');


                end;
            }
            trigger OnAfterGetRecord()  //SIH
            begin
                if RecCust.get("Sales Invoice Header"."Sell-to Customer No.") then
                    Mail := RecCust."E-Mail";
                PhoneNo := RecCust."Phone No.";
                CustGSTIN := RecCust."GST Registration No.";



                Reclocation.get("Location Code");
                //     StoreAddress := Reclocation.Address;
                // StoreAddress2 := Reclocation."Address 2";
                // StorePostCode := Reclocation."Post Code";
                // SotreCountryRegioncode:=Reclocation."Country/Region Code";
                // if RecCust.get("Ship-to Code") then
                //     ShiptoGSTIN := RecCust."GST Registration No.";

                IF "Ship-to Code" <> '' then begin
                    ShiptoName := "Ship-to Name";
                    ShiptoAdd := "Ship-to Address" + '' + "Ship-to Address 2";
                    Shiptocity := "Ship-to City" + ',' + "Ship-to Post Code" + ',' + "Ship-to Country/Region Code";
                    ShiptoGSTIN := "Ship-to GST Reg. No.";
                end
                ELSE begin
                    ShiptoName := "Bill-to Name";
                    ShiptoAdd := "Bill-to Address" + '' + "Bill-to Address 2";
                    Shiptocity := "Bill-to City" + ',' + "Bill-to Post Code" + ',' + "Bill-to Country/Region Code";
                    ShiptoGSTIN := CustGSTIN;
                end;

                if WithSerialNo = true then
                    Notext := 'Bill Of Supply'
                else
                    Notext := 'Tax Invoice';

                //PCPL-064<< 8june2023
                PostedPaymentLines.Reset();
                PostedPaymentLines.setrange("Document No.", "No.");
                //PostedPaymentLines.SetRange("Line No.", "Line No.");
                if PostedPaymentLines.findfirst() then begin
                    repeat
                        if Paymentmethod <> '' then
                            Paymentmethod := Paymentmethod + ',' + PostedPaymentLines."Payment Method Code"
                        else
                            Paymentmethod := PostedPaymentLines."Payment Method Code";
                    until PostedPaymentLines.Next = 0;
                end;

                if ReLocation.Get("Location Code") then;
                Relocation.CalcFields("Payment QR");

                //PCPL-064<< 8june2023
            end;

            trigger OnPreDataItem() //SIH
            begin

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(General)
                {
                    field(WithSerialNo; WithSerialNo)
                    {
                        Caption = 'Without Sr.No.';
                        ApplicationArea = all;
                        trigger OnValidate()
                        begin


                        end;
                    }
                    // field(WithoutSerialNo; WithoutSerialNo)
                    // {
                    //     Caption = 'Without Sr.No.';
                    // }
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

                }
            }
        }
    }
    trigger OnInitReport();
    begin
        CompInfo.GET;
        CompInfo.CALCFIELDS(Picture);
        //Reclocation.get();
    end;

    var
        myInt: Integer;
        Compinfo: record "Company Information";
        SrNo: Integer;
        recSalesInvoiceLine: Record 113;
        RecCust: Record Customer;
        Mail: Text[80];
        PhoneNo: Code[30];
        CustGSTIN: code[20];
        CGST: Decimal;
        IGST: Decimal;
        SGST: Decimal;
        CGSTPer: Decimal;
        SGSTPer: Decimal;
        IGSTPer: Decimal;
        DGLE: Record "Detailed GST Ledger Entry";
        Reclocation: Record Location;
        // StoreAddress: Text[100];
        // StoreAddress2: Text[50];
        // StorePostCode: Code[20];
        // Storecity: Text[30];
        // SotreCountryRegioncode: Code[10];
        AmountInwords: codeunit "Amount In Words";
        AmountInWords1: array[2] of Text[200];
        TotalAmount: decimal;
        ShiptoAdd: Text[100];
        ShiptoName: Text[50];
        Shiptocity: Text[20];
        ShiptoGSTIN: Code[20];
        WithSerialNo: Boolean;
        WithoutSerialNo: Boolean;
        Notext: Text[20];
        PostedPaymentLines: Record "Posted Payment Lines";
        Paymentmethod: Code[50];
        ReLocation: Record Location;

    //GLE:Record 
}