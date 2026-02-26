//GL2024
// page 50316 "Liste Caisse Extra PENETRANTE"
// {
//     //GL2024 NEW PAGE
//     Caption = 'Liste Caisse Extra PENETRANTE';
//     RefreshOnActivate = true;
//     PageType = List;
//     DeleteAllowed = true;
//     SourceTable = "Payment Header";
//     SourceTableView = WHERE("Payment Class" = CONST('CAISSEEXT'), Valider = CONST(false), "Caisse Chantier" = CONST(false), "N° Affaire" = FILTER('PENETRANTE_LOT3' | ''));
//     ApplicationArea = all;
//     CardPageId = "Caisse Extra PENETRANTE";
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
//                 field(Valider; REC.Valider)
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
//                 field("Solde Caisse PENETRANTE"; REC."Solde Caisse PENETRANTE")
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
//         // << HJ DSFT 08-11-2009
//         IF RecUser.Niveau = 0 THEN ERROR(Text011);
//         IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, USERID);
//         IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
//             rec.SETRANGE(Agence, RecUser.Agence)
//         ELSE
//             rec.SETRANGE(Agence);
//     end;

//     trigger OnOpenPage()
//     begin
//         // << HJ DSFT 21-01-2009
//         RecUser.GET(UPPERCASE(USERID));
//         IF RecUser.Niveau = 0 THEN ERROR(Text0011);
//         IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, UPPERCASE(USERID));
//         IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
//             rec.SETRANGE(Agence, RecUser.Agence)
//         ELSE
//             rec.SETRANGE(Agence);
//         rec.SETRANGE("Account Type", REC."Account Type"::"Bank Account");


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

