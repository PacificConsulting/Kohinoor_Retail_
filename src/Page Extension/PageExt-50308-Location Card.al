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
        // addafter("Home Page")
        // {
        //     field("Payment QR"; Rec."Payment QR")
        //     {
        //         ApplicationArea = all;
        //     }
        // }
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
            field("Bank Account No."; Rec."Bank Account No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bank Account No. field.';
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
            field("Startup Menu "; Rec."Startup Menu ")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Startup Menu  field.';
            }
            field("Payment QR "; Rec."Payment QR")
            {
                ApplicationArea = All;
                ToolTip = 'Upload Payment QR';
            }



        }
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnModifyRecord(): Boolean
    begin
        IF US.Get(UserId) then begin
            IF not Us."Admin Access" then
                Error('You do not have access to modify the data.');
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        IF US.Get(UserId) then begin
            IF not Us."Admin Access" then
                Error('You do not have access to modify the data.');
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF US.Get(UserId) then begin
            IF not Us."Admin Access" then
                Error('You do not have access to modify the data.');
        end;
    end;

    var
        US: Record "User Setup";

}