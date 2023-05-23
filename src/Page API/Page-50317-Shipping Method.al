page 50317 "Shipping method"
{
    APIGroup = 'ShippingmethodGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v9.0';
    ApplicationArea = All;
    Caption = 'Shippingmethod';
    DelayedInsert = true;
    EntityName = 'Shippingmethod';
    EntitySetName = 'Shippingmethods';
    PageType = API;
    SourceTable = "Shipment Method";
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
                field(coupledToCRM; Rec."Coupled to CRM")
                {
                    Caption = 'Coupled to Dataverse';
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