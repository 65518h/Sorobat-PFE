// Page 50056 "Liste Affectation Employé"
// {
//     Editable = false;
//     PageType = list;
//     SourceTable = "Affectation Employé";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Liste Affectation Employé';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("N°"; rec."N°")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Journée"; rec.Journée)
//                 {
//                     ApplicationArea = all;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field(Affectation; rec.Affectation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Utilisateur; rec.Utilisateur)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Validé"; rec.Validé)
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

