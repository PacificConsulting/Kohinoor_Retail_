pageextension 50357 "Sales credit Memo 1" extends "Sales Credit Memo"
{
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
