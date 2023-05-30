pageextension 50322 "Bank Account Led Entries" extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter("Cheque Date")
        {
            field("Approval Code"; Rec."Approval Code")
            {
                ApplicationArea = all;
            }
        }
    }
}
