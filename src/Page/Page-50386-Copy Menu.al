page 50386 "Copy Menu"
{
    PageType = ConfirmationDialog;
    // ApplicationArea = All;
    // UsageCategory = Lists;


    layout
    {
        area(Content)
        {
            group("Menu Details")
            {
                field("Menu ID"; MenuID)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                }
                field("Menu Name"; MenuName)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                }
                field("Store No."; Storeno)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Loc: Record 14;
                    begin
                        Loc.Reset();
                        Loc.FILTERGROUP(10);
                        Loc.SETRANGE(Store, true);
                        Loc.FILTERGROUP(0);
                        IF PAGE.RUNMODAL(15, Loc) = ACTION::LookupOK THEN
                            Storeno := Loc.Code;

                        Loc.Reset();
                        Loc.SetRange(code, Storeno);
                        IF Not loc.FindFirst() then
                            Error('Selected Store does not exist');



                    end;
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    procedure MenuIDF(): Text
    var
        myInt: Integer;
    begin
        exit(MenuID);
    end;

    procedure MenunameF(): Text
    var
        myInt: Integer;
    begin
        exit(MenuName);
    end;

    procedure StoreNoF(): Text
    var
        myInt: Integer;
    begin
        exit(Storeno);
    end;

    var
        MenuName: Code[50];
        MenuID: Code[20];
        Storeno: Code[10];
}