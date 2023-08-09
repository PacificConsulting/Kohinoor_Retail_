page 50801 "Posted Sales Inv. Line Modify"
{
    ApplicationArea = All;
    Caption = 'Posted Sales Inv. Line Modify';
    PageType = List;
    SourceTable = "Sales Invoice Line";
    UsageCategory = Lists;
    Permissions = tabledata "Sales Invoice Line" = RM;
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

            }
        }
    }
}
