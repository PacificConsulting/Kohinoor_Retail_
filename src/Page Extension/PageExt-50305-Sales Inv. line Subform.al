pageextension 50305 "Sales Inv Line Subform" extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Store No."; Rec."Store No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Approval Status"; Rec."Approval Status")
            {
                ApplicationArea = all;
            }
            field("Approval Sent By"; Rec."Approval Sent By")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Approval Sent By field.';
            }
            field("Approval Sent On"; Rec."Approval Sent On")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Approval Sent On field.';
            }
            field("Approved By"; Rec."Approved By")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Approved By field.';
            }
            field("Approved On"; Rec."Approved On")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Approved On field.';
            }
            field("Old Unit Price"; Rec."Old Unit Price")
            {
                ApplicationArea = all;
            }
            field("GST Tax Amount"; Rec."GST Tax Amount")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the GST Tax Amount.';

            }
        }



    }
    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}