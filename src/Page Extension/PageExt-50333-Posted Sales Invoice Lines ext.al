pageextension 50333 "Posted Sales Invoice Lines ext" extends "Posted Sales Invoice Lines"
{
    layout
    {
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

        }

    }
}
