pageextension 50310 "Sales & Receivables Setup Ext" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("GST Dependency Type")
        {
            field("Default Warehouse"; Rec."Default Warehouse")
            {
                ApplicationArea = all;
            }
            field("Exchange Item G/L"; Rec."Exchange Item G/L")
            {
                ApplicationArea = all;
            }
            field("Warranty G/L Code"; Rec."Warranty G/L Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Warranty G/L Code field.';
            }
            field("Installtion Details"; Rec."Installtion Details")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Installtion Details field.';
            }


        }
        addafter("Direct Debit Mandate Nos.")
        {
            field("Ship To address No Series"; Rec."Ship To address No Series")
            {
                ApplicationArea = all;
            }
            field("Tender Declartion No Series"; Rec."Tender Declartion No Series")
            {
                ApplicationArea = all;
            }
            field("Bank Drop No Series"; Rec."Bank Drop No Series")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bank Drop No Series field.';
            }
        }
    }
}
