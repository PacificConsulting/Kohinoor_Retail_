pageextension 50367 Countries_ext extends "Countries/Regions"
{
    layout
    {
        addafter(Code)
        {
            field("Country New"; Rec."Country New")
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