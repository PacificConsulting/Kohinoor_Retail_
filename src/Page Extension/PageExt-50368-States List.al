pageextension 50368 State_ext extends States
{
    layout
    {
        addafter(Code)
        {
            field("State New"; Rec."State New")
            {
                ApplicationArea = all;
            }
        }


        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}