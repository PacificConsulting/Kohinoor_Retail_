page 50371 "Salesperson"
{
    APIGroup = 'Salesperson';
    APIPublisher = 'Pacific';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'Salesperson';
    DelayedInsert = true;
    EntityName = 'Salesperson';
    EntitySetName = 'Salespersons';
    PageType = API;
    SourceTable = "Salesperson/Purchaser";
    ODataKeyFields = Code;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; rec.Code)
                {
                    Caption = 'Salesperson Code';
                }
                field(Name; rec.Name)
                {
                    Caption = 'Name';
                }
                field(storeNo; Rec."Store No.")
                {
                    Caption = 'Store No.';
                }
            }
        }
    }
}
