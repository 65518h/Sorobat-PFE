// page 50281 "Pointage Employé"
// {
//     PageType = Card;
//     SourceTable = "Pointage Employé";
//     SourceTableView = SORTING("N°")
//                       WHERE(Validé = CONST(false));
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     Caption = 'Pointage Employé';

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
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//             }
//             part(Lines; "Subform Ligne Pointage Employé")
//             {
//                 ApplicationArea = all;
//                 Editable = true;
//                 SubPageLink = "N°" = FIELD("N°");
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Valider)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Valider';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     IF NOT CONFIRM(Text003, FALSE) THEN EXIT;
//                     rec.Validé := TRUE;
//                     rec.MODIFY;
//                     MESSAGE(Text002);
//                 end;
//             }
//             action(Actualiser)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Actualiser';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     //Currpage.Lines.FORM.EDITABLE(TRUE);

//                     RePointageEmployé.RESET();
//                     RePointageEmployé.SETRANGE(Validé, TRUE);
//                     IF RePointageEmployé.FINDLAST THEN BEGIN
//                         RecLignePointageEmployé.RESET();
//                         RecLignePointageEmployé.SETRANGE("N°", RePointageEmployé."N°");
//                         RecLignePointageEmployé.SETFILTER(Employé, '<>%1', '');
//                         IF RecLignePointageEmployé.FINDFIRST THEN
//                             REPEAT
//                                 RecLignePointageEmployé2."N°" := rec."N°";
//                                 RecLignePointageEmployé2.VALIDATE(RecLignePointageEmployé2.Employé, RecLignePointageEmployé.Employé);
//                                 RecLignePointageEmployé2.Journée := rec.Journée;
//                                 RecLignePointageEmployé2.Chantier := rec.Chantier;
//                                 RecLignePointageEmployé2.INSERT;

//                             UNTIL RecLignePointageEmployé.NEXT = 0;
//                         MESSAGE('Insertion Terminé');
//                     END;
//                 end;
//             }
//         }
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
//         "RePointageEmployé": Record "Pointage Employé";
//         "RecLignePointageEmployé": Record "Ligne Pointage Employé";
//         "RecLignePointageEmployé2": Record "Ligne Pointage Employé";
// }

