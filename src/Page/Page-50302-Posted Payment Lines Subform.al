page 50302 "Posted Payment Lines Subform"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Posted Payment Lines";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Control00122)
            {

                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ToolTip = 'Specifies the value of the Payment Method Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Approval Code"; Rec."Approval Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approval Code field.';
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approval Date field.';
                }
                field("Card Expiry Date"; Rec."Card Expiry Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Card Expiry Date field.';
                }
                field("Card Type"; Rec."Card Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Card Type field.';
                }
                field("Cheque No 6 Digit"; Rec."Cheque No 6 Digit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque No 6 Digit field.';
                }
                field("Credit Card No. Last 4 digit"; Rec."Credit Card No. Last 4 digit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Owner Name field.';
                }
                field("DO Number"; Rec."DO Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the DO Number field.';
                }
                field("Deliver Order Copy Upload"; Rec."Deliver Order Copy Upload")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deliver Order Copy Upload field.';
                }
                field("MFR Sub. to be born by Dealer"; Rec."MFR Sub. to be born by Dealer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the MFR Subvention Borne to be born by Dealer field.';
                }
                field("Owner Name"; Rec."Owner Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Owner Name field.';
                }
                field("Subvention by Dealer"; Rec."Subvention by Dealer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Subvention by Dealer field.';
                }
                field("Finance Promoter"; Rec."Finance Promoter")
                {
                    ToolTip = 'Specifies the value of the Finance Promoter field.';
                }
                field("Finance Promoter Name"; Rec."Finance Promoter Name")
                {
                    ToolTip = 'Specifies the value of the Finance Promoter Name field.';
                }
                field(Attachment; Rec.Attachment)
                {
                    ToolTip = 'Specifies the value of the Attachment field.';
                }
                field("Invoice Posting Date"; Rec."Invoice Posting Date")
                {
                    ToolTip = 'Specifies the value of the Invoice Posting Date field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}