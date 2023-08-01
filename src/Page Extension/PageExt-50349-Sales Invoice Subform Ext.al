pageextension 50349 "Sales Invoice Subform Retail" extends "Sales Invoice Subform"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {

            field("Salesperson Code"; Rec."Salesperson Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Salesperson Code field.';
            }
            field("Salesperson Name"; Rec."Salesperson Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Salesperson Name field.';
            }
        }
        moveafter("Location Code"; Quantity)
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("GST on Assessable Value")
        {
            Visible = false;
        }
        modify("GST Assessable Value (LCY)")
        {
            Visible = false;
        }
        moveafter(Quantity; "Unit Price Incl. of Tax")
        moveafter(Exempted; "TCS Nature of Collection")
        moveafter("Bin Code"; "Price Exclusive of Tax")
        moveafter(Quantity; "Unit of Measure Code")
        moveafter("Tax Group Code"; "Line Amount")
        moveafter("Line Amount"; "GST Group Code")
        moveafter("Qty. to Assign"; "Line Discount %")
        moveafter("GST Group Code"; "HSN/SAC Code")
        moveafter("GST Assessable Value (LCY)"; "GST Group Type")
    }
}
