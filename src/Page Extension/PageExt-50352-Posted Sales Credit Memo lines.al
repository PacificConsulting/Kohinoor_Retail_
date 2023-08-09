pageextension 50352 "Posted Sales Credit Memo lines" extends "Posted Sales Credit Memo Lines"
{
    layout
    {

        addafter("Sell-to Customer No.")
        {
            field("Posting Date4"; Rec."Posting Date")
            {
                ApplicationArea = All;
                Caption = 'Posting Date';
            }
        }
        addafter("Amount Including VAT")
        {
            field("Location Code2"; Rec."Location Code")
            {
                ApplicationArea = All;
                Caption = 'Location Code';
            }
            field("Bin Code3"; Rec."Bin Code")
            {
                ApplicationArea = All;
                Caption = 'Bin Code';
            }
            field("Shortcut Dimension 1 Code1"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 1 Code';
            }
            field("Shortcut Dimension 2 Code2"; Rec."Shortcut Dimension 2 Code")
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 2 Code';
            }
            field("GST Group Code4"; Rec."GST Group Code")
            {
                ApplicationArea = All;
                Caption = 'GST Group Code';
            }
            field("HSN/SAC Code7"; Rec."HSN/SAC Code")
            {
                ApplicationArea = All;
                Caption = 'HSN/SAC Code';
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
                Caption = 'Line No.';
            }
        }
        addafter(Description)
        {
            field("Description 20"; Rec."Description 2")
            {
                ApplicationArea = All;
                Caption = 'Description 2';
            }
        }
        addafter("Unit of Measure")
        {
            field("Unit Price Incl. of Tax1"; Rec."Unit Price Incl. of Tax")
            {
                ApplicationArea = All;
                Caption = 'Unit Price Incl. of Tax';
            }
            field("Total UPIT Amount"; Rec."Total UPIT Amount")
            {
                ApplicationArea = All;
                Caption = 'Total UPIT Amount';
            }
            field("Exchange Item No."; Rec."Exchange Item No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exchange Item No. field.';
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
            field("Warranty Value"; Rec."Warranty Value")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Warranty Value field.';
            }
        }

    }
}
