page 50394 "Date Filter"
{
    ApplicationArea = All;
    Caption = 'Password Detail';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            group("Access Detail")
            {
                field("Start Date"; StartDate)
                {
                    ApplicationArea = All;
                    // ExtendedDatatype = Masked;
                }
                field("End Date"; EndDate)
                {
                    ApplicationArea = All;
                    // ExtendedDatatype = Masked;
                }
            }
        }
    }
    var
        UserID: Code[50];
        Password: Text[10];
        EmployeeName: Text[30];
        StartDate: Date;
        EndDate: Date;


    procedure Returnstartdate(): Date
    begin
        exit(StartDate);
    end;

    procedure ReturnEnddate(): Date
    begin
        exit(EndDate);
    end;
}
