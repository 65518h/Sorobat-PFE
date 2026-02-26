// page 50080 "Payment Slip 2"
// {
//     // //>>>MBK:05/02/2010: Référence chèque
//     // // << HJ DSFT 21-01-2009: Gestion des Utilisateurs

//     Caption = 'Reglement';
//     PageType = Card;
//     RefreshOnActivate = true;
//     SourceTable = "Payment Header";

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'Général';
//                 field("No."; rec."No.")
//                 {
//                     ApplicationArea = all;
//                     AssistEdit = false;
//                     Editable = false;

//                     /*GL2024  trigger OnAssistEdit()
//                       begin

//                           IF AssistEdit2(xRec) THEN
//                               CurrPage.UPDATE;

//                       end;*/
//                 }
//                 field("Payment Class"; rec."Payment Class")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Lookup = false;
//                 }
//                 field("Payment Class Name"; rec."Payment Class Name")
//                 {
//                     ApplicationArea = all;
//                     DrillDown = false;
//                     Editable = false;
//                 }
//                 field("Status Name"; rec."Status Name")
//                 {
//                     ApplicationArea = all;
//                     DrillDown = false;
//                     Editable = false;
//                 }
//                 field("Account Type"; rec."Account Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Account No."; rec."Account No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Valider; rec.Valider)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Utilisateur; rec.Utilisateur)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Validé Par"; rec."Validé Par")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Posting Date"; rec."Posting Date")
//                 {
//                     ApplicationArea = all;
//                 }

//                 field("Document Date"; rec."Document Date")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         DocumentDateOnAfterValidate;
//                     end;
//                 }
//                 field("Amount (LCY)"; rec."Amount (LCY)")
//                 {
//                     ApplicationArea = all;

//                     DecimalPlaces = 3 : 3;
//                 }
//                 field(Amount; rec.Amount)
//                 {
//                     ApplicationArea = all;

//                     DecimalPlaces = 3 : 3;
//                 }
//                 field("Folio N° RS"; rec."Folio N° RS")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }




//                 field(TxtEtapesSuivante; TxtEtapesSuivante)
//                 {
//                     ApplicationArea = all;
//                     ShowCaption = false;
//                     Editable = false;
//                     MultiLine = true;
//                 }
//                 group(AutorisationAvance)
//                 {
//                     Caption = 'Advance Authorization';
//                     Visible = AutorisationAvanceVisible;
//                     field("Autoriser avance Fournisseur"; rec."Autoriser avance Fournisseur")
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                         Style = Strong;
//                         StyleExpr = TRUE;
//                         Visible = AutoriseravanceFournisseurVisi;
//                     }
//                     field("Approuvé par"; rec."Approuvé par")
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                         Style = Unfavorable;
//                         StyleExpr = TRUE;
//                         Visible = "Approuvé parVisible";
//                     }
//                     field("Date Approbation"; rec."Date Approbation")
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                         Style = Unfavorable;
//                         StyleExpr = TRUE;
//                         Visible = "Date ApprobationVisible";
//                     }
//                 }
//             }
//             part(Lines; "Payment Slip Subform 2")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Sous-formulaire bordereau paiement';

//                 SubPageLink = "No." = FIELD("No.");
//             }
//             group(Posting)
//             {
//                 Caption = 'Validation';
//                 field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Currency Code"; rec."Currency Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Presentation; rec.Presentation)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group("Lettre De Crédit")
//             {
//                 Caption = 'Lettre de Crédit';
//                 field("N° CI"; rec."N° CI")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("DATE D'EMBARQUEMENT"; rec."DATE D'EMBARQUEMENT")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("DATE D'EXPIRATION"; rec."DATE D'EXPIRATION")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("CONDITION DE VENTE"; rec."CONDITION DE VENTE")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("PORT EMBARQUEMENT"; rec."PORT EMBARQUEMENT")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("PORT DEBARQUEMENT"; rec."PORT DEBARQUEMENT")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Mode Echéance"; rec."Mode Echéance")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Objet Lettre"; rec."Objet Lettre")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Brouillard"; rec."N° Brouillard")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Destinataire; rec.Destinataire)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Tomber FED"; rec."Tomber FED")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group(Placement)
//             {
//                 Caption = 'Placement';
//                 field(TAUX; rec.TAUX)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Durée; rec.Durée)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Comm Bancaire"; rec."Comm Bancaire")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Bénéficiaire; rec.Bénéficiaire)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Période; rec.Période)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group("Fatures Ventes")
//             {
//                 Caption = 'Fatures Ventes';
//                 part("Liaison Paiement Facture Vente"; "Liaison Paiement Facture Vente")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Liaison Paiement Facture Vente';
//                     SubPageLink = "N° Bordereaux" = FIELD("No.");
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Promoted)
//         {
//             group("&Navigate1")
//             {
//                 Caption = 'Navi&guer';

//                 actionref(Header1; Header) { }

//                 actionref(Line1; Line) { }

//             }

//             //GL2024    actionref(Lettrer1; Lettrer) { }
//             actionref("2 - Fractionner1"; "2 - Fractionner") { }
//             actionref("3 - Confirmer1"; "3 - Confirmer") { }
//             actionref(ValiderPaiement1; ValiderPaiement) { }
//             actionref("* - Imp Traite1"; "* - Imp Traite") { }

//             actionref("* - Imp Cheque1"; "* - Imp Cheque") { }

//             actionref("* - Imp Certif Ret.1"; "* - Imp Certif Ret.") { }
//             actionref("*- Imp Ord Paiement1"; "*- Imp Ord Paiement") { }
//             actionref("IMP ORDRE VIR1"; "IMP ORDRE VIR") { }
//             actionref(BTNAutoriserAvanceF1; BTNAutoriserAvanceF) { }

//         }
//         area(navigation)
//         {
//             group("&Navigate")
//             {
//                 Caption = '&Navigate';
//                 action(Header)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'En-tête';

//                     trigger OnAction()
//                     begin
//                         Navigate.SetDoc(rec."Posting Date", rec."No.");
//                         Navigate.RUN;
//                     end;
//                 }
//                 action(Line)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Ligne';

//                     trigger OnAction()
//                     var
//                         PaymentLine: Record "Payment Line";
//                     begin
//                         CurrPage.Lines.page.GETRECORD(PaymentLine);
//                         Navigate.SetDoc(rec."Posting Date", PaymentLine."Document No.");
//                         Navigate.RUN;
//                     end;
//                 }
//             }
//         }
//         area(processing)
//         {
//             /*GL2024     action(Lettrer)
//                  {
//                      ApplicationArea = all;
//                      Caption = '1  - Lettrer';
//                      // Promoted = true;
//                      // PromotedCategory = Process;

//                      trigger OnAction()
//                      begin


//                          IF rec.Valider THEN ERROR(Text005);

//                          // MH SORO 03-05-2023


//                          IF (rec."Payment Class" = 'AVANCE-FRS-CHEQ') OR (rec."Payment Class" = 'AVANCE-FRS-TRT') THEN BEGIN

//                              RecPaymentLineAV.RESET();
//                              RecPaymentLineAV.SETRANGE("No.", rec."No.");
//                              IF RecPaymentLineAV.FINDFIRST THEN BEGIN
//                                  RecVendor.RESET();
//                                  IF RecVendor.GET(RecPaymentLineAV."Code compte") THEN;
//                                  IF (RecVendor."Autoriser Avance" = TRUE) OR (rec."Autoriser avance Fournisseur" = TRUE) THEN BEGIN
//                                      //************************
//                                      IF RecPaymentLineAV."Commande N°" = '' THEN
//                                          ERROR('Champs oblogatoire : N° Commande')
//                                      ELSE BEGIN
//                                          RecPurchaseHeader.RESET();
//                                          RecPurchaseHeader.SETRANGE("No.", RecPaymentLineAV."Commande N°");
//                                          IF NOT RecPurchaseHeader.FINDFIRST THEN
//                                              ERROR('N° Bon commande n existe pas')
//                                          ELSE BEGIN
//                                              RecPaymentLineAV2.RESET();
//                                              RecPaymentLineAV2.SETFILTER("No.", '<>%1', rec."No.");
//                                              RecPaymentLineAV2.SETRANGE("Commande N°", RecPaymentLineAV."Commande N°");
//                                              IF RecPaymentLineAV2.FINDFIRST THEN
//                                                  ERROR('N° Bon commande déja affecter à lavance N°: %1', RecPaymentLineAV2."No.");

//                                          END;
//                                      END;
//                                      //**********************
//                                  END
//                                  ELSE
//                                      ERROR('Fournisseur Non Autoriser pour avoir une Avance');

//                              END;
//                          END;
//                          //**********************
//                          // MH SORO 03-05-2023

//                          CurrPage.Lines.page.Application;
//                      end;
//                  }*/
//             action("* - Imp Traite")
//             {
//                 ApplicationArea = all;
//                 Caption = '* - Imp Traite';
//                 // Promoted = true;
//                 // PromotedCategory = Process;

//                 trigger OnAction()
//                 begin


//                     IF rec.Valider THEN ERROR(Text005);
//                     // MH SORO 03-05-2023
//                     /*

//                     IF ("Payment Class"='AVANCE-FRS-CHEQ') OR ("Payment Class"='AVANCE-FRS-TRT') THEN
//                       BEGIN

//                          RecPaymentLineAV.RESET();
//                          RecPaymentLineAV.SETRANGE("No.","No.");
//                          IF RecPaymentLineAV.FINDFIRST THEN
//                            BEGIN
//                            RecVendor.RESET();
//                            IF RecVendor.GET(RecPaymentLineAV."Code compte") THEN;
//                            IF (RecVendor."Autoriser Avance"= TRUE) OR ("Autoriser avance Fournisseur"=TRUE) THEN
//                              BEGIN
//                              //************************
//                               IF RecPaymentLineAV."Commande N°"='' THEN ERROR('Champs oblogatoire : N° Commande')
//                               ELSE
//                               BEGIN
//                                  RecPurchaseHeader.RESET();
//                                  RecPurchaseHeader.SETRANGE("No.",RecPaymentLineAV."Commande N°");
//                                  IF NOT RecPurchaseHeader.FINDFIRST THEN ERROR('N° Bon commande n existe pas')
//                                  ELSE
//                                  BEGIN
//                                     RecPaymentLineAV2.RESET();
//                                     RecPaymentLineAV2.SETFILTER("No.",'<>%1',"No.");
//                                     RecPaymentLineAV2.SETRANGE("Commande N°",RecPaymentLineAV."Commande N°");
//                                             IF RecPaymentLineAV2.FINDFIRST THEN ERROR('N° Bon commande déja affecter à lavance N°: %1',RecPaymentLineAV2
//                     ."
//                     No
//                     ."
//                     );

//                                  END;
//                               END;
//                               //**********************
//                               END
//                               ELSE ERROR('Fournisseur Non Autoriser pour avoir une Avance');

//                            END;
//                       END;
//                     //**********************
//                     // MH SORO 03-05-2023
//                     */

//                     CurrPage.Lines.page.GetImprimer;
//                     CLEAR(RepTraiteFournisseur);
//                     RecPaymentHeader.SETRANGE("No.", rec."No.");
//                     //REPORT.RUNMODAL(50048,TRUE,TRUE,RecPaymentHeader);
//                     RepTraiteFournisseur.GetNumberLIne(CurrPage.Lines.page.GetLineNumber);
//                     RepTraiteFournisseur.SETTABLEVIEW(RecPaymentHeader);
//                     RepTraiteFournisseur.RUNMODAL;
//                     CurrPage.Lines.page.IsPrinted;

//                 end;
//             }
//             action("2 - Fractionner")
//             {
//                 ApplicationArea = all;
//                 Caption = '2 - Fractionner';
//                 // Promoted = true;
//                 // PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     IF rec.Valider THEN ERROR(Text005);
//                     CurrPage.Lines.page.fractLine;
//                 end;
//             }
//             action("* - Imp Cheque")
//             {
//                 ApplicationArea = all;
//                 Caption = '* - Imp Cheque';
//                 // Promoted = true;
//                 // PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     IF rec.Valider THEN ERROR(Text005);

//                     // MH SORO 03-05-2023
//                     /*

//                     IF ("Payment Class"='AVANCE-FRS-CHEQ') OR ("Payment Class"='AVANCE-FRS-TRT') THEN
//                       BEGIN

//                          RecPaymentLineAV.RESET();
//                          RecPaymentLineAV.SETRANGE("No.","No.");
//                          IF RecPaymentLineAV.FINDFIRST THEN
//                            BEGIN
//                            RecVendor.RESET();
//                            IF RecVendor.GET(RecPaymentLineAV."Code compte") THEN;
//                            IF (RecVendor."Autoriser Avance"= TRUE) OR ("Autoriser avance Fournisseur"=TRUE) THEN
//                              BEGIN
//                              //************************
//                               IF RecPaymentLineAV."Commande N°"='' THEN ERROR('Champs oblogatoire : N° Commande')
//                               ELSE
//                               BEGIN
//                                  RecPurchaseHeader.RESET();
//                                  RecPurchaseHeader.SETRANGE("No.",RecPaymentLineAV."Commande N°");
//                                  IF NOT RecPurchaseHeader.FINDFIRST THEN ERROR('N° Bon commande n existe pas')
//                                  ELSE
//                                  BEGIN
//                                     RecPaymentLineAV2.RESET();
//                                     RecPaymentLineAV2.SETFILTER("No.",'<>%1',"No.");
//                                     RecPaymentLineAV2.SETRANGE("Commande N°",RecPaymentLineAV."Commande N°");
//                                             IF RecPaymentLineAV2.FINDFIRST THEN ERROR('N° Bon commande déja affecter à lavance N°: %1',RecPaymentLineAV2
//                     ."
//                     No
//                     ."
//                     );

//                                  END;
//                               END;
//                               //**********************
//                               END
//                               ELSE ERROR('Fournisseur Non Autoriser pour avoir une Avance');

//                            END;
//                       END;
//                     //**********************
//                     // MH SORO 03-05-2023
//                     */
//                     CLEAR(RepCheque);
//                     CurrPage.Lines.page.GetImprimer;
//                     RecPaymentHeader.SETRANGE("No.", rec."No.");
//                     RepCheque.GetNumberLIne(CurrPage.Lines.page.GetLineNumber);
//                     RepCheque.SETTABLEVIEW(RecPaymentHeader);
//                     RepCheque.RUNMODAL;
//                     CurrPage.Lines.page.IsPrinted;

//                 end;
//             }
//             action("3 - Confirmer")
//             {
//                 ApplicationArea = all;
//                 Caption = '3 - Confirmer';
//                 // Promoted = true;
//                 // PromotedCategory = Process;

//                 trigger OnAction()
//                 var
//                     RecAvancePaymentLine: Record "Payment Line";

//                     Text1: Label 'There is no line to treat.';
//                 begin
//                     // MH SORO 03-05-2023

//                     /*
//                     IF ("Payment Class"='AVANCE-FRS-CHEQ') OR ("Payment Class"='AVANCE-FRS-TRT') THEN
//                       BEGIN

//                          RecPaymentLineAV.RESET();
//                          RecPaymentLineAV.SETRANGE("No.","No.");
//                          IF RecPaymentLineAV.FINDFIRST THEN
//                            BEGIN
//                            RecVendor.RESET();
//                            IF RecVendor.GET(RecPaymentLineAV."Code compte") THEN;
//                            IF (RecVendor."Autoriser Avance"= TRUE) OR ("Autoriser avance Fournisseur"=TRUE) THEN
//                              BEGIN
//                              //************************
//                               IF RecPaymentLineAV."Commande N°"='' THEN ERROR('Champs oblogatoire : N° Commande')
//                               ELSE
//                               BEGIN
//                                  RecPurchaseHeader.RESET();
//                                  RecPurchaseHeader.SETRANGE("No.",RecPaymentLineAV."Commande N°");
//                                  IF NOT RecPurchaseHeader.FINDFIRST THEN ERROR('N° Bon commande n existe pas')
//                                  ELSE
//                                  BEGIN
//                                     RecPaymentLineAV2.RESET();
//                                     RecPaymentLineAV2.SETFILTER("No.",'<>%1',"No.");
//                                     RecPaymentLineAV2.SETRANGE("Commande N°",RecPaymentLineAV."Commande N°");
//                                             IF RecPaymentLineAV2.FINDFIRST THEN ERROR('N° Bon commande déja affecter à lavance N°: %1',RecPaymentLineAV2
//                     ."
//                     No
//                     ."
//                     );

//                                  END; 
//                               END;
//                               //**********************
//                               END
//                               ELSE ERROR('Fournisseur Non Autoriser pour avoir une Avance');

//                            END;
//                       END;
//                     //**********************
//                     // MH SORO 03-05-2023
//                     */
//                     // MH SORO 04-06-2021
//                     RecUserSetup.GET(USERID);
//                     IF RecUserSetup."Appliquer Blocage Date Compatb" = TRUE THEN
//                         IF (rec."Payment Class" <> 'PAIEMENT') AND (rec."Payment Class" <> 'LOYER') THEN
//                             IF rec."Posting Date" <> TODAY THEN ERROR(Text0023);
//                     // MH SORO 04-06-2021


//                     IF rec.Valider THEN ERROR(Text005);

//                     // RB SORO 08/09/2015 SAISIE MONTANT RETENUE A LA SOURCE
//                     IF (rec."Payment Class" = 'ENC-CHEQUE') OR (rec."Payment Class" = 'ENC-TRAITE') OR (rec."Payment Class" = 'ENC-ESPECE') THEN BEGIN
//                         RecPaymentLineRetenue.SETRANGE("No.", rec."No.");
//                         IF RecPaymentLineRetenue.FINDFIRST THEN
//                             REPEAT
//                                 IF RecPaymentLineRetenue."Code Retenue à la Source" <> '' THEN BEGIN
//                                     IF (RecPaymentLineRetenue."Montant Retenue" = 0) AND (RecPaymentLineRetenue."Montant Retenue Validé" = 0) THEN
//                                         ERROR(Text017);
//                                 END;
//                             UNTIL RecPaymentLineRetenue.NEXT = 0;
//                     END;
//                     // RB SORO 08/09/2015 SAISIE MONTANT RETENUE A LA SOURCE

//                     IF rec."Status No." = 0 THEN ChangerStatut(1);
//                     //REC.TestNbOfLines;
//                     //GL2024 License
//                     rec.CalcFields("No. of Lines");
//                     if rec."No. of Lines" = 0 then
//                         Error(Text1);
//                     //GL2024 License

//                     Steps.SETRANGE("Payment Class", rec."Payment Class");
//                     Steps.SETRANGE("Previous Status", rec."Status No.");
//                     Steps.SETFILTER("Action Type", '<>%1&<>%2&<>%3', Steps."Action Type"::Report, Steps."Action Type"::File, Steps."Action Type"::
//                       "Create New Document");
//                     //>> HJ DSFT 09 12 2010
//                     IF RecUser.GET(UPPERCASE(USERID)) THEN;
//                     IF RecUser.Agence <> '' THEN Steps.SETFILTER(Agence, '%1|%2', '', RecUser.Agence);
//                     //>> HJ DSFT 09 12 2010
//                     ValidatePayment;
//                     //IBK DSFT
//                     IF PaymentStatus_gr.GET(rec."Payment Class", rec."Status No.") THEN
//                         IF PaymentStatus_gr."Référence Chèque" THEN BEGIN
//                             PaymentLine_gr.RESET;
//                             Chèquemouvementé_gr.RESET;
//                             PaymentLine_gr.SETRANGE("No.", rec."No.");
//                             IF PaymentLine_gr.FINDFIRST THEN
//                                 REPEAT
//                                     IF PaymentLine_gr."N° chèque" = 0 THEN
//                                         ERROR(STRSUBSTNO(Text010, PaymentLine_gr."Line No."));
//                                     Chèquemouvementé_gr.GET(rec."Account No.", PaymentLine_gr."Référence chèque", PaymentLine_gr."N° chèque");
//                                     //IF Chèquemouvementé_gr.Statut=Chèquemouvementé_gr.Statut::Confirmer THEN
//                                     //ERROR( STRSUBSTNO (Text011 , PaymentLine_gr."N° chèque"));
//                                     IF PaymentLine_gr."Status No." IN [1000, 3000] THEN BEGIN
//                                         Chèquemouvementé_gr.Statut := Chèquemouvementé_gr.Statut::Confirmer;
//                                         Chèquemouvementé_gr."N° Bordereu" := PaymentLine_gr."No.";
//                                         Chèquemouvementé_gr."N° Ligne Bordereu" := PaymentLine_gr."Line No.";

//                                         Chèquemouvementé_gr.MODIFY;
//                                     END
//                                     ELSE
//                                         IF PaymentLine_gr."Status No." = 4000 THEN BEGIN
//                                             Chèquemouvementé_gr.Statut := Chèquemouvementé_gr.Statut::Comptabilisé;
//                                             Chèquemouvementé_gr."N° Bordereu" := PaymentLine_gr."No.";
//                                             Chèquemouvementé_gr."N° Ligne Bordereu" := PaymentLine_gr."Line No.";

//                                             Chèquemouvementé_gr.MODIFY;
//                                         END
//                                         ELSE
//                                             IF PaymentLine_gr."Status No." IN [5000, 6000] THEN BEGIN
//                                                 Chèquemouvementé_gr.Statut := Chèquemouvementé_gr.Statut::Annulé;
//                                                 Chèquemouvementé_gr."N° Bordereu" := PaymentLine_gr."No.";
//                                                 Chèquemouvementé_gr."N° Ligne Bordereu" := PaymentLine_gr."Line No.";

//                                                 Chèquemouvementé_gr.MODIFY;
//                                             END;

//                                 UNTIL PaymentLine_gr.NEXT = 0;
//                         END;
//                     //IBK DSFT
//                     // >> HJ DSFT 26-01-2009
//                     IF RecEntetePayement.GET(rec."No.") THEN BEGIN
//                         RecEntetePayement."Validé Par" := USERID;
//                         RecEntetePayement.MODIFY;
//                     END;
//                     // << HJ DSFT 26-01-2009

//                     // << HJ DSFT 17-03-2011
//                     IF RecSalesReceivablesSetup.GET THEN;
//                     IF RecSalesReceivablesSetup."Activer Suivi Mode Réglement" THEN BEGIN
//                         RecPaymentLine.SETRANGE("No.", rec."No.");
//                         IF RecPaymentLine.FINDFIRST THEN
//                             REPEAT
//                                 IF RecPaymentLine."Account Type" = RecPaymentLine."Account Type"::Customer THEN BEGIN
//                                     IF RecCustomer.GET(RecPaymentLine."Account No.") THEN;
//                                     IF RecPaymentClass.GET(rec."Payment Class") THEN;
//                                     IF RecPaymentMethod2.GET(RecPaymentClass."Mode Paiement") THEN IntTypeReglement := RecPaymentMethod2.Priorité;
//                                     IF RecPaymentMethod.GET(RecCustomer."Payment Method Code") THEN IntClient := RecPaymentMethod.Priorité;
//                                     IF IntClient < IntTypeReglement THEN
//                                         ERROR(Text0015, RecPaymentLine."Account No.",
//                                              RecCustomer."Payment Method Code", rec."Payment Class");
//                                 END;
//                             UNTIL RecPaymentLine.NEXT = 0;
//                     END;
//                     // << HJ DSFT 17-03-2011
//                     IF (rec."Payment Class" = 'PAIEMENT') OR (rec."Payment Class" = 'DECAISS-VIREME') THEN BEGIN
//                         RecPaymentLine.RESET;
//                         RecPaymentLine.SETRANGE("No.", rec."No.");
//                         IF RecPaymentLine.FINDFIRST THEN
//                             REPEAT
//                                 IF RecPaymentLine."Applies-to ID" <> '' THEN
//                                     IdLettrage := RecPaymentLine."Applies-to ID"
//                                 ELSE
//                                     ERROR(Text001);

//                                 //ListeFacturesLettrage.SETRANGE("ID Lettrage",IdLettrage);
//                                 //ListeFacturesLettrage.DELETEALL;

//                                 VendorLedgerEntry.SETRANGE("Applies-to ID", IdLettrage);
//                                 IF VendorLedgerEntry.FINDFIRST THEN
//                                     REPEAT
//                                         VendorLedgerEntry.CALCFIELDS("Remaining Amount");
//                                         ListeFacturesLettrage."Montant Facture" := VendorLedgerEntry."Remaining Amount";
//                                         ListeFacturesLettrage.Sequence := VendorLedgerEntry."Entry No.";
//                                         ListeFacturesLettrage.Fournisseurs := VendorLedgerEntry."Vendor No.";
//                                         ListeFacturesLettrage."Numero Facture" := VendorLedgerEntry."Document No.";
//                                         ListeFacturesLettrage."Montant Facture" := VendorLedgerEntry."Remaining Amount";
//                                         ListeFacturesLettrage."Date Document" := VendorLedgerEntry."Posting Date";
//                                         ListeFacturesLettrage.Description := VendorLedgerEntry.Description;
//                                         ListeFacturesLettrage."ID Lettrage" := RecPaymentLine."Applies-to ID";
//                                         ListeFacturesLettrage."Numero Reglement" := rec."No.";
//                                         ListeFacturesLettrage."Nom Et Prenom" := RecPaymentLine.Libellé;
//                                         ListeFacturesLettrage."Montant Reglement" := RecPaymentLine."Amount (LCY)";
//                                         ListeFacturesLettrage.RS := RecPaymentLine."Code Retenue à la Source";
//                                         ListeFacturesLettrage."Montant Retenu" := RecPaymentLine."Montant Retenue";
//                                         ListeFacturesLettrage."Date Reglement" := RecPaymentLine."Posting Date";
//                                         ListeFacturesLettrage."Compte Bancaire" := RecPaymentLine."Compte Bancaire";
//                                         ListeFacturesLettrage.Banque := RecPaymentLine.Banque;
//                                         ListeFacturesLettrage."Date Echeance" := RecPaymentLine."Due Date";
//                                         ListeFacturesLettrage."Numero Piece" := RecPaymentLine."External Document No.";
//                                         ListeFacturesLettrage."Mode Paiement" := RecPaymentLine."Mode Paiement";
//                                         ListeFacturesLettrage."Num Ligne Reglement" := RecPaymentLine."Line No.";
//                                         IF ListeFacturesLettrage.INSERT THEN;
//                                         CduPurchPost.ChangerStatutFacture(VendorLedgerEntry."Document No.", 1);
//                                     UNTIL VendorLedgerEntry.NEXT = 0;

//                             UNTIL RecPaymentLine.NEXT = 0;

//                     END;
//                     //MESSAGE(FORMAT(Steps."Statut Facture"));
//                     ChangerStatut(Steps."Statut Facture")
//                     //IF Steps."Next Status"=6000 THEN ChangerStatut(3);
//                     //IF Steps."Next Status"=10000 THEN ChangerStatut(1);

//                 end;
//             }
//             action("* - Imp Certif Ret.")
//             {
//                 ApplicationArea = all;
//                 Caption = '* - Imp Certif Ret.';
//                 // Promoted = true;
//                 // PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     //IF Valider THEN ERROR(Text005);

//                     RecPaymentHeader.SETRANGE("No.", rec."No.");
//                     REPORT.RUNMODAL(50046, TRUE, TRUE, RecPaymentHeader);
//                 end;
//             }
//             action("*- Imp Ord Paiement")
//             {
//                 ApplicationArea = all;
//                 Caption = '*- Imp Ord Paiement';
//                 // Promoted = true;
//                 // PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     IF rec."Payment Class" = 'LOYER' THEN BEGIN
//                         IF rec.Valider THEN ERROR(Text005);
//                         CLEAR(RepPiecePaiementLoyer);
//                         RecPaymentHeader.SETRANGE("No.", rec."No.");
//                         RepPiecePaiementLoyer.GetNumberLIne(CurrPage.Lines.page.GetLineNumber);
//                         RepPiecePaiementLoyer.SETTABLEVIEW(RecPaymentHeader);
//                         RepPiecePaiementLoyer.RUNMODAL;

//                     END
//                     ELSE BEGIN
//                         IF rec.Valider THEN ERROR(Text005);
//                         CLEAR(RepPiecePaiement);
//                         RecPaymentHeader.SETRANGE("No.", rec."No.");
//                         RepPiecePaiement.GetNumberLIne(CurrPage.Lines.page.GetLineNumber);
//                         RepPiecePaiement.SETTABLEVIEW(RecPaymentHeader);
//                         RepPiecePaiement.RUNMODAL;
//                     END;
//                     ChangerStatut(2);
//                 end;
//             }
//             action("IMP ORDRE VIR")
//             {
//                 ApplicationArea = all;
//                 Caption = '*- Imp Ord Virement';
//                 // Promoted = true;
//                 // PromotedCategory = Process;
//                 //   Visible = "IMP ORDRE VIRVisible";

//                 trigger OnAction()
//                 begin
//                     CLEAR(OrdreVirementFournisseur);
//                     RecPaymentHeader.SETRANGE("No.", rec."No.");
//                     OrdreVirementFournisseur.SETTABLEVIEW(RecPaymentHeader);
//                     OrdreVirementFournisseur.RUNMODAL;
//                 end;
//             }
//             action(BTNAutoriserAvanceF)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Autoriser avance Fournisseur';
//                 // Promoted = true;
//                 // PromotedCategory = Process;
//                 Visible = BTNAutoriserAvanceFVisible;

//                 trigger OnAction()
//                 begin
//                     IF RecUserSetupAV.GET(USERID) THEN
//                         IF (RecUserSetupAV."Approbateur Autoriser Avance F") AND
//                            ((rec."Payment Class" = 'AVANCE-FRS-CHEQ') OR (rec."Payment Class" = 'AVANCE-FRS-TRT')) THEN BEGIN
//                             IF NOT CONFIRM('Voulez-vous Autoriser cette Avance?', FALSE) THEN EXIT;
//                             rec."Autoriser avance Fournisseur" := TRUE;
//                             rec."Approuvé par" := USERID;
//                             rec."Date Approbation" := TODAY;
//                             rec.MODIFY;
//                         END;
//                 end;
//             }
//             action(ValiderPaiement)
//             {
//                 ApplicationArea = all;
//                 Caption = '4 - Validation Paiements';
//                 // Promoted = true;
//                 // PromotedCategory = Process;
//                 Visible = ValiderPaiementVisible;

//                 trigger OnAction()
//                 begin
//                     IF RecUser.GET(UPPERCASE(USERID)) THEN;
//                     IF NOT RecUser."Validation Paiement" THEN ERROR(Text016);
//                     IF rec."Status No." < 6000 THEN ERROR(Text012);
//                     PaymentHeader4.SETRANGE("N° Brouillard", rec."No.");
//                     IF PaymentHeader4.FINDFIRST THEN ERROR(Text018);
//                     IF rec.Valider THEN ERROR(Text005);
//                     IF NOT CONFIRM(Text002, FALSE) THEN EXIT;
//                     RecPaymentLine.RESET;
//                     RecPaymentLine.SETRANGE("No.", rec."No.");
//                     IF rec."Payment Class" = 'PAIEMENT' THEN BEGIN
//                         IF RecPaymentLine.FINDFIRST THEN
//                             IF RecPaymentLine."Applies-to ID" <> '' THEN
//                                 IdLettrage := RecPaymentLine."Applies-to ID"
//                             ELSE
//                                 ERROR(Text001);

//                         ListeFacturesLettrage.SETRANGE("ID Lettrage", IdLettrage);
//                         ListeFacturesLettrage.DELETEALL;

//                         VendorLedgerEntry.SETRANGE("Applies-to ID", IdLettrage);
//                         IF VendorLedgerEntry.FINDFIRST THEN
//                             REPEAT
//                                 VendorLedgerEntry.CALCFIELDS("Remaining Amount");
//                                 ListeFacturesLettrage."Montant Facture" := VendorLedgerEntry."Remaining Amount";
//                                 ListeFacturesLettrage.Sequence := VendorLedgerEntry."Entry No.";
//                                 ListeFacturesLettrage.Fournisseurs := VendorLedgerEntry."Vendor No.";
//                                 ListeFacturesLettrage."Numero Facture" := VendorLedgerEntry."Document No.";
//                                 ListeFacturesLettrage."Montant Facture" := VendorLedgerEntry."Remaining Amount";
//                                 ListeFacturesLettrage."Date Document" := VendorLedgerEntry."Posting Date";
//                                 ListeFacturesLettrage.Description := VendorLedgerEntry.Description;
//                                 ListeFacturesLettrage."ID Lettrage" := VendorLedgerEntry."Applies-to ID";
//                                 ListeFacturesLettrage."Numero Reglement" := rec."No.";
//                                 ListeFacturesLettrage.INSERT;

//                             UNTIL VendorLedgerEntry.NEXT = 0;
//                     END;
//                     CreerBOR;
//                     IF RecPaymentHeader.GET(rec."No.") THEN BEGIN
//                         RecPaymentHeader.Valider := TRUE;
//                         RecPaymentHeader.MODIFY;
//                     END;
//                     ChangerStatut(4);
//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         IF RecUserSetupAV.GET(USERID) THEN
//             IF (RecUserSetupAV."Approbateur Autoriser Avance F") AND
//                ((rec."Payment Class" = 'AVANCE-FRS-CHEQ') OR (rec."Payment Class" = 'AVANCE-FRS-TRT'))
//                     = TRUE THEN
//                 BTNAutoriserAvanceFVisible := TRUE
//             ELSE
//                 BTNAutoriserAvanceFVisible := FALSE;


//         IF (rec."Payment Class" = 'AVANCE-FRS-CHEQ') OR (rec."Payment Class" = 'AVANCE-FRS-TRT') THEN BEGIN
//             AutorisationAvanceVisible := TRUE;
//             AutoriseravanceFournisseurVisi := TRUE;
//             "Approuvé parVisible" := TRUE;
//             "Date ApprobationVisible" := TRUE;
//         END
//         ELSE BEGIN
//             AutorisationAvanceVisible := FALSE;
//             AutoriseravanceFournisseurVisi := FALSE;
//             "Approuvé parVisible" := FALSE;
//             "Date ApprobationVisible" := FALSE;

//         END;



//         IF (rec."Payment Class" = 'PAIEMENT') OR (rec."Payment Class" = 'LOYER') THEN
//             ValiderPaiementVisible := TRUE ELSE
//             ValiderPaiementVisible := FALSE;
//         CurrPage.Lines.page.EDITABLE(TRUE);

//         IF rec."Payment Class" <> 'DECAISS-VIREME' THEN
//             "IMP ORDRE VIRVisible" := FALSE
//         ELSE
//             IF rec."Payment Class" = 'DECAISS-VIREME' THEN "IMP ORDRE VIRVisible" := TRUE;

//         // << HJ DSFT 08-11-2009
//         IF RecUser.Niveau = 0 THEN ERROR(Text011);
//         IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, USERID);
//         IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
//             rec.SETRANGE(Agence, RecUser.Agence)
//         ELSE
//             rec.SETRANGE(Agence);
//         GetABK;
//         // >> HJ DSFT 08 11 2010
//         TxtEtapesSuivante := 'Action : ';
//         REcPaymentSteps.SETRANGE("Payment Class", rec."Payment Class");
//         REcPaymentSteps.SETRANGE("Previous Status", rec."Status No.");
//         IF REcPaymentSteps.FIND('-') THEN
//             REPEAT
//                 REcPaymentSteps.CALCFIELDS("Next Status Name");
//                 IF (REcPaymentSteps."Action Type" = 0) OR (REcPaymentSteps."Action Type" = 1) THEN
//                     TxtEtapesSuivante := TxtEtapesSuivante + ' < Valider >:' + REcPaymentSteps.Name;
//                 IF (REcPaymentSteps."Action Type" = 2) THEN
//                     TxtEtapesSuivante := TxtEtapesSuivante + ' < Imprimer > :' + REcPaymentSteps."Next Status Name";
//                 IF (REcPaymentSteps."Action Type" = 3) THEN
//                     TxtEtapesSuivante := TxtEtapesSuivante + ' < Fichier > :' + REcPaymentSteps."Next Status Name";
//                 IF (REcPaymentSteps."Action Type" = 4) THEN
//                     TxtEtapesSuivante := TxtEtapesSuivante + ' < Créer Bordereau > :' + REcPaymentSteps."Next Status Name";

//             UNTIL REcPaymentSteps.NEXT = 0;

//         // >> HJ DSFT 08 11 2010

//         // RB SORO 26/03/2015
//         /*
//         IF  ("Status No." = 0) AND ("Payment Class" = 'DECAISS-TRAITE') OR ("Payment Class" ='DECAISS-CHEQUE') THEN
//         BEGIN
//            Currpage.Avance.EDITABLE := TRUE;
//         END
//         ELSE
//         BEGIN
//            Currpage.Avance.EDITABLE := FALSE;
//         END;
//         */
//         // RB SORO 26/03/2015

//     end;

//     trigger OnInit()
//     begin
//         "IMP ORDRE VIRVisible" := TRUE;
//         ValiderPaiementVisible := TRUE;
//         BTNAutoriserAvanceFVisible := TRUE;
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     var
//         NoSeries: Codeunit "No. Series";
//         PaymentClass: Record "Payment Class";
//         NoSeriesManagement: Codeunit NoSeriesManagement;


//         IsHandled: Boolean;
//     begin
//         // >> HJ DSFT 21-01-2009
//         IF RecUser.GET(UPPERCASE(USERID)) THEN rec.Agence := RecUser.Agence;
//         rec.Utilisateur := UPPERCASE(USERID);
//         // << HJ DSFT 21-01-2009

//         //GL2024
//         if PaymentClass.Get(rec."Payment Class") then;
//         /*GL2024   if rec."No." = '' then begin
//               if PAGE.RunModal(PAGE::"Payment Class List", PaymentClass2) = ACTION::LookupOK then
//                   PaymentClass := PaymentClass2;
//               PaymentClass.TestField("Header No. Series");*/


//         NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(PaymentClass."Header No. Series", xRec."No. Series", 0D, rec."No.", rec."No. Series", IsHandled);
//         if not IsHandled then begin

//             rec."No. Series" := PaymentClass."Header No. Series";
//             if NoSeries.AreRelated(rec."No. Series", xRec."No. Series") then
//                 rec."No. Series" := xRec."No. Series";
//             rec."No." := NoSeries.GetNextNo(rec."No. Series");

//             NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(rec."No. Series", PaymentClass."Header No. Series", 0D, rec."No.");
//         end;
//         rec.Validate("Payment Class", PaymentClass.Code);
//         // GL2024    end;
//         //GL2024
//         rec."Posting Date" := WorkDate();
//         rec."Document Date" := WorkDate();
//         rec.Validate("Account Type", rec."Account Type"::"Bank Account");
//     end;

//     trigger OnOpenPage()
//     begin
//         IF RecUserSetupAV.GET(USERID) THEN
//             IF (RecUserSetupAV."Approbateur Autoriser Avance F") AND
//                ((rec."Payment Class" = 'AVANCE-FRS-CHEQ') OR (rec."Payment Class" = 'AVANCE-FRS-TRT'))
//                     = TRUE THEN
//                 BTNAutoriserAvanceFVisible := TRUE
//             ELSE
//                 BTNAutoriserAvanceFVisible := FALSE;


//         IF (rec."Payment Class" = 'AVANCE-FRS-CHEQ') OR (rec."Payment Class" = 'AVANCE-FRS-TRT') THEN BEGIN
//             AutorisationAvanceVisible := TRUE;
//             AutoriseravanceFournisseurVisi := TRUE;
//             "Approuvé parVisible" := TRUE;
//             "Date ApprobationVisible" := TRUE;
//         END
//         ELSE BEGIN
//             AutorisationAvanceVisible := FALSE;
//             AutoriseravanceFournisseurVisi := FALSE;
//             "Approuvé parVisible" := FALSE;
//             "Date ApprobationVisible" := FALSE;

//         END;


//         // << HJ DSFT 21-01-2009
//         RecUser.GET(UPPERCASE(USERID));
//         IF RecUser.Niveau = 0 THEN ERROR(Text0011);
//         IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, UPPERCASE(USERID));
//         IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
//             rec.SETRANGE(Agence, RecUser.Agence)
//         ELSE
//             rec.SETRANGE(Agence);
//         GetABK;
//         // << HJ DSFT 21-01-2009
//         IF rec."Payment Class" <> 'DECAISS-VIREME' THEN
//             "IMP ORDRE VIRVisible" := FALSE
//         ELSE
//             IF rec."Payment Class" = 'DECAISS-VIREME' THEN "IMP ORDRE VIRVisible" := TRUE;
//         OnActivateForm;
//     end;

//     var
//         ChangeExchangeRate: Page "Change Exchange Rate";
//         Navigate: Page Navigate;
//         Steps: Record "Payment Step";

//         Text001: label 'Lettrage Non Etabli';
//         Text002: label 'Lancer Le Traitement ?';
//         Text003: label 'Traitement Achever Avec Succé';
//         Text004: label 'Vous Devez Confirmer D''abords';
//         Text005: label 'Deja Valider';
//         Text006: label 'Une ligne n''est pas validée. Êtes-vous sur de vouloir archiver ce document ?';
//         Text007: label 'Certaines lignes ne sont pas validées. Êtes-vous sur de vouloir archiver ce document ?';
//         Text008: label 'Etes-vous sur de vouloir archiver ce document ?';
//         Text009: label 'Souhaitez-vous archiver ce document ?';
//         "-MBK-": Integer;
//         PaymentStatus_gr: Record "Payment Status";
//         PaymentLine_gr: Record "Payment Line";
//         "Chèquemouvementé_gr": Record "Chèque mouvementé";

//         Text010: Label 'Veuillez saisir le N° Chèque dans la ligne %1';
//         Text011: Label 'N° chèque %1 utlisé plus d''une fois';
//         RecBankAccount: Record "Bank Account";
//         "-HJ-": Integer;
//         RecAutorisationEtapes: Record "Autorisation Etapes2";
//         RecUser: Record "User Setup";
//         RecEntetePayement: Record "Payment Header";
//         RecPaymentLine: Record "Payment Line";
//         RecPaymentLine2: Record "Payment Line";
//         RecPaymentLine3: Record "Payment Line";
//         RecBank: Record "Bank Account";
//         REcPaymentSteps: Record "Payment Step";
//         RecPaymentStatus: Record "Payment Status";
//         TxtEtapesSuivante: Text[1000];
//         RecEntete: Record "Payment Header";
//         Text012: Label 'Piece Doit Avoir Statut Signee Pour Pouvoir Comptabilisée';

//         Text0010: Label 'Vous N''ete Pas Autorise A Cette Etape %1,  %2,  %3 ; Consulter Votre Administrateur';
//         Text0011: Label 'Vous N''ete Pas Autorisé Au Module Encaissement - Decaissement';
//         Text0012: Label 'Votre Agence %1 Est Différente De Celle De L''Etape ( %2 )';
//         Text013: Label 'Changement Agence Non Permis A Ce Statut';
//         Text014: Label 'Vous n''etes pas autoriser à Changer L''agence';
//         RecAgence: Record "Chantier Loyer";
//         RecPaymentMethod: Record "Payment Method";
//         RecPaymentMethod2: Record "Payment Method";
//         RecSalesReceivablesSetup: Record "Sales & Receivables Setup";
//         RecCustomer: Record Customer;
//         RecPaymentClass: Record "Payment Class";
//         IntClient: Integer;
//         IntTypeReglement: Integer;
//         Text0015: Label 'Mode Paiement Client N° %1 ( %2 ) Ne Peut Pas Etre %3';
//         Text0016: Label 'Vous Devez Confirmer Le Crédit';
//         Text0017: Label 'Confirmer Cette Action';
//         Text0018: Label 'Veuillez Préciser Nombre Mois Echeancier';
//         GeneralLedgerSetup: Record "General Ledger Setup";
//         GenJournalLine: Record "Gen. Journal Line";
//         Text0019: Label 'Crédit Déja Emis';
//         Text0020: Label 'Echeance Déja Comptabilisé';
//         Text0021: Label 'Ecritures Déja Comptabilisées';
//         Text0022: Label 'Ce Crédit Na Pas Etais Emis';
//         RecPaymentHeader: Record "Payment Header";
//         ListeFacturesLettrage: Record "Liste Factures Lettrage";
//         VendorLedgerEntry: Record "Vendor Ledger Entry";
//         IdLettrage: Code[50];
//         DernierNumero: Integer;
//         SommeInitial: Decimal;
//         RestMontant: Decimal;
//         RepTraiteFournisseur: Report "* Traite Fournisseur";
//         RepCheque: Report CHEQUE;
//         RepPiecePaiementLoyer: Report "Pièce de Paiement Loyer";
//         RepPiecePaiement: Report "Pièce de Paiement";
//         CduPurchPost: Codeunit "PurchPostEvent";

//         "// RB SORO 08/09/2015": Integer;
//         RecPaymentLineRetenue: Record "Payment Line";

//         Text015: Label 'Paiement Signé ?';
//         Text016: Label 'Vous n''avez pas Le Droit de Valider Les Paiements, Consulter Votre Administrateur';
//         Text018: Label 'Bordereau Lié a Un Reglement';
//         Text017: Label 'Erreur, vous devez introduire le montant de la reteune à la source';
//         Text0023: Label 'Date Comptabilisation Non Valide!!';



//         PaymentHeader4: Record "Payment Header";
//         OrdreVirementFournisseur: Report "Ordre Virement Fournisseur";
//         RecUserSetup: Record "User Setup";
//         RecUserSetup2: Record "User Setup";
//         RecPaymentLineAV: Record "Payment Line";
//         RecPurchaseHeader: Record "Purchase Header";
//         RecPaymentLineAV2: Record "Payment Line";
//         RecVendor: Record Vendor;
//         RecUserSetupAV: Record "User Setup";

//         BTNAutoriserAvanceFVisible: Boolean;
//         //GL2024
//         [InDataSet]
//         AutorisationAvanceVisible: Boolean;

//         AutoriseravanceFournisseurVisi: Boolean;

//         "Approuvé parVisible": Boolean;

//         "Date ApprobationVisible": Boolean;

//         ValiderPaiementVisible: Boolean;

//         "IMP ORDRE VIRVisible": Boolean;
//         PaymentHeader: Record "Payment Header";
//         PaymentClass: Record "Payment Class";
//         PaymentClass2: Record "Payment Class";


//     procedure ValidatePayment()
//     var
//         PaymentHeader: Record "Payment Header";
//         PaymentLine: Record "Payment Line";
//         LPaymentLine: Record "Payment Line";
//         PaymentStatus: Record "Payment Status";
//         LPaymentClass: Record "Payment Class";
//         Ok: Boolean;
//         PostingStatement: Codeunit "Payment Management Copy";
//         Options: Text[400];
//         Choice: Integer;
//         I: Integer;
//         CduGenJnPostLine: Codeunit "Gen. Jnl.-Post Line_CDU12";
//     begin
//         // >> HJ DELTA 11-02-2014 Verifer Si Montant = Zero

//         LPaymentLine.RESET;
//         LPaymentLine.SETRANGE("No.", rec."No.");
//         IF LPaymentLine.FINDFIRST THEN
//             REPEAT
//                 IF rec."Account No." <> '' THEN
//                     IF LPaymentLine."Compte Bancaire" = '' THEN BEGIN
//                         LPaymentLine."Compte Bancaire" := rec."Account No.";
//                         LPaymentLine.MODIFY;
//                     END;
//             UNTIL LPaymentLine.NEXT = 0;


//         LPaymentLine.RESET;
//         LPaymentLine.SETRANGE("No.", rec."No.");
//         IF LPaymentLine.FINDFIRST THEN
//             REPEAT
//                 LPaymentLine.TESTFIELD("Mode Paiement");
//             UNTIL LPaymentLine.NEXT = 0;


//         LPaymentLine.RESET;
//         LPaymentLine.SETRANGE("No.", rec."No.");
//         IF LPaymentLine.FINDFIRST THEN
//             REPEAT
//                 LPaymentLine.TESTFIELD(Amount);
//                 LPaymentLine.TESTFIELD("Account No.");
//                 IF rec."Payment Class" = 'PAIEMENT' THEN BEGIN
//                     LPaymentLine.TESTFIELD("Mode Paiement");
//                     LPaymentLine.TESTFIELD("Affectation Financiere");
//                     LPaymentLine.TESTFIELD(LPaymentLine."Compte Bancaire");
//                 END;
//             UNTIL LPaymentLine.NEXT = 0;
//         IF LPaymentClass.GET(rec."Payment Class") THEN BEGIN
//             IF LPaymentClass."Piece De Paiement Obligatoire" THEN BEGIN
//                 LPaymentLine.RESET;
//                 LPaymentLine.SETRANGE("No.", rec."No.");
//                 IF LPaymentLine.FINDFIRST THEN
//                     REPEAT
//                         LPaymentLine.TESTFIELD("External Document No.");
//                     UNTIL LPaymentLine.NEXT = 0;
//             END;
//             IF LPaymentClass."Banque Bénéficiaire Obligatoir" THEN BEGIN
//                 LPaymentLine.RESET;
//                 LPaymentLine.SETRANGE("No.", rec."No.");
//                 IF LPaymentLine.FINDFIRST THEN
//                     REPEAT
//                         LPaymentLine.TESTFIELD("Bank Account Code");
//                     UNTIL LPaymentLine.NEXT = 0;
//             END;

//         END;
//         // >> HJ DELTA 11-02-2014 Verifer Si Montant = Zero
//         I := Steps.COUNT;
//         Ok := FALSE;
//         IF I = 1 THEN BEGIN
//             Steps.FIND('-');
//             //GL2024      Ok := CONFIRM(Steps.Name, TRUE);
//         END ELSE
//             IF I > 1 THEN BEGIN
//                 IF Steps.FIND('-') THEN BEGIN
//                     REPEAT
//                         IF Options = '' THEN
//                             Options := Steps.Name
//                         ELSE
//                             Options := Options + ',' + Steps.Name;
//                     UNTIL Steps.NEXT = 0;

//                     Choice := STRMENU(Options, 1);

//                     I := 1;
//                     IF Choice > 0 THEN BEGIN
//                         Ok := TRUE;
//                         Steps.FIND('-');
//                         WHILE Choice > I DO BEGIN
//                             I += 1;
//                             Steps.NEXT;
//                         END;
//                     END;
//                 END;
//             END;

//         // >> HJ DSFT 21-01-2009
//         RecAutorisationEtapes.SETRANGE("Type Reglement", Steps."Payment Class");
//         RecAutorisationEtapes.SETRANGE(Etape, Steps.Line);
//         RecAutorisationEtapes.SETRANGE(User, USERID);

//         IF NOT RecAutorisationEtapes.FINDFIRST THEN ERROR(Text0010, USERID, Steps."Payment Class", Steps.Line);
//         // << HJ DSFT 21-01-2009

//         // >> HJ DSFT 14-04-2009
//         IF RecUser.GET(UPPERCASE(USERID)) THEN;
//         IF RecUser.Agence <> '' THEN
//             IF Steps.Agence <> '' THEN IF rec.Agence <> Steps.Agence THEN ERROR(Text0012, rec.Agence, Steps.Agence);
//         // << HJ DSFT 14-04-2009

//         //GL2024   IF Ok THEN
//         Steps.SetFilter(
//                           "Action Type",
//                           '%1|%2|%3',
//                           Steps."Action Type"::None, Steps."Action Type"::Ledger, Steps."Action Type"::"Cancel File");
//         //GL2024 PostingStatement.Valbord(Rec, Steps);
//         PostingStatement.ProcessPaymentSteps(Rec, Steps);
//         IF PaymentStatus.GET(rec."Payment Class", Steps."Next Status") THEN BEGIN
//             PaymentLine.RESET;
//             PaymentLine.SETRANGE("No.", rec."No.");
//             PaymentLine.MODIFYALL("Type Engagement", PaymentStatus."Type Engagement");
//             PaymentLine.RESET;
//             PaymentLine.SETRANGE("No.", rec."No.");
//             PaymentLine.MODIFYALL("Header Account Type", rec."Account Type");
//             PaymentLine.RESET;
//             PaymentLine.SETRANGE("No.", rec."No.");
//             PaymentLine.MODIFYALL("Header Account No.", rec."Account No.");

//             PaymentLine.RESET;
//             PaymentLine.SETRANGE("No.", rec."No.");
//             PaymentLine.MODIFYALL("Sens Engagement", PaymentStatus."Sens Engagement");


//         END;
//         //>> HJ TC 03-12-2011
//         CduGenJnPostLine.LettrageAutomatique(rec."No.", rec."Payment Class", Steps.Line);
//         //>> HJ TC 03-12-2011
//     end;


//     procedure "// Fonction HJ DSFT"()
//     begin
//     end;


//     procedure GetABK()
//     var
//         RecLUserSetup: Record "User Setup";
//     begin
//         // >> HJ DSFT 04-10-2012
//         IF RecLUserSetup.GET(UPPERCASE(USERID)) THEN;
//         //CALCFIELDS(Valider) ;
//         IF NOT RecLUserSetup."Compte EX" THEN rec.SETRANGE(Valider, FALSE);
//         // >> HJ DSFT 04-10-2012
//     end;


//     procedure CreerBOR()
//     var
//         LPaymentLine: Record "Payment Line";
//     begin
//         RecPaymentLine3.SETRANGE("No.", rec."No.");
//         IF RecPaymentLine3.FINDLAST THEN DernierNumero := RecPaymentLine3."Line No.";
//         RecPaymentLine2.SETRANGE("No.", rec."No.");
//         IF RecPaymentLine2.FINDFIRST THEN
//             REPEAT
//                 RecPaymentHeader.INIT;
//                 RecPaymentHeader."No." := '';
//                 IF RecPaymentLine2."Mode Paiement" = RecPaymentLine2."Mode Paiement"::Cheque THEN BEGIN
//                     RecPaymentHeader.GetNoSeries('DECAISS-CHEQUE');
//                     RecPaymentHeader.VALIDATE("Payment Class", 'DECAISS-CHEQUE');

//                 END;
//                 IF RecPaymentLine2."Mode Paiement" = RecPaymentLine2."Mode Paiement"::Traite THEN BEGIN
//                     RecPaymentHeader.GetNoSeries('DECAISS-TRAITE');
//                     RecPaymentHeader.VALIDATE("Payment Class", 'DECAISS-TRAITE');
//                 END;
//                 RecPaymentHeader."Account Type" := RecPaymentHeader."Account Type"::"Bank Account";
//                 RecPaymentHeader.VALIDATE("Account No.", RecPaymentLine2."Compte Bancaire");
//                 RecPaymentHeader."N° Brouillard" := rec."No.";
//                 RecPaymentHeader."Mode Paiement" := RecPaymentLine2."Mode Paiement";
//                 RecPaymentHeader."Num Ligne" := RecPaymentLine2."Line No.";
//                 RecPaymentHeader.INSERT;
//                 RecPaymentLine.COPY(RecPaymentLine2);
//                 RecPaymentLine."No." := RecPaymentHeader."No.";

//                 RecPaymentLine."Payment Class" := RecPaymentHeader."Payment Class";
//                 RecPaymentLine."Status No." := RecPaymentHeader."Status No.";
//                 RecPaymentLine."Line No." := 10000;

//                 RecPaymentLine.INSERT(TRUE);
//                 IF RecPaymentHeader."Payment Class" = 'PAIEMENT' THEN
//                     Lettrage(RecPaymentLine."Applies-to ID", RecPaymentLine."Debit Amount" + ABS(RecPaymentLine."Montant Retenue"));
//                 // COMMIT;
//                 ValidatePayment2(RecPaymentHeader);
//                 RecPaymentLine2."Copied To No." := RecPaymentHeader."No.";
//                 RecPaymentLine2.MODIFY;
//             //page.RUN(page::"Payment Slip",RecPaymentHeader);
//             UNTIL RecPaymentLine2.NEXT = 0;
//         LPaymentLine.RESET;
//         LPaymentLine.SETRANGE("No.", rec."No.");
//         IF LPaymentLine.FINDFIRST THEN
//             REPEAT
//                 LPaymentLine."Status No." := 7000; // Payer
//                 LPaymentLine.MODIFY;
//             UNTIL LPaymentLine.NEXT = 0;
//         rec."Status No." := 7000;// payer
//         rec.MODIFY;
//         CurrPage.UPDATE;
//         MESSAGE(Text003);
//     end;


//     procedure ValidatePayment2(var ParaPaymentHeader: Record "Payment Header")
//     var
//         PaymentHeader: Record "Payment Header";
//         PaymentLine: Record "Payment Line";
//         LPaymentLine: Record "Payment Line";
//         PaymentStatus: Record "Payment Status";
//         LPaymentClass: Record "Payment Class";
//         Ok: Boolean;
//         PostingStatement: Codeunit "Payment Management Copy";
//         Options: Text[400];
//         Choice: Integer;
//         I: Integer;
//         fefrf: Page 10868;
//         CduGenJnPostLine: Codeunit "Gen. Jnl.-Post Line_CDU12";
//     begin
//         Steps.SETRANGE("Payment Class", ParaPaymentHeader."Payment Class");
//         Steps.SETRANGE("Previous Status", ParaPaymentHeader."Status No.");
//         Steps.SETFILTER("Action Type", '<>%1&<>%2&<>%3', Steps."Action Type"::Report, Steps."Action Type"::File, Steps."Action Type"::
//           "Create New Document");

//         I := Steps.COUNT;
//         Ok := FALSE;
//         IF I = 1 THEN BEGIN
//             Steps.FIND('-');
//             Ok := TRUE;
//         END ELSE
//             IF I > 1 THEN BEGIN
//                 IF Steps.FIND('-') THEN BEGIN
//                     REPEAT
//                         IF Options = '' THEN
//                             Options := Steps.Name
//                         ELSE
//                             Options := Options + ',' + Steps.Name;
//                     UNTIL Steps.NEXT = 0;

//                     Choice := 1;

//                     I := 1;
//                     IF Choice > 0 THEN BEGIN
//                         Ok := TRUE;
//                         Steps.FIND('-');
//                         WHILE Choice > I DO BEGIN
//                             I += 1;
//                             Steps.NEXT;
//                         END;
//                     END;
//                 END;
//             END;
//         //GL2024    IF Ok THEN 
//         /*  Steps.SetFilter(
//                             "Action Type",
//                             '%1|%2|%3',
//                             Steps."Action Type"::None, Steps."Action Type"::Ledger, Steps."Action Type"::"Cancel File");*/
//         //GL2024  PostingStatement.Valbord(ParaPaymentHeader, Steps);
//         PostingStatement.ProcessPaymentSteps(ParaPaymentHeader, Steps);
//         //>> HJ TC 03-12-2011
//         CduGenJnPostLine.LettrageAutomatique(rec."No.", rec."Payment Class", Steps.Line);
//         //>> HJ TC 03-12-2011
//     end;


//     procedure Lettrage(ParaIdLettrage: Code[20]; ParaMontantLettrage: Decimal)
//     var
//         LocalVendorLedgerEntry: Record "Vendor Ledger Entry";
//         MontantRestant: Decimal;
//         LocalListeFacturesLettrage: Record "Liste Factures Lettrage";
//         CduPurchasePost: Codeunit PurchPostEvent;
//     begin
//         CduPurchasePost.Lettrage(ParaIdLettrage, ParaMontantLettrage);
//     end;


//     procedure ChangerStatut(ParaStatut: Integer)
//     var
//         LettrageFactures: Record "Liste Factures Lettrage";
//     begin
//         LettrageFactures.SETRANGE("Numero Reglement", rec."No.");
//         IF LettrageFactures.FINDFIRST THEN
//             REPEAT
//                 CduPurchPost.ChangerStatutFacture(LettrageFactures."Numero Facture", ParaStatut);
//                 COMMIT;
//             UNTIL LettrageFactures.NEXT = 0;
//         // >> Mise a Jour Statut Factures
//     end;

//     local procedure DocumentDateOnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure OnActivateForm()
//     begin
//         IF rec."Payment Class" <> 'DECAISS-VIREME' THEN
//             "IMP ORDRE VIRVisible" := FALSE
//         ELSE
//             IF rec."Payment Class" = 'DECAISS-VIREME' THEN "IMP ORDRE VIRVisible" := TRUE;
//     end;
//     // //GL2024
//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin


//         rec."Payment Class" := 'PAIEMENT';
//     end;
//     // //GL2024

//     procedure AssistEdit2(OldPaymentHeader: Record "Payment Header"): Boolean
//     var
//         NoSeries: Codeunit "No. Series";

//     begin
//         PaymentHeader := Rec;
//         PaymentClass := PaymentClass2;
//         PaymentClass.TestField("Header No. Series");
//         if NoSeries.LookupRelatedNoSeries(PaymentClass."Header No. Series", OldPaymentHeader."No. Series", PaymentHeader."No. Series") then begin
//             PaymentHeader."No." := NoSeries.GetNextNo(PaymentHeader."No. Series");
//             Rec := PaymentHeader;
//             exit(true);
//         end;
//     end;
// }


