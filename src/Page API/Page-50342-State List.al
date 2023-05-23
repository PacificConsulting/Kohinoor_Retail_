page 50342 "State List"
{
    APIGroup = 'StateGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'stateList';
    DelayedInsert = true;
    EntityName = 'StateList';
    EntitySetName = 'StateLists';
    PageType = API;
    SourceTable = State;
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
                field(stateCodeGSTRegNo; Rec."State Code (GST Reg. No.)")
                {
                    Caption = 'State Code (GST Reg. No.)';
                }
                field(stateCodeForETDSTCS; Rec."State Code for eTDS/TCS")
                {
                    Caption = 'State Code for eTDS/TCS';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
