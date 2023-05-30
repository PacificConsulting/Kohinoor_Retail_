page 50385 "Finance Promoter API"
{
    APIGroup = 'FinanceGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'financePromoterAPI';
    DelayedInsert = true;
    EntityName = 'FinancePromoter';
    EntitySetName = 'FinancePromoters';
    PageType = API;
    SourceTable = "Finance Promoter ";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
