pageextension 50311 "Ship To Address Ext" extends "Ship-to Address List"
{
    layout
    {
        modify(Code)
        {
            trigger OnLookup(var Text: Text): Boolean
            Var
                SR: record 311;
                NoSeries: Codeunit NoSeriesManagement;
            begin
                SR.Get();
                SR.TestField("Ship To address No Series");
                Rec.code := NoSeries.GetNextNo(SR."Ship To address No Series", Today, true);
                Rec.Modify();
            end;
        }
        addafter("Location Code")
        {
            field("Ship Type"; Rec."Address Type")
            {
                ApplicationArea = all;
            }
        }
    }
}
