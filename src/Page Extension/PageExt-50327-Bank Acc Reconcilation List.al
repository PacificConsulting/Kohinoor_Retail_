pageextension 50327 "Bank Acc Reconcilation List" extends "Bank Acc. Reconciliation List"
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
