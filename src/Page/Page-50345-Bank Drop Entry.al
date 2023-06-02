page 50345 "Bank Drop Entry "
{
    ApplicationArea = All;
    Caption = 'Bank Drop Entry ';
    PageType = List;
    SourceTable = "Bank Drop Entry";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = all;
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Staff ID"; Rec."Staff ID")
                {
                    ToolTip = 'Specifies the value of the Staff ID field.';
                }
                field("Store No."; Rec."Store No.")
                {
                    ToolTip = 'Specifies the value of the Store No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    ToolTip = 'Specifies the value of the Bank Account field.';
                }
                field("Cash Account"; Rec."Cash Account")
                {
                    ToolTip = 'Specifies the value of the Cash Account field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Date"; Rec."Store Date")
                {
                    ToolTip = 'Specifies the value of the Store Date field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Create Contra Voucher")
            {
                ApplicationArea = all;
                Caption = 'Create Contra Voucher';
                Image = Entry;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Promoted = true;
                trigger OnAction()
                var
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    GenerateContraVoucher();
                end;
            }
        }
    }
    local procedure GenerateContraVoucher()
    var
        GenJourLine: record 81;
        GenJourLineFilter: record 81;
        NoSeriesMgt: Codeunit 396;
        BankAcc: Record 270;
        GLSetup: Record 98;
        Staff: Record "Staff Master";
        Loc: Record 14;
        GenJournalBatch: Record "Gen. Journal Batch";
    begin

        GLSetup.Get();
        IF Staff.Get(rec."Staff ID") then
            IF Loc.Get(Staff."Store No.") then;

        GLSetup.TestField("Bank Drop Batch");

        GenJourLineFilter.Reset();
        GenJourLineFilter.SetRange("Journal Template Name", 'CONTRA VO');
        GenJourLineFilter.SetRange("Journal Batch Name", GLSetup."Bank Drop Batch");

        GenJourLine.Init();
        GenJourLine."Journal Template Name" := 'CONTRA VO';
        GenJourLine."Journal Batch Name" := GLSetup."Bank Drop Batch";
        GenJourLine.Validate("Posting Date", Today);

        IF GenJourLineFilter.FindLast() then
            GenJourLine."Line No." := GenJourLineFilter."Line No." + 10000
        else
            GenJourLine."Line No." := 10000;


        GenJourLine.Insert(true);
        GenJourLine."Document No." := NoSeriesMgt.GetNextNo('CONTRA VO', Today, false);
        GenJourLine."Document Type" := GenJourLine."Document Type"::Payment;
        GenJourLine."Account Type" := GenJourLine."Account Type"::"G/L Account";
        GenJourLine.Validate("Account No.", rec."Cash Account");
        GenJourLine.Validate(Amount, rec.Amount * -1);
        GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"Bank Account";
        GenJourLine.Validate("Bal. Account No.", rec."Bank Account");

        GenJourLine.validate("Shortcut Dimension 1 Code", loc."Global Dimension 1 Code");
        GenJourLine.validate("Shortcut Dimension 2 Code", loc."Global Dimension 2 Code");
        // IF GenJournalBatch.Get(GenJourLine."Journal Template Name", GenJourLine."Journal Batch Name") then
        //     GenJournalBatch.TestField("Posting No. Series");
        // GenJourLine."Posting No. Series" := GenJournalBatch."Posting No. Series";
        GenJourLine.Comment := 'Auto Post';

        GenJourLine.Modify();
        Message('Contra Voucher Created with Docuemt No. %1 and Batch Name %2', GenJourLine."Document No.", GenJourLine."Journal Batch Name");
        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJourLine);
    end;


}
