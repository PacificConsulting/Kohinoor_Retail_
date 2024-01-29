tableextension 50340 "Sales Line Archive" extends "Sales Line Archive"
{
    fields
    {
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

    }
}
