// Page 50152 "Liste BT GMAO Enre"
// {
//     PageType = List;
//     SourceTable = "Entete BT Enreg";
//     ApplicationArea = All;
//     Caption = 'Liste BT GMAO Enre';
//     CardPageId = "Entete BT Preventive Enreg";
//     //GL2024  CardPageId = "Entete BT Curative Enreg";
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 Editable = false;
//                 ShowCaption = false;
//                 field("Code"; REC.Code)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Type; REC.Type)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Lancement"; REC."Date Lancement")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Equipement; REC.Equipement)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Immatriculation; REC.Immatriculation)
//                 {
//                     ApplicationArea = all;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field(Gamme; REC.Gamme)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Frequence; REC.Frequence)
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

