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
            column(IRNNo; recEInvoice."E-Invoice IRN No.")
            {

            }
            column(IRNQRCode; recEInvoice."E-Invoice QR Code")
            {

            }
            column(CommentsLine; CommentsLine)
            {

            }
            column(salesReceivablesetupIntallation; salesReceivablesetup."Installtion Details")
            {

            }

            column(CompName; Compinfo.Name)
            {

            }

            column(CompName2; Compinfo.Name + '' + Compinfo."Name 2")
            {

            }
            column(Compinfo_bankname; Compinfo."Bank Name")
            {

            }
            column(Compinfo_AccountNo; Compinfo."Bank Account No.")
            {

            }
            column(Compinfo_IFSC; Compinfo.IBAN)
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
            column(Store_name; loc.Name)
            {
            }

            column(StoreAddress1; loc.Address + ' ' + loc."Address 2" + '' + loc.City + ',' + loc."Post Code" + ',' /*+ 'PANNO.' + Compinfo."P.A.N. No." + ','*/ + loc."State Code" + ',' + loc."Country/Region Code")
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
            column(Bill_to_Address; "Bill-to Address" + ' ' + "Bill-to Address 2" + ',' + "Bill-to City" + ',' + "Bill-to Post Code" + ',' + "Bill-to Country/Region Code")
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
            // column(Salesperson_Code; "Salesperson Code")
            // {

            // }
            column(Notext; Notext)
            {

            }
            column(Paymentmethod; txt1)
            {

            }
            column(ReLocation; ReLocation."Payment QR")
            {

            }
            column(TotalPaidAmount; TotalPaidAmount)
            {

            }
            column(PaymentAmount; PaymentAmount)
            {

            }
            column(balanceamount; balanceamount)
            {

            }
            column(Financecode; txt2)
            {

            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(Salespersoncode; txt3)
            {

            }
            column(ExchangeComments; ExchangeComments)
            {

            }


            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Sales Invoice Header";
                DataItemTableView = sorting("Document No.", "Line No.") order(ascending) where(Quantity = filter(<> 0));

                column(SrNo; SrNo)
                {

                }

                column(Salesperson_Code; "Salesperson Name")
                {

                }
                column(Line_No_; "Line No.")
                {

                }
                column(Item_No_; ItemNo)
                {

                }
                column(No_; "Sales Invoice Line"."No.")
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
                column(Exchange_Comment; "Exchange Comment")
                {

                }
                column(GL_Serial_No_; "Serial No.")
                {

                }
                //column(Itemserialno; 'Serial No.' + '-' + Itemserialno)
                column(Itemserialno; Itemserialno)
                {

                }
                column(SerialCaption; SerialCaption)
                {

                }
                dataitem("Value Entry"; "Value Entry")
                {
                    DataItemLink = "Document No." = FIELD("Document No."),
                    "Document Line No." = FIELD("Line No.");
                    dataitem("Item Ledger Entry"; "Item Ledger Entry")
                    {
                        DataItemLink = "Entry No." = FIELD("Item Ledger Entry No.");
                        //column(Serial_No_; 'Serial No.' + '-' + "Serial No.")
                        column(Serial_No_; "Serial No.")
                        {

                        }
                        // column(SerialCaption; SerialCaption)
                        // {

                        // }

                    }
                }


                trigger OnAfterGetRecord() //SIL
                begin
                    Clear(SerialCaption);
                    if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then begin
                        VE.Reset();
                        VE.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                        VE.SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
                        IF VE.FindFirst() then begin
                            ILE.Reset();
                            ILE.SetRange("Entry No.", VE."Item Ledger Entry No.");
                            ILE.SetFilter("Serial No.", '<>%1', '');
                            if ILE.FindFirst() then
                                SerialCaption := 'Serial No.:'
                            else
                                SerialCaption := '';
                        end;
                    end else
                        if "Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account" then begin
                            if "Sales Invoice Line"."Serial No." <> '' then
                                SerialCaption := 'Serial No.:' + '' + "Sales Invoice Line"."Serial No."
                            else
                                SerialCaption := '';
                        end;


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
                    TotalGST := SGST + CGST + IGST;


                    //Clear(TotalAmt);
                    Clear(TotalAmount);
                    CalcSta.GetPostedSalesInvStatisticsAmount("Sales Invoice Header", TotalAmount);
                    /*
                    recSIL.Reset();
                    recSIL.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                    IF recSIL.FindFirst() then
                        repeat
                            TotalAmt += recSIL.Amount;
                        until recSIL.Next() = 0;

                    TotalAmount := TotalAmt + TotalGST;
                    */

                    //TotalAmount := Amount + SGST + CGST + IGST;
                    AmountInwords.InitTextVariable();
                    AmountInwords.FormatNoText(AmountInWords1, ROUND((TotalAmount), 1), '');

                    if Type = Type::"G/L Account" then
                        ItemNo := "Exchange Item No."
                    else
                        ItemNo := "No.";


                    // Clear(Itemserialno);
                    // if type = Type::"G/L Account" then begin
                    //     IF "Sales Invoice Line"."Serial No." <> '' then
                    //         IF "No." <> '402053' then
                    //             Itemserialno := "Sales Invoice Line"."Serial No.";
                    // end;
                end;

            }
            trigger OnAfterGetRecord()  //SIH
            begin
                salesReceivablesetup.Get();
                recEInvoice.RESET;
                recEInvoice.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                IF recEInvoice.FINDFIRST THEN
                    recEInvoice.CALCFIELDS(recEInvoice."E-Invoice QR Code");

                if RecCust.get("Sales Invoice Header"."Sell-to Customer No.") then begin
                    Mail := RecCust."E-Mail";
                    PhoneNo := RecCust."Phone No.";
                    CustGSTIN := RecCust."GST Registration No.";
                end;



                Reclocation.get("Location Code");
                if loc.get("Store No.") then;

                IF "Ship-to Code" <> '' then begin
                    ShiptoName := "Ship-to Name";
                    ShiptoAdd := "Ship-to Address" + ' ' + "Ship-to Address 2";
                    Shiptocity := "Ship-to City" + ',' + "Ship-to Post Code" + ',' + "Ship-to Country/Region Code";
                    ShiptoGSTIN := "Ship-to GST Reg. No.";
                end
                ELSE begin
                    ShiptoName := "Bill-to Name";
                    ShiptoAdd := "Bill-to Address" + ' ' + "Bill-to Address 2";
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
                if PostedPaymentLines.FindSet() then //begin
                    repeat
                        Paymentmethod += PostedPaymentLines."Payment Method Code" + ':' + format(PostedPaymentLines.Amount) + ',';
                    until PostedPaymentLines.Next = 0;
                if Paymentmethod <> '' then
                    txt1 := DelStr(paymentmethod, StrLen(Paymentmethod), 1);
                //end;

                PostedPaylines.Reset();
                PostedPaylines.SetRange("Document No.", "No.");
                if PostedPaylines.FindSet() then begin
                    repeat
                        Financecode += PostedPaylines."Approval Code" + ',';
                    until PostedPaylines.Next = 0;
                    if Financecode <> '' then
                        txt2 := DelStr(Financecode, StrLen(Financecode), 1);
                end;

                recSIL.Reset();
                recSIL.SetRange("Document No.", "No.");
                if recSIL.FindSet() then begin
                    repeat
                        IF recSIL."Salesperson Code" <> '' then
                            Salespersoncode += recSIL."Salesperson Name" + ',';
                    until recSIL.Next = 0;
                    if Salespersoncode <> '' then
                        txt3 := DelStr(Salespersoncode, StrLen(Salespersoncode), 1);
                end;



                //PaidAmount
                RecPaymentlines.Reset();
                RecPaymentlines.SetRange("Document No.", "No.");
                RecPaymentlines.SetRange("Document Type", RecPaymentlines."Document Type"::Order);
                // RecPaymentlines.SetRange("Line No.", "Line No.");
                if RecPaymentlines.FindFirst() then begin
                    repeat
                        TotalPaidAmount += RecPaymentlines.Amount;
                    until RecPaymentlines.Next = 0;
                end;


                if ReLocation.Get("Location Code") then;
                Relocation.CalcFields("Payment QR");

                //TotalAmount\

                recSalesInvLine.RESET;
                recSalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                recSalesInvLine.SETRANGE(Type, recSalesInvLine.Type::Item);
                IF recSalesInvLine.FindFirst() THEN
                    REPEAT
                    //TotalAmt += recSalesInvLine.Amount;

                    UNTIL recSalesInvLine.NEXT = 0;



                //Exhanges comments
                SalesInvLine.Reset();
                SalesInvLine.SetRange("Document No.", "No.");
                SalesInvLine.SetRange(Type, Type::"G/L Account");
                if SalesInvLine.FindFirst() then
                    repeat
                        ExchangeComments += SalesInvLine."Exchange Comment";
                    until SalesInvLine.Next = 0;


                SalesInvLine.Reset();
                SalesInvLine.SetRange("Document No.", "No.");
                SalesInvLine.SetRange(Type, Type::" ");
                if SalesInvLine.FindFirst() then
                    repeat
                        CommentsLine += SalesInvLine.Description + ',';
                    until SalesInvLine.Next() = 0;

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
        salesReceivablesetup: Record "Sales & Receivables Setup";
        SalesInvLine: Record "Sales Invoice Line";
        glserialno: Code[50];
        Itemserialno: Code[50];
        txt1: Text;
        txt2: Text;
        txt3: Text;
        txt4: Text;
        TotalGST: Decimal;
        Salespersoncode: Text[250];
        SIL: Record "Sales Invoice Line";
        recSIL: Record "Sales Invoice Line";
        TotalAmt: Decimal;
        SH: record "Sales Invoice Header";
        recSalesInvLine: Record "Sales Invoice Line";
        loc: Record Location;
        Financecode: Code[250];
        RecPaymentlines: Record "Posted Payment Lines";
        TotalPaidAmount: Decimal;
        PaymentAmount: Decimal;
        PostedPaylines: record "Posted Payment Lines";
        ItemNo: Code[20];
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
        Paymentmethod: Code[250];
        ReLocation: Record Location;
        balanceamount: Decimal;
        CalcSta: Codeunit "Calculate Statistics";
        valueentry: Record "Value Entry";
        ILE: Record "Item Ledger Entry";
        ExchangeComments: Text[250];
        CommentsLine: Text;
        recEInvoice: Record "E-Invoice Detail";
        VE: Record "Value Entry";
        SerialCaption: Text;

    //GLE:Record 
}