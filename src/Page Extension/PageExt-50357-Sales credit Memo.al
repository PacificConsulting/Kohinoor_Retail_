pageextension 50357 "Sales credit Memo 1" extends "Sales Credit Memo"
{
    layout
    {
        addafter(Status)
        {
            field("Store No."; Rec."Store No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Store No. field.';
            }
        }
    }
    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Salesperson Code");
            end;
        }
        modify(PostAndSend)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Salesperson Code");
            end;
        }
    }
}
