pageextension 50302 "Posted Sales invoice Retail" extends "Posted Sales Invoice"
{
    layout
    {
        addafter(SalesInvLines)
        {
            part(PostedPaymentLine; "Posted Payment Lines Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
                Editable = false;
            }
        }
        addafter(Closed)
        {
            field("Amount To Customer"; Rec."Amount To Customer")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Store No."; Rec."Store No.")
            {
                ApplicationArea = all;
            }
            field("Posted By"; Rec."Posted By")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posted By field.';
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