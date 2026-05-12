// page 50054 "Affectation Employé"
// {
//     PageType = Card;
//     SourceTable = "Affectation Employé";
//     Caption = 'Affectation Employé';
//     ApplicationArea = all;
//     UsageCategory = Administration;

//     layout
//     {
//         area(content)
//         {
//             group("Général")
//             {
//                 Caption = 'General';
//                 field("N°"; rec."N°")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                 }
//                 field(Journée; rec.Journée)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Affectation; rec.Affectation)
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Description Affectation"; rec."Description Affectation")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
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
//                 }
//             }
//             part("Ligne Affectation Employé"; "Ligne Affectation Employé")
//             {
//                 ApplicationArea = all;
//                 Caption = '"Employee Assignment Line';

//                 SubPageLink = "N°" = FIELD("N°");
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Actualiser)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Refresh';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 var
//                     txt001: Label 'Insertion Completed';

//                 begin
//                     //Currpage.Lines.FORM.EDITABLE(TRUE);

//                     RecEmployé.RESET();
//                     RecEmployé.SETRANGE(Blocked, FALSE);
//                     RecEmployé.SETRANGE(Affectation, rec.Affectation);
//                     IF RecEmployé.FINDFIRST THEN
//                         REPEAT
//                             RecLignePointageEmployé."N°" := rec."N°";
//                             RecLignePointageEmployé.VALIDATE(RecLignePointageEmployé.Employé, RecEmployé."No.");
//                             RecLignePointageEmployé.Journée := rec.Journée;
//                             RecLignePointageEmployé.INSERT;

//                         UNTIL RecEmployé.NEXT = 0;
//                     MESSAGE(txt001);
//                 end;
//             }
//         }
//     }

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         rec."N°" := NoSeriesMgt.GetNextNo('PSAL-AFECT', 0D, TRUE);
//         rec.Utilisateur := USERID;
//     end;

//     var
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         "RePointageEmployé": Record "Affectation Employé";
//         "RecEmployé": Record Employee;
//         "RecLignePointageEmployé": Record "Ligne Affectation Employé";
// }

