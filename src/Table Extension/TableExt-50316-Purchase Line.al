tableextension 50316 "Purchase Line Ext" extends "Purchase Line"
{
    fields
    {

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
                IF RecLoc.Get(PurchHeder."Location Code") then begin
                    IF RecLoc."Default Receipt Bin" <> '' then
                        "Bin Code" := RecLoc."Default Receipt Bin";
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
                Item: Record 27;//
                GetItem: Record 27;
                PLInit: Record 39;
                PurchaseLine: Record 39;
                PurchLineFilter: Record 39;
                PH: Record 38;
            begin
                //IF GetItem.Get(rec."No.") then;
                IF Rec."Document Type" = Rec."Document Type"::Order then begin
                    IF Quantity > 0 then begin
                        PH.Reset();
                        PH.SetRange("No.", Rec."Document No.");
                        IF Ph.FindFirst() then;
                        Item.Reset();
                        Item.SetRange("Parent Item No.", Rec."No.");
                        IF Item.FindSet() then
                            repeat
                                PurchLineFilter.Reset();
                                PurchLineFilter.SetRange("Document No.", "Document No.");
                                PurchLineFilter.SetRange("No.", Item."No.");
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
                                    PLInit.Validate("No.", item."No.");
                                    PLInit.Validate(Quantity, PurchaseLine.Quantity);
                                    PLInit.Validate("Location Code", PH."Location Code");
                                    //PLInit.Validate("Store No.", PurchaseLine."Store No.");
                                    // PLInit.Validate("Salesperson Code", PurchaseLine."Salesperson Code");
                                    PLInit.Validate("Shortcut Dimension 1 Code", PurchaseLine."Shortcut Dimension 1 Code");
                                    PLInit.Validate("Shortcut Dimension 2 Code", PurchaseLine."Shortcut Dimension 2 Code");
                                    //PLInit."Warranty Parent Line No." := SalesLine."Line No.";
                                    PLInit.Modify();
                                end else begin
                                    //**********Modify Qty only**********
                                    PurchLineFilter.Validate(Quantity, Rec.Quantity);
                                    PurchLineFilter.Modify();
                                end;
                            until item.Next() = 0;
                    end;
                end;
            end;
        }
    }


    var
        myInt: Integer;
}