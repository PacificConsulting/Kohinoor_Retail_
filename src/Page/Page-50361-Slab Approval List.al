page 50361 "Slab Approval List"
{
    ApplicationArea = All;
    Caption = 'Slab Approval List';
    PageType = List;
    SourceTable = "Sales Line";
    UsageCategory = Lists;
    InsertAllowed = false;
    DeleteAllowed = false;

    SourceTableView = where("Approval Status" = filter("Pending for Approval"));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the document number.';
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the line number.';
                    Editable = false;

                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the record.';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the item or service on the line.';
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    Editable = false;
                }
                field("Unit Price Incl. of Tax"; Rec."Unit Price Incl. of Tax")
                {
                    ToolTip = 'Specifies unit prices are inclusive of tax on the line.';
                    Editable = false;
                }

                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the inventory location from which the items sold should be picked and where the inventory decrease is registered.';
                    Editable = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Editable = false;
                    ToolTip = ' Specifies the Approval Status for one unit on the sales line.';

                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Approved Status")
            {
                Caption = 'Approve';
                ApplicationArea = all;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                Image = Approve;
                trigger OnAction()
                var
                    SalesLine: Record 37;
                begin
                    CurrPage.SetSelectionFilter(SalesLine);
                    SalesLine.SetRange("Approval Status", SalesLine."Approval Status"::"Pending for Approval");
                    IF SalesLine.FindFirst() then begin
                        SalesLine."Approval Status" := SalesLine."Approval Status"::" ";
                        SalesLine."Approved By" := UserId;
                        SalesLine."Approved On" := Today;
                        SalesLine.Modify();
                        Message('Price is Approved Successfully.');
                    end;
                end;
            }
            action("Reject")
            {
                Caption = 'Reject';
                ApplicationArea = all;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                Image = Reject;
                trigger OnAction()
                var
                    SalesLine: Record 37;
                begin
                    CurrPage.SetSelectionFilter(SalesLine);
                    SalesLine.SetRange("Approval Status", SalesLine."Approval Status"::"Pending for Approval");
                    IF SalesLine.FindFirst() then begin

                        SalesLine."Rejected By" := UserId;
                        SalesLine."Rejected On" := CurrentDateTime;
                        SalesLine."Approval Status" := SalesLine."Approval Status"::" ";
                        // SalesLine.Validate("Unit Price Incl. of Tax", rec."Old Unit Price");
                        // SalesLine."GST Tax Amount" := (SalesLine."Unit Price Incl. of Tax" - SalesLine."Unit Price") * SalesLine.Quantity;
                        SalesLine.Modify();
                        Message('Price is Rejected Successfully.');

                    end;
                end;
            }

        }
    }
}
