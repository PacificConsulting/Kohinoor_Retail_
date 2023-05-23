table 50323 "Tender POS No.Series Setup"
{
    Caption = 'Tender POS No.Series Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code where(Store = filter(true));
        }
        field(2; "Journal Template Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Gen. Journal Batch"."Journal Template Name";
        }
        field(3; "Journal Batch Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Gen. Journal Batch".Name;
        }
        field(4; "Cash Voucher No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(5; "Tender Voucher No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "Location Code")
        {
            Clustered = true;
        }
    }
}
