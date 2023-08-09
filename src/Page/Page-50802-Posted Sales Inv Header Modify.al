page 50802 "Posted Sales Inv.Header Modify"
{
    ApplicationArea = All;
    Caption = 'Posted Sales Inv. Header Modify';
    PageType = List;
    SourceTable = "Sales Invoice Header";
    UsageCategory = Lists;
    Permissions = tabledata "Sales Invoice Header" = RM;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Editable = false;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer the invoice concerns.';
                    Editable = false;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ToolTip = 'Specifies the name of the customer that you shipped the items on the invoice to.';
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the code for the location from which the items were shipped.';
                    Editable = false;
                }
                field("Store No."; Rec."Store No.")
                {
                    ToolTip = 'Specifies the value of the Store No. field.';
                }
            }
        }
    }
}
