//GL2024
// page 74818 "Liste Caisse Jour OACA Validé"
// {

//     Caption = 'Liste Caisse Journaliére OACA Validé';
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = list;
//     UsageCategory = Lists;
//     CardPageId = "Caisse OACA Validé";
//     RefreshOnActivate = true;
//     SourceTable = "Payment Header";
//     SourceTableView = WHERE("Payment Class" = CONST('CAISSEEXT'), Valider = CONST(true), "Caisse Chantier" = CONST(false), "N° Affaire" = FILTER('AEROP-JERBA-MATMATA' | ''));
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(content1)
//             {

//                 field("No."; REC."No.")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'N° Document';
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                 }
//                 field("Document Date"; REC."Document Date")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Journée';
//                 }
//                 field("Account No."; REC."Account No.")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Amount (LCY)"; REC."Amount (LCY)")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Montant Journée';
//                     Enabled = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Payment Class"; REC."Payment Class")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field(Valider; REC.Valider)
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Validé Par"; REC."Validé Par")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("N° Affaire"; REC."N° Affaire")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Solde Caisse OACA"; REC."Solde Caisse OACA")
//                 {
//                     ApplicationArea = All;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                 }
//             }
//         }
//     }


//     trigger OnAfterGetRecord()
//     begin


//         // << HJ DSFT 08-11-2009
//         IF RecUser.Niveau = 0 THEN ERROR(Text011);
//         IF RecUser.Niveau = 1 THEN REC.SETRANGE(Utilisateur, USERID);
//         IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
//             REC.SETRANGE(Agence, RecUser.Agence)
//         ELSE
//             REC.SETRANGE(Agence);
//         // >> HJ DSFT 08 11 2010
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         // >> HJ DSFT 21-01-2009
//         IF RecUser.GET(UPPERCASE(USERID)) THEN REC.Agence := RecUser.Agence;
//         REC.Utilisateur := UPPERCASE(USERID);
//         // << HJ DSFT 21-01-2009
//     end;


//     trigger OnOpenPage()
//     begin
//         // << HJ DSFT 21-01-2009
//         RecUser.GET(UPPERCASE(USERID));
//         IF RecUser.Niveau = 0 THEN ERROR(Text0011);
//         IF RecUser.Niveau = 1 THEN REC.SETRANGE(Utilisateur, UPPERCASE(USERID));
//         IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
//             REC.SETRANGE(Agence, RecUser.Agence)
//         ELSE
//             REC.SETRANGE(Agence);
//         REC.SETRANGE("Account Type", REC."Account Type"::"Bank Account");



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
//         // "--MBK--": ;
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
//         // "--HJ--": ;
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





// }

