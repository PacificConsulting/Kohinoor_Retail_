report 50322 "Order Update from Trade"
{
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    //  EnableHyperlinks = true;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = sorting("Document No.", "Line No.") where(Type = filter(Type::Item), "Document Type" = filter('Order'));
            RequestFilterFields = "Document No.", "Posting Date";
            trigger OnPreDataItem()
            begin
                //"Sales Line".SetFilter("Posting Date", '<%1', 20230914D);
            end;

            trigger OnAfterGetRecord()
            begin
                IF SalesHeder.Get("Sales Line"."Document Type"::Order, "Document No.") then;
                "Sales Line".CalcFields("Posting Date");

                IF "Sales Line".Type = "Sales Line".Type::Item then begin
                    IF recitem.Get("Sales Line"."No.") then begin
                        IF recitem.Type = recitem.Type::Inventory then begin
                            IF cust.get("Sell-to Customer No.") then;

                            TradeAggre.Reset();
                            TradeAggre.SetCurrentKey("Item No.", "From Date", "To Date", "Location Code");
                            //TradeAggre.SetRange("Customer Group", TradeAggre."Customer Group"::Regular);
                            TradeAggre.SetRange("Customer Group", Cust."Customer Group"); //New Condition Add
                            TradeAggre.SetRange("Item No.", "Sales Line"."No.");
                            //TradeAggre.SetRange("Location Code", SalesHeder."Location Code");
                            TradeAggre.SetFilter("From Date", '<=%1', "Sales Line"."Posting Date");
                            TradeAggre.SetFilter("To Date", '>=%1', "Sales Line"."Posting Date");
                            IF TradeAggre.FindFirst() then begin
                                Validate(MOP, TradeAggre.MOP);
                                validate("Last Selling Price", TradeAggre."Last Selling Price");
                                Validate(NNLC, TradeAggre.NNLC);
                                validate("PMG NLC W/O SELL OUT", TradeAggre."PMG NLC W/O SELL OUT");
                                Validate("Manager Discection", TradeAggre."Manager Discection");
                                validate("Manager Discection - INC", TradeAggre."Manager Discection - INC");
                                Validate("Sellout Text", TradeAggre."Sellout Text");
                                Validate(Sellout, TradeAggre.Sellout);
                                Validate("Sell out Text From Date", TradeAggre."Sell out Text From Date");
                                Validate("Sell out Text To Date", TradeAggre."Sell out Text To Date");
                                Validate("Fnnlc with sell out", TradeAggre."Fnnlc with sell out");
                                Validate(FNNLC, TradeAggre.FNNLC);
                                Validate("FNNLC Without SELLOUT", TradeAggre."FNNLC Without SELLOUT");
                                Validate("SLAB 1 - INC", TradeAggre."SLAB 1 - INC");
                                Validate("SLAB 2 - INC", TradeAggre."SLAB 2 - INC");
                                Validate("SLAB 1 - PRICE", TradeAggre."SLAB 1 - PRICE");
                                Validate("SLAB 2 - PRICE", TradeAggre."SLAB 2 - PRICE");
                                Validate(AMZ, TradeAggre.AMZ);
                                Validate(PROMO, TradeAggre.PROMO);
                                Validate(PRICE_TAG, TradeAggre.PRICE_TAG);
                                Validate(KTVWEB_WE, TradeAggre.KTVWEB_WE);
                                Validate(KTVWEB_WOE, TradeAggre.KTVWEB_WOE);
                                Validate("M.R.P", TradeAggre."M.R.P");
                                Validate(ALLFINANCE, TradeAggre.ALLFINANCE);
                                Validate(CASHBACK, TradeAggre.CASHBACK);
                                Validate(DP, TradeAggre.DP);
                                Validate("Actual From Date", TradeAggre."Actual From Date");
                                Validate("Actual To Date", TradeAggre."Actual To Date");
                                "Sales Line".Modify();
                            end else begin
                                TradeAggre.SetRange("Location Code");
                                IF TradeAggre.FindFirst() then begin
                                    //Validate("Unit Price Incl. of Tax", TradeAggre."Amount In INR");

                                    Validate(MOP, TradeAggre.MOP);
                                    validate("Last Selling Price", TradeAggre."Last Selling Price");
                                    Validate(NNLC, TradeAggre.NNLC);
                                    validate("PMG NLC W/O SELL OUT", TradeAggre."PMG NLC W/O SELL OUT");
                                    Validate("Manager Discection", TradeAggre."Manager Discection");
                                    validate("Manager Discection - INC", TradeAggre."Manager Discection - INC");
                                    Validate("Sellout Text", TradeAggre."Sellout Text");
                                    Validate(Sellout, TradeAggre.Sellout);
                                    Validate("Sell out Text From Date", TradeAggre."Sell out Text From Date");
                                    Validate("Sell out Text To Date", TradeAggre."Sell out Text To Date");
                                    Validate("Fnnlc with sell out", TradeAggre."Fnnlc with sell out");
                                    Validate(FNNLC, TradeAggre.FNNLC);
                                    Validate("FNNLC Without SELLOUT", TradeAggre."FNNLC Without SELLOUT");
                                    Validate("SLAB 1 - INC", TradeAggre."SLAB 1 - INC");
                                    Validate("SLAB 2 - INC", TradeAggre."SLAB 2 - INC");
                                    Validate("SLAB 1 - PRICE", TradeAggre."SLAB 1 - PRICE");
                                    Validate("SLAB 2 - PRICE", TradeAggre."SLAB 2 - PRICE");
                                    Validate(AMZ, TradeAggre.AMZ);
                                    Validate(PROMO, TradeAggre.PROMO);
                                    Validate(PRICE_TAG, TradeAggre.PRICE_TAG);
                                    Validate(KTVWEB_WE, TradeAggre.KTVWEB_WE);
                                    Validate(KTVWEB_WOE, TradeAggre.KTVWEB_WOE);
                                    Validate("M.R.P", TradeAggre."M.R.P");
                                    Validate(ALLFINANCE, TradeAggre.ALLFINANCE);
                                    Validate(CASHBACK, TradeAggre.CASHBACK);
                                    Validate(DP, TradeAggre.DP);
                                    Validate("Actual From Date", TradeAggre."Actual From Date");
                                    Validate("Actual To Date", TradeAggre."Actual To Date");
                                    "Sales Line".Modify();
                                end;
                                // end else
                                //     Error('Trade Agreement does not exist for posting date %1', SalesHeder."Posting Date");
                            end;
                        end;
                    end;
                end;
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
                    field(Name; "Sales Line"."Posting Date")
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }

        // actions
        // {
        //     area(processing)
        //     {
        //         action(ActionName)
        //         {
        //             ApplicationArea = All;

        //         }
        //     }
        // }
    }

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

    var
        myInt: Integer;
        Cust: Record Customer;
        TradeAggre: record "Trade Aggrement";
        recitem: Record Item;
        SalesHeder: Record "Sales Header";
}