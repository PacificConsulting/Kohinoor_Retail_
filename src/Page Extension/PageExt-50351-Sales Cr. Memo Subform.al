pageextension 50351 "Sales Cr. Memo Subform Ext" extends "Sales Cr. Memo Subform"
{
    layout
    {
        moveafter("Location Code"; Quantity)
        moveafter(Quantity; "Unit Price Incl. of Tax")
        moveafter("Qty. Assigned"; "TCS Nature of Collection")
        moveafter("Unit Price Incl. of Tax"; "Price Exclusive of Tax")
        moveafter("Price Exclusive of Tax"; "Unit Price")
        modify("Tax Group Code")
        {
            Visible = false;
        }
        moveafter("Unit Price"; "Line Amount")
        moveafter("Line Amount"; "GST Group Code")
        moveafter("GST Group Code"; "HSN/SAC Code")
        moveafter("HSN/SAC Code"; "GST Group Type")
    }
}
