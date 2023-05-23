page 50331 "Staff Master"
{
    APIGroup = 'StaffMasterGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v19.0';
    ApplicationArea = All;
    Caption = 'staffMaster';
    DelayedInsert = true;
    EntityName = 'StaffMaster';
    EntitySetName = 'StaffMasters';
    PageType = API;
    SourceTable = "Staff Master";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'E-Mail';
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
                field(storeNo; Rec."Store No.")
                {
                    Caption = 'Store No.';
                }
                field(PosUserID; Rec."POS User ID")
                {
                    Caption = 'POS User ID';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
