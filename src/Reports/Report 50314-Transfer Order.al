report 50314 "Transfer Order New"
{
    //PCPL-064
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report Layout\Transfer Order -3.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "Transfer-from Code", "Transfer-to Code";
            column(Cominfo_Name; Cominfo.Name)
            {

            }
            column(No_; "No.")
            {

            }
            column(Transfer_Order_No_; "Transfer Order No.")
            {

            }
            column(Transfer_Order_Date; "Transfer Order Date")
            {

            }
            column(Shipment_Date; "Shipment Date")
            {

            }
            column(Transfer_from_Name; "Transfer-from Name")
            {

            }
            column(Transfer_from_Address; "Transfer-from Address" + ' ' + "Transfer-from Address 2" + ',' + "Transfer-from City" + ',' + "Trsf.-from Country/Region Code" + ',' + "Transfer-from County" + "Transfer-from Post Code")
            {

            }
            column(Transfer_to_Name; "Transfer-to Name")
            {

            }
            column(Transfer_to_Address; "Transfer-to Address" + ' ' + "Transfer-to Address 2" + ',' + "Transfer-to City" + ',' + "Trsf.-to Country/Region Code" + ',' + "Transfer-to County" + "Transfer-to Post Code")
            {

            }
            column(comments; 'Narration:' + comments)
            {

            }


            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Transfer Shipment Header";
                DataItemTableView = sorting("Document No.", "Line No.") order(ascending) where(Quantity = filter(<> 0));
                column(SrNo; SrNo)
                {

                }
                column(Line_No_; "Line No.")
                {

                }
                column(Item_No_; "Item No.")
                {

                }

                column(Description; Description)
                {

                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_Price; "Unit Price")
                {

                }
                column(Amount; Amount)
                {

                }
                column(SGST; SGST)
                {

                }
                column(SGSTPer; SGSTPer)
                {

                }
                column(CGST; CGST)
                {

                }
                column(CGSTPer; CGSTPer)
                {

                }
                column(IGST; IGST)
                {

                }
                column(IGSTPer; IGSTPer)
                {

                }
                column(TotalAmount; TotalAmount)
                {
                }
                column(AmountInWords1; AmountInWords1[1])
                {
                }
                column(ItemStatus; ItemStatus)
                {

                }
                column(SerialCaption; SerialCaption)
                {

                }
                column(SrNo1; SrNo1)
                {

                }

                // dataitem("Value Entry"; "Value Entry")
                // {
                //     DataItemLink = "Document No." = FIELD("Document No."),
                //     "Document Line No." = FIELD("Line No.");
                /*  dataitem("Item Ledger Entry"; "Item Ledger Entry")
                 {
                     //DataItemLink = "Entry No." = FIELD();
                     DataItemLink = "Document No." = FIELD("Document No."),
                         "Document Line No." = field("Line No.");
                     column(ILE_Document_Line_No_; "Document Line No.")
                     {

                     }
                     column(Serial_No_; 'Serial No:' + "Serial No.")
                     {

                     }

                 } */
                trigger OnAfterGetRecord()  //TSL
                begin
                    //Serial No.
                    Clear(SerialCaption);
                    VE.Reset();
                    VE.SetRange("Document No.", "Transfer Shipment Line"."Document No.");
                    VE.SetRange("Document Line No.", "Transfer Shipment Line"."Line No.");
                    IF VE.FindFirst() then begin
                        ILE.Reset();
                        ILE.SetRange("Entry No.", VE."Item Ledger Entry No.");
                        ILE.SetFilter("Serial No.", '<>%1', '');
                        if ILE.FindFirst() then
                            SerialCaption := 'Serial No.:'
                        else
                            SerialCaption := '';
                    end;

                    Clear(SrNo1);
                    VE.Reset();
                    VE.SetRange("Document No.", "Transfer Shipment Line"."Document No.");
                    VE.SetRange("Document Line No.", "Transfer Shipment Line"."Line No.");
                    IF VE.FindSet() then
                        repeat
                            ILE.Reset();
                            ILE.SetRange("Entry No.", VE."Item Ledger Entry No.");
                            ILE.SetFilter("Serial No.", '<>%1', '');
                            ILE.SetRange("Location Code", "Transfer Shipment Header"."Transfer-from Code");
                            if ILE.FindSet() then
                                repeat
                                    if ILE."Serial No." <> '' then
                                        SrNo1 += ILE."Serial No." + ',';
                                until ILE.Next() = 0;
                        until VE.Next() = 0;

                    IF SrNo1 <> '' then
                        SrNo1 := DelStr(SrNo1, StrLen(SrNo1), 1);







                    SrNo += 1;
                    CGST := 0;
                    IGST := 0;
                    SGST := 0;
                    CGSTPer := 0;
                    SGSTPer := 0;
                    IGSTPer := 0;
                    Clear(CGST);
                    Clear(IGST);
                    Clear(SGST);

                    //GST Calculate
                    DGLE.Reset();
                    DGLE.SetRange("Document No.", "Document No.");
                    DGLE.SetRange("Document Line No.", "Line No.");
                    DGLE.SetRange(DGLE."HSN/SAC Code", "Transfer Shipment Line"."HSN/SAC Code");
                    //DGLE.SetRange("No.", "No.");
                    DGLE.SetRange("Transaction Type", DGLE."Transaction Type"::Transfer);

                    if DGLE.findset then begin
                        repeat
                            IF DGLE."GST Component Code" = 'SGST' THEN BEGIN
                                SGST := ABS(DGLE."GST Amount");
                                SGSTPer := DGLE."GST %";
                            END

                            ELSE
                                IF DGLE."GST Component Code" = 'CGST' THEN BEGIN
                                    CGST := ABS(DGLE."GST Amount");
                                    CGSTPer := DGLE."GST %";
                                END

                                ELSE
                                    IF DGLE."GST Component Code" = 'IGST' THEN BEGIN
                                        IGST := ABS(DGLE."GST Amount");
                                        IGSTPer := DGLE."GST %";

                                    END
                        until DGLE.Next() = 0;
                    end;
                    TotalGST := SGST + CGST + IGST;

                    if Recitem.Get("Transfer Shipment Line"."Item No.") then
                        ItemStatus := Recitem."Item Status";

                    Clear(TotalAmount);
                    // TotalAmount += Amount + SGST + CGST + IGST;

                    TSL.Reset();
                    TSL.SetRange("Document No.", "Transfer Shipment Line"."Document No.");
                    IF TSL.FindFirst() then
                        repeat
                            TotalAmt += TSL.Amount;
                        until TSL.Next() = 0;

                    TotalAmount := TotalAmt + TotalGST;

                    AmountInwords.InitTextVariable();
                    AmountInwords.FormatNoText(AmountInWords1, ROUND(TotalAmount), '');

                end;
            }
            trigger OnAfterGetRecord()  //TSH
            begin
                //Narration
                /* ReInvenComm.Reset();
                ReInvenComm.SetRange("No.", "No.");
                ReInvenComm.SetRange("Document Type", ReInvenComm."Document Type"::"Posted Transfer Shipment");
                if ReInvenComm.FindFirst() then
                    repeat
                        comments += ReInvenComm.Comment;
                    until ReInvenComm.Next = 0; */
                RecTSL.Reset();
                RecTSL.SetRange("Document No.", "No.");
                if RecTSL.FindSet() then
                    repeat
                        comments += RecTSL.Remarks;
                    until RecTSL.Next = 0;
                // AmountInwords.InitTextVariable();
                //AmountInwords.FormatNoText(AmountInWords1, ROUND(TotalAmount), '');
                //Clear(TotalAmt);
                //AoumntInWords



            end;


            trigger OnPreDataItem() //TSH
            begin
                Cominfo.Get();
                Cominfo.CalcFields(Picture);
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
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
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

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

    var
        myInt: Integer;
        TotalGST: Decimal;
        TotalAmt: Decimal;
        TSL: Record "Transfer Shipment Line";
        RecTSL: Record "Transfer Shipment Line";
        // Remarks: Text[200];
        Cominfo: Record "Company Information";
        CGST: Decimal;
        IGST: Decimal;
        SGST: Decimal;
        CGSTPer: Decimal;
        SGSTPer: Decimal;
        IGSTPer: Decimal;
        DGLE: Record "Detailed GST Ledger Entry";
        AmountInwords: codeunit "Amount In Words";
        AmountInWords1: array[2] of Text[200];
        TotalAmount: decimal;
        SrNo: Integer;
        Recitem: Record Item;
        ItemStatus: Code[20];
        ReInvenComm: Record "Inventory Comment Line";
        comments: text[80];

        VE: Record "Value Entry";
        SerialCaption: Text;
        SrNo1: Text;
        ILE: Record "Item Ledger Entry";
}