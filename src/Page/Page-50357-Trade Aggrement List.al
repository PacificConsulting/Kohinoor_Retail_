page 50357 "Trade Aggrement List"
{
    ApplicationArea = All;
    Caption = 'Trade Aggrement List';
    PageType = List;
    SourceTable = "Trade Aggrement";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Item; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item field.';
                }
                field("From Date"; Rec."From Date")
                {
                    ToolTip = 'Specifies the value of the From Date field.';
                }
                field("To Date"; Rec."To Date")
                {
                    ToolTip = 'Specifies the value of the To Date field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Amount In INR"; Rec."Amount In INR")
                {
                    ToolTip = 'Specifies the value of the Amount In INR field.';
                }
                field(DP; Rec.DP)
                {
                    ToolTip = 'Specifies the value of the DP field.';
                }
                field("Detailed NNLC"; Rec."Detailed NNLC")
                {
                    ToolTip = 'Specifies the value of the Detailed NNLC field.';
                }
                field(FNNLC; Rec.FNNLC)
                {
                    ToolTip = 'Specifies the value of the FNNLC field.';
                }
                field("Last Selling Price"; Rec."Last Selling Price")
                {
                    ToolTip = 'Specifies the value of the Last Selling Price field.';
                }
                field("M.R.P"; Rec."M.R.P")
                {
                    ToolTip = 'Specifies the value of the M.R.P field.';
                }
                field(MOP; Rec.MOP)
                {
                    ToolTip = 'Specifies the value of the MOP field.';
                }
                field("Manager Discection"; Rec."Manager Discection")
                {
                    ToolTip = 'Specifies the value of the Manager Discection field.';
                }
                field(NNLC; Rec.NNLC)
                {
                    ToolTip = 'Specifies the value of the NNLC field.';
                }
                field("Purchase Price"; Rec."Purchase Price")
                {
                    ToolTip = 'Specifies the value of the Purchase Price field.';
                }
                field("SLAB 1 - PRICE"; Rec."SLAB 1 - PRICE")
                {
                    ToolTip = 'Specifies the value of the SLAB 1 - PRICE field.';
                }
                field("SLAB 1 - X-PRICE"; Rec."SLAB 1 - X-PRICE")
                {
                    ToolTip = 'Specifies the value of the SLAB 1 - X-PRICE field.';
                }
                field("SLAB 2 - INC"; Rec."SLAB 2 - INC")
                {
                    ToolTip = 'Specifies the value of the SLAB 2 - INC field.';
                }
                field("SLAB 2 - PRICE"; Rec."SLAB 2 - PRICE")
                {
                    ToolTip = 'Specifies the value of the SLAB 2 - PRICE field.';
                }
                field("SLAB 2 - X-PRICE"; Rec."SLAB 2 - X-PRICE")
                {
                    ToolTip = 'Specifies the value of the SLAB 2 - X-PRICE field.';
                }
                field(Sellout; Rec.Sellout)
                {
                    ToolTip = 'Specifies the value of the Sellout field.';
                }
                field("Sellout Text"; Rec."Sellout Text")
                {
                    ToolTip = 'Specifies the value of the Sellout Text field.';
                }
                field("Actual From Date"; Rec."Actual From Date")
                {
                    ToolTip = 'Specifies the value of the Actual From Date field.';
                }
                field(ALLFINANCE; Rec.ALLFINANCE)
                {
                    ToolTip = 'Specifies the value of the ALLFINANCE field.';
                }
                field(AMZ; Rec.AMZ)
                {
                    ToolTip = 'Specifies the value of the AMZ field.';
                }
                field("Actual To Date"; Rec."Actual To Date")
                {
                    ToolTip = 'Specifies the value of the Actual To Date field.';
                }
                field("Amount in Transaction Currency"; Rec."Amount in Transaction Currency")
                {
                    ToolTip = 'Specifies the value of the Amount in Transaction Currency field.';
                }
                field(CASHBACK; Rec.CASHBACK)
                {
                    ToolTip = 'Specifies the value of the CASHBACK field.';
                }
                field("Customer Group"; Rec."Customer Group")
                {
                    ToolTip = 'Specifies the value of the Customer Group field.';
                }
                field("FOC/Sellout"; Rec."FOC/Sellout")
                {
                    ToolTip = 'Specifies the value of the FOC/Sellout field.';
                }
                field("Fnnlc with sell out"; Rec."Fnnlc with sell out")
                {
                    ToolTip = 'Specifies the value of the Fnnlc with sell out field.';
                }
                field(From; Rec.From)
                {
                    ToolTip = 'Specifies the value of the From field.';
                }
                field(KTVWEB_WE; Rec.KTVWEB_WE)
                {
                    ToolTip = 'Specifies the value of the KTVWEB_WE field.';
                }
                field(KTVWEB_WOE; Rec.KTVWEB_WOE)
                {
                    ToolTip = 'Specifies the value of the KTVWEB_WOE field.';
                }
                field("Manager Discection - INC"; Rec."Manager Discection - INC")
                {
                    ToolTip = 'Specifies the value of the Manager Discection - INC field.';
                }
                field(PRICE_TAG; Rec.PRICE_TAG)
                {
                    ToolTip = 'Specifies the value of the PRICE_TAG field.';
                }
                field(PROMO; Rec.PROMO)
                {
                    ToolTip = 'Specifies the value of the PROMO field.';
                }
                field("SLAB 1 - INC"; Rec."SLAB 1 - INC")
                {
                    ToolTip = 'Specifies the value of the SLAB 1 - INC field.';
                }
                field("To"; Rec."To")
                {
                    ToolTip = 'Specifies the value of the To field.';
                }
                field(UOM; Rec.UOM)
                {
                    ToolTip = 'Specifies the value of the UOM field.';
                }
            }
        }
    }
}
