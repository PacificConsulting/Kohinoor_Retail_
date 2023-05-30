page 50305 "Menu Line Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Menu Line";



    layout
    {
        area(Content)
        {
            repeater(Control001)
            {


                field("Action Name"; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }

                field(IsVisible; Rec."Is Visible")
                {
                    Caption = 'Is Visible';
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Store No."; Rec."Store No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Store No. field.';
                }
                field("Action"; Rec."Action")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Action field.';
                }
                field("Parameter 1"; Rec.Parameter)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Parameter field.';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        POSAct: Record "POS Action Master";
                        Menu: Record "Menu Header";
                        PaymentM: Record "Payment Method";
                    begin
                        IF Rec.Action = 'MENU' then begin
                            Menu.Reset();
                            Menu.SetRange("Store No.", rec."Store No.");
                            IF Menu.Find() then;
                            IF (Page.RunModal(Page::"Menu List", Menu, Menu."Menu ID") = Action::LookupOK) then begin
                                Rec.Parameter := Menu."Menu ID";
                                Rec.Modify();
                            end;
                        end
                        else begin
                            IF Rec.Action = 'PAYMENT' then begin
                                PaymentM.Reset();
                                PaymentM.SetRange(Tender, true);
                                if PaymentM.Find() then;
                                IF (Page.RunModal(Page::"Payment Methods", PaymentM, PaymentM.Code) = Action::LookupOK) then begin
                                    Rec.Parameter := PaymentM.Code;
                                    Rec.Modify();
                                end;
                            end;
                        end;
                    end;
                }
                field("Parameter 2"; Rec."Parameter 2")
                {
                    ApplicationArea = all;
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