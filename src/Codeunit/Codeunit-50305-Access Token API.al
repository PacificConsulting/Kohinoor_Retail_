codeunit 50305 "Access Token API"
{
    trigger OnRun()
    begin
    end;

    internal procedure GetClientId(): Text
    begin
        exit(ClientIdTxt);
    end;

    internal procedure GetClientSecret(): Text
    begin
        exit(ClientSecretTxt);
    end;

    internal procedure GetApiGraphMe(): Text
    begin
        exit(ApiGraphMeUrlTxt);
    end;

    internal procedure GetRedirectURL(): Text
    begin
        exit(RedirectURLText);
    end;

    internal procedure GetAadTenantId(): Text
    var
        AzureADTenant: Codeunit "Azure AD Tenant";
    begin
        exit(AzureADTenant.GetAadTenantId());
    end;

    internal procedure GetOAuthAuthorityUrl(): text
    begin
        exit(OAuthAuthorityUrlLabel + GetAadTenantId() + '/oauth2/v2.0/authorize');
    end;

    internal procedure GetApiListCompanies(): text
    var
        EnviromentMgt: Codeunit "Environment Information";
    begin
        exit(StrSubstNo(ApiListCompaniesTxt, ApiBCUrl, GetAadTenantId(), EnviromentMgt.GetEnvironmentName()));
    end;

    internal procedure GetResourceURLForApiGraph(): text
    begin
        exit(ApiGraphUrlTxt);
    end;

    internal procedure GetResourceURLForApiBC(): text
    begin
        exit(ApiBCUrl);
    end;

    var
        ApiBCUrl: Label 'https://api.businesscentral.dynamics.com/', Locked = true;
        ApiGraphMeUrlTxt: Label 'https://graph.microsoft.com/v1.0/me', Locked = true;
        ApiGraphUrlTxt: Label 'https://graph.microsoft.com/', Locked = true;
        ApiListCompaniesTxt: Label '%1v2.0/%2/%3/api/beta/companies', Locked = true;
        ClientIdTxt: Label '68750603-fadd-4441-8542-bfaaa433a309', Locked = true;
        ClientSecretTxt: Label 'gOr8Q~UysVp6fIKqdedP4i1k1gnoDGGhKV-5TcAR', Locked = true;
        OAuthAuthorityUrlLabel: Label 'https://login.microsoftonline.com/', Locked = true;
        RedirectURLText: Label 'https://businesscentral.dynamics.com/OAuthLanding.htm', Locked = true;

}