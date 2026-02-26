//GL2024
// page 50315 "Liste Caisse Extra RFR"
// {
//     //GL2024 NEW PAGE
//     Caption = 'Liste Caisse Journaliére PENETRANTE LOT2';
//     RefreshOnActivate = true;
//     PageType = List;
//     DeleteAllowed = true;
//     SourceTable = "Payment Header";
//     SourceTableView = WHERE("Payment Class" = CONST('CAISSEEXT'), Valider = CONST(false), "Caisse Chantier" = CONST(false), "N° Affaire" = FILTER('PENETRANTE_LOT2' | ''));
//     ApplicationArea = all;
//     CardPageId = "Caisse Extra RFR";
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
//                     ApplicationArea = all;
//                     Caption = 'N° Document';
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                 }
//                 field("Document Date"; REC."Document Date")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Journée';
//                 }
//                 field("Account No."; REC."Account No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Payment Class"; REC."Payment Class")
//                 {
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }

//                 field(Valider1; rec.Valider)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Validé Par1"; rec."Validé Par")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("N° Affaire1"; rec."N° Affaire")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Solde Caisse RFR1"; rec."Solde Caisse RFR")
//                 {
//                     ApplicationArea = all;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                 }




//                 field("Amount (LCY)"; rec."Amount (LCY)")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Montant Brouillards';
//                     Enabled = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }

//             }
//         }
//     }

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

//     trigger OnAfterGetRecord()
//     begin
//         RecUser.GET(UPPERCASE(USERID));
//         // << HJ DSFT 08-11-2009
//         IF RecUser.Niveau = 0 THEN ERROR(Text011);
//         IF RecUser.Niveau = 1 THEN REC.SETRANGE(Utilisateur, USERID);
//         IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
//             REC.SETRANGE(Agence, RecUser.Agence)
//         ELSE
//             REC.SETRANGE(Agence);
//         // >> HJ DSFT 08 11 2010
//     end;

//     var
//         RecUser: Record "User Setup";
//         Text011: Label 'N° chèque %1 utlisé plus d''une fois';

//         Text0011: Label 'Vous N''ete Pas Autorisé Au Module Encaissement - Decaissement';
// }

