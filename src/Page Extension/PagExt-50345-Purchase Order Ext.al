pageextension 50345 "Purchase Order  Ext" extends "Purchase Order"
{
    layout
    {
        modify("Quote No.")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = false;
        }
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Shipment Method Code")
        {
            Visible = false;
        }
        modify("Inbound Whse. Handling Time")
        {
            Visible = false;
        }
        modify("Promised Receipt Date")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        moveafter("Include GST in TDS Base"; ShippingOptionWithLocation)
        moveafter(ShippingOptionWithLocation; "Location Code")
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
        modify(SubcontractingOrder)
        {
            Visible = false;
        }
        modify("Subcon. Order No.")
        {
            Visible = false;
        }
        modify("Subcon. Order Line No.")
        {
            Visible = false;
        }
        modify(SubConPostLine)
        {
            Visible = false;
        }
        modify("Prepayment %")
        {
            Visible = false;
        }
        modify("Prepmt. Payment Discount %")
        {
            Visible = false;
        }
        modify("Prepmt. Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Prepayment Due Date")
        {
            Visible = false;
        }
        modify("Prepmt. Payment Terms Code")
        {
            Visible = false;
        }
        modify("Compress Prepayment")
        {
            Visible = false;
        }
    }

}
