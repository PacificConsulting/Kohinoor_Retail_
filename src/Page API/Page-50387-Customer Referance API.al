page 50387 "Customer Referance API"
{
    APIGroup = 'CustGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'customerReferanceAPI';
    DelayedInsert = true;
    EntityName = 'CustomerReference';
    EntitySetName = 'CustomerReferences';
    PageType = API;
    SourceTable = "Customer Reference";
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
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
