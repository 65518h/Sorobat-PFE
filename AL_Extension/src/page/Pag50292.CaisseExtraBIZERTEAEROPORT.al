//GL2024
// page 50292 "Caisse Extra BIZERTE AEROPORT"
// {
//     // //>>>MBK:05/02/2010: Référence chèque
//     // // << HJ DSFT 21-01-2009: Gestion des Utilisateurs

//     Caption = 'Caisse Extra BIZERTE AEROPORT';
//     DeleteAllowed = true;
//     PageType = Card;
//     RefreshOnActivate = true;
//     SourceTable = "Payment Header";
//     SourceTableView = WHERE("Payment Class" = CONST('CAISSEEXT'), Valider = CONST(false), "Caisse Chantier" = CONST(false), "N° Affaire" = FILTER('=BIZERTE_BASE_AERIEN' | ''));
//     ApplicationArea = all;
//     layout
//     {
//         area(content)
//         {

//             field("No."; REC."No.")
//             {
//                 Caption = 'N° Document';
//                 Editable = false;
//                 Style = Unfavorable;
//                 StyleExpr = TRUE;
//             }
//             field("Document Date"; REC."Document Date")
//             {
//                 Caption = 'Journée';
//             }
//             field("Account No."; REC."Account No.")
//             {
//                 Editable = false;
//                 Style = Strong;
//                 StyleExpr = TRUE;
//             }

//             field("Payment Class"; REC."Payment Class")
//             {

//                 Style = Strong;
//                 StyleExpr = TRUE;
//             }
//             field(Valider; REC.Valider)
//             {
//                 Editable = false;
//                 Style = Strong;
//                 StyleExpr = TRUE;
//             }
//             field("Validé Par"; REC."Validé Par")
//             {
//                 Editable = false;
//             }
//             field("N° Affaire"; REC."N° Affaire")
//             {
//                 Editable = false;
//                 Style = Strong;
//                 StyleExpr = TRUE;
//             }
//             field("Solde Caisse Bizerte Aerop"; REC."Solde Caisse Bizerte Aerop")
//             {
//                 Style = Unfavorable;
//                 StyleExpr = TRUE;
//             }
//             part(Lines; "Ligne Paiement Caisse")
//             {
//                 SubPageLink = "No." = FIELD("No.");
//             }
//             field("Amount (LCY)"; REC."Amount (LCY)")
//             {
//                 Caption = 'Montant Brouillards';
//                 Enabled = false;
//                 Style = Strong;
//                 StyleExpr = TRUE;
//             }
//         }
//     }

//     actions
//     {
//         area(Promoted)
//         {

//             actionref("Integration Paie1"; "Integration Paie") { }
//             actionref("Imprimer Bon1"; "Imprimer Bon") { }
//             actionref("Imprimer Journée De Caisse1"; "Imprimer Journée De Caisse") { }
//             actionref(Actualiser1; Actualiser) { }
//             group("P&osting1")
//             {
//                 Caption = 'P&osting';
//                 actionref("Integration Paie a La Caisse1"; "Integration Paie a La Caisse") { }
//                 actionref("Retour Paie a La Caisse1"; "Retour Paie a La Caisse") { }
//                 actionref("Imprimer Bordereau Paie a la Caisse1"; "Imprimer Bordereau Paie a la Caisse") { }
//                 actionref(Insertion1; Insertion) { }
//                 actionref(Printing1; Printing) { }
//                 actionref("Imprimer Mandat Minute1"; "Imprimer Mandat Minute") { }
//                 actionref("Imprimer Fiche de Versement1"; "Imprimer Fiche de Versement") { }
//                 actionref("Generate file1"; "Generate file") { }
//                 actionref(Valider21; Valider2) { }
//                 actionref("Réouvrir1"; "Réouvrir") { }
//                 actionref(Validate1; Validate) { }

//                 actionref("STC - BON1"; "STC - BON") { }
//                 actionref("Detail Brouillard1"; "Detail Brouillard") { }

//             }
//         }
//         area(processing)
//         {
//             action("Integration Paie")
//             {
//                 Caption = 'Integration Paie';

//                 Visible = false;

//                 trigger OnAction()
//                 begin

//                     RegroupementPaieEntete.DELETEALL;
//                     RegroupementPaie.DELETEALL;
//                     RegroupementPaieEntete."N° Caisse" := REC."No.";
//                     RegroupementPaieEntete.Date := REC."Document Date";
//                     RegroupementPaieEntete.INSERT;
//                     COMMIT;
//                     PAGE.RUNMODAL(PAGE::"Regroupement paie");
//                 end;
//             }
//             action("Imprimer Bon")
//             {
//                 Caption = 'Imprimer Bon';


//                 trigger OnAction()
//                 begin
//                     CurrPage.Lines.PAGE.GETRECORD(Line);
//                     PaymentLine2.SETRANGE(PaymentLine2."No.", Line."No.");
//                     PaymentLine2.SETRANGE(PaymentLine2."Numero Seq", Line."Numero Seq");
//                     IF Line.Provisoire = TRUE THEN
//                         REPORT.RUN(50214, TRUE, TRUE, PaymentLine2)
//                     ELSE
//                         IF Line.Avance = TRUE THEN BEGIN
//                             REPORT.RUN(50217, TRUE, TRUE, PaymentLine2);
//                         END;
//                 end;
//             }
//             action("Imprimer Journée De Caisse")
//             {
//                 Caption = 'Imprimer Journée De Caisse';


//                 trigger OnAction()
//                 begin
//                     PaymentLine.SETRANGE("No.", REC."No.");
//                     REPORT.RUNMODAL(REPORT::"Brouillard de Caisse", TRUE, TRUE, PaymentLine);
//                 end;
//             }
//             action(Actualiser)
//             {
//                 Caption = 'Actualiser';


//                 trigger OnAction()
//                 begin
//                     CurrPage.Lines.PAGE.EDITABLE(TRUE);
//                     REC."N° Affaire" := 'BIZERTE_BASE_AERIEN';
//                     REC.MODIFY;
//                 end;
//             }
//             group("P&osting")
//             {
//                 Caption = 'P&osting';
//                 action("Integration Paie a La Caisse")
//                 {
//                     Caption = 'Integration Paie a La Caisse';

//                     trigger OnAction()
//                     begin

//                         RegroupementPaieEntete.DELETEALL;
//                         RegroupementPaie.DELETEALL;
//                         RegroupementPaieEntete."N° Caisse" := REC."No.";
//                         RegroupementPaieEntete.Date := REC."Document Date";
//                         RegroupementPaieEntete.INSERT;
//                         COMMIT;
//                         PAGE.RUNMODAL(PAGE::"Regroupement paie");
//                     end;
//                 }
//                 action("Retour Paie a La Caisse")
//                 {
//                     Caption = 'Retour Paie a La Caisse';

//                     trigger OnAction()
//                     begin
//                         RegroupementPaieEntete.DELETEALL;
//                         //GL3900    RegroupementPaieRetour.DELETEALL;
//                         RegroupementPaieEntete."N° Caisse" := REC."No.";
//                         RegroupementPaieEntete.Date := REC."Document Date";
//                         RegroupementPaieEntete.INSERT;
//                         COMMIT;
//                         //GL3900    PAGE.RUNMODAL(PAGE::"Regroupement paie Retour");
//                     end;
//                 }
//                 action("Imprimer Bordereau Paie a la Caisse")
//                 {
//                     Caption = 'Imprimer Bordereau Paie a la Caisse';

//                     trigger OnAction()
//                     begin
//                         PaymentLine.SETRANGE("No.", REC."No.");
//                         REPORT.RUNMODAL(REPORT::"Bordereau Paie a la caisse", TRUE, TRUE, PaymentLine);
//                     end;
//                 }
//                 action(Insertion)
//                 {
//                     Caption = 'Insertion';

//                     trigger OnAction()
//                     begin
//                         IF GeneralLedgerSetup.GET THEN;
//                         IF NOT CONFIRM(Text016) THEN EXIT;
//                         RecEntetePayement.INIT;
//                         IF RecPaymentClass.GET(GeneralLedgerSetup."Type Caisse Ex") THEN;
//                         RecEntetePayement."No." := NoSeriesMgt.GetNextNo(RecPaymentClass."Header No. Series", 0D, TRUE);
//                         RecEntetePayement.VALIDATE("Posting Date", TODAY);
//                         RecEntetePayement.VALIDATE("Document Date", TODAY);
//                         RecEntetePayement.VALIDATE("Payment Class", GeneralLedgerSetup."Type Caisse Ex");
//                         RecEntetePayement.VALIDATE("Account Type", RecEntetePayement."Account Type"::"Bank Account");
//                         RecEntetePayement.VALIDATE("Account No.", GeneralLedgerSetup.Caisse);
//                         RecEntetePayement."Date Création" := CURRENTDATETIME;
//                         RecEntetePayement."Créer par" := COPYSTR(USERID, 1, 20);
//                         RecEntetePayement.Utilisateur := COPYSTR(USERID, 1, 20);
//                         RecEntetePayement.INSERT;
//                         IF REC.FINDLAST THEN;
//                     end;
//                 }
//                 action(Printing)
//                 {
//                     Caption = 'Printing';

//                     trigger OnAction()
//                     var
//                         Text1: Label 'There is no line to treat.';
//                     begin
//                         //GL2024 License
//                         rec.CalcFields("No. of Lines");
//                         if rec."No. of Lines" = 0 then
//                             Error(Text1);
//                         //GL2024 License
//                         Steps.SETRANGE("Payment Class", REC."Payment Class");
//                         Steps.SETRANGE("Previous Status", REC."Status No.");
//                         Steps.SETRANGE("Action Type", Steps."Action Type"::Report);
//                         //>> HJ DSFT 09 12 2010
//                         IF RecUser.GET(UPPERCASE(USERID)) THEN;
//                         IF RecUser.Agence <> '' THEN Steps.SETFILTER(Agence, '%1|%2', '', RecUser.Agence);
//                         //>> HJ DSFT 09 12 2010

//                         CurrPage.Lines.PAGE.MarkLines(TRUE);
//                         ValidatePayment;
//                         CurrPage.Lines.PAGE.MarkLines(FALSE);
//                     end;
//                 }
//                 action("Imprimer Mandat Minute")
//                 {
//                     Caption = 'Imprimer Mandat Minute';

//                     trigger OnAction()
//                     begin
//                         CurrPage.Lines.PAGE.GETRECORD(Line);

//                         RecPaymentLine2.SETRANGE("No.", Line."No.");
//                         RecPaymentLine2.SETRANGE("Line No.", Line."Line No.");
//                         REPORT.RUNMODAL(REPORT::"Monadat Minute", TRUE, TRUE, RecPaymentLine2);
//                     end;
//                 }
//                 action("Imprimer Fiche de Versement")
//                 {
//                     Caption = 'Imprimer Fiche de Versement';

//                     trigger OnAction()
//                     begin
//                         CurrPage.Lines.PAGE.GETRECORD(Line);

//                         PaymentLine2.SETRANGE(PaymentLine2."No.", Line."No.");
//                         PaymentLine2.SETRANGE(PaymentLine2."Numero Seq", Line."Numero Seq");
//                         REPORT.RUN(50100, TRUE, TRUE, PaymentLine2)
//                     end;
//                 }
//                 action("Generate file")
//                 {
//                     Caption = 'Generate file';
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         Text1: Label 'There is no line to treat.';
//                     begin
//                         //GL2024 License
//                         rec.CalcFields("No. of Lines");
//                         if rec."No. of Lines" = 0 then
//                             Error(Text1);
//                         //GL2024 License
//                         Steps.SETRANGE("Payment Class", REC."Payment Class");
//                         Steps.SETRANGE("Previous Status", REC."Status No.");
//                         Steps.SETRANGE("Action Type", Steps."Action Type"::File);
//                         ValidatePayment;
//                     end;
//                 }
//                 action(Valider2)
//                 {
//                     Caption = 'Valider';

//                     trigger OnAction()
//                     begin
//                         IF REC.Valider = TRUE THEN ERROR(Text019);

//                         // MH SORO 04-09-2020

//                         /* RecPaymentLine2.RESET;
//                          RecPaymentLine2.SETRANGE("No.","No.");
//                          RecPaymentLine2.SETRANGE("Code Opération",'P2');
//                          IF RecPaymentLine2.FINDFIRST THEN
//                            REPEAT
//                               RecAvance.RESET;
//                               RecAvance.SETRANGE("N° Bon Caisse",RecPaymentLine2."Numero Seq");
//                               IF NOT RecAvance.FINDFIRST THEN ERROR('Il Existe des Avances non Validé !!!');

//                            UNTIL RecPaymentLine2.NEXT=0;  */

//                         // MH SORO 04-09-2020
//                         IF NOT CONFIRM(Text017, FALSE) THEN EXIT;

//                         REC."Status No." := 10000;
//                         REC."Status Name" := 'VALIDER';
//                         REC.Valider := TRUE;
//                         REC."Validé Par" := UPPERCASE(USERID);

//                         REC.MODIFY;
//                         MESSAGE(Text018);

//                         PaymentLine2.RESET;
//                         PaymentLine2.SETRANGE(PaymentLine2."No.", REC."No.");
//                         IF PaymentLine2.FINDFIRST THEN
//                             REPEAT
//                                 PaymentLine2."Validé Caisse" := TRUE;
//                                 PaymentLine2.MODIFY;
//                             UNTIL PaymentLine2.NEXT = 0;

//                     end;
//                 }
//                 action("Réouvrir")
//                 {
//                     Caption = 'Réouvrir';
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         IF REC.Valider = FALSE THEN ERROR(Text022);
//                         IF NOT CONFIRM(Text020, FALSE) THEN EXIT;
//                         REC."Status No." := 10000;
//                         REC.Valider := FALSE;
//                         REC."Validé Par" := '';
//                         REC.MODIFY;
//                         MESSAGE(Text021);

//                         PaymentLine2.RESET;
//                         PaymentLine2.SETRANGE(PaymentLine2."No.", REC."No.");
//                         IF PaymentLine2.FINDFIRST THEN
//                             REPEAT
//                                 PaymentLine2."Validé Caisse" := FALSE;
//                                 PaymentLine2.MODIFY;
//                             UNTIL PaymentLine2.NEXT = 0;
//                     end;
//                 }
//                 action(Validate)
//                 {
//                     Caption = 'Validate';
//                     ShortCutKey = 'F9';
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         Text1: Label 'There is no line to treat.';
//                     begin
//                         //>>>MBK:05/02/2010: Référence chèque
//                         /*
//                        IF PaymentStatus_gr.GET("Payment Class","Status No.")THEN

//                          IF PaymentStatus_gr."Référence Chèque" THEN
//                            BEGIN
//                            PaymentLine_gr.RESET;
//                            Chèquemouvementé_gr.RESET;
//                            PaymentLine_gr.SETRANGE("No.","No.");
//                            IF PaymentLine_gr.FINDFIRST THEN
//                             REPEAT
//                              IF PaymentLine_gr."N° chèque" =0 THEN
//                                ERROR( STRSUBSTNO (Text010 , PaymentLine_gr."Line No."));
//                              Chèquemouvementé_gr.GET("Account No.", PaymentLine_gr."Référence chèque",PaymentLine_gr."N° chèque");
//                              //IF Chèquemouvementé_gr.Statut=Chèquemouvementé_gr.Statut::Confirmer THEN
//                                //ERROR( STRSUBSTNO (Text011 , PaymentLine_gr."N° chèque"));
//                              Chèquemouvementé_gr.Statut:=Chèquemouvementé_gr.Statut::Confirmer;
//                              Chèquemouvementé_gr."N° Bordereu":=PaymentLine_gr."No.";
//                              Chèquemouvementé_gr."N° Ligne Bordereu":=PaymentLine_gr."Line No.";

//                              Chèquemouvementé_gr.MODIFY;
//                             UNTIL PaymentLine_gr.NEXT=0;
//                            END;
//                            */
//                         //Nettoyage
//                         IF PaymentStatus_gr.GET(REC."Payment Class", REC."Status No.") THEN
//                             IF PaymentStatus_gr."Référence Chèque" THEN BEGIN

//                                 Chèquemouvementé_gr.RESET;
//                                 Chèquemouvementé_gr.SETRANGE("N° Bordereu", REC."No.");
//                                 IF Chèquemouvementé_gr.FINDFIRST THEN
//                                     REPEAT
//                                         IF Chèquemouvementé_gr.Statut = Chèquemouvementé_gr.Statut::Encours THEN BEGIN
//                                             Chèquemouvementé_gr.Statut := Chèquemouvementé_gr.Statut::" ";
//                                             Chèquemouvementé_gr."N° Bordereu" := '';
//                                             Chèquemouvementé_gr."N° Ligne Bordereu" := 0;
//                                             Chèquemouvementé_gr.MODIFY;
//                                         END;
//                                     UNTIL Chèquemouvementé_gr.NEXT = 0;
//                             END;
//                         //<<<MBK:05/02/2010: Référence chèque



//                         //GL2024 License
//                         rec.CalcFields("No. of Lines");
//                         if rec."No. of Lines" = 0 then
//                             Error(Text1);
//                         //GL2024 License
//                         Steps.SETRANGE("Payment Class", REC."Payment Class");
//                         Steps.SETRANGE("Previous Status", REC."Status No.");
//                         Steps.SETFILTER("Action Type", '<>%1&<>%2&<>%3', Steps."Action Type"::Report, Steps."Action Type"::File, Steps."Action Type"::
//                           "Create New Document");
//                         //>> HJ DSFT 09 12 2010
//                         IF RecUser.GET(UPPERCASE(USERID)) THEN;
//                         IF RecUser.Agence <> '' THEN Steps.SETFILTER(Agence, '%1|%2', '', RecUser.Agence);
//                         //>> HJ DSFT 09 12 2010
//                         ValidatePayment;
//                         //IBK DSFT
//                         IF PaymentStatus_gr.GET(REC."Payment Class", REC."Status No.") THEN
//                             IF PaymentStatus_gr."Référence Chèque" THEN BEGIN
//                                 PaymentLine_gr.RESET;
//                                 Chèquemouvementé_gr.RESET;
//                                 PaymentLine_gr.SETRANGE("No.", REC."No.");
//                                 IF PaymentLine_gr.FINDFIRST THEN
//                                     REPEAT
//                                         IF PaymentLine_gr."N° chèque" = 0 THEN
//                                             ERROR(STRSUBSTNO(Text010, PaymentLine_gr."Line No."));
//                                         Chèquemouvementé_gr.GET(REC."Account No.", PaymentLine_gr."Référence chèque", PaymentLine_gr."N° chèque");
//                                         //IF Chèquemouvementé_gr.Statut=Chèquemouvementé_gr.Statut::Confirmer THEN
//                                         //ERROR( STRSUBSTNO (Text011 , PaymentLine_gr."N° chèque"));
//                                         IF PaymentLine_gr."Status No." IN [1000, 3000] THEN BEGIN
//                                             Chèquemouvementé_gr.Statut := Chèquemouvementé_gr.Statut::Confirmer;
//                                             Chèquemouvementé_gr."N° Bordereu" := PaymentLine_gr."No.";
//                                             Chèquemouvementé_gr."N° Ligne Bordereu" := PaymentLine_gr."Line No.";

//                                             Chèquemouvementé_gr.MODIFY;
//                                         END
//                                         ELSE
//                                             IF PaymentLine_gr."Status No." = 4000 THEN BEGIN
//                                                 Chèquemouvementé_gr.Statut := Chèquemouvementé_gr.Statut::Comptabilisé;
//                                                 Chèquemouvementé_gr."N° Bordereu" := PaymentLine_gr."No.";
//                                                 Chèquemouvementé_gr."N° Ligne Bordereu" := PaymentLine_gr."Line No.";

//                                                 Chèquemouvementé_gr.MODIFY;
//                                             END
//                                             ELSE
//                                                 IF PaymentLine_gr."Status No." IN [5000, 6000] THEN BEGIN
//                                                     Chèquemouvementé_gr.Statut := Chèquemouvementé_gr.Statut::Annulé;
//                                                     Chèquemouvementé_gr."N° Bordereu" := PaymentLine_gr."No.";
//                                                     Chèquemouvementé_gr."N° Ligne Bordereu" := PaymentLine_gr."Line No.";

//                                                     Chèquemouvementé_gr.MODIFY;
//                                                 END;

//                                     UNTIL PaymentLine_gr.NEXT = 0;
//                             END;
//                         //IBK DSFT
//                         // >> HJ DSFT 26-01-2009
//                         IF RecEntetePayement.GET(REC."No.") THEN BEGIN
//                             RecEntetePayement."Validé Par" := USERID;
//                             RecEntetePayement.MODIFY;
//                         END;
//                         // << HJ DSFT 26-01-2009

//                         // << HJ DSFT 17-03-2011
//                         IF RecSalesReceivablesSetup.GET THEN;
//                         IF RecSalesReceivablesSetup."Activer Suivi Mode Réglement" THEN BEGIN
//                             RecPaymentLine.SETRANGE("No.", REC."No.");
//                             IF RecPaymentLine.FINDFIRST THEN
//                                 REPEAT
//                                     IF RecPaymentLine."Account Type" = RecPaymentLine."Account Type"::Customer THEN BEGIN
//                                         IF RecCustomer.GET(RecPaymentLine."Account No.") THEN;
//                                         IF RecPaymentClass.GET(REC."Payment Class") THEN;
//                                         IF RecPaymentMethod2.GET(RecPaymentClass."Mode Paiement") THEN IntTypeReglement := RecPaymentMethod2.Priorité;
//                                         IF RecPaymentMethod.GET(RecCustomer."Payment Method Code") THEN IntClient := RecPaymentMethod.Priorité;
//                                         IF IntClient < IntTypeReglement THEN
//                                             ERROR(Text0015, RecPaymentLine."Account No.",
//                                                  RecCustomer."Payment Method Code", REC."Payment Class");
//                                     END;
//                                 UNTIL RecPaymentLine.NEXT = 0;
//                         END;
//                         // << HJ DSFT 17-03-2011

//                     end;
//                 }
//                 action("STC - BON")
//                 {
//                     Caption = 'STC - BON';
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         CurrPage.Lines.PAGE.Get11X12X;
//                     end;
//                 }
//                 action("Detail Brouillard")
//                 {
//                     Caption = 'Detail Brouillard';
//                     ShortCutKey = 'F7';

//                     trigger OnAction()
//                     begin
//                         NumSequence := CurrPage.Lines.PAGE.GetNumSeq;
//                         DetailBrouillard.RESET;
//                         DetailBrouillard.SETRANGE("Order N°", NumSequence);
//                         PAGE.RUNMODAL(PAGE::"Detail Brouillard de Caisse", DetailBrouillard);
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         //Currpage.Lines.FORM.EDITABLE(TRUE);
//         //IF Valider=TRUE   THEN
//         //  BEGIN
//         //    Currpage.EDITABLE(FALSE);
//         //    Currpage.Lines.FORM.EDITABLE(FALSE);
//         //  END
//         // ELSE Currpage.EDITABLE(TRUE);

//         //Currpage.Lines.FORM.DisableFields;


//         //GL2024 // << HJ DSFT 08-11-2009
//         // IF RecUser.Niveau = 0 THEN ERROR(Text011);
//         // IF RecUser.Niveau = 1 THEN REC.SETRANGE(Utilisateur, USERID);
//         // IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
//         //     REC.SETRANGE(Agence, RecUser.Agence)
//         // ELSE
//         //     REC.SETRANGE(Agence);
//         // // >> HJ DSFT 08 11 2010
//         TxtEtapesSuivante := 'Action : ';
//         REcPaymentSteps.SETRANGE("Payment Class", REC."Payment Class");
//         REcPaymentSteps.SETRANGE("Previous Status", REC."Status No.");
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
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     var
//         NoSeries: Codeunit "No. Series";
//         PaymentClass: Record "Payment Class";
//         NoSeriesManagement: Codeunit NoSeriesManagement;


//         IsHandled: Boolean;
//     begin
//         // >> HJ DSFT 21-01-2009
//         IF RecUser.GET(UPPERCASE(USERID)) THEN REC.Agence := RecUser.Agence;
//         REC.Utilisateur := UPPERCASE(USERID);
//         // << HJ DSFT 21-01-2009

//         //GL2024
//         if PaymentClass.Get(rec."Payment Class") then;
//         NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(PaymentClass."Header No. Series", xRec."No. Series", 0D, rec."No.", rec."No. Series", IsHandled);
//         if not IsHandled then begin

//             rec."No. Series" := PaymentClass."Header No. Series";
//             if NoSeries.AreRelated(rec."No. Series", xRec."No. Series") then
//                 rec."No. Series" := xRec."No. Series";
//             rec."No." := NoSeries.GetNextNo(rec."No. Series");

//             NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(rec."No. Series", PaymentClass."Header No. Series", 0D, rec."No.");
//         end;
//         //GL2024
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         // >> HJ DSFT 21-01-2009

//         IF GeneralLedgerSetup.GET THEN;
//         REC.VALIDATE("Account Type", REC."Account Type"::"Bank Account");
//         REC.VALIDATE("Account No.", GeneralLedgerSetup.Caisse);
//         // << HJ DSFT 21-01-2009
//         rec."Payment Class" := 'CAISSEEXT';
//     end;

//     //GL2024 trigger OnOpenPage()
//     // begin
//     //     // << HJ DSFT 21-01-2009
//     //     RecUser.GET(UPPERCASE(USERID));
//     //     IF RecUser.Niveau = 0 THEN ERROR(Text0011);
//     //     IF RecUser.Niveau = 1 THEN REC.SETRANGE(Utilisateur, UPPERCASE(USERID));
//     //     IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
//     //         REC.SETRANGE(Agence, RecUser.Agence)
//     //     ELSE
//     //         REC.SETRANGE(Agence);
//     //     REC.SETRANGE("Account Type", REC."Account Type"::"Bank Account");


//     //     //IF Valider=TRUE   THEN
//     //     //  BEGIN
//     //     //  Currpage.EDITABLE(FALSE);
//     //     //  // Currpage.Lines.FORM.EDITABLE(FALSE);
//     //     // END
//     //     //ELSE Currpage.EDITABLE(TRUE);

//     //     //<< HJ DSFT 21-01-2009IF (Valider)   THEN
//     // end;

//     var
//         ChangeExchangeRate: Page "Change Exchange Rate";
//         Navigate: Page Navigate;
//         Steps: Record "Payment Step";
//         Text001: Label 'This payment class does not authorize vendor suggestions.';
//         Text002: Label 'This payment class does not authorize customer suggestions.';
//         Text003: Label 'You cannot suggest payments on a posted header.';
//         Text004: Label 'You cannot assign a number to a posted header.';
//         Text005: Label 'This document has no line. You cannot archive it. You must delete it.';
//         Text006: Label 'One line is not posted. Are you sure you want to archive this document ?';
//         Text007: Label 'Some lines are not posted. Are you sure you want to archive this document ?';
//         Text008: Label 'Are you sure you want to archive this document ?';
//         Text009: Label 'Do you wish to archive this document ?';
//         "-MBK-": Integer;
//         PaymentStatus_gr: Record "Payment Status";
//         PaymentLine_gr: Record "Payment Line";
//         "Chèquemouvementé_gr": Record "Chèque mouvementé";
//         //"--MBK--": ;
//         Text010: Label 'Veuillez saisir le N° Chèque dans la ligne %1';
//         Text011: Label 'N° chèque %1 utlisé plus d''une fois';
//         RecBankAccount: Record "Bank Account";
//         "-HJ-": Integer;
//         RecAutorisationEtapes: Record "Autorisation Etapes2";
//         RecUser: Record "User Setup";
//         RecEntetePayement: Record "Payment Header";
//         RecPaymentLine: Record "Payment Line";
//         RecBank: Record "Bank Account";
//         REcPaymentSteps: Record "Payment Step";
//         RecPaymentStatus: Record "Payment Status";
//         TxtEtapesSuivante: Text[1000];
//         RecEntete: Record "Payment Header";
//         //  "--HJ--": ;
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
//         PaymentLine: Record "Payment Line";
//         GeneralLedgerSetup: Record "General Ledger Setup";
//         PaymentClassList: Page "Payment Class List";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         Text016: Label 'Nouveau Brouillard ?';
//         LoanAdvance: Record "Loan & Advance";
//         DetailBrouillard: Record "Detail Avancement Production";
//         NumSequence: Code[20];
//         PaymentLine2: Record "Payment Line";
//         Line: Record "Payment Line";
//         Text017: Label 'Valider Le Brouillards ?';
//         Text018: Label 'Validation Achevée Avec Succée';
//         Text019: Label 'Deja Valider';
//         Text020: Label 'reouvrir Ce Document ?';
//         Text021: Label 'Document est Ouvert';
//         Text022: Label 'Deja Ouvert';
//         SalaryLines: Record "Salary Lines";
//         RegroupementPaie: Record "Regroupement Paie";
//         PaymentHeader: Record "Payment Header";
//         RegroupementPaieEntete: Record "Regroupement Paie Entete";
//         //GL3900     RegroupementPaieRetour: Record "Regroupement Paie Retour";
//         RecPaymentLine2: Record "Payment Line";
//         RecAvance: Record "Loan & Advance Header";
//         NumAvance: Code[20];


//     procedure ValidatePayment()
//     var
//         Ok: Boolean;
//         PostingStatement: Codeunit "Payment Management Copy";
//         Options: Text[400];
//         Choice: Integer;
//         I: Integer;
//     begin
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
//             IF Steps.Agence <> '' THEN IF REC.Agence <> Steps.Agence THEN ERROR(Text0012, REC.Agence, Steps.Agence);
//         // << HJ DSFT 14-04-2009

//         //GL2024    IF Ok THEN
//         Steps.SetFilter(
//                           "Action Type",
//                           '%1|%2|%3',
//                           Steps."Action Type"::None, Steps."Action Type"::Ledger, Steps."Action Type"::"Cancel File");
//         PostingStatement.ProcessPaymentSteps(Rec, Steps);
//     end;
// }

