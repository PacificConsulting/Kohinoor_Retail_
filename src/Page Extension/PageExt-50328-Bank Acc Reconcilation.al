pageextension 50328 "Bank Acc reconcilation" extends "Bank Acc. Reconciliation"
{
    layout
    {
        modify(BankAccountNo)
        {
            trigger OnAfterValidate()
            var
                BA: Record "Bank Account";
            begin
                IF BA.get(Rec."Bank Account No.") then
                    IF BA.Tender then
                        Error('This Bank Account is define as Tender Account');
            end;
        }
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
