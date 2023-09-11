xmlport 50303 "Import Reco Lines"
{
    Caption = 'Import Reco Lines';
    DefaultFieldsValidation = true;
    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy; ////

    schema
    {
        textelement(RootNodeName)
        {
            tableelement("Bank Acc. Reconciliation Line"; "Bank Acc. Reconciliation Line")
            {
                XmlName = 'Import';
                AutoSave = false;
                textelement(Transactiondate)
                {
                }
                textelement(Description)
                {
                }
                textelement(StatementAmt)
                {
                }

            }
        }
    }
}