pageextension 50308 Location_Card extends "Location Card"
{
    layout
    {
        addafter(Dimensions)
        {
            group("No. Series")
            {
                field("Sales Order Nos"; Rec."Sales Order Nos")
                {
                    ApplicationArea = all;
                }
            }
        }
        addafter("Receipt Bin Code")
        {
            field("Default Receipt Bin"; Rec."Default Receipt Bin")
            {
                ApplicationArea = all;
            }
        }
        addafter("Use As In-Transit")
        {
            field(Store; Rec.Store)
            {
                ApplicationArea = all;
            }
            field("Cash Account No."; Rec."Cash Account No.")
            {
                ApplicationArea = all;
            }
            field("Payment Journal Template Name"; Rec."Payment Journal Template Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payment Journal Template Name field.';
            }
            field("Payment Journal Batch Name"; Rec."Payment Journal Batch Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payment Journal Batch Name field.';
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