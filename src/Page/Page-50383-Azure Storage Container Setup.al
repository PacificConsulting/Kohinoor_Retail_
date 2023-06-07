page 50383 "Azure Storage Container Setup"
{
    ApplicationArea = all;
    Caption = 'Azure Storage Container Setup';
    PageType = Card;
    SourceTable = "Azure Storage Container Setup";
    DeleteAllowed = false;
    InsertAllowed = false;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Account Name"; Rec."Account Name")
                {
                    ToolTip = 'Specifies the value of the Account Name field.';
                }
                field("Container Name"; Rec."Container Name")
                {
                    ToolTip = 'Specifies the value of the Container Name field.';
                }
                field("Container Name Invoice"; Rec."Container Name Invoice")
                {
                    ToolTip = 'Specifies the value of the Container Name Invoice field.';
                }
                field("Access key"; Rec."Access key")
                {
                    ToolTip = 'Specifies the value of the Access key field.';
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
