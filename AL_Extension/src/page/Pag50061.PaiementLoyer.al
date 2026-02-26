// page 50061 "Paiement Loyer"
// {
//     // //>>>MBK:05/02/2010: Référence chèque
//     // // << HJ DSFT 21-01-2009: Gestion des Utilisateurs

//     Caption = 'Paiement Loyer';
//     PageType = Card;
//     RefreshOnActivate = true;
//     SourceTable = "Payment Header";
//     SourceTableView = WHERE("Payment Class" = CONST('LOYER'));

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'Général';
//                 field("No."; rec."No.")
//                 {
//                     AssistEdit = false;
//                     Editable = false;
//                     ApplicationArea = all;
//                     trigger OnAssistEdit()
//                     begin
//                         /*//GL2024 License
//       IF rec.AssistEdit(xRec) THEN
//                                CurrPage.UPDATE;*///GL2024 License

//                     end;
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
//                 field(Utilisateur; rec.Utilisateur)
//                 {
//                     ApplicationArea = all;

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
//                 field(TxtEtapesSuivante; TxtEtapesSuivante)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     ShowCaption = false;
//                     MultiLine = true;
//                 }
//             }
//             part(Lines; "Ligne Paiement Loyer")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Ligne Paiement Loyer';
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
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Confirmer)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Confirmer';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 var
//                     Text1: Label 'There is no line to treat.';
//                 begin
//                     //>>>MBK:05/02/2010: Référence chèque
//                     IF PaymentStatus_gr.GET(rec."Payment Class", rec."Status No.") THEN
//                         IF PaymentStatus_gr."Référence Chèque" THEN BEGIN

//                             Chèquemouvementé_gr.RESET;
//                             Chèquemouvementé_gr.SETRANGE("N° Bordereu", rec."No.");
//                             IF Chèquemouvementé_gr.FINDFIRST THEN
//                                 REPEAT
//                                     IF Chèquemouvementé_gr.Statut = Chèquemouvementé_gr.Statut::Encours THEN BEGIN
//                                         Chèquemouvementé_gr.Statut := Chèquemouvementé_gr.Statut::" ";
//                                         Chèquemouvementé_gr."N° Bordereu" := '';
//                                         Chèquemouvementé_gr."N° Ligne Bordereu" := 0;
//                                         Chèquemouvementé_gr.MODIFY;
//                                     END;
//                                 UNTIL Chèquemouvementé_gr.NEXT = 0;
//                         END;
//                     //<<<MBK:05/02/2010: Référence chèque



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

//                     EXIT;
//                     /////////////*****
//                     IF rec.Valider THEN ERROR(Text005);
//                     IF rec."Payment Class" = 'PAIEMENT' THEN BEGIN
//                         RecPaymentLine.RESET;
//                         RecPaymentLine.SETRANGE("No.", rec."No.");
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
//                                 CduPurchPost.ChangerStatutFacture(VendorLedgerEntry."Document No.", 1);
//                             UNTIL VendorLedgerEntry.NEXT = 0;
//                     END;
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
//                 end;
//             }
//             action(Imprimer)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Imprimer';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     //IF Status<>Status::Released THEN ERROR(Text003);

//                     RecEntetePayement.SETRANGE("No.", rec."No.");
//                     RecPaymentLine.SETRANGE("No.", rec."No.");
//                     REPORT.RUNMODAL(REPORT::"Etat Loyer", TRUE, TRUE, RecEntetePayement);
//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         CurrPage.Lines.page.EDITABLE(TRUE);
//         // << HJ DSFT 08-11-2009
//         //GL2024 IF RecUser.Niveau = 0 THEN ERROR(Text011);
//         // IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, USERID);
//         // IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
//         //     rec.SETRANGE(Agence, RecUser.Agence)
//         // ELSE
//         //     rec.SETRANGE(Agence);
//         // GetABK;
//         // >> HJ DSFT 08 11 2010
//         TxtEtapesSuivante := 'Action : ';
//         REcPaymentSteps.SETRANGE("Payment Class", rec."Payment Class");
//         REcPaymentSteps.SETRANGE("Previous Status", rec."Status No.");
//         IF REcPaymentSteps.FIND('-') THEN
//             REPEAT
//                 REcPaymentSteps.CALCFIELDS("Next Status Name");
//                 IF (REcPaymentSteps."Action Type" = 0) OR (REcPaymentSteps."Action Type" = 1) THEN
//                     TxtEtapesSuivante := TxtEtapesSuivante + '  Valider :' + REcPaymentSteps.Name;
//                 IF (REcPaymentSteps."Action Type" = 2) THEN
//                     TxtEtapesSuivante := TxtEtapesSuivante + '  Imprimer  :' + REcPaymentSteps."Next Status Name";
//                 IF (REcPaymentSteps."Action Type" = 3) THEN
//                     TxtEtapesSuivante := TxtEtapesSuivante + '  Fichier  :' + REcPaymentSteps."Next Status Name";
//                 IF (REcPaymentSteps."Action Type" = 4) THEN
//                     TxtEtapesSuivante := TxtEtapesSuivante + '  Créer Bordereau  :' + REcPaymentSteps."Next Status Name";

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

//     //GL2024 trigger OnOpenPage()
//     // begin
//     //     // << HJ DSFT 21-01-2009
//     //     RecUser.GET(UPPERCASE(USERID));
//     //     IF RecUser.Niveau = 0 THEN ERROR(Text0011);
//     //     IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, UPPERCASE(USERID));
//     //     IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
//     //         rec.SETRANGE(Agence, RecUser.Agence)
//     //     ELSE
//     //         rec.SETRANGE(Agence);
//     //     GetABK;
//     //     // << HJ DSFT 21-01-2009
//     // end;

//     var
//         //DYS
//         //    ChangeExchangeRate: Page "Change Exchange Rate";
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


//         RecAgence: Record "Chantier Loyer";
//         RecPaymentMethod: Record "Payment Method";
//         RecPaymentMethod2: Record "Payment Method";
//         RecSalesReceivablesSetup: Record "Sales & Receivables Setup";
//         RecCustomer: Record Customer;
//         RecPaymentClass: Record "Payment Class";
//         IntClient: Integer;
//         IntTypeReglement: Integer;

//         GeneralLedgerSetup: Record "General Ledger Setup";
//         GenJournalLine: Record "Gen. Journal Line";

//         RecPaymentHeader: Record "Payment Header";
//         ListeFacturesLettrage: Record "Liste Factures Lettrage";
//         VendorLedgerEntry: Record "Vendor Ledger Entry";
//         IdLettrage: Code[20];
//         DernierNumero: Integer;
//         SommeInitial: Decimal;
//         RestMontant: Decimal;
//         RepTraiteFournisseur: Report "* Traite Fournisseur";
//         RepCheque: Report CHEQUE;
//         RepPiecePaiement: Report "Pièce de Paiement";
//         CduPurchPost: Codeunit "PurchPostEvent";
//         RecLigLoyer: Record "Payment Line";
//         Text010: Label 'Please enter the Check No. in line %1';
//         Text011: Label 'Check No. %1 used more than once.';
//         Text0010: Label 'You are not authorized at this step %1, %2, %3; please consult your administrator';
//         Text0011: Label 'You are not authorized for the Cash Collection - Disbursement module.';
//         Text0012: Label 'Your agency %1 is different from that of the step (%2)';
//         Text013: Label 'Changing agency is not permitted at this status';
//         Text014: Label 'You are not authorized to change the agency';
//         Text0015: Label 'Customer Payment Method No. %1 (%2) cannot be %3.';
//         Text0016: Label 'You must confirm the credit.';
//         Text0017: Label 'Confirm this action';
//         Text0018: Label 'Please specify the number of months for the schedule';
//         Text0019: Label 'Credit already issued';
//         Text0020: Label 'Due date already accounted for';
//         Text0021: Label 'Entries already accounted for';
//         Text0022: Label 'This credit has not been issued';
//         Text0023: Label '"Please enter the rent month in line %1';
//         Text0024: Label 'Please enter the rent year in line %1';




//     procedure GetABK()
//     var
//         RecLUserSetup: Record "User Setup";
//     begin
//     end;


//     procedure CreerBOR()
//     begin
//     end;


//     procedure ValidatePayment2(var ParaPaymentHeader: Record "Payment Header")
//     var
//         PaymentHeader: Record "Payment Header";
//         PaymentLine: Record "Payment Line";
//         LPaymentLine: Record "Payment Line";
//         PaymentStatus: Record "Payment Status";
//         LPaymentClass: Record "Payment Class";
//         Ok: Boolean;
//         PostingStatement: Codeunit "Payment Management";
//         Options: Text[400];
//         Choice: Integer;
//         I: Integer;
//     begin
//     end;


//     procedure Lettrage(ParaIdLettrage: Code[20]; ParaMontantLettrage: Decimal)
//     var
//         LocalVendorLedgerEntry: Record "Vendor Ledger Entry";
//         MontantRestant: Decimal;
//         LocalListeFacturesLettrage: Record "Liste Factures Lettrage";
//         CduPurchasePost: Codeunit "Purch.-Post";
//     begin
//     end;


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
//     begin
//         // >> HJ DELTA 11-02-2014 Verifer Si Montant = Zero
//         LPaymentLine.RESET;
//         LPaymentLine.SETRANGE("No.", rec."No.");
//         IF LPaymentLine.FINDFIRST THEN
//             REPEAT
//                 LPaymentLine.TESTFIELD(Amount);
//                 LPaymentLine.TESTFIELD("Account No.");
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


//         //GL2024  IF Ok THEN
//         Steps.SetFilter(
//                           "Action Type",
//                           '%1|%2|%3',
//                           Steps."Action Type"::None, Steps."Action Type"::Ledger, Steps."Action Type"::"Cancel File");
//         //GL2024  PostingStatement.Valbord(Rec, Steps);
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
//     end;


//     local procedure DocumentDateOnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         rec."Payment Class" := 'LOYER';
//     end;
// }

