page 50395 "Bank Acc.Ledger Approval Code"
{
    ApplicationArea = All;
    Caption = 'Bank Acc.Ledger Approval Code';
    DataCaptionFields = "Bank Account No.";
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Bank Account Ledger Entry";
    SourceTableView = SORTING("Bank Account No.", "Posting Date")
                      ORDER(Descending) where(Open = filter(true));
    UsageCategory = Lists;
    Permissions = tabledata "Bank Account Ledger Entry" = RM;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the posting date for the entry.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the document type on the bank account entry. The document type will be Payment, Refund, or the field will be blank.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the document number on the bank account entry.';
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the bank account used for the entry.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the description of the bank account entry.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                    Visible = Dim1Visible;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                    Visible = Dim2Visible;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = AmountVisible;
                    Editable = false;
                    ToolTip = 'Specifies the amount of the entry denominated in the applicable foreign currency.';
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent debits.';
                    Editable = false;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent credits.';
                    Editable = false;
                }
                field(RunningBalance; CalcRunningAccBalance.GetBankAccBalance(Rec))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Running Balance';
                    ToolTip = 'Specifies the running balance.';
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    Editable = false;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount of the entry in LCY.';

                }
                field("Debit Amount (LCY)"; Rec."Debit Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent debits, expressed in LCY.';
                    Visible = DebCredAmountVisible and IsForeignCurrency;
                    Editable = false;
                }
                field("Credit Amount (LCY)"; Rec."Credit Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent credits, expressed in LCY.';
                    Visible = DebCredAmountVisible and IsForeignCurrency;
                    Editable = false;
                }
                field(RunningBalanceLCY; CalcRunningAccBalance.GetBankAccBalanceLCY(Rec))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Running Balance (LCY)';
                    ToolTip = 'Specifies the running balance in LCY.';
                    AutoFormatType = 1;
                    Editable = false;
                }

                field(Open; Rec.Open)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies whether the amount on the bank account entry has been fully applied to or if there is still a remaining amount that must be applied to.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';
                    Visible = false;
                }

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                }
                field("Approval Code"; Rec."Approval Code")
                {
                    ToolTip = 'Specifies the value of the Approval Code field.';
                    Editable = true;
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
            part(GLEntriesPart; "G/L Entries Part")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Related G/L Entries';
                ShowFilter = false;
                SubPageLink = "Posting Date" = field("Posting Date"), "Document No." = field("Document No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                Image = Entry;
                action("Check Ledger E&ntries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Check Ledger E&ntries';
                    Image = CheckLedger;
                    RunObject = Page "Check Ledger Entries";
                    RunPageLink = "Bank Account Ledger Entry No." = FIELD("Entry No.");
                    RunPageView = SORTING("Bank Account Ledger Entry No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View check ledger entries that result from posting transactions in a payment journal for the relevant bank account.';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        rec.ShowDimensions();
                    end;
                }
                action(SetDimensionFilter)
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Set Dimension Filter';
                    Ellipsis = true;
                    Image = "Filter";
                    ToolTip = 'Limit the entries according to the dimension filters that you specify. NOTE: If you use a high number of dimension combinations, this function may not work and can result in a message that the SQL server only supports a maximum of 2100 parameters.';

                    trigger OnAction()
                    begin
                        Rec.SetFilter("Dimension Set ID", DimensionSetIDFilter.LookupFilter());
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

            }
            action("&Navigate")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Find entries...';
                Image = Navigate;
                ShortCutKey = 'Ctrl+Alt+Q';
                ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';

                trigger OnAction()
                begin
                    Navigate.SetDoc(rec."Posting Date", rec."Document No.");
                    Navigate.Run();
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                // actionref("&Navigate_Promoted"; "&Navigate")
                // {
                // }
                // actionref("Reverse Transaction_Promoted"; rec."Reverse Transaction")
                // {
                // }
                // group(Category_Category4)
                // {
                //     Caption = 'Entry', Comment = 'Generated from the PromotedActionCategories property index 3.';

                //     actionref(Dimensions_Promoted; Dimensions)
                //     {
                //     }
                //     actionref(SetDimensionFilter_Promoted; SetDimensionFilter)
                //     {
                //     }
                //     actionref("Check Ledger E&ntries_Promoted"; "Check Ledger E&ntries")
                //     {
                //     }
                // }
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
            }
        }
    }

    // trigger OnOpenPage()
    // var
    //     GLSetup: Record "General Ledger Setup";
    //     BankAccount: Record "Bank Account";
    //     LocalCalcRunningAccBalance: Codeunit "Calc. Running Acc. Balance";
    // begin
    //     SetDimVisibility();
    //     BankAccount.SetLoadFields("Currency Code");
    //     if Rec.GetFilter("Bank Account No.") <> '' then begin
    //         if BankAccount.Get(Rec.GetRangeMin("Bank Account No.")) then
    //             IsForeignCurrency := BankAccount."Currency Code" <> '';
    //         BankAccount.Reset();
    //         Rec.CopyFilter("Bank Account No.", BankAccount."No.");
    //         if BankAccount.FindSet() then
    //             repeat
    //                 LocalCalcRunningAccBalance.FlushDayTotalsForNewestEntries(BankAccount."No.");
    //             until BankAccount.Next() = 0;
    //     end;
    //     GLSetup.SetLoadFields("Show Amounts");
    //     GLSetup.Get();
    //     AmountVisible := GLSetup."Show Amounts" in [GLSetup."Show Amounts"::"Amount Only", GLSetup."Show Amounts"::"All Amounts"];
    //     DebCredAmountVisible := GLSetup."Show Amounts" in [GLSetup."Show Amounts"::"Debit/Credit Only", GLSetup."Show Amounts"::"All Amounts"];

    // end;

    var
        CalcRunningAccBalance: Codeunit "Calc. Running Acc. Balance";
        Navigate: Page Navigate;
        DimensionSetIDFilter: Page "Dimension Set ID Filter";

    protected var
        Dim1Visible: Boolean;
        Dim2Visible: Boolean;
        Dim3Visible: Boolean;
        Dim4Visible: Boolean;
        Dim5Visible: Boolean;
        Dim6Visible: Boolean;
        Dim7Visible: Boolean;
        Dim8Visible: Boolean;
        AmountVisible: Boolean;
        DebCredAmountVisible: Boolean;
        IsForeignCurrency: Boolean;

    local procedure SetDimVisibility()
    var
        DimensionManagement: Codeunit DimensionManagement;
    begin
        DimensionManagement.UseShortcutDims(Dim1Visible, Dim2Visible, Dim3Visible, Dim4Visible, Dim5Visible, Dim6Visible, Dim7Visible, Dim8Visible);
    end;
}

