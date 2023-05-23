pageextension 50316 "Post Code" extends "Post Codes"
{
    layout
    {
        addafter("Country/Region Code")
        {
            field("State Code"; Rec."State Code")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}