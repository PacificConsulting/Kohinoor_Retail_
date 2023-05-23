page 50308 "Tender Declartion API Hdr"
{
    APIGroup = 'TenderGroupHdr';
    APIPublisher = 'Pacific';
    APIVersion = 'v5.0';
    ApplicationArea = All;
    Caption = 'TenderDeclartionAPIHdr';
    DelayedInsert = true;
    EntityName = 'TenderDeclartionHdr';
    EntitySetName = 'TenderDeclartionHdrs';
    PageType = API;
    SourceTable = "Tender Declartion Header";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(StaffID; Rec."Staff ID")
                {
                    Caption = 'Staff ID';
                    // trigger OnValidate()
                    // var
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
                field(storeNo; Rec."Store No.")
                {
                    Caption = 'Store No.';
                }
                field(storeDate; Rec."Store Date")
                {
                    Caption = 'Store Date';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }

            }
        }
    }
    // trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    // var
    //     NoSeries: Codeunit NoSeriesManagement;
    //     SR: Record "Sales & Receivables Setup";
    // begin
    //     //Rec."No." := NoSeries.GetNextNo(SR."Tender Declartion No Series", Today, true);
    // end;
}
