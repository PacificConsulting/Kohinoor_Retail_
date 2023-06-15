tableextension 50303 "Sales Line Retail" extends "Sales Line"
{
    fields
    {
        modify("Unit Price Incl. of Tax")
        {
            trigger OnAfterValidate()
            var
                SH: Record 36;
            begin
                //****Below code commened due to Sales Statictic page run same error coming now same code done on Sales line Page
                /*
                SH.Reset();
                SH.SetRange("No.", "Document No.");
                SH.SetFilter("POS Released Date", '<>%1', 0D);
                SH.SetRange("Document Type", "Document Type"::Order);
                IF SH.FindFirst() then
                    Error('You can not change the unit price incl. of tax when order is Confirmed');
                    */
            end;
        }
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            var
                SH: Record 36;
            begin
                // SH.Reset();
                // SH.SetRange("No.", "Document No.");
                // SH.SetFilter("POS Released Date", '<>%1', 0D);
                // SH.SetRange("Document Type", "Document Type"::Order);
                // IF SH.FindFirst() then
                //     Error('You can not change the unit price when order is Confirmed');
            end;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                TradeAggre: record "Trade Aggrement";
                SalesHeder: record 36;
                BlockItem: Record "Block Item List";

            begin
                SalesHeder.Reset();
                SalesHeder.SetRange("No.", rec."Document No.");
                SalesHeder.SetFilter("Document Type", '%1|%2', "Document Type"::Order, "Document Type"::Invoice);
                IF SalesHeder.FindFirst() then begin
                    BlockItem.Reset();
                    BlockItem.SetRange("Store No.", SalesHeder."Store No.");
                    BlockItem.SetRange("Item No.", "No.");
                    if BlockItem.FindFirst() then
                        Error('This %1 Item No. is block', BlockItem."Item No.");
                end;

                IF SalesHeder.Get(rec."Document Type", rec."Document No.") then;
                TradeAggre.Reset();
                TradeAggre.SetCurrentKey("Item No.", "From Date", "To Date", "Location Code");
                TradeAggre.SetRange("Customer Group", TradeAggre."Customer Group"::Regular);
                TradeAggre.SetRange("Item No.", Rec."No.");
                TradeAggre.SetRange("Location Code", SalesHeder."Location Code");
                TradeAggre.SetFilter("From Date", '<=%1', SalesHeder."Posting Date");
                TradeAggre.SetFilter("To Date", '>=%1', SalesHeder."Posting Date");
                IF TradeAggre.FindFirst() then begin
                    Validate("Unit Price Incl. of Tax", TradeAggre."Amount In INR");
                    "Price Inclusive of Tax" := true;
                end else begin
                    TradeAggre.SetRange("Location Code");
                    IF TradeAggre.FindFirst() then begin
                        Validate("Unit Price Incl. of Tax", TradeAggre."Amount In INR");
                        "Price Inclusive of Tax" := true
                    end;
                end;

                // Validate("Unit Price Incl. of Tax", 25000);
                //Validate("Price Inclusive of Tax", true);
                //"Price Inclusive of Tax" := true;
            end;

        }
        modify(Quantity)
        {
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
                ItemConfig: Record "Item Component";
            begin
                //****Below code commened due to Sales Statictic page run same error coming now same code done on Sales line Page
                // SH.Reset();
                // SH.SetRange("No.", "Document No.");
                // SH.SetRange("Document Type", "Document Type"::Order);
                // SH.SetFilter("POS Released Date", '<>%1', 0D);
                // IF SH.FindFirst() then
                //     Error('You can not change the quantity when order is Confirmed');
                IF Rec.Type <> rec.Type::" " then begin
                    IF Rec.Quantity > 0 then begin
                        ItemConfig.Reset();
                        ItemConfig.SetRange("Item No.", Rec."No.");
                        IF ItemConfig.FindSet() then
                            repeat
                                SalesLineFilter.Reset();
                                SalesLineFilter.SetRange("Document No.", "Document No.");
                                SalesLineFilter.SetRange("No.", ItemConfig."Item Child No.");
                                if not SalesLineFilter.FindFirst() then begin
                                    //*********New Line Insert*******
                                    SLInit.Init();
                                    SLInit."Document Type" := rec."Document Type";
                                    SLInit."Document No." := rec."Document No.";

                                    SalesLine.Reset();
                                    SalesLine.SetRange("Document No.", "Document No.");
                                    if SalesLine.FindLast() then
                                        SLInit."Line No." := SalesLine."Line No." + 10000;

                                    SLInit.Insert();
                                    SLInit.Type := SLInit.Type::Item;
                                    SLInit.Validate("No.", ItemConfig."Item Child No.");
                                    SLInit.Validate(Quantity, SalesLine.Quantity);
                                    SLInit.Validate("Location Code", SalesLine."Location Code");
                                    SLInit.Validate("Store No.", SalesLine."Store No.");
                                    SLInit.Validate("Salesperson Code", SalesLine."Salesperson Code");
                                    SLInit.Validate("Shortcut Dimension 1 Code", SalesLine."Shortcut Dimension 1 Code");
                                    SLInit.Validate("Shortcut Dimension 2 Code", SalesLine."Shortcut Dimension 2 Code");
                                    SLInit."Warranty Parent Line No." := SalesLine."Line No.";
                                    SLInit.Modify();
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

        field(50301;
        "Store No.";
        Code[20])
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
            Editable = false;
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
                    Validate("Location Code", RecLoc.Code);
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
