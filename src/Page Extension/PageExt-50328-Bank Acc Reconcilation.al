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
    actions
    {
        addafter("Ba&nk")
        {
            action(Tender)
            {
                ApplicationArea = all;
                PromotedCategory = New;
                Promoted = true;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    rec.Tender := true;
                    rec.Modify();

                end;


            }
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
