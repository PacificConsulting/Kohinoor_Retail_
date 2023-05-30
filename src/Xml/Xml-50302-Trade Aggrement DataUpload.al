xmlport 50302 "Trade Aggrement Data Ori"
{
    Caption = 'Trade Aggrement Data Ori';
    DefaultFieldsValidation = true;
    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy; ////

    schema
    {
        textelement(RootNodeName)
        {
            tableelement("Trade Aggrement"; "Trade Aggrement")
            {
                XmlName = 'Import';
                AutoSave = false;
                textelement(ItemNo)
                {
                }
                textelement(FromDate)
                {
                }
                textelement(AmountInINR)
                {
                }
                /*
                textelement(DP)
                {
                }
                textelement(FNNLC)
                {
                }
                textelement(LastSellPrice)
                {
                    MinOccurs = Once;
                }
                textelement(NNLC)
                {
                    MinOccurs = Once;
                }
                textelement(PurchPrice)
                {
                }
                textelement(CustomerGroup)
                {
                }
                */

                trigger OnBeforeInsertRecord()
                var
                    TDInit: Record "Trade Aggrement";
                    AMTINR: Decimal;
                    FromdateD: Date;
                    FNNLCDecim: Decimal;
                    DPDeci: Decimal;
                    LastSellDecimal: Decimal;
                    NNLCdeci: Decimal;
                    PurcpriceDecimal: Decimal;
                    Custgroup: Enum "Trade Customer Group";
                begin
                    TG.Reset();
                    TG.SetRange("Item No.", ItemNo);
                    IF TG.FindLast() then begin
                        TG.Rename(TG."Item No.", TG."From Date", Today, TG."Location Code");
                    End;
                    Evaluate(AMTINR, AmountInINR);
                    Evaluate(FromdateD, FromDate);
                    /*
                    Evaluate(FNNLCDecim, FNNLC);
                    Evaluate(DPDeci, DP);
                    Evaluate(NNLCdeci, NNLC);
                    Evaluate(LastSellDecimal, LastSellPrice);
                    Evaluate(PurcpriceDecimal, PurchPrice);
                    Evaluate(Custgroup, CustomerGroup);
                    */
                    TDInit.Init();
                    TDInit."Item No." := ItemNo;
                    TDInit."From Date" := FromdateD;
                    TDInit."To Date" := 20500101D;
                    TDInit."Location Code" := TDInit."Location Code";
                    TDInit.Insert();
                    TDInit."Amount In INR" := AMTINR;
                    /*
                    TradeAggrement.DP := DPDeci;
                    TradeAggrement.FNNLC := FNNLCDecim;
                    TradeAggrement."Last Selling Price" := LastSellDecimal;
                    TradeAggrement.NNLC := NNLCdeci;
                    TradeAggrement."Purchase Price" := PurcpriceDecimal;
                    TradeAggrement."Customer Group" := Custgroup;
                    */
                    //******Copy from Last Entry********
                    TDInit."Detailed NNLC" := TG."Detailed NNLC";
                    TDInit."M.R.P" := TG."M.R.P";
                    TDInit.MOP := TG.MOP;
                    TDInit."Manager Discection" := TG."Manager Discection";
                    TDInit."Manager Discection - INC" := TG."Manager Discection - INC";
                    TDInit."SLAB 1 - INC" := TG."SLAB 1 - INC";
                    TDInit."SLAB 1 - PRICE" := TG."SLAB 1 - PRICE";
                    TDInit."SLAB 1 - X-PRICE" := TG."SLAB 1 - X-PRICE";
                    TDInit."SLAB 2 - INC" := TG."SLAB 2 - INC";
                    TDInit."SLAB 2 - PRICE" := TG."SLAB 2 - PRICE";
                    TDInit."SLAB 2 - X-PRICE" := TG."SLAB 2 - X-PRICE";
                    TDInit.Sellout := TG.Sellout;
                    TDInit."Sellout Text" := TG."Sellout Text";
                    TDInit.ALLFINANCE := TG.ALLFINANCE;
                    TDInit.AMZ := TG.AMZ;
                    TDInit."Actual To Date" := TG."Actual To Date";
                    TDInit."Actual From Date" := TG."Actual From Date";
                    TDInit."Amount in Transaction Currency" := TG."Amount in Transaction Currency";
                    TDInit.CASHBACK := TG.CASHBACK;
                    TDInit."FOC/Sellout" := TG."FOC/Sellout";
                    TDInit.Modify();
                    //end;
                end;

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
        TG: Record "Trade Aggrement";

}