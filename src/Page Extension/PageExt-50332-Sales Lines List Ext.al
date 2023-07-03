pageextension 50332 "Sales Lines List Ext" extends "Sales Lines"
{
    layout
    {
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
        }
    }
}
