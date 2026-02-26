PageExtension 50270 "Payment Slip_PagEXT" extends "Payment Slip"
{


    layout
    {
        addafter("Amount (LCY)")
        {

            field(Amount; rec.Amount)
            {
                ApplicationArea = all;

            }
            field("Account Type2"; rec."Account Type")
            {
                ApplicationArea = all;
            }
            field("<Account No.2>"; rec."Account No.")
            {
                ApplicationArea = all;
            }

            field("<Source Code2>"; rec."Source Code")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(Agence; rec.Agence)
            {
                ApplicationArea = all;
                trigger OnDrillDown()
                begin
                    //>> HJ DSFT 10 12 2010
                    IF RecPaymentStatus.GET(rec."Payment Class", rec."Status No.") THEN BEGIN
                        IF NOT RecPaymentStatus."Changement Agence Permis" THEN
                            EXIT
                        ELSE BEGIN
                            IF RecPaymentStatus."Changement Agence Par" <> UPPERCASE(USERID) THEN
                                ERROR(Text014)
                            ELSE BEGIN
                                IF PAGE.RUNMODAL(PAGE::Sites, RecAgence) = ACTION::LookupOK THEN BEGIN
                                    RecPaymentLine.SETRANGE("No.", rec."No.");
                                    RecPaymentLine.MODIFYALL(Agence, RecAgence.Code);
                                    rec.Agence := RecAgence.Code;
                                    rec.MODIFY;
                                END;

                            END;
                        END;
                    END;
                    //>> HJ DSFT 10 12 2010
                end;
            }
            field(Utilisateur; rec.Utilisateur)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Validé Par"; rec."Validé Par")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(Motif; rec.Motif)
            {
                ApplicationArea = all;
            }


            field(Objet; rec.Objet)
            {
                ApplicationArea = all;
            }

            field("Mois Echeance Crédit Bancaire"; rec."Mois Echeance Crédit Bancaire")
            {
                ApplicationArea = all;
            }
            field("Date Echeance à Comptabiliser"; rec."Date Echeance à Comptabiliser")
            {
                ApplicationArea = all;
            }
            field("N° Brouillard"; rec."N° Brouillard")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Mode Paiement"; rec."Mode Paiement")
            {
                ApplicationArea = all;
                Editable = false;
            }
            // field("Folio N°"; rec."Folio N°")
            // {
            //     ApplicationArea = all;
            // }
            field("N° Contrat"; rec."N° Contrat")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Bank Name"; rec."Bank Name")
            {
                ApplicationArea = all;

            }
            field("Bank Account No."; rec."Bank Account No.")
            {
                ApplicationArea = all;

            }


            /* field(Affectation; rec.Affectation)
             {
                 ApplicationArea = all;
                 trigger OnDrillDown()
                 begin
                     // RB SORO 29/08/2015
                     IF rec."Modifier Date Compta" THEN BEGIN
                         DetailPaieCaisse.SETRANGE("New Date", rec."Posting Date");
                         DetailPaieCaisse.SETRANGE(Code, rec.Agence);
                         DetailPaieCaisse.SETRANGE(Affectation, rec.Affectation);
                         PAGE.RUNMODAL(52049017, DetailPaieCaisse);
                     END
                     ELSE BEGIN
                         DetailPaieCaisse.SETRANGE(Journee, rec."Posting Date");
                         DetailPaieCaisse.SETRANGE(Code, rec.Agence);
                         DetailPaieCaisse.SETRANGE(Affectation, rec.Affectation);
                         PAGE.RUNMODAL(52049017, DetailPaieCaisse);
                     END;
                     // RB SORO 29/08/2015
                 end;
             }*/
            group("Autorisation Avance")
            {
                Caption = 'Autorisation Avance';
                Visible = AutorisationAvanceVISIBLE;

                field("Autoriser avance Fournisseur1"; rec."Autoriser avance Fournisseur")
                {
                    ApplicationArea = all;
                    Editable = false;
                    //  Visible = AutorisationAvanceVISIBLE;
                }
                field("Approuvé par"; rec."Approuvé par")
                {
                    ApplicationArea = all;
                    Editable = false;
                    // Visible = AutorisationAvanceVISIBLE;
                }
                field("Date Approbation"; rec."Date Approbation")
                {
                    ApplicationArea = all;
                    Editable = false;
                    //  Visible = AutorisationAvanceVISIBLE;
                }
            }
        }

        modify("Partner Type")
        {
            Visible = false;
        }
        addafter("Partner Type")
        {
            field(TxtEtapesSuivante; TxtEtapesSuivante)
            {
                ApplicationArea = all;
                ShowCaption = false;
            }
        }
        modify("Account Type")
        {
            Visible = false;
        }
        modify("Account No.")
        {
            Visible = false;
        }

        addafter("Account No.")
        {
            field("Currency Code2"; rec."Currency Code")
            {
                ApplicationArea = all;
            }
            field(Presentation; rec.Presentation)
            {
                ApplicationArea = all;
            }
            group("Brouillard de caisse")
            {
                Caption = 'Brouillard de caisse';
                field("N° Caisse"; rec."N° Caisse")
                {
                    ApplicationArea = all;
                    Editable = false;

                    /* trigger OnAssistEdit()
                     var
                         RecLPaymentLine: Record "Payment Line";
                     begin

                         // RB SORO 22/05/2017
                         RecLineCaisse.RESET;
                         RecLineCaisse.SETRANGE(Chrono, rec."No.");
                         IF RecLineCaisse.FINDFIRST THEN BEGIN
                             RecLineCaisse.Chrono := '';
                             RecLineCaisse.MODIFY;
                         END;
                         // RB SORO 22/05/2017
                         rec."N° Sequence Caisse" := '';
                         rec."N° Caisse" := '';
                         rec."Montant Brouillard" := 0;
                         rec.MODIFY;
                         CurrPage.Update(false);

                     end;

                     trigger OnDrillDown()
                     Var
                         RecLPaymentLine: Record "Payment Line";
                     begin

                         IF PAGE.RUNMODAL(PAGE::"Ligne Caisse Brouillard", RecLPaymentLine) = ACTION::LookupOK THEN BEGIN
                             rec."N° Sequence Caisse" := RecLPaymentLine."Numero Seq";
                             rec."N° Caisse" := RecLPaymentLine."No.";
                             IF RecLPaymentLine."Credit Amount" <> 0 THEN
                                 rec."Montant Brouillard" := RecLPaymentLine."Credit Amount"
                             ELSE
                                 rec."Montant Brouillard" := -(RecLPaymentLine."Debit Amount");
                             rec.VALIDATE("Posting Date", RecLPaymentLine."Due Date");
                             rec."Document Date" := RecLPaymentLine."Due Date";
                             rec.MODIFY;
                             // RB SORO 22/05/2017
                             RecLineCaisse.RESET;
                             RecLineCaisse.SETRANGE("No.", RecLPaymentLine."No.");
                             RecLineCaisse.SETRANGE("Numero Seq", RecLPaymentLine."Numero Seq");
                             IF RecLineCaisse.FINDFIRST THEN BEGIN
                                 RecLineCaisse.Chrono := rec."No.";
                                 RecLineCaisse.MODIFY;
                             END;
                             // RB SORO 22/05/2017
                         end;
                         CurrPage.Update(false);
                     end;*/
                }
                field("N° Sequence Caisse"; rec."N° Sequence Caisse")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Montant Brouillard"; rec."Montant Brouillard")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Ecart; rec.Ecart)
                {
                    ApplicationArea = all;
                    Editable = false;
                }

            }
        }

        addafter(Posting)
        {
            group("Lettre De Crédit")
            {
                Caption = 'Letter of Credit';
                field("N° CI"; rec."N° CI")
                {
                    ApplicationArea = all;
                }
                field("DATE D'EMBARQUEMENT"; rec."DATE D'EMBARQUEMENT")
                {
                    ApplicationArea = all;

                }
                field("DATE D'EXPIRATION"; rec."DATE D'EXPIRATION")
                {
                    ApplicationArea = all;
                }
                field("CONDITION DE VENTE"; rec."CONDITION DE VENTE")
                {
                    ApplicationArea = all;
                }
                field("PORT EMBARQUEMENT"; rec."PORT EMBARQUEMENT")
                {
                    ApplicationArea = all;
                }
                field("PORT DEBARQUEMENT"; rec."PORT DEBARQUEMENT")
                {
                    ApplicationArea = all;
                }
                field("Mode Echéance"; rec."Mode Echéance")
                {
                    ApplicationArea = all;
                }
                field("Objet Lettre"; rec."Objet Lettre")
                {
                    ApplicationArea = all;
                }
                field("<N° Brouillard2>"; rec."N° Brouillard")
                {
                    ApplicationArea = all;
                }
                field(Destinataire; rec.Destinataire)
                {
                    ApplicationArea = all;
                }
                field("Tomber FED"; rec."Tomber FED")
                {
                    ApplicationArea = all;
                }
            }
            group(Placement)
            {
                Caption = 'Placement';
                field(TAUX; rec.TAUX)
                {
                    ApplicationArea = all;
                }
                field(Durée; rec.Durée)
                {
                    ApplicationArea = all;
                }
                field("Comm Bancaire"; rec."Comm Bancaire")
                {
                    ApplicationArea = all;
                }
                field(Bénéficiaire; rec.Bénéficiaire)
                {
                    ApplicationArea = all;
                }
                field(Période; rec.Période)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {

        addafter(Archive)
        {
            action("Calcul Base Montant")
            {
                Caption = 'Calcul Base Montant';
                ApplicationArea = all;

                trigger OnAction()
                var
                    LPaymentLine: Record "Payment Line";
                    LMontanttRet: Decimal;
                begin


                    LMontanttRet := 0;
                    IF PaymentStatus_gr.GET(rec."Payment Class", rec."Status No.") THEN
                        IF PaymentStatus_gr."Retenu Loyer" THEN BEGIN
                            IF NOT CONFIRM(Text0017) THEN EXIT;
                            LPaymentLine.RESET;
                            LPaymentLine.SETRANGE("No.", rec."No.");
                            IF LPaymentLine.FINDFIRST THEN
                                REPEAT
                                    IF LPaymentLine."Code Retenue à la Source" = '' THEN BEGIN
                                        LPaymentLine.VALIDATE("Code Retenue à la Source", 'RET10');
                                        LMontanttRet := ROUND((LPaymentLine."Debit Amount" * 100 / 90) * (10 / 100), 0.001);
                                        LPaymentLine.VALIDATE("Montant Retenue", LMontanttRet);
                                        LPaymentLine.MODIFY;
                                    END;
                                UNTIL LPaymentLine.NEXT = 0;

                        END
                        ELSE
                            ERROR(Text0023);
                end;
            }
        }

        modify(Print)
        {
            Visible = false;
        }
        addafter(Print)
        {
            action(Print2)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Imprimer';
                Image = Print;
                ToolTip = 'Print the payment slip.';

                trigger OnAction()
                var

                    Steps: Record "Payment Step";

                    RecUser: Record "User Setup";
                begin

                    //TestNbOfLines;
                    Steps.SETRANGE("Payment Class", rec."Payment Class");
                    Steps.SETRANGE("Previous Status", rec."Status No.");
                    Steps.SETRANGE("Action Type", Steps."Action Type"::Report);
                    //>> HJ DSFT 09 12 2010
                    IF RecUser.GET(UPPERCASE(USERID)) THEN;
                    IF RecUser.Agence <> '' THEN Steps.SETFILTER(Agence, '%1|%2', '', RecUser.Agence);
                    //>> HJ DSFT 09 12 2010

                    Currpage.Lines.page.MarkLines(TRUE);
                    ValidatePayment(true);
                    Currpage.Lines.page.MarkLines(FALSE);

                    /*      IF RecPaymentHeader2.FINDFIRST THEN
                              //GL2024    REPORT.RUNMODAL(REPORT::"Draft recapitulation", TRUE, TRUE, RecPaymentHeader2);
                              REPORT.RUNMODAL(REPORT::"Pièce de Paiements copy", TRUE, TRUE, RecPaymentHeader2);*/

                end;
            }
        }


        modify(GenerateFile)
        {
            Visible = false;
        }
        modify(Post)
        {
            Visible = false;


        }


        addafter(Post)
        {
            action(Post2)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Valider';
                Image = Post;
                ToolTip = 'Post the payment.';

                trigger OnAction()
                var
                    LPaymentLine: Record "Payment Line";
                    PaymentMgt: Codeunit "Payment Management";
                begin

                    /*
                    // MH SORO 03-05-2023 
                    {
                    IF ("Payment Class" = 'AVANCE-FRS-CHEQ') OR ("Payment Class" = 'AVANCE-FRS-TRT') THEN BEGIN

                                            RecPaymentLineAV.RESET();
                                            RecPaymentLineAV.SETRANGE("No.", "No.");
                                            IF RecPaymentLineAV.FINDFIRST THEN BEGIN
                                                RecVendor.RESET();
                                                IF RecVendor.GET(RecPaymentLineAV."Code compte") THEN;
                                                IF (RecVendor."Autoriser Avance" = TRUE) OR ("Autoriser avance Fournisseur" = TRUE) THEN BEGIN
                                                    //************************
                                                    IF RecPaymentLineAV."Commande N°" = '' THEN
                                                        ERROR('Champs oblogatoire : N° Commande')
                                                    ELSE BEGIN
                                                        RecPurchaseHeader.RESET();
                                                        RecPurchaseHeader.SETRANGE("No.", RecPaymentLineAV."Commande N°");
                                                        IF NOT RecPurchaseHeader.FINDFIRST THEN
                                                            ERROR('N° Bon commande n existe pas')
                                                        ELSE BEGIN
                                                            RecPaymentLineAV2.RESET();
                                                            RecPaymentLineAV2.SETFILTER("No.", '<>%1', "No.");
                                                            RecPaymentLineAV2.SETRANGE("Commande N°", RecPaymentLineAV."Commande N°");
                                                            IF RecPaymentLineAV2.FINDFIRST THEN ERROR('N° Bon commande déja affecter à lavance N°: %1', RecPaymentLineAV2."No.");

                                                        END;
                                                    END;
                                                    //**********************
                                                END
                                                ELSE
                                                    ERROR('Fournisseur Non Autoriser pour avoir une Avance');

                                            END;
                                        END;
                    //**********************
                    // MH SORO 03-05-2023
                                }*/

                    // MH SORO 04-06-2021
                    /*   RecUserSetup2.GET(USERID);
                       IF RecUserSetup2."Appliquer Blocage Date Compatb" = TRUE THEN
                           IF (rec."Payment Class" <> 'PAIEMENT') AND (rec."Payment Class" <> 'LOYER') THEN
                               IF rec."Posting Date" <> TODAY THEN ERROR(Text0025);*/
                    // MH SORO 04-06-2021



                    // MH SORO 19-04-2017
                    /*   rec.CALCFIELDS(Amount);
                       REC.Ecart := rec.Amount - rec."Montant Brouillard";

                       //KA 04-06-2022  
                       IF (rec."N° Sequence Caisse" <> '') AND (REC.Ecart <> 0) THEN ERROR(Text0024);*/
                    // MH SORO 19-04-2017


                    //>>>MBK:05/02/2010: Référence chèque
                    /* {
                    IF PaymentStatus_gr.GET("Payment Class", "Status No.") THEN
                                            IF PaymentStatus_gr."Référence Chèque" THEN BEGIN
                                                PaymentLine_gr.RESET;
                                                Chèquemouvementé_gr.RESET;
                                                PaymentLine_gr.SETRANGE("No.", "No.");
                                                IF PaymentLine_gr.FINDFIRST THEN
                                                    REPEAT
                                                        IF PaymentLine_gr."N° chèque" = 0 THEN
                                                            ERROR(STRSUBSTNO(Text010, PaymentLine_gr."Line No."));
                                                        Chèquemouvementé_gr.GET("Account No.", PaymentLine_gr."Référence chèque", PaymentLine_gr."N° chèque");
                                                        //IF Chèquemouvementé_gr.Statut=Chèquemouvementé_gr.Statut::Confirmer THEN
                                                        //ERROR( STRSUBSTNO (Text011 , PaymentLine_gr."N° chèque"));
                                                        Chèquemouvementé_gr.Statut := Chèquemouvementé_gr.Statut::Confirmer;
                                                        Chèquemouvementé_gr."N° Bordereu" := PaymentLine_gr."No.";
                                                        Chèquemouvementé_gr."N° Ligne Bordereu" := PaymentLine_gr."Line No.";

                                                        Chèquemouvementé_gr.MODIFY;
                                                    UNTIL PaymentLine_gr.NEXT = 0;
                                            END;
                        }*/

                    //Nettoyage
                    IF PaymentStatus_gr.GET(rec."Payment Class", rec."Status No.") THEN
                        // BEGIN
                        /*   IF PaymentStatus_gr."Retenu Loyer" THEN BEGIN
                               LPaymentLine.RESET;
                               LPaymentLine.SETRANGE("No.", rec."No.");
                               IF LPaymentLine.FINDFIRST THEN
                                   REPEAT
                                       LPaymentLine.TESTFIELD("Code Retenue à la Source");
                                       LPaymentLine.TESTFIELD("Montant Retenue");
                                   UNTIL LPaymentLine.NEXT = 0;

                           END;-*/
                        IF PaymentStatus_gr."Référence Chèque" THEN BEGIN

                            Chèquemouvementé_gr.RESET;
                            Chèquemouvementé_gr.SETRANGE("N° Bordereu", rec."No.");
                            IF Chèquemouvementé_gr.FINDFIRST THEN
                                REPEAT
                                    IF Chèquemouvementé_gr.Statut = Chèquemouvementé_gr.Statut::Encours THEN BEGIN
                                        Chèquemouvementé_gr.Statut := Chèquemouvementé_gr.Statut::" ";
                                        Chèquemouvementé_gr."N° Bordereu" := '';
                                        Chèquemouvementé_gr."N° Ligne Bordereu" := 0;
                                        Chèquemouvementé_gr.MODIFY;
                                    END;
                                UNTIL Chèquemouvementé_gr.NEXT = 0;
                        END;
                    //  END;
                    //<<<MBK:05/02/2010: Référence chèque



                    //GL2024     rec.TestNbOfLines;
                    rec.CalcFields("No. of Lines");
                    if rec."No. of Lines" = 0 then
                        Error(Text001); //GL2024   
                    Steps.SETRANGE("Payment Class", rec."Payment Class");
                    Steps.SETRANGE("Previous Status", rec."Status No.");
                    Steps.SETFILTER("Action Type", '<>%1&<>%2&<>%3', Steps."Action Type"::Report, Steps."Action Type"::File, Steps."Action Type"::
                      "Create New Document");
                    //GL2024
                    /*     Steps.SetFilter(
                         "Action Type",
                         '%1|%2|%3',
                         Steps."Action Type"::None, Steps."Action Type"::Ledger, Steps."Action Type"::"Cancel File");
                     PaymentMgt.ProcessPaymentSteps(Rec, Steps);
                    //GL2024*/
                    //>> HJ DSFT 09 12 2010
                    IF RecUser.GET(UPPERCASE(USERID)) THEN;
                    IF RecUser.Agence <> '' THEN Steps.SETFILTER(Agence, '%1|%2', '', RecUser.Agence);
                    //>> HJ DSFT 09 12 2010
                    ValidatePayment(false);
                    //IBK DSFT
                    IF PaymentStatus_gr.GET(rec."Payment Class", rec."Status No.") THEN
                        IF PaymentStatus_gr."Référence Chèque" THEN BEGIN
                            PaymentLine_gr.RESET;
                            Chèquemouvementé_gr.RESET;
                            PaymentLine_gr.SETRANGE("No.", rec."No.");
                            IF PaymentLine_gr.FINDFIRST THEN
                                REPEAT
                                    IF PaymentLine_gr."N° chèque" = 0 THEN
                                        ERROR(STRSUBSTNO(Text010, PaymentLine_gr."Line No."));
                                    Chèquemouvementé_gr.GET(rec."Account No.", PaymentLine_gr."Référence chèque", PaymentLine_gr."N° chèque");
                                    //IF Chèquemouvementé_gr.Statut=Chèquemouvementé_gr.Statut::Confirmer THEN
                                    //ERROR( STRSUBSTNO (Text011 , PaymentLine_gr."N° chèque"));
                                    IF PaymentLine_gr."Status No." IN [1000, 3000] THEN BEGIN
                                        Chèquemouvementé_gr.Statut := Chèquemouvementé_gr.Statut::Confirmer;
                                        Chèquemouvementé_gr."N° Bordereu" := PaymentLine_gr."No.";
                                        Chèquemouvementé_gr."N° Ligne Bordereu" := PaymentLine_gr."Line No.";

                                        Chèquemouvementé_gr.MODIFY;
                                    END
                                    ELSE
                                        IF PaymentLine_gr."Status No." = 4000 THEN BEGIN
                                            Chèquemouvementé_gr.Statut := Chèquemouvementé_gr.Statut::Comptabilisé;
                                            Chèquemouvementé_gr."N° Bordereu" := PaymentLine_gr."No.";
                                            Chèquemouvementé_gr."N° Ligne Bordereu" := PaymentLine_gr."Line No.";

                                            Chèquemouvementé_gr.MODIFY;
                                        END
                                        ELSE
                                            IF PaymentLine_gr."Status No." IN [5000, 6000] THEN BEGIN
                                                Chèquemouvementé_gr.Statut := Chèquemouvementé_gr.Statut::Annulé;
                                                Chèquemouvementé_gr."N° Bordereu" := PaymentLine_gr."No.";
                                                Chèquemouvementé_gr."N° Ligne Bordereu" := PaymentLine_gr."Line No.";

                                                Chèquemouvementé_gr.MODIFY;
                                            END;

                                UNTIL PaymentLine_gr.NEXT = 0;
                        END;
                    //IBK DSFT
                    // >> HJ DSFT 26-01-2009
                    IF RecEntetePayement.GET(rec."No.") THEN BEGIN
                        RecEntetePayement."Validé Par" := USERID;
                        RecEntetePayement.MODIFY;
                    END;
                    // << HJ DSFT 26-01-2009

                    // << HJ DSFT 17-03-2011
                    IF RecSalesReceivablesSetup.GET THEN;
                    IF RecSalesReceivablesSetup."Activer Suivi Mode Réglement" THEN BEGIN
                        RecPaymentLine.SETRANGE("No.", rec."No.");
                        IF RecPaymentLine.FINDFIRST THEN
                            REPEAT
                                IF RecPaymentLine."Account Type" = RecPaymentLine."Account Type"::Customer THEN BEGIN
                                    IF RecCustomer.GET(RecPaymentLine."Account No.") THEN;
                                    IF RecPaymentClass.GET(rec."Payment Class") THEN;
                                    IF RecPaymentMethod2.GET(RecPaymentClass."Mode Paiement") THEN IntTypeReglement := RecPaymentMethod2.Priorité;
                                    IF RecPaymentMethod.GET(RecCustomer."Payment Method Code") THEN IntClient := RecPaymentMethod.Priorité;
                                    IF IntClient < IntTypeReglement THEN
                                        ERROR(Text0015, RecPaymentLine."Account No.",
                                             RecCustomer."Payment Method Code", rec."Payment Class");
                                END;
                            UNTIL RecPaymentLine.NEXT = 0;
                    END;
                    // << HJ DSFT 17-03-2011

                    // MH SORO 19-04-2017
                    /*{RecPaymentLine3.SETRANGE(RecPaymentLine3."Numero Seq", "N° Sequence Caisse");
                                        IF RecPaymentLine3.FINDFIRST THEN
                                            REPEAT
                                                RecPaymentLine3."External Invoice No." := "N° Caisse";
                                                RecPaymentLine3.MODIFY();
                                            UNTIL RecPaymentLine3.NEXT = 0;
                     }*/
                    // MH SORO 19-04-2017
                end;
            }


        }



        addafter("F&unctions")
        {
            group("&Line")
            {
                Caption = '&Line';


                /*GL2024    action("Calculer Retenue à la Source")
                    {
                        Caption = 'Calculer Retenue à la Source';
                        ApplicationArea = all;
                        trigger OnAction()
                        begin
                            CurrPage.Lines.page.CalculerRetenu;
                        end;


                    }*/
                action("&Actualiser")
                {
                    Caption = '&Actualiser';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        CurrPage.Lines.page.Actualiser;
                    end;
                }
                separator(separator100)
                {

                }
                action("Fractionner Line")
                {
                    Caption = 'Fractionner Line';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        CurrPage.Lines.page.fractLine;
                    end;
                }
                separator(separator200)
                {

                }

                action("Chèques mouvementés")
                {
                    Caption = 'Chèques mouvementés';
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        "Chèquemouvementé_lr": Record "Chèque mouvementé";
                        "Listchèquesmouvementés_lf": Page "List chèques mouvementés";
                    begin

                        //>>>MBK:05/02/2010: Référence chèque
                        CLEAR(Listchèquesmouvementés_lf);
                        Chèquemouvementé_lr.SETRANGE("Code banque", rec."Account No.");
                        Chèquemouvementé_lr.SETRANGE("Référence chèque", CurrPage.Lines.PAGE.REFCHEQUE);
                        Listchèquesmouvementés_lf.SETTABLEVIEW(Chèquemouvementé_lr);
                        Listchèquesmouvementés_lf.SETRECORD(Chèquemouvementé_lr);
                        Listchèquesmouvementés_lf.RUNMODAL;
                        //<<<MBK:05/02/2010: Référence chèque
                    end;
                }
                action("Vider Id Lettrage")
                {
                    Caption = 'Vider Id Lettrage';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin

                        CurrPage.Lines.PAGE.ViderIdLettrage;
                    end;
                }
            }
        }








        addafter("P&osting")
        {
            group("&Imprimer...")
            {
                Caption = '&Imprimer';
                Visible = false;

                action("Retenue à la source")
                {
                    ApplicationArea = all;
                    Caption = 'Retenue à la source';
                    trigger OnAction()
                    begin

                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUNMODAL(REPORT::"Certif. Retenue a la Source", TRUE, FALSE, Rec);
                        rec.RESET;
                    end;
                }
                separator(separator300)
                {
                }
                action("Reçu de caisse")
                {
                    ApplicationArea = all;
                    Caption = 'Reçu de caisse';
                    trigger OnAction()
                    begin

                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUNMODAL(REPORT::"BON COMMANDE SOUROUBAT", TRUE, FALSE, Rec);
                        rec.RESET;
                    end;
                }
                separator(separator400)
                {
                }
                action("Bordereau Espéce Banque")
                {
                    ApplicationArea = all;
                    Caption = 'Bordereau Espéce Banque';
                    trigger OnAction()
                    begin

                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUNMODAL(REPORT::"Suivi PV Reception", TRUE, FALSE, Rec);
                        rec.RESET;
                    end;
                }
                action("Bordereau Chèques Banque")
                {
                    ApplicationArea = all;
                    Caption = 'Bordereau Chèques Banque';
                    trigger OnAction()
                    begin

                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUNMODAL(REPORT::"Documents Bureau D'ordre", TRUE, FALSE, Rec);
                        rec.RESET;
                    end;
                }
                action("Bordereau Effets encaissement")
                {
                    Caption = 'Bordereau Effets encaissement';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin

                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUNMODAL(REPORT::"Demande d'Appro", TRUE, FALSE, Rec);
                        rec.RESET;
                    end;
                }
                action("Bordereau Effets à l'escompte")
                {
                    Caption = 'Bordereau Effets à l''escompte';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin

                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUNMODAL(REPORT::"PV Reception", TRUE, FALSE, Rec);
                        rec.RESET;
                    end;
                }
                separator(separator500)
                {
                }
                action("Ordre de paiement")
                {
                    Caption = 'Ordre de paiement';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin

                        CurrPage.SETSELECTIONFILTER(Rec);
                        REPORT.RUNMODAL(REPORT::"Pièce de Paiement", TRUE, FALSE, Rec);
                        rec.RESET;
                    end;
                }
            }
            group("LETTRAGE")
            {
                Caption = 'LETTERING';
                Visible = false;
                //DYS action deplacer dans BC
                action(Lettrer)
                {
                    ApplicationArea = all;
                    Caption = '&Application';
                    ShortCutKey = 'Maj+F9';

                    trigger OnAction()
                    var
                        RecPaymentLine: Record "Payment Line";
                    begin
                        RecPaymentLine.Reset();
                        RecPaymentLine.SetRange("No.", Rec."No.");
                        if RecPaymentLine.FindSet() then
                            CODEUNIT.Run(CODEUNIT::"Payment-Apply", RecPaymentLine);
                        //  CurrPage.Lines.Page.ApplyPayment;
                        CurrPage.Lines.Page.LettrerFacture;
                    end;
                }

            }

            group("Credit Bancaire")
            {

                Caption = 'Credit Bancaire';
                //GL2024      Visible = CreditBancaireVISIBLE;


                action("Emission Et Comptabilisation")
                {
                    Visible = CreditBancaireVISIBLE;
                    Caption = 'Emission Et Comptabilisation';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin

                        // >> HJ DELTA 10-02-2014
                        IF NOT CONFIRM(Text0017) THEN EXIT;
                        rec.TESTFIELD("Account No.");
                        RecPaymentLine.RESET;
                        RecPaymentLine.SETRANGE("No.", rec."No.");
                        RecPaymentLine.SETRANGE("Type Ligne Credit", RecPaymentLine."Type Ligne Credit"::Emis);
                        RecPaymentLine.SETRANGE(Comptabilisé, TRUE);
                        IF RecPaymentLine.FINDFIRST THEN ERROR(Text0019);
                        IF GeneralLedgerSetup.GET THEN;
                        GenJournalLine.SETRANGE("Journal Template Name", GeneralLedgerSetup."Journal Template Echeance");
                        GenJournalLine.SETRANGE("Journal Batch Name", GeneralLedgerSetup."Journal Batch Echeance");
                        GenJournalLine.DELETEALL;

                        IF RecPaymentClass.GET(rec."Payment Class") THEN
                            IF RecPaymentClass."Credit Bancaire Avec Echeancie" THEN BEGIN
                                RecPaymentLine.RESET;
                                RecPaymentLine.SETRANGE("No.", rec."No.");
                                RecPaymentLine.SETRANGE("Line No.", 10000);
                                IF RecPaymentLine.FINDFIRST THEN BEGIN
                                    RecPaymentLine.TESTFIELD(RecPaymentLine.Amount);
                                    RecPaymentLine."Type Ligne Credit" := RecPaymentLine."Type Ligne Credit"::Emis;
                                    GenJournalLine."Journal Template Name" := GeneralLedgerSetup."Journal Template Echeance";
                                    GenJournalLine."Journal Batch Name" := GeneralLedgerSetup."Journal Batch Echeance";
                                    GenJournalLine."Line No." := 10000;
                                    GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                                    GenJournalLine.VALIDATE("Account No.", GeneralLedgerSetup."Compte Credit");
                                    GenJournalLine.VALIDATE("Posting Date", rec."Posting Date");
                                    GenJournalLine."Document No." := rec."No.";
                                    GenJournalLine.VALIDATE("Credit Amount", ABS(RecPaymentLine.Amount));
                                    GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"Bank Account");
                                    GenJournalLine.VALIDATE("Bal. Account No.", rec."Account No.");
                                    GenJournalLine.INSERT;

                                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
                                    RecPaymentLine.Comptabilisé := TRUE;
                                    RecPaymentLine.MODIFY;

                                END;
                            END;
                        // >> HJ DELTA 10-02-2014
                    end;
                }
                action("Créer Echeancier")
                {
                    Visible = CreditBancaireVISIBLE;
                    Caption = 'Créer Echeancier';
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        Compteur: Integer;
                        i: Integer;
                    begin

                        // >> HJ DELTA 10-02-2014
                        //IF "Status No."=0 THEN ERROR(Text0016);
                        IF rec."Mois Echeance Crédit Bancaire" = 0 THEN ERROR(Text0018);

                        RecPaymentLine.RESET;
                        RecPaymentLine.SETRANGE("No.", rec."No.");
                        RecPaymentLine.SETRANGE(Comptabilisé, TRUE);
                        RecPaymentLine.SETRANGE("Type Ligne Credit", RecPaymentLine."Type Ligne Credit"::Emis);
                        IF NOT RecPaymentLine.FINDFIRST THEN ERROR(Text0022);


                        RecPaymentLine.RESET;
                        RecPaymentLine.SETRANGE("No.", rec."No.");
                        RecPaymentLine.SETRANGE(Comptabilisé, TRUE);
                        RecPaymentLine.SETRANGE("Type Ligne Credit", RecPaymentLine."Type Ligne Credit"::Principal);
                        IF RecPaymentLine.FINDFIRST THEN ERROR(Text0021);

                        IF NOT CONFIRM(Text0017) THEN EXIT;
                        RecPaymentLine.RESET;
                        RecPaymentLine.SETRANGE("No.", rec."No.");
                        RecPaymentLine.SETFILTER("Line No.", '<>%1', 10000);
                        RecPaymentLine.DELETEALL;
                        RecPaymentLine.RESET;
                        RecPaymentLine.SETRANGE("No.", rec."No.");
                        RecPaymentLine.SETRANGE("Line No.", 10000);
                        IF RecPaymentLine.FINDFIRST THEN;
                        i := 1;
                        FOR Compteur := 1 TO rec."Mois Echeance Crédit Bancaire" DO BEGIN
                            i += 1;
                            RecPaymentLine2.INIT;
                            RecPaymentLine2.COPY(RecPaymentLine);
                            RecPaymentLine2."Line No." := i * 10000;
                            RecPaymentLine2."Type Ligne Credit" := RecPaymentLine2."Type Ligne Credit"::Principal;
                            RecPaymentLine2.VALIDATE(Amount, 0);
                            RecPaymentLine2."Type Engagement" := RecPaymentLine2."Type Engagement"::Banque;
                            RecPaymentLine2.Comptabilisé := FALSE;
                            IF NOT RecPaymentLine2.INSERT THEN RecPaymentLine2.MODIFY;
                            RecPaymentLine2.INIT;
                            i += 1;
                            RecPaymentLine2.COPY(RecPaymentLine);
                            RecPaymentLine2."Line No." := i * 10000;
                            RecPaymentLine2."Type Ligne Credit" := RecPaymentLine2."Type Ligne Credit"::Interet;
                            RecPaymentLine2."Type Engagement" := RecPaymentLine2."Type Engagement"::Banque;
                            RecPaymentLine2.VALIDATE(Amount, 0);
                            RecPaymentLine2.Comptabilisé := FALSE;
                            IF NOT RecPaymentLine2.INSERT THEN RecPaymentLine2.MODIFY;

                        END;
                        // >> HJ DELTA 10-02-2014
                    end;
                }
                action("Comptabiliser Echeancier")
                {
                    Visible = CreditBancaireVISIBLE;
                    Caption = 'Comptabiliser Echeancier';
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        PaymentHeader: Record "Payment Header";
                    begin

                        // >> HJ DELTA 10-02-2014
                        IF NOT CONFIRM(Text0017) THEN EXIT;
                        rec.TESTFIELD("Account No.");
                        rec.TESTFIELD("Date Echeance à Comptabiliser");
                        IF GeneralLedgerSetup.GET THEN;
                        GenJournalLine.SETRANGE("Journal Template Name", GeneralLedgerSetup."Journal Template Echeance");
                        GenJournalLine.SETRANGE("Journal Batch Name", GeneralLedgerSetup."Journal Batch Echeance");
                        GenJournalLine.DELETEALL;

                        IF RecPaymentClass.GET(rec."Payment Class") THEN
                            IF RecPaymentClass."Credit Bancaire Avec Echeancie" THEN BEGIN
                                RecPaymentLine.RESET;
                                RecPaymentLine.SETRANGE("No.", rec."No.");
                                RecPaymentLine.SETRANGE("Due Date", rec."Date Echeance à Comptabiliser");
                                RecPaymentLine.SETRANGE("Type Ligne Credit", RecPaymentLine."Type Ligne Credit"::Principal);
                                RecPaymentLine.SETRANGE(Comptabilisé, FALSE);
                                IF RecPaymentLine.FINDFIRST THEN BEGIN
                                    RecPaymentLine.TESTFIELD(RecPaymentLine.Amount);
                                    GenJournalLine."Journal Template Name" := GeneralLedgerSetup."Journal Template Echeance";
                                    GenJournalLine."Journal Batch Name" := GeneralLedgerSetup."Journal Batch Echeance";
                                    GenJournalLine."Line No." := 10000;
                                    GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                                    GenJournalLine.VALIDATE("Account No.", GeneralLedgerSetup."Compte Principal");
                                    GenJournalLine.VALIDATE("Posting Date", rec."Posting Date");
                                    GenJournalLine."Document No." := rec."No.";
                                    GenJournalLine.VALIDATE("Credit Amount", ABS(RecPaymentLine.Amount));
                                    GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
                                    GenJournalLine.VALIDATE("Bal. Account No.", GeneralLedgerSetup."Compte Credit");
                                    GenJournalLine.INSERT;

                                    GenJournalLine."Journal Template Name" := GeneralLedgerSetup."Journal Template Echeance";
                                    GenJournalLine."Journal Batch Name" := GeneralLedgerSetup."Journal Batch Echeance";
                                    GenJournalLine."Line No." := 20000;
                                    GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"Bank Account");
                                    GenJournalLine.VALIDATE("Account No.", rec."Account No.");
                                    GenJournalLine.VALIDATE("Posting Date", rec."Posting Date");
                                    GenJournalLine."Document No." := rec."No.";
                                    GenJournalLine.VALIDATE("Credit Amount", ABS(RecPaymentLine.Amount));
                                    GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
                                    GenJournalLine.VALIDATE("Bal. Account No.", GeneralLedgerSetup."Compte Principal");
                                    GenJournalLine.INSERT;
                                    RecPaymentLine."Type Engagement" := 0;
                                    RecPaymentLine.Comptabilisé := TRUE;
                                    RecPaymentLine.MODIFY;

                                END;
                                RecPaymentLine.RESET;
                                RecPaymentLine.SETRANGE("No.", rec."No.");
                                RecPaymentLine.SETRANGE("Due Date", rec."Date Echeance à Comptabiliser");
                                RecPaymentLine.SETRANGE(Comptabilisé, FALSE);
                                RecPaymentLine.SETRANGE("Type Ligne Credit", RecPaymentLine."Type Ligne Credit"::Interet);
                                IF RecPaymentLine.FINDFIRST THEN BEGIN
                                    RecPaymentLine.TESTFIELD(RecPaymentLine.Amount);

                                    GenJournalLine."Journal Template Name" := GeneralLedgerSetup."Journal Template Echeance";
                                    GenJournalLine."Journal Batch Name" := GeneralLedgerSetup."Journal Batch Echeance";
                                    GenJournalLine."Line No." := 30000;
                                    GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                                    GenJournalLine.VALIDATE("Account No.", GeneralLedgerSetup."Compte Interet");
                                    GenJournalLine.VALIDATE("Posting Date", rec."Posting Date");
                                    GenJournalLine."Document No." := rec."No.";
                                    GenJournalLine.VALIDATE("Credit Amount", ABS(RecPaymentLine.Amount));
                                    GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
                                    GenJournalLine.VALIDATE("Bal. Account No.", GeneralLedgerSetup."Compte Charge Credit");
                                    GenJournalLine.INSERT;


                                    GenJournalLine."Journal Template Name" := GeneralLedgerSetup."Journal Template Echeance";
                                    GenJournalLine."Journal Batch Name" := GeneralLedgerSetup."Journal Batch Echeance";
                                    GenJournalLine."Line No." := 40000;
                                    GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"Bank Account");
                                    GenJournalLine.VALIDATE("Account No.", rec."Account No.");
                                    GenJournalLine.VALIDATE("Posting Date", rec."Posting Date");
                                    GenJournalLine."Document No." := rec."No.";
                                    GenJournalLine.VALIDATE("Credit Amount", ABS(RecPaymentLine.Amount));
                                    GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
                                    GenJournalLine.VALIDATE("Bal. Account No.", GeneralLedgerSetup."Compte Interet");
                                    GenJournalLine.INSERT;
                                    RecPaymentLine.Comptabilisé := TRUE;
                                    RecPaymentLine."Type Engagement" := 0;
                                    RecPaymentLine.MODIFY;
                                    IF PaymentHeader.GET(rec."No.") THEN BEGIN
                                        PaymentHeader."Date Echeance à Comptabiliser" := 0D;
                                        PaymentHeader.MODIFY;
                                    END;


                                END;
                                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);

                            END;
                        // >> HJ DELTA 10-02-2014
                    end;
                }
            }
            group("Impression Bordereau de Versement")
            {
                //GL2024      Visible = ButtImpressionBqVISIBLE;
                Caption = 'Impression Bordereau de Versement';
                action("Versement Cheques")
                {
                    Visible = ButtImpressionBqVISIBLE;
                    Caption = 'Versement Cheques';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin

                        RecPaymentHeaderImpr.RESET;
                        RecPaymentHeaderImpr.SETRANGE("No.", rec."No.");
                        REPORT.RUNMODAL(50184, TRUE, TRUE, RecPaymentHeaderImpr);
                    end;
                }
                separator(separator600)
                {
                }
                action("Remise Effets Encaissements")
                {
                    Visible = ButtImpressionBqVISIBLE;
                    Caption = 'Remise Effets A l''Encaissements';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin

                        RecPaymentHeaderImpr.RESET;
                        RecPaymentHeaderImpr.SETRANGE("No.", rec."No.");
                        REPORT.RUNMODAL(50185, TRUE, TRUE, RecPaymentHeaderImpr);
                    end;
                }
                separator(separator700)
                {
                }
                action("Remise Effets A l'Escompte")
                {
                    Visible = ButtImpressionBqVISIBLE;
                    Caption = 'Remise Effets A l''Escompte';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin

                        RecPaymentHeaderImpr.RESET;
                        RecPaymentHeaderImpr.SETRANGE("No.", rec."No.");
                        REPORT.RUNMODAL(50186, TRUE, TRUE, RecPaymentHeaderImpr);
                    end;
                }
                separator(separator800)
                {
                }
                action("Cheques Impayés")
                {
                    Visible = ButtImpressionBqVISIBLE;
                    Caption = 'Cheques Impayés';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin

                        RecPaymentHeaderImpr.RESET;
                        RecPaymentHeaderImpr.SETRANGE("No.", rec."No.");
                        REPORT.RUNMODAL(50215, TRUE, TRUE, RecPaymentHeaderImpr);
                    end;
                }
                separator(separator900)
                {
                }
                action("Effets Impayés")
                {
                    Visible = ButtImpressionBqVISIBLE;
                    Caption = 'Effets Impayés';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin

                        RecPaymentHeaderImpr.RESET;
                        RecPaymentHeaderImpr.SETRANGE("No.", rec."No.");
                        REPORT.RUNMODAL(50216, TRUE, TRUE, RecPaymentHeaderImpr);
                    end;
                }

            }



            group("Intégration Paie")
            {
                //GL2024     Visible = ButtIntegCaisseVISIBLE;
                Caption = 'Intégration Paie';
                /* action("Intégration Paie à la Caisse")
                 {
                     Visible = ButtIntegCaisseVISIBLE;
                     ApplicationArea = all;
                     Caption = 'Intégration Paie à la Caisse';

                     trigger OnAction()
                     begin

                         // RB SORO 17/01/2017
                         FormListePaieCaisse.GetParametres(rec."No.", rec.Affectation);
                         FormListePaieCaisse.RUN;
                         // RB SORO 17/01/2017
                     end;
                 }*/
                action("Intégration Avance à la Caisse")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Intégration Avance à la Caisse';


                    trigger OnAction()
                    begin

                        // // RB SORO 10/05/2017
                        // FormAvancePretCaiss.GetParametres(rec."No.", 'P2');
                        // FormAvancePretCaiss.RUN;
                        // RB SORO 10/05/2017
                    end;
                }
                action("Intégration Pret à la Caisse")
                {
                    Visible = false;
                    ApplicationArea = all;
                    caption = 'Intégration Pret à la Caisse';
                    trigger OnAction()
                    begin

                        // // RB SORO 10/05/2017
                        // FormAvancePretCaiss.GetParametres(rec."No.", 'P3');
                        // FormAvancePretCaiss.RUN;
                        // RB SORO 10/05/2017
                    end;
                }
                action("Intégration Regu Av Caisse")
                {
                    Visible = false;
                    Caption = 'Intégration Regularisation Avance à la Caisse';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin

                        // // RB SORO 08/06/2017
                        // FormAvancePretCaiss.GetParametres(rec."No.", '3');
                        // FormAvancePretCaiss.RUN;
                        // RB SORO 08/06/2017
                    end;
                }
                action("Intégration Regu Pret Caisse")
                {
                    Visible = false;
                    Caption = 'Intégration Regularisation Pret à la Caisse';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin

                        // // RB SORO 08/06/2017

                        // FormAvancePretCaiss.GetParametres(rec."No.", '2');
                        // FormAvancePretCaiss.RUN;
                        // // RB SORO 08/06/2017
                    end;
                }
            }
            group("Intégration Salaire")
            {
                Caption = 'Intégration Salaire';
                //GL2024      Visible = ButtIntgVirementSalaireVISIBLE;

                action("Intégration Virement Salaire")
                {
                    ApplicationArea = all;
                    Caption = 'Intégration Virement Salaire';
                    Visible = false;
                    trigger OnAction()
                    var
                    //    FormListeVirement: Page "Liste Virement Salaire";
                    begin

                        // FormListeVirement.GetParametres(rec."No.");
                        // FormListeVirement.RUN;
                    end;
                }
                action("Intégration Rejet de Salaire")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Intégration Rejet de Salaire';

                    trigger OnAction()
                    var
                    // FormListeRejetSalaire: Page "Liste Rejet Salaire";
                    begin

                        // FormListeRejetSalaire.GetParametres(rec."No.");
                        // FormListeRejetSalaire.RUN;
                    end;
                }
            }



            //DYS  action(Lettrer2)
            //DYS   {
            //DYS  ApplicationArea = all;
            //DYS   Caption = 'Lettrer';
            //DYS     trigger OnAction()
            //DYS  begin

            // MH SORO 03-05-2023

            /*{
            IF ("Payment Class"='AVANCE-FRS-CHEQ') OR ("Payment Class"='AVANCE-FRS-TRT') THEN
              BEGIN

                 RecPaymentLineAV.RESET();
                 RecPaymentLineAV.SETRANGE("No.","No.");
                 IF RecPaymentLineAV.FINDFIRST THEN
                   BEGIN
                   RecVendor.RESET();
                   IF RecVendor.GET(RecPaymentLineAV."Code compte") THEN;
                   IF (RecVendor."Autoriser Avance"= TRUE) OR ("Autoriser avance Fournisseur"=TRUE) THEN
                     BEGIN
                     //************************
                      IF RecPaymentLineAV."Commande N°"='' THEN ERROR('Champs oblogatoire : N° Commande')
                      ELSE
                      BEGIN
                         RecPurchaseHeader.RESET();
                         RecPurchaseHeader.SETRANGE("No.",RecPaymentLineAV."Commande N°");
                         IF NOT RecPurchaseHeader.FINDFIRST THEN ERROR('N° Bon commande n existe pas')
                         ELSE
                         BEGIN
                            RecPaymentLineAV2.RESET();
                            RecPaymentLineAV2.SETFILTER("No.",'<>%1',"No.");
                            RecPaymentLineAV2.SETRANGE("Commande N°",RecPaymentLineAV."Commande N°");
                            IF RecPaymentLineAV2.FINDFIRST THEN ERROR('N° Bon commande déja affecter à lavance N°: %1',RecPaymentLineAV2."No.");

                         END;
                      END;
                      //**********************
                      END
                      ELSE ERROR('Fournisseur Non Autoriser pour avoir une Avance');

                   END;
              END;
            //**********************
            // MH SORO 03-05-2023
            }*/
            //DYS fonction dans ligne bordereau
            //Currpage.Lines.page.Application;
            //DYS   end;





            //DYS    }
            Group(Imp2)
            {
                Caption = 'Imp';
                action("* - Imp Certif Ret.")
                {
                    ApplicationArea = all;
                    Visible = false;
                    Caption = '* - Imp Certif Ret.';
                    trigger OnAction()
                    begin

                        //IF Valider THEN ERROR(Text005);
                        RecPaymentHeader.SETRANGE("No.", rec."No.");
                        REPORT.RUNMODAL(report::"Certif. Retenue a la Source", TRUE, TRUE, RecPaymentHeader);
                    end;
                }

                action("*- Imp Ord Paiement")
                {
                    ApplicationArea = all;
                    Caption = '*- Imp Ord Paiement';
                    Visible = false;


                    trigger OnAction()
                    begin


                        // MH SORO 03-05-2023

                        /*{
                        IF ("Payment Class"='AVANCE-FRS-CHEQ') OR ("Payment Class"='AVANCE-FRS-TRT') THEN
                          BEGIN

                             RecPaymentLineAV.RESET();
                             RecPaymentLineAV.SETRANGE("No.","No.");
                             IF RecPaymentLineAV.FINDFIRST THEN
                               BEGIN
                               RecVendor.RESET();
                               IF RecVendor.GET(RecPaymentLineAV."Code compte") THEN;
                               IF (RecVendor."Autoriser Avance"= TRUE) OR ("Autoriser avance Fournisseur"=TRUE) THEN
                                 BEGIN
                                 //************************
                                  IF RecPaymentLineAV."Commande N°"='' THEN ERROR('Champs oblogatoire : N° Commande')
                                  ELSE
                                  BEGIN
                                     RecPurchaseHeader.RESET();
                                     RecPurchaseHeader.SETRANGE("No.",RecPaymentLineAV."Commande N°");
                                     IF NOT RecPurchaseHeader.FINDFIRST THEN ERROR('N° Bon commande n existe pas')
                                     ELSE
                                     BEGIN
                                        RecPaymentLineAV2.RESET();
                                        RecPaymentLineAV2.SETFILTER("No.",'<>%1',"No.");
                                        RecPaymentLineAV2.SETRANGE("Commande N°",RecPaymentLineAV."Commande N°");
                                        IF RecPaymentLineAV2.FINDFIRST THEN ERROR('N° Bon commande déja affecter à lavance N°: %1',RecPaymentLineAV2."No.");

                                     END;
                                  END;
                                  //**********************
                                  END
                                  ELSE ERROR('Fournisseur Non Autoriser pour avoir une Avance');

                               END;
                          END;
                        //**********************
                        // MH SORO 03-05-2023
                        }*/

                        CLEAR(RepPiecePaiement);
                        RecPaymentHeader.SETRANGE("No.", rec."No.");
                        //  RepPiecePaiement.GetNumberLIne(Currpage.Lines.page.GetLineNumber);
                        RepPiecePaiement.SETTABLEVIEW(RecPaymentHeader);
                        RepPiecePaiement.RUNMODAL;
                    End;
                }

                action("* - Imp Traite")
                {
                    Caption = '* - Imp Traite';
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnAction()
                    begin

                        // MH SORO 03-05-2023
                        /*

                        IF ("Payment Class"='AVANCE-FRS-CHEQ') OR ("Payment Class"='AVANCE-FRS-TRT') THEN
                          BEGIN

                             RecPaymentLineAV.RESET();
                             RecPaymentLineAV.SETRANGE("No.","No.");
                             IF RecPaymentLineAV.FINDFIRST THEN
                               BEGIN
                               RecVendor.RESET();
                               IF RecVendor.GET(RecPaymentLineAV."Code compte") THEN;
                               IF (RecVendor."Autoriser Avance"= TRUE) OR ("Autoriser avance Fournisseur"=TRUE) THEN
                                 BEGIN
                                 //************************
                                  IF RecPaymentLineAV."Commande N°"='' THEN ERROR('Champs oblogatoire : N° Commande')
                                  ELSE
                                  BEGIN
                                     RecPurchaseHeader.RESET();
                                     RecPurchaseHeader.SETRANGE("No.",RecPaymentLineAV."Commande N°");
                                     IF NOT RecPurchaseHeader.FINDFIRST THEN ERROR('N° Bon commande n existe pas')
                                     ELSE
                                     BEGIN
                                        RecPaymentLineAV2.RESET();
                                        RecPaymentLineAV2.SETFILTER("No.",'<>%1',"No.");
                                        RecPaymentLineAV2.SETRANGE("Commande N°",RecPaymentLineAV."Commande N°");
                                        IF RecPaymentLineAV2.FINDFIRST THEN ERROR('N° Bon commande déja affecter à lavance N°: %1',RecPaymentLineAV2."No.");

                                     END;
                                  END;
                                  //**********************
                                  END
                                  ELSE ERROR('Fournisseur Non Autoriser pour avoir une Avance');

                               END;
                          END;
                        //**********************
                        // MH SORO 03-05-2023
                        */

                        IF rec.Valider THEN ERROR(Text005);
                        CurrPage.Lines.PAGE.GetImprimer;
                        CLEAR(RepTraiteFournisseur);
                        RecPaymentHeader.SETRANGE("No.", rec."No.");
                        //REPORT.RUNMODAL(50048,TRUE,TRUE,RecPaymentHeader);
                        RepTraiteFournisseur.GetNumberLIne(CurrPage.Lines.PAGE.GetLineNumber);
                        RepTraiteFournisseur.SETTABLEVIEW(RecPaymentHeader);
                        RepTraiteFournisseur.RUNMODAL;

                    end;
                }
                action("* - Imp Cheque")
                {
                    Caption = '* - Imp Cheque';
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnAction()
                    begin

                        // MH SORO 03-05-2023

                        /*
                        IF ("Payment Class"='AVANCE-FRS-CHEQ') OR ("Payment Class"='AVANCE-FRS-TRT') THEN
                          BEGIN

                             RecPaymentLineAV.RESET();
                             RecPaymentLineAV.SETRANGE("No.","No.");
                             IF RecPaymentLineAV.FINDFIRST THEN
                               BEGIN
                               RecVendor.RESET();
                               IF RecVendor.GET(RecPaymentLineAV."Code compte") THEN;
                               IF (RecVendor."Autoriser Avance"= TRUE) OR ("Autoriser avance Fournisseur"=TRUE) THEN
                                 BEGIN
                                 //************************
                                  IF RecPaymentLineAV."Commande N°"='' THEN ERROR('Champs oblogatoire : N° Commande')
                                  ELSE
                                  BEGIN
                                     RecPurchaseHeader.RESET();
                                     RecPurchaseHeader.SETRANGE("No.",RecPaymentLineAV."Commande N°");
                                     IF NOT RecPurchaseHeader.FINDFIRST THEN ERROR('N° Bon commande n existe pas')
                                     ELSE
                                     BEGIN
                                        RecPaymentLineAV2.RESET();
                                        RecPaymentLineAV2.SETFILTER("No.",'<>%1',"No.");
                                        RecPaymentLineAV2.SETRANGE("Commande N°",RecPaymentLineAV."Commande N°");
                                        IF RecPaymentLineAV2.FINDFIRST THEN ERROR('N° Bon commande déja affecter à lavance N°: %1',RecPaymentLineAV2."No.");

                                     END;
                                  END;
                                  //**********************
                                  END
                                  ELSE ERROR('Fournisseur Non Autoriser pour avoir une Avance');

                               END;
                          END;
                        //**********************
                        // MH SORO 03-05-2023
                        */

                        IF rec.Valider THEN ERROR(Text005);
                        CLEAR(RepCheque);
                        CurrPage.Lines.PAGE.GetImprimer;
                        RecPaymentHeader.SETRANGE("No.", rec."No.");
                        // RepCheque.GetNumberLIne(CurrPage.Lines.PAGE.GetLineNumber);
                        RepCheque.SETTABLEVIEW(RecPaymentHeader);
                        RepCheque.RUNMODAL;

                    end;
                }
                action("*- Imp Ord Virement")
                {
                    //  Visible = "IMP ORDRE VIR.VISIBLE";
                    Caption = '*- Imp Ord Virement';
                    Visible = false;
                    ApplicationArea = all;
                    trigger OnAction()
                    begin

                        CLEAR(OrdreVirementFournisseur);
                        RecPaymentHeader.SETRANGE("No.", rec."No.");
                        OrdreVirementFournisseur.SETTABLEVIEW(RecPaymentHeader);
                        OrdreVirementFournisseur.RUNMODAL;
                    end;
                }
            }
            /* action("Autoriser avance Fournisseur")
             {
                 Caption = 'Autoriser avance Fournisseur';
                 Visible = BTNAutoriserAvanceFVISIBLE;
                 ApplicationArea = all;
                 trigger OnAction()
                 begin

                     IF RecUserSetupAV.GET(USERID) THEN
                         IF (RecUserSetupAV."Approbateur Autoriser Avance F") AND
                            ((rec."Payment Class" = 'AVANCE-FRS-CHEQ') OR (rec."Payment Class" = 'AVANCE-FRS-TRT')) THEN BEGIN
                             IF NOT CONFIRM('Voulez-vous Autoriser cette Avance?', FALSE) THEN EXIT;
                             rec."Autoriser avance Fournisseur" := TRUE;
                             rec."Approuvé par" := USERID;
                             rec."Date Approbation" := TODAY;
                             rec.MODIFY;
                         END;
                 end;
             }*/
            /*GL2024  action("Agence...")
           {
               caption = 'Agence';
               ApplicationArea = all;
               trigger OnAction()
               begin

                   //>> HJ DSFT 10 12 2010
                   IF RecPaymentStatus.GET(rec."Payment Class", rec."Status No.") THEN BEGIN
                       IF NOT RecPaymentStatus."Changement Agence Permis" THEN
                           EXIT
                       ELSE BEGIN
                           IF RecPaymentStatus."Changement Agence Par" <> UPPERCASE(USERID) THEN
                               ERROR(Text014)
                           ELSE BEGIN
                               IF PAGE.RUNMODAL(PAGE::Sites, RecAgence) = ACTION::LookupOK THEN BEGIN
                                   RecPaymentLine.SETRANGE("No.", rec."No.");
                                   RecPaymentLine.MODIFYALL(Agence, RecAgence.Code);
                                   rec.Agence := RecAgence.Code;
                                   rec.MODIFY;
                               END;

                           END;
                       END;
                   END;
                   //>> HJ DSFT 10 12 2010
               end;
           }
           action("Affectation....")
           {
               Caption = 'Affectation';
               ApplicationArea = all;
               trigger OnAction()
               begin

                   // RB SORO 29/08/2015
                   IF rec."Modifier Date Compta" THEN BEGIN
                       DetailPaieCaisse.SETRANGE("New Date", rec."Posting Date");
                       DetailPaieCaisse.SETRANGE(Code, rec.Agence);
                       DetailPaieCaisse.SETRANGE(Affectation, rec.Affectation);
                       PAGE.RUNMODAL(52049017, DetailPaieCaisse);
                   END
                   ELSE BEGIN
                       DetailPaieCaisse.SETRANGE(Journee, rec."Posting Date");
                       DetailPaieCaisse.SETRANGE(Code, rec.Agence);
                       DetailPaieCaisse.SETRANGE(Affectation, rec.Affectation);
                       PAGE.RUNMODAL(52049017, DetailPaieCaisse);
                   END;
                   // RB SORO 29/08/2015
               end;
           }
           action("Caisse...")
               {
                   Caption = 'Caisse';
                   ApplicationArea = all;
                   trigger OnAction()
                   var
                       RecLPaymentLine: Record "Payment Line";
                   begin

                       IF PAGE.RUNMODAL(PAGE::"Ligne Caisse Brouillard", RecLPaymentLine) = ACTION::LookupOK THEN BEGIN
                           rec."N° Sequence Caisse" := RecLPaymentLine."Numero Seq";
                           rec."N° Caisse" := RecLPaymentLine."No.";
                           IF RecLPaymentLine."Credit Amount" <> 0 THEN
                               rec."Montant Brouillard" := RecLPaymentLine."Credit Amount"
                           ELSE
                               rec."Montant Brouillard" := -(RecLPaymentLine."Debit Amount");
                           rec.VALIDATE("Posting Date", RecLPaymentLine."Due Date");
                           rec."Document Date" := RecLPaymentLine."Due Date";
                           rec.MODIFY;
                           // RB SORO 22/05/2017
                           RecLineCaisse.RESET;
                           RecLineCaisse.SETRANGE("No.", RecLPaymentLine."No.");
                           RecLineCaisse.SETRANGE("Numero Seq", RecLPaymentLine."Numero Seq");
                           IF RecLineCaisse.FINDFIRST THEN BEGIN
                               RecLineCaisse.Chrono := rec."No.";
                               RecLineCaisse.MODIFY;
                           END;
                           // RB SORO 22/05/2017
                       END;
                   end;
               }
               action("Caisse!!!")
               {
                   Caption = 'Caisse!!!';
                   ApplicationArea = all;
                   trigger OnAction()
                   var
                       RecLPaymentLine: Record "Payment Line";
                   begin

                       // RB SORO 22/05/2017
                       RecLineCaisse.RESET;
                       RecLineCaisse.SETRANGE(Chrono, rec."No.");
                       IF RecLineCaisse.FINDFIRST THEN BEGIN
                           RecLineCaisse.Chrono := '';
                           RecLineCaisse.MODIFY;
                       END;
                       // RB SORO 22/05/2017
                       rec."N° Sequence Caisse" := '';
                       rec."N° Caisse" := '';
                       rec."Montant Brouillard" := 0;
                       rec.MODIFY;
                   end;
               }*/






        }
        addafter(Post_Promoted)
        {
            actionref(Post21; Post2)
            {

            }

            actionref(Print21; Print2)
            {

            }

            actionref("Calcul Base Montant1"; "Calcul Base Montant")
            {

            }
        }

        addafter(Category_Process)
        {
            group("Line1")
            {
                Caption = 'Ligne';
                //GL2024   actionref("Calculer Retenue à la Source1"; "Calculer Retenue à la Source") { }
                actionref("&Actualiser1"; "&Actualiser") { }
                actionref("Fractionner Line1"; "Fractionner Line") { }
                actionref("Chèques mouvementés1"; "Chèques mouvementés") { }
                actionref("Vider Id Lettrage1"; "Vider Id Lettrage") { }
            }
        }
        addafter(Post_Promoted)
        {
            group("Imprimer...")
            {
                Caption = 'Imprimer...';
                actionref("Retenue à la source1"; "Retenue à la source")
                {

                }
                actionref("Reçu de caisse1"; "Reçu de caisse")
                {

                }
                actionref("Bordereau Espéce Banque1"; "Bordereau Espéce Banque")
                {

                }
                actionref("Bordereau Chèques Banque1"; "Bordereau Chèques Banque")
                {

                }
                actionref("Bordereau Effets encaissement1"; "Bordereau Effets encaissement")
                {

                }
                actionref("Bordereau Effets à l'escompte1"; "Bordereau Effets à l'escompte")
                {

                }
                actionref("Ordre de paiement1"; "Ordre de paiement")
                {

                }

            }
            group("Credit Bancaire1")
            {
                Caption = 'Credit Bancaire';

                actionref("Emission Et Comptabilisation1"; "Emission Et Comptabilisation")
                {

                }
                actionref("Créer Echeancier1"; "Créer Echeancier")
                {

                }
                actionref("Comptabiliser Echeancier1"; "Comptabiliser Echeancier")
                {

                }
            }
            group("Impression Bordereau de Versement1")
            {
                Caption = 'Impression Bordereau de Versement';
                actionref("Versement Cheques1"; "Versement Cheques") //Testé G
                {

                }
                actionref("Remise Effets Encaissements1"; "Remise Effets Encaissements")//Testé G
                {

                }
                actionref("Remise Effets A l'Escompte1"; "Remise Effets A l'Escompte")//Testé G
                {

                }
                actionref("Cheques Impayés1"; "Cheques Impayés")//Testé G
                {

                }
                actionref("Effets Impayés1"; "Effets Impayés")//Testé G
                {

                }


            }

            group("Intégration Paie1")
            {

                Caption = 'Intégration Paie';
                // actionref("Intégration Paie à la Caisse1"; "Intégration Paie à la Caisse") { }
                actionref("Intégration Avance à la Caisse1"; "Intégration Avance à la Caisse") { }
                actionref("Intégration Pret à la Caisse1"; "Intégration Pret à la Caisse") { }
                actionref("Intégration Regu Av Caisse1"; "Intégration Regu Av Caisse") { }
                actionref("Intégration Regu Pret Caisse1"; "Intégration Regu Pret Caisse") { }


            }


            group("Intégration Salaire1")
            {
                Caption = 'Intégration Salaire';

                actionref("Intégration Virement Salaire1"; "Intégration Virement Salaire") { }
                actionref("Intégration Rejet de Salaire1"; "Intégration Rejet de Salaire") { }




            }

            Group(Imp)
            {
                Caption = 'Imp';
                actionref("* - Imp Certif Ret.1"; "* - Imp Certif Ret.") { }//testé G
                actionref("*- Imp Ord Paiement1"; "*- Imp Ord Paiement") { }//testé G
                actionref("* - Imp Traite1"; "* - Imp Traite") { }//testé G
                actionref("* - Imp Cheque1"; "* - Imp Cheque") { }
                actionref("*- Imp Ord Virement1"; "*- Imp Ord Virement") { }//testé G
            }

            // actionref("Autoriser avance Fournisseur11"; "Autoriser avance Fournisseur") { }

            /*GL2024     actionref("Agence...1"; "Agence...") { }

            actionref("Affectation....1"; "Affectation....") { }
          actionref("Caisse...1"; "Caisse...") { }
               actionref("Caisse!!!1"; "Caisse!!!") { }*/

        }





    }

    trigger OnOpenPage()
    begin

        /* IF RecUserSetupAV.GET(USERID) THEN
             IF (RecUserSetupAV."Approbateur Autoriser Avance F") AND
                ((rec."Payment Class" = 'AVANCE-FRS-CHEQ') OR (rec."Payment Class" = 'AVANCE-FRS-TRT'))
                     = TRUE THEN
                 BTNAutoriserAvanceFVISIBLE := TRUE
             ELSE
                 BTNAutoriserAvanceFVISIBLE := FALSE;*/


        /*  IF (rec."Payment Class" = 'AVANCE-FRS-CHEQ') OR (rec."Payment Class" = 'AVANCE-FRS-TRT') THEN BEGIN
              AutorisationAvanceVISIBLE := TRUE;*/
        /*GL2024   "Autoriser avance FournisseurVISIBLE" := TRUE;
           "Approuvé parVISIBLE" := TRUE;
           "Date ApprobationVISIBLE" := TRUE;*/
        /*  END
          ELSE BEGIN
              AutorisationAvanceVISIBLE := FALSE;
              /*GL2024     "Autoriser avance FournisseurVISIBLE" := FALSE;
               "Approuvé parVISIBLE" := FALSE;
               "Date ApprobationVISIBLE" := FALSE;*/

        //END;

        // << HJ DSFT 21-01-2009
        /* IF rec."Payment Class" <> 'DECAISS-VIREME' THEN
             "IMP ORDRE VIR.VISIBLE" := FALSE
         ELSE
             IF rec."Payment Class" = 'DECAISS-VIREME' THEN "IMP ORDRE VIR.VISIBLE" := TRUE;*/


        // rec.RESET;
        RecUser.GET(UPPERCASE(USERID));
        IF RecUser.Niveau = 0 THEN ERROR(Text0011);
        IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, UPPERCASE(USERID));
        IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
            rec.SETRANGE(Agence, RecUser.Agence)
        ELSE
            rec.SETRANGE(Agence);
        //GetABK;
        // << HJ DSFT 21-01-2009
        // RB SORO 26/09/2016
        /* IF RecPaymentClassImpr.GET(rec."Payment Class") THEN;
         IF RecPaymentClassImpr."Type de Paiement" = RecPaymentClassImpr."Type de Paiement"::Encaissement THEN BEGIN
             ButtImpressionBqVISIBLE := (TRUE)
         END
         ELSE BEGIN
             ButtImpressionBqVISIBLE := (FALSE);
         END;
         IF RecUserSetup.GET(UPPERCASE(USERID)) THEN;
         IF ((rec."Payment Class" = 'PAIECAISSE') OR (rec."Payment Class" = 'PAIE-AV-CAISSE')
            OR (rec."Payment Class" = 'PAIE-PRET-CAISSE') OR (rec."Payment Class" = 'REG-AV-PRET-CAISSE'))
            AND (RecUserSetup."Integrer Caisse Comptable") THEN BEGIN
             ButtIntegCaisseVISIBLE := (TRUE)
         END
         ELSE BEGIN
             ButtIntegCaisseVISIBLE := (FALSE);
         END;
         IF ((rec."Payment Class" = 'VIR-SALAIRE') OR (rec."Payment Class" = 'REJET-SALAIRE'))
            AND (RecUserSetup."Integrer Virement Salaire Comp") THEN BEGIN
             ButtIntgVirementSalaireVISIBLE := (TRUE)
         END
         ELSE BEGIN
             ButtIntgVirementSalaireVISIBLE := (FALSE);
         END;*/
        // RB SORO 26/09/2016
    end;


    trigger OnAfterGetRecord()
    begin

        /* IF RecUserSetupAV.GET(USERID) THEN
             IF (RecUserSetupAV."Approbateur Autoriser Avance F") AND
                ((rec."Payment Class" = 'AVANCE-FRS-CHEQ') OR (rec."Payment Class" = 'AVANCE-FRS-TRT'))
                     = TRUE THEN
                 BTNAutoriserAvanceFVISIBLE := TRUE
             ELSE
                 BTNAutoriserAvanceFVISIBLE := FALSE;*/


        /*  IF (rec."Payment Class" = 'AVANCE-FRS-CHEQ') OR (rec."Payment Class" = 'AVANCE-FRS-TRT') THEN BEGIN
              AutorisationAvanceVISIBLE := TRUE;*/
        /*GL2024    "Autoriser avance FournisseurVISIBLE" := TRUE;
        "Approuvé parVISIBLE" := TRUE;
        "Date ApprobationVISIBLE" := TRUE;*/
        /*END
        ELSE BEGIN
            AutorisationAvanceVISIBLE := FALSE;*/
        /*GL2024    "Autoriser avance FournisseurVISIBLE" := FALSE;
        "Approuvé parVISIBLE" := FALSE;
        "Date ApprobationVISIBLE" := FALSE;*/

        //END;


        /*  rec.CALCFIELDS(Amount);
          REC.Ecart := rec.Amount - rec."Montant Brouillard";

          IF rec."Payment Class" <> 'DECAISS-VIREME' THEN
              "IMP ORDRE VIR.VISIBLE" := FALSE
          ELSE
              IF rec."Payment Class" = 'DECAISS-VIREME' THEN "IMP ORDRE VIR.VISIBLE" := TRUE;*/

        CurrPage.Lines.page.EDITABLE(TRUE);
        // << HJ DSFT 08-11-2009
        //rec.RESET;
        IF RecUser.Niveau = 0 THEN ERROR(Text011);
        IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, USERID);
        IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
            rec.SETRANGE(Agence, RecUser.Agence)
        ELSE
            rec.SETRANGE(Agence);
        GetABK;
        // >> HJ DSFT 08 11 2010
        TxtEtapesSuivante := 'Action : ';
        REcPaymentSteps.SETRANGE("Payment Class", rec."Payment Class");
        REcPaymentSteps.SETRANGE("Previous Status", rec."Status No.");
        IF REcPaymentSteps.FIND('-') THEN
            REPEAT
                REcPaymentSteps.CALCFIELDS("Next Status Name");
                IF (REcPaymentSteps."Action Type" = 0) OR (REcPaymentSteps."Action Type" = 1) THEN
                    TxtEtapesSuivante := TxtEtapesSuivante + ' < Valider >:' + REcPaymentSteps.Name;
                IF (REcPaymentSteps."Action Type" = 2) THEN
                    TxtEtapesSuivante := TxtEtapesSuivante + ' < Imprimer > :' + REcPaymentSteps."Next Status Name";
                IF (REcPaymentSteps."Action Type" = 3) THEN
                    TxtEtapesSuivante := TxtEtapesSuivante + ' < Fichier > :' + REcPaymentSteps."Next Status Name";
                IF (REcPaymentSteps."Action Type" = 4) THEN
                    TxtEtapesSuivante := TxtEtapesSuivante + ' < Créer Bordereau > :' + REcPaymentSteps."Next Status Name";

            UNTIL REcPaymentSteps.NEXT = 0;
        IF RecPaymentClass.GET(rec."Payment Class") THEN
            IF RecPaymentClass."Credit Bancaire Avec Echeancie" THEN
                CreditBancaireVISIBLE := TRUE
            ELSE
                CreditBancaireVISIBLE := FALSE;

        // >> HJ DSFT 08 11 2010
        // RB SORO 26/09/2016
        /* IF RecPaymentClassImpr.GET(rec."Payment Class") THEN;
         IF RecPaymentClassImpr."Type de Paiement" = RecPaymentClassImpr."Type de Paiement"::Encaissement THEN BEGIN
             ButtImpressionBqVISIBLE := (TRUE)
         END
         ELSE BEGIN
             ButtImpressionBqVISIBLE := (FALSE);
         END;
         IF RecUserSetup.GET(UPPERCASE(USERID)) THEN;
         IF ((rec."Payment Class" = 'PAIECAISSE') OR (rec."Payment Class" = 'PAIE-AV-CAISSE')
              OR (rec."Payment Class" = 'PAIE-PRET-CAISSE') OR (rec."Payment Class" = 'REG-AV-PRET-CAISSE'))
          AND (RecUserSetup."Integrer Caisse Comptable") THEN BEGIN
             ButtIntegCaisseVISIBLE := (TRUE)
         END
         ELSE BEGIN
             ButtIntegCaisseVISIBLE := (FALSE);
         END;
         IF ((rec."Payment Class" = 'VIR-SALAIRE') OR (rec."Payment Class" = 'REJET-SALAIRE') OR (rec."Payment Class" = 'VIR-SALAIRE-Rappel'))
            AND (RecUserSetup."Integrer Virement Salaire Comp") THEN BEGIN
             ButtIntgVirementSalaireVISIBLE := (TRUE)

         END
         ELSE BEGIN
             ButtIntgVirementSalaireVISIBLE := (FALSE);
         END;*/
        // RB SORO 26/09/2016
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        // >> HJ DSFT 21-01-2009
        IF RecUser.GET(UPPERCASE(USERID)) THEN rec.Agence := RecUser.Agence;
        rec.Utilisateur := UPPERCASE(USERID);
        // << HJ DSFT 21-01-2009
    end;

    PROCEDURE GetABK();
    VAR
        RecLUserSetup: Record "User Setup";
    BEGIN
        // >> HJ DSFT 04-10-2012
        IF RecLUserSetup.GET(UPPERCASE(USERID)) THEN;
        rec.CALCFIELDS(ABK);
        IF NOT RecLUserSetup."Compte EX" THEN rec.SETRANGE(ABK, FALSE);
        // >> HJ DSFT 04-10-2012
    END;

    PROCEDURE LettrageComptableAuto();
    VAR
        RecPaymentLine: Record "Payment Line";
        RecPaymentStatus: Record "Payment Status";
        RecGeneralLedgerSetup: Record "General Ledger Setup";
        RecGLEntry: Record "G/L Entry";
        GLEntryTmp: Record "G/L Entry";
        RecGlAccount: Record "G/L Account";
        GLEntriesApplication: Codeunit "G/L Entry Application2";
        TxtLetter: Text[4];
        CdeClient: Code[20];
        IntSequenceDebit: Integer;
        efefef: Codeunit "Payment-Apply";
        IntSequenceCredit: Integer;
        BlnSens: Code[1];
    BEGIN

        //>> HJ TC 27-11-2011 RAPPROCHEMENT COMPTABLE AUTOMATIQUE
        /* IF RecGeneralLedgerSetup.GET THEN;
         IF NOT RecGeneralLedgerSetup."Activer Rapproch. Auto" THEN EXIT;
         RecPaymentLine.SETRANGE("No.", rec."No.");
         IF RecPaymentLine.FINDFIRST THEN
             REPEAT
                 RecPaymentStatus.SETRANGE("Payment Class", rec."Payment Class");
                 // RecPaymentStatus.SETRANGE(Rapprocher,TRUE);
                 IF RecPaymentStatus.FINDFIRST THEN BEGIN
                     CdeClient := RecPaymentLine."Account No.";
                     IntSequenceDebit := RecPaymentLine."Entry No. Debit";
                     IntSequenceCredit := RecPaymentLine."Entry No. Credit";
                     RecGLEntry.RESET;
                     RecGLEntry.SETRANGE(Letter, '');
                     RecGLEntry.SETRANGE("Source No.", CdeClient);
                     RecGLEntry.SETRANGE("External Document No.", RecPaymentLine."External Document No.");
                     RecGLEntry.SETFILTER("Posting Date", '>=%1', RecGeneralLedgerSetup."Date Debut Lettarge Auto");
                     IF (RecGeneralLedgerSetup."No. Compte Rapp 1" = RecPaymentLine."Acc. No. Last Entry Debit") THEN BEGIN
                         TxtLetter := GLEntriesApplication.GetLetter2(RecGeneralLedgerSetup."No. Compte Rapp 1");
                         RecGLEntry.SETRANGE("G/L Account No.", RecGeneralLedgerSetup."No. Compte Rapp 1");
                         RecGLEntry.SETRANGE(Amount, -(ABS(RecPaymentLine.Amount)));
                         IF GLEntryTmp.GET(IntSequenceDebit) THEN;
                     END;
                     IF (RecGeneralLedgerSetup."No. Compte Rapp 2" = RecPaymentLine."Acc. No. Last Entry Debit") THEN BEGIN
                         TxtLetter := GLEntriesApplication.GetLetter2(RecGeneralLedgerSetup."No. Compte Rapp 2");
                         RecGLEntry.SETRANGE("G/L Account No.", RecGeneralLedgerSetup."No. Compte Rapp 2");
                         RecGLEntry.SETRANGE(Amount, -(ABS(RecPaymentLine.Amount)));
                         IF GLEntryTmp.GET(IntSequenceDebit) THEN;

                     END;
                     IF (RecGeneralLedgerSetup."No. Compte Rapp 3" = RecPaymentLine."Acc. No. Last Entry Debit") THEN BEGIN
                         TxtLetter := GLEntriesApplication.GetLetter2(RecGeneralLedgerSetup."No. Compte Rapp 3");
                         RecGLEntry.SETRANGE("G/L Account No.", RecGeneralLedgerSetup."No. Compte Rapp 3");
                         RecGLEntry.SETRANGE(Amount, -(ABS(RecPaymentLine.Amount)));
                         IF GLEntryTmp.GET(IntSequenceDebit) THEN;

                     END;
                     IF (RecGeneralLedgerSetup."No. Compte Rapp 4" = RecPaymentLine."Acc. No. Last Entry Debit") THEN BEGIN
                         TxtLetter := GLEntriesApplication.GetLetter2(RecGeneralLedgerSetup."No. Compte Rapp 4");
                         RecGLEntry.SETRANGE("G/L Account No.", RecGeneralLedgerSetup."No. Compte Rapp 4");
                         RecGLEntry.SETRANGE(Amount, -(ABS(RecPaymentLine.Amount)));
                         IF GLEntryTmp.GET(IntSequenceDebit) THEN;

                     END;
                     IF (RecGeneralLedgerSetup."No. Compte Rapp 5" = RecPaymentLine."Acc. No. Last Entry Debit") THEN BEGIN
                         TxtLetter := GLEntriesApplication.GetLetter2(RecGeneralLedgerSetup."No. Compte Rapp 5");
                         RecGLEntry.SETRANGE("G/L Account No.", RecGeneralLedgerSetup."No. Compte Rapp 5");
                         RecGLEntry.SETRANGE(Amount, -(ABS(RecPaymentLine.Amount)));
                         IF GLEntryTmp.GET(IntSequenceDebit) THEN;

                     END;
                     IF (RecGeneralLedgerSetup."No. Compte Rapp 1" = RecPaymentLine."Acc. No. Last Entry Credit") THEN BEGIN
                         TxtLetter := GLEntriesApplication.GetLetter2(RecGeneralLedgerSetup."No. Compte Rapp 1");
                         RecGLEntry.SETRANGE("G/L Account No.", RecGeneralLedgerSetup."No. Compte Rapp 1");
                         RecGLEntry.SETRANGE(Amount, (ABS(RecPaymentLine.Amount)));
                         IF GLEntryTmp.GET(IntSequenceCredit) THEN;

                     END;
                     IF (RecGeneralLedgerSetup."No. Compte Rapp 2" = RecPaymentLine."Acc. No. Last Entry Credit") THEN BEGIN
                         TxtLetter := GLEntriesApplication.GetLetter2(RecGeneralLedgerSetup."No. Compte Rapp 2");
                         RecGLEntry.SETRANGE("G/L Account No.", RecGeneralLedgerSetup."No. Compte Rapp 2");
                         RecGLEntry.SETRANGE(Amount, (ABS(RecPaymentLine.Amount)));
                         IF GLEntryTmp.GET(IntSequenceCredit) THEN;

                     END;
                     IF (RecGeneralLedgerSetup."No. Compte Rapp 3" = RecPaymentLine."Acc. No. Last Entry Credit") THEN BEGIN
                         TxtLetter := GLEntriesApplication.GetLetter2(RecGeneralLedgerSetup."No. Compte Rapp 3");
                         RecGLEntry.SETRANGE("G/L Account No.", RecGeneralLedgerSetup."No. Compte Rapp 3");
                         RecGLEntry.SETRANGE(Amount, (ABS(RecPaymentLine.Amount)));
                         IF GLEntryTmp.GET(IntSequenceCredit) THEN;

                     END;
                     IF (RecGeneralLedgerSetup."No. Compte Rapp 4" = RecPaymentLine."Acc. No. Last Entry Credit") THEN BEGIN
                         TxtLetter := GLEntriesApplication.GetLetter2(RecGeneralLedgerSetup."No. Compte Rapp 4");
                         RecGLEntry.SETRANGE("G/L Account No.", RecGeneralLedgerSetup."No. Compte Rapp 4");
                         RecGLEntry.SETRANGE(Amount, (ABS(RecPaymentLine.Amount)));
                         IF GLEntryTmp.GET(IntSequenceCredit) THEN;

                     END;
                     IF (RecGeneralLedgerSetup."No. Compte Rapp 5" = RecPaymentLine."Acc. No. Last Entry Credit") THEN BEGIN
                         TxtLetter := GLEntriesApplication.GetLetter2(RecGeneralLedgerSetup."No. Compte Rapp 5");
                         RecGLEntry.SETRANGE("G/L Account No.", RecGeneralLedgerSetup."No. Compte Rapp 5");
                         RecGLEntry.SETRANGE(Amount, (ABS(RecPaymentLine.Amount)));
                         IF GLEntryTmp.GET(IntSequenceCredit) THEN;

                     END;
                     IF RecGLEntry.FINDLAST THEN BEGIN
                         GLEntryTmp.Letter := TxtLetter;
                         GLEntryTmp."Letter Date" := RecGLEntry."Posting Date";
                         GLEntryTmp.MODIFY;
                         RecGLEntry.Letter := TxtLetter;
                         RecGLEntry."Letter Date" := RecGLEntry."Posting Date";
                         RecGLEntry.MODIFY;
                     END;

                 END;
             UNTIL RecPaymentLine.NEXT = 0;*/
        //>> HJ TC 27-11-2011  RAPPROCHEMENT COMPTABLE AUTOMATIQUE
    END;

    local procedure ValidatePayment(PrintOrPost: Boolean)
    var
        PaymentHeader: Record "Payment Header";
        PaymentLine, LPaymentLine : Record "Payment Line";
        PaymentStatus: Record "Payment Status";
        LPaymentClass, RecPaymentClassM : Record "Payment Class";
        Ok: Boolean;
        PostingStatement: Codeunit "Payment Management Copy";
        Options: Text;
        Choice, I : Integer;
        CduGenJnPostLine: Codeunit "Gen. Jnl.-Post Line";
        PaymentStep: Record "Payment Step";
    begin

        // >> HJ DELTA 11-02-2014 Verifer Si Montant = Zero
        IF RecPaymentClassM.GET(REC."Payment Class") THEN;
        LPaymentLine.RESET;
        LPaymentLine.SETRANGE("No.", REC."No.");
        IF LPaymentLine.FINDFIRST THEN
            REPEAT
                LPaymentLine.TESTFIELD(Amount);
                LPaymentLine.TESTFIELD("Account No.");
            //     IF NOT RecPaymentClassM."Verifier Compte Ligne" THEN LPaymentLine.TESTFIELD("Account No.");
            // IF RecPaymentClassM."Verifier Affectation Financier" THEN LPaymentLine.TESTFIELD("Affectation Financiere");
            UNTIL LPaymentLine.NEXT = 0;
        IF LPaymentClass.GET(REC."Payment Class") THEN BEGIN
            IF LPaymentClass."Piece De Paiement Obligatoire" THEN BEGIN
                LPaymentLine.RESET;
                LPaymentLine.SETRANGE("No.", REC."No.");
                IF LPaymentLine.FINDFIRST THEN
                    REPEAT
                        LPaymentLine.TESTFIELD("External Document No.");
                    UNTIL LPaymentLine.NEXT = 0;
            END;
            IF LPaymentClass."Banque Bénéficiaire Obligatoir" THEN BEGIN
                LPaymentLine.RESET;
                LPaymentLine.SETRANGE("No.", REC."No.");
                IF LPaymentLine.FINDFIRST THEN
                    REPEAT
                        LPaymentLine.TESTFIELD("Bank Account Code");
                    UNTIL LPaymentLine.NEXT = 0;
            END;

        END;
        //////
        if PrintOrPost then begin


            Steps.SETRANGE("Payment Class", rec."Payment Class");
            Steps.SETRANGE("Previous Status", rec."Status No.");
            Steps.SETRANGE("Action Type", Steps."Action Type"::Report);
            //>> HJ DSFT 09 12 2010
            IF RecUser.GET(UPPERCASE(USERID)) THEN;
            IF RecUser.Agence <> '' THEN Steps.SETFILTER(Agence, '%1|%2', '', RecUser.Agence);
        end;
        /// ////
        // >> HJ DELTA 11-02-2014 Verifer Si Montant = Zero
        I := Steps.COUNT;
        Ok := FALSE;
        IF I = 1 THEN BEGIN
            Steps.FIND('-');
            //GL2024    Ok := CONFIRM(Steps.Name, TRUE);
        END ELSE
            IF I > 1 THEN BEGIN
                IF Steps.FIND('-') THEN BEGIN
                    REPEAT
                        IF Options = '' THEN
                            Options := Steps.Name
                        ELSE
                            Options := Options + ',' + Steps.Name;
                    UNTIL Steps.NEXT = 0;

                    Choice := STRMENU(Options, 1);

                    I := 1;
                    IF Choice > 0 THEN BEGIN
                        Ok := TRUE;
                        Steps.FIND('-');
                        WHILE Choice > I DO BEGIN
                            I += 1;
                            Steps.NEXT;
                        END;
                    END;
                END;
            END;

        // >> HJ DSFT 21-01-2009
        RecAutorisationEtapes.SETRANGE("Type Reglement", Steps."Payment Class");
        RecAutorisationEtapes.SETRANGE(Etape, Steps.Line);
        RecAutorisationEtapes.SETRANGE(User, USERID);

        IF NOT RecAutorisationEtapes.FINDFIRST THEN ERROR(Text0010, USERID, Steps."Payment Class", Steps.Line);
        // << HJ DSFT 21-01-2009
        // >> HJ DSFT 14-04-2009
        IF RecUser.GET(UPPERCASE(USERID)) THEN;
        IF RecUser.Agence <> '' THEN
            IF Steps.Agence <> '' THEN IF REC.Agence <> Steps.Agence THEN ERROR(Text0012, REC.Agence, Steps.Agence);
        // << HJ DSFT 14-04-2009

        // >> Mise a Jour Statut Factures
        IF REC."N° Bordereau" <> '' THEN
            LettrageFactures.SETRANGE("Numero Reglement", REC."N° Bordereau")
        ELSE
            LettrageFactures.SETRANGE("Numero Reglement", REC."No.");
        IF LettrageFactures.FINDFIRST THEN
            REPEAT
                CduPurchpostevent.ChangerStatutFacture(LettrageFactures."Numero Facture", Steps."Statut Facture" - 1);
                COMMIT;
            UNTIL LettrageFactures.NEXT = 0;
        // >> Mise a Jour Statut Factures

        if not PrintOrPost then
            Steps.SetFilter(
                              "Action Type",
                              '%1|%2|%3',
                              Steps."Action Type"::None, Steps."Action Type"::Ledger, Steps."Action Type"::"Cancel File");
        PostingStatement.ProcessPaymentSteps(Rec, Steps);
        IF PaymentStatus.GET(REC."Payment Class", Steps."Next Status") THEN BEGIN
            PaymentLine.RESET;
            PaymentLine.SETRANGE("No.", REC."No.");
            PaymentLine.MODIFYALL("Type Engagement", PaymentStatus."Type Engagement");
            PaymentLine.RESET;
            PaymentLine.SETRANGE("No.", REC."No.");
            PaymentLine.MODIFYALL("Header Account Type", REC."Account Type");
            PaymentLine.RESET;
            PaymentLine.SETRANGE("No.", REC."No.");
            PaymentLine.MODIFYALL("Header Account No.", REC."Account No.");

            PaymentLine.RESET;
            PaymentLine.SETRANGE("No.", REC."No.");
            PaymentLine.MODIFYALL("Sens Engagement", PaymentStatus."Sens Engagement");


        END;

        //>> HJ TC 03-12-2011
        // CduGenpost.LettrageAutomatique(REC."No.", REC."Payment Class", Steps.Line);
        //>> HJ TC 03-12-2011
    end;



    var
        "-MBK-": Integer;
        PaymentStatus_gr: Record "Payment Status";
        PaymentLine_gr: Record "Payment Line";
        Chèquemouvementé_gr: Record "Chèque mouvementé";
        RecBankAccount: Record "Bank Account";
        CduGenpost: Codeunit "Gen. Jnl.-Post Line_CDU12";
        "-HJ-": Integer;
        RecAutorisationEtapes: Record "Autorisation Etapes2";
        RecUser: Record "User Setup";
        RecEntetePayement: Record "Payment Header";
        RecPaymentLine: Record "Payment Line";
        RecPaymentLine2: Record "Payment Line";
        RecBank: Record "Bank Account";
        REcPaymentSteps: Record "Payment Step";
        RecPaymentStatus: Record "Payment Status";
        TxtEtapesSuivante: Text[1000];
        RecEntete: Record "Payment Header";
        RecAgence: Record 50039;
        RecPaymentMethod: Record "Payment Method";
        RecPaymentMethod2: Record "Payment Method";
        RecSalesReceivablesSetup: Record "Sales & Receivables Setup";
        RecCustomer: Record Customer;
        RecPaymentClass: Record "Payment Class";
        IntClient: Integer;
        IntTypeReglement: Integer;
        GeneralLedgerSetup: Record "General Ledger Setup";
        GenJournalLine: Record "Gen. Journal Line";
        LettrageFactures: Record "Liste Factures Lettrage";
        CduPurchPost: Codeunit "Purch.-Post";
        CduPurchpostevent: Codeunit PurchPostEvent;
        RecPaymentHeader: Record "Payment Header";
        RepPiecePaiement: Report "Pièce de Paiement";
        RepTraiteFournisseur: Report "* Traite Fournisseur";
        RepCheque: Report "CHEQUE CORIS";
        // DetailPaieCaisse: Record "Detail Paie Caisse";
        RecPaymentClassImpr: Record "Payment Class";
        RecPaymentHeaderImpr: Record "Payment Header";
        RecPaymentLineCaiss: Record "Payment Line";
        //  FormListePaieCaisse: Page "Liste Paie Caisse";
        RecUserSetup: Record "User Setup";
        NumBrouillards: Code[20];
        NumSequence: Code[20];
        MontantBrouillard: Decimal;
        Ecart: Decimal;
        RecPaymentLine3: Record "Payment Line";
        //  RegroupementPaieEntete: Record "Regroupement Paie Entete";
        Ecart2: Decimal;
        //   FormAvancePretCaiss: Page "Liste Avance/Pret Caisse";
        SensType: option " ",Avance,Pret;
        RecLineCaisse: Record "Payment Line";
        OrdreVirementFournisseur: Report "Ordre Virement Fournisseur";
        RecPaymentHeader2: Record "Payment Header";
        RecUserSetup2: Record "User Setup";
        RecPaymentLineAV: Record "Payment Line";
        RecPurchaseHeader: Record "Purchase Header";
        RecPaymentLineAV2: Record "Payment Line";
        RecVendor: Record Vendor;
        RecUserSetupAV: Record "User Setup";
        Steps: Record "Payment Step";

        Text004: label 'Vous ne pouvez pas affecter un numéro à un bordereau validé.';
        Text005: label 'Ce document n''a pas de ligne. Vous ne pouvez l''archiver. Vous devez le supprimer.';
        Text006: label 'Une ligne n''est pas validée. Êtes-vous sur de vouloir archiver ce document ?';
        Text007: label 'Certaines lignes ne sont pas validées. Êtes-vous sur de vouloir archiver ce document ?';
        Text008: label 'Etes-vous sur de vouloir archiver ce document ?';
        //
        Text010: label 'Veuillez saisir le N° Chèque dans la ligne %1';
        Text011: label 'N° chèque %1 utlisé plus d''une fois';
        Text0010: label 'Vous N''ete Pas Autorise A Cette Etape %1,  %2,  %3 ; Consulter Votre Administrateur';
        Text0011: label 'Vous N''ete Pas Autorisé Au Module Encaissement - Decaissement';
        Text0012: label 'Votre Agence %1 Est Différente De Celle De L''Etape ( %2 )';
        Text013: label 'Changement Agence Non Permis A Ce Statut';
        Text014: label 'Vous n''etes pas autoriser à Changer L''agence';
        Text0015: label 'Mode Paiement Client N° %1 ( %2 ) Ne Peut Pas Etre %3';
        Text0016: label 'Vous Devez Confirmer Le Crédit';
        Text0017: label 'Confirmer Cette Action';
        Text0018: label 'Veuillez Préciser Nombre Mois Echeancier';
        Text0019: label 'Crédit Déja Emis';
        Text0020: label 'Echeance Déja Comptabilisé';
        Text0021: label 'Ecritures Déja Comptabilisées';
        Text0022: label 'Ce Crédit Na Pas Etais Emis';
        Text0023: label 'Statut Ne Permet Pas Cette Action';
        Text0024: label 'Le Montant Total des  Lignes est different au Montant Total de la  Brouillard !!!!';
        Text0025: label 'Date Comptabilisation Non Valide!!';
        Text001: Label 'Il n''y a pas de file d''attente à traiter';


        //GL2024
        [InDataSet]
        AutorisationAvanceVISIBLE: Boolean;
        [InDataSet]
        "Autoriser avance FournisseurVISIBLE": Boolean;
        "Approuvé parVISIBLE": Boolean;
        "Date ApprobationVISIBLE": Boolean;
        BTNAutoriserAvanceFVISIBLE: Boolean;
        "IMP ORDRE VIR.VISIBLE": Boolean;
        ButtImpressionBqVISIBLE: Boolean;
        ButtIntegCaisseVISIBLE: Boolean;
        [InDataSet]
        ButtIntgVirementSalaireVISIBLE: Boolean;
        [InDataSet]
        CreditBancaireVISIBLE: Boolean;



}