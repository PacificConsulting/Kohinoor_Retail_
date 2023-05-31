page 50304 "Menu Card"
{
    PageType = Card;
    Caption = 'Menu Card';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Menu Header";
    RefreshOnActivate = true;
    layout
    {
        area(Content)
        {
            group("Menu Header")
            {
                field("Menu ID"; Rec."Menu ID")
                {
                    ToolTip = 'Specifies the value of the Menu ID field.';
                }
                field("Menu Name"; Rec."Menu Name")
                {
                    ToolTip = 'Specifies the value of the Menu Name field.';
                }
                field("Store No."; Rec."Store No.")
                {
                    ToolTip = 'Specifies the value of the Store No. field.';
                }
            }
            part(Lines; "Menu Line Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Menu ID" = field("Menu ID");//, "Store No." = field("Store No.");

            }

        }
    }



    var
        myInt: Integer;
}