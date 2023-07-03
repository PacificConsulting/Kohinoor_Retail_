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
                    Orderno := PIH."Order No.";
                    VendInvNo := PIH."Vendor Invoice No.";
                    Orderdate := PIH."Order Date";
                    documentdate := PIH."Document Date";
                    buyfromvenno := PIH."Buy-from Vendor No.";
                    buyfromvenname := PIH."Buy-from Vendor Name";

                end;
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
        Fromdate := "Purch. Inv. Line".GetRangeMin("Posting Date");
        Todate := "Purch. Inv. Line".GetRangeMax("Posting Date");
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



}