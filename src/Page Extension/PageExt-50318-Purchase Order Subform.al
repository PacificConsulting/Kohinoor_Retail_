pageextension 50318 "Purchase Order Subform Ext" extends "Purchase Order Subform"
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
        moveafter("Over-Receipt Code"; "Reserved Quantity")
        moveafter("Line Amount"; "Qty. to Receive")
        moveafter("TDS Section Code"; "Quantity Received")
        moveafter("HSN/SAC Code"; "GST Credit")
        moveafter("GST Assessable Value"; "Vendor Model No.")
        moveafter("GST Credit"; "GST Group Type")
        modify("Item Charge Qty. to Handle")
        {
            Visible = false;
        }
        addafter("No.")
        {

            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the No. 2 field.';
            }
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = true;
        }
        addafter(Quantity)
        {
            field("Outstanding Quantity"; Rec."Outstanding Quantity")
            {
                ApplicationArea = all;
            }
            field("Warranty Parent Line No."; Rec."Warranty Parent Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Warranty Parent Line No. field.';
            }
        }


    }
}
