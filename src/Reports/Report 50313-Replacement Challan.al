report 50313 "Replacement Challan"
{
    //pcpl-064
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report Layout\Replacement Challan -1.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Journal Replace Data"; "Item Journal Replace Data")
        {
            RequestFilterFields = "Document No.", "Posting Date";
            DataItemTableView = where("Item No." = filter(<> ''), "Entry Type" = filter('Negative Adjmt.'));

            column(Srno; Srno)
            {

            }
            /* column(Document_No_; "Document No.")
            {

            } */
            column(Item_No_; "Item No.")
            {

            }
            column(External_Document_No_; "Document No.")
            {

            }
            column(Description; Description)
            {

            }
            column(Store_name; loc.Name)
            {
            }

            column(StoreAddress1; loc.Address + ' ' + loc."Address 2" + '' + loc.City + ',' + loc."Post Code" + ',' /*+ 'PANNO.' + Compinfo."P.A.N. No." + ','*/ + loc."State Code" + ',' + loc."Country/Region Code")
            {

            }
            column(StoreGSTIN; Loc."GST Registration No.")
            {

            }
            column(CompName; Compinfo.Name)
            {

            }
            column(callcenterno; compinfo."Phone No.")
            {

            }
            column(SalesOrderNo; SalesOrderNo)
            {

            }
            column(Bill_to_Name; BilltoName)
            {

            }
            column(Bill_to_Address; BilltoAdd)
            {

            }

            column(Bill_to_Customer_No_; Bill_to_Customer_No_)
            {

            }
            column(Ship_to_address; ShiptoAdd)
            {

            }

            column(Ship_to_GSTIN; SIH."Ship-to GST Reg. No.")
            {

            }
            column(HSNCode_SIL; HSNCode)
            {

            }
            column(Salespersoncode; txt3)
            {

            }
            column(Storeno; Storeno)
            {

            }
            column(serialno; serialno)
            {

            }
            column(cust_contact; custphoneno)
            {

            }
            column(Narration; Narration)
            {

            }
            column(NewSerialNo; NewSerialNo)
            {

            }



            trigger OnAfterGetRecord()
            begin

                Srno += 1;

                compinfo.get();
                compinfo.CalcFields(Picture);

                RECILE.Reset(); //25july2023
                RECILE.SetRange("External Document No.", "External Document No.");
                if RECILE.FindLast() then begin
                    SalesOrderNo := RECILE."Document No.";
                end;
                //Bill to and Ship to Address
                if Loc.Get("Location Code") then;
                //if SIH.get("Document No.") then;
                SIH.Reset();
                SIH.SetRange("No.", "Document No.");
                if SIH.FindFirst() then begin
                    Bill_to_Customer_No_ := SIH."Bill-to Customer No.";
                    //SalesOrderNo := SIH."Order No.";
                    BilltoName := SIH."Sell-to Customer Name";
                    BilltoAdd := SIH."Sell-to Address" + ' ' + SIH."Sell-to Address 2" + ',' + SIH."Sell-to City" + ',' + SIH."Sell-to Post Code" + ',' + SIH."Sell-to Country/Region Code";
                    ShiptoAdd := SIH."Ship-to Address" + '' + SIH."Ship-to Address 2" + '' + SIH."Ship-to City" + ',' + SIH."Ship-to Post Code" + ',' + SIH."Ship-to Country/Region Code";
                    Storeno := SIH."Store No.";

                end;

                //Sales Excutive
                SIL.Reset();
                SIL.SetRange("Document No.", "Document No.");
                SIL.SetRange("No.", "Item No.");
                if SIL.FindSet() then begin
                    repeat
                        IF SIL."Salesperson Name" <> '' then
                            Salespersoncode += SIL."Salesperson Name" + ',';
                    until SIL.Next = 0;
                    if Salespersoncode <> '' then
                        txt3 := DelStr(Salespersoncode, StrLen(Salespersoncode), 1);
                end;

                //HSN Code
                RescSIL.Reset();
                RescSIL.SetRange("Document No.", "Document No.");
                RescSIL.SetRange("No.", "Item No.");
                if RescSIL.FindFirst() then begin
                    HSNCode := RescSIL."HSN/SAC Code";

                end;

                //Old Serial No.
                //Clear(serialno);
                /*SalesInvLine.Reset();
                SalesInvLine.SetRange("Document No.", "Document No.");
                SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                SalesInvLine.SetRange("No.", "Item No.");
                if SalesInvLine.FindFirst() then begin
                    VL.Reset();
                    VL.SetRange("Document No.", "Document No.");
                    VL.SetRange("Item No.", "Item No.");
                    //VL.SetRange("Item Ledger Entry Type", VL."Item Ledger Entry Type"::"Negative Adjmt.");
                    if VL.FindFirst() then begin
                        ILE.Reset();
                        ILE.SetRange("Entry No.", VL."Item Ledger Entry No.");
                        //ILE.SetRange("Entry Type", ILE."Entry Type"::"Negative Adjmt.");
                        ILE.SetFilter("Serial No.", '<>%1', '');
                        if ILE.FindFirst() then begin
                            serialno := ILE."Serial No.";
                            /* IF serialno <> '' then
                                serialno := DelStr(serialno, StrLen(serialno), 1); */
                // end;
                //         end;
                //     end;*/

                /* SalesInvLine.Reset();
                SalesInvLine.SetRange("Document No.", "Item Journal Replace Data"."Document No.");
                SalesInvLine.SetRange("No.", "Item Journal Replace Data"."Item No.");
                if SalesInvLine.FindFirst() then begin
                    VL.Reset();
                    VL.SetRange("Document No.", SalesInvLine."Document No.");
                    VL.SetRange("Item No.", SalesInvLine."No.");
                    if VL.FindFirst() then begin
                        ILE.Reset();
                        ILE.SetRange("Entry No.", VL."Item Ledger Entry No.");
                        if ILE.FindFirst() then begin
                            serialno := ILE."Serial No.";
                        end;
                    end;
                end; */
                ILE.Reset();
                ILE.SetRange("External Document No.", "Item Journal Replace Data"."External Document No.");
                ILE.SetRange("Entry Type", ILE."Entry Type"::"Positive Adjmt.");
                if ILE.FindFirst() then begin
                    serialno := ILE."Serial No.";
                end;




                //NEW Serial No.
                /*  Clear(NewSerialNo);
                 RSIL.Reset();
                 RSIL.SetRange("Document No.", "Document No.");
                 RSIL.SetRange("No.", "Item No.");
                 if RSIL.FindFirst() then begin
                 ValEntry.Reset();
                 ValEntry.SetRange("Document No.", "Item Journal Replace Data"."Document No.");
                 ValEntry.SetRange("Item Ledger Entry Type", ValEntry."Item Ledger Entry Type"::"Negative Adjmt.");
                 if ValEntry.FindFirst() then begin
                     itemLedEntry.Reset();
                     itemLedEntry.SetRange("Entry No.", ValEntry."Item Ledger Entry No.");
                     itemLedEntry.SetRange("Entry Type", itemLedEntry."Entry Type"::"Negative Adjmt.");
                     if itemLedEntry.FindFirst() then begin
                         NewSerialNo := itemLedEntry."Serial No.";
                     end;
                     end;
                 end; */

                itemLedEntry.Reset();
                itemLedEntry.SetRange("External Document No.", "Item Journal Replace Data"."External Document No.");
                itemLedEntry.SetRange("Entry Type", itemLedEntry."Entry Type"::"Negative Adjmt.");
                if itemLedEntry.FindFirst() then begin
                    // itemLedEntry.CalcFields("Serial No.");
                    NewSerialNo := itemLedEntry."Serial No.";
                end;


                //Contact No.
                if SIH.get("Document No.") then;
                if cust.get(SIH."Sell-to Customer No.") then;
                if cust."Mobile Phone No." <> '' then
                    custphoneno := cust."Phone No." + '/' + cust."Mobile Phone No."
                else
                    custphoneno := cust."Phone No.";

                //Narration
                /* RecSIH.Reset();
                RecSIH.SetRange("No.", "Document No.");
                if RecSIH.FindFirst() then begin
                    SalesCommLine.Reset();
                    SalesCommLine.SetRange("No.", RecSIH."No.");
                    SalesCommLine.SetRange("Document Line No.", 0);
                    if SalesCommLine.FindFirst() then
                        repeat
                            Narration += SalesCommLine.Comment;
                        until SalesCommLine.Next = 0;
                end; */
                //Clear(Narration);
                IJRD.Reset();
                IJRD.SetRange("Document No.", "Item Journal Replace Data"."Document No.");
                IF IJRD.FindSet() then
                    repeat
                        IF IJRD."Replacement Remarks" <> '' then
                            Narration += IJRD."Replacement Remarks" + ',';
                    until IJRD.Next() = 0;
                if Narration <> '' then
                    Narration := DelStr(Narration, StrLen(Narration), 1);
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                // "Item Journal Replace Data".Reset();
                // "Item Journal Replace Data".SetRange("Entry Type", "Item Journal Replace Data"."Entry Type"::"Negative Adjmt.");
            end;

        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                // group(GroupName)
                // {
                //     field(Name; SourceExpression)
                //     {
                //         ApplicationArea = All;

                //     }
                // }
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

    var
        myInt: Integer;
        txt1: Text;
        IJRD: Record "Item Journal Replace Data";
        NewSerialNo: Code[50];
        RECILE: Record "Item Ledger Entry";
        RSIL: Record "Sales Invoice Line";
        Narration: Text[250];
        ValEntry: Record "Value Entry";
        itemLedEntry: record "Item Ledger Entry";
        RecSIH: Record "Sales Invoice Header";
        SalesCommLine: Record "Sales Comment Line";
        serialno: Code[50];
        custphoneno: Text[30];
        VL: record "Value Entry";
        ILE: Record "Item Ledger Entry";
        SalesInvLine: Record "Sales Invoice Line";
        IRD: record "Item Journal Replace Data";
        Loc: Record Location;
        SIL: Record "Sales Invoice Line";
        SIH: Record "Sales Invoice Header";
        cust: Record Customer;
        compinfo: record "Company Information";
        SalesOrderNo: code[20];
        Srno: Integer;
        Salespersoncode: Text[200];
        txt3: Text;
        RescSIL: Record "Sales Invoice Line";
        HSNCode: Code[50];
        ShiptoAdd: Text[500];
        //ShiptoAdd1: Text[500];
        ShiptoPostCode: Code[50];
        ShipCountry_RegionCode: code[30];
        ShiptoName: Text[500];
        Shiptocity: Text[500];
        ShiptoGSTIN: Code[20];
        BilltoAdd: Text[500];
        BilltoName: Text[100];
        Bill_to_Customer_No_: Text[30];
        Storeno: Code[20];
}