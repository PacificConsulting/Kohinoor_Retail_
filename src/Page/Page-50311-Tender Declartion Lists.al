page 50311 "Tender Declartion Lists"
{
    ApplicationArea = All;
    Caption = 'Tender Declartion Lists';
    PageType = List;
    SourceTable = "Tender Declartion Header";
    UsageCategory = Lists;
    CardPageId = "Tender Declartion Card";
    InsertAllowed = false;
    ModifyAllowed = false;



    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Staff ID"; Rec."Staff ID")
                {
                    ToolTip = 'Specifies the value of the Staff ID field.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Store No."; Rec."Store No.")
                {
                    ToolTip = 'Specifies the value of the Store No. field.';
                }
                field("Store Date"; Rec."Store Date")
                {
                    ToolTip = 'Specifies the value of the Store Date field.';
                }

                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Tender Creation")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Create;
                trigger OnAction()
                var
                    TDC: page "Tender Declartion Creation";
                    TDL: Record "Tender Declartion Line ";
                begin
                    TDC.Run();

                end;

            }
            action("Tender Line Delete")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Create;
                trigger OnAction()
                var
                    TDC: page "Tender Declartion Creation";
                    TDL: Record "Tender Declartion Line ";
                begin
                    TDL.DeleteAll();

                end;

            }



        }
    }
}
