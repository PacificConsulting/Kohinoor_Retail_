page 50348 "Request Tranfer Subform"
{
    APIGroup = 'TransferGroup';
    APIPublisher = 'Pacific';
    APIVersion = 'v4.0';
    ApplicationArea = All;
    Caption = 'requestTranferSubform';
    DelayedInsert = true;
    EntityName = 'RequestTranferSubform';
    EntitySetName = 'RequestTranferSubforms';
    PageType = API;
    SourceTable = "Request Transfer Line";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(itemDescription; Rec."Item Description")
                {
                    Caption = 'Item Description';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(transferFromCode; Rec."Transfer-from Code")
                {
                    Caption = 'Transfer-from Code';
                }
                field(transferFromName; Rec."Transfer-from Name")
                {
                    Caption = 'Transfer-from Name';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                field(remarks; Rec.Remarks)
                {
                    Caption = 'Remarks';
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
        ReqTranLine: record "Request Transfer Line";
    begin
        ReqTranLine.reset;
        ReqTranLine.SETRANGE("Document No.", Rec."Document No.");
        IF ReqTranLine.findlast then
            Rec."Line No." := ReqTranLine."Line No." + 10000
        else
            Rec."Line No." := 10000;
    end;
}
