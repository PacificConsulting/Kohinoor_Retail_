report 50321 "Sales Delivery"
{
    //PCPL-064
    DefaultLayout = RDLC;
    Caption = 'Sales Delivery Report New';
    RDLCLayout = 'src/Report Layout/Sales Delivery -4.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {

        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            //DataItemLink = "Document No." = FIELD("No."); 
            RequestFilterFields = "Posting Date", "Document No.";
            DataItemTableView = where(Type = filter('Item'));
            column(Document_No_; "Document No.")
            {

            }
            column(cnt; cnt)
            { }
            /* column(DeliveryOrderId; SIH."No.")
            {

            } */
            column(DeliveryOrderId; "Document No.")
            {

            }
            column(SalesOrderId; SIH."Order No.")
            {

            }
            column(dcId; SIH."Location Code")
            {

            }
            column(StoreId; SIH."Store No.")
            {

            }
            column(Customer_Name; SIH."Sell-to Customer Name")
            {

            }
            column(Ship_to_Address; SIH."Ship-to Address")
            {

            }
            column(Ship_to_Address_2; SIH."Ship-to Address 2")
            {

            }
            column(Ship_to_Post_Code; SIH."Ship-to Post Code")
            {

            }
            column(Ship_to_City; SIH."Ship-to City")
            {

            }
            /* column(Ship_to_County; SIH."Ship-to Country/Region Code")
            {

            } */
            column(Ship_to_County; Coutry)
            {

            }
            /*  column(State; SIH.State)
             {

             } */
            column(State; Recstate."State New") //pcpl-064 26/10/2023
            {

            }
            /*   column(State; RecSta1)
              {

              } */

            column(ProductId; "No. 2")
            {

            }
            column(ProductName; Description)
            {

            }
            column(Srno; Srno)
            {

            }
            column(ProductType; RecItem."Category 1" + ' - ' + RecItem."Category 2" + ' - ' + RecItem."Category 3" + ' - ' + RecItem."Category 4" + ' - ' + RecItem."Category 5" + ' - ' + RecItem."Category 6" + ' - ' + RecItem."Category 7" + ' - ' + RecItem."Category 8")
            {

            }
            column(Posting_Date; FORMAT("Posting Date", 0, '<day,2>/<month,2>/<year4>'))
            {

            }
            column(TodayDate; FORMAT(TodayDate, 0, '<day,2>/<month,2>/<year4>') + ' ' + Format(Time))
            {

            }
            column(Qty; Qty)
            {

            }
            column(SerialNo; SerialNo)
            {

            }
            column(Createtime; Createtime)
            {

            }
            column(cust_PhoneNO; cust."Phone No.")
            {

            }
            column(cust_email; cust."E-Mail")
            {

            }
            column(cust_mobileno; cust."Mobile Phone No.")
            {

            }


            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                //Clear(cnt);
            end;


            trigger OnAfterGetRecord() //SIL
            begin
                if documentno <> "Document No." then //Printing the number based  on line value. 
                    cnt := 1

                else
                    cnt += 1;
                documentno := "Document No.";

                /*  RecSta := CopyStr(Recstate.Description, 1, 3);
                 RecSta1 := UpperCase(RecSta); */


                /* if "Sales Invoice Line"."Document No." = "Sales Invoice Line"."Document No." then begin
                    Srno += 1;
                end; */
                // cnt += 1;


                /* if documentno <> SIH."No." then
                    cnt := 1

                else
                    cnt += 1;
                documentno := SIH."No."; */

                /*   cnt += "Sales Invoice Line".Count;
                  Message(format(cnt)); */


                Clear(Createtime);
                // CreateDate := System.CurrentDateTime;
                Createtime := DT2Time(SystemCreatedAt);
                //CreatedTime := CreatedTime;
                // CreatedDate := "Posting Date" + format(Createtime);

                TodayDate := CurrentDateTime;
                // tm := DT2Time(CurrentDateTime);
                if RecItem.Get("No.") then;

                valentry.Reset();
                valentry.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                valentry.SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
                if valentry.FindFirst() then begin
                    Qty := ABS(valentry."Invoiced Quantity");
                end;

                //SERIAL No.
                VE.Reset();
                VE.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                VE.SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
                IF VE.FindSet() then
                    ILE.Reset();
                ILE.SetRange("Entry No.", VE."Item Ledger Entry No.");
                //ILE.SetFilter("Serial No.", '<>%1', '');
                if ILE.FindFirst() then begin
                    SerialNo := ILE."Serial No.";
                end;

                if cust.get("Sell-to Customer No.") then;

                SIH.Reset();
                SIH.SetRange("No.", "Document No.");
                if SIH.FindFirst() then;

                if SIH.get("No.") then;
                if Recstate.Get(SIH.State) then;

                if RecSIH.get("No.") then;
                if RecCountry.Get(RecSIH."Ship-to Country/Region Code") then;

                RecSIH.Reset();
                RecSIH.SetRange("No.", "Document No.");
                if RecSIH.FindFirst() then begin
                    if RecSIH."Ship-to Country/Region Code" = 'IN' then
                        Coutry := 'IND'
                    else
                        Coutry := SIH."Ship-to Country/Region Code";
                end;



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
                    /* field(Name; SourceExpression)
                    {
                        ApplicationArea = All;

                    } */
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

    /* rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'mylayout.rdl';
        }
    } */

    var
        SIH: Record "Sales Invoice Header";
        Srno: Integer;
        RecItem: Record Item;
        Createtime: Time;
        CreatedTime: Time;
        CreatedDate: Date;
        TodayDate: DateTime;
        valentry: Record "Value Entry";
        Qty: Decimal;
        VE: Record "Value Entry";
        ILE: Record "Item Ledger Entry";
        SerialNo: Code[100];
        cust: Record customer;
        documentno: code[20];
        cnt: Integer;
        Recstate: Record State;
        RecCountry: Record "Country/Region";
        RecSIH: Record "Sales Invoice Header";
        Coutry: Code[10];
        RecSta: Text[20];
        RecSta1: Text[20];





}