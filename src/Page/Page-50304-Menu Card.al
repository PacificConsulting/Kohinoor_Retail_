page 50304 "Menu Card"
{
    PageType = Card;
    Caption = 'Menu Card';
    //ApplicationArea = All;
    //UsageCategory = Administration;
    SourceTable = "Menu Header";
    RefreshOnActivate = true;
    layout
    {
        area(Content)
        {
            group("Menu Header")
            {
                field("Menu ID"; Rec."Menu ID")
                {
                    ToolTip = 'Specifies the value of the Menu ID field.';
                    ApplicationArea = all;
                }
                field("Menu Name"; Rec."Menu Name")
                {
                    ToolTip = 'Specifies the value of the Menu Name field.';
                    ApplicationArea = all;
                }
                field("Store No."; Rec."Store No.")
                {
                    ToolTip = 'Specifies the value of the Store No. field.';
                    ApplicationArea = all;
                }
            }
            part(Lines; "Menu Line Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Menu ID" = field("Menu ID");//, "Store No." = field("Store No.");

            }


        }

    }
    actions
    {
        area(Processing)
        {
            action("Copy Menu")
            {
                ApplicationArea = all;
                Image = Copy;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    CopyPage: Page "Copy Menu";
                    MH: Record "Menu Header";
                    MHInit: Record "Menu Header";
                    MenuID: Code[20];
                    ML: Record "Menu Line";
                    MLInit: Record "Menu Line";
                    MenuName: Code[20];
                    StoreNo: Code[20];
                begin
                    CLEAR(CopyPage);//PCPL
                    CopyPage.LOOKUPMODE(TRUE);//PCPL
                    IF CopyPage.RUNMODAL = ACTION::Yes then begin

                        MenuID := CopyPage.MenuIDF();
                        MenuName := CopyPage.MenunameF();
                        StoreNo := CopyPage.StoreNoF();
                        IF MenuID = '' then
                            Error('Menu should not be blank');
                        if MenuName = '' then
                            Error('Menu name not be blank');
                        if StoreNo = '' then
                            Error('Store No. should not be blank');

                        MH.Reset();
                        MH.SetFilter("Menu ID", '%1', rec."Menu ID");
                        IF MH.FindFirst() then begin
                            MHInit.Init();
                            MHInit."Menu ID" := MenuID;
                            MHInit.Insert();
                            MHInit."Menu Name" := CopyPage.MenunameF();
                            MHInit."Store No." := CopyPage.StoreNoF();
                            MHInit."Creation Date" := Today;
                            MHInit."Creation ID" := UserId;
                            MHInit.Modify();
                            ML.Reset();
                            ML.SetRange("Menu ID", MH."Menu ID");
                            IF ML.FindSet() then
                                repeat
                                    MLInit.Init();
                                    MLInit.TransferFields(ML);
                                    MLInit."Menu ID" := MHInit."Menu ID";
                                    MLInit."Menu Name" := MHInit."Menu Name";
                                    MLInit."Store No." := MHInit."Store No.";
                                    MLInit.Insert();
                                until Ml.Next() = 0;
                        end;
                        Message('New Menu has been Created');
                        CurrPage.Close();
                    end;
                end;

            }
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        IF US.Get(UserId) then begin
            IF not Us."Admin Access" then
                Error('You do not have access to modify the data.');
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        IF US.Get(UserId) then begin
            IF not Us."Admin Access" then
                Error('You do not have access to modify the data.');
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF US.Get(UserId) then begin
            IF not Us."Admin Access" then
                Error('You do not have access to modify the data.');
        end;
    end;

    var
        US: Record 91;
}