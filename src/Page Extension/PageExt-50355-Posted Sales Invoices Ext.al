pageextension 50355 "Posted Sales Invoices Ext" extends "Posted Sales Invoices"
{
    layout
    {
        addafter(Closed)
        {

            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Date field.';
            }
            field("Sell-to Address"; Rec."Sell-to Address")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the address of the customer that the items on the invoice were shipped to.';
            }
            field("Sell-to Address 2"; Rec."Sell-to Address 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies additional address information.';
            }
            field("Ship-to Address"; Rec."Ship-to Address")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the address that the items on the invoice were shipped to.';
            }
            field("Ship-to Address 2"; Rec."Ship-to Address 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies additional address information.';
            }
            field("GST Bill-to State Code"; Rec."GST Bill-to State Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the bill-to state code of the customer on the sales document.';
            }
            field("GST Ship-to State Code"; Rec."GST Ship-to State Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the ship-to state code of the customer on the sales document.';
            }
            field("Store No."; Rec."Store No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Store No. field.';
            }
            field("Posted By"; Rec."Posted By")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posted By field.';
            }
            field("POS Released Date"; Rec."POS Released Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the POS Released Date field.';
            }
        }
    }
}
