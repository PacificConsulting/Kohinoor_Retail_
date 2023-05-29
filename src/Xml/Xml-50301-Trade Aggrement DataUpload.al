xmlport 50301 "Trade Aggrement Data Upload"
{
    Caption = 'Trade Aggrement Data Upload';
    DefaultFieldsValidation = true;
    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(TradeAggrement; "Trade Aggrement")
            {
                XmlName = 'Import';
                fieldelement(Item; TradeAggrement."Item No.")
                {
                }

                fieldelement(FromDate; TradeAggrement."From Date")
                {
                }
                fieldelement(ToDate; TradeAggrement."To Date")
                {
                }
                fieldelement(LocationCode; TradeAggrement."Location Code")
                {
                }
                fieldelement(AmountInINR; TradeAggrement."Amount In INR")
                {
                }
                fieldelement(PurchasePrice; TradeAggrement."Purchase Price")
                {
                }
                fieldelement(MRP; TradeAggrement."M.R.P")
                {
                }
                fieldelement(DP; TradeAggrement.DP)
                {
                }
                fieldelement(MOP; TradeAggrement.MOP)
                {
                }
                fieldelement(ManagerDiscection; TradeAggrement."Manager Discection")
                {
                }
                fieldelement(LastSellingPrice; TradeAggrement."Last Selling Price")
                {
                }
                fieldelement(NNLC; TradeAggrement.NNLC)
                {
                }
                fieldelement(FNNLC; TradeAggrement.FNNLC)
                {
                }
                fieldelement(Sellout; TradeAggrement.Sellout)
                {
                }
                fieldelement(SelloutText; TradeAggrement."Sellout Text")
                {
                }
                fieldelement(DetailedNNLC; TradeAggrement."Detailed NNLC")
                {
                }
                fieldelement(SLAB1PRICE; TradeAggrement."SLAB 1 - PRICE")
                {
                }
                fieldelement(SLAB1XPRICE; TradeAggrement."SLAB 1 - X-PRICE")
                {
                }
                fieldelement(SLAB2PRICE; TradeAggrement."SLAB 2 - PRICE")
                {
                }
                fieldelement(SLAB2XPRICE; TradeAggrement."SLAB 2 - X-PRICE")
                {
                }
                fieldelement(SLAB2INC; TradeAggrement."SLAB 2 - INC")
                {
                }
                fieldelement(ActualFromDate; TradeAggrement."Actual From Date")
                {
                }
                fieldelement(ALLFINANCE; TradeAggrement.ALLFINANCE)
                {
                }
                fieldelement(AMZ; TradeAggrement.AMZ)
                {
                }
                fieldelement(ActualToDate; TradeAggrement."Actual To Date")
                {
                }
                fieldelement(AmountinTransactionCurrency; TradeAggrement."Amount in Transaction Currency")
                {
                }
                fieldelement(CASHBACK; TradeAggrement.CASHBACK)
                {
                }
                fieldelement(CustomerGroup; TradeAggrement."Customer Group")
                {
                }
                fieldelement(FOCSellout; TradeAggrement."FOC/Sellout")
                {
                }
                fieldelement(Fnnlcwithsellout; TradeAggrement."Fnnlc with sell out")
                {
                }
                fieldelement(From; TradeAggrement.From)
                {
                }
                fieldelement(To; TradeAggrement."To")
                {
                }
                fieldelement(KTVWEB_WE; TradeAggrement.KTVWEB_WE)
                {
                }
                fieldelement(KTVWEB_WOE; TradeAggrement.KTVWEB_WOE)
                {
                }
                fieldelement(PRICE_TAG; TradeAggrement.PRICE_TAG)
                {
                }
                fieldelement(ManagerDiscectionINC; TradeAggrement."Manager Discection - INC")
                {
                }
                fieldelement(PROMO; TradeAggrement.PROMO)
                {
                }
                fieldelement(SLAB1INC; TradeAggrement."SLAB 1 - INC")
                {
                }

                fieldelement(UOM; TradeAggrement.UOM)
                {
                }
                trigger OnAfterInitRecord()
                begin
                    I += 1;
                    IF I = 1 THEN
                        currXMLport.SKIP;
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPostXmlPort()
    begin
        Message('Data Uploaded Successfully');
    end;

    var
        I: Integer;

}
