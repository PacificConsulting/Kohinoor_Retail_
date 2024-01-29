pageextension 50366 TDSEntries_page extends "TDS Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter("Vendor No.")
        {
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = All;
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