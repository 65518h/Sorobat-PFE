// page 50197 "Caisse Extra Validé"
// {
//     // //>>>MBK:05/02/2010: Référence chèque
//     // // << HJ DSFT 21-01-2009: Gestion des Utilisateurs


//     Caption = 'Caisse Journaliére Validé';
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = Card;
//     RefreshOnActivate = true;
//     SourceTable = "Payment Header";
//     SourceTableView = WHERE("Payment Class" = CONST('CAISSEEXT'), Valider = CONST(true), "Caisse Chantier" = CONST(false), "N° Affaire" = FILTER(= 'ADMINISTRATION' | ''));



//     layout
//     {
//         area(content)
//         {

//             field("No."; rec."No.")
//             {
//                 ApplicationArea = all;
//                 Caption = 'N° Document';
//                 Editable = false;
//                 Style = Unfavorable;
//                 StyleExpr = TRUE;
//             }
//             field("Document Date"; rec."Document Date")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Journée';
//             }
//             field("Account No."; rec."Account No.")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//                 Style = Strong;
//                 StyleExpr = TRUE;
//             }

//             field("Payment Class"; rec."Payment Class")
//             {
//                 ApplicationArea = all;

//                 Style = Strong;
//                 StyleExpr = TRUE;
//             }
//             field(Valider; rec.Valider)
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//                 Style = Strong;
//                 StyleExpr = TRUE;
//             }
//             field("Validé Par"; rec."Validé Par")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//             field("N° Affaire"; rec."N° Affaire")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//                 Style = Strong;
//                 StyleExpr = TRUE;
//             }
//             field("Solde Caisse"; rec."Solde Caisse")
//             {
//                 ApplicationArea = all;
//                 Style = Unfavorable;
//                 StyleExpr = TRUE;
//             }
//             part(Lines; "Ligne Paiement Caisse")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//                 SubPageLink = "No." = FIELD("No.");
//                 SubPageView = WHERE("Validé Caisse" = CONST(true));
//             }
//             field("Amount (LCY)"; rec."Amount (LCY)")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Montant Journée';
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

//             actionref("Imprimer Bon1"; "Imprimer Bon") { }
//             actionref("Imprimer Journée De Caisse1"; "Imprimer Journée De Caisse") { }

//             group("P&osting1")
//             {
//                 Caption = '&Fonction';
//                 actionref(Insertion1; Insertion) { }
//                 actionref(Printing1; Printing) { }
//                 actionref("Generate file1"; "Generate file") { }
//                 actionref(Valider21; Valider2) { }
//                 actionref("Réouvrir1"; "Réouvrir") { }
//                 actionref(Validate1; Validate) { }
//                 actionref("Avance Et Prêt1"; "Avance Et Prêt") { }
//                 actionref("Detail Brouillard1"; "Detail Brouillard") { }

//             }
//         }
//         area(processing)
//         {
//             action("Imprimer Bon")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Imprimer Bon';


//                 trigger OnAction()
//                 begin
//                     CurrPage.Lines.page.GETRECORD(Line);


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
//                 ApplicationArea = all;
//                 Caption = 'Imprimer Journée De Caisse';


//                 trigger OnAction()
//                 begin
//                     PaymentLine.SETRANGE("No.", rec."No.");
//                     REPORT.RUNMODAL(REPORT::"Brouillard de Caisse", TRUE, TRUE, PaymentLine);
//                 end;
//             }
//             group("P&osting")
//             {
//                 Caption = '&Fonction';
//                 action(Insertion)
//                 {
//                     ApplicationArea = all;
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
//                         IF rec.FINDLAST THEN;
//                     end;
//                 }
//                 action(Printing)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Imprimer';

//                     trigger OnAction()
//                     var
//                         Text1: Label 'There is no line to treat.';
//                     begin
//                         //REC.TestNbOfLines;
//                         //GL2024 License
//                         rec.CalcFields("No. of Lines");
//                         if rec."No. of Lines" = 0 then
//                             Error(Text1);
//                         //GL2024 License
//                         Steps.SETRANGE("Payment Class", rec."Payment Class");
//                         Steps.SETRANGE("Previous Status", rec."Status No.");
//                         Steps.SETRANGE("Action Type", Steps."Action Type"::Report);
//                         //>> HJ DSFT 09 12 2010
//                         IF RecUser.GET(UPPERCASE(USERID)) THEN;
//                         IF RecUser.Agence <> '' THEN Steps.SETFILTER(Agence, '%1|%2', '', RecUser.Agence);
//                         //>> HJ DSFT 09 12 2010

//                         CurrPage.Lines.page.MarkLines(TRUE);
//                         ValidatePayment;
//                         CurrPage.Lines.page.MarkLines(FALSE);
//                     end;
//                 }
//                 action("Generate file")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Generate file';
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         Text1: Label 'There is no line to treat.';
//                     begin
//                         //REC.TestNbOfLines;
//                         //GL2024 License
//                         rec.CalcFields("No. of Lines");
//                         if rec."No. of Lines" = 0 then
//                             Error(Text1);
//                         //GL2024 License
//                         Steps.SETRANGE("Payment Class", rec."Payment Class");
//                         Steps.SETRANGE("Previous Status", rec."Status No.");
//                         Steps.SETRANGE("Action Type", Steps."Action Type"::File);
//                         ValidatePayment;
//                     end;
//                 }
//                 action(Valider2)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Valider';
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         IF rec.Valider = TRUE THEN ERROR(Text019);
//                         IF NOT CONFIRM(Text017, FALSE) THEN EXIT;
//                         rec."Status No." := 10000;
//                         rec."Status Name" := 'VALIDER';
//                         rec.Valider := TRUE;
//                         rec."Validé Par" := UPPERCASE(USERID);
//                         rec.MODIFY;
//                         MESSAGE(Text018);
//                         PaymentLine2.RESET;

//                         PaymentLine2.SETRANGE(PaymentLine2."No.", rec."No.");
//                         IF PaymentLine2.FINDFIRST THEN
//                             REPEAT
//                                 PaymentLine2."Validé Caisse" := TRUE;
//                                 PaymentLine2.MODIFY;
//                             UNTIL PaymentLine2.NEXT = 0;
//                     end;
//                 }
//                 action("Réouvrir")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Réouvrir';

//                     trigger OnAction()
//                     begin
//                         IF rec.Valider = FALSE THEN ERROR(Text022);
//                         IF NOT CONFIRM(Text020, FALSE) THEN EXIT;
//                         rec."Status No." := 10000;
//                         rec.Valider := FALSE;
//                         rec."Validé Par" := '';
//                         rec.MODIFY;
//                         MESSAGE(Text021);

//                         PaymentLine2.RESET;
//                         PaymentLine2.SETRANGE(PaymentLine2."No.", rec."No.");
//                         IF PaymentLine2.FINDFIRST THEN
//                             REPEAT
//                                 PaymentLine2."Validé Caisse" := FALSE;
//                                 PaymentLine2.MODIFY;
//                             UNTIL PaymentLine2.NEXT = 0;
//                     end;
//                 }
//                 action(Validate)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Valider Comptabiliser';
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
//                         IF PaymentStatus_gr.GET(rec."Payment Class", rec."Status No.") THEN
//                             IF PaymentStatus_gr."Référence Chèque" THEN BEGIN

//                                 Chèquemouvementé_gr.RESET;
//                                 Chèquemouvementé_gr.SETRANGE("N° Bordereu", rec."No.");
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



//                         //REC.TestNbOfLines;
//                         //GL2024 License
//                         rec.CalcFields("No. of Lines");
//                         if rec."No. of Lines" = 0 then
//                             Error(Text1);
//                         //GL2024 License
//                         Steps.SETRANGE("Payment Class", rec."Payment Class");
//                         Steps.SETRANGE("Previous Status", rec."Status No.");
//                         Steps.SETFILTER("Action Type", '<>%1&<>%2&<>%3', Steps."Action Type"::Report, Steps."Action Type"::File, Steps."Action Type"::
//                           "Create New Document");
//                         //>> HJ DSFT 09 12 2010
//                         IF RecUser.GET(UPPERCASE(USERID)) THEN;
//                         IF RecUser.Agence <> '' THEN Steps.SETFILTER(Agence, '%1|%2', '', RecUser.Agence);
//                         //>> HJ DSFT 09 12 2010
//                         ValidatePayment;
//                         //IBK DSFT
//                         IF PaymentStatus_gr.GET(rec."Payment Class", REC."Status No.") THEN
//                             IF PaymentStatus_gr."Référence Chèque" THEN BEGIN
//                                 PaymentLine_gr.RESET;
//                                 Chèquemouvementé_gr.RESET;
//                                 PaymentLine_gr.SETRANGE("No.", rec."No.");
//                                 IF PaymentLine_gr.FINDFIRST THEN
//                                     REPEAT
//                                         IF PaymentLine_gr."N° chèque" = 0 THEN
//                                             ERROR(STRSUBSTNO(Text010, PaymentLine_gr."Line No."));
//                                         Chèquemouvementé_gr.GET(rec."Account No.", PaymentLine_gr."Référence chèque", PaymentLine_gr."N° chèque");
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
//                         IF RecEntetePayement.GET(rec."No.") THEN BEGIN
//                             RecEntetePayement."Validé Par" := USERID;
//                             RecEntetePayement.MODIFY;
//                         END;
//                         // << HJ DSFT 26-01-2009

//                         // << HJ DSFT 17-03-2011
//                         IF RecSalesReceivablesSetup.GET THEN;
//                         IF RecSalesReceivablesSetup."Activer Suivi Mode Réglement" THEN BEGIN
//                             RecPaymentLine.SETRANGE("No.", rec."No.");
//                             IF RecPaymentLine.FINDFIRST THEN
//                                 REPEAT
//                                     IF RecPaymentLine."Account Type" = RecPaymentLine."Account Type"::Customer THEN BEGIN
//                                         IF RecCustomer.GET(RecPaymentLine."Account No.") THEN;
//                                         IF RecPaymentClass.GET(rec."Payment Class") THEN;
//                                         IF RecPaymentMethod2.GET(RecPaymentClass."Mode Paiement") THEN IntTypeReglement := RecPaymentMethod2.Priorité;
//                                         IF RecPaymentMethod.GET(RecCustomer."Payment Method Code") THEN IntClient := RecPaymentMethod.Priorité;
//                                         IF IntClient < IntTypeReglement THEN
//                                             ERROR(Text0015, RecPaymentLine."Account No.",
//                                                  RecCustomer."Payment Method Code", rec."Payment Class");
//                                     END;
//                                 UNTIL RecPaymentLine.NEXT = 0;
//                         END;
//                         // << HJ DSFT 17-03-2011

//                     end;
//                 }
//                 action("Avance Et Prêt")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Avance Et Prêt';

//                     trigger OnAction()
//                     begin
//                         CurrPage.Lines.page.AfficherAvancePret;
//                     end;
//                 }
//                 action("Detail Brouillard")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Detail Brouillard';
//                     ShortCutKey = 'F7';

//                     trigger OnAction()
//                     begin
//                         NumSequence := CurrPage.Lines.page.GetNumSeq;
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
//         CurrPage.Lines.page.EDITABLE(TRUE);
//         IF rec.Valider = TRUE THEN BEGIN
//             CurrPage.EDITABLE(FALSE);
//             CurrPage.Lines.PAGE.EDITABLE(FALSE);
//         END
//         ELSE
//             CurrPage.EDITABLE(TRUE);

//         CurrPage.Lines.PAGE.DisableFields;


//         // // << HJ DSFT 08-11-2009
//         //GL2024 IF RecUser.Niveau = 0 THEN ERROR(Text011);
//         // IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, USERID);
//         // IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
//         //     rec.SETRANGE(Agence, RecUser.Agence)
//         // ELSE
//         //     rec.SETRANGE(Agence);
//         // // >> HJ DSFT 08 11 2010
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
//         rec.VALIDATE("Account Type", rec."Account Type"::"Bank Account");
//         rec.VALIDATE("Account No.", GeneralLedgerSetup.Caisse);
//         // << HJ DSFT 21-01-2009
//         rec."Payment Class" := 'CAISSEEXT';
//     end;

//     trigger OnOpenPage()
//     begin
//         // << HJ DSFT 21-01-2009
//         //GL2024 RecUser.GET(UPPERCASE(USERID));
//         // IF RecUser.Niveau = 0 THEN ERROR(Text0011);
//         // IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, UPPERCASE(USERID));
//         // IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
//         //     rec.SETRANGE(Agence, RecUser.Agence)
//         // ELSE
//         //     rec.SETRANGE(Agence);
//         // rec.SETRANGE("Account Type", rec."Account Type"::"Bank Account");


//         IF rec.Valider = TRUE THEN BEGIN
//             CurrPage.EDITABLE(FALSE);
//             CurrPage.Lines.PAGE.EDITABLE(FALSE);
//         END
//         ELSE
//             CurrPage.EDITABLE(TRUE);

//         // << HJ DSFT 21-01-2009IF (Valider)   THEN
//         OnActivateForm;
//     end;

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
//             //GL2024    Ok := CONFIRM(Steps.Name, TRUE);
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

//     local procedure OnActivateForm()
//     begin
//         IF REC.Valider = TRUE THEN BEGIN
//             CurrPage.EDITABLE(FALSE);
//             CurrPage.Lines.PAGE.EDITABLE(FALSE);
//         END
//         ELSE
//             CurrPage.EDITABLE(TRUE);
//     end;
// }

