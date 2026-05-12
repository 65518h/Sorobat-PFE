// page 50295 "Pointage Employé Validé"
// {
//     PageType = Card;
//     SourceTable = "Pointage Employé";
//     SourceTableView = SORTING("N°")
//                       WHERE(Validé = CONST(true));
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     Caption = 'Pointage Employé Validé';

//     layout
//     {
//         area(content)
//         {
//             group("Général")
//             {
//                 Caption = 'Général';
//                 field("N°"; rec."N°")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field(Journée; rec.Journée)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field(Chantier; rec.Chantier)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                 }
//                 field(Utilisateur; rec.Utilisateur)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field(Validé; rec.Validé)
//                 {
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//             }
//             part(Lines; "Subform Ligne Pointage Employé")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//                 SubPageLink = "N°" = FIELD("N°");
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         rec."N°" := NoSeriesMgt.GetNextNo('PSAL', 0D, TRUE);
//         rec.Utilisateur := USERID;
//         rec.Chantier := 'AIN-ZAGHOUEN';
//     end;

//     var
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         Text001: Label 'Il faut date de la journée !!';
//         Text002: Label 'Pointage Validé avec succée';
//         Text003: Label 'Voulez vous valider le pointage ?';
// }

