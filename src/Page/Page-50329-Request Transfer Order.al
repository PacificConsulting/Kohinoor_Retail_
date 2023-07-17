page 50329 "Request Transfer Order"
{
    ApplicationArea = All;
    Caption = 'Request Transfer Order';
    SourceTable = "Request Transfer Header";
    PageType = Document;
    RefreshOnActivate = true;


    layout
    {
        area(content)
        {
            group(General)

            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Staff ID"; Rec."Staff ID")
                {
                    ToolTip = 'Specifies the value of the Staff ID field.';
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                // field("Transfer-from Code"; Rec."Transfer-from Code")
                // {
                //     ToolTip = 'Specifies the value of the Transfer-from Code field.';
                // }
                // field("Transfer-from Name"; Rec."Transfer-from Name")
                // {
                //     ToolTip = 'Specifies the value of the Transfer-from Name field.';
                //     Editable = false;
                // }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    ToolTip = 'Specifies the value of the Transfer-to Code field.';
                    Editable = false;
                }
                field("Transfer-to Name"; Rec."Transfer-to Name")
                {
                    ToolTip = 'Specifies the value of the Transfer-to Name field.';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }

            }
            part(RequestTransferLines; "Request Tranfer Ord. Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Send for Approval")
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                Caption = 'Send for Approval';
                Image = SendApprovalRequest;
                trigger OnAction()
                var
                    RTH: Record "Request Transfer Header";
                begin
                    RTH.Reset();
                    RTH.SetRange("No.", rec."No.");
                    IF RTH.FindFirst() then begin
                        RTH.Status := RTH.Status::"Pending for Approval";
                        RTH.Modify();
                    end;
                end;
            }
            action("Submit Transfer Order")
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                Caption = 'Submit Transfer Order';
                Image = TransferOrder;

                trigger OnAction()
                var
                    TransferHeader: Record "Transfer Header";
                    TransferLine: Record "Transfer Line";
                    RrqTransferLine: Record "Request Transfer Line";
                    RrqTransferLineFilter: Record "Request Transfer Line";
                    RLocation: Record Location;
                    InvSetup: Record "Inventory Setup";
                    TransferRelease: Codeunit "Release Transfer Document";
                    Transline: Record "Transfer Line";
                    TranferFromcode: Code[10];
                    RrqTransferLineNew: record "Request Transfer Line";
                    TransferOrderNo: list of [Text];
                    recLocation: Record 14;
                    RH: Record "Request Transfer Header";
                    TranRel: Codeunit "Whse.-Transfer Release";
                    RTH: Record "Request Transfer Header";
                begin
                    RrqTransferLineFilter.Reset();
                    RrqTransferLineFilter.SetRange("Document No.", Rec."No.");
                    IF RrqTransferLineFilter.FindSet() then
                        repeat
                            IF RrqTransferLineFilter."Transfer-from Code" = Rec."Transfer-to Code" then
                                Error('Transfer from code and Transfer to code should be different for line no. %1', RrqTransferLineFilter."Line No.");
                            //IF RrqTransferLineFilter."Transfer-from Code" <> TranferFromcode then begin
                            IF RrqTransferLineFilter."Line Created" = false then begin
                                InvSetup.Get();
                                TransferHeader.Init();
                                TransferHeader."No." := Noseries.GetNextNo(InvSetup."Transfer Order Nos.", Today, true);
                                TransferHeader.Insert(true);
                                //TransferHeader."Transfer-from Code" := Rec."Transfer-from Code";
                                TransferHeader.Validate("Transfer-from Code", RrqTransferLineFilter."Transfer-from Code");
                                TransferHeader.Validate("Transfer-to Code", rec."Transfer-to Code");
                                IF recLocation.Get(Rec."Transfer-from Code") then begin
                                    TransferHeader.Validate("Shortcut Dimension 1 Code", recLocation."Global Dimension 1 Code");
                                    TransferHeader.Validate("Shortcut Dimension 2 Code", recLocation."Global Dimension 2 Code");
                                end;
                                IF RTH.Get(RrqTransferLineFilter."Document No.") then;
                                TransferHeader."Staff Id" := RTH."Staff ID";
                                TransferHeader."Posting Date" := Rec."Posting Date";
                                RLocation.Reset();
                                RLocation.SetRange("Use As In-Transit", true);
                                IF RLocation.FindFirst() then begin
                                    TransferHeader."In-Transit Code" := RLocation.Code;
                                end;
                                TransferHeader.Modify();
                                //TranferFromcode := TransferHeader."Transfer-from Code";
                                TransferOrderNo.Add(TransferHeader."No.");
                                //******Transfer Line Creation**********
                                RrqTransferLine.Reset();
                                RrqTransferLine.SetRange("Document No.", Rec."No.");
                                RrqTransferLine.SetRange("Transfer-from Code", TransferHeader."Transfer-from Code");
                                IF RrqTransferLine.FindSet() then //begin
                                    repeat
                                        TransferLine.Init();
                                        TransferLine."Document No." := TransferHeader."No.";
                                        Transline.Reset();
                                        Transline.SetRange("Document No.", TransferHeader."No.");
                                        IF Transline.FindLast() then
                                            TransferLine."Line No." := Transline."Line No." + 10000
                                        else
                                            TransferLine."Line No." := 10000;
                                        //TransferLine."Line No." := RrqTransferLine."Line No.";
                                        TransferLine.Insert(true);
                                        TransferLine.Validate("Item No.", RrqTransferLine."Item No.");
                                        TransferLine.Validate(Quantity, RrqTransferLine.Quantity);
                                        TransferLine.Validate("Transfer-To Bin Code", recLocation."Default Receipt Bin");
                                        TransferLine.Remarks := RrqTransferLine.Remarks;
                                        TransferLine.Modify();
                                        RrqTransferLine."Line Created" := True;
                                        RrqTransferLine.Modify();
                                    until RrqTransferLine.Next() = 0;
                                TranRel.Release(TransferHeader);
                                //TransferHeader.Modify();
                                //end;
                            end;
                        //end
                        until RrqTransferLineFilter.Next() = 0;
                    Message('Transfer Order Created successfully with No %1.', TransferHeader."No.");
                    RH.Reset();
                    RH.SetRange("No.", Rec."No.");
                    IF RH.FindFirst() then
                        RH.Delete(true);
                    /*
                    if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) then
                        ShowPostedConfirmationMessage(TransferHeader."No.");
                    */
                end;
            }


        }
    }
    var
        Noseries: Codeunit NoSeriesManagement;
        InstructionMgt: Codeunit "Instruction Mgt.";
        OpenPostedSalesOrderQst: Label 'The transfer Order is Created as number %1 .\\Do you want to open the Transfer Order?', Comment = '%1 = posted document number';



    local procedure ShowPostedConfirmationMessage(TranferNo: code[20])
    var
        TrasferHeader: Record "Transfer Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin

        TrasferHeader.SetRange("No.", TranferNo);
        if TrasferHeader.FindFirst() then
            if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedSalesOrderQst, TrasferHeader."No."),
                 InstructionMgt.ShowPostedConfirmationMessageCode())
            then
                InstructionMgt.ShowPostedDocument(TrasferHeader, Page::"Transfer Order");
    end;



}
