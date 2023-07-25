codeunit 50308 "Tax Invoice Upload on AZURE"
{
    trigger OnRun()
    begin
        TaxInvoiceUploadAzure();
    end;

    procedure TaxInvoiceUploadAzure()
    var
        FinConfimBool: Boolean;
        OtherConfimBool: Boolean;
        ABSBlobClient: Codeunit "ABS Blob Client";
        Authorization: Interface "Storage Service Authorization";
        ABSCSetup: Record "Azure Storage Container Setup";
        StorageServiceAuth: Codeunit "Storage Service Authorization";
        FileName: Text;
        response: Codeunit "ABS Operation Response";
        SIHNEW: Record 112;
        Instrm: InStream;
        OutStrm: OutStream;
        TempBlob: Codeunit "Temp Blob";
        Recref: RecordRef;
        PPL: Record "Posted Payment Lines";
    begin
        PPL.Reset();
        PPL.SetCurrentKey("Invoice Posting Date", "Payment type");
        //PPL.SetRange("Invoice Posting Date", CalcDate('-1D', Today));
        PPL.SetFilter("Document No.", '%1|%2', 'CHETI23240200036', 'THATI23240900023');
        PPL.SetRange("Payment type", PPL."Payment type"::Finance);
        IF PPL.FindSet() then
            repeat
                SIHNEW.Reset();
                SIHNEW.SetRange("No.", PPL."Document No.");
                IF SIHNEW.FindFirst() then;
                Recref.GetTable(SIHNEW);
                TempBlob.CreateOutStream(OutStrm);
                Report.SaveAs(Report::"Tax Invoice", '', ReportFormat::Excel, OutStrm, Recref);
                TempBlob.CreateInStream(Instrm);

                ABSCSetup.Get();
                ABSCSetup.TestField("Container Name Demo");
                Authorization := StorageServiceAuth.CreateSharedKey(ABSCSetup."Access key");
                ABSBlobClient.Initialize(ABSCSetup."Account Name", 'emailtaxinvoices', Authorization);
                FileName := SIHNEW."No." + '_' + Format(Today) + '.' + 'pdf';
                response := ABSBlobClient.PutBlobBlockBlobStream(FileName, Instrm);
            until ppl.Next() = 0;
    end;

}
