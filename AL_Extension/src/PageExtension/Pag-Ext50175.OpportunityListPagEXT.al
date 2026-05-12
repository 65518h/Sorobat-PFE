PageExtension 50175 "Opportunity List_PagEXT" extends "Opportunity List"

{

    layout
    {
        addbefore(Control1)
        {
            field("Filtre contact"; wContact)
            {
                Caption = 'Contact Filter';
                ApplicationArea = all;
                trigger OnLookup(var Text: Text): Boolean
                var
                    lContact: Record Contact;
                begin

                    IF PAGE.RUNMODAL(PAGE::"Contact List", lContact) = ACTION::LookupOK THEN
                        wContact += lContact."No.";
                    IF (wContact <> '') THEN
                        rec.SETFILTER("Contact No.", '%1', wContact)
                    ELSE
                        rec.SETRANGE("Contact No.");
                    CurrPage.UPDATE(TRUE);
                end;

                trigger OnValidate()
                begin

                    IF (wContact <> '') THEN
                        rec.SETFILTER("Contact No.", wContact)
                    ELSE
                        rec.SETRANGE("Contact No.");
                    CurrPage.UPDATE(TRUE);
                end;
            }
            field("Filtre vendeur"; wSalesperson)
            {
                Caption = 'Salesperson Filter';
                ApplicationArea = all;
                trigger OnLookup(var Text: Text): Boolean
                var
                    lSalesPerson: Record "Salesperson/Purchaser";
                begin

                    IF PAGE.RUNMODAL(PAGE::"Salespersons/Purchasers", lSalesPerson) = ACTION::LookupOK THEN
                        wSalesperson += lSalesPerson.Code;
                    IF (wSalesperson <> '') THEN
                        rec.SETFILTER("Salesperson Code", '%1', wSalesperson)
                    ELSE
                        rec.SETRANGE("Salesperson Code");
                    CurrPage.UPDATE(TRUE);
                end;

                trigger OnValidate()
                begin

                    IF (wSalesperson <> '') THEN
                        rec.SETFILTER("Salesperson Code", wSalesperson)
                    ELSE
                        rec.SETRANGE("Salesperson Code");
                    CurrPage.UPDATE(TRUE);
                end;
            }
            field("Filtre fin opportunité"; wCloseOpportCode)
            {
                ApplicationArea = all;
                Caption = 'Close Opportunity Filter';

                trigger OnLookup(var Text: Text): Boolean
                var
                    lCloseOppCode: Record "Close Opportunity Code";
                begin

                    IF PAGE.RUNMODAL(PAGE::"Close Opportunity Codes", lCloseOppCode) = ACTION::LookupOK THEN
                        wCloseOpportCode += lCloseOppCode.Code;
                    IF (wCloseOpportCode <> '') THEN BEGIN
                        rec.SETFILTER("Close Opportunity Code", wCloseOpportCode);
                        rec.SETRANGE(Closed, TRUE);
                    END ELSE BEGIN
                        rec.SETRANGE("Close Opportunity Code");
                        rec.SETRANGE(Closed);
                    END;
                    CurrPage.UPDATE(TRUE);
                end;

                trigger OnValidate()
                begin

                    IF (wCloseOpportCode <> '') THEN BEGIN
                        rec.SETFILTER("Close Opportunity Code", wCloseOpportCode);
                        rec.SETRANGE(Closed, TRUE);
                    END ELSE BEGIN
                        rec.SETRANGE("Close Opportunity Code");
                        rec.SETRANGE(Closed);
                    END;
                    CurrPage.UPDATE(TRUE);
                end;
            }
            field("Filtre campagne"; wCampaign)
            {
                Caption = 'Campaign Filter';
                ApplicationArea = all;
                trigger OnLookup(var Text: Text): Boolean
                var
                    lCampaign: Record Campaign;
                begin

                    IF PAGE.RUNMODAL(PAGE::"Campaign List", lCampaign) = ACTION::LookupOK THEN
                        wCampaign += lCampaign."No.";
                    IF (wCampaign <> '') THEN
                        rec.SETFILTER("Campaign No.", wCampaign)
                    ELSE
                        rec.SETRANGE("Campaign No.");
                    CurrPage.UPDATE(TRUE);
                end;

                trigger OnValidate()
                begin

                    IF (wCampaign <> '') THEN
                        rec.SETFILTER("Campaign No.", wCampaign)
                    ELSE
                        rec.SETRANGE("Campaign No.");
                    CurrPage.UPDATE(TRUE);
                end;
            }
        }
        addafter("Contact Company Name")
        {
            field("gSalesCycleStage.Description"; gSalesCycleStage.Description)
            {
                Caption = 'Description';
                Editable = FALSE;
                ShowCaption = false;
                ApplicationArea = all;
            }
            field("gSalesCycleStage.TABLECAPTION"; gSalesCycleStage.TABLECAPTION)
            {
                Caption = 'TABLECAPTION';
                Editable = FALSE;
                ShowCaption = false;
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter("Co&mments")
        {
            action("A&xes analytiques")
            {
                Caption = 'Dimensions';
                ApplicationArea = all;
                trigger OnAction()
                begin
                    Rec.fShowDocDim;
                end;
            }

            action("E&tats")
            {
                Caption = '&Etats';
                ApplicationArea = all;
                trigger OnAction()
                var
                    lReportList: Record ReportList;
                    lId: Integer;
                    lRecRef: RecordRef;
                begin
                    WITH lReportList DO BEGIN
                        EVALUATE(lId, FORMAT(COPYSTR(CurrPage.OBJECTID(FALSE), 6)));
                        lRecRef.GETTABLE(Rec);
                        SetRecordRef(lRecRef, FALSE);
                        ShowList(lId);
                    END;
                end;
            }
        }
        addafter("Show Sales Quote_Promoted")
        {
            actionref("E&tats1"; "E&tats")
            {

            }

            actionref("A&xes analytiques1"; "A&xes analytiques")
            {

            }
        }
    }

    trigger OnOpenPage()
    begin

        wContact := Rec.GETFILTER("Contact No.");
        wCampaign := Rec.GETFILTER("Campaign No.");
        wSalesperson := Rec.GETFILTER("Salesperson Code");
        wCloseOpportCode := Rec.GETFILTER("Close Opportunity Code");
        //+REF+OPPORT

        //+REF+OPPORT
        IF gUserMgt.GetSalesFilter() <> '' THEN BEGIN
            rec.FILTERGROUP(2);
            rec.SETRANGE("Responsibility Center", gUserMgt.GetSalesFilter());
            rec.FILTERGROUP(0);
        END;
        //+REF+OPPORT//
    end;

    var
        wContact: Text[250];
        wCampaign: Text[250];
        wSalesperson: Text[250];
        wCloseOpportCode: Text[250];
        gSalesCycleStage: Record "Sales Cycle Stage";
        gUserMgt: Codeunit "User Setup Management";
        Text002: Label 'There is no sales quote assigned to this opportunity.';
        Text003: Label 'Sales quote %1 does not exist.';

}