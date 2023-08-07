pageextension 50351 "Sales Cr. Memo Subform Ext" extends "Sales Cr. Memo Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Exchange Item No."; Rec."Exchange Item No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exchange Item No. field.';
            }
            field("Serial No."; Rec."Serial No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Serial No. field.';
            }
            field("Exchange Comment"; Rec."Exchange Comment")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exchange Comment field.';
            }
            field("Salesperson Code"; Rec."Salesperson Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Salesperson Code field.';
            }
            field("Salesperson Name"; Rec."Salesperson Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Salesperson Name field.';
                Editable = false;
            }
        }
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
