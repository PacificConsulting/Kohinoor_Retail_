page 50316 "Payment Method"
{
    APIGroup = 'PaymentMethodGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v8.0';
    ApplicationArea = All;
    Caption = 'PaymentMethod';
    DelayedInsert = true;
    EntityName = 'PaymentMethod';
    EntitySetName = 'PaymentMethods';
    PageType = API;
    SourceTable = "Payment Method";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(balAccountNo; Rec."Bal. Account No.")
                {
                    Caption = 'Bal. Account No.';
                }
                field(balAccountType; Rec."Bal. Account Type")
                {
                    Caption = 'Bal. Account Type';
                }
                field(directDebit; Rec."Direct Debit")
                {
                    Caption = 'Direct Debit';
                }
                field(directDebitPmtTermsCode; Rec."Direct Debit Pmt. Terms Code")
                {
                    Caption = 'Direct Debit Pmt. Terms Code';
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                    Caption = 'Last Modified Date Time';
                }
                field(pmtExportLineDefinition; Rec."Pmt. Export Line Definition")
                {
                    Caption = 'Pmt. Export Line Definition';
                }
                field(paymentType; Rec."Payment Type")
                {
                    Caption = 'Payment Type';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}