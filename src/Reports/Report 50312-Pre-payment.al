report 50312 "Pre-Payment Sheet Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report Layout\Pre-payment -1.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Pre-Payment Sheet Report';

    dataset
    {
        dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
        {
            RequestFilterFields = "Document No.", "Posting Date";
            DataItemTableView = sorting("Document No.", "Line No.") order(ascending) where(Quantity = filter(<> 0), Type = filter('Item'));

            //DataItemLinkReference= 
            column(PIH_Orderno; Orderno)
            {

            }
            column(PIL_HSN_SAC_Code; "HSN/SAC Code")
            {

            }
            column(PIL_Document_No_; "Document No.")
            {

            }
            column(PIH_VendInvNo; VendInvNo)
            {

            }
            column(PIH_Orderdate; Orderdate)
            {

            }
            column(PIL_Posting_Date; "Posting Date")
            {

            }
            column(PIH_documentdate; documentdate)
            {

            }
            column(PIH_buyfromvenno; buyfromvenno)
            {

            }
            column(PIH_buyfromvenname; buyfromvenname)
            {

            }
            column(RecPIL_loc_Name; loc.Name)
            {

            }
            column(PIL_Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            {

            }
            column(PIL_Bin_Code; "Bin Code")
            {

            }
            column(Categorylevel_1; RecItem."Category 1")
            {

            }
            column(Categorylevel_2; RecItem."Category 2")
            {

            }
            column(Categorylevel_3; RecItem."Category 3")
            {

            }
            column(Categorylevel_4; RecItem."Category 4")
            {

            }
            column(Categorylevel_5; RecItem."Category 5")
            {

            }
            column(Categorylevel_6; RecItem."Category 6")
            {

            }
            column(PIL_Item_id; "No.")
            {

            }
            column(PIL_Item_id2; RecItem."No. 2")
            {

            }
            column(PIL_ItmeName; Description)
            {

            }
            column(PIL_Quantity; Quantity)
            {

            }
            column(PIL_Unit_of_Measure_Code; "Unit of Measure Code")
            {

            }
            column(PIL_Direct_Unit_Cost; "Direct Unit Cost")
            {

            }
            column(TotalTaxAmount; TotalGST)
            {

            }
            column(PIL_Totalbasic_Unitprice; Totalbasic)
            {

            }
            column(PIL_Discount_Amount; "Line Discount Amount")
            {

            }
            column(Unit_Cost; PUP)
            {

            }
            column(Totalpurchaseprice; Totalpurchaseprice)
            {

            }
            column(SGSTPer; SGSTPer)
            {

            }
            column(CGSTPer; CGSTPer)
            {


            }
            column(IGSTPer; IGSTPer)
            {

            }
            column(SGST; SGST)
            {

            }
            column(CGST; CGST)
            {

            }
            column(IGST; IGST)
            {

            }
            column(TDSAmt; TDSAmt)
            {

            }
            column(Dealer_price; Dealerprice)
            {

            }
            column(Total_Dealer_Price; TotalDealerPrice)
            {

            }
            column(NNLC; NNLC)
            {

            }
            column(FNNLC; FNNLC)
            {

            }
            column(Margin_percent_on_Purchase_unit_price; Margin_percent_on_Purchase_unit_price)
            {

            }
            column(Margin_percent_on_NLC; Margin_percent_on_NLC)
            {

            }
            column(Fromdate; Fromdate)
            {

            }
            column(Todate; Todate)
            {

            }
            column(TotalNLC; TotalNLC)
            {

            }
            // column(PurchUnitPrice; PurchUnitPrice)
            // {

            // }
            column(PUP; PUP)
            {

            }


            trigger OnAfterGetRecord()

            begin
                PIH.Reset();
                PIH.SetRange("No.", "Document No.");
                if PIH.FindFirst() then begin
                    //Orderno := PIH."Order No.";
                    VendInvNo := PIH."Vendor Invoice No.";
                    Orderdate := PIH."Order Date";
                    documentdate := PIH."Document Date";
                    buyfromvenno := PIH."Buy-from Vendor No.";
                    buyfromvenname := PIH."Buy-from Vendor Name";
                end;
                //Order No.
                RPIH.Reset();
                RPIH.SetRange("No.", "Document No.");
                if RPIH.FindFirst() then
                    RPPR.Reset();
                RPPR.SetRange("No.", "Receipt No.");
                if RPPR.FindFirst() then
                    if PIH."Order No." <> '' then
                        Orderno := RPIH."Order No."
                    else
                        Orderno := RPPR."Order No.";
                //if RecPIH.Get("Location Code") then;
                if loc.get("Location Code") then;
                if RecItem.Get("No.") then;


                //Calculate GST

                CGST := 0;
                IGST := 0;
                SGST := 0;
                CGSTPer := 0;
                SGSTPer := 0;
                IGSTPer := 0;
                Clear(CGST);
                Clear(IGST);
                Clear(SGST);
                Clear(TotalGST);
                DGLE.Reset();
                DGLE.SetRange("Document No.", "Document No.");
                DGLE.SetRange("Document Line No.", "Line No.");
                DGLE.SetRange(DGLE."HSN/SAC Code", "Purch. Inv. Line"."HSN/SAC Code");
                //DGLE.SetRange("No.", "No.");
                DGLE.SetRange("Transaction Type", DGLE."Transaction Type"::Purchase);
                DGLE.SetRange("Document Type", DGLE."Document Type"::Invoice);
                if DGLE.findset then begin
                    repeat
                        IF DGLE."GST Component Code" = 'SGST' THEN BEGIN
                            SGST += ABS(DGLE."GST Amount");
                            SGSTPer := DGLE."GST %";
                        END

                        ELSE
                            IF DGLE."GST Component Code" = 'CGST' THEN BEGIN
                                CGST += ABS(DGLE."GST Amount");
                                CGSTPer := DGLE."GST %";
                            END

                            ELSE
                                IF DGLE."GST Component Code" = 'IGST' THEN BEGIN
                                    IGST += ABS(DGLE."GST Amount");
                                    IGSTPer := DGLE."GST %";

                                END
                    until DGLE.Next() = 0;

                end;
                //Total Tax Amount
                TotalGST := SGST + CGST + IGST;

                //TotalBasic
                Totalbasic := "Purch. Inv. Line".Quantity * "Purch. Inv. Line"."Unit Cost";

                //Totalpurchaseprice 
                Totalpurchaseprice := (Totalbasic + TotalGST) - "Line Discount Amount";

                //TDS Amount
                TDSAmT := 0;
                Clear(TDSAmt);
                TDSEntry.Reset();
                TDSEntry.SetRange("Document No.", "Document No.");
                TDSEntry.SetRange("Posting Date", "Posting Date");

                TDSEntry.SetRange("Document Type", TDSEntry."Document Type"::Invoice);
                if TDSEntry.FindSet() then
                    repeat
                        TDSAmt += TDSEntry."TDS Amount";
                    until TDSEntry.Next = 0;

                //Trade Aggrement   
                Clear(Dealerprice);
                Clear(FNNLC);
                Clear(NNLC);
                TradeAggrement.Reset();
                TradeAggrement.SetRange("Item No.", "Purch. Inv. Line"."No.");
                TradeAggrement.SetRange("Customer Group", TradeAggrement."Customer Group"::Regular);
                //TradeAggrement.SetRange("From Date", Fromdate);
                //TradeAggrement.SetRange("To Date", Todate);
                TradeAggrement.SetFilter("From Date", '<=%1', "Posting Date");
                TradeAggrement.SetFilter("To Date", '>=%1', "Posting Date");
                if TradeAggrement.FindFirst() then begin
                    Dealerprice += TradeAggrement.DP;
                    NNLC += TradeAggrement.NNLC;
                    FNNLC += TradeAggrement.FNNLC;
                end;


                //TotalDealerPrice
                Clear(TotalDealerPrice);
                TotalDealerPrice := "Purch. Inv. Line".Quantity * Dealerprice;


                //PurchUnitPrice
                Clear(PUP);
                if "Purch. Inv. Line".Quantity <> 0 then
                    PUP := (TotalGST / Quantity) + "Unit Cost";

                // TotalNLC
                Clear(TotalNLC);
                TotalNLC := PUP * "Purch. Inv. Line".Quantity;

                //Margin percent on NLC
                if (Dealerprice <> 0) then
                    Margin_percent_on_NLC := (PUP * 100 / Dealerprice) + 100;
                //Margin percent on Purchase unit price
                if (TradeAggrement.DP <> 0) AND (Dealerprice <> 0) then
                    Margin_percent_on_Purchase_unit_price := (PUP * 100 / Dealerprice) + 100;


            end;

            trigger OnPreDataItem() //PIL

            begin


            end;

        }
        dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
        {
            RequestFilterFields = "Document No.", "Posting Date";
            DataItemTableView = sorting("Document No.", "Line No.") order(ascending) where(Quantity = filter(<> 0), Type = filter('Item'));

            //DataItemLinkReference= 
            column(PCL_Orderno; Orderno_1)
            {

            }
            column(PCL_HSN_SAC_Code; "HSN/SAC Code")
            {

            }
            column(PCL_Document_No_; "Document No.")
            {

            }
            column(PCL_VendInvNo; VendInvNo_1)
            {

            }
            column(PCL_Orderdate; Orderdate_1)
            {

            }
            column(PCL_Posting_Date; "Posting Date")
            {

            }
            column(PCL_documentdate; documentdate_1)
            {

            }
            column(PCL_buyfromvenno; buyfromvenno_1)
            {

            }
            column(PCL_buyfromvenname; buyfromvenname_1)
            {

            }
            column(PCL_loc_Name; loc_1.Name)
            {

            }
            column(PCL_Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            {

            }
            column(PCL_Bin_Code; "Bin Code")
            {

            }
            column(PCL_Categorylevel_1; RecItem_1."Category 1")
            {

            }
            column(PCL_Categorylevel_2; RecItem_1."Category 2")
            {

            }
            column(PCL_Categorylevel_3; RecItem_1."Category 3")
            {

            }
            column(PCL_Categorylevel_4; RecItem_1."Category 4")
            {

            }
            column(PCL_Categorylevel_5; RecItem_1."Category 5")
            {

            }
            column(PCL_Categorylevel_6; RecItem_1."Category 6")
            {

            }
            column(PCL_Item_id; "No.")
            {

            }
            column(PCL_ItmeName; Description)
            {

            }
            column(PCL_Quantity; Quantity)
            {

            }
            column(PCL_Unit_of_Measure_Code; "Unit of Measure Code")
            {

            }
            column(PCL_Direct_Unit_Cost; "Direct Unit Cost")
            {

            }
            column(PCL_TotalTaxAmount; TotalGST_1)
            {

            }
            column(PCL_Totalbasic_Unitprice; Totalbasic_1)
            {

            }
            column(PCL_Discount_Amount; "Line Discount Amount")
            {

            }
            column(PCL_Unit_Cost; PUP_1)
            {

            }
            column(PCL_Totalpurchaseprice; Totalpurchaseprice_1)
            {

            }
            column(PCL_SGSTPer; SGSTPer_1)
            {

            }
            column(PCL_CGSTPer; CGSTPer_1)
            {


            }
            column(PCL_IGSTPer; IGSTPer_1)
            {

            }
            column(PCL_SGST; SGST_1)
            {

            }
            column(PCL_CGST; CGST_1)
            {

            }
            column(PCL_IGST; IGST_1)
            {

            }
            column(PCL_TDSAmt; TDSAmt_1)
            {

            }
            column(PCL_Dealer_price; Dealerprice_1)
            {

            }
            column(PCL_Total_Dealer_Price; TotalDealerPrice_1)
            {

            }
            column(PCL_NNLC; NNLC_1)
            {

            }
            column(PCL_FNNLC; FNNLC_1)
            {

            }
            column(PCL_Margin_percent_on_Purchase_unit_price; Margin_percent_on_Purchase_unit_price_1)
            {

            }
            column(PCL_Margin_percent_on_NLC; Margin_percent_on_NLC_1)
            {

            }
            column(PCL_Fromdate; Fromdate_1)
            {

            }
            column(PCL_Todate; Todate_1)
            {

            }
            column(PCL_TotalNLC; TotalNLC_1)
            {

            }
            // column(PurchUnitPrice; PurchUnitPrice)
            // {

            // }
            column(PCL_PUP; PUP_1)
            {

            }


            trigger OnAfterGetRecord() //PCL

            begin
                PCH.Reset();
                PCH.SetRange("No.", "Document No.");
                if PCH.FindFirst() then begin
                    Orderno_1 := PCH."Return Order No.";
                    VendInvNo_1 := PCH."Vendor Cr. Memo No.";
                    Orderdate_1 := PCH."Due Date";
                    documentdate_1 := PCH."Document Date";
                    buyfromvenno_1 := PCH."Buy-from Vendor No.";
                    buyfromvenname_1 := PCH."Buy-from Vendor Name";
                end;


                //if RecPIH.Get("Location Code") then;
                if loc_1.get("Location Code") then;

                if RecItem_1.Get("No.") then;


                //Calculate GST

                CGST_1 := 0;
                IGST_1 := 0;
                SGST_1 := 0;
                CGSTPer_1 := 0;
                SGSTPer_1 := 0;
                IGSTPer_1 := 0;
                Clear(CGST_1);
                Clear(IGST_1);
                Clear(SGST_1);
                Clear(TotalGST_1);
                DGLE_1.Reset();
                DGLE_1.SetRange("Document No.", "Document No.");
                DGLE_1.SetRange("Document Line No.", "Line No.");
                DGLE_1.SetRange(DGLE_1."HSN/SAC Code", "Purch. Cr. Memo Line"."HSN/SAC Code");
                //DGLE.SetRange("No.", "No.");
                DGLE_1.SetRange("Transaction Type", DGLE_1."Transaction Type"::Purchase);
                DGLE_1.SetRange("Document Type", DGLE_1."Document Type"::"Credit Memo");
                if DGLE_1.findset then begin
                    repeat
                        IF DGLE_1."GST Component Code" = 'SGST' THEN BEGIN
                            SGST_1 += ABS(DGLE_1."GST Amount");
                            SGSTPer_1 := DGLE_1."GST %";
                        END

                        ELSE
                            IF DGLE_1."GST Component Code" = 'CGST' THEN BEGIN
                                CGST_1 += ABS(DGLE_1."GST Amount");
                                CGSTPer_1 := DGLE_1."GST %";
                            END

                            ELSE
                                IF DGLE_1."GST Component Code" = 'IGST' THEN BEGIN
                                    IGST_1 += ABS(DGLE_1."GST Amount");
                                    IGSTPer_1 := DGLE_1."GST %";

                                END
                    until DGLE_1.Next() = 0;

                end;
                //Total Tax Amount
                TotalGST_1 := SGST_1 + CGST_1 + IGST_1;

                //TotalBasic
                Totalbasic_1 := "Purch. Cr. Memo Line".Quantity * "Purch. Cr. Memo Line"."Unit Cost";

                //Totalpurchaseprice 
                Totalpurchaseprice_1 := (Totalbasic_1 + TotalGST_1) - "Line Discount Amount";

                //TDS Amount
                TDSAmt_1 := 0;
                Clear(TDSAmt_1);
                TDSEntry_1.Reset();
                TDSEntry_1.SetRange("Document No.", "Document No.");
                TDSEntry_1.SetRange("Posting Date", "Posting Date");
                TDSEntry_1.SetRange("Document Type", TDSEntry_1."Document Type"::"Credit Memo");
                if TDSEntry_1.FindSet() then
                    repeat
                        TDSAmt_1 += TDSEntry_1."TDS Amount";
                    until TDSEntry_1.Next = 0;

                //Trade Aggrement   
                Clear(Dealerprice_1);
                Clear(FNNLC_1);
                Clear(NNLC_1);
                TradeAggrement_1.Reset();
                TradeAggrement_1.SetRange("Item No.", "Purch. Cr. Memo Line"."No.");
                TradeAggrement_1.SetRange("Customer Group", TradeAggrement_1."Customer Group"::Regular);
                //TradeAggrement.SetRange("From Date", Fromdate);
                //TradeAggrement.SetRange("To Date", Todate);
                TradeAggrement_1.SetFilter("From Date", '<=%1', "Posting Date");
                TradeAggrement_1.SetFilter("To Date", '>=%1', "Posting Date");
                if TradeAggrement_1.FindFirst() then begin
                    Dealerprice_1 += TradeAggrement_1.DP;
                    NNLC_1 += TradeAggrement_1.NNLC;
                    FNNLC_1 += TradeAggrement_1.FNNLC;
                end;


                //TotalDealerPrice
                Clear(TotalDealerPrice_1);
                TotalDealerPrice_1 := "Purch. Cr. Memo Line".Quantity * Dealerprice_1;


                //PurchUnitPrice
                Clear(PUP_1);
                if "Purch. Cr. Memo Line".Quantity <> 0 then
                    PUP_1 := (TotalGST_1 / Quantity) + "Unit Cost";

                // TotalNLC
                Clear(TotalNLC_1);
                TotalNLC_1 := PUP_1 * "Purch. Cr. Memo Line".Quantity;

                //Margin percent on NLC
                if (Dealerprice_1 <> 0) then
                    Margin_percent_on_NLC_1 := (PUP_1 * 100 / Dealerprice_1) + 100;
                //Margin percent on Purchase unit price
                if (TradeAggrement_1.DP <> 0) AND (Dealerprice_1 <> 0) then
                    Margin_percent_on_Purchase_unit_price_1 := (PUP_1 * 100 / Dealerprice_1) + 100;

            end;
        }

    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Fromdate; Fromdate)
                    // {
                    //     ApplicationArea = All;

                    // }
                    // field(Todate; Todate)
                    // {
                    //     ApplicationArea = all;
                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    trigger OnPreReport()

    begin
        // if "Purch. Inv. Line".GetFilter("Posting Date") <> '' then;
        Fromdate_1 := "Purch. Cr. Memo Line".GetRangeMin("Posting Date");
        Todate_1 := "Purch. Cr. Memo Line".GetRangeMax("Posting Date");
    end;

    /*  rendering
     {
         layout(LayoutName)
         {
             Type = RDLC;
             LayoutFile = 'mylayout.rdl';
         }
     } */

    var
        myInt: Integer;

        RecItem: Record Item;
        ITEMNO2: Code[20];
        RPIH: Record "Purch. Inv. Header";
        RPIL: Record "Purch. Inv. Line";
        RPPR: Record "Purch. Rcpt. Header";

        PILRec: Record "Purch. Inv. Line";
        RecPIL: record "Purch. Inv. Line";
        PIH: Record "Purch. Inv. Header";

        RecPIH: Record "Purch. Inv. Header";
        PIL: Record "Purch. Inv. Line";
        Orderno: Code[20];
        VendInvNo: Code[35];
        Orderdate: Date;
        documentdate: Date;
        buyfromvenno: Code[20];
        buyfromvenname: Text[100];
        loc: Record Location;
        locname: Text[100];
        DGLE: Record "Detailed GST Ledger Entry";
        CGST: Decimal;
        IGST: Decimal;
        SGST: Decimal;
        CGSTPer: Decimal;
        SGSTPer: Decimal;
        IGSTPer: Decimal;
        TotalGST: Decimal;
        Totalbasic: Decimal;
        Totalpurchaseprice: Decimal;
        TDSAmt: Decimal;
        TDSEntry: record "TDS Entry";
        TradeAggrement: record "Trade Aggrement";
        Dealerprice: Decimal;
        TotalDealerPrice: Decimal;
        NNLC: Decimal;
        FNNLC: Decimal;
        Margin_percent_on_Purchase_unit_price: Decimal;
        Margin_percent_on_NLC: Decimal;
        Fromdate: Date;
        Todate: Date;
        String: Text;
        TotalNLC: Decimal;
        PUP: Decimal;
        PurchUnitPrice: Decimal;

        //PCL Variable
        RecItem_1: Record Item;
        PCLRec: Record "Purch. Cr. Memo Line";
        RecPCL: record "Purch. Cr. Memo Line";
        PCH: Record "Purch. Cr. Memo Hdr.";

        RecPCH: Record "Purch. Cr. Memo Hdr.";
        PCL: Record "Purch. Cr. Memo Line";
        Orderno_1: Code[20];
        VendInvNo_1: Code[35];
        Orderdate_1: Date;
        documentdate_1: Date;
        buyfromvenno_1: Code[20];
        buyfromvenname_1: Text[100];
        loc_1: Record Location;
        locname_1: Text[100];
        DGLE_1: Record "Detailed GST Ledger Entry";
        CGST_1: Decimal;
        IGST_1: Decimal;
        SGST_1: Decimal;
        CGSTPer_1: Decimal;
        SGSTPer_1: Decimal;
        IGSTPer_1: Decimal;
        TotalGST_1: Decimal;
        Totalbasic_1: Decimal;
        Totalpurchaseprice_1: Decimal;
        TDSAmt_1: Decimal;
        TDSEntry_1: record "TDS Entry";
        TradeAggrement_1: record "Trade Aggrement";
        Dealerprice_1: Decimal;
        TotalDealerPrice_1: Decimal;
        NNLC_1: Decimal;
        FNNLC_1: Decimal;
        Margin_percent_on_Purchase_unit_price_1: Decimal;
        Margin_percent_on_NLC_1: Decimal;
        Fromdate_1: Date;
        Todate_1: Date;
        String_1: Text;
        TotalNLC_1: Decimal;
        PUP_1: Decimal;
        PurchUnitPrice_1: Decimal;







}