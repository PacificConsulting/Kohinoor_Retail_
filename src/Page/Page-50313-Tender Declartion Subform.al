page 50313 "Tender Declartion Subform"
{
    ApplicationArea = All;
    Caption = 'Tender Declartion Subform';
    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Tender Declartion Line ";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Staff ID"; Rec."Staff ID")
                {
                    ToolTip = 'Specifies the value of the Staff ID field.';
                    Editable = false;
                    Visible = false;
                }
                field("Store No."; Rec."Store No.")
                {
                    ToolTip = 'Specifies the value of the Store No. field.';
                    Editable = false;
                    Visible = false;
                }
                field("Store Date"; Rec."Store Date")
                {
                    ToolTip = 'Specifies the value of the Store Date field.';
                    Editable = false;
                    Visible = false;
                }
                // field("Line No."; Rec."Line No.")
                // {
                //     ToolTip = 'Specifies the value of the Line No. field.';
                //     Editable = false;
                // }
                field("Payment Method code"; Rec."Payment Method code")
                {
                    ToolTip = 'Specifies the value of the Payment Method code field.';
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
            }
        }
    }
}
