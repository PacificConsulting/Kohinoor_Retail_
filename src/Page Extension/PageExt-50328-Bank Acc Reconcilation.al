pageextension 50328 "Bank Acc reconcilation" extends "Bank Acc. Reconciliation"
{
    layout
    {

    }
    trigger OnOpenPage()
    begin
        rec.FilterGroup(2);
        rec.SetFilter(Tender, '%1', false);
        rec.FilterGroup(0);
    end;

    trigger OnAfterGetRecord()
    begin
        rec.FilterGroup(2);
        rec.SetFilter(Tender, '%1', false);
        rec.FilterGroup(0);
    end;
}
