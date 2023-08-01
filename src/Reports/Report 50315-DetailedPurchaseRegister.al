report 50315 "Detailed Purchase Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DetailedPurchaseRegister.rdlc';

    dataset
    {
        dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
        {
            DataItemTableView = WHERE(Type = FILTER(<> ' '),
                                      Quantity = FILTER(<> 0));
            column(PostingDate_PINLINES; "Purch. Inv. Line"."Posting Date")
            {
            }
            column(LineNos; "Purch. Inv. Line"."Line No.")
            {
            }
            column(Purch_InvoiceNo; PurchInvHeader."No.")
            {
            }
            column(VendorInvoiceNo; PurchInvHeader."Vendor Invoice No.")
            {
            }
            column(VendorInv_Date; PurchInvHeader."Document Date")
            {
            }
            column(DocumentNo_PINLINES; "Purch. Inv. Line"."Document No.")
            {
            }
            column(VendorName; PurchInvHeader."Buy-from Vendor Name")
            {
            }
            column(CountryName; recCR.Name)
            {
            }
            column(PurchaseName; recSP.Name)
            {
            }
            column(StateCode; Vendor."State Code")
            {
            }
            column(No_PINLINES; "Purch. Inv. Line"."No.")
            {
            }
            column(Description_PINLINES; "Purch. Inv. Line".Description)
            {
            }
            column(Quantity_PINLINES; "Purch. Inv. Line".Quantity)
            {
            }
            column(UnitCost_PINLINES; "Purch. Inv. Line"."Direct Unit Cost")
            {
            }
            column(Amount_PINLINES; "Purch. Inv. Line".Amount)
            {
            }
            column(CurrencyCode; PurchInvHeader."Currency Code")
            {
            }
            column(CurrencyRate; vCurrency)
            {
            }
            column(AmountinCurrency; vAmount)
            {
            }
            column(CGSTAmt; CGSTAmt)
            {
            }
            column(SGSTAmt; SGSTAmt)
            {
            }
            column(IGSTAmt; IGSTAmt)
            {
            }
            column(GST_PINLINES; '')//"Purch. Inv. Line"."GST %") //pcpl-064 01Aug2023
            {
            }
            column(GSTBaseAmount_PINLINES; '')//"Purch. Inv. Line"."GST Base Amount") //pcpl-064 01Aug2023
            {
            }
            column(TotalGSTAmount_PINLINES; '')//"Purch. Inv. Line"."Total GST Amount") //pcpl-064 01Aug2023
            {
            }
            column(GenBusPostingGroup_PINLINES; "Purch. Inv. Line"."Gen. Bus. Posting Group")
            {
            }
            column(PurchaserCode; recSP.Name)
            {
            }
            column(VendorGSTIN; Vendor."GST Registration No.")
            {
            }
            column(PaymentTerms; PurchInvHeader."Payment Terms Code")
            {
            }
            column(DueDate; PurchInvHeader."Due Date")
            {
            }
            column(VendorNo_PINLINES; PurchInvHeader."Buy-from Vendor No.")
            {
            }
            column(LocationCode; PurchInvHeader."Location Code")
            {
            }
            column(OrderNo; PurchRcptHeader."Order No.")
            {
            }
            column(UOM; "Purch. Inv. Line"."Unit of Measure Code")
            {
            }
            column(ShortcutDimension1Code; "Purch. Inv. Line"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; "Purch. Inv. Line"."Shortcut Dimension 2 Code")
            {
            }
            column(Description2; "Purch. Inv. Line"."Description 2")
            {
            }
            column(GRNNo; "Purch. Inv. Line"."Receipt No.")
            {
            }
            column(AssesseeCode; '')//"Purch. Inv. Line"."Assessee Code") //pcpl-064 01Aug2023
            {
            }
            column(TDS_TCSpercentage; '')// "Purch. Inv. Line"."TDS %") //pcpl-064 01Aug2023
            {
            }
            column(TDS_TCSAmount; '')// "Purch. Inv. Line"."TDS Amount") //pcpl-064 01Aug2023
            {
            }
            column(HSN_SACCode; "Purch. Inv. Line"."HSN/SAC Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                PurchInvHeader.RESET;
                PurchInvHeader.SETRANGE(PurchInvHeader."No.", "Purch. Inv. Line"."Document No.");
                IF PurchInvHeader.FINDFIRST THEN;
                IF PurchInvHeader."Currency Factor" <> 0 THEN
                    vCurrency := 1 / PurchInvHeader."Currency Factor"
                ELSE
                    vCurrency := 1;
                vAmount := "Purch. Inv. Line"."Line Amount" * vCurrency;

                IF Vendor.GET(PurchInvHeader."Buy-from Vendor No.") THEN;

                IF recCR.GET(Vendor."Country/Region Code") THEN;

                recSP.RESET;
                recSP.SETRANGE(recSP.Code, PurchInvHeader."Purchaser Code");
                IF recSP.FINDFIRST THEN;

                CLEAR(CGSTAmt);
                CLEAR(SGSTAmt);
                CLEAR(IGSTAmt);
                DGSTLE.RESET;
                DGSTLE.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Document Line No.");
                DGSTLE.SETRANGE("Transaction Type", DGSTLE."Transaction Type"::Purchase);
                DGSTLE.SETRANGE("Document No.", "Purch. Inv. Line"."Document No.");
                DGSTLE.SETRANGE("Document Line No.", "Purch. Inv. Line"."Line No.");
                IF DGSTLE.FINDSET THEN
                    REPEAT
                        IF DGSTLE."GST Component Code" = 'CGST' THEN BEGIN
                            CGSTAmt := ABS(DGSTLE."GST Amount");
                            //cgstrate := ABS(DGSTLE."GST %");
                        END ELSE
                            IF (DGSTLE."GST Component Code" = 'SGST') OR (DGSTLE."GST Component Code" = 'UTGST') THEN BEGIN
                                SGSTAmt := ABS(DGSTLE."GST Amount");
                                //sgstrate := ABS(DGSTLE."GST %");
                            END ELSE
                                IF DGSTLE."GST Component Code" = 'IGST' THEN BEGIN
                                    IGSTAmt := ABS(DGSTLE."GST Amount");
                                    //igstrate := ABS(DGSTLE."GST %");
                                END ELSE
                                    IF DGSTLE."GST Component Code" = 'CESS' THEN BEGIN
                                        CESSGSTAmt := ABS(DGSTLE."GST Amount");
                                        //cessrate := DGSTLE."GST %";
                                    END;
                    UNTIL DGSTLE.NEXT = 0;

                PurchRcptHeader.RESET;
                PurchRcptHeader.SETRANGE(PurchRcptHeader."No.", "Purch. Inv. Line"."Receipt No.");
                IF PurchRcptHeader.FINDFIRST THEN;
            end;
        }
        dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
        {
            DataItemTableView = WHERE(Type = FILTER(<> ' '),
                                      Quantity = FILTER(<> 0));
            column(PostingDate_PCINLINES; "Purch. Cr. Memo Line"."Posting Date")
            {
            }
            column(PCMLineNos; "Purch. Cr. Memo Line"."Line No.")
            {
            }
            column(Purch_CRMNo; PurchCrMemoHdr."No.")
            {
            }
            column(PCMVendorNo; PurchCrMemoHdr."Buy-from Vendor No.")
            {
            }
            column(VendorCrMemoNo; PurchCrMemoHdr."Vendor Cr. Memo No.")
            {
            }
            column(VendoCRM_Date; PurchCrMemoHdr."Document Date")
            {
            }
            column(DocumentNo_PCINLINES; "Purch. Cr. Memo Line"."Document No.")
            {
            }
            column(VendorNamePCM; PurchCrMemoHdr."Buy-from Vendor Name")
            {
            }
            column(VendorGSTINPCM; PCMVendor."GST Registration No.")
            {
            }
            column(CountryNamePCM; PCMrecCR.Name)
            {
            }
            column(No_PCINLINES; "Purch. Cr. Memo Line"."No.")
            {
            }
            column(Description_PCINLINES; "Purch. Cr. Memo Line".Description)
            {
            }
            column(Quantity_PCINLINES; "Purch. Cr. Memo Line".Quantity)
            {
            }
            column(UnitCost_PCINLINES; "Purch. Cr. Memo Line"."Direct Unit Cost")
            {
            }
            column(Amount_PCINLINES; "Purch. Cr. Memo Line".Amount)
            {
            }
            column(CurrencyCodePCM; PurchCrMemoHdr."Currency Code")
            {
            }
            column(CurrencyRatePCM; vCurrencyPCM)
            {
            }
            column(AmountinCurrencyPCM; vAmountPCM)
            {
            }
            column(PurchaseNamePCM; PCMrecSP.Name)
            {
            }
            column(StateCodePCM; PCMVendor."State Code")
            {
            }
            column(PCMCGSTAmt; PCMCGSTAmt)
            {
            }
            column(PCMSGSTAmt; PCMSGSTAmt)
            {
            }
            column(PCMIGSTAmt; PCMIGSTAmt)
            {
            }
            column(GST_PCINLINES; '')//"Purch. Cr. Memo Line"."GST %") //pcpl-064 01Aug2023
            {
            }
            column(GSTBaseAmount_PCINLINES; '')//"Purch. Cr. Memo Line"."GST Base Amount") //pcpl-064 01Aug2023
            {
            }
            column(TotalGSTAmount_PCINLINES; '')//"Purch. Cr. Memo Line"."Total GST Amount") //pcpl-064 01Aug2023
            {
            }
            column(GenBusPostingGroup_PCINLINES; "Purch. Cr. Memo Line"."Gen. Bus. Posting Group")
            {
            }
            column(PurchaserCodePCM; recSP.Name)
            {
            }
            column(PaymentTermsPCM; PurchCrMemoHdr."Payment Terms Code")
            {
            }
            column(DueDatePCM; PurchCrMemoHdr."Due Date")
            {
            }
            column(VendorNo_PCINLINES; PurchCrMemoHdr."Buy-from Vendor No.")
            {
            }
            column(LocationCodePCM; PurchCrMemoHdr."Location Code")
            {
            }
            column(OrderNoPCM; ReturnShipmentHeader."Return Order No.")
            {
            }
            column(UOMPCM; "Purch. Cr. Memo Line"."Unit of Measure Code")
            {
            }
            column(ShortcutDimension1CodePCM; "Purch. Cr. Memo Line"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2CodePCM; "Purch. Cr. Memo Line"."Shortcut Dimension 2 Code")
            {
            }
            column(Description2PCM; "Purch. Cr. Memo Line"."Description 2")
            {
            }
            column(GRNNoPCM; "Purch. Cr. Memo Line"."Return Shipment No.")
            {
            }
            column(HSN_SACCodePCM; "Purch. Cr. Memo Line"."HSN/SAC Code")
            {
            }

            trigger OnAfterGetRecord()
            begin

                PurchCrMemoHdr.RESET;
                PurchCrMemoHdr.SETRANGE(PurchCrMemoHdr."No.", "Purch. Cr. Memo Line"."Document No.");
                IF PurchCrMemoHdr.FINDFIRST THEN;
                IF PurchCrMemoHdr."Currency Factor" <> 0 THEN
                    vCurrencyPCM := 1 / PurchCrMemoHdr."Currency Factor";
                vAmountPCM := "Purch. Cr. Memo Line"."Line Amount" * vCurrency;

                IF PCMVendor.GET(PurchCrMemoHdr."Buy-from Vendor No.") THEN;

                IF PCMrecCR.GET(PCMVendor."Country/Region Code") THEN;

                PCMrecSP.RESET;
                PCMrecSP.SETRANGE(PCMrecSP.Code, PurchCrMemoHdr."Purchaser Code");
                IF PCMrecSP.FINDFIRST THEN;

                CLEAR(PCMCGSTAmt);
                CLEAR(PCMSGSTAmt);
                CLEAR(PCMIGSTAmt);
                PCMDGSTLE.RESET;
                PCMDGSTLE.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Document Line No.");
                PCMDGSTLE.SETRANGE("Transaction Type", DGSTLE."Transaction Type"::Purchase);
                PCMDGSTLE.SETRANGE("Document No.", "Purch. Cr. Memo Line"."Document No.");
                PCMDGSTLE.SETRANGE("Document Line No.", "Purch. Cr. Memo Line"."Line No.");
                IF PCMDGSTLE.FINDSET THEN
                    REPEAT
                        IF PCMDGSTLE."GST Component Code" = 'CGST' THEN BEGIN
                            PCMCGSTAmt := ABS(PCMDGSTLE."GST Amount");
                            //cgstrate := ABS(PCMDGSTLE."GST %");
                        END ELSE
                            IF (PCMDGSTLE."GST Component Code" = 'SGST') OR (PCMDGSTLE."GST Component Code" = 'UTGST') THEN BEGIN
                                PCMSGSTAmt := ABS(PCMDGSTLE."GST Amount");
                                //sgstrate := ABS(PCMDGSTLE."GST %");
                            END ELSE
                                IF PCMDGSTLE."GST Component Code" = 'IGST' THEN BEGIN
                                    PCMIGSTAmt := ABS(PCMDGSTLE."GST Amount");
                                    //igstrate := ABS(PCMDGSTLE."GST %");
                                END ELSE
                                    IF PCMDGSTLE."GST Component Code" = 'CESS' THEN BEGIN
                                        PCMCESSGSTAmt := ABS(PCMDGSTLE."GST Amount");
                                        //cessrate := PCMDGSTLE."GST %";
                                    END;
                    UNTIL PCMDGSTLE.NEXT = 0;

                ReturnShipmentHeader.RESET;
                ReturnShipmentHeader.SETRANGE(ReturnShipmentHeader."No.", "Purch. Cr. Memo Line"."Return Shipment No.");
                IF ReturnShipmentHeader.FINDFIRST THEN;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        recSP: Record 13;
        recCR: Record 9;
        Vendor: Record 23;
        vCurrency: Decimal;
        vAmount: Decimal;
        PCMCurrency: Decimal;
        PCMAmount: Decimal;
        PCMSP: Record 13;
        PCMVendor: Record 23;
        SCMCR: Record 9;
        // DGSTLE: Record 16419; //pcpl-064 01Aug2023
        DGSTLE: Record "Detailed GST Ledger Entry";
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        IGSTAmt: Decimal;
        CESSGSTAmt: Decimal;
        // PCMDGSTLE: Record "16419"; //pcpl-064 01Aug2023
        PCMDGSTLE: Record "Detailed GST Ledger Entry";
        PCMCGSTAmt: Decimal;
        PCMSGSTAmt: Decimal;
        PCMIGSTAmt: Decimal;
        PCMCESSGSTAmt: Decimal;
        PurchInvHeader: Record 122;
        PurchCrMemoHdr: Record 124;
        vAmountPCM: Decimal;
        vCurrencyPCM: Decimal;
        StateCodePCM: Code[10];
        StateCode: Code[10];
        PCMrecCR: Record 9;
        PCMrecSP: Record 13;
        PurchRcptHeader: Record 120;
        ReturnShipmentHeader: Record 6650;
}

