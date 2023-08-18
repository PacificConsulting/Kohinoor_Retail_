pageextension 50332 "Sales Lines List Ext" extends "Sales Lines"
{
    layout
    {
        modify("Description 2")
        {
            Visible = true;
        }

        addafter("No.")
        {
            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the No. 2 field.';
            }
        }
        addafter("Line Amount")
        {

            field("VAT Base Amount"; Rec."VAT Base Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Base Amount field.';
            }
            field("Unit Price Incl. of Tax"; Rec."Unit Price Incl. of Tax")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies unit prices are inclusive of tax on the line.';
            }
            field("Store No."; Rec."Store No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Store No. field.';
            }
            field("Exchange Comment"; Rec."Exchange Comment")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exchange Comment field.';
            }
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
            field("Old Unit Price"; Rec."Old Unit Price")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Old Unit Price field.';
            }
            field("Salesperson Name"; Rec."Salesperson Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Salesperson Name field.';
            }
            field("Unit Price"; Rec."Unit Price")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the price for one unit on the sales line.';
            }
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posting Date field.';
            }
            field("Bin Code"; Rec."Bin Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the bin where the items are picked or put away.';
            }
            field("GST Group Code"; Rec."GST Group Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies an identifier for the GST group used to calculate and post GST.';
            }
            field("HSN/SAC Code"; Rec."HSN/SAC Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the HSN/SAC code for the calculation of GST on Sales line.';
            }
            field("Warranty Value"; Rec."Warranty Value")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Warranty Value field.';
            }
        }
    }
}
