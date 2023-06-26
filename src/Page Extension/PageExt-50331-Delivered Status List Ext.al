pageextension 50331 "Delivered Status List Ext" extends "Delivered Status List"
{
    layout
    {

    }
    actions
    {
        addafter(Report)
        {

            action("Demo Files")
            {
                ApplicationArea = all;
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Caption = 'Demo File';
                trigger OnAction()
                var
                    PDL: Record "Posted Delivery Line";
                    Demo: Report 50190;
                    ABSBlobClient: Codeunit "ABS Blob Client";
                    Authorization: Interface "Storage Service Authorization";
                    ABSCSetup: Record "Azure Storage Container Setup";
                    StorageServiceAuth: Codeunit "Storage Service Authorization";
                    Instrm: InStream;
                    OutStrm: OutStream;
                    TempBlob: Codeunit "Temp Blob";
                    FileName: Text;
                    Recref: RecordRef;
                    response: Codeunit "ABS Operation Response";
                    IH: record "Item Heirarchy Master";

                begin
                    /*
                    PDL.Reset();
                    PDL.SetRange("Delivery Challan No.", rec."Delivery Challan No.");
                    if PDL.FindFirst() then
                        Report.RunModal(50190, true, false, PDL);
                        */
                    Demo.Run();
                    IH.Reset();
                    IH.SetRange("Option Type", IH."Option Type"::"Category 1");
                    If IH.FindSet() then
                        repeat
                            //***********Report Save as Excel****************
                            PDL.RESET;
                            PDL.SETRANGE("Item Category code 1", IH.Code);
                            IF PDL.FINDFIRST THEN;
                            Recref.GetTable(PDL);
                            TempBlob.CreateOutStream(OutStrm);
                            Report.SaveAs(Report::"Sales Delivery Report", '', ReportFormat::Excel, OutStrm, Recref);
                            TempBlob.CreateInStream(Instrm);

                            //*************Azure upload Code**************
                            ABSCSetup.Get();
                            Authorization := StorageServiceAuth.CreateSharedKey(ABSCSetup."Access key");
                            ABSBlobClient.Initialize(ABSCSetup."Account Name", ABSCSetup."Container Name", Authorization);
                            FileName := PDL."Item Category code 1" + '_' + Format(Today) + '.' + 'xlsx';
                            response := ABSBlobClient.PutBlobBlockBlobStream(FileName, Instrm);
                            IF response.IsSuccessful() then
                                Message('File Create and upload successfully.');

                            //************Update Demo Field***************
                            PDL.Reset();
                            PDL.SetRange("Item Category code 1", IH.Code);
                            PDL.SetRange(Delivered, true);
                            IF PDL.FindSet() then
                                repeat
                                    PDL.Demo := true;
                                    PDL.Modify();
                                until PDL.Next() = 0;
                        until PDl.Next() = 0;
                end;
            }

        }
    }
}
