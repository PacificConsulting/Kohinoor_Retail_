page 50389 "Tender Bank Acc. Reconciliate"
{
    Caption = 'Tender Bank Acc. Reconciliate';
    PageType = ListPlus;
    SaveValues = false;
    SourceTable = "Bank Acc. Reconciliation";
    SourceTableView = WHERE("Statement Type" = CONST("Bank Reconciliation"), Tender = filter(true));
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(BankAccountNo; rec."Bank Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Tender Account No.';
                    ToolTip = 'Specifies the number of the bank account that you want to reconcile with the bank''s statement.';
                    Editable = BankAccountNoIsEditable;
                    //Visible=false;

                    trigger OnValidate()
                    var
                        BankAccReconciliationLine: record "Bank Acc. Reconciliation Line";
                        BA: Record "Bank Account";
                        PM: Record "Payment Method";
                    begin
                        IF BA.get(Rec."Bank Account No.") then
                            IF BA.Tender = false then
                                Error('This Bank Account is not as Tender Account');
                        IF PM.Get(rec."Bank Account No.") then begin
                            rec."Reco. Account Type" := PM."Reco. Account Type";
                            rec."Reco. Account No." := PM."Reco. Account No.";
                        end;

                        if BankAccReconciliationLine.BankStatementLinesListIsEmpty(Rec."Statement No.", Rec."Statement Type", Rec."Bank Account No.") then
                            CreateEmptyListNotification();

                        if not WarnIfOngoingBankReconciliations(Rec."Bank Account No.") then
                            Error('');
                        CurrPage.ApplyBankLedgerEntries.Page.AssignBankAccReconciliation(Rec);
                        BankAccountNoIsEditable := false;
                        CheckBankAccLedgerEntriesAlreadyMatched();
                        CurrPage.Update(false);
                    end;
                }

                field(StatementNo; Rec."Statement No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statement No.';
                    ToolTip = 'Specifies the number of the bank account statement.';
                }
                field(StatementDate; Rec."Statement Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statement Date';
                    ToolTip = 'Specifies the date on the bank account statement.';
                    trigger OnValidate()
                    begin
                        //   CurrPage.ApplyBankLedgerEntries.Page.SetBankRecDateFilter(MatchCandidateFilterDate()); //PCPL/NSW/07
                    end;
                }
                field(BalanceLastStatement; Rec."Balance Last Statement")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Balance Last Statement';
                    ToolTip = 'Specifies the ending balance shown on the last bank statement, which was used in the last posted bank reconciliation for this bank account.';
                }
                field(StatementEndingBalance; Rec."Statement Ending Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statement Ending Balance';
                    ToolTip = 'Specifies the ending balance shown on the bank''s statement that you want to reconcile with the bank account.';
                }
                field("Reco. Account Type"; Rec."Reco. Account Type")
                {
                    ApplicationArea = all;
                }
                field("Reco. Account No."; Rec."Reco. Account No.")
                {
                    ApplicationArea = all;
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = all;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = all;
                }

            }
            group(Control8)
            {
                ShowCaption = false;
                part(StmtLine; "Tender Bank Acc Recon Lines")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Statement Lines';
                    SubPageLink = "Bank Account No." = FIELD("Bank Account No."),
                                  "Statement No." = FIELD("Statement No.");
                }
                part(ApplyBankLedgerEntries; "Tender Apply Bank Acc Leder")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account Ledger Entries';
                    SubPageLink = "Bank Account No." = FIELD("Bank Account No."),
                                  Open = CONST(true),
                                  "Statement Status" = FILTER(Open | "Bank Acc. Entry Applied" | "Check Entry Applied");
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Recon.")
            {
                Caption = '&Recon.';
                Image = BankAccountRec;
                action("&Card")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Bank Account Card';
                    Image = EditLines;
                    RunObject = Page "Bank Account Card";
                    RunPageLink = "No." = FIELD("Bank Account No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or change detailed information about the record that is being processed on the journal line.';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(SuggestLines)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Suggest Lines';
                    Ellipsis = true;
                    Image = SuggestLines;
                    ToolTip = 'Create bank account ledger entries suggestions and enter them automatically.';

                    trigger OnAction()
                    begin
                        RecallEmptyListNotification();
                        SuggestBankAccReconLines.SetStmt(Rec);
                        SuggestBankAccReconLines.RunModal();
                        Clear(SuggestBankAccReconLines);
                    end;
                }
                action(ShowReversedEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Reversed Entries';
                    Ellipsis = true;
                    Image = ReverseLines;
                    ToolTip = 'Include reversed bank account ledger entries in the list of suggestions.';

                    trigger OnAction()
                    begin
                        RecallEmptyListNotification();
                        CurrPage.ApplyBankLedgerEntries.Page.ShowReversed();
                    end;
                }
                action(HideReversedEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Hide Reversed Entries';
                    Ellipsis = true;
                    Image = FilterLines;
                    ToolTip = 'Hide unmatched reversed bank account ledger entries up to the statement date.';

                    trigger OnAction()
                    begin
                        RecallEmptyListNotification();
                        CurrPage.ApplyBankLedgerEntries.Page.HideReversed();
                    end;
                }
                action("Transfer to General Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transfer to General Journal';
                    Ellipsis = true;
                    Image = TransferToGeneralJournal;
                    ToolTip = 'Transfer the lines from the current window to the general journal.';

                    trigger OnAction()
                    var
                        TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
                    begin
                        CurrPage.StmtLine.PAGE.GetSelectedRecords(TempBankAccReconciliationLine);
                        TempBankAccReconciliationLine.Setrange(Difference, 0);
                        TempBankAccReconciliationLine.DeleteAll();
                        TempBankAccReconciliationLine.Setrange(Difference);
                        if TempBankAccReconciliationLine.IsEmpty() then
                            error(NoBankAccReconcilliationLineWithDiffSellectedErr);
                        TransBankRecToGenJnl.SetBankAccReconLine(TempBankAccReconciliationLine);
                        TransBankRecToGenJnl.SetBankAccRecon(Rec);
                        TransBankRecToGenJnl.Run();
                    end;
                }
                action("Create Contra Voucher")
                {
                    ApplicationArea = All;
                    Caption = 'Identify & Adjust Differenec';
                    Image = ContractPayment;
                    ToolTip = 'Transfer the lines from the current window to the general journal.';
                    trigger OnAction()
                    var
                        BankRecoLine: Record 274;
                        BankLedgerEntry: Record "Bank Account Ledger Entry";
                        GL: Record 81;
                        GenJnLine: Record 81;
                        PayMethod: Record "Payment Method";
                        GenJnlpost: Codeunit 12;
                        BRLInit: Record "Bank Acc. Reconciliation Line";
                        BankAccledEntryTemp: Record "Bank Account Ledger Entry" temporary;
                        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";

                        BRL: Record "Bank Acc. Reconciliation Line";
                        BRL11: Record "Bank Acc. Reconciliation Line";
                        MBEL: codeunit "Match Bank Rec. Lines";
                        BLE: Record "Bank Account Ledger Entry";
                        MatchBankRecLines: Codeunit "Match Bank Rec. Lines";
                        TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
                        TempBankAccountLedgerEntry: Record "Bank Account Ledger Entry" temporary;
                    begin
                        Clear(BankAccledEntryTemp);
                        IF PayMethod.Get(Rec."Bank Account No.") then begin
                            IF (PayMethod."Payment Type" in [PayMethod."Payment Type"::Finance]) then begin

                                BRl.Reset();
                                BRL.SetCurrentKey("Bank Account No.", "Statement No.", "Approval Code");
                                BRL.SetRange("Bank Account No.", rec."Bank Account No.");
                                BRL.SetRange("Statement No.", rec."Statement No.");
                                IF BRL.FindSet() then
                                    repeat
                                        BLE.Reset();
                                        BLE.SetCurrentKey("Bank Account No.", "Statement No.", "Approval Code");
                                        BLE.SetRange("Bank Account No.", BRL."Bank Account No.");
                                        BLE.SetRange("Approval Code", BRL."Approval Code");
                                        // IF PayMethod.Get(Rec."Bank Account No.") then begin
                                        //     IF (PayMethod."Payment Type" = PayMethod."Payment Type"::Finance) then
                                        //         BLE.SetRange(Amount, BRL."Statement Amount");
                                        // end;
                                        BLE.SetRange(Open, true);
                                        IF BLE.FindFirst() then
                                            repeat
                                                TempBankAccReconciliationLine.DeleteAll();
                                                TempBankAccountLedgerEntry.DeleteAll();
                                                BRL11.Reset();
                                                BRL11.SetRange("Bank Account No.", BLE."Bank Account No.");
                                                BRL11.SetRange("Approval Code", BLE."Approval Code");
                                                // IF PayMethod.Get(Rec."Bank Account No.") then begin
                                                //     IF (PayMethod."Payment Type" = PayMethod."Payment Type"::Finance) then
                                                //         BRL11.SetRange("Statement Amount", BLE.Amount);
                                                // end;
                                                IF BRL11.FindSet() then
                                                    repeat
                                                        TempBankAccReconciliationLine := BRL11;
                                                        TempBankAccReconciliationLine.Insert();
                                                    until BRL11.Next() = 0;
                                                TempBankAccountLedgerEntry := BLE;
                                                TempBankAccountLedgerEntry.Insert();
                                                MatchBankRecLines.MatchManually(TempBankAccReconciliationLine, TempBankAccountLedgerEntry);
                                            until BLE.Next() = 0;
                                    until BRL.Next() = 0;

                                //PCPL-BRB
                                BankRecoLine.Reset();
                                BankRecoLine.SetRange("Bank Account No.", rec."Bank Account No.");
                                BankRecoLine.SetFilter(Difference, '<%1', 0);
                                IF BankRecoLine.FindSet() then
                                    repeat
                                        BankLedgerEntry.Reset();
                                        BankLedgerEntry.SetRange("Bank Account No.", BankRecoLine."Bank Account No.");
                                        BankLedgerEntry.SetRange("Statement No.", BankRecoLine."Statement No.");
                                        BankLedgerEntry.SetRange("Statement Line No.", BankRecoLine."Statement Line No.");
                                        IF BankLedgerEntry.FindFirst() then begin
                                            //************Credit Amount****************
                                            BankAccledEntryTemp.Init();
                                            BankAccledEntryTemp := BankLedgerEntry;
                                            BankAccledEntryTemp.Insert();

                                            Gl.Reset();
                                            Gl.SetRange("Journal Template Name", 'CONTRAV');
                                            Gl.SetRange("Journal Batch Name", 'AUTO');
                                            GenJnLine.Init();
                                            GenJnLine."Journal Template Name" := 'CONTRAV';
                                            GenJnLine.validate("Journal Batch Name", 'AUTO');
                                            IF Gl.FindLast() then
                                                GenJnLine."Line No." := Gl."Line No." + 10000
                                            else
                                                GenJnLine."Line No." := 10000;

                                            GenJnLine.Validate("Posting Date", BankLedgerEntry."Posting Date");
                                            GenJnLine."Document Type" := GenJnLine."Document Type"::Payment;
                                            GenJnLine."Document No." := 'TENDERREC' + FORMAT(BankLedgerEntry."Statement No.") + FORMAT(BankLedgerEntry."Statement Line No.");
                                            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
                                            GenJnLine.Validate("Account No.", Rec."Bank Account No.");
                                            GenJnLine."Bal. Account Type" := GenJnLine."Bal. Account Type"::"G/L Account";
                                            GenJnLine.Validate("Credit Amount", BankLedgerEntry.Amount);
                                            BankLedgerEntry.CalcFields("Customer Name");
                                            GenJnLine.Description := BankLedgerEntry."Customer Name";
                                            GenJnLine."Approval Code" := BankLedgerEntry."Approval Code";
                                            GenJnLine.Validate("Shortcut Dimension 1 Code", BankLedgerEntry."Global Dimension 1 Code");
                                            GenJnLine.Validate("Shortcut Dimension 2 Code", BankLedgerEntry."Global Dimension 2 Code");
                                            GenJnLine."External Document No." := BankLedgerEntry."External Document No.";
                                            GenJnLine.Insert();
                                            //*************Applied Amount*************************
                                            Gl.Reset();
                                            Gl.SetRange("Journal Template Name", 'CONTRAV');
                                            Gl.SetRange("Journal Batch Name", 'AUTO');
                                            GenJnLine.Init();
                                            GenJnLine."Journal Template Name" := 'CONTRAV';
                                            GenJnLine.validate("Journal Batch Name", 'AUTO');
                                            IF Gl.FindLast() then
                                                GenJnLine."Line No." := Gl."Line No." + 10000
                                            else
                                                GenJnLine."Line No." := 10000;

                                            GenJnLine.Validate("Posting Date", BankLedgerEntry."Posting Date");
                                            GenJnLine."Document Type" := GenJnLine."Document Type"::Payment;
                                            //GenJnLine."Document No." := 'TENDERREC' + FORMAT(BankLedgerEntry."Statement Line No.");
                                            GenJnLine."Document No." := 'TENDERREC' + FORMAT(BankLedgerEntry."Statement No.") + FORMAT(BankLedgerEntry."Statement Line No.");
                                            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
                                            GenJnLine.Validate("Account No.", Rec."Bank Account No.");
                                            GenJnLine."Bal. Account Type" := GenJnLine."Bal. Account Type"::"G/L Account";
                                            GenJnLine.Validate("Debit Amount", BankRecoLine."Statement Amount");
                                            BankLedgerEntry.CalcFields("Customer Name");
                                            GenJnLine.Description := BankLedgerEntry."Customer Name";
                                            GenJnLine."Approval Code" := BankLedgerEntry."Approval Code";
                                            GenJnLine.Validate("Shortcut Dimension 1 Code", BankLedgerEntry."Global Dimension 1 Code");
                                            GenJnLine.Validate("Shortcut Dimension 2 Code", BankLedgerEntry."Global Dimension 2 Code");
                                            GenJnLine."External Document No." := BankLedgerEntry."External Document No.";
                                            GenJnLine.Insert();
                                            //*************Remaning Amount*************************
                                            Gl.Reset();
                                            Gl.SetRange("Journal Template Name", 'CONTRAV');
                                            Gl.SetRange("Journal Batch Name", 'AUTO');
                                            GenJnLine.Init();
                                            GenJnLine."Journal Template Name" := 'CONTRAV';
                                            GenJnLine.validate("Journal Batch Name", 'AUTO');
                                            IF Gl.FindLast() then
                                                GenJnLine."Line No." := Gl."Line No." + 10000
                                            else
                                                GenJnLine."Line No." := 10000;

                                            GenJnLine.Validate("Posting Date", BankLedgerEntry."Posting Date");
                                            GenJnLine."Document Type" := GenJnLine."Document Type"::Payment;
                                            //GenJnLine."Document No." := 'TENDERREC' + FORMAT(BankLedgerEntry."Statement Line No.");
                                            GenJnLine."Document No." := 'TENDERREC' + FORMAT(BankLedgerEntry."Statement No.") + FORMAT(BankLedgerEntry."Statement Line No.");
                                            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
                                            GenJnLine.Validate("Account No.", Rec."Bank Account No.");
                                            GenJnLine."Bal. Account Type" := GenJnLine."Bal. Account Type"::"G/L Account";
                                            GenJnLine.Validate("Debit Amount", ABS(BankRecoLine.Difference));
                                            BankLedgerEntry.CalcFields("Customer Name");
                                            GenJnLine.Description := BankLedgerEntry."Customer Name";
                                            GenJnLine."Approval Code" := BankLedgerEntry."Approval Code";
                                            GenJnLine.Validate("Shortcut Dimension 1 Code", BankLedgerEntry."Global Dimension 1 Code");
                                            GenJnLine.Validate("Shortcut Dimension 2 Code", BankLedgerEntry."Global Dimension 2 Code");
                                            GenJnLine."External Document No." := BankLedgerEntry."External Document No.";
                                            GenJnLine.Correction := false;
                                            GenJnLine.Insert();
                                        end;
                                    until BankRecoLine.Next() = 0;
                            end else
                                Error('Conta Voucher Allowed only for Finance.');
                        end;
                        //*****Auto Post Entry
                        //GenJnlpost.RunWithCheck(GenJnLine);
                        GenJnlPostBatch.Run(GenJnLine);

                        //************Bank Reconsilation Lines Creation*************************
                        IF PayMethod.Get(Rec."Bank Account No.") then begin
                            IF (PayMethod."Payment Type" in [PayMethod."Payment Type"::Finance]) then begin
                                if BankAccledEntryTemp.FindSet() then
                                    repeat
                                        //*******Negative Amount Entry
                                        BRLInit.Init();
                                        BRLInit."Statement Type" := BRLInit."Statement Type"::"Bank Reconciliation";
                                        BRLInit."Bank Account No." := Rec."Bank Account No.";
                                        BRLInit."Statement No." := rec."Statement No.";
                                        BankRecoLine.Reset();
                                        BankRecoLine.SetRange("Bank Account No.", rec."Bank Account No.");
                                        BankRecoLine.SetRange("Statement No.", Rec."Statement No.");
                                        IF BankRecoLine.FindLast() then
                                            BRLInit."Statement Line No." := BankRecoLine."Statement Line No." + 10000
                                        else
                                            BRLInit."Statement Line No." := 10000;

                                        //BRLInit."Transaction Date" := Today;
                                        BRLInit."Transaction Date" := BankAccledEntryTemp."Posting Date";
                                        //BRLInit.Description:=
                                        BRLInit."Document No." := BankAccledEntryTemp."External Document No.";
                                        BRLInit."Value Date" := BankAccledEntryTemp."Posting Date";
                                        BRLInit.Validate("Credit Amount", BankAccledEntryTemp.Amount);
                                        BRLInit."Approval Code" := BankAccledEntryTemp."Approval Code";
                                        BRLInit."External Document No." := BankAccledEntryTemp."External Document No.";
                                        BRLInit.Isledgerexist := true;
                                        BRLInit.Insert();
                                        //*******Postive Amount Entry
                                        BRLInit.Init();
                                        BRLInit."Statement Type" := BRLInit."Statement Type"::"Bank Reconciliation";
                                        BRLInit."Bank Account No." := Rec."Bank Account No.";
                                        BRLInit."Statement No." := rec."Statement No.";
                                        BankRecoLine.Reset();
                                        BankRecoLine.SetRange("Bank Account No.", rec."Bank Account No.");
                                        BankRecoLine.SetRange("Statement No.", Rec."Statement No.");
                                        IF BankRecoLine.FindLast() then
                                            BRLInit."Statement Line No." := BankRecoLine."Statement Line No." + 10000
                                        else
                                            BRLInit."Statement Line No." := 10000;

                                        BRLInit."Transaction Date" := BankAccledEntryTemp."Posting Date";
                                        BankAccledEntryTemp.CalcFields("Customer Name");
                                        BRLInit.Description := BankAccledEntryTemp."Customer Name";
                                        BRLInit."Value Date" := BankAccledEntryTemp."Posting Date";
                                        BRLInit.Validate("Debit Amount", BankAccledEntryTemp.Amount);
                                        BRLInit."Approval Code" := BankAccledEntryTemp."Approval Code";
                                        BRLInit."External Document No." := BankAccledEntryTemp."External Document No.";
                                        BRLInit.Isledgerexist := true;
                                        BRLInit.Insert();
                                    until BankAccledEntryTemp.Next() = 0;
                            end;
                        end;
                        Message('Entry Created and posted succesfully');
                    end;
                    //************

                    //end;

                }

                action(ChangeStatementNo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Change Statement No.';
                    Ellipsis = true;
                    Image = ChangeTo;
                    ToolTip = 'Change the statement number of the bank account reconciliation. Typically, this is used when you have created a new reconciliation to correct a mistake, and you want to use the same statement number.';

                    trigger OnAction()
                    var
                        BankAccReconciliation: Record "Bank Acc. Reconciliation";
                        BankAccReconciliationCard: Page "Bank Acc. Reconciliation";
                    begin
                        BankAccReconciliation := Rec;
                        Codeunit.Run(Codeunit::"Change Bank Rec. Statement No.", BankAccReconciliation);
                        if Rec."Statement No." <> BankAccReconciliation."Statement No." then begin
                            BankAccReconciliationCard.SetRecord(BankAccReconciliation);
                            BankAccReconciliationCard.Run();
                            CurrPage.Close();
                        end;
                    end;
                }
            }
            group("Ba&nk")
            {
                Caption = 'Ba&nk';
                action(ImportBankStatement)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import Bank Statement';
                    Image = Import;
                    ToolTip = 'Import electronic bank statements from your bank to populate with data about actual bank transactions.';

                    trigger OnAction()
                    begin
                        CurrPage.Update();
                        Rec.ImportBankStatement();
                        CheckStatementDate();
                        RecallEmptyListNotification();
                    end;
                }
            }
            group("M&atching")
            {
                Caption = 'M&atching';//
                action(MatchAutomatically)
                {
                    ApplicationArea = All;
                    Caption = 'Match Auto With Approval Code';
                    Image = MapAccounts;
                    ToolTip = 'Automatically search for and match bank statement lines.';
                    trigger OnAction()
                    var
                        BRL: Record "Bank Acc. Reconciliation Line";
                        BRL11: Record "Bank Acc. Reconciliation Line";
                        MBEL: codeunit "Match Bank Rec. Lines";
                        BLE: Record "Bank Account Ledger Entry";
                        MatchBankRecLines: Codeunit "Match Bank Rec. Lines";
                        TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
                        TempBankAccountLedgerEntry: Record "Bank Account Ledger Entry" temporary;
                        PayMethod: record "Payment Method";
                        vApprovalCode: Code[20];
                        vApprovalCodechild: Code[20];
                        StatementNoLineApplied: Code[20];
                    begin
                        /*
                        BRl.Reset();
                        BRL.SetCurrentKey("Bank Account No.", "Statement No.", "Approval Code");
                        BRL.SetRange("Bank Account No.", rec."Bank Account No.");
                        BRL.SetRange("Statement No.", rec."Statement No.");
                        IF BRL.FindSet() then
                            repeat
                                BLE.Reset();
                                BLE.SetCurrentKey("Bank Account No.", "Statement No.", "Approval Code");
                                BLE.SetRange("Bank Account No.", BRL."Bank Account No.");
                                BLE.SetRange("Approval Code", BRL."Approval Code");
                                BLE.SetRange(Open, true);
                                IF BLE.FindFirst() then
                                    repeat
                                        TempBankAccReconciliationLine.DeleteAll();
                                        TempBankAccountLedgerEntry.DeleteAll();
                                        TempBankAccReconciliationLine := BRL;
                                        TempBankAccReconciliationLine.Insert();
                                        TempBankAccountLedgerEntry := BLE;
                                        TempBankAccountLedgerEntry.Insert();
                                        MatchBankRecLines.MatchManually(TempBankAccReconciliationLine, TempBankAccountLedgerEntry);
                                    until BLE.Next() = 0;
                            until BRL.Next() = 0;
                        */
                        BRl.Reset();
                        BRL.SetCurrentKey("Bank Account No.", "Statement No.", "Approval Code");
                        BRL.SetRange("Bank Account No.", rec."Bank Account No.");
                        BRL.SetRange("Statement No.", rec."Statement No.");
                        IF BRL.FindSet() then
                            repeat
                                BLE.Reset();
                                BLE.SetCurrentKey("Bank Account No.", "Statement No.", "Approval Code");
                                BLE.SetRange("Bank Account No.", BRL."Bank Account No.");
                                BLE.SetRange("Approval Code", BRL."Approval Code");
                                BLE.SetRange(Reversed, false);   //skip reverse entry 


                                // BLE.SetRange(Amount, BRL."Statement Amount");    //PCPL-BRB 21082023
                                IF PayMethod.Get(Rec."Bank Account No.") then begin
                                    IF (PayMethod."Payment Type" = PayMethod."Payment Type"::Finance) then
                                        BLE.SetRange(Amount, BRL."Statement Amount");
                                end;
                                BLE.SetRange(Open, true);
                                IF BLE.FindFirst() then
                                    repeat
                                        TempBankAccReconciliationLine.DeleteAll();
                                        TempBankAccountLedgerEntry.DeleteAll();
                                        BRL11.Reset();
                                        BRL11.SetRange("Bank Account No.", BLE."Bank Account No.");
                                        BRL11.SetRange("Approval Code", BLE."Approval Code");

                                        // BRL11.SetRange("Statement Amount", BLE.Amount);  //PCPL-BRB 21082023
                                        IF PayMethod.Get(Rec."Bank Account No.") then begin
                                            IF (PayMethod."Payment Type" = PayMethod."Payment Type"::Finance) then
                                                BRL11.SetRange("Statement Amount", BLE.Amount);
                                        end;
                                        IF BRL11.FindSet() then
                                            repeat
                                                TempBankAccReconciliationLine := BRL11;
                                                TempBankAccReconciliationLine.Insert();
                                            until BRL11.Next() = 0;
                                        TempBankAccountLedgerEntry := BLE;
                                        TempBankAccountLedgerEntry.Insert();
                                        MatchBankRecLines.MatchManually(TempBankAccReconciliationLine, TempBankAccountLedgerEntry);
                                    until BLE.Next() = 0;
                            until BRL.Next() = 0;

                        //BRB
                        IF PayMethod.Get(Rec."Bank Account No.") then begin
                            IF (PayMethod."Payment Type" in [PayMethod."Payment Type"::Finance]) then begin

                                BRl.Reset();
                                BRL.SetCurrentKey("Bank Account No.", "Statement No.", "Approval Code");
                                BRL.SetRange("Bank Account No.", rec."Bank Account No.");
                                BRL.SetRange("Statement No.", rec."Statement No.");
                                BRL.SetFilter(Difference, '>%1', 0);
                                IF BRL.FindSet() then
                                    repeat
                                        //IF vApprovalCode <> BRL."Approval Code" THEN begin
                                        BLE.Reset();
                                        BLE.SetCurrentKey("Bank Account No.", "Statement No.", "Approval Code");
                                        BLE.SetRange("Bank Account No.", BRL."Bank Account No.");
                                        BLE.SetRange("Approval Code", BRL."Approval Code");
                                        BLE.SetRange(Reversed, false);   //skip reverse entry
                                        BLE.SetRange(Open, true);
                                        IF BLE.FindFirst() then
                                            repeat
                                                TempBankAccReconciliationLine.DeleteAll();
                                                TempBankAccountLedgerEntry.DeleteAll();
                                                BRL11.Reset();
                                                BRL11.SetRange("Bank Account No.", BLE."Bank Account No.");
                                                BRL11.SetRange("Approval Code", BLE."Approval Code");
                                                IF BRL11.FindSet() then
                                                    repeat
                                                        TempBankAccReconciliationLine := BRL11;
                                                        TempBankAccReconciliationLine.Insert();
                                                    until BRL11.Next() = 0;
                                                TempBankAccountLedgerEntry := BLE;
                                                TempBankAccountLedgerEntry.Insert();
                                                if vApprovalCodechild <> BLE."Approval Code" then
                                                    MatchBankRecLines.MatchManually(TempBankAccReconciliationLine, TempBankAccountLedgerEntry);
                                                vApprovalCodechild := BLE."Approval Code";
                                            until BLE.Next() = 0;
                                    // vApprovalCode := BRL."Approval Code";
                                    //  END;
                                    until BRL.Next() = 0;

                                //For difference 
                                BRl.Reset();
                                BRL.SetCurrentKey("Bank Account No.", "Statement No.", "Approval Code");
                                BRL.SetRange("Bank Account No.", rec."Bank Account No.");
                                BRL.SetRange("Statement No.", rec."Statement No.");
                                BRL.SetFilter(Difference, '>%1', 0);
                                if BRL.FindSet then
                                    repeat
                                        BLE.Reset();
                                        BLE.SetCurrentKey("Bank Account No.", "Statement No.", "Approval Code");
                                        BLE.SetRange("Bank Account No.", BRL."Bank Account No.");
                                        BLE.SetRange("Approval Code", BRL."Approval Code");
                                        BLE.SetRange(Reversed, false);   //skip reverse entry
                                        BLE.SetRange(Open, true);
                                        IF BLE.FindFirst() then
                                            repeat
                                                StatementNoLineApplied := BLE.GetAppliedStatementNo();
                                                if StatementNoLineApplied = '' then begin
                                                    TempBankAccReconciliationLine.DeleteAll();
                                                    TempBankAccountLedgerEntry.DeleteAll();
                                                    BRL11.Reset();
                                                    BRL11.SetCurrentKey("Bank Account No.", "Statement No.", "Approval Code");
                                                    BRL11.SetRange("Bank Account No.", BLE."Bank Account No.");
                                                    BRL11.SetRange("Approval Code", BLE."Approval Code");
                                                    BRL11.SetRange(Difference, BLE.Amount);
                                                    IF BRL11.FindSet() then
                                                        repeat
                                                            TempBankAccReconciliationLine := BRL11;
                                                            TempBankAccReconciliationLine.Insert();
                                                        until BRL11.Next() = 0;
                                                    TempBankAccountLedgerEntry := BLE;
                                                    TempBankAccountLedgerEntry.Insert();
                                                    // if vApprovalCodechild <> BLE."Approval Code" then
                                                    MatchBankRecLines.MatchManually(TempBankAccReconciliationLine, TempBankAccountLedgerEntry);
                                                    //vApprovalCodechild := BLE."Approval Code";
                                                end;
                                            until BLE.Next() = 0;

                                    until BRL.Next() = 0;

                            end;
                        end;
                    end;

                }
                /*
                action(MatchAutomaticallyNew)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Match Automatically New';
                    Image = MapAccounts;
                    ToolTip = 'Automatically search for and match bank statement lines.';

                    trigger OnAction()
                    var
                        BRL: Record "Bank Acc. Reconciliation Line";
                        MBEL: codeunit "Match Bank Rec. Lines";
                        BLE: Record "Bank Account Ledger Entry";
                        MatchBankRecLines: Codeunit "Match Bank Rec. Lines";
                        TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
                        TempBankAccountLedgerEntry: Record "Bank Account Ledger Entry" temporary;
                    begin
                        BRl.Reset();
                        BRL.SetCurrentKey("Bank Account No.", "Statement No.", "Approval Code");
                        BRL.SetRange("Bank Account No.", rec."Bank Account No.");
                        BRL.SetRange("Statement No.", rec."Statement No.");
                        IF BRL.FindSet() then
                            repeat
                                BLE.Reset();
                                BLE.SetCurrentKey("Bank Account No.", "Statement No.", "Approval Code");
                                BLE.SetRange("Bank Account No.", BRL."Bank Account No.");
                                BLE.SetRange("Approval Code", BRL."Approval Code");
                                IF BLE.FindFirst() then
                                    repeat
                                        TempBankAccReconciliationLine.DeleteAll();
                                        TempBankAccountLedgerEntry.DeleteAll();
                                        TempBankAccReconciliationLine := BRL;
                                        TempBankAccReconciliationLine.Insert();
                                        TempBankAccountLedgerEntry := BLE;
                                        TempBankAccountLedgerEntry.Insert();
                                        MatchBankRecLines.MatchManually(TempBankAccReconciliationLine, TempBankAccountLedgerEntry);
                                    until BLE.Next() = 0;
                            until BRL.Next() = 0;
                    end;

                }
                */
                action(MatchManually)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Match Manually';
                    Image = CheckRulesSyntax;
                    ToolTip = 'Manually match selected lines in both panes to link each bank statement line to one or more related bank account ledger entries.';

                    trigger OnAction()
                    var
                        TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
                        TempBankAccountLedgerEntry: Record "Bank Account Ledger Entry" temporary;
                        MatchBankRecLines: Codeunit "Match Bank Rec. Lines";
                    begin
                        CurrPage.StmtLine.PAGE.GetSelectedRecords(TempBankAccReconciliationLine);
                        CurrPage.ApplyBankLedgerEntries.PAGE.GetSelectedRecords(TempBankAccountLedgerEntry);
                        if ConfirmSelectedEntriesWithExternalMatchForModification(TempBankAccountLedgerEntry) then
                            MatchBankRecLines.MatchManually(TempBankAccReconciliationLine, TempBankAccountLedgerEntry);
                    end;
                }
                action(RemoveMatch)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Remove Match';
                    Image = RemoveContacts;
                    ToolTip = 'Remove selection of matched bank statement lines.';

                    trigger OnAction()
                    var
                        TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
                        TempBankAccountLedgerEntry: Record "Bank Account Ledger Entry" temporary;
                        MatchBankRecLines: Codeunit "Match Bank Rec. Lines";
                    begin
                        CurrPage.StmtLine.PAGE.GetSelectedRecords(TempBankAccReconciliationLine);
                        CurrPage.ApplyBankLedgerEntries.PAGE.GetSelectedRecords(TempBankAccountLedgerEntry);
                        if ConfirmSelectedEntriesWithExternalMatchForModification(TempBankAccountLedgerEntry) then
                            MatchBankRecLines.RemoveMatch(TempBankAccReconciliationLine, TempBankAccountLedgerEntry);
                    end;
                }
                action(MatchDetails)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Match Details';
                    Image = ViewDetails;
                    ToolTip = 'Show matching details about the selected bank statement line.';

                    trigger OnAction()
                    var
                        TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
                    begin
                        CurrPage.StmtLine.PAGE.GetSelectedRecords(TempBankAccReconciliationLine);
                        if TempBankAccReconciliationLine."Applied Entries" > 0 then
                            Page.Run(Page::"Bank Rec. Line Match Details", TempBankAccReconciliationLine);
                    end;
                }
                action(All)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show All';
                    Image = AddWatch;
                    ToolTip = 'Show all bank statement lines.';

                    trigger OnAction()
                    begin
                        CurrPage.StmtLine.PAGE.ToggleMatchedFilter(false);
                        CurrPage.ApplyBankLedgerEntries.Page.ShowAll();
                    end;
                }
                action(NotMatched)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Nonmatched';
                    Image = AddWatch;
                    ToolTip = 'Show all bank statement lines that have not yet been matched.';

                    trigger OnAction()
                    begin
                        CurrPage.StmtLine.PAGE.ToggleMatchedFilter(true);
                        CurrPage.ApplyBankLedgerEntries.Page.ShowNonMatched();
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("&Test Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'Preview the resulting bank account reconciliations to see the consequences before you perform the actual posting.';

                    trigger OnAction()
                    var
                        BankAccRecTestRepVisible: Codeunit "Bank Acc.Rec.Test Rep. Visible";
                    begin
                        // To configure the report and log troubleshooting telemetry we bind subscribers.
                        // the report is not directly configurable since it uses ReportSelections
                        Rec.TestField("Journal Template Name");
                        Rec.TestField("Journal Batch Name");
                        BindSubscription(BankAccRecTestRepVisible);
                        TestReportPrint.PrintBankAccRecon(Rec);
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    RunObject = Codeunit "Bank Acc. Recon. Post (Yes/No)";
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';
                }
                action(PostAndPrint)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    var
                        BankAccRecTestRepVisible: Codeunit "Bank Acc.Rec.Test Rep. Visible";
                        BankAccReconPostPrint: Codeunit "Bank Acc. Recon. Post+Print";
                    begin
                        BindSubscription(BankAccRecTestRepVisible);
                        BankAccReconPostPrint.Run(Rec);
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                actionref("Transfer to General Journal_Promoted"; "Transfer to General Journal")
                {
                }
                actionref("Create Contra Voucher."; "Create Contra Voucher")
                {

                }
                actionref(SuggestLines_Promoted; SuggestLines)
                {
                }
                group(Category_Category6)
                {
                    Caption = 'Posting', Comment = 'Generated from the PromotedActionCategories property index 5.';
                    ShowAs = SplitButton;

                    actionref(Post_Promoted; Post)
                    {
                    }
                    actionref(PostAndPrint_Promoted; PostAndPrint)
                    {
                    }
                    actionref("&Test Report_Promoted"; "&Test Report")
                    {
                    }
                }
            }
            group(Category_Category4)
            {
                Caption = 'Bank', Comment = 'Generated from the PromotedActionCategories property index 3.';

                actionref(ImportBankStatement_Promoted; ImportBankStatement)
                {
                }
                actionref("&Card_Promoted"; "&Card")
                {
                }
            }
            group(Category_Category5)
            {
                Caption = 'Matching', Comment = 'Generated from the PromotedActionCategories property index 4.';

                actionref(MatchManually_Promoted; MatchManually)
                {
                }
                actionref(MatchAutomatically_Promoted; MatchAutomatically)
                {
                }
                actionref(RemoveMatch_Promoted; RemoveMatch)
                {
                }
                actionref(MatchDetails_Promoted; MatchDetails)
                {
                }
            }
            group(Category_Show)
            {
                Caption = 'Show';

                actionref(All_Promoted; All)
                {
                }
                actionref(ShowReversedEntries_Promoted; ShowReversedEntries)
                {
                }
                actionref(HideReversedEntries_Promoted; HideReversedEntries)
                {
                }
                actionref(NotMatched_Promoted; NotMatched)
                {
                }
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
            }
        }
    }

    trigger OnOpenPage()
    var
        FeatureTelemetry: Codeunit "Feature Telemetry";
    begin
        //FeatureTelemetry.LogUptake('0000JLL', Rec.GetBankReconciliationTelemetryFeatureName(), Enum::"Feature Uptake Status"::Discovered);
        //FeatureTelemetry.LogUptake('0000JM9', Rec.GetBankReconciliationTelemetryFeatureName(), Enum::"Feature Uptake Status"::"Set up");
        CreateEmptyListNotification();

        if (Rec."Bank Account No." <> '') then begin
            BankAccountNoIsEditable := false;
            CheckBankAccLedgerEntriesAlreadyMatched();
            CurrPage.ApplyBankLedgerEntries.Page.AssignBankAccReconciliation(Rec);
            //CurrPage.ApplyBankLedgerEntries.Page.SetBankRecDateFilter(Rec.MatchCandidateFilterDate()); //PCPL/NSW/07
        end
        else
            BankAccountNoIsEditable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        BankAccount: Record "Bank Account";
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
        BankAccountNumber: Code[20];
    begin
        if (Rec."Bank Account No." <> '') then
            exit;
        if BankAccount.FindSet() then begin
            BankAccountNumber := BankAccount."No.";
            if BankAccount.Next() = 0 then begin
                Rec."Statement Type" := BankAccReconciliation."Statement Type"::"Bank Reconciliation";
                Rec.Validate("Bank Account No.", BankAccountNumber);
            end;
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        RecallEmptyListNotification();
        Rec.Tender := true;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if UpdatedBankAccountLESystemId <> Rec.SystemId then
            UpdatedBankAccountLESystemId := Rec.SystemId;
        CurrPage.ApplyBankLedgerEntries.Page.AssignBankAccReconciliation(Rec);
    end;

#if not CLEAN22
    internal procedure UpdateBankAccountLedgerEntrySubpageOnAfterSetFilters(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    begin
        OnUpdateBankAccountLedgerEntrySubpageOnAfterSetFilters(BankAccountLedgerEntry);
    end;
#endif

    local procedure GetImportBankStatementNotificatoinId(): Guid
    begin
        exit('aa54bf06-b8b9-420d-a4a8-1f55a3da3e2a');
    end;

    local procedure CreateEmptyListNotification()
    var
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        ImportBankStatementNotification: Notification;
    begin
        ImportBankStatementNotification.Id := GetImportBankStatementNotificatoinId();
        if ImportBankStatementNotification.Recall() then;
        if not BankAccReconciliationLine.BankStatementLinesListIsEmpty(Rec."Statement No.", Rec."Statement Type", Rec."Bank Account No.") then
            exit;

        ImportBankStatementNotification.Message := ListEmptyMsg;
        ImportBankStatementNotification.Scope := NotificationScope::LocalScope;
        ImportBankStatementNotification.Send();
    end;

    local procedure RecallEmptyListNotification()
    var
        ImportBankStatementNotification: Notification;
    begin
        ImportBankStatementNotification.Id := GetImportBankStatementNotificatoinId();
        if ImportBankStatementNotification.Recall() then;
    end;

    local procedure CheckStatementDate()
    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
    begin
        BankAccReconciliationLine.SetFilter("Bank Account No.", Rec."Bank Account No.");
        BankAccReconciliationLine.SetFilter("Statement No.", Rec."Statement No.");
        BankAccReconciliationLine.SetCurrentKey("Transaction Date");
        BankAccReconciliationLine.Ascending := false;
        if BankAccReconciliationLine.FindFirst() then begin
            BankAccReconciliation.GetBySystemId(Rec.SystemId);
            if BankAccReconciliation."Statement Date" = 0D then begin
                if Confirm(StrSubstNo(StatementDateEmptyMsg, Format(BankAccReconciliationLine."Transaction Date"))) then begin
                    Rec."Statement Date" := BankAccReconciliationLine."Transaction Date";
                    Rec.Modify();
                end;
            end else
                if BankAccReconciliation."Statement Date" < BankAccReconciliationLine."Transaction Date" then
                    Message(ImportedLinesAfterStatementDateMsg);
            // CurrPage.ApplyBankLedgerEntries.Page.SetBankRecDateFilter(BankAccReconciliation.MatchCandidateFilterDate()); PCPL/NSW/07
        end;
    end;

    local procedure WarnIfOngoingBankReconciliations(BankAccountNoCode: Code[20]): Boolean
    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
    begin
        BankAccReconciliation.SetRange("Bank Account No.", BankAccountNoCode);
        BankAccReconciliation.SetRange("Statement Type", BankAccReconciliation."Statement Type"::"Bank Reconciliation");
        if not BankAccReconciliation.FindSet() then
            exit(true);
        repeat
            if BankAccReconciliation."Statement No." <> Rec."Statement No." then
                exit(Dialog.Confirm(StrSubstNo(IgnoreExistingBankAccReconciliationAndContinueQst)));
        until BankAccReconciliation.Next() = 0;
        exit(true);
    end;

    local procedure ConfirmSelectedEntriesWithExternalMatchForModification(var TempBankAccountLedgerEntry: Record "Bank Account Ledger Entry" temporary): Boolean
    var
        ReturnValue: Boolean;
    begin
        TempBankAccountLedgerEntry.SetFilter("Statement No.", '<> %1 & <> ''''', Rec."Statement No.");
        if TempBankAccountLedgerEntry.IsEmpty() then
            ReturnValue := true
        else begin
            ReturnValue := Confirm(ModifyBankAccLedgerEntriesForModificationQst, false);
            //if ReturnValue then PCPL/NSW/07
            //  Session.LogMessage('0000JLM', '', Verbosity::Warning, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', Rec.GetBankReconciliationTelemetryFeatureName()); PCPL/NSW/07
        end;

        TempBankAccountLedgerEntry.SetRange("Statement No.");
        TempBankAccountLedgerEntry.FindSet();
        exit(ReturnValue);
    end;

    local procedure CheckBankAccLedgerEntriesAlreadyMatched()
    var
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
    begin
        BankAccountLedgerEntry.SetRange("Bank Account No.", Rec."Bank Account No.");
        BankAccountLedgerEntry.SetRange(Open, true);
        BankAccountLedgerEntry.SetFilter("Statement No.", '<> %1 & <> ''''', Rec."Statement No.");
        BankAccountLedgerEntry.SetFilter("Statement Status", '<> Closed');
        if (Rec."Statement Date" <> 0D) then
            BankAccountLedgerEntry.SetFilter("Posting Date", '<= %1', Rec."Statement Date");

        if not BankAccountLedgerEntry.IsEmpty() then
            Message(ExistingBankAccReconciliationAndContinueMsg);
    end;

    var
        SuggestBankAccReconLines: Report "Suggest Bank Acc. Recon. Lines";
        TransBankRecToGenJnl: Report "Trans. Bank Rec. to Gen. Jnl.";
        TestReportPrint: Codeunit "Test Report-Print";
        BankAccountNoIsEditable: Boolean;
        ListEmptyMsg: Label 'No bank statement lines exist. Choose the Import Bank Statement action to fill in the lines from a file, or enter lines manually.';
        ImportedLinesAfterStatementDateMsg: Label 'There are lines on the imported bank statement with dates that are after the statement date.';
        StatementDateEmptyMsg: Label 'The bank account reconciliation does not have a statement date. %1 is the latest date on a line. Do you want to use that date for the statement?', Comment = '%1 - statement date';
        NoBankAccReconcilliationLineWithDiffSellectedErr: Label 'Select the bank statement lines that have differences to transfer to the general journal.';
        UpdatedBankAccountLESystemId: Guid;
        IgnoreExistingBankAccReconciliationAndContinueQst: Label 'There are ongoing reconciliations for this bank account. \\Do you want to continue?';
        ExistingBankAccReconciliationAndContinueMsg: Label 'There are ongoing reconciliations for this bank account in which entries are matched.';
        ModifyBankAccLedgerEntriesForModificationQst: Label 'One or more of the selected entries have been matched on another bank account reconciliation.\\Do you want to continue?';

#if not CLEAN22
    [Obsolete('Use the event OnAfterApplyControledFilters in ApplyBankLedferEntries.Page.al', '22.0')]
    [IntegrationEvent(false, false)]
    local procedure OnUpdateBankAccountLedgerEntrySubpageOnAfterSetFilters(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    begin
    end;
#endif
}