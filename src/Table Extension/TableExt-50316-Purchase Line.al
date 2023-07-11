tableextension 50316 "Purchase Line Ext" extends "Purchase Line"
{
    fields
    {
        field(50301; "Warranty Parent Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50302; "No. 2"; Text[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item."No. 2" where("No." = field("No.")));
            Editable = false;
        }

        modify("No.")
        {
            trigger OnAfterValidate()
            var
                TradeAggre: record "Trade Aggrement";
                PurchHeder: record 38;
                RecLoc: Record 14;
            begin
                IF PurchHeder.Get(rec."Document Type", rec."Document No.") then;
                TradeAggre.Reset();
                TradeAggre.SetRange("Item No.", Rec."No.");
                TradeAggre.SetRange("Location Code", PurchHeder."Location Code");
                TradeAggre.SetFilter("From Date", '<=%1', PurchHeder."Posting Date");
                TradeAggre.SetFilter("To Date", '>=%1', PurchHeder."Posting Date");
                IF TradeAggre.FindFirst() then begin
                    Validate("Direct Unit Cost", TradeAggre."Purchase Price");
                    //"Price Inclusive of Tax" := true;
                end else begin
                    TradeAggre.SetRange("Location Code");
                    IF TradeAggre.FindFirst() then begin
                        Validate("Direct Unit Cost", TradeAggre."Purchase Price");
                        // "Price Inclusive of Tax" := true
                    end;
                end;
                IF RecItem.Get(rec."No.") then begin
                    IF RecItem.Type <> RecItem.Type::Service then begin
                        IF RecLoc.Get(PurchHeder."Location Code") then begin
                            IF RecLoc."Default Receipt Bin" <> '' then
                                "Bin Code" := RecLoc."Default Receipt Bin";
                        end;
                    end;
                end;
            end;

        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                TradeAggre: record "Trade Aggrement";
                PurchHeder: record 38;
            begin
                IF PurchHeder.Get(rec."Document Type", rec."Document No.") then;
                TradeAggre.Reset();
                TradeAggre.SetCurrentKey("Item No.", "From Date", "To Date", "Location Code");
                TradeAggre.SetRange("Customer Group", TradeAggre."Customer Group"::Regular);
                TradeAggre.SetRange("Item No.", Rec."No.");
                TradeAggre.SetRange("Location Code", Rec."Location Code");
                TradeAggre.SetFilter("From Date", '<=%1', PurchHeder."Posting Date");
                TradeAggre.SetFilter("To Date", '>=%1', PurchHeder."Posting Date");
                IF TradeAggre.FindFirst() then begin
                    Validate("Direct Unit Cost", TradeAggre."Purchase Price");
                    //"Price Inclusive of Tax" := true;
                end else begin
                    TradeAggre.SetRange("Location Code");
                    IF TradeAggre.FindFirst() then begin
                        Validate("Direct Unit Cost", TradeAggre."Purchase Price");
                        // "Price Inclusive of Tax" := true
                    end;
                end;
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                Item: Record 27;
                GetItem: Record 27;
                PLInit: Record 39;
                PurchaseLine: Record 39;
                PurchLineFilter: Record 39;
                PH: Record 38;
                ItemConfig: record "Link Item";
            begin

                IF Rec."Document Type" = Rec."Document Type"::Order then begin
                    IF Rec.Quantity > 0 then begin
                        ItemConfig.Reset();
                        ItemConfig.SetCurrentKey("Item No.");
                        ItemConfig.SetRange("Item No.", Rec."No.");
                        IF ItemConfig.FindSet() then
                            repeat
                                PurchLineFilter.Reset();
                                PurchLineFilter.SetCurrentKey("Document No.", "Warranty Parent Line No.");
                                PurchLineFilter.SetRange("Document No.", "Document No.");
                                //PurchLineFilter.SetRange("No.", ItemConfig."Item Child No.");
                                PurchLineFilter.SetRange("Warranty Parent Line No.", "Line No.");
                                if Not PurchLineFilter.FindFirst() then begin
                                    //*********New Line Insert*******
                                    PLInit.Init();
                                    PLInit."Document Type" := rec."Document Type";
                                    PLInit."Document No." := rec."Document No.";

                                    PurchaseLine.Reset();
                                    PurchaseLine.SetRange("Document No.", "Document No.");
                                    if PurchaseLine.FindLast() then
                                        PLInit."Line No." := PurchaseLine."Line No." + 10000;

                                    PLInit.Insert();
                                    PLInit.Type := PLInit.Type::Item;
                                    PLInit.Validate("No.", ItemConfig."Item Child No.");//
                                    PLInit.Validate(Quantity, Rec.Quantity);
                                    PLInit.Validate("Location Code", Rec."Location Code");
                                    PLInit.Validate("Bin Code", Rec."Bin Code");
                                    PLInit.Validate("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                                    PLInit.Validate("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                                    PLInit."Warranty Parent Line No." := Rec."Line No.";
                                    PLInit.Modify();
                                end else begin
                                    //**********Modify Qty only**********
                                    PurchLineFilter.Validate(Quantity, Rec.Quantity);
                                    PurchLineFilter.Modify();
                                end;

                            until ItemConfig.Next() = 0;
                    end;
                end;
            end;
        }
    }


    var
        RecItem: Record 27;
}