pageextension 50348 "Purchase Inv. Subform" extends "Purch. Invoice Subform"
{
    layout
    {
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        moveafter("Line Amount"; "GST Group Code")
        moveafter("GST Group Code"; "HSN/SAC Code")
        moveafter("HSN/SAC Code"; "GST Group Type")
        moveafter("GST Group Type"; "GST Credit")
    }
}
