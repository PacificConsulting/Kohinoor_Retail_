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

                }
                field("Menu Name"; MenuName)
                {
                    ApplicationArea = All;

                }
                field("Store No."; Storeno)
                {
                    ApplicationArea = All;
                    TableRelation = Location.Code where(Store = filter(true));
                    trigger OnValidate()
                    begin
                        Storeno := Storeno;
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