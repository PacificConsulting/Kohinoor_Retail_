tableextension 50307 "Payment Method" extends "Payment Method"
{
    fields
    {
        field(50301; Tender; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50302; "Payment Type"; Enum "Payment Type Ext")
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                BankAcc: Record "Bank Account";
                BankAccFilter: Record "Bank Account";
                Noseries: Codeunit NoSeriesManagement;
                GL: Record "General Ledger Setup";
                BankAccposting: Record "Bank Account Posting Group";
            begin
                IF Rec.Tender = true then begin
                    GL.Get();
                    IF (Rec."Payment Type" <> rec."Payment Type"::" ") or
                    (Rec."Payment Type" <> rec."Payment Type"::Cheque) then begin
                        BankAccFilter.Reset();
                        BankAccFilter.SetFilter("No.", '%1', rec.Code);
                        IF Not BankAccFilter.FindFirst() then begin
                            //****Bank Acc Posting Group reation*******
                            BankAccposting.Init();
                            BankAccposting.Code := Rec.Code;
                            BankAccposting.Insert(true);
                            //******Bank Account Creation********
                            BankAcc.Init();
                            BankAcc."No." := rec.Code;
                            BankAcc.Name := rec.Description;
                            BankAcc."Bank Acc. Posting Group" := BankAccposting.Code;
                            BankAcc.Insert(true);
                            Message('New bank Account Created with No. %1', BankAcc."No.");
                        end;

                    end;
                end;
            end;
        }
    }

    var
        myInt: Integer;
}