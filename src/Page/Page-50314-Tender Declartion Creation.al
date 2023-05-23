page 50314 "Tender Declartion Creation"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    Caption = 'Tender Declartion Creation';
    layout
    {
        area(Content)
        {
            group("Tender Creation")

            {
                field("Select Staff ID "; StaffID)
                {
                    ApplicationArea = All;
                    TableRelation = "Staff Master".ID;

                    trigger OnValidate()
                    var
                        StaffMaster: Record "Staff Master";
                        TenderHdr: Record "Tender Declartion Header";
                        PagetenderCard: page "Tender Declartion Card";
                        TenderInit: Record "Tender Declartion Header";
                        TenderInitLine: Record "Tender Declartion Line ";
                        Paymethod: Record "Payment Method";
                        TenderInitLineNew: Record "Tender Declartion Line ";
                    begin
                        IF StaffMaster.Get(StaffID) then begin
                            SR.Get();
                            // TenderHdr.Reset();
                            // TenderHdr.SetRange("Staff ID", StaffID);
                            // TenderHdr.SetRange("Store No.", StaffMaster."Store No.");
                            // TenderHdr.SetRange("Store Date", Today);
                            // IF not TenderHdr.FindFirst() then begin
                            TenderInit.Init();
                            TenderInit."No." := Noseries.GetNextNo(sr."Tender Declartion No Series", Today, true);
                            TenderInit."Store No." := StaffMaster."Store No.";
                            TenderInit."Store Date" := Today;
                            TenderInit."Staff ID" := StaffID;
                            TenderInit.Insert();

                            Paymethod.Reset();
                            Paymethod.SetRange(Tender, true);
                            IF Paymethod.FindSet() then
                                repeat
                                    TenderInitLine.Init();
                                    TenderInitLine."Document No." := TenderInit."No.";
                                    TenderInitLine."Store No." := TenderInit."Store No.";
                                    TenderInitLine."Store Date" := TenderInit."Store Date";
                                    TenderInitLine."Staff ID" := TenderInit."Staff ID";

                                    TenderInitLineNew.Reset();
                                    TenderInitLineNew.SetRange("Store No.", TenderInitLine."Store No.");
                                    TenderInitLineNew.SetRange("Store Date", TenderInitLine."Store Date");
                                    TenderInitLineNew.SetRange("Staff ID", TenderInitLine."Staff ID");
                                    IF TenderInitLineNew.FindLast() then
                                        TenderInitLine."Line No." := TenderInitLineNew."Line No." + 10000
                                    else
                                        TenderInitLine."Line No." := 10000;

                                    TenderInitLine.Insert();
                                    TenderInitLine."Payment Method code" := Paymethod.Code;
                                    TenderInitLine.Modify();
                                until Paymethod.Next() = 0;

                            TenderHdr.Reset();
                            TenderHdr.SetRange("No.", TenderInit."No.");
                            //TenderHdr.SetRange("Staff ID", StaffID);
                            //TenderHdr.SetRange("Store No.", StaffMaster."Store No.");
                            //TenderHdr.SetRange("Store Date", Today);
                            IF TenderHdr.FindFirst() then begin
                                PagetenderCard.SetTableView(TenderHdr);
                                PagetenderCard.Run();
                                Clear(StaffID);
                                CurrPage.Close();
                            end;
                        end;
                        /*
                        else begin
                            TenderHdr.Reset();
                            TenderHdr.SetRange("Staff ID", StaffID);
                            TenderHdr.SetRange("Store No.", StaffMaster."Store No.");
                            TenderHdr.SetRange("Store Date", Today);
                            IF TenderHdr.FindFirst() then begin
                                PagetenderCard.SetTableView(TenderHdr);
                                PagetenderCard.Run();
                                Clear(StaffID);
                                CurrPage.Close();
                            end;
                        end;
                    end;
                    */
                    end;

                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(DeleteDataLine)
            {
                ApplicationArea = All;

                trigger OnAction();
                var
                    TL: Record "Tender Declartion Line ";
                begin
                    TL.DeleteAll();
                    Message('Delete all Lines');
                end;
            }
        }
    }
    var
        StaffID: Code[10];
        Noseries: Codeunit NoSeriesManagement;
        SR: Record "Sales & Receivables Setup";
}