tableextension 50312 "General Led.Setup Ext" extends "General Ledger Setup"
{
    fields
    {
        field(50301; "Bank Drop Batch"; Code[10])
        {
            Caption = 'Bank Drop Batch';
            DataClassification = ToBeClassified;
        }
        field(50302; "Slab Approval User 1"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Slab Approval User 1';
            TableRelation = "User Setup"."User ID";
            trigger OnValidate()
            var
                RecUser1: Record "User Setup";
            begin
                IF RecUser1.Get("Slab Approval User 1") then begin
                    RecUser1.TestField("E-Mail");
                end;
            end;
        }
        field(50303; "Slab Approval User 2"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Slab Approval User 2';
            TableRelation = "User Setup"."User ID";
            trigger OnValidate()
            var
                RecUser1: Record "User Setup";
            begin
                IF RecUser1.Get("Slab Approval User 2") then begin
                    RecUser1.TestField("E-Mail");
                end;
            end;
        }
        field(50304; "Slab Approval User 3"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Slab Approval User 3';
            TableRelation = "User Setup"."User ID";
            trigger OnValidate()
            var
                RecUser1: Record "User Setup";
            begin
                IF RecUser1.Get("Slab Approval User 3") then begin
                    RecUser1.TestField("E-Mail");
                end;
            end;
        }
        field(50305; "Cash Expense Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where("Direct Posting" = filter(true));
        }
        field(50306; "Slab Approval User 4"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Slab Approval User 4';
            TableRelation = "User Setup"."User ID";
            trigger OnValidate()
            var
                RecUser1: Record "User Setup";
            begin
                IF RecUser1.Get("Slab Approval User 4") then begin
                    RecUser1.TestField("E-Mail");
                end;
            end;
        }
        field(50307; "Slab Approval User 5"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Slab Approval User 5';
            TableRelation = "User Setup"."User ID";
            trigger OnValidate()
            var
                RecUser1: Record "User Setup";
            begin
                IF RecUser1.Get("Slab Approval User 5") then begin
                    RecUser1.TestField("E-Mail");
                end;
            end;
        }
        field(50308; "Slab Approval User 6"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Slab Approval User 6';
            TableRelation = "User Setup"."User ID";
            trigger OnValidate()
            var
                RecUser1: Record "User Setup";
            begin
                IF RecUser1.Get("Slab Approval User 6") then begin
                    RecUser1.TestField("E-Mail");
                end;
            end;
        }
        field(50309; "Slab Approval User 7"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Slab Approval User 7';
            TableRelation = "User Setup"."User ID";
            trigger OnValidate()
            var
                RecUser1: Record "User Setup";
            begin
                IF RecUser1.Get("Slab Approval User 7") then begin
                    RecUser1.TestField("E-Mail");
                end;
            end;
        }
        field(50310; "Exchange Batch"; Code[10])
        {
            Caption = 'Exchange Batch';
            DataClassification = ToBeClassified;
        }
    }
}
