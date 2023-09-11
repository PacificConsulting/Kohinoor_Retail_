pageextension 50364 PostedPurchInv_ extends "Posted Purchase Invoices"
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
    }
}