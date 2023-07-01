xmlport 50302 "Sales Document Upload"
{
    Direction = Import;
    DefaultFieldsValidation = true;
    Format = VariableText;
    FormatEvaluate = Legacy;
    schema
    {
        textelement(root)
        {

            tableelement(Integer; Integer)
            {
                XmlName = 'SalesHeader';
                AutoSave = false;
                textelement(DocumentType)
                {
                }
                textelement(Postingdate)
                {
                }
                textelement(CustNo)
                {
                }
                textelement(ShiptoAdd)
                {
                }
                textelement(LocationCode)
                {
                }
                textelement(Type1)
                {
                }
                textelement(itemno)
                {
                    XmlName = 'ItemNo';
                }
                textelement(quantity)
                {
                    XmlName = 'Quantity';
                }
                textelement(Unitprice)
                {
                }
                textelement(GSTGroupCode)
                {
                }
                textelement(HSNCode)
                {
                }
                textelement(PayemntCode)
                {
                }
                textelement(ExterDocNo)
                {
                }
                textelement(GlobalDimension1)
                {
                }
                textelement(GlobalDimension2)
                {
                }
                textelement(staffID)
                {
                }
                trigger OnBeforeInsertRecord()
                var
                    RecLoc: Record 14;
                begin
                    SalesRec.Get();
                    EVALUATE(DocType, DocumentType);
                    SaleseHeader.RESET;
                    SaleseHeader.SETRANGE("Document Type", DocType);
                    SaleseHeader.SETRANGE("No.", DocNo);
                    SaleseHeader.SetRange("Location Code", LocationCode);
                    IF NOT SaleseHeader.FINDFIRST THEN BEGIN
                        SaleseHeader.INIT;
                        SaleseHeader.VALIDATE(SaleseHeader."Document Type", DocType);
                        IF DocType = DocType::Order then begin
                            IF RecLoc.Get(LocationCode) then
                                RecLoc.TestField("Sales Order Nos");
                            DocNo := NoSeriesMgt.GetNextNo(RecLoc."Sales Order Nos", SaleseHeader."Posting Date", true);
                            SaleseHeader."No." := DocNo;
                        end else
                            if DocType = DocType::Invoice then begin
                                SalesRec.TestField(SalesRec."Invoice Nos.");
                                DocNo := NoSeriesMgt.GetNextNo(SalesRec."Invoice Nos.", SaleseHeader."Posting Date", true);
                                SaleseHeader."No." := DocNo;
                            end else
                                if DocType = DocType::"Credit Memo" then begin
                                    SalesRec.TestField(SalesRec."Credit Memo Nos.");
                                    DocNo := NoSeriesMgt.GetNextNo(SalesRec."Credit Memo Nos.", SaleseHeader."Posting Date", true);
                                    SaleseHeader."No." := DocNo;
                                end else
                                    if DocType = DocType::"Return Order" then begin
                                        SalesRec.TestField(SalesRec."Return Order Nos.");
                                        DocNo := NoSeriesMgt.GetNextNo(SalesRec."Return Order Nos.", SaleseHeader."Posting Date", true);
                                        SaleseHeader."No." := DocNo;
                                    end;

                        SaleseHeader.INSERT(TRUE);
                        SaleseHeader.VALIDATE("Sell-to Customer No.", CustNo);
                        EVALUATE(PostDate, Postingdate);
                        SaleseHeader.Validate("Staff Id", staffID);
                        SaleseHeader.VALIDATE(SaleseHeader."Posting Date", PostDate);
                        SaleseHeader.Validate("Payment Terms Code", PayemntCode);
                        SaleseHeader.validate("External Document No.", ExterDocNo);
                        SaleseHeader.validate("Document Date", DocDate);
                        SaleseHeader.VALIDATE(SaleseHeader."Location Code", LocationCode);
                        SaleseHeader.VALIDATE("Shortcut Dimension 1 Code", GlobalDimension1);
                        SaleseHeader.VALIDATE("Shortcut Dimension 2 Code", GlobalDimension2);
                        SaleseHeader."Store No." := GlobalDimension2;
                        SaleseHeader.Validate("Ship-to Code", ShiptoAdd);
                        SaleseHeader.MODIFY(true);
                        COMMIT;

                        SalesLine.RESET;
                        SalesLine.SETRANGE(SalesLine."Document No.", SaleseHeader."No.");
                        IF SalesLine.FINDLAST THEN
                            Linenumber := SalesLine."Line No." + 10000
                        ELSE
                            Linenumber := 10000;

                        SalesLine.INIT;
                        SalesLine.VALIDATE(SalesLine."Document Type", DocType);
                        SalesLine."Document No." := SaleseHeader."No.";
                        SalesLine."Line No." := Linenumber;
                        SalesLine.INSERT(TRUE);
                        SalesLine.VALIDATE(SalesLine."Location Code", SaleseHeader."Location Code");
                        Evaluate(ItemType, type1);
                        SalesLine.Validate(Type, ItemType);
                        SalesLine.VALIDATE(SalesLine."No.", ItemNo);
                        EVALUATE(Qty, Quantity);
                        SalesLine.VALIDATE(SalesLine.Quantity, Qty);
                        EVALUATE(UnitCostValue, Unitprice);
                        SalesLine.Validate("GST Group Code", GSTGroupCode);
                        SalesLine.Validate("HSN/SAC Code", HSNCode);
                        SalesLine.VALIDATE("Unit Price Incl. of Tax", UnitCostValue);
                        SalesLine."Price Inclusive of Tax" := true;
                        SalesLine.VALIDATE("Shortcut Dimension 1 Code", SaleseHeader."Shortcut Dimension 1 Code");
                        SalesLine.VALIDATE("Shortcut Dimension 2 Code", SaleseHeader."Shortcut Dimension 2 Code");
                        SalesLine."Store No." := SaleseHeader."Shortcut Dimension 2 Code";
                        SalesLine.MODIFY(TRUE);

                    END ELSE BEGIN
                        SalesLine.RESET;
                        SalesLine.SETRANGE(SalesLine."Document No.", SaleseHeader."No.");
                        IF SalesLine.FINDLAST THEN
                            Linenumber := SalesLine."Line No." + 10000
                        ELSE
                            Linenumber := 10000;
                        SalesLine.INIT;
                        SalesLine."Document Type" := SaleseHeader."Document Type";
                        SalesLine."Document No." := SaleseHeader."No.";
                        SalesLine."Line No." := Linenumber;
                        SalesLine.INSERT(TRUE);
                        SalesLine.VALIDATE(SalesLine."Location Code", SaleseHeader."Location Code");
                        SalesLine.Validate(Type, ItemType);
                        SalesLine.VALIDATE(SalesLine."No.", ItemNo);
                        EVALUATE(Qty, Quantity);
                        SalesLine.VALIDATE(SalesLine.Quantity, Qty);
                        EVALUATE(UnitCostValue, Unitprice);
                        SalesLine.VALIDATE("Unit Price Incl. of Tax", UnitCostValue);
                        SalesLine."Price Inclusive of Tax" := true;
                        SalesLine."Store No." := SaleseHeader."Shortcut Dimension 2 Code";
                        SalesLine.MODIFY(TRUE);
                    END;

                end;

                trigger OnAfterInitRecord()
                begin
                    I += 1;
                    IF I = 1 THEN
                        currXMLport.SKIP;
                end;

            }

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


    trigger OnPostXmlPort()
    begin
        MESSAGE('Data has been imported successfully,Last Document No. is %1', SaleseHeader."No.");
    end;

    var

        Text0001: Label 'Item No. %1 is not a part of Purchase %2 No. %3';
        Text0002: Label 'Please Modify the Quantity for Item No. %1 as the Quantity being recieved is more than %2. Total Quantity being recieved is %3';
        Linenumber: Integer;
        SaleseHeader: Record 36;
        PostDate: Date;
        DocDate: Date;
        SalesLine: Record 37;
        Unit: Decimal;
        Qty: Decimal;
        //NoSerMngt: Codeunit no
        Item: Record 27;
        BrandInp: Code[20];
        OrderNoSeries: Code[20];
        Location: Record 14;
        NoBOx: Decimal;
        UnitCostValue: Decimal;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        firstline: Boolean;
        "GlobalDimension-1": Record 349;
        NoSeriesMgt: Codeunit 396;
        ItemType: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        DocNo: Code[20];
        SalesRec: Record "Sales & Receivables Setup";
        I: Integer;

}

