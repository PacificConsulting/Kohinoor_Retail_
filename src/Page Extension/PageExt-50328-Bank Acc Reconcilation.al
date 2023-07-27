pageextension 50328 "Bank Acc reconcilation" extends "Bank Acc. Reconciliation"
{
    layout
    {
        modify(BankAccountNo)
        {
            trigger OnAfterValidate()
            var
                BA: Record "Bank Account";
            begin
                IF BA.get(Rec."Bank Account No.") then
                    IF BA.Tender then
                        Error('This Bank Account is define as Tender Account');
            end;
        }

    }
    actions
    {
        addafter(MatchAutomatically)
        {
            // action(Tender)
            // {
            //     ApplicationArea = all;
            //     PromotedCategory = New;
            //     Promoted = true;
            //     PromotedOnly = true;
            //     trigger OnAction()
            //     begin
            //         rec.Tender := true;
            //         rec.Modify();

            //     end;

            // }
            action(MatchAutoApproval)
            {
                ApplicationArea = All;
                Caption = 'Match Auto With Approval Code';
                Image = MapAccounts;
                ToolTip = 'Automatically search for and match bank statement lines.';
                PromotedCategory = New;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    BRL: Record "Bank Acc. Reconciliation Line";
                    BRL11: Record "Bank Acc. Reconciliation Line";
                    MBEL: codeunit "Match Bank Rec. Lines";
                    BLE: Record "Bank Account Ledger Entry";
                    MatchBankRecLines: Codeunit "Match Bank Rec. Lines";
                    TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
                    TempBankAccountLedgerEntry: Record "Bank Account Ledger Entry" temporary;
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
                                    MatchBankRecLines.MatchManually(TempBankAccReconciliationLine, TempBankAccountLedgerEntry);
                                until BLE.Next() = 0;
                        until BRL.Next() = 0;
                end;

            }
        }
    }
    trigger OnOpenPage()
    begin
        rec.FilterGroup(2);
        rec.SetFilter(Tender, '%1', false);
        rec.FilterGroup(0);
    end;

    trigger OnAfterGetRecord()
    begin
        rec.FilterGroup(2);
        rec.SetFilter(Tender, '%1', false);
        rec.FilterGroup(0);
    end;
}
