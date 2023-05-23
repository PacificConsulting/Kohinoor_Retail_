pageextension 50320 "Posted Transfer receipts" extends "Posted Transfer Receipts"
{
    layout
    {
        addafter("Transfer-to Code")
        {

            field("Transfer Order No."; Rec."Transfer Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of the related transfer order.';
            }
        }
    }
}
