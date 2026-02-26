PageExtension 50034 "Purchase Order_PagEXT" extends "Purchase Order"
{
    /*GL2024 SourceTableView = WHERE(Document Type=FILTER(Order),
                           Status=FILTER(<>Archived),
                           Contrat=CONST(No));*/
    layout
    {
        modify("Order Address Code")
        {
            Visible = false;
        }
        // modify(General)
        // {
        //     Editable = EditableStatus;
        // }
        /*GL2024   modify("PurchLines")
            {
                Editable = false;
            }*/
        // modify("Invoice Details")
        // {
        //     Editable = EditableStatus;
        // }
        // modify("Shipping and Payment")
        // {
        //     Editable = EditableStatus;
        // }
        // modify("Foreign Trade")
        // {
        //     Editable = EditableStatus;
        // }
        // modify(Prepayment)
        // {
        //     Editable = EditableStatus;
        // }


        addafter("Purchaser Code")
        {
            field(Designation; Rec.Designation) { ApplicationArea = all; Editable = false; }
        }
        modify("Purchaser Code")
        {
            Caption = 'Affectation';
        }
        addafter(General)
        {
            group(Observations)
            {
                Editable = EditableStatus;

                field("Observation 1"; Rec."Observation 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Observation 1 field.', Comment = '%';
                }
                field("Observation 2"; Rec."Observation 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Observation 2 field.', Comment = '%';
                }
                field("Observation 3"; Rec."Observation 3")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Observation 3 field.', Comment = '%';
                }

            }
        }
        modify("No.")
        {
            Editable = false;
            Visible = true;
            //  AssistEdit = false;
            trigger OnAssistEdit()
            begin
                IF rec.AssistEdit(xRec) THEN
                    CurrPage.UPDATE;
            end;
        }
        modify("No. of Archived Versions")
        {
            Visible = false;
        }
        addafter("Quote No.")
        {
            field("Job No."; Rec."Job No.")
            {
                Caption = 'N° Affaire';
                ApplicationArea = all;
                ShowMandatory = true;
            }
            field("N° Demande d'achat"; Rec."N° Demande d'achat")
            {
                ApplicationArea = all;

                Style = Strong;
                StyleExpr = true;
                Editable = false;
            }
            field("Date DA"; Rec."Date DA")
            {
                ApplicationArea = all;
            }
            field("Statut Commande"; Rec."Statut Commande")
            {
                ApplicationArea = all;
                Style = AttentionAccent;
                StyleExpr = true;

            }

            field("Nom Affectation"; Rec."Nom Affectation")
            {
                ApplicationArea = all;
                Visible = false;
                Caption = 'Affectation';
            }
            field("Entry Point2"; Rec."Entry Point")
            {
                ApplicationArea = All;
                Caption = 'Lieu de livraision';
                Visible = false;
                trigger OnValidate()
                begin
                    rec.CALCFIELDS("Nom Lieu Liv");
                end;
            }
            field("Nom Lieu Liv"; Rec."Nom Lieu Liv")
            {
                ApplicationArea = all;
                Caption = 'Désignation livraision';
                Visible = false;
            }
            field("N° Dossier"; Rec."N° Dossier")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Location Code2"; Rec."Location Code")
            {
                ApplicationArea = all;
                Editable = true;
                trigger OnValidate()
                begin
                    // RB SORO 03/01/2014
                    IF rec."N° Demande d'achat" <> '' THEN
                        MESSAGE(Text012, rec."N° Demande d'achat");
                    // RB SORO 03/01/2014
                end;
            }
            field(Contrat; Rec.Contrat)
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(Utilisateur; Rec.Utilisateur)
            {
                ApplicationArea = all;
            }
            field("Date Bureau Ordre"; Rec."Date Bureau Ordre")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Nom Condition Paiement"; Rec."Nom Condition Paiement")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Etat Commande"; Rec."Etat Commande")
            {
                ApplicationArea = all;
                Caption = 'Etat Commande';
                Style = Attention;
                StyleExpr = true;
            }
            field("Motif Annulation"; Rec."Motif Annulation")
            {
                Style = Attention;
                StyleExpr = true;
                Visible = false;
                ApplicationArea = all;
            }
            field("N° Devis Fournisseur"; Rec."N° Devis Fournisseur")
            {
                ApplicationArea = all;
            }
            field("N° DA Chantier"; Rec."N° DA Chantier")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(Demandeur; Rec.Demandeur)
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(Demarcheur; Rec.Demarcheur)
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(Imprimer; Rec.Imprimer)
            {
                Editable = false;
                Visible = false;
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    // >> HJ SORO 10-10-2015
                    IF UserSetup.GET(UPPERCASE(USERID)) THEN;
                    //      IF NOT UserSetup."Annuler Impression CMDA" THEN ERROR(Text013);
                    // >> HJ SORO 10-10-2015
                end;
            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
                Caption = 'Utilisateur';
            }

        }
        /*GL2024  modify("Purchaser Code")
          {
              trigger OnAfterValidate()
              begin
                  rec.CALCFIELDS("Nom Affectation");
              end;
          }*/
        modify("Payment Terms Code")
        {
            trigger OnAfterValidate()
            begin
                rec.CALCFIELDS("Nom Condition Paiement");
            end;
        }

        addafter(General)
        {
            // part("Commentaire Achat"; "Commentaire Achat")
            // {//Page 50126
            //     Visible = false;
            //     Caption = 'Commentaire Achat';
            //     ApplicationArea = all;
            //     SubPageLink = "Document Type" = FIELD("Document Type"),
            //                 "No." = FIELD("No."),
            //                 "Document Line No." = CONST(0);

            // }
        }
        addafter(Prepayment)
        {
            Group("Materiaux Marché")
            {
                Caption = 'Materiaux Marché';

                part("Regroupement Rapport DG"; "Regroupement Rapport DG")
                {//Page 50241
                    Caption = 'Regroupement Rapport DG';
                    ApplicationArea = all;
                    SubPageView = WHERE(Type = CONST(Materiaux));
                    SubPageLink = Chantier = FIELD("Job No.");
                    Editable = false;

                }
            }
        }

        addbefore("Pay-to Contact No.")
        {
            field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }

        addafter("Pay-to Contact")
        {
            field(wDescr; wDescr)
            {
                ApplicationArea = all;
                Caption = 'Posting Description';

                trigger OnValidate()
                begin

                    //POSTING_DESC
                    IF wDescr = '' THEN BEGIN
                        rec."Posting Description" := rec.wPostingDescription;
                        wDescr := rec.wShowPostingDescription(rec."Posting Description");
                    END ELSE
                        rec."Posting Description" := wDescr;
                    //POSTING_DESC//
                end;
            }
            field("Subscription Starting Date"; rec."Subscription Starting Date")
            {
                ApplicationArea = all;
            }
            field("Subscription End Date"; rec."Subscription End Date")
            {
                ApplicationArea = all;
            }
            field("Apply-to Sales Order No."; Rec."Apply-to Sales Order No.")
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
                end;
            }
        }
        modify("Vendor Shipment No.")
        {
            ShowMandatory = true;
        }

        addafter(Status)
        {

            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Price Offer Amount"; Rec."Price Offer Amount")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Appliquer Fodec"; Rec."Appliquer Fodec")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Apply Stamp fiscal"; Rec."Apply Stamp fiscal")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(Finance; Rec.Finance) { Visible = false; ApplicationArea = all; }
        }

        addafter("VAT Bus. Posting Group")
        {


            field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
                end;
            }
            field("Your Reference2"; Rec."Your Reference")
            {
                ApplicationArea = all;
            }


        }

        addafter("Ship-to Contact")
        {
            field("Ship-to Contact No."; Rec."Ship-to Contact No.")
            {
                ApplicationArea = all;
            }
            field("Ship-to Job No."; Rec."Ship-to Job No.")
            {
                ApplicationArea = all;
            }
            field("Shipment Remark"; Rec."Shipment Remark")
            {
                ApplicationArea = all;
            }
            //HS
            /*   field("Apply Stamp fiscal"; Rec."Apply Stamp fiscal")
               {
                   ApplicationArea = all;
               }
               field("Appliquer Fodec2"; Rec."Appliquer Fodec")
               {
                   ApplicationArea = all;
               }*/
            //HS
            field("Shipment Method Code2"; Rec."Shipment Method Code")
            {
                ApplicationArea = all;
            }
            field("Promised Receipt Date2"; Rec."Promised Receipt Date")
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin

                    // >> HJ SORO 10-04-2018
                    /*   SalesHeader.SETRANGE("No.", rec."N° Demande d'achat");
                        IF SalesHeader.FINDFIRST THEN BEGIN
                            SalesContributor.SETRANGE("Job No.", rec."Job No.");
                            // SalesContributor.SETRANGE(Approbateur, UPPERCASE(SalesHeader.Approbateur));
                            IF SalesContributor.FINDFIRST THEN
                                //DYS fonction Mail.SendMail commenté car elle utilise Automation
                                //IF SalesHeader."Mode Notification" = SalesHeader."Mode Notification"::Mail THEN
                                //  Mail.SendMail(SalesContributor.Mail, 'NAVISION : NOTIFICATION RECEPTION ',
                                // 'RECEPTION CONFIRMER POUR LA DA Nø : ' + rec."N° Demande d'achat" + ' : DATE PREVUE ' +
                                // FORMAT(rec."Promised Receipt Date"));
                                Mail.NotificationDa(rec."N° Demande d'achat", 'RECEPTION CONFIRMER POUR LA DA Nø : ' + rec."N° Demande d'achat" + ' : DATE PREVUE ' +
                            FORMAT(rec."Promised Receipt Date"), rec."Job No.", WORKDATE, rec."User ID");

    */
                    //END;
                    // >> HJ SORO 10-04-2018
                end;
            }
            field("Date Next Follow-Up"; Rec."Date Next Follow-Up")
            {
                ApplicationArea = all;
            }

        }


    }
    actions
    {

        //hs


        /*modify("IncomingDocument")
        {
            Visible = ModifCommandeachat;
        }
        modify("Request Approval")
        {
            Visible = ModifCommandeachat;
        }
        modify("Flow")
        {
            Visible = ModifCommandeachat;
        }
        modify("Action17")
        {
            Visible = ModifCommandeachat;
        }
        modify("Category_Category11")
        {
            Visible = ModifCommandeachat;
        }
        modify("Category_Category8")
        {
            Visible = ModifCommandeachat;
        }
        modify("Category_Category9")
        {
            Visible = ModifCommandeachat;
        }

        modify("Category_Category4")
        {
            Visible = ModifCommandeachat;
        }
        modify("Category_Category7")
        {
            Visible = ModifCommandeachat;
        }
        modify("Category_Process")
        {
            Visible = ModifCommandeachat;
        }
        modify("P&osting")
        {
            Visible = ModifCommandeachat;
        }
        modify("F&unctions")
        {
            Visible = ModifCommandeachat;
        }
        modify("Action13")
        {
            Visible = ModifCommandeachat;
        }
        modify("Approval")
        {
            Visible = ModifCommandeachat;
        }
        modify("Documents")
        {
            Visible = ModifCommandeachat;
        }
        modify("Warehouse")
        {
            Visible = ModifCommandeachat;
        }
        modify("O&rder")
        {
            Visible = ModifCommandeachat;
        }*/
        modify(Statistics)
        {
            trigger OnbeforeAction()
            begin
                // >> HJ SORO 16-10-2014
                //HS replace with action appliquer Fodec
                /*  CduPurchpostevent.CalcTimbre(Rec);
                  CduPurchpostevent.CalcFodec(Rec);*/
                // >> HJ SORO 16-10-2014
            end;
        }
        addafter(Approvals)
        {
            action(Description)
            {
                Caption = 'Description';
                ApplicationArea = all;
                trigger OnAction()
                var
                    lDescription: Record "Description Line";
                begin

                    //ACHATS
                    lDescription.ShowDescription(38, rec."Document Type", rec."No.", 0);
                    //ACHATS//
                end;
            }
            separator(separator100)
            {
            }
            action("Interaction Log E&ntries")
            {
                Caption = 'Interaction Log E&ntries';
                ApplicationArea = all;
                trigger OnAction()
                begin

                    //+REF+CRM
                    rec.fShowDocumentInteraction(Rec);
                    //+REF+CRM//
                end;
            }
            /*GL2024 action("Reception Achat")
             {
                 ApplicationArea = all;
                 Caption = 'Purchase receipt';
                 //DYS page addon non migrer
                 // RunObject = Page 8003949;
                 // RunPageLink = "Document Type" = FIELD("Document Type"),
                 //                   "No." = FIELD("No.");
             }*/
        }
        addafter("Post_Promoted")
        {
            actionref("ValiderReceip"; "Valider")
            {

            }


        }
        addafter(Approvals_Promoted)
        {
            actionref(Description1; Description)
            {

            }
            actionref("Interaction Log E&ntries1"; "Interaction Log E&ntries")
            {

            }

        }

        addafter(PostedPrepaymentCrMemos)
        {
            action("E&tats")
            {
                Caption = 'E&tats';
                ApplicationArea = all;
                trigger OnAction()
                VAR
                    lReportList: Record ReportList;
                    lId: Integer;
                    lRecRef: RecordRef;
                BEGIN

                    WITH lReportList DO BEGIN
                        EVALUATE(lId, COPYSTR(CurrPage.OBJECTID(FALSE), 6));
                        lRecRef.GETTABLE(Rec);
                        lRecRef.SETRECFILTER;
                        SetRecordRef(lRecRef, TRUE);
                        ShowList(lId);

                    end;
                end;
            }
        }

        modify(Release)
        {


            trigger OnBeforeAction()
            var
                CduSoro: Codeunit "Soroubat cdu";

                lNaviBatSetup: Record NavibatSetup;

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
                // >> HJ SORO 15-01-2015
                /*{
                // RB SORO 07/05/2015 Rectification suite à la modification Entete Achat : Appliquer FODEC 
                // meme si RecVendor."Vendor Posting Group"<>'LOCALFODEC'
                RecPurchaseLine.RESET;
                                RecPurchaseLine.SETRANGE("Document Type", "Document Type");
                                RecPurchaseLine.SETRANGE("Document No.", "No.");
                                RecPurchaseLine.SETRANGE("Apply Fodec", TRUE);
                                IF RecPurchaseLine.FINDFIRST THEN BEGIN
                                    IF RecVendor.GET("Buy-from Vendor No.") THEN
                                        IF RecVendor."Vendor Posting Group" <> 'LOCALFODEC' THEN ERROR(Text011);
                                    IF "Vendor Posting Group" <> 'LOCALFODEC' THEN ERROR(Text011);
                                END
                }*/
                //RecPurchaseLine.SETRANGE(Type,RecPurchaseLine.Type::Item);



                // >> HJ SORO 16-10-2014

                //  CduSalesPost2.CalcBIC(Rec);
                // CduPurchpostevent.CalcFodec(Rec);
                // >> HJ SORO 16-10-2014

                // >> HJ SORO 15-01-2015
                RecPurchaseLine.RESET;
                RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                RecPurchaseLine.SETRANGE("Document No.", rec."No.");
                RecPurchaseLine.SETFILTER(Type, '<>%1', 0);

                //RecPurchaseLine.SETRANGE(Type,RecPurchaseLine.Type::Item);
                IF RecPurchaseLine.FINDFIRST THEN;
                REPEAT
                //GL2024     IF RecPurchaseLine."Job No." = '' THEN ERROR(Text009);
                //   CduSoro.VerifMateriauxChantier(RecPurchaseLine."dysJob No.", RecPurchaseLine."No.");
                UNTIL RecPurchaseLine.NEXT = 0;
                // >> HJ SORO 15-01-2015

                // >> HJ DSFT 18-10-2012

                rec.Approbateur := UPPERCASE(USERID);
                // >> HJ DSFT 18-10-2012
            end;

            trigger OnAfterAction()
            var
                lNaviBatSetup: Record NavibatSetup;
            begin


                // >> HJ SORO 09-01-2015
                RecPurchaseLine.RESET;
                RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                RecPurchaseLine.SETRANGE("Document No.", rec."No.");
                IF RecPurchaseLine.FINDFIRST THEN
                    REPEAT
                        RecPurchaseLine.Status := RecPurchaseLine.Status::Released;
                        RecPurchaseLine.MODIFY;
                    UNTIL RecPurchaseLine.NEXT = 0;
                // >> HJ SORO 09-01-2015






                //
                lNaviBatSetup.GET();

                //GL2024  rec."Posting Description" := rec.wPostingDescription;
                rec."Posting Description" := Format(rec."Document Type") + ' ' + rec."Pay-to Name" + ' - Affaire ' + rec."Job No.";


            end;
        }


        modify(Reopen)
        {
            trigger OnBeforeAction()
            begin
                /* IF UserSetup.GET(UPPERCASE(USERID)) THEN;
                 IF NOT UserSetup."Reouvrir DOC Achat" THEN ERROR(Text007);*/
            end;

            trigger OnAfterAction()
            begin
                // >> HJ SORO 09-01-2015
                rec.Synchronise := FALSE;
                rec.MODIFY;
                RecPurchaseLine.RESET;
                RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                RecPurchaseLine.SETRANGE("Document No.", rec."No.");
                IF RecPurchaseLine.FINDFIRST THEN
                    REPEAT
                        // RecPurchaseLine.Status := RecPurchaseLine.Status::Open;
                        RecPurchaseLine.Synchronise := FALSE;
                        RecPurchaseLine.MODIFY;
                    UNTIL RecPurchaseLine.NEXT = 0;
                // >> HJ SORO 09-01-2015
            end;
        }

        modify(Post)
        {
            //Visible = false;
            trigger OnBeforeAction()
            var
                Txt0001: Label 'N° B.L. fournisseur est obligatoire';



            begin
                rec."Posting Description" := Format(rec."Document Type") + ' ' + rec."Pay-to Name" + ' - Affaire ' + rec."Job No.";


                if Rec."Vendor Shipment No." = '' then
                    Error(Txt0001);
                // MH SORO 08-05-2021
                IF RecUserSetup3.GET(UPPERCASE(USERID)) THEN;


                // >> HJ DSFT 03-10-2012
                RecPurchaseLine.RESET;
                IF UserSetup.GET(UPPERCASE(USERID)) THEN;
                /*  IF UserSetup."Filtre Magasin" <> '' THEN BEGIN
                      RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                      RecPurchaseLine.SETRANGE("Document No.", rec."No.");
                      RecPurchaseLine.SETRANGE(Type, RecPurchaseLine.Type::Item);
                      RecPurchaseLine.SETFILTER("Qty. to Receive", '<>%1', 0);
                      IF RecPurchaseLine.FINDFIRST THEN
                          REPEAT
                              IF RecPurchaseLine."Location Code" <> UserSetup."Filtre Magasin" THEN
                                  ERROR(Text010, UserSetup."Filtre Magasin", RecPurchaseLine."Line No.", RecPurchaseLine."No.", RecPurchaseLine."Location Code");
                          UNTIL RecPurchaseLine.NEXT = 0;
                  END;*/
                // >> HJ DSFT 03-10-2012

                // >> HJ 06-02-2014
                RecPurchaseLine.RESET;
                RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                RecPurchaseLine.SETRANGE("Document No.", rec."No.");
                IF RecPurchaseLine.FINDFIRST THEN
                    IF RecPurchaseLine."Ancien Groupe Cpt Marche TVA" <> '' THEN
                        IF RecPurchaseLine."VAT Bus. Posting Group" <> RecPurchaseLine."Ancien Groupe Cpt Marche TVA" THEN
                            ERROR(Text005, RecPurchaseLine."Ancien Groupe Cpt Marche TVA", RecPurchaseLine."VAT Bus. Posting Group");
                // >> HJ 06-02-2014
                // >> HJ SORO 15-01-2015
                RecPurchaseLine.RESET;
                RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                RecPurchaseLine.SETRANGE("Document No.", rec."No.");
                RecPurchaseLine.SetRange("DYSJob Task No.", '');
                RecPurchaseLine.SetFilter(Type, '<>%1', RecPurchaseLine.Type::" ");
                IF RecPurchaseLine.FINDFIRST THEN
                    Error('N° tâche du travail non renseigné sur les lignes de la commande. Veuillez le renseigner avant de valider la réception.');

                RecPurchaseLine.RESET;
                RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                RecPurchaseLine.SETRANGE("Document No.", rec."No.");
                IF RecPurchaseLine.FINDFIRST THEN
                    REPEAT
                        IF RecPurchaseLine."dysJob No." = '' THEN ERROR(Text009);
                    UNTIL RecPurchaseLine.NEXT = 0;

                RecPurchaseLine.RESET;
                RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                RecPurchaseLine.SETRANGE("Document No.", rec."No.");
                RecPurchaseLine.SetFilter(Type, '<>%1', RecPurchaseLine.Type::" ");
                IF RecPurchaseLine.FINDFIRST THEN
                    REPEAT
                        RecPurchaseLine.TestField("Location Code");
                    UNTIL RecPurchaseLine.NEXT = 0;
                // >> HJ SORO 15-01-2015

                //+REF+FACTURATION_ACHAT
                PurchSetup.GET;
                IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                    CurrPage.PurchLines.PAGE.ApproveCalcInvDisc();
                    COMMIT;
                END;

            end;
        }
        addfirst("P&osting")
        {
            action("Valider")
            {
                Visible = false;
                ApplicationArea = all;
                Caption = 'Valider';
                // Promoted = true;
                // PromotedIsBig = true;
                // PromotedCategory = Process;
                Ellipsis = true;
                Image = PostOrder;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                var
                    Txt0001: Label 'N° B.L. fournisseur est obligatoire';
                begin
                    if Rec."Vendor Shipment No." = '' then
                        Error(Txt0001);
                    PostDocumentDys(CODEUNIT::"Purch.-Post (Yes/No)Dys", Enum::"Navigate After Posting"::"Posted Document");
                end;
            }

        }
        addafter(CalculateInvoiceDiscount)
        {
            group("Create &Interaction")
            {
                Caption = 'Create &Interaction';


                action("Buy-from")
                {
                    Caption = 'Buy-from';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        //+REF+CRM
                        rec.fCreateInteraction(rec."Buy-from Vendor No.", rec."No.");
                        //+REF+CRM//

                    end;
                }
                action("Pay-to Vendor")
                {
                    Caption = 'Pay-to Vendor';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        //+REF+CRM
                        rec.fCreateInteraction(rec."Pay-to Vendor No.", rec."No.");
                        //+REF+CRM//

                    end;
                }
            }
        }
        addafter(CalculateInvoiceDiscount_Promoted)
        {
            group("Create &Interaction1")
            {
                Caption = 'Create &Interaction';
                actionref("Buy-from1"; "Buy-from")
                {

                }
                actionref("Pay-to Vendor1"; "Pay-to Vendor")
                {

                }
            }
        }
        addfirst("P&osting")
        {
            action("AppliquerFTRS")
            {
                ApplicationArea = all;
                Caption = 'Appliquer FODEC';
                //  Promoted = true;
                //  PromotedIsBig = true;
                //  PromotedCategory = Process;
                Visible = false;
                Ellipsis = true;
                Image = Apply;
                trigger OnAction()
                var
                begin
                    // Cdupurchpostevent.CalcTimbre(Rec);
                    // Cdupurchpostevent.CalcFodec(Rec);

                end;
            }
        }

        addafter(MoveNegativeLines)
        {
            action("Close Order")
            {

                Caption = 'Close Order';
                ApplicationArea = all;
                trigger OnAction()
                begin
                    fCompletelyReceived;
                end;
            }
            action("En Cours de Verification")
            {
                Caption = 'En Cours de Verification';
                Visible = false;
                ApplicationArea = all;
                trigger OnAction()
                begin

                    // >> HJ SORO 24-2014
                    rec.Status := rec.Status::"En Cours De Verification";
                    rec.MODIFY;
                    // >> HJ SORO 24-2014
                end;
            }
            action(Reclamation)
            {
                Caption = 'Reclamation';
                ApplicationArea = all;
                Visible = false;
                trigger OnAction()
                begin

                    // >> HJ SORO 24-2014
                    rec.Status := rec.Status::Reclamation;
                    rec.MODIFY;
                    // >> HJ SORO 24-2014
                end;
            }
            action("Delete Order")
            {

                Caption = 'Delete Order';
                ApplicationArea = All;
                Visible = false;
                trigger OnAction()
                var
                    lPurchHeader: Record "Purchase Header";
                    lDeleteInvOrder: Report "Delete Invoiced Purch. Orders";
                begin

                    //ACHAT
                    lPurchHeader.COPY(Rec);
                    lPurchHeader.SETRECFILTER;
                    lDeleteInvOrder.SETTABLEVIEW(lPurchHeader);
                    //GL2024 lDeleteInvOrder.USEREQUESTFORM(TRUE);
                    lDeleteInvOrder.RUN;
                    CurrPage.UPDATE;
                    //ACHAT//
                end;
            }
        }
        addafter(MoveNegativeLines_Promoted)
        {

            actionref("En Cours de Verification1"; "En Cours de Verification")
            {

            }
            actionref(Reclamation1; Reclamation)
            {

            }
            actionref("Delete Order1"; "Delete Order")
            {

            }
        }

        addafter(Print)
        {
            group("&Line")
            {
                Caption = '&Line';
                Visible = ModifCommandeachat;

                action("&Affectation frais annexes")
                {
                    Caption = '&Affectation frais annexes';
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        RecLPurchaseLine: Record "Purchase Line";
                    begin

                        // >> HJ DSFT 05-10-2012
                        rec.TESTFIELD("N° Dossier");
                        RecLPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                        RecLPurchaseLine.SETRANGE("Document No.", rec."No.");
                        RecLPurchaseLine.SETRANGE(Type, RecLPurchaseLine.Type::"Charge (Item)");
                        RecLPurchaseLine.MODIFYALL("N° Dossier", rec."N° Dossier");
                        // >> HJ DSFT 05-10-2012
                        //DYS a verifier
                        //CurrPAGE.PurchLines.PAGE.ItemChargeAssgnt;
                    end;
                }
                action(Description2)
                {
                    Caption = 'Description 2';
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnAction()
                    begin

                        fShowDescription;
                    end;
                }
                action(WorkFlowBtn)
                {
                    Caption = 'Wor&Kflow';
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnAction()
                    var
                        lRecordRef: RecordRef;
                        lWorkflowConnector: Codeunit "Workflow Connector";
                    begin

                        lRecordRef.GETTABLE(Rec);
                        lWorkflowConnector.OnPush(PAGE::"Purchase Order", lRecordRef);
                    end;
                }
            }
            action("Basculer TVA")
            {
                Caption = 'Basculer TVA';
                ApplicationArea = All;
                trigger OnAction()
                begin

                    // >> HJ DSFT 10-10-2012
                    IntChoix := STRMENU(Text004);
                    IF RecPurchasesPayablesSetup.GET THEN;
                    //IF Status=Status::Released THEN Status:=Status::Open;
                    CdeOldGroupeCptMarcheTVA := rec."VAT Bus. Posting Group";
                    IF IntChoix = 1 THEN BEGIN
                        RecPurchaseLine.RESET;
                        RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                        RecPurchaseLine.SETRANGE("Document No.", rec."No.");
                        IF RecPurchaseLine.FINDFIRST THEN
                            REPEAT
                                RecPurchaseLine.VALIDATE("VAT Bus. Posting Group", RecPurchasesPayablesSetup."Groupe Compta Marche TVA");
                                RecPurchaseLine."Ancien Groupe Cpt Marche TVA" := CdeOldGroupeCptMarcheTVA;
                                RecPurchaseLine.MODIFY;
                            UNTIL RecPurchaseLine.NEXT = 0;
                    END;
                    IF IntChoix = 2 THEN BEGIN
                        RecPurchaseLine.RESET;
                        RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                        RecPurchaseLine.SETRANGE("Document No.", rec."No.");
                        IF RecPurchaseLine.FINDFIRST THEN
                            REPEAT
                                RecPurchaseLine.VALIDATE("VAT Bus. Posting Group", CdeOldGroupeCptMarcheTVA);
                                RecPurchaseLine."Ancien Groupe Cpt Marche TVA" := CdeOldGroupeCptMarcheTVA;
                                RecPurchaseLine.MODIFY;
                            UNTIL RecPurchaseLine.NEXT = 0;
                    END;
                    // >> HJ DSFT 10-10-2012
                    // STD HJ DSFT 10-10-2012 DocPrint.PrintPurchHeader(Rec);

                end;
            }
            action("&TestPrint")
            {
                Caption = '&TestPrintA4';
                ApplicationArea = All;
                Visible = false;

                trigger OnAction()
                begin

                    // >> HJ DSFT 10-10-2012

                    IF CompanyInfo.GET() THEN;
                    IF rec.Status <> rec.Status::Released THEN ERROR(Text003);
                    RecPurchaseOrder.SETRANGE("Document Type", rec."Document Type");
                    RecPurchaseOrder.SETRANGE("No.", rec."No.");
                    //  IF CompanyInfo.Name = 'SOROUBAT' THEN REPORT.RUNMODAL(REPORT::"BON COMMANDE Test a4", TRUE, TRUE, RecPurchaseOrder);
                    IF CompanyInfo.Name = 'SOTIDEX' THEN REPORT.RUNMODAL(REPORT::"Liste des tombés d'échéance V2", TRUE, TRUE, RecPurchaseOrder);
                    // >> HJ DSFT 10-10-2012
                    // STD HJ DSFT 10-10-2012 DocPrint.PrintPurchHeader(Rec);
                end;
            }
            action("&Print2")
            {
                Caption = '&Print Format A4';
                ApplicationArea = All;
                Visible = false;

                trigger OnAction()
                begin

                    // >> HJ DSFT 10-10-2012

                    IF CompanyInfo.GET() THEN;
                    IF rec.Status <> rec.Status::Released THEN ERROR(Text003);
                    RecPurchaseOrder.SETRANGE("Document Type", rec."Document Type");
                    RecPurchaseOrder.SETRANGE("No.", rec."No.");
                    IF CompanyInfo.Name = 'SOROUBAT' THEN REPORT.RUNMODAL(REPORT::"Bon Commande Format A4", TRUE, TRUE, RecPurchaseOrder);
                    IF CompanyInfo.Name = 'SOTIDEX' THEN REPORT.RUNMODAL(REPORT::"Liste des tombés d'échéance V2", TRUE, TRUE, RecPurchaseOrder);
                    // >> HJ DSFT 10-10-2012
                    // STD HJ DSFT 10-10-2012 DocPrint.PrintPurchHeader(Rec);
                end;
            }
            action("&Print3")
            {
                Caption = 'Print';
                ApplicationArea = all;
                // Promoted = true;
                // PromotedIsBig = true;
                // PromotedCategory = Report;
                Image = Print;
                trigger OnAction()
                var
                    CompanyInfo: Record "Company Information";
                    RecPurchaseOrder: Record 38;
                    Text003: Label 'Statut doit être "Lancé" ';
                begin

                    // >> HJ DSFT 10-10-2012
                    IF CompanyInfo.GET() THEN;
                    IF rec.Status <> rec.Status::Released THEN ERROR(Text003);
                    RecPurchaseOrder.SETRANGE("Document Type", rec."Document Type");
                    RecPurchaseOrder.SETRANGE("No.", rec."No.");
                    REPORT.RUNMODAL(REPORT::"BON COMMANDE SOUROUBAT", TRUE, TRUE, RecPurchaseOrder);

                end;
            }


        }
        addafter(Category_Category10)
        {



            group("Line")
            {
                Visible = ModifCommandeachat;
                Caption = '&Line';
                actionref(Description21; Description2)
                {

                }





                actionref("&Print21"; "&Print2")
                {

                }
            }
        }
        modify("Archive Document")
        {
            trigger OnbeforeAction()
            begin
                rec.Status := rec.Status::Archived;
                rec.MODIFY;
            end;
        }

        addafter("Test Report")
        {
            action("Valider réception")
            {

                Caption = 'Post Receipt';
                ApplicationArea = all;
                trigger OnAction()
                begin

                    // MH SORO 08-05-2021
                    IF RecUserSetup3.GET(UPPERCASE(USERID)) THEN;
                    RecPurchaseLine3.RESET;
                    RecPurchaseLine3.SETRANGE("Document No.", rec."No.");
                    RecPurchaseLine3.SETRANGE("Location Code", 'DEPOT Z4');
                    /*IF RecPurchaseLine3.FINDFIRST THEN
                        IF RecUserSetup3."Autoriser Réception Magasin Z4" = FALSE THEN ERROR(Text015);*/
                    // MH SORO 08-05-2021

                    // >> HJ DSFT 03-10-2012
                    RecPurchaseLine.RESET;
                    IF UserSetup.GET(UPPERCASE(USERID)) THEN;
                    /*  IF UserSetup."Filtre Magasin" <> '' THEN BEGIN
                          RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                          RecPurchaseLine.SETRANGE("Document No.", rec."No.");
                          RecPurchaseLine.SETRANGE(Type, RecPurchaseLine.Type::Item);
                          RecPurchaseLine.SETFILTER("Qty. to Receive", '<>%1', 0);
                          IF RecPurchaseLine.FINDFIRST THEN
                              REPEAT
                                  IF RecPurchaseLine."Location Code" <> UserSetup."Filtre Magasin" THEN
                                      ERROR(Text010, UserSetup."Filtre Magasin", RecPurchaseLine."Line No.", RecPurchaseLine."No.", RecPurchaseLine."Location Code");
                              UNTIL RecPurchaseLine.NEXT = 0;
                      END;*/
                    // >> HJ DSFT 03-10-2012

                    // >> HJ 06-02-2014
                    RecPurchaseLine.RESET;
                    RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                    RecPurchaseLine.SETRANGE("Document No.", rec."No.");
                    IF RecPurchaseLine.FINDFIRST THEN
                        IF RecPurchaseLine."Ancien Groupe Cpt Marche TVA" <> '' THEN
                            IF RecPurchaseLine."VAT Bus. Posting Group" <> RecPurchaseLine."Ancien Groupe Cpt Marche TVA" THEN
                                ERROR(Text005, RecPurchaseLine."Ancien Groupe Cpt Marche TVA", RecPurchaseLine."VAT Bus. Posting Group");
                    // >> HJ 06-02-2014
                    // >> HJ SORO 15-01-2015
                    RecPurchaseLine.RESET;
                    RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                    RecPurchaseLine.SETRANGE("Document No.", rec."No.");
                    IF RecPurchaseLine.FINDFIRST THEN
                        REPEAT
                            IF RecPurchaseLine."dysJob No." = '' THEN ERROR(Text009);
                        UNTIL RecPurchaseLine.NEXT = 0;
                    // >> HJ SORO 15-01-2015

                    //+REF+FACTURATION_ACHAT
                    PurchSetup.GET;
                    IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc();
                        COMMIT;
                    END;
                    gPurchPost.InitRequest(FALSE, TRUE);
                    gPurchPost.RUN(Rec);
                    //+REF+FACTURATION_ACHAT//
                    //>> HJ SORO 29-01-2015
                    RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                    RecPurchaseLine.SETRANGE("Document No.", rec."No.");
                    RecPurchaseLine.SETRANGE(Type, RecPurchaseLine.Type::Item);
                    IF RecPurchaseLine.FINDFIRST THEN
                        REPEAT
                            RecPurchaseLine.VALIDATE("Qty. to Receive", 0);
                            RecPurchaseLine.MODIFY;
                        UNTIL RecPurchaseLine.NEXT = 0;
                    //>> HJ SORO 29-01-2015
                end;
            }
            action("&Valider facture")
            {

                Caption = 'P&ost Invoice';
                ApplicationArea = all;
                trigger OnAction()
                begin

                    //+REF+ACHAT
                    // >> HJ 06-02-2014
                    IF UserSetup.GET(UPPERCASE(USERID)) THEN;
                    // IF NOT UserSetup."Validation Commande Achat" THEN ERROR(Text008);

                    RecPurchaseLine.RESET;
                    RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                    RecPurchaseLine.SETRANGE("Document No.", rec."No.");
                    IF RecPurchaseLine.FINDFIRST THEN
                        IF RecPurchaseLine."Ancien Groupe Cpt Marche TVA" <> '' THEN
                            IF RecPurchaseLine."VAT Bus. Posting Group" <> RecPurchaseLine."Ancien Groupe Cpt Marche TVA" THEN
                                ERROR(Text005, RecPurchaseLine."Ancien Groupe Cpt Marche TVA", RecPurchaseLine."VAT Bus. Posting Group");
                    // >> HJ 06-02-2014
                    // >> HJ SORO 15-01-2015
                    RecPurchaseLine.RESET;
                    RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                    RecPurchaseLine.SETRANGE("Document No.", rec."No.");
                    RecPurchaseLine.SETFILTER("No.", '<>%1', '');
                    IF RecPurchaseLine.FINDFIRST THEN
                        REPEAT
                            IF RecPurchaseLine."dysJob No." = '' THEN ERROR(Text009);
                        UNTIL RecPurchaseLine.NEXT = 0;
                    // >> HJ SORO 15-01-2015
                    PurchSetup.GET;
                    IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc();
                        COMMIT;
                    END;
                    gPurchPost.InitRequest(FALSE, FALSE);
                    gPurchPost.RUN(Rec);
                    //+REF+ACHAT//
                end;
            }
        }

        addafter("Post &Batch_Promoted")
        {
            actionref("Valider réception1"; "Valider réception")
            {

            }
            actionref("&Valider facture1"; "&Valider facture")
            {

            }
        }
        addafter("&Print_Promoted")
        {
            actionref("&Print2Ref"; "&Print2")
            {

            }
            actionref("&Print3Ref"; "&Print3")
            {

            }

        }

        addafter(Category_Category6)
        {
            actionref(AppliquerFTRS1; AppliquerFTRS)
            {

            }

        }
        modify("&Print")
        {
            Visible = false;
            trigger OnbeforeAction()
            var
                PurchaseHeader: Record "Purchase Header";
            begin
                // >> HJ DSFT 10-10-2012
                IntChoix := STRMENU(Text004);
                IF RecPurchasesPayablesSetup.GET THEN;
                //IF Status=Status::Released THEN Status:=Status::Open;
                CdeOldGroupeCptMarcheTVA := rec."VAT Bus. Posting Group";
                IF IntChoix = 1 THEN BEGIN
                    RecPurchaseLine.RESET;
                    RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                    RecPurchaseLine.SETRANGE("Document No.", rec."No.");
                    IF RecPurchaseLine.FINDFIRST THEN
                        REPEAT
                            RecPurchaseLine.VALIDATE("VAT Bus. Posting Group", RecPurchasesPayablesSetup."Groupe Compta Marche TVA");
                            RecPurchaseLine."Ancien Groupe Cpt Marche TVA" := CdeOldGroupeCptMarcheTVA;
                            RecPurchaseLine.MODIFY;
                        UNTIL RecPurchaseLine.NEXT = 0;
                END;
                IF IntChoix = 2 THEN BEGIN
                    RecPurchaseLine.RESET;
                    RecPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                    RecPurchaseLine.SETRANGE("Document No.", rec."No.");
                    IF RecPurchaseLine.FINDFIRST THEN
                        REPEAT
                            RecPurchaseLine.VALIDATE("VAT Bus. Posting Group", CdeOldGroupeCptMarcheTVA);
                            RecPurchaseLine."Ancien Groupe Cpt Marche TVA" := CdeOldGroupeCptMarcheTVA;
                            RecPurchaseLine.MODIFY;
                        UNTIL RecPurchaseLine.NEXT = 0;
                END;
                // >> HJ DSFT 10-10-2012
                /*     IF rec.Status <> rec.Status::Released THEN ERROR(Text003);
                     RecPurchaseOrder.SETRANGE("Document Type", rec."Document Type");
                     RecPurchaseOrder.SETRANGE("No.", rec."No.");*/
                // REPORT.RUNMODAL(REPORT::"BON COMMANDE SOUROUBAT 03", TRUE, TRUE, RecPurchaseOrder);
                // >> HJ DSFT 10-10-2012
                // STD HJ DSFT 10-10-2012 

            end;
        }


    }

    trigger OnOpenPage()
    VAR
        UserMgt: Codeunit "User Setup Management";
    BEGIN
        //HS
        /* IF RecUserSetup.GET(UPPERCASE(USERID)) THEN;
         CurrPage.EDITABLE(RecUserSetup."Modif commande Achat");
         ModifCommandeachat := RecUserSetup."Modif commande Achat";*/

        Rec.FilterGroup(0);
        IF UserMgt.GetPurchasesFilter() <> '' THEN
            rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());

        Rec.SetFilter("Document Type", '%1', Rec."Document Type"::Order);
        Rec.SetFilter("Status", '<>%1', Rec."Status"::Archived);
        // Rec.SetRange(Contrat, false);
        Rec.FilterGroup(2);

        EDITABLEStatus2();





    END;



    trigger OnAfterGetRecord()
    begin

        rec.SETRANGE("Document Type");
        //POSTING_DESC
        wDescr := rec.wShowPostingDescription(rec."Posting Description");
        //POSTING_DESC//
        //ACHATS
        //DYS fonction commenté dans NAV
        // PurchInfoPaneMgmt.gGetAddress(Rec, gAddress);
        //ACHATS//

        // RB SORO 20/04/2015
        /*{
        IF RecUserSetup.GET(USERID) THEN;
        IF RecUserSetup."Filtre Magasin"= "Location Code" THEN
           CurrForm."Location Code".EDITABLE(TRUE)
        ELSE
           CurrForm."Location Code".EDITABLE(FALSE);
        }*/
        // RB SORO 20/04/2015


        EDITABLEStatus2();

    end;

    trigger OnAfterGetCurrRecord()
    begin
        EDITABLEStatus2();

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //#6695
        rec."Document Type" := rec."Document Type"::Order;
        //ACHATS
        IF (rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No.") OR (rec."Order Address Code" <> xRec."Order Address Code") THEN;
        //  PurchInfoPaneMgmt.gGetAddress(Rec, gAddress);
        //ACHATS//
        //#6695//
    end;

    /*GL2024  trigger OnModifyRecord(): Boolean
      begin

          IF rec.Status <> rec.Status::Open THEN ERROR(Text006);
          //ACHATS
          //DYS fonction commenté dans NAV
          //IF (rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No.") OR (rec."Order Address Code" <> xRec."Order Address Code") THEN
          //  PurchInfoPaneMgmt.gGetAddress(Rec, gAddress);
          //ACHATS//
      end;*/

    local PROCEDURE EDITABLEStatus2();
    begin
        if rec.Status = rec.Status::Released then
            EditableStatus := false
        else
            EditableStatus := true;


    end;

    PROCEDURE fOpenSalesOrderForm();
    BEGIN
        //RTC-2009
        //DYS a verifier
        //CurrPage.PurchLines.PAGE.OpenSalesOrderForm;
        //RTC-2009//
    END;

    PROCEDURE fOpenSpecSalesOrderForm();
    BEGIN
        //RTC-2009
        //DYS a verifier
        // CurrPage.PurchLines.PAGE.OpenSpecOrderSalesOrderForm;
        //RTC-2009//
    END;

    PROCEDURE fExplodeBOM();
    BEGIN
        //RTC-2009
        //DYS a verifier
        // CurrPage.PurchLines.PAGE.ExplodeBOM;
        //RTC-2009//
    END;

    PROCEDURE fInsertExtendedText();
    BEGIN
        //RTC-2009
        CurrPage.PurchLines.PAGE.InsertExtendedText(TRUE);
        //RTC-2009//
    END;

    PROCEDURE fShowReserve();
    BEGIN
        //RTC-2009
        //DYS a verifier
        // Currpage.PurchLines.page.ShowReservation;
        //RTC-2009//
    END;



    PROCEDURE fShowTracking();
    BEGIN
        //RTC-2009
        CurrPage.PurchLines.PAGE.ShowTracking;
        //RTC-2009//
    END;

    PROCEDURE fCompletelyReceived();
    BEGIN
        //RTC-2009
        //+REF+SOLDE_CDE
        Currpage.PurchLines.PAGE.fCompletelyReceived;

        //+REF+SOLDE_CDE//
        //RTC-2009//
    END;

    PROCEDURE fItmAvailPeriod();
    BEGIN
        //RTC-2009
        //DYS a verifier
        //   Currpage.PurchLines.page.ItemAvailability(0);
        //RTC-2009//
    END;

    PROCEDURE fItmAvailVariante();
    BEGIN
        //RTC-2009
        //DYS a verifier
        //Currpage.PurchLines.page.ItemAvailability(1);
        //RTC-2009//
    END;

    PROCEDURE fItmAvailWksp();
    BEGIN
        //RTC-2009
        //DYS a verifier
        //Currpage.PurchLines.page.ItemAvailability(2);
        //RTC-2009//
    END;

    PROCEDURE fReservationEntries();
    BEGIN
        //RTC-2009
        //DYS a verifier
        // Currpage.PurchLines.page.ShowReservationEntries;
        //RTC-2009//
    END;

    PROCEDURE fOpenItmTrackingLines();
    BEGIN
        //RTC-2009
        //DYS a verifier
        // Currpage.PurchLines.page.OpenItemTrackingLines;
        //RTC-2009//
    END;

    PROCEDURE fShowDimensions();
    BEGIN
        //RTC-2009
        //DYS a verifier
        // Currpage.PurchLines.page.ShowDimensions;
        //RTC-2009//
    END;

    PROCEDURE fShowLineComments();
    BEGIN
        //RTC-2009
        //DYS a verifier
        //Currpage.PurchLines.page.ShowLineComments;
        //RTC-2009//
    END;

    PROCEDURE fItemChargeAssgnt();
    BEGIN
        //RTC-2009
        //DYS a verifier
        //Currpage.PurchLines.page.ItemChargeAssgnt;
        //RTC-2009//
    END;

    PROCEDURE fShowDescription();
    BEGIN
        //RTC-2009
        //OUVRAGE
        Currpage.PurchLines.page.wShowDescription;
        //OUVRAGE//
        //RTC-2009//
    END;

    local procedure ShowPostedConfirmationMessage()
    var
        OrderPurchaseHeader: Record "Purchase Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        ICFeedback: Codeunit "IC Feedback";
    begin
        if not OrderPurchaseHeader.Get(Rec."Document Type", Rec."No.") then begin
            PurchInvHeader.SetRange("No.", Rec."Last Posting No.");
            if PurchInvHeader.FindFirst() then begin
                ICFeedback.ShowIntercompanyMessage(Rec, Enum::"IC Transaction Document Type"::Order);
                if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedPurchaseOrderQst, PurchInvHeader."No."),
                     InstructionMgt.ShowPostedConfirmationMessageCode())
                then
                    InstructionMgt.ShowPostedDocument(PurchInvHeader, Page::"Purchase Order");
            end;
        end;
    end;

    local procedure PostDocumentDys(PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting")
    var
        PurchaseHeader: Record "Purchase Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        IsScheduledPosting: Boolean;
        IsHandled: Boolean;
    begin
        LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

        Rec.SendToPosting(PostingCodeunitID);

        IsScheduledPosting := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        DocumentIsPosted := (not PurchaseHeader.Get(Rec."Document Type", Rec."No.")) or IsScheduledPosting;

        if IsScheduledPosting then
            CurrPage.Close();
        CurrPage.Update(false);

        IsHandled := false;
        //    OnPostDocumentBeforeNavigateAfterPosting(Rec, PostingCodeunitID, Navigate, DocumentIsPosted, IsHandled);
        if IsHandled then
            exit;

        if PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" then
            exit;

        case Navigate of
            Enum::"Navigate After Posting"::"Posted Document":
                begin
                    if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) then
                        ShowPostedConfirmationMessage();

                    if IsScheduledPosting or DocumentIsPosted then
                        CurrPage.Close();
                end;
            Enum::"Navigate After Posting"::"New Document":
                if DocumentIsPosted then begin
                    Clear(PurchaseHeader);
                    PurchaseHeader.Init();
                    PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Order);
                    //    OnPostDocumentOnBeforePurchaseHeaderInsert(PurchaseHeader);
                    PurchaseHeader.Insert(true);
                    PAGE.Run(PAGE::"Purchase Order", PurchaseHeader);
                end;
        end;
    end;

    var
        [InDataSet]
        ModifCommandeachat: Boolean;
        [InDataSet]
        EditableStatus: Boolean;

        gPurchPost: Codeunit "Purch. Order - Post";
        wDescr: Text[100];
        gAddress: Record "Order Address";
        "// HJ DSFT": Integer;
        RecPurchaseOrder: Record "Purchase Header";
        RecPurchaseLine: Record "Purchase Line";
        RecPurchasesPayablesSetup: Record "Purchases & Payables Setup";
        UserSetup: Record "User Setup";
        InventorySetup: Record "Inventory Setup";
        CduPurchasePost: Codeunit "Purch.-Post";
        CduSalesPost2: Codeunit SalesPostEvent;
        CdeOldGroupeCptMarcheTVA: Code[20];
        IntChoix: Integer;
        RecVendor: Record Vendor;
        CompanyInfo: Record "Company Information";
        "// // RB SORO 07/04/2015": Integer;
        RecVendorPostingGroup: Record "Vendor Posting Group";
        RecVendorFODEC: Record Vendor;
        RecUserSetup: Record "User Setup";
        Mail: Codeunit "Soroubat cdu";
        SalesContributor: Record "Sales Contributor";
        SalesHeader: Record "Sales Header";
        RecPurchaseLine3: Record "Purchase Line";
        RecUserSetup3: Record "User Setup";
        PurchInfoPaneMgmt: Codeunit "Purchases Info-Pane Management";
        Text001: Label 'There are non posted Prepayment Amounts on %1 %2.';
        Text002: Label 'There are unpaid Prepayment Invoices related to %1 %2. Do you wish to continue?';
        Text003: Label 'You must place the order before printing';
        Text004: Label 'VAT, exemption.';
        Text005: Label 'The accounting group market ... has been modified (old group %1, new group %2)';
        Text006: Label 'No modifications allowed, status not open.';
        Text007: Label 'You do not have the right to reopen purchase orders; please consult your administrator';
        Text008: Label 'You do not have the right to validate purchase orders; please consult your administrator';
        Text009: Label 'Affaire/Chantie Doit Etre Preciser';
        Text010: Label 'Your receiving store is %1; it is not the one in line %2, item %3, store %4';
        Text011: Label 'Supplier must be local Fodec';
        Text012: Label 'You cannot modify the store code; linked order... the quote no. %1';
        Text013: Label 'You do not have the right to cancel the printing';
        Text014: Label 'Printing completed successfully ?';
        Text015: Label 'You do not have the right to validate the receipt for store depot Z4';
        PurchSetup: Record "Purchases & Payables Setup";
        DocumentIsPosted: Boolean;
        OpenPostedPurchaseOrderQst: Label 'The order is posted as number %1 and moved to the Posted Purchase Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';
        [InDataSet]
        ModifierNoSeries: Boolean;
}
