// Page 50293 "Liste Pointage Employée"
// {
//     Editable = false;
//     PageType = List;
//     SourceTable = "Pointage Employé";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Liste Pointage Employée';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("N°"; REC."N°")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Journée"; REC.Journée)
//                 {
//                     ApplicationArea = all;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field(Chantier; REC.Chantier)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Utilisateur; REC.Utilisateur)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nbre Effectif"; REC."Nbre Effectif")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Validé"; REC.Validé)
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
// }

