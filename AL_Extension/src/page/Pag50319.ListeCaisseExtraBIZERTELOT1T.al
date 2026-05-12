//GL2024
// page 50319 "Liste Cai Ex. BIZERTE LOT1T"
// {
//     //GL2024 NEW PAGE
//     Caption = 'Liste Caisse Extra BIZERTE LOT1T';
//     RefreshOnActivate = true;
//     PageType = List;
//     DeleteAllowed = true;
//     SourceTable = "Payment Header";
//     SourceTableView = WHERE("Payment Class" = CONST('CAISSEEXT'), Valider = CONST(false), "Caisse Chantier" = CONST(false), "N° Affaire" = FILTER('PONT_BIZERTE_LOT1' | ''));
//     ApplicationArea = all;
//     CardPageId = "Caisse Extra BIZERTE LOT1";
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
//                     ApplicationArea = all;
//                 }
//                 field("Document Date"; REC."Document Date")
//                 {
//                     Caption = 'Journée';
//                     ApplicationArea = all;
//                 }
//                 field("Account No."; REC."Account No.")
//                 {
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                     ApplicationArea = all;
//                 }

//                 field("Payment Class"; REC."Payment Class")
//                 {

//                     Style = Strong;
//                     StyleExpr = TRUE;
//                     ApplicationArea = all;
//                 }
//                 field(Valider2; REC.Valider)
//                 {
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                     ApplicationArea = all;
//                 }
//                 field("Validé Par"; REC."Validé Par")
//                 {
//                     Editable = false;
//                     ApplicationArea = all;
//                 }
//                 field("N° Affaire"; REC."N° Affaire")
//                 {
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                     ApplicationArea = all;
//                 }
//                 field("Solde Caisse Bizerte Lot1"; REC."Solde Caisse Bizerte Lot1")
//                 {
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                     ApplicationArea = all;
//                 }

//                 field("Amount (LCY)"; REC."Amount (LCY)")
//                 {
//                     Caption = 'Montant Brouillards';
//                     Enabled = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }


//     trigger OnAfterGetRecord()
//     begin
//         // << HJ DSFT 08-11-2009
//         RecUser.GET(UPPERCASE(USERID));
//         IF RecUser.Niveau = 0 THEN ERROR(Text011);
//         IF RecUser.Niveau = 1 THEN REC.SETRANGE(Utilisateur, USERID);
//         IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
//             REC.SETRANGE(Agence, RecUser.Agence)
//         ELSE
//             REC.SETRANGE(Agence);
//         // >> HJ DSFT 08 11 2010
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

//         RecUser: Record "User Setup";
//         Text0011: Label 'Vous N''ete Pas Autorisé Au Module Encaissement - Decaissement';
//         Text011: Label 'N° chèque %1 utlisé plus d''une fois';
// }

