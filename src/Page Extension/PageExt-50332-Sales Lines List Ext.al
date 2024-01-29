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
        addafter("Sell-to Customer No.")
        {
            field("Customer Name"; Rec."Customer Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Name';

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
            field(MOP; Rec.MOP)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MOP field.';
            }
            field(DP; Rec.DP)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the DP field.';
            }
            field("Last Selling Price"; Rec."Last Selling Price")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Last Selling Price field.';
            }
            field(NNLC; Rec.NNLC)
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the NNLC field.';
            }
            field("PMG NLC W/O SELL OUT"; Rec."PMG NLC W/O SELL OUT")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PMG NLC W/O SELL OUT field.';
            }
            field("Manager Discection"; Rec."Manager Discection")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Manager Discection field.';
            }
            field("Manager Discection - INC"; Rec."Manager Discection - INC")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Manager Discection INC field.';
            }
            field("Sell out Text From Date"; Rec."Sell out Text From Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the ell out Text From Date field.';
            }
            field("Sell out Text To Date"; Rec."Sell out Text To Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sell out Text To Date field.';
            }
            field(Sellout; Rec.Sellout)
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Sellout field.';
            }
            field("Sellout Text"; Rec."Sellout Text")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sellout text field.';
            }
            field("Actual From Date"; Rec."Actual From Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual From Date field.';
            }
            field("Actual To Date"; Rec."Actual To Date")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Actual To Date field.';
            }
            field(FNNLC; Rec.FNNLC)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual To Date field.';

            }
            field("Fnnlc with sell out"; Rec."Fnnlc with sell out")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Fnnlc with sell out field.';
            }
            field("FNNLC Without SELLOUT"; Rec."FNNLC Without SELLOUT")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the FNNLC Without SELLOUT field.';
            }
            field("SLAB 1 - INC"; Rec."SLAB 1 - INC")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SLAB 1 - INC field.';
            }
            field("SLAB 2 - INC"; Rec."SLAB 2 - INC")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SLAB 2 - INC field.';
            }
            field("SLAB 1 - PRICE"; Rec."SLAB 1 - PRICE")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the SLAB 1 - PRICE field.';
            }
            field("SLAB 2 - PRICE"; Rec."SLAB 2 - PRICE")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SLAB 2 - PRICE field.';
            }
            field(AMZ; Rec.AMZ)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the AMZ field.';
            }
            field(PROMO; Rec.PROMO)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PROMO field.';
            }
            field(KTVWEB_WE; Rec.KTVWEB_WE)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the KTVWEB_WE field.';
            }
            field(KTVWEB_WOE; Rec.KTVWEB_WOE)
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the KTVWEB_WOE field.';
            }
            field(PRICE_TAG; Rec.PRICE_TAG)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PRICE_TAG field.';
            }
            field("M.R.P"; Rec."M.R.P")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MRP field.';
            }
            field(ALLFINANCE; Rec.ALLFINANCE)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the ALLFINANCE field.';
            }
            field(CASHBACK; Rec.CASHBACK)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CASHBACK field.';
            }


        }
    }
}
