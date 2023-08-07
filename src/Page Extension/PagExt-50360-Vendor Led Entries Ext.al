pageextension 50360 "Vendor Led Entries Ext" extends "Vendor Ledger Entries"
{
    layout
    {
        addafter("TDS Section Code")
        {

            field("Total TDS Including SHE CESS"; Rec."Total TDS Including SHE CESS")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Total TDS Including SHE CESS field.';
            }
        }
    }
}
