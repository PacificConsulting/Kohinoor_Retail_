xmlport 50301 "Trade Agreement Data Upload"
{
    Caption = 'Trade Agreement Data Upload';
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
                textelement(CustomerGroup)
                {
                }
                textelement(ItemNo)
                {
                }
                textelement(FromDate)
                {
                }
                textelement(AmountInINR)
                {
                }
                textelement(DP)
                {
                }
                textelement(FNNLC)
                {
                }
                textelement(LastSellPrice)
                {
                }
                textelement(NNLC)
                {
                }
                textelement(PurchPrice)
                {
                }
                textelement(FNNLCWithSellout)
                {
                    MinOccurs = Zero;
                }
                textelement(FNNLCWithoutSellout)
                {
                    MinOccurs = Zero;
                }
                textelement(MRP)
                {
                    MinOccurs = Zero;
                }
                textelement(MOP)
                {
                    MinOccurs = Zero;
                }
                textelement(Sellout)
                {
                    MinOccurs = Zero;
                }
                textelement(SelloutFromDate)
                {
                    MinOccurs = Zero;
                }
                textelement(SellouttoDate)
                {
                    MinOccurs = Zero;
                }
                textelement(SelloutText)
                {
                    MinOccurs = Zero;
                }
                textelement(SelloutTextFromDate)
                {
                    MinOccurs = Zero;
                }
                textelement(SelloutTextToDate)
                {
                    MinOccurs = Zero;
                }
                textelement(SLAB1PRICE)
                {
                    MinOccurs = Zero;
                }
                textelement(SLAB1ExcPRICE)
                {
                    MinOccurs = Zero;
                }
                textelement(SLAB1INC)
                {
                    MinOccurs = Zero;
                }
                textelement(SLAB2PRICE)
                {
                    MinOccurs = Zero;
                }
                textelement(SLAB2ExcPRICE)
                {
                    MinOccurs = Zero;
                }
                textelement(SLAB2INC)
                {
                    MinOccurs = Zero;
                }
                textelement(MANAGERDISCRITION)
                {
                    MinOccurs = Zero;
                }
                textelement(MANAGERDISCRITIONINC)
                {
                    MinOccurs = Zero;
                }
                textelement(PMGNLCWOSELLOUT)
                {
                    MinOccurs = Zero;
                }
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
                    FNNLCWithSelloutDec: Decimal;
                    FNNLCWithoutSelloutDec: Decimal;
                    MRPDec: Decimal;
                    MOPDec: Decimal;
                    SelloutDec: Decimal;
                    SelloutFromDateD: Date;
                    SellouttoDateD: Date;
                    SelloutTextFromDateD: Date;
                    SelloutTextToDateD: Date;
                    SLAB1PRICEDec: Decimal;
                    SLAB1ExcPRICEDec: Decimal;
                    SLAB1INCDec: Decimal;
                    SLAB2PRICEDec: Decimal;
                    SLAB2ExcPRICEDec: Decimal;
                    SLAB2INCDec: Decimal;
                    MANAGERDISCRITIONDec: Decimal;
                    MANAGERDISCRITIONINCDec: Decimal;
                    PMGNLCWOSELLOUTDec: Decimal;
                    CustomerGroupEnum: enum "Trade Customer Group";
                begin
                    if FromDate <> '' then
                        Evaluate(FromdateD, FromDate);
                    IF CustomerGroup <> '' then
                        Evaluate(CustomerGroupEnum, CustomerGroup);
                    TG.Reset();
                    TG.SetRange("Item No.", ItemNo);
                    TG.SetRange("Customer Group", CustomerGroupEnum);
                    IF TG.FindLast() then begin
                        TG.Rename(TG."Item No.", TG."From Date", FromdateD, TG."Location Code", TG."Customer Group", TG."Amount In INR");

                        if AmountInINR <> '' then
                            Evaluate(AMTINR, AmountInINR);
                        if FromDate <> '' then
                            Evaluate(FromdateD, FromDate);
                        if FNNLC <> '' then
                            Evaluate(FNNLCDecim, FNNLC);
                        if DP <> '' then
                            Evaluate(DPDeci, DP);
                        if NNLC <> '' then
                            Evaluate(NNLCdeci, NNLC);
                        if LastSellPrice <> '' then
                            Evaluate(LastSellDecimal, LastSellPrice);
                        if PurchPrice <> '' then
                            Evaluate(PurcpriceDecimal, PurchPrice);
                        if CustomerGroup <> '' then
                            Evaluate(CustomerGroupEnum, CustomerGroup);


                        IF FNNLCWithSellout <> '' then
                            Evaluate(FNNLCWithSelloutdec, FNNLCWithSellout);
                        IF FNNLCWithoutSellout <> '' then
                            Evaluate(FNNLCWithoutSelloutDec, FNNLCWithoutSellout);
                        IF MRP <> '' then
                            Evaluate(MRPDec, MRP);
                        IF MOP <> '' then
                            Evaluate(MOPDec, MOP);
                        IF Sellout <> '' then
                            Evaluate(SelloutDec, Sellout);
                        IF SelloutFromDate <> '' then
                            Evaluate(SelloutFromDateD, SelloutFromDate);
                        IF SellouttoDate <> '' then
                            Evaluate(SellouttoDateD, SellouttoDate);
                        IF SelloutTextFromDate <> '' then
                            Evaluate(SelloutTextFromDateD, SelloutTextFromDate);
                        IF SelloutTextToDate <> '' then
                            Evaluate(SelloutTextToDateD, SelloutTextToDate);
                        IF SLAB1PRICE <> '' then
                            Evaluate(SLAB1PRICEDec, SLAB1PRICE);
                        if SLAB1ExcPRICE <> '' then
                            Evaluate(SLAB1ExcPRICEDec, SLAB1ExcPRICE);
                        IF SLAB1INC <> '' then
                            Evaluate(SLAB1INCDec, SLAB1INC);
                        IF SLAB2PRICE <> '' then
                            Evaluate(SLAB2PRICEDec, SLAB2PRICE);
                        if SLAB2ExcPRICE <> '' then
                            Evaluate(SLAB2ExcPRICEDec, SLAB2ExcPRICE);
                        IF SLAB2INC <> '' then
                            Evaluate(SLAB2INCDec, SLAB2INC);
                        IF MANAGERDISCRITION <> '' then
                            Evaluate(MANAGERDISCRITIONDec, MANAGERDISCRITION);
                        IF MANAGERDISCRITIONINC <> '' then
                            Evaluate(MANAGERDISCRITIONINCDec, MANAGERDISCRITIONINC);
                        IF PMGNLCWOSELLOUT <> '' then
                            Evaluate(PMGNLCWOSELLOUTDec, PMGNLCWOSELLOUT);



                        TDInit.Init();
                        TDInit.TransferFields(TG);
                        TDInit."Item No." := ItemNo;
                        TDInit."From Date" := FromdateD;
                        TDInit."To Date" := 21540101D;
                        TDInit."Location Code" := TDInit."Location Code";
                        TDInit."Amount In INR" := AMTINR;
                        TDInit.DP := DPDeci;
                        TDInit.FNNLC := FNNLCDecim;
                        TDInit."Last Selling Price" := LastSellDecimal;
                        TDInit.NNLC := NNLCdeci;
                        TDInit."Purchase Price" := PurcpriceDecimal;
                        TDInit."Customer Group" := CustomerGroupEnum;
                        //********New Line Modified if Value is there
                        IF FNNLCWithSellout <> '' then
                            TDInit."Fnnlc with sell out" := FNNLCWithSelloutDec;
                        IF FNNLCWithoutSellout <> '' then
                            TDInit."FNNLC Without SELLOUT" := FNNLCWithoutSelloutDec;
                        IF MRP <> '' then
                            TDInit."M.R.P" := MRPDec;
                        IF MOP <> '' then
                            TDInit.MOP := MOPDec;
                        IF Sellout <> '' then
                            TDInit.Sellout := SelloutDec;

                        IF SLAB1PRICE <> '' then
                            TDInit."SLAB 1 - PRICE" := SLAB1PRICEDec;
                        if SLAB1ExcPRICE <> '' then
                            TDInit."SLAB 1 - X-PRICE" := SLAB1ExcPRICEDec;
                        IF SLAB1INC <> '' then
                            TDInit."SLAB 1 - INC" := SLAB1INCDec;
                        IF SLAB2PRICE <> '' then
                            TDInit."SLAB 2 - PRICE" := SLAB2PRICEDec;
                        if SLAB2ExcPRICE <> '' then
                            TDInit."SLAB 2 - X-PRICE" := SLAB2ExcPRICEDec;
                        IF SLAB2INC <> '' then
                            TDInit."SLAB 2 - INC" := SLAB2INCDec;
                        IF MANAGERDISCRITION <> '' then
                            TDInit."Manager Discection" := MANAGERDISCRITIONDec;
                        IF MANAGERDISCRITIONINC <> '' then
                            TDInit."Manager Discection - INC" := MANAGERDISCRITIONINCDec;
                        IF PMGNLCWOSELLOUT <> '' then
                            TDInit."PMG NLC W/O SELL OUT" := PMGNLCWOSELLOUTDec;
                        if SelloutFromDate <> '' then
                            TDInit."Actual From Date" := SelloutFromDateD;
                        if SellouttoDate <> '' then
                            TDInit."Actual To Date" := SellouttoDateD;
                        IF SelloutTextFromDate <> '' then
                            TDInit."Sell out Text From Date" := SelloutTextFromDateD;
                        If SelloutTextToDate <> '' then
                            TDInit."Sell out Text To Date" := SelloutTextToDateD;
                        IF SelloutText <> '' then
                            TDInit."Sellout Text" := SelloutText;

                        TDInit.Insert();
                    end else begin
                        if AmountInINR <> '' then
                            Evaluate(AMTINR, AmountInINR);
                        if FromDate <> '' then
                            Evaluate(FromdateD, FromDate);
                        if FNNLC <> '' then
                            Evaluate(FNNLCDecim, FNNLC);
                        if DP <> '' then
                            Evaluate(DPDeci, DP);
                        if NNLC <> '' then
                            Evaluate(NNLCdeci, NNLC);
                        if LastSellPrice <> '' then
                            Evaluate(LastSellDecimal, LastSellPrice);
                        if PurchPrice <> '' then
                            Evaluate(PurcpriceDecimal, PurchPrice);
                        if CustomerGroup <> '' then
                            Evaluate(CustomerGroupEnum, CustomerGroup);


                        IF FNNLCWithSellout <> '' then
                            Evaluate(FNNLCWithoutSelloutdec, FNNLCWithoutSellout);
                        IF FNNLCWithoutSellout <> '' then
                            Evaluate(FNNLCWithoutSelloutDec, FNNLCWithoutSellout);
                        IF MRP <> '' then
                            Evaluate(MRPDec, MRP);
                        IF MOP <> '' then
                            Evaluate(MOPDec, MOP);
                        IF Sellout <> '' then
                            Evaluate(SelloutDec, Sellout);
                        IF SelloutFromDate <> '' then
                            Evaluate(SelloutFromDateD, SelloutFromDate);
                        IF SellouttoDate <> '' then
                            Evaluate(SellouttoDateD, SellouttoDate);
                        IF SelloutTextFromDate <> '' then
                            Evaluate(SelloutTextFromDateD, SelloutTextFromDate);
                        IF SelloutTextToDate <> '' then
                            Evaluate(SelloutTextToDateD, SelloutTextToDate);
                        IF SLAB1PRICE <> '' then
                            Evaluate(SLAB1PRICEDec, SLAB1PRICE);
                        if SLAB1ExcPRICE <> '' then
                            Evaluate(SLAB1ExcPRICEDec, SLAB1ExcPRICE);
                        IF SLAB1INC <> '' then
                            Evaluate(SLAB1INCDec, SLAB1INC);
                        IF SLAB2PRICE <> '' then
                            Evaluate(SLAB2PRICEDec, SLAB2PRICE);
                        if SLAB2ExcPRICE <> '' then
                            Evaluate(SLAB2ExcPRICEDec, SLAB2ExcPRICE);
                        IF SLAB2INC <> '' then
                            Evaluate(SLAB2INCDec, SLAB2INC);
                        IF MANAGERDISCRITION <> '' then
                            Evaluate(MANAGERDISCRITIONDec, MANAGERDISCRITION);
                        IF MANAGERDISCRITIONINC <> '' then
                            Evaluate(MANAGERDISCRITIONINCDec, MANAGERDISCRITIONINC);
                        IF PMGNLCWOSELLOUT <> '' then
                            Evaluate(PMGNLCWOSELLOUTDec, PMGNLCWOSELLOUT);



                        TDInit.Init();
                        TDInit."Item No." := ItemNo;
                        TDInit."From Date" := FromdateD;
                        TDInit."To Date" := 21540101D;
                        TDInit."Location Code" := TDInit."Location Code";
                        TDInit."Amount In INR" := AMTINR;
                        TDInit.DP := DPDeci;
                        TDInit.FNNLC := FNNLCDecim;
                        TDInit."Last Selling Price" := LastSellDecimal;
                        TDInit.NNLC := NNLCdeci;
                        TDInit."Purchase Price" := PurcpriceDecimal;
                        TDInit."Customer Group" := CustomerGroupEnum;
                        //********New Line Modified if Value is there
                        IF FNNLCWithSellout <> '' then
                            TDInit."Fnnlc with sell out" := FNNLCWithSelloutDec;
                        IF FNNLCWithoutSellout <> '' then
                            TDInit."FNNLC Without SELLOUT" := FNNLCWithoutSelloutDec;
                        IF MRP <> '' then
                            TDInit."M.R.P" := MRPDec;
                        IF MOP <> '' then
                            TDInit.MOP := MOPDec;
                        IF Sellout <> '' then
                            TDInit.Sellout := SelloutDec;

                        IF SLAB1PRICE <> '' then
                            TDInit."SLAB 1 - PRICE" := SLAB1PRICEDec;
                        if SLAB1ExcPRICE <> '' then
                            TDInit."SLAB 1 - X-PRICE" := SLAB1ExcPRICEDec;
                        IF SLAB1INC <> '' then
                            TDInit."SLAB 1 - INC" := SLAB1INCDec;
                        IF SLAB2PRICE <> '' then
                            TDInit."SLAB 2 - PRICE" := SLAB2PRICEDec;
                        if SLAB2ExcPRICE <> '' then
                            TDInit."SLAB 2 - X-PRICE" := SLAB2ExcPRICEDec;
                        IF SLAB2INC <> '' then
                            TDInit."SLAB 2 - INC" := SLAB2INCDec;
                        IF MANAGERDISCRITION <> '' then
                            TDInit."Manager Discection" := MANAGERDISCRITIONDec;
                        IF MANAGERDISCRITIONINC <> '' then
                            TDInit."Manager Discection - INC" := MANAGERDISCRITIONINCDec;
                        IF PMGNLCWOSELLOUT <> '' then
                            TDInit."PMG NLC W/O SELL OUT" := PMGNLCWOSELLOUTDec;
                        if SelloutFromDate <> '' then
                            TDInit."Actual From Date" := SelloutFromDateD;
                        if SellouttoDate <> '' then
                            TDInit."Actual To Date" := SellouttoDateD;
                        IF SelloutTextFromDate <> '' then
                            TDInit."Sell out Text From Date" := SelloutTextFromDateD;
                        If SelloutTextToDate <> '' then
                            TDInit."Sell out Text To Date" := SelloutTextToDateD;

                        TDInit.Insert();
                    end;
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
