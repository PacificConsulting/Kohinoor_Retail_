page 50301 "Payment Lines Subform"
{
    AutoSplitKey = true;
    Caption = 'Payment Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Payment Lines";
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(Content)
        {
            repeater(Control00125)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                    Editable = false;
                    Visible = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Type field.';
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                    Editable = false;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Method Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }

                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                    Editable = false;
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
                field("Payment Attachment"; Rec."Payment Attachment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Attachment field.';
                }
                field("Transaction ID"; Rec."Transaction ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction ID field.';
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
    trigger OnModifyRecord(): Boolean
    var
        SH: Record 36;
    begin
        SH.Reset();
        SH.SetRange("No.", Rec."Document No.");
        SH.SetRange(Status, SH.Status::Released);
        IF SH.FindFirst() then
            Error('you can not modify when Sales order released');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        SH: Record 36;
    begin
        SH.Reset();
        SH.SetRange("No.", Rec."Document No.");
        SH.SetRange(Status, SH.Status::Released);
        IF SH.FindFirst() then
            Error('you can not modify when Sales order released');
    end;


    var
        myInt: Integer;
}