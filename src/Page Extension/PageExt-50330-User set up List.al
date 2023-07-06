pageextension 50330 "User sertup List" extends "User Setup"
{
    layout
    {
        addafter(PhoneNo)
        {

            field("Allow for Credit Bill"; Rec."Allow for Credit Bill")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow for Credit Bill field.';
            }
            field("Admin Access"; Rec."Admin Access")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Admin Access field.';
            }

        }
    }
}
