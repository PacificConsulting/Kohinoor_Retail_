report 50315 "Detailed Purchase Register"
{
    //DefaultLayout = RDLC;
    //RDLCLayout = './DetailedPurchaseRegister.rdlc';
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report Layout\DetailedPurchaseRegister.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {


        dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
        {
            RequestFilterFields = "Document No.", "Posting Date";
            DataItemTableView = WHERE(Type = FILTER(<> ' '),
                                      Quantity = FILTER(<> 0), Description = filter(<> 'Round Off'));
            column(PostingDate_PINLINES; "Purch. Inv. Line"."Posting Date")
            {
            }
            column(LineNos; "Purch. Inv. Line"."Line No.")
            {
            }
            column(Purch_InvoiceNo; PurchInvHeader."No.")
            {
            }
            column(VendorInvoiceNo; PurchInvHeader."Vendor Invoice No.")
            {
            }
            column(VendorInv_Date; PurchInvHeader."Document Date")
            {
            }
            column(DocumentNo_PINLINES; "Purch. Inv. Line"."Document No.")
            {
            }
            column(VendorName; PurchInvHeader."Buy-from Vendor Name")
            {
            }
            column(CountryName; recCR.Name)
            {
            }
            column(PurchaseName; recSP.Name)
            {
            }
            column(StateCode; Vendor."State Code")
            {
            }
            column(No_PINLINES; "Purch. Inv. Line"."No.")
            {
            }
            column(Description_PINLINES; "Purch. Inv. Line".Description)
            {
            }
            column(Quantity_PINLINES; "Purch. Inv. Line".Quantity)
            {
            }
            column(UnitCost_PINLINES; "Purch. Inv. Line"."Direct Unit Cost")
            {
            }
            column(Amount_PINLINES; "Purch. Inv. Line".Amount)
            {
            }
            column(CurrencyCode; PurchInvHeader."Currency Code")
            {
            }
            column(CurrencyRate; vCurrency)
            {
            }
            column(AmountinCurrency; vAmount)
            {
            }
            column(CGSTAmt; CGSTAmt)
            {
            }
            column(SGSTAmt; SGSTAmt)
            {
            }
            column(IGSTAmt; IGSTAmt)
            {
            }
            column(GST_PINLINES; TotGSTPer)//"Purch. Inv. Line"."GST %") //pcpl-064 01Aug2023
            {
            }
            column(GSTBaseAmount_PINLINES; DGSTLE."GST Base Amount") //pcpl-064 01Aug2023
            {
            }
            column(TotalGSTAmount_PINLINES; TotalGST)//"Purch. Inv. Line"."Total GST Amount") //pcpl-064 01Aug2023
            {
            }
            column(GenBusPostingGroup_PINLINES; "Purch. Inv. Line"."Gen. Bus. Posting Group")
            {
            }
            column(PurchaserCode; recSP.Name)
            {
            }
            column(VendorGSTIN; Vendor."GST Registration No.")
            {
            }
            column(PaymentTerms; PurchInvHeader."Payment Terms Code")
            {
            }
            column(DueDate; PurchInvHeader."Due Date")
            {
            }
            column(VendorNo_PINLINES; PurchInvHeader."Buy-from Vendor No.")
            {
            }
            column(LocationCode; PurchInvHeader."Location Code")
            {
            }
            // column(OrderNo; PurchRcptHeader."Order No.") pcpl-64 3aug2023
            // {
            // }
            column(OrderNo; OrderNo)
            {
            }
            column(UOM; "Purch. Inv. Line"."Unit of Measure Code")
            {
            }
            column(ShortcutDimension1Code; "Purch. Inv. Line"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; "Purch. Inv. Line"."Shortcut Dimension 2 Code")
            {
            }
            column(Description2; "Purch. Inv. Line"."Description 2")
            {
            }
            /*  column(GRNNo; "Purch. Inv. Line"."Receipt No.")  //pcpl-064 01Aug2023
             {
             } */
            column(GRNNo; GRNNo)  //pcpl-064 01Aug2023
            {
            }
            column(AssesseeCode; '')//"Purch. Inv. Line"."Assessee Code") //pcpl-064 01Aug2023
            {
            }
            column(TDS_TCSpercentage; TDSPer)// "Purch. Inv. Line"."TDS %") //pcpl-064 01Aug2023
            {
            }
            column(TDS_TCSAmount; TDSAmount)// "Purch. Inv. Line"."TDS Amount") //pcpl-064 01Aug2023
            {
            }
            column(HSN_SACCode; "Purch. Inv. Line"."HSN/SAC Code")
            {
            }
            column(cgstrate; cgstrate)
            {

            }
            column(sgstrate; sgstrate)
            {

            }
            column(igstrate; igstrate)
            {

            }
            column(PIL_No2; RecItem."No. 2")
            {

            }
            column(PIL_Category1; RecItem."Category 1")
            {


            }
            column(PIL_Category2; RecItem."Category 2")
            {


            }
            column(PIL_Category3; RecItem."Category 3")
            {


            }
            column(PIL_orderdate; orderdate)
            {

            }
            column(PurchInvoiceAcc; PurchInvoiceAcc)
            {

            }
            column(PIL_Bin_Code; "Bin Code")
            {

            }
            column(PIL_FNNLC; FNNLC)
            {

            }
            column(PIL_Sellout; Sellout)
            {

            }
            column(PIL_FNNLCwithSellout; FNNLCwithSellout)
            {

            }
            column(PIL_FNNLCwithoutSellout; FNNLCwithoutSellout)
            {

            }
            column(SrNo; SrNo)
            {

            }

            trigger OnAfterGetRecord()
            begin
                PurchInvHeader.RESET;
                PurchInvHeader.SETRANGE(PurchInvHeader."No.", "Purch. Inv. Line"."Document No.");
                IF PurchInvHeader.FINDFIRST THEN;
                IF PurchInvHeader."Currency Factor" <> 0 THEN
                    vCurrency := 1 / PurchInvHeader."Currency Factor"
                ELSE
                    vCurrency := 1;
                vAmount := "Purch. Inv. Line"."Line Amount" * vCurrency;

                IF Vendor.GET(PurchInvHeader."Buy-from Vendor No.") THEN;

                IF recCR.GET(Vendor."Country/Region Code") THEN;

                recSP.RESET;
                recSP.SETRANGE(recSP.Code, PurchInvHeader."Purchaser Code");
                IF recSP.FINDFIRST THEN;

                CLEAR(CGSTAmt);
                CLEAR(SGSTAmt);
                CLEAR(IGSTAmt);
                // Clear(cgstrate);
                // Clear(sgstrate);
                // Clear(igstrate);
                DGSTLE.RESET;
                DGSTLE.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Document Line No.");
                DGSTLE.SETRANGE("Transaction Type", DGSTLE."Transaction Type"::Purchase);
                DGSTLE.SETRANGE("Document No.", "Purch. Inv. Line"."Document No.");
                DGSTLE.SETRANGE("Document Line No.", "Purch. Inv. Line"."Line No.");
                IF DGSTLE.FINDSET THEN
                    REPEAT
                        IF DGSTLE."GST Component Code" = 'CGST' THEN BEGIN
                            CGSTAmt := ABS(DGSTLE."GST Amount");
                            cgstrate := ABS(DGSTLE."GST %");
                        END ELSE
                            IF (DGSTLE."GST Component Code" = 'SGST') OR (DGSTLE."GST Component Code" = 'UTGST') THEN BEGIN
                                SGSTAmt := ABS(DGSTLE."GST Amount");
                                sgstrate := ABS(DGSTLE."GST %");
                            END ELSE
                                IF DGSTLE."GST Component Code" = 'IGST' THEN BEGIN
                                    IGSTAmt := ABS(DGSTLE."GST Amount");
                                    igstrate := ABS(DGSTLE."GST %");
                                END ELSE
                                    IF DGSTLE."GST Component Code" = 'CESS' THEN BEGIN
                                        CESSGSTAmt := ABS(DGSTLE."GST Amount");
                                        //cessrate := DGSTLE."GST %";
                                    END;
                    UNTIL DGSTLE.NEXT = 0;

                PurchRcptHeader.RESET;
                PurchRcptHeader.SETRANGE(PurchRcptHeader."No.", "Purch. Inv. Line"."Receipt No.");
                IF PurchRcptHeader.FINDFIRST THEN;

                //<<pcpl-064
                TotalGST := SGSTAmt + CGSTAmt + IGSTAmt; //pcpl-064 3aug2023
                TotGSTPer := cgstrate + sgstrate + igstrate; //pcpl-064 3aug2023
                //<<pcpl-064 3aug2023
                TDSAmount := 0;
                TDSAmount := 0;
                Clear(TDSAmount);
                Clear(TDSPer);
                if documentno <> "Document No." then begin
                    TDSEntry.Reset();
                    TDSEntry.SetRange("Document No.", "Document No.");
                    TDSEntry.SetRange("Posting Date", "Posting Date");
                    TDSEntry.SetRange("Document Type", TDSEntry."Document Type"::Invoice);
                    if TDSEntry.FindSet() then
                        repeat
                            TDSAmount += TDSEntry."TDS Amount";

                            if TDSAmount <> 0 then
                                TDSPer := TDSEntry."TDS %";

                        until TDSEntry.Next = 0;

                end;
                documentno := "Document No.";


                //Order No.
                RPIH.Reset();
                RPIH.SetRange("No.", "Document No.");
                if RPIH.FindFirst() then
                    RPPR.Reset();
                RPPR.SetRange("No.", "Receipt No.");
                if RPPR.FindFirst() then
                    if RPIH."Order No." <> '' then
                        Orderno := RPIH."Order No."
                    else
                        Orderno := RPPR."Order No.";


                //>>pcpl-064 3aug2023

                //<<pcpl-064 7aug2023
                if "Purch. Inv. Line"."Receipt No." <> '' then
                    VL.Reset();
                VL.SetRange("Document No.", "Purch. Inv. Line"."Document No.");
                VL.SetRange("Document Line No.", "Purch. Inv. Line"."Line No.");
                if VL.FindFirst() then
                    ILE.Reset();
                ILE.SetRange("Entry No.", VL."Item Ledger Entry No.");
                if ILE.FindFirst() then begin
                    GRNNO := ILE."Document No.";
                end;
                //>>pcpl-064 7aug2023
                //<<pcpl-064 8aug2023
                Clear(RecItem);
                if RecItem.Get("No.") then;

                //Order Date  PCPL-064 8aug2023
                RecPIH.Reset();
                RecPIH.SetRange("No.", "Document No.");
                if RecPIH.FindFirst() then
                    RPPR.Reset();
                RPPR.SetRange("No.", "Receipt No.");
                if RPPR.FindFirst() then begin
                    orderdate := RPPR."Order Date";
                end;

                Clear(PurchInvoiceAcc);
                if "Purch. Inv. Line".Type = "Purch. Inv. Line".Type::Item then begin
                    GenPosSetup.Reset();
                    GenPosSetup.SetRange("Gen. Bus. Posting Group", "Gen. Bus. Posting Group");
                    GenPosSetup.SetRange("Gen. Prod. Posting Group", "Gen. Prod. Posting Group");
                    if GenPosSetup.FindFirst() then begin
                        PurchInvoiceAcc := GenPosSetup."Purch. Account";
                    end;
                end
                else
                    if "Purch. Inv. Line".Type = "Purch. Inv. Line".Type::"Charge (Item)" then begin
                        GenPosSetup.Reset();
                        GenPosSetup.SetRange("Gen. Bus. Posting Group", "Gen. Bus. Posting Group");
                        GenPosSetup.SetRange("Gen. Prod. Posting Group", "Gen. Prod. Posting Group");
                        if GenPosSetup.FindFirst() then begin
                            PurchInvoiceAcc := GenPosSetup."Purch. Account";
                        end;
                    end
                    else
                        if "Purch. Inv. Line".Type = "Purch. Inv. Line".Type::"G/L Account" then begin
                            PurchInvoiceAcc := "Purch. Inv. Line"."No.";
                        end;

                //>>pcpl-064 8aug2023
                //<<PCPL-064 10aug2023

                Clear(FNNLC);
                Clear(Sellout);
                Clear(FNNLCwithSellout);
                Clear(FNNLCwithoutSellout);
                TradeAggrement.Reset();
                TradeAggrement.SetRange("Item No.", "Purch. Inv. Line"."No.");
                TradeAggrement.SetRange("Customer Group", TradeAggrement."Customer Group"::Regular);
                //TradeAggrement.SetRange("From Date", Fromdate);
                //TradeAggrement.SetRange("To Date", Todate);
                TradeAggrement.SetFilter("From Date", '<=%1', "Posting Date");
                TradeAggrement.SetFilter("To Date", '>=%1', "Posting Date");
                if TradeAggrement.FindFirst() then begin
                    FNNLC += TradeAggrement.FNNLC;
                    Sellout += TradeAggrement.Sellout;
                    FNNLCwithSellout += TradeAggrement."Fnnlc with sell out";
                    FNNLCwithoutSellout += TradeAggrement."FNNLC Without SELLOUT";
                end;
                //>>pcpl-064 10aug2023
                //<<PCPL-064 11aug2023
                Clear(SrNo);
                if "Purch. Inv. Line".Type = "Purch. Inv. Line".Type::Item then begin
                    Val.Reset();
                    Val.SetRange("Document No.", "Purch. Inv. Line"."Document No.");
                    Val.SetRange("Document Line No.", "Purch. Inv. Line"."Line No.");
                    IF Val.FindSet() then
                        repeat
                            ItemLed.Reset();
                            ItemLed.SetRange("Entry No.", Val."Item Ledger Entry No.");
                            ItemLed.SetFilter("Serial No.", '<>%1', '');
                            if ItemLed.FindFirst() then
                                SrNo += ItemLed."Serial No." + ','
                        until Val.Next() = 0;
                    IF SrNo <> '' then
                        SrNo := DelStr(SrNo, StrLen(SrNo), 1);
                end;

                //>>pcpl-064 11aug2023
            end;
        }
        dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
        {
            DataItemTableView = WHERE(Type = FILTER(<> ' '),
                                      Quantity = FILTER(<> 0), Description = filter(<> 'Round Off'));
            column(PostingDate_PCINLINES; "Purch. Cr. Memo Line"."Posting Date")
            {
            }
            column(PCMLineNos; "Purch. Cr. Memo Line"."Line No.")
            {
            }
            column(Purch_CRMNo; PurchCrMemoHdr."No.")
            {
            }
            column(PCMVendorNo; PurchCrMemoHdr."Buy-from Vendor No.")
            {
            }
            column(VendorCrMemoNo; PurchCrMemoHdr."Vendor Cr. Memo No.")
            {
            }
            column(VendoCRM_Date; PurchCrMemoHdr."Document Date")
            {
            }
            column(DocumentNo_PCINLINES; "Purch. Cr. Memo Line"."Document No.")
            {
            }
            column(VendorNamePCM; PurchCrMemoHdr."Buy-from Vendor Name")
            {
            }
            column(VendorGSTINPCM; PCMVendor."GST Registration No.")
            {
            }
            column(CountryNamePCM; PCMrecCR.Name)
            {
            }
            column(No_PCINLINES; "Purch. Cr. Memo Line"."No.")
            {
            }
            column(Description_PCINLINES; "Purch. Cr. Memo Line".Description)
            {
            }
            column(Quantity_PCINLINES; "Purch. Cr. Memo Line".Quantity)
            {
            }
            column(UnitCost_PCINLINES; "Purch. Cr. Memo Line"."Direct Unit Cost")
            {
            }
            column(Amount_PCINLINES; "Purch. Cr. Memo Line".Amount)
            {
            }
            column(CurrencyCodePCM; PurchCrMemoHdr."Currency Code")
            {
            }
            column(CurrencyRatePCM; vCurrencyPCM)
            {
            }
            column(AmountinCurrencyPCM; vAmountPCM)
            {
            }
            column(PurchaseNamePCM; PCMrecSP.Name)
            {
            }
            column(StateCodePCM; PCMVendor."State Code")
            {
            }
            column(PCMCGSTAmt; PCMCGSTAmt)
            {
            }
            column(PCMSGSTAmt; PCMSGSTAmt)
            {
            }
            column(PCMIGSTAmt; PCMIGSTAmt)
            {
            }
            column(GST_PCINLINES; TotGSTPer_1)//"Purch. Cr. Memo Line"."GST %") //pcpl-064 01Aug2023
            {
            }
            column(GSTBaseAmount_PCINLINES; Abs(PCMDGSTLE."GST Base Amount"))//"Purch. Cr. Memo Line"."GST Base Amount") //pcpl-064 01Aug2023
            {
            }
            column(TotalGSTAmount_PCINLINES; TotalGST_1)//"Purch. Cr. Memo Line"."Total GST Amount") //pcpl-064 01Aug2023
            {
            }
            column(GenBusPostingGroup_PCINLINES; "Purch. Cr. Memo Line"."Gen. Bus. Posting Group")
            {
            }
            column(PurchaserCodePCM; recSP.Name)
            {
            }
            column(PaymentTermsPCM; PurchCrMemoHdr."Payment Terms Code")
            {
            }
            column(DueDatePCM; PurchCrMemoHdr."Due Date")
            {
            }
            column(VendorNo_PCINLINES; PurchCrMemoHdr."Buy-from Vendor No.")
            {
            }
            column(LocationCodePCM; PurchCrMemoHdr."Location Code")
            {
            }
            column(OrderNoPCM; ReturnShipmentHeader."Return Order No.")
            {
            }
            column(UOMPCM; "Purch. Cr. Memo Line"."Unit of Measure Code")
            {
            }
            column(ShortcutDimension1CodePCM; "Purch. Cr. Memo Line"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2CodePCM; "Purch. Cr. Memo Line"."Shortcut Dimension 2 Code")
            {
            }
            column(Description2PCM; "Purch. Cr. Memo Line"."Description 2")
            {
            }
            column(GRNNoPCM; "Purch. Cr. Memo Line"."Return Shipment No.")
            {
            }
            column(HSN_SACCodePCM; "Purch. Cr. Memo Line"."HSN/SAC Code")
            {
            }
            column(PCML_No2; RecItem_1."No. 2")
            {

            }
            column(PCML_Category1; RecItem_1."Category 1")
            {

            }
            column(PCML_Category2; RecItem_1."Category 2")
            {

            }
            column(PCML_Category3; RecItem_1."Category 3")
            {

            }
            column(PurchCreditAcc; PurchCreditAcc)
            {

            }
            column(PCML_Bin_Code; "Bin Code")
            {

            }
            column(PCML_FNNLC_1; FNNLC_1)
            {

            }
            column(PCML_Sellout_1; Sellout_1)
            {

            }
            column(PCML_FNNLCwithSellout_1; FNNLCwithSellout_1)
            {

            }
            column(PCML_FNNLCwithoutSellout_1; FNNLCwithoutSellout_1)
            {

            }
            column(SrNo_1; SrNo_1)
            {

            }

            trigger OnAfterGetRecord()
            begin

                PurchCrMemoHdr.RESET;
                PurchCrMemoHdr.SETRANGE(PurchCrMemoHdr."No.", "Purch. Cr. Memo Line"."Document No.");
                IF PurchCrMemoHdr.FINDFIRST THEN;
                IF PurchCrMemoHdr."Currency Factor" <> 0 THEN
                    vCurrencyPCM := 1 / PurchCrMemoHdr."Currency Factor";
                vAmountPCM := "Purch. Cr. Memo Line"."Line Amount" * vCurrency;

                IF PCMVendor.GET(PurchCrMemoHdr."Buy-from Vendor No.") THEN;

                IF PCMrecCR.GET(PCMVendor."Country/Region Code") THEN;

                PCMrecSP.RESET;
                PCMrecSP.SETRANGE(PCMrecSP.Code, PurchCrMemoHdr."Purchaser Code");
                IF PCMrecSP.FINDFIRST THEN;

                CLEAR(PCMCGSTAmt);
                CLEAR(PCMSGSTAmt);
                CLEAR(PCMIGSTAmt);
                PCMDGSTLE.RESET;
                PCMDGSTLE.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Document Line No.");
                PCMDGSTLE.SETRANGE("Transaction Type", DGSTLE."Transaction Type"::Purchase);
                PCMDGSTLE.SETRANGE("Document No.", "Purch. Cr. Memo Line"."Document No.");
                PCMDGSTLE.SETRANGE("Document Line No.", "Purch. Cr. Memo Line"."Line No.");
                IF PCMDGSTLE.FINDSET THEN
                    REPEAT
                        IF PCMDGSTLE."GST Component Code" = 'CGST' THEN BEGIN
                            PCMCGSTAmt := ABS(PCMDGSTLE."GST Amount");
                            cgstrate_1 := ABS(PCMDGSTLE."GST %");
                        END ELSE
                            IF (PCMDGSTLE."GST Component Code" = 'SGST') OR (PCMDGSTLE."GST Component Code" = 'UTGST') THEN BEGIN
                                PCMSGSTAmt := ABS(PCMDGSTLE."GST Amount");
                                sgstrate_1 := ABS(PCMDGSTLE."GST %");
                            END ELSE
                                IF PCMDGSTLE."GST Component Code" = 'IGST' THEN BEGIN
                                    PCMIGSTAmt := ABS(PCMDGSTLE."GST Amount");
                                    igstrate_1 := ABS(PCMDGSTLE."GST %");
                                END ELSE
                                    IF PCMDGSTLE."GST Component Code" = 'CESS' THEN BEGIN
                                        PCMCESSGSTAmt := ABS(PCMDGSTLE."GST Amount");
                                        //cessrate := PCMDGSTLE."GST %";
                                    END;
                    UNTIL PCMDGSTLE.NEXT = 0;

                ReturnShipmentHeader.RESET;
                ReturnShipmentHeader.SETRANGE(ReturnShipmentHeader."No.", "Purch. Cr. Memo Line"."Return Shipment No.");
                IF ReturnShipmentHeader.FINDFIRST THEN;
                //<<pcpl-064 8aug2023
                TotGSTPer_1 := cgstrate_1 + sgstrate_1 + igstrate_1;
                TotalGST_1 := PCMSGSTAmt + PCMCGSTAmt + PCMIGSTAmt;

                Clear(RecItem_1);
                if RecItem_1.Get("No.") then;

                //>>pcpl-064 8aug2023
                //<<pcpl-064 9aug2023
                clear(PurchCreditAcc);
                if "Purch. Cr. Memo Line".Type = "Purch. Cr. Memo Line".Type::Item then begin
                    GenPosSetup_1.Reset();
                    GenPosSetup_1.SetRange("Gen. Bus. Posting Group", "Gen. Bus. Posting Group");
                    GenPosSetup_1.SetRange("Gen. Prod. Posting Group", "Gen. Prod. Posting Group");
                    if GenPosSetup_1.FindFirst() then begin
                        PurchCreditAcc := GenPosSetup_1."Purch. Credit Memo Account";
                    end;
                end
                else
                    if "Purch. Cr. Memo Line".Type = "Purch. Cr. Memo Line".Type::"Charge (Item)" then begin
                        GenPosSetup_1.Reset();
                        GenPosSetup_1.SetRange("Gen. Bus. Posting Group", "Gen. Bus. Posting Group");
                        GenPosSetup_1.SetRange("Gen. Prod. Posting Group", "Gen. Prod. Posting Group");
                        if GenPosSetup_1.FindFirst() then begin
                            PurchCreditAcc := GenPosSetup_1."Purch. Credit Memo Account";
                        end;
                    end
                    else
                        if "Purch. Cr. Memo Line".Type = "Purch. Cr. Memo Line".Type::"G/L Account" then begin
                            PurchCreditAcc := "Purch. Cr. Memo Line"."No.";
                        end;
                //  Message('hello');
                //>>pcpl-064 9aug2023

                //<<PCPL-064 10aug2023

                Clear(FNNLC_1);
                Clear(Sellout_1);
                Clear(FNNLCwithSellout_1);
                Clear(FNNLCwithoutSellout_1);
                TradeAggrement_1.Reset();
                TradeAggrement_1.SetRange("Item No.", "Purch. Cr. Memo Line"."No.");
                TradeAggrement_1.SetRange("Customer Group", TradeAggrement."Customer Group"::Regular);
                //TradeAggrement.SetRange("From Date", Fromdate);
                //TradeAggrement.SetRange("To Date", Todate);
                TradeAggrement_1.SetFilter("From Date", '<=%1', "Posting Date");
                TradeAggrement_1.SetFilter("To Date", '>=%1', "Posting Date");
                if TradeAggrement_1.FindFirst() then begin

                    FNNLC_1 += TradeAggrement_1.FNNLC;
                    Sellout_1 += TradeAggrement_1.Sellout;
                    FNNLCwithSellout_1 += TradeAggrement_1."Fnnlc with sell out";
                    FNNLCwithoutSellout_1 += TradeAggrement_1."FNNLC Without SELLOUT";
                end;
                //>>pcpl-064 10aug2023
                //Message('done');
                //<<PCPL-064 11aug2023
                Clear(SrNo_1);
                if "Purch. Cr. Memo Line".Type = "Purch. Cr. Memo Line".Type::Item then begin
                    Val_1.Reset();
                    Val_1.SetRange("Document No.", "Purch. Cr. Memo Line"."Document No.");
                    Val_1.SetRange("Document Line No.", "Purch. Cr. Memo Line"."Line No.");
                    IF Val_1.FindSet() then
                        repeat
                            ItemLed_1.Reset();
                            ItemLed_1.SetRange("Entry No.", Val_1."Item Ledger Entry No.");
                            ItemLed_1.SetFilter("Serial No.", '<>%1', '');
                            if ItemLed_1.FindFirst() then
                                SrNo_1 += ItemLed_1."Serial No." + ','
                        until Val_1.Next() = 0;
                    IF SrNo_1 <> '' then
                        SrNo_1 := DelStr(SrNo_1, StrLen(SrNo_1), 1);
                end;

                //>>pcpl-064 11aug2023

            end;
        }


    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Orderno: Code[20];
        Sellout: Decimal;
        FNNLCwithSellout: Decimal;
        FNNLCwithoutSellout: Decimal;
        FNNLC: Decimal;
        TradeAggrement: record "Trade Aggrement";
        Sellout_1: Decimal;
        FNNLCwithSellout_1: Decimal;
        FNNLCwithoutSellout_1: Decimal;
        FNNLC_1: Decimal;
        TradeAggrement_1: record "Trade Aggrement";
        GenPosSetup: Record "General Posting Setup";
        PurchInvoiceAcc: Code[20];
        GenPosSetup_1: Record "General Posting Setup";
        PurchCreditAcc: Code[20];
        RecPCML: Record "Purch. Cr. Memo Line";
        RecPIH: Record "Purch. Inv. Header";
        orderdate: Date;
        RecItem: Record Item;
        RecItem_1: Record Item;
        TDSAMTPER: Text;
        PIL: Record "Purch. Inv. Line";
        VL: Record "Value Entry";
        ILE: Record "Item Ledger Entry";
        GRNNO: Code[20];
        RPPR: Record "Purch. Rcpt. Header";
        RPIH: Record "Purch. Inv. Header";
        documentno: Code[20];
        TDSEntry: Record "TDS Entry";
        TDSEntry_1: Record "TDS Entry";
        TDSAmount: Decimal;
        TDSPer: Decimal;

        TotGSTPer: Decimal;
        TotGSTPer_1: Decimal;
        cgstrate: Decimal;
        sgstrate: Decimal;
        igstrate: Decimal;
        cgstrate_1: Decimal;
        sgstrate_1: Decimal;
        igstrate_1: Decimal;
        TotalGST: Decimal;
        TotalGST_1: Decimal;
        recSP: Record 13;
        recCR: Record 9;
        Vendor: Record 23;
        vCurrency: Decimal;
        vAmount: Decimal;
        PCMCurrency: Decimal;
        PCMAmount: Decimal;
        PCMSP: Record 13;
        PCMVendor: Record 23;
        SCMCR: Record 9;
        // DGSTLE: Record 16419; //pcpl-064 01Aug2023
        DGSTLE: Record "Detailed GST Ledger Entry";
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        IGSTAmt: Decimal;
        CESSGSTAmt: Decimal;
        // PCMDGSTLE: Record "16419"; //pcpl-064 01Aug2023
        PCMDGSTLE: Record "Detailed GST Ledger Entry";
        PCMCGSTAmt: Decimal;
        PCMSGSTAmt: Decimal;
        PCMIGSTAmt: Decimal;
        PCMCESSGSTAmt: Decimal;
        PurchInvHeader: Record 122;
        PurchCrMemoHdr: Record 124;
        vAmountPCM: Decimal;
        vCurrencyPCM: Decimal;
        StateCodePCM: Code[10];
        StateCode: Code[10];
        PCMrecCR: Record 9;
        PCMrecSP: Record 13;
        PurchRcptHeader: Record 120;
        ReturnShipmentHeader: Record 6650;
        SrNo: Text;
        SrNo_1: Text;
        PILRec: record "Purch. Inv. Line";
        PCMLRec: Record "Purch. Cr. Memo Line";
        Val: Record "Value Entry";
        ItemLed: Record "Item Ledger Entry";
        Val_1: Record "Value Entry";
        ItemLed_1: Record "Item Ledger Entry";

}

