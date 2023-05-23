page 50378 "Tender POS No.Series Setup"
{
    ApplicationArea = All;
    Caption = 'Tender POS No.Series Setup';
    PageType = List;
    SourceTable = "Tender POS No.Series Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ToolTip = 'Specifies the value of the Journal Template Name field.';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ToolTip = 'Specifies the value of the Journal Batch Name field.';
                }
                field("Cash Voucher No. Series"; Rec."Cash Voucher No. Series")
                {
                    ToolTip = 'Specifies the value of the Cash Voucher No. Series field.';
                }
                field("Tender Voucher No. Series"; Rec."Tender Voucher No. Series")
                {
                    ToolTip = 'Specifies the value of the Tender Voucher No. Series field.';
                }
            }
        }
    }
}
