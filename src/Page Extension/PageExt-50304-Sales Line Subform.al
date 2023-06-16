pageextension 50304 "Sales Line Subform" extends "Sales Order Subform"
{
    layout
    {
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                SH: Record 36;
            begin
                SH.Reset();
                SH.SetRange("No.", Rec."Document No.");
                SH.SetRange("Document Type", SH."Document Type"::Order);
                SH.SetFilter("POS Released Date", '<>%1', 0D);
                IF SH.FindFirst() then
                    Error('You can not change the quantity when order is Confirmed');
            end;
        }
        modify("Unit Price Incl. of Tax")
        {
            trigger OnAfterValidate()
            var
                TradeAggre: record "Trade Aggrement";
                SalesHeder: record 36;
                SL: Record 37;
                SH: Record 36;
            begin
                SH.Reset();
                SH.SetRange("No.", Rec."Document No.");
                SH.SetFilter("POS Released Date", '<>%1', 0D);
                SH.SetRange("Document Type", SH."Document Type"::Order);
                IF SH.FindFirst() then
                    Error('You can not change the unit price when order is Confirmed');

                IF xRec."Unit Price Incl. of Tax" <> Rec."Unit Price Incl. of Tax" then begin
                    Rec."Old Unit Price" := Rec."Unit Price Incl. of Tax";
                    //Rec.Modify();
                    IF SalesHeder.Get(rec."Document Type", rec."Document No.") then;
                    TradeAggre.Reset();
                    TradeAggre.SetCurrentKey("Item No.", "From Date", "To Date", "Location Code");
                    TradeAggre.SetRange("Item No.", Rec."No.");
                    TradeAggre.SetRange("Location Code", SalesHeder."Location Code");
                    TradeAggre.SetFilter("From Date", '<=%1', SalesHeder."Posting Date");
                    TradeAggre.SetFilter("To Date", '>=%1', SalesHeder."Posting Date");
                    IF TradeAggre.FindFirst() then begin
                        IF TradeAggre."Amount In INR" < Rec."Unit Price Incl. of Tax" then
                            Error('Amount should not be more than %1 INR', TradeAggre."Amount In INR");
                        IF TradeAggre."Last Selling Price" > Rec."Unit Price Incl. of Tax" then begin
                            ApprovalMailSent(Rec);

                        end;
                    end;
                end;
            end;
        }
        addafter(Quantity)
        {
            field("Store No."; Rec."Store No.")
            {
                ApplicationArea = all;
            }
            field("Approval Status"; Rec."Approval Status")
            {
                ApplicationArea = all;
            }
            field("Approval Sent By"; Rec."Approval Sent By")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Approval Sent By field.';
            }
            field("Approval Sent On"; Rec."Approval Sent On")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Approval Sent On field.';
            }
            field("Approved By"; Rec."Approved By")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Approved By field.';
            }
            field("Approved On"; Rec."Approved On")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Approved On field.';
            }
            field("Old Unit Price"; Rec."Old Unit Price")
            {
                ApplicationArea = all;
            }
            field("Salesperson Code"; Rec."Salesperson Code")
            {
                ApplicationArea = all;
            }
            field("Salesperson Name"; Rec."Salesperson Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Salesperson Name field.';
            }
            field("Exchange Item No."; Rec."Exchange Item No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exchange Item No. field.';
            }
            field("Serial No."; Rec."Serial No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Serial No. field.';
            }
            field("Exchange Comment"; Rec."Exchange Comment")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exchange Comment field.';
            }

            field("Warranty Parent Line No."; Rec."Warranty Parent Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Warranty Parent Line No. field.';
            }


        }
        addafter("Unit Price Incl. of Tax")
        {
            field("GST Tax Amount"; Rec."GST Tax Amount")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the GST Tax Amount.';

            }
            // field("Change Unit Price Incl. of Tax"; Rec."Change Unit Price Incl. of Tax")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Change Unit Price Incl. of Tax field.';
            // }

        }
    }


    actions
    {
        // Add changes to page actions here
    }


    var
        myInt: Integer;


    local procedure ApprovalMailSent(SalesLine: Record "Sales Line")
    var
        txtFile: Text[100];
        Window: Dialog;
        txtFileName: Text[100];
        Char: Char;
        recSalesInvHdr: Record 112;
        Recref: RecordRef;
        recCust: Record 18;
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        Instr: InStream;
        EMail: Codeunit Email;
        Emailmessage: Codeunit "Email Message";
        Pagelink: Text;
        GLSetup: Record "General Ledger Setup";
        ToRecipients: List of [text];
        SL: Record 37;
    begin
        Sl.Reset();
        SL.SetRange("Document No.", SalesLine."Document No.");
        SL.SetRange("Line No.", SalesLine."Line No.");
        IF SL.FindFirst() then begin
            SL."Approval Status" := SL."Approval Status"::"Pending for Approval";
            SL.Modify();
        end;

        GLSetup.Get();
        GLSetup.TestField("Slab Approval User 1");
        //GLSetup.TestField("Slab Approval User 2");
        //GLSetup.TestField("Slab Approval User 3");
        //Pagelink := GetUrl(ClientType::Current, Rec.CurrentCompany, ObjectType::Page, Page::"Slab Approval List");
        Sl.Reset();
        SL.SetRange("Document No.", SalesLine."Document No.");
        SL.SetRange("Line No.", SalesLine."Line No.");
        IF SL.FindFirst() then
            Pagelink := GETURL(CURRENTCLIENTTYPE, 'Kohinoor Televideo Pvt. Ltd.', ObjectType::Page, 50361, SL, true);

        //  Window.OPEN(
        // 'Sending Mail#######1\');

        ToRecipients.Add(GLSetup."Slab Approval User 1");
        ToRecipients.Add(GLSetup."Slab Approval User 2");
        ToRecipients.Add(GLSetup."Slab Approval User 3");

        Emailmessage.Create(/*ToRecipients*/'niwagh16@gmail.com', 'Approval Slab', '', true);
        Emailmessage.AppendToBody('<p><font face="Georgia">Dear <B>Sir,</B></font></p>');
        Char := 13;
        Emailmessage.AppendToBody(FORMAT(Char));
        Emailmessage.AppendToBody('<p><font face="Georgia"> <B>!!!Greetings!!!</B></font></p>');
        Emailmessage.AppendToBody(FORMAT(Char));
        Emailmessage.AppendToBody(FORMAT(Char));
        Emailmessage.AppendToBody('<p><font face="Georgia"><BR>Please find below Approval Link Approve Date</BR></font></p>');
        Emailmessage.AppendToBody(FORMAT(Char));
        Emailmessage.AppendToBody(FORMAT(Char));
        Emailmessage.AppendToBody('<a href=' + Pagelink + '/">Web Link!</a>');
        Emailmessage.AppendToBody(Pagelink);
        Emailmessage.AppendToBody(FORMAT(Char));
        Emailmessage.AppendToBody(FORMAT(Char));
        Emailmessage.AppendToBody('<p><font face="Georgia"><BR>Thanking you,</BR></font></p>');

        // Window.UPDATE(1, STRSUBSTNO('%1', 'Mail Sent'));
        EMail.Send(Emailmessage, Enum::"Email Scenario"::Default);
        //Window.CLOSE;
        Rec."Approval Sent By" := UserId;
        Rec."Approval Sent On" := Today;
        // Rec.Modify();
        Message('Approval mail sent successfully');

    end;

}