report 50323 UpdatingSerialInfor
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItemName; Integer)
        {
            trigger OnAfterGetRecord()
            var
                UpdtinCD: Codeunit "Event and Subscribers";
            begin
                UpdtinCD.ModifyingSerlialNo();
            end;



            trigger OnPreDataItem()
            var

            begin
                SetRange(Number, 1);
            end;
        }

    }


    var
        myInt: Integer;
}