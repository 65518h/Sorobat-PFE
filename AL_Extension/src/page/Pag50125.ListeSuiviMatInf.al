// Page 50125 "Liste Suivi Mat Inf"
// {
//     Editable = false;
//     PageType = List;
//     SourceTable = "Entete Suivi Materiel Inf";
//     ApplicationArea = all;
//     Caption = 'Liste Suivi Mat Inf';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(Affaire; REC.Affaire)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Employee; REC.Employee)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Enabled = true;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field(Observation; REC.Observation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nom Preleveur"; REC."Nom Preleveur")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nom Et Prenom"; REC."Nom Et Prenom")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Affectation; REC.Affectation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Qualification; REC.Qualification)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Statut; REC.Statut)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
// }

