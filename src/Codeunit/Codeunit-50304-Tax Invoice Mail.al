codeunit 50304 "Tax Invoice Mail"
{
    trigger OnRun()
    var
        PPL: Record "Posted Payment Lines";
        PaymentMethod: Record "Payment Method";
        SalesInvHdr: Record "Sales Invoice Header";
    begin
        SendMail();
        /*
        PPL.Reset();
        PPL.SetCurrentKey("Invoice Posting Date", "Payment type");
        //PPL.SetRange("Invoice Posting Date", CalcDate('-1D', Today));
        PPL.SetFilter("Document No.", '%1|%2', 'CHETI23240200036', 'THATI23240900023');
        PPL.SetRange("Payment type", PPL."Payment type"::Finance);
        IF PPL.FindSet() then
            repeat
                //IF PaymentMethod.Get(PPL."Payment Method Code") then begin
                //  IF PaymentMethod."Payment Type" = PaymentMethod."Payment Type"::Finance then begin
                SalesInvHdr.Reset();
                SalesInvHdr.SetRange("No.", PPL."Document No.");
                IF SalesInvHdr.FindFirst() then
                    SendMail(SalesInvHdr, PPL."Payment Method Code");
            //end;
            until PPL.Next() = 0;
            */
    end;

    procedure SendMail();//(SIH: Record "Sales Invoice Header"; PayMethodCode: Code[10])
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
        PPL: record "Posted Payment Lines";
        FileName: Text[250];
        DocumentNo: Code[20];
        PaymentMethod: Record "Payment Method";
    begin
        VarRecipient.RemoveRange(1, VarRecipient.Count);
        Clear(VCount);
        ETF.Reset();
        IF ETF.FindSet() then
            repeat
                VarRecipient.Add(ETF."E-Mail");
            until ETF.Next() = 0;

        //**** Email Create ****     
        VCount := VarRecipient.Count();
        IF VCount <> 0 then begin
            Emailmessage.Create(VarRecipient, 'Tax Invoice: ' + ' Dated ' + FORMAT(CalcDate('-1D', Today)), '', true);
            //**** Report SaveAsPDF and Attached in Mail
            PPL.Reset();
            PPL.SetCurrentKey("Invoice Posting Date", "Payment type");
            //PPL.SetRange("Invoice Posting Date", CalcDate('-1D', Today));
            PPL.SetFilter("Document No.", '%1|%2', 'CHETI23240200036', 'THATI23240900023');
            PPL.SetRange("Payment type", PPL."Payment type"::Finance);
            //PPL.SetRange("Payment Method Code", PaymentMethod.Code);
            IF PPL.FindSet() then
                repeat
                    //IF DocumentNo <> PPL."Document No." then begin
                    SIHNEW.Reset();
                    SIHNEW.SetRange("No.", PPL."Document No.");
                    IF SIHNEW.FindFirst() then;
                    Recref.GetTable(SIHNEW);
                    TempBlob.CreateOutStream(OutStr);
                    Report.SaveAs(Report::"Tax Invoice", '', ReportFormat::Pdf, OutStr, Recref);
                    TempBlob.CreateInStream(InStr);
                    FileName := SIHNEW."No." + '_' + FORMAT(Today) + '.pdf';
                    Emailmessage.AddAttachment(FileName, '.pdf', InStr);
                //DocumentNo := PPL."Document No.";
                //  end;
                until PPL.Next() = 0;
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
        end;
    end;
}
