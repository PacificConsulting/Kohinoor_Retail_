page 50374 "Expense Booking"
{
    ApplicationArea = All;
    Caption = 'Expense Booking';
    PageType = Card;
    SourceTable = "Expense Booking Header";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Staff ID"; Rec."Staff ID")
                {
                    ToolTip = 'Specifies the value of the Staff ID field.';
                }
                field("Store No."; Rec."Store No.")
                {
                    ToolTip = 'Specifies the value of the Store No. field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Date"; Rec."Date")
                {
                    //Editable = false;
                    ToolTip = 'Specifies the value of the Store Date field.';
                }
            }
            part(Lines; "Expense Booking Subform")
            {
                ApplicationArea = all;
                SubPageLink = "Store No." = field("Store No."), Date = field(Date), "Staff ID" = field("Staff ID");
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Creation)
        {
            action("Submit Expense")
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                Caption = 'Submit Expense';
                Image = Post;
                trigger OnAction()
                var
                    ExpBook: Record "Expense Booking Header";
                begin
                    IF Confirm('Do you want submit expense booking', true) then begin
                        ExpBook.Reset();
                        ExpBook.SetRange("Staff ID", rec."Staff ID");
                        ExpBook.SetRange("Store No.", rec."Store No.");
                        ExpBook.SetRange(Date, Rec.Date);
                        IF ExpBook.FindFirst() then begin
                            ExpBook.Status := ExpBook.Status::Released;
                            ExpBook.Modify();
                        end;
                    end;
                end;
            }

        }
    }
}
