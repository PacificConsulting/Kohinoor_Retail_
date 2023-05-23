pageextension 50317 SalesPerson extends "Salesperson/Purchaser Card"
{
    layout
    {
        addafter(Name)
        {
            field("Store No."; Rec."Store No.")
            {
                ApplicationArea = all;
            }
        }
    }
}
