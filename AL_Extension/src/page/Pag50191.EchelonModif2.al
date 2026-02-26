// Page 50191 "Echelon Modif 2"
// {
//     PageType = List;
//     SourceTable = "Echelon Temporaire";
//     ApplicationArea = all;
//     Caption = 'Echelon Modif 2';
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             label(Control1000000018)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Historique Passage Echelon';
//                 StyleExpr = true;
//             }
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Code"; REC.Code)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Date Modification"; REC."Date Modification")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Matricule; REC.Matricule)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Nom et Prénom"; REC."Nom et Prénom")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Date Embauche"; REC."Date Embauche")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Ancienté"; REC.Ancienté)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Ancien Echelon"; REC."Ancien Echelon")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Nouveau Echelon"; REC."Nouveau Echelon")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//             }

//         }
//     }

//     actions
//     {
//     }

//     var
//         Text001: label 'Voulez vous valider le changement de l''échelon ?';
//         RecEmployee: Record Employee;
//         EchelonTemporaire: Record "Echelon Temporaire";
//         Text19071353: label 'Historique Passage Echelon';
// }

