pageextension 50315 Cust_card extends "Customer Card"
{
    layout
    {
        modify("Search Name")
        {
            Visible = true;
        }
        addafter("Salesperson Code")
        {
            field("Customer Reference"; Rec."Customer Reference")
            {
                ApplicationArea = all;
                Caption = 'Customer Reference';
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