report 50319 "Outstanding Report"
{
    //PCPL-064
    DefaultLayout = RDLC;
    Caption = 'Finance Outstanding Report';
    RDLCLayout = 'src/Report Layout/Outstanding Report -1.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    EnableHyperlinks = true;

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            RequestFilterFields = "Bank Account No.", "Posting Date";
            DataItemTableView = where(Open = filter(true), Reversed = filter('No'));
            column(Approval_Code; "Approval Code")
            {

            }
            column(Bank_Account_No_; "Bank Account No.")
            {

            }
            column(InvoiceID; InvoiceID)
            {

            }
            column(Invoicedate; Invoicedate)
            {

            }
            column(Amount; Amount)
            {

            }
            column(customerNo; customerNo)
            {

            }
            column(Customername; Customername)
            {

            }
            column(fromdate; fromdate)
            {

            }
            column(Todate; Todate)
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(NoOfdays; NoOfdays)
            {

            }
            column(storenumber; "Global Dimension 2 Code")
            {

            }
            column(storename; storename)
            {

            }
            column(outstandingamt; outstandingamt)
            {

            }
            column(closed; closed)
            {

            }
            column(LastReconciledDate; LastReconciledDate)
            {

            }
            column(ReceivedAmount; ReceivedAmount)
            {

            }

            trigger OnAfterGetRecord()
            begin
                if bankacc.get("Bank Account No.") then begin
                    if not bankacc.Tender then
                        Error('Please enter valid No.');
                    //CurrReport.Skip();
                end;

                if "Bank Account Ledger Entry".Open = true then //begin
                    closed := 'No'
                else
                    closed := 'Yes';
                // end;
                /* documentno := InvoiceID;
                                if documentno = InvoiceID then begin
                                    CurrReport.Skip();
                                end; */


                /*  PostPyaline.Reset();
                 //PostPyaline.SetRange("Document No.","Document No.");
                 PostPyaline.SetRange("Approval Code", "Approval Code");
                 PostPyaline.SetRange("Payment Method Code", "Bank Account No.");
                 if PostPyaline.FindSet() then
                     repeat
                         InvoiceID += PostPyaline."Document No." + ',';
                         Invoicedate += format(PostPyaline."Invoice Posting Date") + ',';
                         Amount += PostPyaline.Amount;

                     until PostPyaline.Next() = 0;
  */

                // Clear(Amount);
                //Clear(InvoiceID);
                PostPyaline.Reset();
                //PostPyaline.SetRange("Document No.","Document No.");
                PostPyaline.SetRange("Approval Code", "Approval Code");
                PostPyaline.SetRange("Payment Method Code", "Bank Account No.");
                if PostPyaline.FindFirst() then begin
                    //InvoiceID := PostPyaline."Document No.";
                    //Invoicedate := PostPyaline."Invoice Posting Date";
                    Amount := Abs(PostPyaline.Amount);
                end
                else
                    RecBALE.Reset();
                RecBALE.SetRange("Approval Code", "Approval Code"); //PCPL-064 3oct2023
                RecBALE.SetRange("Bank Account No.", "Bank Account No.");
                RecBALE.SetRange("Document No.", "Document No.");
                if RecBALE.FindFirst() then begin
                    Amount := Abs(RecBALE.Amount);
                end;

                //29sep2023
                Clear(ReceivedAmount);
                BALE.Reset();
                BALE.SetRange("Approval Code", "Approval Code");
                BALE.SetRange("Bank Account No.", "Bank Account No.");
                //BALE.SetRange("Document No.", "Document No.");
                BALE.SetRange(Open, false);
                if BALE.FindSet() then begin
                    repeat
                        //if BankAccLedEntr.Open = false then
                        ReceivedAmount += BALE.Amount;
                    until BALE.Next() = 0;
                end;

                //29sep2023
                Clear(outstandingamt);
                outstandingamt := ABS(Amount - ReceivedAmount);

                //Clear(outstandingamt);
                /*  BankAccLedEntr.Reset();
                 BankAccLedEntr.SetRange("Approval Code", "Approval Code");
                 BankAccLedEntr.SetRange("Bank Account No.", "Bank Account No.");
                 // BankAccLedEntr.SetRange("Document No.", "Document No.");
                 BankAccLedEntr.SetRange(Open, true);
                 if BankAccLedEntr.FindFirst() then begin
                     // if BankAccLedEntr.Open = true then
                     outstandingamt := BankAccLedEntr.Amount;
                 end; */



                Clear(Customername);
                Clear(customerNo);
                Clear(Invoicedate);
                Clear(InvoiceID);
                PostPyaline_1.Reset();
                //PostPyaline.SetRange("Document No.","Document No.");
                PostPyaline_1.SetRange("Approval Code", "Approval Code");
                PostPyaline_1.SetRange("Payment Method Code", "Bank Account No.");
                if PostPyaline_1.FindFirst() then begin
                    InvoiceID := PostPyaline_1."Document No.";
                    Invoicedate := PostPyaline_1."Invoice Posting Date";
                    SIH.Reset();
                    SIH.SetRange("No.", InvoiceID);
                    if SIH.FindFirst() then begin
                        Customername := SIH."Sell-to Customer Name";
                        customerNo := SIH."Sell-to Customer No.";
                        Invoicedate := SIH."Posting Date";
                    end;
                end
                //else
                ELSE
                    CLE.Reset();
                CLE.SetRange("Document No.", "Document No."); //pcpl-064 11nov2023
                                                              //CLE.SetRange("External Document No.", "External Document No.");
                if CLE.FindFirst() then begin
                    RecSaleInvHead.Reset();
                    // RecSaleInvHead.SetRange("No.", CLE."Document No.");
                    RecSaleInvHead.SetRange("Order No.", CLE."External Document No.");
                    if RecSaleInvHead.FindFirst() then begin
                        Customername := RecSaleInvHead."Sell-to Customer Name";
                        customerNo := RecSaleInvHead."Sell-to Customer No.";
                        Invoicedate := RecSaleInvHead."Posting Date";
                        InvoiceID := RecSaleInvHead."No.";
                    end;
                end
                else
                    CLE.Reset();
                CLE.SetRange("External Document No.", "External Document No.");
                IF CLE.FindFirst() then begin
                    Customername := CLE."Customer Name";
                    customerNo := CLE."Customer No.";
                    RecSaleInvHead.Reset();
                    RecSaleInvHead.SetRange("Order No.", CLE."External Document No.");
                    if RecSaleInvHead.FindFirst() then begin
                        InvoiceID := RecSaleInvHead."No.";
                        Invoicedate := RecSaleInvHead."Posting Date";
                    end
                    else
                        RecSaleInvHead.Reset();
                    RecSaleInvHead.SetRange("Order Reference", CLE."External Document No.");
                    if RecSaleInvHead.FindFirst() then begin
                        InvoiceID := RecSaleInvHead."No.";
                        Invoicedate := RecSaleInvHead."Posting Date";
                    end
                end;




                /* else
                    CLE.SetRange("Document No.", "Document No.");
                CLE.SetRange("External Document No.", "External Document No.");
                if CLE.FindFirst() then begin
                    Customername := CLE."Customer Name";
                    customerNo := CLE."Customer No.";
                end;
 */

                if RecSIH.get(InvoiceID) then;
                if loc.get(SIH."Store No.") then;
                //if loc.get("Store No.") then;

                //if DImVal.Get("Bank Account Ledger Entry"."Global Dimension 2 Code") then;
                DImVal.Reset();
                DImVal.SetRange(Code, "Global Dimension 2 Code");
                if DImVal.FindFirst() then begin
                    storename := DImVal.Name;
                end;



                //Clear(outstandingamt);
                /*  if "Bank Account Ledger Entry".Open = true then begin
                     outstandingamt := "Bank Account Ledger Entry".Amount;
                 end; */
                /*  Clear(outstandingamt);
               outstandingamt := ABS(Amount - ReceivedAmount);
*/
                Clear(NoOfdays);
                IF InvoiceID <> '' then
                    NoOfdays := Today - Invoicedate
                else
                    NoOfdays := Today - "Posting Date";

                Clear(LastReconciledDate);
                BankAccLedEntr.Reset();
                BankAccLedEntr.SetRange("Bank Account No.", "Bank Account No.");
                BankAccLedEntr.SetRange(Open, false);
                BankAccLedEntr.SetRange("Approval Code", "Approval Code");
                if BankAccLedEntr.FindLast() then begin
                    // if BankAccLedEntr."Statement No." <> '' then
                    LastReconciledDate := BankAccLedEntr."Closed at Date";
                end;

            end;

            trigger OnPreDataItem()
            begin

            end;



        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(BankAccountTendor; BankAccountTendor)
                    {
                        Caption = 'Bank Account Tendor';
                        Visible = false;
                        TableRelation = "Bank Account";
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            /*  if bankacc.get("Bank Account Ledger Entry"."Bank Account No.") then begin
                                 if not bankacc.Tender then
                                     CurrReport.Skip();
                             end; */
                        end;



                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    /*  rendering
     {
         layout(LayoutName)
         {
             Type = RDLC;
             LayoutFile = 'mylayout.rdl';
         }
     } */
    trigger OnPreReport()

    begin
        // if "Purch. Inv. Line".GetFilter("Posting Date") <> '' then;
        Fromdate := "Bank Account Ledger Entry".GetRangeMin("Posting Date");
        Todate := "Bank Account Ledger Entry".GetRangeMax("Posting Date");
    end;


    var

        myInt: Integer;
        LastReconciledDate: Date;
        documentno: Code[50];
        SIH: record "Sales Invoice Header";
        PostPyaline: record "Posted Payment Lines";
        InvoiceID: Code[50];
        Invoicedate: Date;
        Amount: Decimal;
        Customername: Text[100];
        customerNo: Code[50];
        storeid: Code[50];
        storename: Text[100];
        loc: Record Location;
        RecSIH: Record "Sales Invoice Header";
        fromdate: Date;
        Todate: Date;
        NoOfdays: Integer;
        DImVal: Record "Dimension Value";
        BankAccLedEntr: Record "Bank Account Ledger Entry";
        outstandingamt: Decimal;
        BankAccountTendor: Code[20];
        bankacc: Record "Bank Account";
        closed: Text;
        BALE: Record "Bank Account Ledger Entry";
        ReceivedAmount: Decimal;
        RecBALE: Record "Bank Account Ledger Entry";
        CLE: Record "Cust. Ledger Entry";
        RecSaleInvHead: Record "Sales Invoice Header";
        PostPyaline_1: Record "Posted Payment Lines";
}