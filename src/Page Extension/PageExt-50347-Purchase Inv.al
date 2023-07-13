pageextension 50347 Purchase_Invoice_Retail extends "Purchase Invoice"
{
    layout
    {
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        moveafter("Include GST in TDS Base"; ShippingOptionWithLocation)
        moveafter(ShippingOptionWithLocation; "Location Code")
        modify("Prices Including VAT")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("Transaction Specification")
        {
            Visible = false;
        }
        modify("Transaction Type")
        {
            Visible = false;
        }
        modify("Transport Method")
        {
            Visible = false;
        }
    }
}
