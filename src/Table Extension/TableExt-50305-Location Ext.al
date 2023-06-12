tableextension 50305 "Location_Ext_retail" extends Location
{
    fields
    {
        field(50301; Store; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Store';
        }
        field(50302; "Cash Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(50303; "Payment Journal Template Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Gen. Journal Batch"."Journal Template Name";
        }
        field(50304; "Payment Journal Batch Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Gen. Journal Batch".Name;
        }
        field(50305; "Default Receipt Bin"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bin.Code WHERE("Location Code" = FIELD(Code));
        }
        field(50306; "Sales Order Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50307; "Payment QR"; Blob)
        {
            SubType = Bitmap;
        }
        field(50308; "Startup Menu "; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Menu Header"."Menu ID";
        }
    }

    var
        myInt: Integer;
}