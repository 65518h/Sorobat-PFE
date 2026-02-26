//GL2024
// page 50317 "Liste Caisse Extra RAOUED RP2"
// {
//     //GL2024 NEW PAGE
//     Caption = 'Liste Caisse Extra RAOUED RP2';
//     RefreshOnActivate = true;
//     PageType = List;
//     DeleteAllowed = true;
//     SourceTable = "Payment Header";
//     SourceTableView = WHERE("Payment Class" = CONST('CAISSEEXT'), Valider = CONST(false), "Caisse Chantier" = CONST(false), "N° Affaire" = FILTER('PORT FINA RAOUED RP2' | ''));

//     ApplicationArea = all;
//     CardPageId = "Caisse Extra RAOUED RP2";
//     UsageCategory = lists;






//     layout
//     {
//         area(content)
//         {
//             repeater(content1)
//             {
//                 ShowCaption = false;
//                 Editable = false;
//                 field("No."; REC."No.")
//                 {
//                     Caption = 'N° Document';
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                 }
//                 field("Document Date"; REC."Document Date")
//                 {
//                     Caption = 'Journée';
//                 }
//                 field("Account No."; REC."Account No.")
//                 {
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }

//                 field("Payment Class"; REC."Payment Class")
//                 {

//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field(Valider2; REC.Valider)
//                 {
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Validé Par"; REC."Validé Par")
//                 {
//                     Editable = false;
//                 }
//                 field("N° Affaire"; REC."N° Affaire")
//                 {
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Solde Caisse RAOUED RP2"; REC."Solde Caisse RAOUED RP2")
//                 {
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                 }

//                 field("Amount (LCY)"; REC."Amount (LCY)")
//                 {
//                     Caption = 'Montant Brouillards';
//                     Enabled = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         IF RecUser.Niveau = 0 THEN ERROR(Text011);
//         IF RecUser.Niveau = 1 THEN REC.SETRANGE(Utilisateur, USERID);
//         IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
//             REC.SETRANGE(Agence, RecUser.Agence)
//         ELSE
//             REC.SETRANGE(Agence);
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


//         //IF Valider=TRUE   THEN
//         //  BEGIN
//         //  Currpage.EDITABLE(FALSE);
//         //  // Currpage.Lines.FORM.EDITABLE(FALSE);
//         // END
//         //ELSE Currpage.EDITABLE(TRUE);

//         //<< HJ DSFT 21-01-2009IF (Valider)   THEN
//     end;

//     var
//         RecUser: Record "User Setup";
//         Text0011: Label 'Vous N''ete Pas Autorisé Au Module Encaissement - Decaissement';
//         Text011: Label 'N° chèque %1 utlisé plus d''une fois';

// }

