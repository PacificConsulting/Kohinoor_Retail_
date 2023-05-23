tableextension 50306 "Inventory Setup Ext" extends "Inventory Setup"
{
    fields
    {
        field(50301; "Request Tran. Order Nos."; Code[20])
        {
            Caption = 'Request Tran. Order Nos.';
            DataClassification = ToBeClassified;
            //AccessByPermission = TableData "Transfer Header" = R;
            TableRelation = "No. Series";
        }
    }
}
