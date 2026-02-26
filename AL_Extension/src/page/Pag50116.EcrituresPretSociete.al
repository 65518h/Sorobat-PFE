// Page 50116 "Ecritures Pret Societe"
// {
//     PageType = List;
//     SourceTable = "Echelon Temporaire";
//     ApplicationArea = all;
//     Caption = 'Ecritures Pret Societe';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Nouveau Echelon"; REC."Nouveau Echelon")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Ancienté"; REC.Ancienté)
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
//                 field("Ancien Echelon"; REC."Ancien Echelon")
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

