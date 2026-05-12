PageExtension 50061 "Posted Sales Invoice_PagEXT" extends "Posted Sales Invoice"
{
    layout
    {
        modify(General)
        {
            Editable = false;
        }
        addafter("Company Bank Account Code")
        {
            field("N° timbre Fiscal"; Rec."N° timbre Fiscal")
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'N° timbre Fiscal';
            }
            field("N° Sticker Fiscal"; Rec."N° Sticker Fiscal")
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'N° Sticker Fiscal';
            }
        }
        addafter("No. Printed")
        {
            field("Job No."; rec."Job No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Prepayment Rank No."; rec."Prepayment Rank No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("User ID"; rec."User ID")
            {
                ApplicationArea = all;
            }
        }

        addafter("Pmt. Discount Date")
        {
            field("Subscription Starting Date"; rec."Subscription Starting Date")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Subscription End Date"; rec."Subscription End Date")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Next Invoice Calcultation"; rec."Next Invoice Calcultation")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Next Invoice Date"; rec."Next Invoice Date")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(Subject; rec.Subject)
            {
                ApplicationArea = all;

                trigger OnAssistEdit()
                var
                    lDescription: Record "Description Line";
                begin
                    lDescription.ShowDescription(112, 2, rec."No.", 0);
                end;
            }
            field("Part Payment"; rec."Part Payment")
            {
                ApplicationArea = all;
            }
        }

        addafter("Ship-to Contact")
        {
            field("Project Manager"; rec."Project Manager")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Nom du maître d'oeuvre"; wProjectManagerName)
            {
                ApplicationArea = all;
                Caption = 'Project Manager Name';
            }
            field("No. Printed2"; rec."No. Printed")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter("Co&mments")
        {
            /*GL2024  action("Critères Statistiques")
              {
                  Caption = 'Statistics Criteria';
                  ApplicationArea = all;
                  trigger OnAction()
                  var
                      lInvSales: Record "Sales Invoice Header";
                  //DYS page addon non migrer
                  //lFormStatInvSales: Page 8005122;
                  begin

                      lInvSales := Rec;
                      //DYS
                      // lFormStatInvSales.SETRECORD(lInvSales);
                      // lFormStatInvSales.RUNMODAL();
                      Rec := lInvSales;
                      CurrPage.UPDATE(TRUE);
                  end;
              }
              action("Informations Additionnelles")
              {
                  Caption = 'Additionnals Informations';
                  ApplicationArea = all;
                  trigger OnAction()
                  var
                      lSalesInvHeader: Record "Sales Invoice Header";
                  //DYS page addon non migrer
                  //lFormAddInfo: Page 8005127;
                  begin

                      lSalesInvHeader := Rec;
                      //DYS
                      // lFormAddInfo.SETRECORD(lSalesInvHeader);
                      // lFormAddInfo.RUNMODAL;
                      Rec := lSalesInvHeader;
                      CurrPage.UPDATE(TRUE);
                  end;
              }*/
        }



        addafter("&Track Package")
        {
            /*GL2024  action("Annuler facture abonnement")
              {
                  Caption = 'Cancel subscription invoice';
                  ApplicationArea = all;
                  trigger OnAction()
                  var
                  //DYS REPORT addon non migrer
                  //ReverseInvoice: Report 8001910;
                  begin
                      //DYS
                      // ReverseInvoice.SetSalesHeader(Rec);
                      //ReverseInvoice.RUN;
                  end;
              }*/
        }
        modify("Print")
        {
            visible = false;
        }
        addafter(Print)
        {
            action("Print2")
            {
                Caption = 'Imprimer';
                Ellipsis = true;
                Image = Print;
                //  Promoted = true;
                ApplicationArea = all;
                trigger OnAction()
                begin

                    // >> HJ DSFT 10-10-2012
                    SalesInvHeader.SETRANGE("No.", rec."No.");

                    //  REPORT.RUNMODAL(REPORT::"Heure Sup BR Impression", TRUE, TRUE, SalesInvHeader);
                    REPORT.RUNMODAL(REPORT::"Facture Vente enregistré", TRUE, TRUE, SalesInvHeader);
                    // >> HJ DSFT 10-10-2012
                    // STD HJ DSFT 10-10-2012 DocPrint.PrintPurchHeader(Rec);


                    // OLD GESWAY  CurrForm.SETSELECTIONFILTER(SalesInvHeader);
                    // OLD GESWAY SalesInvHeader.PrintRecords(TRUE);
                end;
            }
            action("&&Print Format A4")
            {
                Caption = '&Print Format A4';
                Visible = false;
                Image = Print;
                //   Promoted = true;
                ApplicationArea = all;
                trigger OnAction()
                begin

                    // >> HJ DSFT 10-10-2012 
                    SalesInvHeader.SETRANGE("No.", rec."No.");
                    REPORT.RUNMODAL(REPORT::"Facture Vente enregistré", TRUE, TRUE, SalesInvHeader);
                end;
            }
            action("&Imprimer Ant")
            {
                Caption = '&Print Ant';
                Visible = false;
                Image = Print;
                // Promoted = true;
                ApplicationArea = all;

                trigger OnAction()
                begin

                    SalesInvHeader.SETRANGE("No.", rec."No.");
                    REPORT.RUNMODAL(REPORT::"Facture Vente enregistré2", TRUE, TRUE, SalesInvHeader);
                end;
            }
        }
        addafter(Print_Promoted)
        {
            actionref("Print21"; "Print2")
            {

            }
            actionref("&&Print Format A41"; "&&Print Format A4")
            {

            }
            actionref("&Imprimer Ant1"; "&Imprimer Ant")
            {

            }
        }
    }
    trigger OnOpenPage()
    VAR
        lMaskMgt: Codeunit "Mask Management";
    begin

        //CARACT
        NavibatSetup.GET2;
        //STATSEXPLORER
        IF wStat.READPERMISSION THEN
            IF NOT wStat.GET THEN
                wStat.INIT;
        //STATSEXPLORER//
        //MASK
        lMaskMgt.SalesInvHeader(Rec);
        //MASK//
        //CARACT//
    end;

    trigger OnAfterGetRecord()
    begin
        rec.SETRANGE("No.");
        //DEVIS
        IF (rec."Project Manager" <> '') AND wContact.GET(rec."Project Manager") THEN
            wProjectManagerName := wContact.Name
        ELSE
            wProjectManagerName := '';
        //DEVIS//
    end;

    var
        NavibatSetup: Record NavibatSetup;
        wStat: Record "Statistics setup";
        wContact: Record Contact;
        wProjectManagerName: Text[30];
}

