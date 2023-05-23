pageextension 50307 "Inventory Setup Ext" extends "Inventory Setup"
{
    layout
    {
        addafter("Transfer Order Nos.")
        {
            field("Request Tran. Order Nos."; Rec."Request Tran. Order Nos.")
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