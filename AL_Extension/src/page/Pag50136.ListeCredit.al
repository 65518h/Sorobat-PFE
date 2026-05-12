// Page 50136 "Liste Credit"
// {
//     PageType = List;
//     SourceTable = "Entete Credit";
//     SourceTableView = sorting("Numero Credit");
//     ApplicationArea = all;
//     Caption = 'Liste Credit';

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 Editable = false;
//                 field("Numero Credit"; REC."Numero Credit")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Banque; REC.Banque)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Compte Bancaire"; REC."Compte Bancaire")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Type Calcul"; REC."Type Calcul")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Credit"; REC."Date Credit")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nombre Tranche"; REC."Nombre Tranche")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(TMM; REC.TMM)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Taux Interet"; REC."Taux Interet")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Taux Credit"; REC."Taux Credit")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Montant Credit"; REC."Montant Credit")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Observation; REC.Observation)
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

