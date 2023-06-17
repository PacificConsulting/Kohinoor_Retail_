page 50320 "Bank Drop Entry"
{
    APIGroup = 'BankGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v10.0';
    ApplicationArea = All;
    Caption = 'bankDropEntry';
    DelayedInsert = true;
    EntityName = 'BankDropEntry';
    EntitySetName = 'BankDropEntrys';
    PageType = API;
    SourceTable = "Bank Drop Entry";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {//

                field(staffID; Rec."Staff ID")
                {
                    Caption = 'Staff ID';
                }
                field(storeNo; Rec."Store No.")
                {
                    Caption = 'Store No.';

                }
                field("date"; Rec."Store Date")
                {
                    Caption = 'Store Date';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }

                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        NoSeries: Codeunit NoSeriesManagement;
        SR: Record "Sales & Receivables Setup";
        Loc: Record Location;
    begin
        SR.Get();
        Rec."No." := NoSeries.GetNextNo(SR."Bank Drop No Series", Today, true);
        IF Loc.Get(Rec."Store No.") then begin
            Rec."Cash Account" := Loc."Cash Account No.";
            Rec."Bank Account" := loc."Bank Account No.";
            //Rec.Modify();
        end;

    end;
}
