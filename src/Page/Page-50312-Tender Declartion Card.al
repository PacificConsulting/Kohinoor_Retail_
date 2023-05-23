page 50312 "Tender Declartion Card"
{
    //ApplicationArea = All;
    Caption = 'Tender Declartion Card';
    PageType = Card;
    SourceTable = "Tender Declartion Header";
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
                    ApplicationArea = all;
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
                    ApplicationArea = all;
                    // trigger OnValidate()
                    // var//
                    //     StaffMaster: Record "Staff Master";
                    //     TenderHdr: Record "Tender Declartion Header";
                    //     PagetenderCard: page "Tender Declartion Card";
                    //     TenderInit: Record "Tender Declartion Header";
                    //     TenderInitLine: Record "Tender Declartion Line ";
                    //     Paymethod: Record "Payment Method";
                    //     TenderInitLineNew: Record "Tender Declartion Line ";
                    //     PageTenderSubform: Page "Tender Declartion Subform";
                    // begin
                    //     IF StaffMaster.Get(rec."Staff ID") then begin
                    //         Rec."Store No." := StaffMaster."Store No.";
                    //         Rec."Store Date" := Today;
                    //         Rec.Insert();

                    //         Paymethod.Reset();
                    //         Paymethod.SetRange(Tender, true);
                    //         IF Paymethod.FindSet() then
                    //             repeat
                    //                 TenderInitLine.Init();
                    //                 TenderInitLine."Store No." := Rec."Store No.";
                    //                 TenderInitLine."Store Date" := Today;
                    //                 TenderInitLine."Staff ID" := Rec."Staff ID";

                    //                 TenderInitLineNew.Reset();
                    //                 TenderInitLineNew.SetRange("Store No.", TenderInitLine."Store No.");
                    //                 TenderInitLineNew.SetRange("Store Date", TenderInitLine."Store Date");
                    //                 TenderInitLineNew.SetRange("Staff ID", TenderInitLine."Staff ID");
                    //                 IF TenderInitLineNew.FindLast() then
                    //                     TenderInitLine."Line No." := TenderInitLineNew."Line No." + 10000
                    //                 else
                    //                     TenderInitLine."Line No." := 10000;

                    //                 TenderInitLine.Insert();
                    //                 TenderInitLine."Payment Method code" := Paymethod.Code;
                    //                 TenderInitLine.Modify();
                    //             until Paymethod.Next() = 0;
                    //         CurrPage.Update(true);

                    //     end;
                    // end;
                }
                field("Store No."; Rec."Store No.")
                {
                    ToolTip = 'Specifies the value of the Store No. field.';
                    ApplicationArea = all;
                }
                field("Store Date"; Rec."Store Date")
                {
                    ToolTip = 'Specifies the value of the Store Date field.';
                    ApplicationArea = all;
                }

                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    Editable = false;
                    ApplicationArea = all;
                }

            }
            part(Lines; "Tender Declartion Subform")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = field("No.");
                UpdatePropagation = Both;
            }
        }
    }
    // actions
    // {
    //     area(Processing)
    //     {
    //         action(Status11)
    //         {
    //             ApplicationArea = all;
    //             Caption = 'Status';
    //             trigger OnAction()
    //             var
    //                 TDH: Record "Tender Declartion Header";
    //                 Status: Enum "Tender Header Dec.Status";
    //                 Sta: Text;
    //             begin
    //                 TDH.Reset();
    //                 TDH.SetRange("No.", Rec."No.");
    //                 IF TDH.FindFirst() then begin
    //                     Status := TDH.Status;
    //                     //Sta:=TDH.Status;
    //                 end;
    //                 Message(FORMAT(Status));
    //                 Message('Text %1', Sta);
    //             end;
    //         }
    //     }
    // }
}
