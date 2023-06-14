codeunit 50306 GenericApiCalls
{
    // [EventSubscriber(ObjectType::Table, Database::"Ship-to Address", 'OnAfterLookupPostCode', '', false, false)]
    // local procedure OnAfterLookupPostCode(var ShipToAddress: Record "Ship-to Address"; var PostCodeRec: Record "Post Code"; xShipToAddress: Record "Ship-to Address");
    // begin
    //     ShipToAddress.State := PostCodeRec."State Code";
    // end;

    procedure CreateRequest(RequestUrl: Text; AccessToken: Text): Text
    var
        TempBlob: Codeunit "Temp Blob";
        IsSuccessful: Boolean;
        HttpClient: HttpClient;
        MailContent: HttpContent;
        MailContentHeaders: HttpHeaders;
        RequestHeaders: HttpHeaders;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        ResponseStream: InStream;
        StatusCode: Integer;
        JObject: JsonObject;
        APICallResponseMessage: Text;
    begin
        RequestMessage.GetHeaders(RequestHeaders);
        RequestHeaders.Add('Authorization', 'Bearer ' + AccessToken);
        RequestMessage.SetRequestUri(RequestUrl);
        RequestMessage.Method('GET');

        Clear(TempBlob);
        TempBlob.CreateInStream(ResponseStream);

        IsSuccessful := HttpClient.Send(RequestMessage, ResponseMessage);

        if not IsSuccessful then
            exit('An API call with the provided header has failed.');

        if not ResponseMessage.IsSuccessStatusCode() then begin
            StatusCode := ResponseMessage.HttpStatusCode();
            exit('The request has failed with status code ' + Format(StatusCode));
        end;

        // //<<NSW07
        // IF ResponseMessage.Content().ReadAs(APICallResponseMessage) then
        //     exit(APICallResponseMessage);

        // //>>NSW07

        if not ResponseMessage.Content().ReadAs(ResponseStream) then
            exit('The response message cannot be processed.');

        if not JObject.ReadFrom(ResponseStream) then
            exit('Cannot read JSON response.');

        JObject.WriteTo(APICallResponseMessage);
        APICallResponseMessage := APICallResponseMessage.Replace(',', '\');

        exit(APICallResponseMessage);

    end;

}