pageextension 50302 "Posted Sales invoice Retail" extends "Posted Sales Invoice"
{
    layout
    {
        addafter(SalesInvLines)
        {
            part(PostedPaymentLine; "Posted Payment Lines Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
                Editable = false;
            }
        }
        addafter(Closed)
        {
            field("Amount To Customer"; Rec."Amount To Customer")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Store No."; Rec."Store No.")
            {
                ApplicationArea = all;
            }
            field("Posted By"; Rec."Posted By")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posted By field.';
            }
        }
    }

    actions
    {
        addafter("Tax Invoice")
        {
            action("Send Mail to Finance")
            {
                ApplicationArea = all;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Promoted = true;
                Image = SendMail;
                trigger OnAction()
                var
                    CU: Codeunit 50304;
                    PPL: Record "Posted Payment Lines";
                    PaymentMethod: Record "Payment Method";
                    FinConfimBool: Boolean;
                    OtherConfimBool: Boolean;
                begin
                    PPL.Reset();
                    PPL.SetCurrentKey("Document No.");
                    PPL.SetRange("Document No.", Rec."No.");
                    PPL.SetRange("Payment type", PPL."Payment type"::Finance);
                    IF not PPL.FindFirst() then begin
                        Error('There is no finance payment is available in this invoice.');
                    end;

                    PPL.Reset();
                    PPL.SetCurrentKey("Document No.");
                    PPL.SetRange("Document No.", Rec."No.");
                    PPL.SetRange("Payment type", PPL."Payment type"::Finance);
                    IF PPL.FindFirst() then begin
                        //IF PaymentMethod.Get(PPL."Payment Method Code") then;
                        SendMail(Rec, ppl."Payment Method Code");
                    end;
                end;

            }
        }
    }
    local procedure SendMail(SIH: Record "Sales Invoice Header"; PayMethodCode: Code[10])
    var
        Recref: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        Instr: InStream;
        EMail: Codeunit Email;
        Emailmessage: Codeunit "Email Message";
        VarRecipient: list of [Text];
        Char: Char;
        ETF: Record "Email to Finance";
        SIHNEW: Record 112;
        VCount: Integer;
    begin
        VarRecipient.RemoveRange(1, VarRecipient.Count);
        Clear(VCount);
        ETF.Reset();
        ETF.SetCurrentKey("Payment Method");
        ETF.SetRange("Payment Method", PayMethodCode);
        IF ETF.FindSet() then
            repeat
                VarRecipient.Add(ETF."E-Mail");
            until ETF.Next() = 0;

        //**** Email Create **** 
        VCount := VarRecipient.Count();
        IF VCount <> 0 then begin
            Emailmessage.Create(VarRecipient, 'Tax Invoice' + SIH."No." + ' Dated ' + FORMAT(SIH."Order Date"), '', true);
            //**** Report SaveAsPDF and Attached in Mail
            SIHNEW.Reset();
            SIHNEW.SetRange("No.", SIH."No.");
            IF SIHNEW.FindFirst() then;

            Recref.GetTable(SIHNEW);
            TempBlob.CreateOutStream(OutStr);
            Report.SaveAs(Report::"Tax Invoice", '', ReportFormat::Pdf, OutStr, Recref);
            TempBlob.CreateInStream(InStr);
            Emailmessage.AddAttachment('Tax Sales Invoice.pdf', '.pdf', InStr);

            //**** Email Body Creation *****
            Emailmessage.AppendToBody('<p><font face="Georgia">Dear <B>Sir,</B></font></p>');
            Char := 13;
            Emailmessage.AppendToBody(FORMAT(Char));
            Emailmessage.AppendToBody('<p><font face="Georgia"> <B>!!!Greetings!!!</B></font></p>');
            Emailmessage.AppendToBody(FORMAT(Char));
            Emailmessage.AppendToBody(FORMAT(Char));
            Emailmessage.AppendToBody('<p><font face="Georgia"><BR>Please find enclosed Tax Invoice.</BR></font></p>');
            Emailmessage.AppendToBody(FORMAT(Char));
            Emailmessage.AppendToBody(FORMAT(Char));
            Emailmessage.AppendToBody('<p><font face="Georgia"><BR>Thanking you,</BR></font></p>');
            Emailmessage.AppendToBody('<p><font face="Georgia"><BR>Warm Regards,</BR></font></p>');
            Emailmessage.AppendToBody('<p><font face="Georgia"><BR><B>For Kohinoor</B></BR></font></p>');
            Emailmessage.AppendToBody(FORMAT(Char));
            Emailmessage.AppendToBody(FORMAT(Char));
            //Emailmessage.AppendToBody('<p><font face="Georgia"><BR><B>(Logistic Team)</B></BR></font></p>');
            Emailmessage.AppendToBody(FORMAT(Char));
            Emailmessage.AppendToBody(FORMAT(Char));
            //**** Email Send Function

            EMail.Send(Emailmessage, Enum::"Email Scenario"::Default);
            Message('Mail Sent Successfully.....');
        end else
            Error('Email does not exist in Email to Finance setup for the %1', PayMethodCode);

    end;

    var
        myInt: Integer;
}