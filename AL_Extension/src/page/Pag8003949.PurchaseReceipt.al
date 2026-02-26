page 8003949 "Purchase Receipt"
{
    //GL2024  ID dans Nav 2009 : "8003949"


    // //PROJET GESWAY 01/11/01 Ajout Job No.
    //                 10/12/01 NextControl : Date document > N° projet > Lignes
    // //+RFA+ GESWAY 11/07/02 Déplacement du champ actif dans N° de l'en-tête lors du lancement de la fonction
    //                             de calcul remise facture et des statistiques (OnPush)
    // //+WKF+CUSTOM CW 13/12/02 Add Workflow button
    // //+REF+POST_DESC GESWAY 10/02/03 Ajout du champ "Posting Description" -> Onglet Facturation
    // //+REF+SOLDE_CDE CLA 22/01/03 Ajout Solder la commande dans le bouton fonctions
    // //+REF+ACHAT GESWAY 11/06/03 Appel d'un formulaire sur validation
    // //OUVRAGE GESWAY 12/03/03 Ajout "Description" sur bouton Ligne
    // //ACHATS CLA 13/06/03 Ajout fonction Clôturer commande (= supprimer) 
    //          GESWAY 15/03/04 Ajout en visualisation du champ N° téléphone
    // //MULTI_ADDR GESWAY 12/03/04 Ajout N° chantier destinataire
    // //CRM GESWAY 09/03/04 Ajout Interactions sur bouton Devis
    // //ACHATS GESWAY 07/03/05 Ajout groupe compta marché TVA dans l'en-tête 
    //                 08/07/05 Ajout bouton Commande "élagué"

    Caption = 'Réception achat';
    PageType = card;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order));
    // ApplicationArea = all;
    // UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Shipping)
            {
                Caption = 'Réception';
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Caption = 'N° commande';
                    Importance = Promoted;
                    Editable = false;

                    trigger OnAssistEdit()

                    begin
                        IF rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Nom';

                }
                field("Ship-to Name"; rec."Ship-to Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Nom du destinataire';
                }
                field("Ship-to Address"; rec."Ship-to Address")
                {
                    ApplicationArea = all;
                    Caption = 'Adresse destinataire';
                }
                field("Ship-to Address 2"; rec."Ship-to Address 2")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'N° affaire';
                    Style = AttentionAccent;
                    StyleExpr = true;
                }
                field(Demandeur; Rec.Demandeur)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Demandeur';
                }
                field(Engin; Rec.Engins)
                {
                    ApplicationArea = all;
                    Caption = 'Engin';
                    Editable = false;
                    Visible = false;

                }
                field("Description Engin"; Rec."Description Engins")
                {
                    ApplicationArea = all;
                    Caption = 'Description Engin';
                    Editable = false;
                    Visible = false;

                }
                field("Motif Annulation"; Rec."Motif Annulation")
                {
                    ApplicationArea = all;
                    Caption = 'Motif Annulation';
                    Visible = false;


                }
                field("Etat Commande"; Rec."Etat Commande")
                {
                    ApplicationArea = all;
                    Caption = 'Etat Commande';
                    Style = Unfavorable;
                    StyleExpr = true;
                    Editable = false;

                }
                field("Ship-to Post Code"; rec."Ship-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Contact"; rec."Ship-to Contact")
                {
                    Visible = false;
                }
                field("Ship-to City"; rec."Ship-to City")
                {
                    Visible = false;
                    ApplicationArea = all;
                }

                /*   field("Ship-to Post Code"; rec."Ship-to Post Code")
                   {  ApplicationArea = all;
                   }
                   field("Ship-to City"; rec."Ship-to City")
                   {  ApplicationArea = all;
                   }
                   field("Ship-to Contact"; rec."Ship-to Contact")
                   {
                   }
                   field("Sell-to Customer No."; rec."Sell-to Customer No.")
                   {  ApplicationArea = all;
                   }
                   field("Ship-to Code"; rec."Ship-to Code")
                   {  ApplicationArea = all;
                   }
                   field("Ship-to Job No."; rec."Ship-to Job No.")
                   {  ApplicationArea = all;
                       Importance = Promoted;
                   }*/
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Visible = false;
                    Caption = 'Date BL';
                    trigger OnValidate()
                    begin
                        Rec."Document Date" := Rec."Posting Date";
                    end;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                    Caption = 'Document Date';
                }
                field("Vendor Shipment No."; rec."Vendor Shipment No.")
                {
                    ApplicationArea = all;
                    Caption = 'N° B.L. fournisseur';
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;

                    Editable = false;
                }
                field("Inbound Whse. Handling Time"; rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = all;
                }
                field("Shipment Method Code"; rec."Shipment Method Code")
                {
                    ApplicationArea = all;
                    Caption = 'Code condition livraison';
                }
                field("Lead Time Calculation"; rec."Lead Time Calculation")
                {
                    ApplicationArea = all;
                    Caption = 'Délai de réappro.';
                }
                field("Requested Receipt Date"; rec."Requested Receipt Date")
                {
                    ApplicationArea = all;
                    Caption = 'Date réception demandée';
                }
                field("Promised Receipt Date"; rec."Promised Receipt Date")
                {
                    ApplicationArea = all;

                }
                field("Expected Receipt Date"; rec."Expected Receipt Date")
                {
                    ApplicationArea = all;

                }
                field("N° Demande d'achat"; Rec."N° Demande d'achat")
                {
                    ApplicationArea = all;
                    Caption = 'N° Demande d''achat';
                    Visible = false;
                    Editable = false;
                }
                field("N° DA Chantier"; Rec."N° DA Chantier")
                {
                    ApplicationArea = all;
                    Caption = 'N° DA Chantier';
                    Editable = false;
                    Visible = false;
                }
            }
            part(PurchLines; "Purchase Receipt Subform")
            {
                ApplicationArea = all;
                Caption = 'Sous-form. commande achat';
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(General)
            {
                Caption = 'Général';
                field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        BuyfromVendorNoOnAfterValidate;
                    end;
                }
                field("Buy-from Contact No."; rec."Buy-from Contact No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Buy-from Address"; rec."Buy-from Address")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Buy-from Address 2"; rec."Buy-from Address 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Buy-from Post Code"; rec."Buy-from Post Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Buy-from City"; rec."Buy-from City")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Buy-from Contact"; rec."Buy-from Contact")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(wNoTel; wNoTel)
                {
                    ApplicationArea = all;
                    Caption = 'N° téléphone';
                    Editable = false;
                }
                field("Appliquer Fodec"; Rec."Appliquer Fodec")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ShowCaption = false;

                }
                field("Order Date"; rec."Order Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Vendor Order No."; rec."Vendor Order No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Responsibility Center"; rec."Responsibility Center")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Job No.2"; rec."Job No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'N° affaire';
                    Importance = Promoted;
                }
                field(wFaxNo; wFaxNo)
                {
                    ApplicationArea = all;
                    Caption = 'N° télécopie';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = '&Commande';
                action(Statistics)
                {
                    ApplicationArea = all;
                    Caption = 'Statistics';
                    Image = Statistics;

                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        //+RFA+//
                        PurchSetup.GET;
                        IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                            CurrPage.PurchLines.page.CalcInvDisc;
                            COMMIT;
                        END;
                        Page.RUNMODAL(Page::"Purchase Order Statistics", Rec);
                    end;
                }
                action(Card)
                {
                    ApplicationArea = all;
                    Caption = 'Fiche';
                    Image = EditLines;
                    RunObject = Page 26;
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Maj+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = all;
                    Caption = 'Co&mmentaires';
                    Image = ViewComments;
                    RunObject = Page 66;
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
                }
                action(Receipts)
                {
                    ApplicationArea = all;
                    Caption = 'Bons de réception';
                    Image = PostedReceipts;
                    RunObject = Page 145;
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Description)
                {
                    ApplicationArea = all;
                    Caption = 'Description';

                    trigger OnAction()
                    var
                        lDescription: Record 8004075;
                    begin
                        //ACHATS
                        lDescription.ShowDescription(38, rec."Document Type", rec."No.", 0);
                        //ACHATS//
                    end;
                }
                action("Commande Origine")
                {
                    ApplicationArea = all;
                    Caption = 'Commande Origine';
                    RunObject = Page "Purchase Order";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");

                }
            }

            action(Imprimer)
            {
                ApplicationArea = all;
                Caption = 'Imprimer';
                Image = Print;
                Visible = false;
                trigger OnAction()
                var
                    RecPurchaseOrder: Record "Purchase Header";
                begin

                    /* HS CHANGER PAR BON CMD MAT   RecPvRecept.RESET;
                       RecPvRecept.SETRANGE("Document Type", RecPvRecept."Document Type"::Order);
                       RecPvRecept.SETRANGE("Document No.", rec."No.");
                       REPORT.RUNMODAL(50243, TRUE, TRUE, RecPvRecept);*/
                    // >> HJ DSFT 10-10-2012
                    //    IF CompanyInfo.GET() THEN;
                    //   IF rec.Status <> rec.Status::Released THEN ERROR(Text003);
                    RecPurchaseOrder.SETRANGE("Document Type", rec."Document Type");
                    RecPurchaseOrder.SETRANGE("No.", rec."No.");
                    REPORT.RUNMODAL(REPORT::"BON COMMANDE SOUROUBAT 03 V4", TRUE, TRUE, RecPurchaseOrder);
                end;
            }
        }
        area(processing)
        {
            /*GL2024 action("Wor&Kflow")
             {
                 Caption = 'Wor&Kflow';
                 Promoted = true;
                 PromotedCategory = Process;
                 RunObject = Page 8004213;
                 RunPageLink = Type = CONST(50), "No." = FIELD("No.");
                 ToolTip = 'Workflow';
             }*/

            group("F&unctions")
            {
                Caption = 'Fonction&s';
                action("Delete Order")
                {
                    ApplicationArea = all;
                    Caption = 'Clô&turer la commande';

                    trigger OnAction()
                    var
                        lPurchHeader: Record 38;
                        lDeleteInvOrder: Report 499;
                    begin
                        //ACHAT
                        lPurchHeader.COPY(Rec);
                        lPurchHeader.SETRECFILTER;
                        lDeleteInvOrder.SETTABLEVIEW(lPurchHeader);
                        lDeleteInvOrder.USEREQUESTPAGE(TRUE);
                        lDeleteInvOrder.RUN;
                        CurrPage.UPDATE;
                        //ACHAT//
                    end;
                }
                action("Close Order")
                {
                    ApplicationArea = all;
                    Caption = 'So&lder la commande';

                    trigger OnAction()
                    begin


                        //+REF+SOLDE_CDE
                        Currpage.PurchLines.page.wCompletelyReceived;
                        //+REF+SOLDE_CDE//


                    end;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Axes analytiques';
                    Enabled = Rec."No." <> '';
                    Image = Dimensions;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim();
                        CurrPage.SaveRecord();
                    end;
                }
                action("PV Reception")
                {
                    ApplicationArea = all;
                    Caption = 'PV Reception';

                    trigger OnAction()
                    var

                        RecLPvReception: Record "PV Reception";
                        IntNumSequence: Integer;
                    begin



                        // >> HJ DSFT 25-04-2012
                        rec.TESTFIELD("Vendor Shipment No.");
                        IntNumSequence := Currpage.PurchLines.page.InsertPVReception;
                        rec."N° Sequence" := IntNumSequence;
                        rec.MODIFY;
                        RecLPvReception.SETRANGE("N° Sequence", IntNumSequence);
                        IF RecLPvReception.FINDFIRST THEN page.RUN(page::"PV Reception", RecLPvReception);
                        // >> HJ DSFT 25-04-2012


                    end;
                }
            }
            group("P&osting")
            {
                Caption = '&Validation';
                action("Post Receipt")
                {
                    ApplicationArea = all;
                    Caption = 'Valider réception';
                    Image = Post;

                    ShortCutKey = 'F11';

                    trigger OnAction()
                    var

                        RecLPurchaseLine: Record "Purchase Line";
                        RecLPurchaseHeader: Record "Purchase Header";
                        RecLSalesHeader: Record "Sales Header";
                        RecPurchaseLine: Record "Purchase Line";
                    begin
                        RecPurchaseLine.Reset();
                        RecPurchaseLine.SetRange("Document Type", rec."Document Type"::Order);
                        RecPurchaseLine.SetRange("Document No.", rec."No.");
                        RecPurchaseLine.SetFilter("Job No.", '<>%1', '');
                        IF RecPurchaseLine.FindSet() THEN begin
                            repeat
                                RecPurchaseLine."Job No." := '';
                                RecPurchaseLine."Job Task No." := '';
                                RecPurchaseLine.Modify();
                            until RecPurchaseLine.Next() = 0;
                        end;
                        /*  if Rec."Vendor Shipment No." <> '' then begin
                              // >> HJ DELTA 10-03-2014
                              RecPurchaseheader.RESET;
                              RecPurchaseheader.SETRANGE("Vendor Shipment No.", Rec."Vendor Shipment No.");
                              RecPurchaseheader.SETRANGE("Buy-from Vendor No.", Rec."Buy-from Vendor No.");
                              IF RecPurchaseheader.FINDFIRST THEN begin
                                  if RecPurchaseheader.Count > 1 then
                                      ERROR(Text054);
                              end;

                              PurchRcptHeader.RESET;
                              PurchRcptHeader.SETRANGE("Vendor Shipment No.", Rec."Vendor Shipment No.");
                              PurchRcptHeader.SETRANGE("Buy-from Vendor No.", Rec."Buy-from Vendor No.");
                              IF PurchRcptHeader.FINDFIRST THEN ERROR(Text054);
                          end;*/
                        // >> HJ DELTA 10-03-2014
                        // MH SORO 08-05-2021
                        /*  IF RecUserSetup3.GET(UPPERCASE(USERID)) THEN;
                          RecPurchaseLine3.RESET;
                          RecPurchaseLine3.SETRANGE("Document No.", rec."No.");
                          RecPurchaseLine3.SETRANGE("Location Code", 'DEPOT Z4');
                          IF RecPurchaseLine3.FINDFIRST THEN
                              IF RecUserSetup3."Autoriser Réception Magasin Z4" = FALSE THEN ERROR(Text015);*/
                        // MH SORO 08-05-2021 
                        RecPurchaseLine.RESET;
                        RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                        RecPurchaseLine.SETRANGE("Document No.", rec."No.");
                        RecPurchaseLine.SetFilter(Type, '<>%1', RecPurchaseLine.Type::" ");
                        IF RecPurchaseLine.FINDFIRST THEN
                            REPEAT
                                RecPurchaseLine.TestField("Location Code");
                            UNTIL RecPurchaseLine.NEXT = 0;

                        // SYNCRO 12/05/2015
                        // >> HJ SORO 12-05-2015
                        NumBl := rec."Vendor Shipment No.";
                        RecLPurchaseLine.RESET;
                        RecLPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                        RecLPurchaseLine.SETRANGE("Document No.", rec."No.");
                        RecLPurchaseLine.SetRange("DYSJob Task No.", '');
                        RecLPurchaseLine.SetFilter(Type, '<>%1', RecPurchaseLine.Type::" ");
                        IF RecLPurchaseLine.FINDFIRST THEN
                            Error('N° tâche du travail non renseigné sur les lignes de la commande. Veuillez le renseigner avant de valider la réception.');


                        RecLPurchaseLine.RESET;
                        RecLPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                        RecLPurchaseLine.SETRANGE("Document No.", rec."No.");
                        IF RecLPurchaseLine.FINDFIRST THEN
                            REPEAT
                                /*  IF RecLPurchaseLine."Qty. to Receive" <> 0 THEN BEGIN
                                      RecLPurchaseLine.TESTFIELD("dysJob No.");
                                      RecLPurchaseLine.TESTFIELD("Affectation Marche");
                                      RecLPurchaseLine.TESTFIELD("Sous Affectation Marche");
                                  END;*/
                                RecLPurchaseLine.Synchronise := FALSE;
                                RecLPurchaseLine."Requested Receipt Date" := WORKDATE;
                                RecLPurchaseLine.MODIFY;
                            UNTIL RecLPurchaseLine.NEXT = 0;
                        // >> HJ SORO 12-05-2015
                        // SYNCRO 12/05/2015

                        //FACTURATION_ACHAT
                        //     IF rec."Vendor Shipment No." = '' THEN ERROR(Text002);
                        // >> HJ DSFT 03-10-2012
                        /*     IF UserSetup.GET(UPPERCASE(USERID)) THEN;
                             IF UserSetup."Filtre Magasin" <> '' THEN BEGIN
                                 RecLPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                                 RecLPurchaseLine.SETRANGE("Document No.", rec."No.");
                                 RecLPurchaseLine.SETRANGE(Type, RecLPurchaseLine.Type::Item);

                                 IF RecLPurchaseLine.FINDFIRST THEN
                                     REPEAT
                                         IF RecLPurchaseLine."Location Code" <> UserSetup."Filtre Magasin" THEN
                                             ERROR(Text001, UserSetup."Filtre Magasin",
     RecLPurchaseLine."Line No.", RecLPurchaseLine."No.", RecLPurchaseLine."Location Code");
                                     UNTIL RecLPurchaseLine.NEXT = 0;
                             END;
                             // >> HJ DSFT 03-10-2012
                             RecLPurchaseLine.RESET;
                             RecLPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                             RecLPurchaseLine.SETRANGE("Document No.", rec."No.");
                             RecLPurchaseLine.SETRANGE(Type, RecLPurchaseLine.Type::Item);

                             IF RecLPurchaseLine.FINDFIRST THEN
                                 REPEAT
                                     IF RecLPurchaseLine."No." = 'IMM' THEN ERROR(Text003);
                                 UNTIL RecLPurchaseLine.NEXT = 0;*/


                        PurchSetup.GET;
                        IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                            CurrPage.PurchLines.page.CalcInvDisc;
                            COMMIT;
                        END;
                        //??TESTFIELD(Status,Status::Released);

                        // >> HJ DSFT 20-06-2012
                        Currpage.PurchLines.page.InsertPVReception;
                        // >> HJ DSFT 20-06-2012

                        // >> HJ DSFT 03-10-2012
                        /*  IF RecLPurchaseHeader.GET(rec."Document Type", rec."No.") THEN;
                          RecLSalesHeader.SETRANGE("Document Type", RecLSalesHeader."Document Type"::Order);
                          RecLSalesHeader.SETRANGE("No.", RecLPurchaseHeader."N° Demande d'achat");
                          IF RecLSalesHeader.FINDFIRST THEN;
                          RecLPurchaseLine.RESET;
                          RecLPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                          RecLPurchaseLine.SETRANGE("Document No.", rec."No.");
                          RecLPurchaseLine.SETRANGE(Type, RecLPurchaseLine.Type::Item);
                          RecLPurchaseLine.SETFILTER("Qty. to Receive", '<>%1', 0);
                          IF RecLPurchaseLine.FINDFIRST THEN
                              REPEAT
                                  UserSetup.SETRANGE("Notifier Reception PR", TRUE);
                                  IF UserSetup.FINDFIRST THEN
                                      REPEAT
                                          NotificationReception.Utilisateur := UserSetup."User ID";
                                          NotificationReception."Type Notification" := NotificationReception."Type Notification"::Reception;
                                          NotificationReception."BL N °" := RecLPurchaseHeader."Vendor Shipment No.";
                                          NotificationReception."Document N°" := RecLPurchaseHeader."No.";
                                          NotificationReception.Article := RecLPurchaseLine."No.";
                                          NotificationReception.Description := RecLPurchaseLine.Description;
                                          NotificationReception."Quantité Reçue" := RecLPurchaseLine."Qty. to Receive";
                                          NotificationReception."Date Reception" := RecLPurchaseHeader."Posting Date";
                                          NotificationReception."Date DA" := RecLPurchaseHeader."Date DA";
                                          NotificationReception."Date Commande" := RecLPurchaseHeader."Order Date";
                                          NotificationReception.Demandeur := RecLSalesHeader."Requester ID";
                                          NotificationReception."N° DA" := RecLPurchaseHeader."N° Demande d'achat";
                                          NotificationReception."Quantité Restante" := RecLPurchaseLine."Outstanding Quantity";
                                          IF RecLPurchaseHeader."Vendor Shipment No." <> '' THEN
                                              IF NOT NotificationReception.INSERT THEN NotificationReception.MODIFY;
                                      UNTIL UserSetup.NEXT = 0;
                              UNTIL RecLPurchaseLine.NEXT = 0;

                          // >> HJ DSFT 03-10-2012*/



                        wPurchPost.InitRequest(FALSE, TRUE);
                        wPurchPost.RUN(Rec);
                        //FACTURATION_ACHAT//
                        // >> HJ DSFT 03-10-2012

                        RecLPurchaseLine.RESET;
                        RecLPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                        RecLPurchaseLine.SETRANGE("Document No.", rec."No.");
                        IF RecLPurchaseLine.FINDFIRST THEN
                            REPEAT
                                RecLPurchaseLine."PV Generer" := FALSE;
                                RecLPurchaseLine."Sequence PV" := 0;
                                RecLPurchaseLine.VALIDATE("Qty. to Receive", 0);
                                RecLPurchaseLine.Synchronise := FALSE;
                                RecLPurchaseLine.MODIFY;
                            UNTIL RecLPurchaseLine.NEXT = 0;

                        // >> HJ DSFT 03-10-2012
                        // >> HJ SORO 10-04-2018
                        /*GL2024    SalesHeader.SETRANGE("No.", rec."N° Demande d'achat");
                            IF SalesHeader.FINDFIRST THEN BEGIN
                                SalesContributor.SETRANGE("Job No.", rec."Job No.");
                                SalesContributor.SETRANGE(Approbateur, UPPERCASE(SalesHeader.Approbateur));
                                IF SalesContributor.FINDFIRST THEN
                                    IF SalesHeader."Mode Notification" = SalesHeader."Mode Notification"::Mail THEN
                                        Mail.SendMail(SalesContributor.Mail, 'NAVISION : NOTIFICATION LIVRAISON POUR LA DA N°  ' + rec."N° Demande d'achat",
                                        'LIVRAISON EFFECTUEE POUR LA DA N° ' + rec."N° Demande d'achat" + ' BL N° ' + NumBl);
                                Mail.NotificationDa(rec."N° Demande d'achat", 'LIVRAISON N° : ' + NumBl, rec."Job No.", WORKDATE, rec."User ID");


                            END;*/
                        // >> HJ SORO 10-04-2018
                    end;
                }
            }

        }

        area(Promoted)
        {

            group("O&rder1")
            {
                Caption = '&Commande';
                actionref(Statistics1; Statistics) { }
                actionref(Card1; Card) { }
                actionref("Co&mments1"; "Co&mments") { }
                actionref(Receipts1; Receipts) { }
                actionref(Description1; Description) { }
                actionref("Commande Origine1"; "Commande Origine") { }

            }

            group("F&unctions11")
            {
                Caption = 'Fonction&s';
                actionref("Delete Order1"; "Delete Order") { }
                actionref("Close Order1"; "Close Order") { }
                actionref("PV Reception1"; "PV Reception") { }
                actionref("AxeAnalytique"; "Dimensions") { }
            }
            group("P&osting1")
            {
                Caption = '&Validation';
                actionref("Post Receipt1"; "Post Receipt") { }
            }




            actionref(Imprimer1; Imprimer) { }


        }

    }

    trigger OnAfterGetRecord()
    begin

        rec.SETRANGE("Document Type");
        //POSTING_DESC
        //POSTING_DESC
        wDescr := rec.wShowPostingDescription(rec."Posting Description");
        //POSTING_DESC//
        //ACHATS
        wUpdateTelFax;
        //ACHATS//
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.UPDATE(TRUE);
        EXIT(rec.ConfirmDeletion);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //ACHATS
        IF (rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No.") OR (rec."Order Address Code" <> xRec."Order Address Code") THEN
            wUpdateTelFax;
        //ACHATS//
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            rec.FILTERGROUP(2);
            //  rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            rec.FILTERGROUP(0);
        END;
    end;



    procedure wUpdateTelFax()
    var
        lVendor: Record 23;
        lDest: Record 224;
        lCont: Record 5050;
    begin
        //ACHATS
        wNoTel := '';
        wFaxNo := '';
        IF rec."Order Address Code" = '' THEN BEGIN
            IF rec."Buy-from Contact No." <> '' THEN
                IF lCont.GET(rec."Buy-from Contact No.") THEN BEGIN
                    wNoTel := lCont."Phone No.";
                    wFaxNo := lCont."Fax No.";
                END;
            IF lVendor.GET(rec."Buy-from Vendor No.") THEN BEGIN
                IF wNoTel = '' THEN
                    wNoTel := lVendor."Phone No.";
                IF wFaxNo = '' THEN
                    wFaxNo := lVendor."Fax No.";
            END;
        END ELSE BEGIN
            IF lDest.GET(rec."Buy-from Vendor No.", rec."Order Address Code") THEN BEGIN
                wNoTel := lDest."Phone No.";
                wFaxNo := lDest."Fax No.";
            END;
            IF wNoTel = '' THEN BEGIN
                IF rec."Buy-from Contact No." <> '' THEN
                    IF lCont.GET(rec."Buy-from Contact No.") THEN
                        wNoTel := lCont."Phone No.";
                IF wNoTel = '' THEN
                    IF lVendor.GET(rec."Buy-from Vendor No.") THEN
                        wNoTel := lVendor."Phone No.";
            END;
            IF wFaxNo = '' THEN BEGIN
                IF rec."Buy-from Contact No." <> '' THEN
                    IF lCont.GET(rec."Buy-from Contact No.") THEN
                        wFaxNo := lCont."Fax No.";
                IF wFaxNo = '' THEN
                    IF lVendor.GET(rec."Buy-from Vendor No.") THEN
                        wFaxNo := lVendor."Fax No.";
            END;
        END;
        //ACHATS//
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    procedure InsertPvReception()
    begin

        // >> HJ DSFT 25-04-2012
        Currpage.PurchLines.page.InsertPVReception;
        // >> HJ DSFT 25-04-2012

    end;





    var
        Text054: label 'N° BL Deja Saisie !!!!!';
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        RecPurchaseheader: Record "Purchase Header";
        PurchSetup: Record 312;
        //    NotificationReception: Record "Notification Reception";
        ChangeExchangeRate: Page 511;
        CopyPurchDoc: Report 492;
        MoveNegPurchLines: Report 6698;
        ReportPrint: Codeunit 228;
        DocPrint: Codeunit 229;
        UserMgt: Codeunit 5700;
        ArchiveManagement: Codeunit 5063;
        wPurchPost: Codeunit 8001426;
        wDescr: Text[100];
        wNoTel: Text[30];
        wFaxNo: Text[30];

        UserSetup: Record "User Setup";
        InventorySetup: Record "Inventory Setup";
        RecVendorFODEC: Record "Vendor";
        RecVendorPostingGroup: Record "Vendor Posting Group";
        CduPurchasePost: Codeunit "Purch.-Post";
        RecPvRecept: Record "Purchase Line";
        NumeroBL: Code[20];
        CodeProduit: Code[20];
        //  BLBestBeton: Record "BL Carriere";
        Mail: Codeunit "Soroubat cdu";
        SalesContributor: Record "Sales Contributor";
        SalesHeader: Record "Sales Header";
        fef: page "Purchase Statistics";
        NumBl: Code[20];
        RecPurchaseLine3: Record "Purchase Line";
        RecUserSetup3: Record "User Setup";

        Mail2: Codeunit Mail;
        Text001: label 'Votre Magasin De Reception Est %1  Il n''est pas Celui Dans La Ligne %2 Article %3 Magasin %4';
        Text002: label 'Veuillez Preciser N° BL Fournisseur Avant Validation';
        Text003: label 'Article IMM Ne Peut Etre Receptionné, Veuillez Demander La Creation De L''immobilisation En Question';
        Text015: label 'Vous n''avez pas le droit de valider la réception pour Magasin Depot Z4';

}

