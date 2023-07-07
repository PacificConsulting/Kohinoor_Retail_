pageextension 50333 "Posted Sales Invoice Lines ext" extends "Posted Sales Invoice Lines"
{
    layout
    {
        addafter(Amount)
        {
            field("Unit Price Incl. of Tax"; Rec."Unit Price Incl. of Tax")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Unit Price Incl. of Tax field.';
            }
            field("VAT Base Amount"; Rec."VAT Base Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Base Amount field.';
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

        }

    }
}
