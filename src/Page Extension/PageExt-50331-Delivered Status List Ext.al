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
                Caption = 'Create Demo File';
                trigger OnAction()
                var
                    PDL: Record "Posted Delivery Line";
                    PDLUpdate: Record "Posted Delivery Line";
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
                    //Demo.Run();
                    Clear(SDate);
                    Clear(EDate);
                    Clear(PageDatefilter);
                    PageDatefilter.LookupMode(true);
                    if PageDatefilter.RunModal() = Action::LookupOK then begin
                        SDate := PageDatefilter.Returnstartdate();
                        EDate := PageDatefilter.ReturnEnddate();
                    End;
                    IF SDate = 0D then
                        IF EDate <> 0D then
                            Error('Please enter start date also.');

                    IH.Reset();
                    IH.SetCurrentKey("Option Type");
                    IH.SetRange("Option Type", IH."Option Type"::"Category 1");
                    If IH.FindSet() then
                        repeat
                            //***********Report Save as Excel****************
                            PDL.RESET;
                            PDL.SetCurrentKey("Item Category code 1", Delivered, Demo, "Delivered Date");
                            PDL.SETRANGE("Item Category code 1", IH.Code);
                            PDl.SetRange(Delivered, true);
                            PDL.SetRange(Demo, false);
                            IF (SDate <> 0D) and (EDate <> 0D) then
                                PDL.SetRange("Delivered Date", SDate, EDate);
                            IF PDL.FindSet() THEN begin
                                Recref.GetTable(PDL);
                                TempBlob.CreateOutStream(OutStrm);
                                Report.SaveAs(Report::"Sales Delivery Report", '', ReportFormat::Excel, OutStrm, Recref);
                                TempBlob.CreateInStream(Instrm);

                                //*************Azure upload Code**************
                                //IF PDL."Item Category code 1" <> '' then begin
                                ABSCSetup.Get();
                                ABSCSetup.TestField("Container Name Demo");
                                Authorization := StorageServiceAuth.CreateSharedKey(ABSCSetup."Access key");
                                ABSBlobClient.Initialize(ABSCSetup."Account Name", ABSCSetup."Container Name Demo", Authorization);
                                FileName := PDL."Item Category code 1" + '_' + Format(Today) + '.' + 'xlsx';
                                response := ABSBlobClient.PutBlobBlockBlobStream(FileName, Instrm);
                                //IF response.IsSuccessful() then
                                //  Message('File Create and upload successfully.');

                                //************Update Demo Field***************
                                PDLUpdate.Reset();
                                PDLUpdate.SetRange("Item Category code 1", IH.Code);
                                PDLUpdate.SetRange(Delivered, true);
                                IF PDLUpdate.FindSet() then
                                    repeat
                                        PDLUpdate.Demo := true;
                                        PDLUpdate.Modify();
                                    until PDLUpdate.Next() = 0;
                            end;
                        until IH.Next() = 0;
                end;
            }
            action(DemoFasle)
            {
                ApplicationArea = all;
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Caption = 'Demo Fasle';
                //Visible = false;
                trigger OnAction()
                var
                    PDL: Record "Posted Delivery Line";
                begin
                    PDL.Reset();
                    PDL.SetRange(Delivered, true);
                    if PDL.FindSet() then
                        repeat
                            PDl.Demo := false;
                            PDL.Modify();
                        until PDL.Next() = 0;
                    Message('Done');
                end;
            }

        }
    }
    var
        PageDatefilter: Page 50394;
        SDate: Date;
        EDate: Date;
}
