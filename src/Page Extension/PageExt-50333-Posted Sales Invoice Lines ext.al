pageextension 50333 "Posted Sales Invoice Lines ext" extends "Posted Sales Invoice Lines"
{
    layout
    {
        addafter(Quantity)
        {
            field("GST Group Code"; Rec."GST Group Code")
            {
                ApplicationArea = all;
            }
        }
        addafter("Line Discount %")
        {
            field("Order Line No."; Rec."Order Line No.")
            {
                ApplicationArea = All;
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Document No.")
        {
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("No.")
        {
            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the No. 2 field.';
            }
        }
        addafter(Amount)
        {
            field("Line Amount"; Rec."Line Amount")
            {
                ApplicationArea = All;
            }
            field("Unit Price Incl. of Tax"; Rec."Unit Price Incl. of Tax")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Unit Price Incl. of Tax field.';
            }
            field("Total UPIT Amount"; Rec."Total UPIT Amount")
            {
                ApplicationArea = All;
            }

            field("VAT Base Amount"; Rec."VAT Base Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Base Amount field.';
            }
            field("Shortcut Dimension 1 "; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
            }

            field("Store No."; Rec."Store No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Store No. field.';
            }
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order No. field.';
            }
            field("POS Release Date"; Rec."POS Release Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the POS Release Date field.';
            }
            field("Bin Code"; Rec."Bin Code")
            {
                ApplicationArea = All;
            }
            field("HSN/SAC Code"; Rec."HSN/SAC Code")
            {
                ApplicationArea = All;
            }
            field("Exchange Item No."; Rec."Exchange Item No.")
            {
                ApplicationArea = All;
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
            }
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.';
            }
            field("Exchange Comment"; Rec."Exchange Comment")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exchange Comment field.';
            }
            field("Serial No."; Rec."Serial No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Serial No. field.';
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
