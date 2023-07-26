tableextension 50330 "Bank Acc. Reconciliation Ext" extends "Bank Acc. Reconciliation"
{
    fields
    {
        // modify("Bank Account No.")
        // {
        //     // trigger OnAfterValidate()
        //     // var
        //     //     BA: Record "Bank Account";
        //     // begin
        //     //     IF BA.get("Bank Account No.") then
        //     //         IF BA.Tender = false then
        //     //             Error('This Bank Account is not as Tender Account');
        //     // end;
        // }

        field(50301; Tender; Boolean)
        {
            Caption = 'Tender';
            DataClassification = ToBeClassified;
        }
        field(50303; "Reco. Account Type"; enum "Payment Balance Account Type")
        {
            Caption = 'Reco. Account Type';

        }
        field(50304; "Reco. Account No."; Code[20])
        {
            Caption = 'Reco. Account No.';
            TableRelation = IF ("Reco. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Reco. Account Type" = CONST("Bank Account")) "Bank Account" where(Tender = filter(false));
        }
        field(50305; "Journal Template Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(50306; "Journal Batch Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            trigger OnLookup()
            var
                GenJnlTemplate: Record "Gen. Journal Template";
                GenJnlBatch: Record "Gen. Journal Batch";
            begin
                //GenJnlLine.TestField("Journal Template Name");
                GenJnlTemplate.Get("Journal Template Name");
                GenJnlBatch.FilterGroup(2);
                GenJnlBatch.SetRange("Journal Template Name", "Journal Template Name");
                GenJnlBatch.FilterGroup(0);
                GenJnlBatch.Name := "Journal Batch Name";
                if GenJnlBatch.Find('=><') then;
                if PAGE.RunModal(0, GenJnlBatch) = ACTION::LookupOK then begin
                    "Journal Batch Name" := GenJnlBatch.Name;

                end;
            end;

            trigger OnValidate()
            var
                GenJnlBatch: Record "Gen. Journal Batch";
            begin
                TestField("Journal Template Name");
                GenJnlBatch.Get("Journal Template Name", "Journal Batch Name");
            end;
        }


    }
}
