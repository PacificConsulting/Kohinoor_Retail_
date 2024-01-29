pageextension 50365 PostedPurch_Crmemo extends "Posted Purchase Credit Memos"
{
    layout
    {
        addafter("Due Date")
        {
            field("Posted By"; Rec."Posted By")
            {
                ApplicationArea = all;
            }
        }
        // moveafter("Buy-from Vendor No."; Amount)


    }
}