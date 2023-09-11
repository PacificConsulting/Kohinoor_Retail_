report 50317 "Advance Receipt Voucher Report"
{
    //PCPL-064
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report Layout\Advance Receipt Voucher -1.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    EnableHyperlinks = true;
    EnableExternalImages = true;

    dataset
    {
        dataitem("Payment Lines"; "Payment Lines")
        {
            RequestFilterFields = "Document No.";
            DataItemTableView = where("Document Type" = filter('Advance Payment'));
            column(Payment_Method_Code; "Payment Method Code")
            {

            }
            column(Approval_Code; "Approval Code")
            {

            }
            column(Amount; Amount)
            {

            }
            column(cominfo_Name; cominfo.Name)
            {

            }
            column(cominfo_add; cominfo.Address + ' ' + cominfo."Address 2")
            {

            }
            column(cominfoGSTIN; cominfo."GST Registration No.")
            {

            }
            column(cominfo_statecode; cominfo."State Code")
            {

            }
            column(cust_name; cust.Name)
            {

            }

            column(cust_add; cust.Address + ' ' + cust."Address 2")
            {

            }
            column(cust_GSTIN; cust."GST Registration No.")
            {

            }
            column(cust_Statecode; cust."State Code")
            {

            }

            column(loc_name; loc.Name)
            {

            }
            column(receiptno; receiptno)
            {

            }
            column(receiptdate; receiptdate)
            {

            }
            column(CreateDate; CreateDate)
            {

            }

            trigger OnAfterGetRecord() //PL
            var
                myInt: Integer;
            begin
                Clear(CreateDate);
                CreateDate := DT2Date(SystemCreatedAt);
                // Message(Format(CreateDate));
                IF CreateDate <> CurrDate then
                    CurrReport.Skip();
                // Message(Format("Payment Lines".Count));

                if cust.get("Document No.") then;
                if loc.get("Payment Lines"."Store No.") then;

                CLE.Reset();
                CLE.SetRange("Customer No.", "Payment Lines"."Document No.");
                CLE.SetRange("Posting Date", CreateDate);
                CLE.SetRange("Document Type", CLE."Document Type"::Payment);
                if CLE.FindSet() then
                    repeat
                        receiptno += CLE."Document No." + ',';
                        receiptdate += format(CLE."Posting Date") + ',';
                    until CLE.Next() = 0;
                IF receiptno <> '' then
                    receiptno := DelStr(receiptno, StrLen(receiptno), 1);

                IF receiptdate <> '' then
                    receiptdate := DelStr(receiptdate, StrLen(receiptdate), 1);

                //  end;

            end;







            // end;

            // Message(cust.Name);

            // Message("Payment Lines"."Document No.");


            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                cominfo.Get();
                cominfo.CalcFields(Picture);

                //"Payment Lines".CalcFields("Invoice Posting Date");
                //"Payment Lines".SetRange("Invoice Posting Date", CurrDate);

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(CurrDate; CurrDate)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    /* rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'mylayout.rdl';
        }
    } */

    var
        myInt: Integer;
        cominfo: record "Company Information";
        cust: record Customer;
        SIH: Record "Sales Invoice Header";
        State: Record State;
        receiptno: Code[250];
        receiptdate: Text;
        CLE: Record "Cust. Ledger Entry";
        CurrDate: Date;
        loc: Record Location;
        CreateDate: Date;
}