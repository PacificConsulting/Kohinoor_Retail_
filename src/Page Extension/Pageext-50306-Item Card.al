pageextension 50306 "ItemCArdExtension" extends "Item Card"
{
    layout
    {
        // addafter(Description)
        // {
        //     field("Search Description"; Rec."Search Description")
        //     {
        //         ApplicationArea = all;
        //     }
        // }
    }
    actions
    {
        addlast(processing)
        {
            group(Picture)
            {
                action(TradeAggrement)
                {
                    Caption = 'Trade Aggrement';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Image = Agreement;
                    ApplicationArea = All;
                    RunObject = page "Trade Aggrement List";
                    RunPageLink = "Item No." = field("No.");
                    trigger OnAction()
                    var
                    begin

                    end;
                }

                action(CreatePicture)
                {
                    Caption = 'Create Picture by Description';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Image = Picture;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        POSProcedure: Codeunit 50302;
                        Result: text;
                        Recref: RecordRef;
                        recCust: Record 18;
                        TempBlob: Codeunit "Temp Blob";
                        OutStr: OutStream;
                        Instr: InStream;
                        VResult: text;
                        FileManagement_lCdu: Codeunit "File Management";
                        B64: Codeunit "Base64 Convert";
                        base64convert: Codeunit "Base64 Convert";
                    begin
                        /*
                        Recref.GetTable(recCust);
                        TempBlob.CreateOutStream(OutStr);
                        Report.SaveAs(Report::"Customer - List", '', ReportFormat::Pdf, OutStr, Recref);
                        TempBlob.CreateInStream(InStr);
                        // FileManagement_lCdu.BLOBExport(TempBlob, STRSUBSTNO('Proforma_%1.Pdf', recCust."No."), TRUE);
                        VResult := B64.ToBase64(Instr);
                        SendToFlow('Test.PDF', VResult);
                        // recCust.get(10000);
                        // //CustReport.Run();
                        // // Report.Run(101, false, false, recCust);
                        // // VResult := 'F:\txtfile\';
                        // // UploadIntoStream('Upload Data', '', '', VResult, Instr);
                        // VResult := 'All Files (*.*)|*.*';
                        // UploadIntoStream(VResult, Instr);
                        //DownloadFromCloud();
                        
                        // Result := 'C:\temp\test.pdf';
                        Recref.GetTable(recCust);
                        TempBlob.CreateOutStream(OutStr);
                        Report.SaveAs(Report::"Customer - List", '', ReportFormat::Pdf, OutStr, Recref);
                        TempBlob.CreateInStream(InStr);
                        FileManagement_lCdu.BLOBExport(TempBlob, STRSUBSTNO('Proforma_%1.Pdf', recCust."No."), TRUE);


                        // //DownloadFromStream(Instr, '', '', '', Vresult);


                        //   result := POSProcedure.POSAction('123', 1000, 'VOIDL', 'Test', 'API');
                        // Message(Result);

                        //  Clear(APIManagment);
                        
                        Base64text := CreateImgOpenAI(Rec.Description);

                        TempBlob.CreateOutStream(outstream);
                        base64convert.FromBase64(Base64text, outstream);
                        TempBlob.CreateInStream(InStream);

                        Clear(rec.Picture);
                        Rec.Picture.ImportStream(instream, '');
                        Rec.Modify()
                            */

                    end;
                }
                action("POS Call")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Image = Picture;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        CU: Codeunit 50303;
                        CUN: codeunit 50302;
                        Result: Text;
                        SH: Record 36;
                        NewResult: Text;
                        Qty: Decimal;
                        Vtest: Text;
                    begin
                        IF SH.FindFirst() then
                            // Message(SH."No.");
                            //Result := cu.SalesOrderDeletion(SH."No.");
                            //Message(Result);
                            Vtest := '2';
                        //Evaluate(Qty, Vtest);
                        //NewResult := CUN.POSAction('101016', 10000, 'SHIPLINE', '', '2');
                        //NewResult := CUN.SerialItemTracking('KTPLSO23240001', 10000, '016179OD03');
                        //NewResult := CUN.TranferShipItemTracking('KTRO001', 30000, '015189OC07');
                        Message(NewResult);
                    end;
                }

            }
        }
    }

    procedure CreateImgOpenAI(Description: Text): Text
    var
        JObject: JsonObject;
        JToken: JsonToken;
        JValue: JsonValue;
        JArray2: JsonArray;
        Base64: Text;
        Body: Text;
        z: Integer;

    begin
        Body := StrSubstNo('{"prompt":"%1","n": 2,"size": "256x256","response_format":"b64_json"}', Description);
        JObject.ReadFrom(POST_Request('https://api.openai.com/v1/images/generations', Body));
        JObject.get('data', JToken);
        Jarray2.ReadFrom(Format(Jtoken));
        for z := 0 to JArray2.Count() - 1 do begin
            Jarray2.Get(z, Jtoken);
            JObject := Jtoken.AsObject();
            JObject.get('b64_json', JToken);
            JValue := JToken.AsValue();
            Base64 := JValue.AsText();
        end;
        exit(Base64);
    end;

    procedure POST_Request(uri: Text; _queryObj: Text) responseText: Text;
    var
        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        content: HttpContent;
    begin
        contentHeaders := client.DefaultRequestHeaders();
        contentHeaders.Add('Authorization', 'Bearer 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');

        content.WriteFrom(_queryObj);
        content.GetHeaders(ContentHeaders);
        ContentHeaders.Remove('Content-Type');
        ContentHeaders.Add('Content-Type', 'application/json');
        request.Content(content);

        request.SetRequestUri(uri);

        request.Method := 'POST';

        client.Send(request, response);

        // Read the response content as json.

        response.Content().ReadAs(responseText);

    end;

    procedure DownloadFromCloud()
    var
        Data: BigText;
        ins: InStream;
        outs: OutStream;
        // TempBLOB: codeunit "Temp Blob";
        filename: Text;
        PDFStream: OutStream;
        FileManagement: Codeunit "File Management"; // Set the report ID
    begin
        // Recref.GetTable(recCust);
        // TempBlob.CreateOutStream(OutStr);
        // Report.SaveAs(Report::"Customer - List", '', ReportFormat::Pdf, OutStr, Recref);
        // OutStr.WriteText('F:\txtfile\', 1024);
        // Data.AddText('Hello World');
        // TempBLOB.CreateOutStream(outs);
        // Data.Write(outs);
        // TempBLOB.CreateInStream(ins);
        // filename := 'F:\txtfile\helloworld.txt';
        // DownloadFromStream(
        // ins,  // InStream to save
        //            '',   // Not used in cloud
        //            '',   // Not used in cloud
        //            '',   // Not used in cloud
        //            filename); // Filename is browser download folder


    end;

    procedure SendToFlow(FileName: Text; Base64: Text)

    Var
        client: HttpClient;
        cont: HttpContent;
        header: HttpHeaders;
        response: HttpResponseMessage;
        Jobject: JsonObject;
        tmpString: Text;
        token: Text;
        URL: text;
    Begin
        URL := 'https://prod-10.centralindia.logic.azure.com:443/workflows/61d67d3d2bad418da1ec35829b069cc9/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=2IZf8emoLdAqkFGTiP0GnQoxVJty9MKGdstex5v7dqs';
        Jobject.Add('ApiToken', 'testapi');
        Jobject.Add('Document', Base64);
        Jobject.Add('FileName', FileName);
        Jobject.WriteTo(tmpString);
        cont.WriteFrom(tmpString);
        cont.ReadAs(tmpString);
        cont.GetHeaders(header);
        header.Remove('Content-Type');
        header.Add('Content-Type', 'application/json');

        client.Post(URL, cont, response);

    end;

    var
        //  APIManagment: Codeunit APiMgtOpenAI;
        FromText: Text;
        Base64text: Text;
        //       base64convert: codeunit "Base64 Convert";
        newItem: Record Item;
        //     TempBlob: Codeunit "Temp Blob";
        outstream: OutStream;
        instream: InStream;
}