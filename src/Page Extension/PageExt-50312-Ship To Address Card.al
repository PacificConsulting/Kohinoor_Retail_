pageextension 50312 "Ship To Address Card" extends "Ship-to Address"
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
                //Rec.Modify();
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

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}