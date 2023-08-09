pageextension 50361 "Detailed GST Led Entry " extends "Detailed GST Ledger Entry"
{
    layout
    {
        addafter("Source No.")
        {

            field("Party Name"; Rec."Party Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Party Name field.';
            }
        }
        addafter("Posting Date")
        {

            field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Invoice Date field.';
            }
        }
    }
    actions
    {
        addafter("Show Related Information")
        {
            action("Update Data")
            {
                ApplicationArea = all;
                Image = UpdateDescription;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    DGLE: Record "Detailed GST Ledger Entry";
                    Vend: Record 23;
                    Cust: Record 18;
                    VLE: Record "Vendor Ledger Entry";
                begin
                    DGLE.Reset();
                    DGLE.SetRange("Party Name", '');
                    IF DGLE.FindSet() then
                        repeat
                            IF DGLE."Source Type" = DGLE."Source Type"::Customer then begin
                                IF Cust.get(DGLE."Source No.") then begin
                                    DGLE."Party Name" := Cust.Name;
                                    DGLE.Modify();
                                end;
                            end else
                                IF DGLE."Source Type" = DGLE."Source Type"::Vendor then begin
                                    IF Vend.get(DGLE."Source No.") then begin
                                        DGLE."Party Name" := Vend.Name;
                                        DGLE.Modify();
                                    end;
                                end
                        until DGLE.next = 0;
                    DGLE.Reset();
                    DGLE.SetRange("Source Type", DGLE."Source Type"::Vendor);
                    DGLE.SetRange("Vendor Invoice Date", 0D);
                    IF DGLE.FindSet() then
                        repeat
                            VLE.Reset();
                            VLE.SetRange("Document No.", DGLE."Document No.");
                            IF VLE.FindFirst() then begin
                                DGLE."Vendor Invoice Date" := VLE."Document Date";
                                DGLE.Modify();
                            end;
                        until DGLE.Next() = 0;
                    Message('Data updated successfully...');
                end;
            }
        }
    }
}
