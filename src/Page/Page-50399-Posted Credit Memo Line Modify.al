page 50399 "Posted Credit Memo Line Modify"
{
    ApplicationArea = All;
    Caption = 'Posted Credit Memo Line Modify';
    PageType = List;
    SourceTable = "Sales Cr.Memo Line";
    UsageCategory = Lists;
    Permissions = tabledata "Sales Cr.Memo Line" = RM;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the credit memo number.';
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    Editable = false;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies the value of the Salesperson Code field.';
                }
                field("Salesperson Name"; Rec."Salesperson Name")
                {
                    ToolTip = 'Specifies the value of the Salesperson Name field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the name of the item or general ledger account, or some descriptive text.';
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the number of units of the item specified on the line.';
                    Editable = false;
                }
                field("Exchange Comment"; Rec."Exchange Comment")
                {
                    ToolTip = 'Specifies the value of the Exchange Comment field.';
                }
                field("Exchange Item No."; Rec."Exchange Item No.")
                {
                    ToolTip = 'Specifies the value of the Exchange Item No. field.';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ToolTip = 'Specifies the value of the Serial No. field.';
                }
            }
        }
    }
}
