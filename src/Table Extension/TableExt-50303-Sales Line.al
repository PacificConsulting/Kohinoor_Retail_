tableextension 50303 "Sales Line Retail" extends "Sales Line"
{
    fields
    {



        modify("No.")
        {
            trigger OnAfterValidate()
            var
                TradeAggre: record "Trade Aggrement";
                SalesHeder: record 36;
                BlockItem: Record "Block Item List";
                Cust: Record 18;
                recitem: Record 27;
            begin
                IF SalesHeder.Get(rec."Document Type", rec."Document No.") then begin
                    BlockItem.Reset();
                    BlockItem.SetRange("Store No.", SalesHeder."Store No.");
                    BlockItem.SetRange("Item No.", "No.");
                    if BlockItem.FindFirst() then
                        Error('This %1 Item No. is block', BlockItem."Item No.");
                end;


                IF SalesHeder.Get(rec."Document Type", rec."Document No.") then;
                IF rec.Type = rec.Type::Item then begin
                    IF recitem.Get(Rec."No.") then begin
                        IF recitem.Type = recitem.Type::Inventory then begin
                            IF cust.get("Sell-to Customer No.") then;
                            TradeAggre.Reset();
                            TradeAggre.SetCurrentKey("Item No.", "From Date", "To Date", "Location Code");
                            //TradeAggre.SetRange("Customer Group", TradeAggre."Customer Group"::Regular);
                            TradeAggre.SetRange("Customer Group", Cust."Customer Group"); //New Condition Add
                            TradeAggre.SetRange("Item No.", Rec."No.");
                            TradeAggre.SetRange("Location Code", SalesHeder."Location Code");
                            TradeAggre.SetFilter("From Date", '<=%1', SalesHeder."Posting Date");
                            TradeAggre.SetFilter("To Date", '>=%1', SalesHeder."Posting Date");
                            IF TradeAggre.FindFirst() then begin
                                Validate("Unit Price Incl. of Tax", TradeAggre."Amount In INR");
                                "Price Inclusive of Tax" := true;
                                Validate(MOP, TradeAggre.MOP);
                                validate("Last Selling Price", TradeAggre."Last Selling Price");
                                Validate(NNLC, TradeAggre.NNLC);
                                validate("PMG NLC W/O SELL OUT", TradeAggre."PMG NLC W/O SELL OUT");
                                Validate("Manager Discection", TradeAggre."Manager Discection");
                                validate("Manager Discection - INC", TradeAggre."Manager Discection - INC");
                                Validate("Sellout Text", TradeAggre."Sellout Text");
                                Validate(Sellout, TradeAggre.Sellout);
                                Validate("Sell out Text From Date", TradeAggre."Sell out Text From Date");
                                Validate("Sell out Text To Date", TradeAggre."Sell out Text To Date");
                                Validate("Fnnlc with sell out", TradeAggre."Fnnlc with sell out");
                                Validate(FNNLC, TradeAggre.FNNLC);
                                Validate("FNNLC Without SELLOUT", TradeAggre."FNNLC Without SELLOUT");
                                Validate("SLAB 1 - INC", TradeAggre."SLAB 1 - INC");
                                Validate("SLAB 2 - INC", TradeAggre."SLAB 2 - INC");
                                Validate("SLAB 1 - PRICE", TradeAggre."SLAB 1 - PRICE");
                                Validate("SLAB 2 - PRICE", TradeAggre."SLAB 2 - PRICE");
                                Validate(AMZ, TradeAggre.AMZ);
                                Validate(PROMO, TradeAggre.PROMO);
                                Validate(PRICE_TAG, TradeAggre.PRICE_TAG);
                                Validate(KTVWEB_WE, TradeAggre.KTVWEB_WE);
                                Validate(KTVWEB_WOE, TradeAggre.KTVWEB_WOE);
                                Validate("M.R.P", TradeAggre."M.R.P");
                                Validate(ALLFINANCE, TradeAggre.ALLFINANCE);
                                Validate(CASHBACK, TradeAggre.CASHBACK);
                                Validate(DP, TradeAggre.DP);
                                Validate("Actual From Date", TradeAggre."Actual From Date");
                                Validate("Actual To Date", TradeAggre."Actual To Date");

                            end else begin
                                TradeAggre.SetRange("Location Code");
                                IF TradeAggre.FindFirst() then begin
                                    Validate("Unit Price Incl. of Tax", TradeAggre."Amount In INR");
                                    "Price Inclusive of Tax" := true;
                                    Validate(MOP, TradeAggre.MOP);
                                    validate("Last Selling Price", TradeAggre."Last Selling Price");
                                    Validate(NNLC, TradeAggre.NNLC);
                                    validate("PMG NLC W/O SELL OUT", TradeAggre."PMG NLC W/O SELL OUT");
                                    Validate("Manager Discection", TradeAggre."Manager Discection");
                                    validate("Manager Discection - INC", TradeAggre."Manager Discection - INC");
                                    Validate("Sellout Text", TradeAggre."Sellout Text");
                                    Validate(Sellout, TradeAggre.Sellout);
                                    Validate("Sell out Text From Date", TradeAggre."Sell out Text From Date");
                                    Validate("Sell out Text To Date", TradeAggre."Sell out Text To Date");
                                    Validate("Fnnlc with sell out", TradeAggre."Fnnlc with sell out");
                                    Validate(FNNLC, TradeAggre.FNNLC);
                                    Validate("FNNLC Without SELLOUT", TradeAggre."FNNLC Without SELLOUT");
                                    Validate("SLAB 1 - INC", TradeAggre."SLAB 1 - INC");
                                    Validate("SLAB 2 - INC", TradeAggre."SLAB 2 - INC");
                                    Validate("SLAB 1 - PRICE", TradeAggre."SLAB 1 - PRICE");
                                    Validate("SLAB 2 - PRICE", TradeAggre."SLAB 2 - PRICE");
                                    Validate(AMZ, TradeAggre.AMZ);
                                    Validate(PROMO, TradeAggre.PROMO);
                                    Validate(PRICE_TAG, TradeAggre.PRICE_TAG);
                                    Validate(KTVWEB_WE, TradeAggre.KTVWEB_WE);
                                    Validate(KTVWEB_WOE, TradeAggre.KTVWEB_WOE);
                                    Validate("M.R.P", TradeAggre."M.R.P");
                                    Validate(ALLFINANCE, TradeAggre.ALLFINANCE);
                                    Validate(CASHBACK, TradeAggre.CASHBACK);
                                    Validate(DP, TradeAggre.DP);
                                    Validate("Actual From Date", TradeAggre."Actual From Date");
                                    Validate("Actual To Date", TradeAggre."Actual To Date");
                                end else
                                    Error('Trade Agreement does not exist for posting date %1', SalesHeder."Posting Date");
                            end;
                        end;
                    end;
                end;
            end;

        }
        modify(Quantity)
        {
            // trigger OnBeforeValidate()
            // begin
            //     Message('Hi');
            // end;

            trigger OnAfterValidate()
            var
                Item: Record 27;
                GetItem: Record 27;
                SLInit: Record 37;
                SalesLine: Record 37;
                SalesLineFilter: Record 37;
                SH: Record 36;
                NewItem: Record 27;
                I: Integer;
                J: Integer;
                Itemvar: Code[20];
                RecItem: Record 27;
                ItemConfig: Record "Link Item";
            begin

                IF Rec.Type = rec.Type::Item then begin
                    IF Rec.Quantity > 0 then begin
                        ItemConfig.Reset();
                        ItemConfig.SetCurrentKey("Item No.");
                        ItemConfig.SetRange("Item No.", Rec."No.");
                        IF ItemConfig.FindSet() then
                            repeat
                                SalesLineFilter.Reset();
                                SalesLineFilter.SetCurrentKey("Document No.", "Warranty Parent Line No.");
                                SalesLineFilter.SetRange("Document No.", "Document No.");
                                // SalesLineFilter.SetRange("No.", ItemConfig."Item Child No.");
                                SalesLineFilter.SetRange("Warranty Parent Line No.", "Line No.");
                                if not SalesLineFilter.FindFirst() then begin
                                    //*********New Line Insert*******
                                    SLInit.Init();
                                    SLInit."Document Type" := rec."Document Type";
                                    SLInit."Document No." := rec."Document No.";

                                    SalesLine.Reset();
                                    SalesLine.SetRange("Document No.", "Document No.");
                                    if SalesLine.FindLast() then
                                        SLInit."Line No." := SalesLine."Line No." + 10000;


                                    SLInit.Type := SLInit.Type::Item;
                                    SLInit.Validate("No.", ItemConfig."Item Child No.");
                                    SLInit.Validate(Quantity, Rec.Quantity);
                                    SLInit.Validate("Location Code", Rec."Location Code");
                                    SLInit.Validate("Store No.", Rec."Store No.");
                                    SLInit.Validate("Salesperson Code", Rec."Salesperson Code");
                                    SLInit.Validate("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                                    SLInit.Validate("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                                    SLInit."Warranty Parent Line No." := SalesLine."Line No.";
                                    SLInit.Insert();
                                end else begin
                                    //**********Modify Qty only**********
                                    SalesLineFilter.Validate(Quantity, Rec.Quantity);
                                    SalesLineFilter.Modify();
                                end;
                            until ItemConfig.Next() = 0;
                    end;
                end;
            end;
        }

        field(50301; "Store No."; Code[20])
        {
            Caption = 'Store No.';
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;

        }
        field(50302; "Approval Status"; Enum "Sales Line Approval Status")
        {
            DataClassification = ToBeClassified;

        }
        field(50303; "Approval Sent By"; Text[50])//
        {
            DataClassification = ToBeClassified;
        }
        field(50304; "Approval Sent On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50305; "Approved By"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50306; "Approved On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50307; "Old Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50308; "Exchange Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
            //Editable = false;
        }
        field(50309; "Serial No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50310; "GST Tax Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50311; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser".Code where("Global Dimension 2 Code" = field("Shortcut Dimension 2 Code"));
            trigger OnValidate()
            var
                SP: Record "Salesperson/Purchaser";
            begin
                IF SP.Get(Rec."Salesperson Code") then
                    "Salesperson Name" := SP.Name;

            end;
        }
        field(50312; "Salesperson Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50313; "Warranty Parent Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50314; "Exchange Comment"; Text[150])
        {
            DataClassification = ToBeClassified;

        }
        field(50315; "Rejected By"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50316; "Rejected On"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50317; "No. 2"; Text[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item."No. 2" where("No." = field("No.")));
            Editable = false;
        }
        field(50318; "Warranty Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50319; MOP; Decimal)
        {
            Caption = 'MOP';
            DataClassification = ToBeClassified;
        }
        field(50321; "Last Selling Price"; Decimal)
        {
            Caption = 'Last Selling Price';
            DataClassification = ToBeClassified;
        }
        field(50322; NNLC; Decimal)
        {
            Caption = 'NNLC';
            DataClassification = ToBeClassified;
        }
        field(50323; "PMG NLC W/O SELL OUT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50324; "Manager Discection"; Decimal)
        {
            Caption = 'Manager Discection';
            DataClassification = ToBeClassified;
        }
        field(50325; "Sellout Text"; Text[100])
        {
            Caption = 'Sellout Text';
            DataClassification = ToBeClassified;
        }

        field(50327; "Sell out Text From Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50328; "Sell out Text To Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50329; Sellout; Decimal)
        {
            Caption = 'Sellout';
            DataClassification = ToBeClassified;
        }
        field(50330; "From Date"; Date)
        {
            Caption = 'From Date';
            DataClassification = ToBeClassified;
        }
        field(50331; "To Date"; Date)
        {
            Caption = 'To Date';
            DataClassification = ToBeClassified;
        }
        field(50332; FNNLC; Decimal)
        {
            Caption = 'FNNLC';
            DataClassification = ToBeClassified;
        }
        field(50333; "Fnnlc with sell out"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fnnlc with sell out';
        }
        field(50334; "FNNLC Without SELLOUT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50335; "Manager Discection - INC"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Manager Discection - INC';
        }
        field(50336; "SLAB 1 - PRICE"; Decimal)
        {
            Caption = 'SLAB 1 - PRICE';
            DataClassification = ToBeClassified;
        }
        field(50337; "SLAB 2 - PRICE"; Decimal)
        {
            Caption = 'SLAB 2 - PRICE';
            DataClassification = ToBeClassified;
        }
        field(50338; "SLAB 1 - INC"; Decimal)
        {
            Caption = 'SLAB 1 - INC';
            DataClassification = ToBeClassified;
        }
        field(50339; "SLAB 2 - INC"; Decimal)
        {
            Caption = 'SLAB 2 - INC';
            DataClassification = ToBeClassified;
        }
        field(50340; AMZ; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'AMZ';
        }
        field(50341; PROMO; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'PROMO';
        }
        field(50342; "PRICE_TAG"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'PRICE_TAG';
        }
        field(50343; "KTVWEB_WOE"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'KTVWEB_WOE';
        }
        field(50344; "KTVWEB_WE"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'KTVWEB_WE';
        }
        field(50345; "M.R.P"; Decimal)
        {
            Caption = 'M.R.P';
            DataClassification = ToBeClassified;
        }
        field(50346; "ALLFINANCE"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'ALLFINANCE';
        }
        field(50347; CASHBACK; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'CASHBACK';
        }
        field(50348; DP; Decimal)
        {
            Caption = 'DP';
            DataClassification = ToBeClassified;
        }
        field(50349; "Actual From Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Actual From Date';
        }
        field(50350; "Actual To Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Actual To Date';
        }
        field(50351; "Customer Name"; Text[100])
        {

            Caption = 'Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Sell-to Customer No.")));
        }


    }

    trigger OnModify()
    begin
        IF "Approval Status" = "Approval Status"::"Pending for Approval" then
            Error('You can not modify Lines if Approval Status is Pending for Approval ');
    end;

    trigger OnInsert()
    var
        RecLoc: Record Location;
        SalesHeader: Record 36;
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("No.", "Document No.");
        IF SalesHeader.FindFirst() then begin
            IF SalesHeader."Store No." <> '' then begin
                RecLoc.Reset();
                RecLoc.SetRange(Store, true);
                RecLoc.SetRange(Code, SalesHeader."Store No.");
                IF RecLoc.FindFirst() then begin
                    //Validate("Location Code", RecLoc.Code);
                    "Store No." := RecLoc.Code;
                end;
            end;
        end;
        IF "Approval Status" = "Approval Status"::"Pending for Approval" then
            Error('You can not modify Lines if Approval Status is Pending for Approval ');

        SalesHeader.Reset();
        SalesHeader.SetRange("No.", "Document No.");
        SalesHeader.SetFilter("POS Released Date", '<>%1', 0D);
        SalesHeader.SetRange("Document Type", "Document Type"::Order);
        IF SalesHeader.FindFirst() then begin
            if rec.Type <> rec.Type::" " then
                Error('You can not insert new line when order is Confirmed');
        end;

    end;


    trigger OnDelete()
    begin
        IF "Approval Status" = "Approval Status"::"Pending for Approval" then
            Error('You can not modify Lines if Approval Status is Pending for Approval ');
    end;


}
