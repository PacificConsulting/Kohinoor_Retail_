page 50397 "Kohinoor Admin Access"
{
    ApplicationArea = All;
    Caption = 'Kohinoor Admin Access';
    PageType = List;
    SourceTable = "User Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Admin Access"; Rec."Admin Access")
                {
                    ToolTip = 'Specifies the value of the Admin Access field.';
                }
                field("Trade Agreement Access"; Rec."Trade Agreement Access")
                {
                    ToolTip = 'Specifies the value of the Trade Agreement Access field.';
                }
                field("Warranty Access"; Rec."Warranty Access")
                {
                    ToolTip = 'Specifies the value of the Warranty Access field.';
                }
                field("Allow for Credit Bill"; Rec."Allow for Credit Bill")
                {
                    ToolTip = 'Specifies the value of the Allow for Credit Bill field.';
                }
                field("Allow Cheque Clearance"; Rec."Allow Cheque Clearance")
                {
                    ToolTip = 'Specifies the value of the Allow Cheque Clearance field.';
                }
            }
        }
    }
}
