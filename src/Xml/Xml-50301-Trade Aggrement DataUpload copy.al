xmlport 50301 "Trade Aggrement Data Upload"
{
    Caption = 'Trade Aggrement Data Upload';
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
                textelement(CustomerGroup)
                {
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
                begin
                    TG.Reset();
                    TG.SetRange("Item No.", ItemNo);
                    IF TG.FindLast() then begin
                        TG.Rename(TG."Item No.", TG."From Date", Today, TG."Location Code");

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
                            Evaluate(Custgroup, CustomerGroup);

                        TDInit.Init();
                        TDInit.TransferFields(TG);
                        TDInit."Item No." := ItemNo;
                        TDInit."From Date" := FromdateD;
                        TDInit."To Date" := 20500101D;
                        TDInit."Location Code" := TDInit."Location Code";
                        TDInit."Amount In INR" := AMTINR;
                        TDInit.DP := DPDeci;
                        TDInit.FNNLC := FNNLCDecim;
                        TDInit."Last Selling Price" := LastSellDecimal;
                        TDInit.NNLC := NNLCdeci;
                        TDInit."Purchase Price" := PurcpriceDecimal;
                        TDInit."Customer Group" := Custgroup;
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
