report 50311 "Sales Order"
{
    //PCPL-064
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report Layout\Sales Order -1.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    EnableHyperlinks = true;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Posting Date";
            column(SH_No_; "No.")
            {

            }
            column(CompName; Compinfo.Name)
            {

            }
            column(Compinfo_picture; Compinfo.Picture)
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
            // column()
            // {

            // }
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
            column(CustGSTIN; CustGSTIN)
            {

            }
            column(Salesperson_Code; "Salesperson Code")
            {

            }
            column(Notext; Notext)
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
            column(Paymentmethod; Paymentmethod)
            {

            }
            column(ReLocation; ReLocation."Payment QR")
            {

            }
            column(TotalAmount1; TotalAmount1)
            {
            }
            column(TotalGSTAmountFinal; TotalGSTAmountFinal)
            {

            }


            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Sales Header";

                column(SrNo; SrNo)
                {

                }
                column(Line_No_; "Line No.")
                {

                }
                column(Item_No_; "Sales Line"."No.")
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
                column(HSNSACCode_SalesLine; "Sales Line"."HSN/SAC Code")
                {

                }
                column(SGSTAmount; SGSTAmount)
                {

                }
                column(CGSTAmount; CGSTAmount)
                {
                }
                column(IGSTAmount; IGSTAmount)
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


                trigger OnAfterGetRecord() //SL
                begin
                    SrNo += 1;

                    //AoumntInWords
                    //TotalAmount1 += Amount + SGST + CGST + IGST;
                    AmountInwords.InitTextVariable();
                    AmountInwords.FormatNoText(AmountInWords1, ROUND(TotalAmount1), '');

                    GetGSTAmountLinewise("Sales Line", TotalGSTAmountlinewise, TotalGSTPercent);




                end;
            }
            trigger OnAfterGetRecord()  //SH
            var
                SL: Record "Sales Line";
            begin
                //PCPL-0070
                SL.Reset;
                Sl.SetRange("Document No.", "No.");
                if SL.FindSet() then
                    repeat
                        TotalGSTAmountFinal += GetGSTAmount(SL.RecordId)
                    until SL.next() = 0;

                TotalGSTAmountFinal := ROUND(TotalGSTAmountFinal, 1, '>');

                Message('%1', TotalGSTAmountFinal);
                //PCPl-0070
                if RecCust.get("Sales Header"."Sell-to Customer No.") then
                    Mail := RecCust."E-Mail";
                PhoneNo := RecCust."Phone No.";
                CustGSTIN := RecCust."GST Registration No.";

                Reclocation.get("Location Code");
                //     StoreAddress := Reclocation.Address;
                // StoreAddress2 := Reclocation."Address 2";
                // StorePostCode := Reclocation."Post Code";
                // SotreCountryRegioncode:=Reclocation."Country/Region Code";
                Customer.GET("Sales Header"."Sell-to Customer No.");
                IF "Ship-to Code" <> '' then begin
                    ShiptoName := "Ship-to Name";
                    ShiptoAdd := "Ship-to Address" + '' + "Ship-to Address 2";
                    Shiptocity := "Ship-to City" + ',' + "Ship-to Post Code" + ',' + "Ship-to Country/Region Code";
                end
                ELSE begin
                    ShiptoName := "Bill-to Name";
                    ShiptoAdd := "Bill-to Address" + '' + "Bill-to Address 2";
                    Shiptocity := "Bill-to City" + ',' + "Bill-to Post Code" + ',' + "Bill-to Country/Region Code";
                end;

                if "Pro-forma Invoice" = true then
                    Notext := 'Proforma Invoice'
                else
                    Notext := 'Sales Order';

                //GST
                //GetSalesStatisticsAmount("Sales Header", TotalGSTAmount, TotalGSTPercent);

                //PCPL-064<< 8june2023
                PaymentLines.Reset();
                PaymentLines.setrange("Document No.", "No.");
                PaymentLines.setrange("Document Type", "Sales Line"."Document Type"::Order);
                if PaymentLines.findfirst() then begin
                    repeat
                        if Paymentmethod <> '' then
                            Paymentmethod := Paymentmethod + ',' + PaymentLines."Payment Method Code"
                        else
                            Paymentmethod := PaymentLines."Payment Method Code";
                    until PaymentLines.Next = 0;

                end;

                if ReLocation.Get("Location Code") then
                    Reclocation.CalcFields("Payment QR");



                //PCPL-064<< 8june2023

                //TotalAmount
                recsalesline.RESET;
                recsalesline.SETRANGE(recsalesline."Document No.", "Sales Header"."No.");
                recsalesline.SETRANGE(Type, recsalesline.Type::Item);
                IF recsalesline.FINDSET THEN
                    REPEAT
                        TotalAmount1 += recsalesline.Amount + TotalGSTAmountFinal;

                    UNTIL recsalesline.NEXT = 0;
                Message(format(TotalAmount1));

                // //PCPL-064<<9june2023
                // IF SalesHedr.get("Sales Line"."Document Type", "Sales Line"."Document No.") then
                //     TotalGSTAmountFinal := GSTFooterTotal(SalesHedr);
                // Message(format(TotalGSTAmountFinal));
                //PCPL-064<<9june2023
            end;

            trigger OnPreDataItem() //SH
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
                    // field()
                    // {

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
        IGSTLbl: Label 'IGST';
        SGSTLbl: Label 'SGST';
        CGSTLbl: Label 'CGST';
        CESSLbl: Label 'CESS';
        GSTLbl: Label 'GST';
        GSTCESSLbl: Label 'GST CESS';
        DGLE: Record "Detailed GST Ledger Entry";
        Reclocation: Record Location;
        // StoreAddress: Text[100];
        // StoreAddress2: Text[50];
        // StorePostCode: Code[20];
        // Storecity: Text[30];
        // SotreCountryRegioncode: Code[10];
        AmountInwords: codeunit "Amount In Words";
        AmountInWords1: array[2] of Text[200];
        TotalAmount1: decimal;
        ShiptoAdd: Text[100];
        ShiptoName: Text[50];
        Shiptocity: Text[20];
        Notext: text[20];
        TotalGSTAmount: decimal;
        TotalGSTPercent: Decimal;
        ShipGSTIN: code[20];
        customer: Record Customer;
        TotalAmount: decimal;
        PaymentLines: Record "Payment Lines";
        Paymentmethod: Code[50];
        ReLocation: Record Location;
        recsalesline: record "Sales Line";
        CGSTAmount: Decimal;
        SGSTAmount: Decimal;
        IGSTAmount: Decimal;

        GSTComponentCodeName: array[20] of Code[20];

        CessAmount: Decimal;
        SalesHedr: record "Sales Header";
        TotalGSTAmountFinal: Decimal;
        TotalGSTAmountlinewise: Decimal;


    //GST calculate 
    procedure GetSalesStatisticsAmount(
SalesHeader: Record "Sales Header";
var GSTAmount: Decimal; var GSTPercent: Decimal)
    var
        SalesLine: Record "Sales Line";
    begin
        CGST := 0;
        IGST := 0;
        SGST := 0;
        CGSTPer := 0;
        SGSTPer := 0;
        IGSTPer := 0;
        Clear(CGST);
        Clear(IGST);
        Clear(SGST);
        // Clear(IGSTAmt);
        // Clear(IGSTPercent);
        // Clear(SGSTPercent);
        // Clear(CGSTPercent);

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document no.", SalesHeader."No.");
        if SalesLine.FindSet() then
            repeat
                GSTAmount += GetGSTAmount(SalesLine.RecordId());
                GSTPercent += GetGSTPercent(SalesLine.RecordId());
                TotalAmount += SalesLine."Line Amount" - SalesLine."Line Discount Amount";
                GetGSTAmounts(SalesLine);
            until SalesLine.Next() = 0;
    end;

    local procedure GetGSTAmount(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then begin
            TaxTransactionValue.CalcSums(Amount);
            TaxTransactionValue.CalcSums(Percent);
            /*  if TaxTransactionValue."Value ID" = 6 then begin
                 SGSTAmt += TaxTransactionValue.Amount;
                 SGSTPercent += TaxTransactionValue.Percent;
             end;
             if TaxTransactionValue."Value ID" = 2 then begin
                 CGSTAmt += TaxTransactionValue.Amount;
                 CGSTPercent += TaxTransactionValue.Percent;
             end;
             if TaxTransactionValue."Value ID" = 3 then begin
                 IGSTAmt += TaxTransactionValue.Amount;
                 IGSTPercent += TaxTransactionValue.Percent;
             end; */
        end;
        exit(TaxTransactionValue.Amount);
    end;

    local procedure GetGSTPercent(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            TaxTransactionValue.CalcSums(Percent);

        exit(TaxTransactionValue.Percent);
    end;

    local procedure GetGSTAmounts(Salesline: Record "Sales Line")
    var
        ComponentName: Code[30];
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        ComponentName := GetComponentName(Salesline, GSTSetup);

        if (Salesline.Type <> Salesline.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", Salesline.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    case TaxTransactionValue."Value ID" of
                        6:
                            begin
                                CGST += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                SGSTPer := TaxTransactionValue.Percent;
                            end;
                        2:
                            begin
                                SGST += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                CGSTPer := TaxTransactionValue.Percent;
                            end;
                        3:
                            begin
                                IGST += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                IGSTPer := TaxTransactionValue.Percent;
                            end;
                    end;
                until TaxTransactionValue.Next() = 0;
        end;
    end;


    local procedure GetGSTAmountsTotal(Salesline: Record "Sales Line")
    var
        ComponentName: Code[30];
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        ComponentName := GetComponentName("Sales Line", GSTSetup);

        if (SalesLine.Type <> SalesLine.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", SalesLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    case TaxTransactionValue."Value ID" of
                        6:
                            begin
                                SGSTAmount += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                SGSTPer := TaxTransactionValue.Percent;
                            end;
                        2:
                            begin
                                CGSTAmount += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                CGSTPer := TaxTransactionValue.Percent;
                            end;
                        3:
                            begin
                                IGSTAmount += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                IGSTPer := TaxTransactionValue.Percent;
                            end;
                    end;
                until TaxTransactionValue.Next() = 0;
        end;
    end;


    local procedure GetCessAmount(TaxTransactionValue: Record "Tax Transaction Value";
        SalesLine: Record "Sales Line";
        GSTSetup: Record "GST Setup")
    begin
        if (SalesLine.Type <> SalesLine.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", SalesLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."Cess Tax Type");
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    CessAmount += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(GetComponentName(SalesLine, GSTSetup)));
                until TaxTransactionValue.Next() = 0;
        end;
    end;

    local procedure GetGSTCaptions(TaxTransactionValue: Record "Tax Transaction Value";
SalesLine: Record "Sales Line";
        GSTSetup: Record "GST Setup")
    begin
        TaxTransactionValue.Reset();
        TaxTransactionValue.SetRange("Tax Record ID", SalesLine.RecordId);
        TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindSet() then
            repeat
                case TaxTransactionValue."Value ID" of
                    6:
                        GSTComponentCodeName[6] := SGSTLbl;
                    2:
                        GSTComponentCodeName[2] := CGSTLbl;
                    3:
                        GSTComponentCodeName[3] := IGSTLbl;
                end;
            until TaxTransactionValue.Next() = 0;
    end;

    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal
    var
        TaxComponent: Record "Tax Component";
        GSTSetup: Record "GST Setup";
        GSTRoundingPrecision: Decimal;
    begin
        if not GSTSetup.Get() then
            exit;
        GSTSetup.TestField("GST Tax Type");

        TaxComponent.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxComponent.SetRange(Name, ComponentName);
        TaxComponent.FindFirst();
        if TaxComponent."Rounding Precision" <> 0 then
            GSTRoundingPrecision := TaxComponent."Rounding Precision"
        else
            GSTRoundingPrecision := 1;
        exit(GSTRoundingPrecision);
    end;

    local procedure GetComponentName(SalesLine: Record "Sales Line";
        GSTSetup: Record "GST Setup"): Code[30]
    var
        ComponentName: Code[30];
    begin
        if GSTSetup."GST Tax Type" = GSTLbl then
            if SalesLine."GST Jurisdiction Type" = SalesLine."GST Jurisdiction Type"::Interstate then
                ComponentName := IGSTLbl
            else
                ComponentName := CGSTLbl
        else
            if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                ComponentName := CESSLbl;
        exit(ComponentName)
    end;

    procedure GetGSTAmountLinewise(
        SalesLine: Record "Sales Line";
        var GSTAmount: Decimal; var GSTPercent: Decimal)
    var
        PurchaseLine1: Record "Purchase Line";
    begin
        Clear(GSTAmount);
        Clear(GSTPercent);
        Clear(TotalAmount);
        Clear(CGSTAmount);
        Clear(SGSTAmount);
        Clear(IGSTAmount);
        Clear(IGSTPer);
        Clear(SGSTPer);
        Clear(CGSTPer);

        SalesLine.SetRange("Document Type", SalesLine."Document Type");
        SalesLine.SetRange("Document no.", SalesLine."Document No.");
        SalesLine.SetRange(SalesLine."Line No.", SalesLine."Line No.");
        if SalesLine.FindSet() then
            repeat
                GSTAmount += GetGSTAmount(SalesLine.RecordId());
                GSTPercent += GetGSTPercent(SalesLine.RecordId());
                TotalAmount += SalesLine."Line Amount" /*- PurchaseLine."Line Discount Amount"*/ - SalesLine."Inv. Discount Amount";//PCPL/NSW/170222
                GetGSTAmounts(SalesLine);
            until SalesLine.Next() = 0;
    end;


    procedure GSTFooterTotal(SalesHedr: Record "Sales Header"): Decimal

    var
        SalesLines: Record "Sales Line";
        GSTAmountFooter: Decimal;
    begin
        // Clear(GSTAmount);
        // Clear(GSTPercent);
        // Clear(TotalAmount);
        // Clear(CGSTAmount);
        // Clear(SGSTAmount);
        // Clear(IGSTAmount);
        // Clear(IGSTPer);
        // Clear(SGSTPer);
        // Clear(CGSTPer);

        SalesLines.SetRange("Document Type", SalesLines."Document Type");
        SalesLines.SetRange("Document no.", SalesLines."No.");
        if SalesLines.FindSet() then
            repeat
                GSTAmountFooter += GetGSTAmountFooter(SalesLines.RecordId());
            //TotalGSTAmountFinal += SGSTAmount + CGSTAmount + IGSTAmount;
            until SalesLines.Next() = 0;
        exit(GSTAmountFooter);
    end;

    local procedure GetGSTAmountFooter(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then begin
            TaxTransactionValue.CalcSums(Amount);
            TaxTransactionValue.CalcSums(Percent);

        end;


        exit(TaxTransactionValue.Amount);
    end;



}

