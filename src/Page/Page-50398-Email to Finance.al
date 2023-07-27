page 50398 "Email to Finance"
{
    ApplicationArea = All;
    Caption = 'Email to Finance Setup';
    PageType = List;
    SourceTable = "Email to Finance";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Payment Method"; Rec."Payment Method")
                {
                    ToolTip = 'Specifies the value of the Payment Method field.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
                field("Store No."; Rec."Store No.")
                {
                    ToolTip = 'Specifies the value of the Store No. field.';
                }

            }
        }
    }
}
