// page 50334 "Liste Entete BT Preventive En."
// {//GL2024 NEW PAGE
//     Editable = false;
//     PageType = list;
//     SourceTable = "Entete BT Enreg";
//     SourceTableView = SORTING(Code)
//                       WHERE(Type = FILTER(Preventive));
//     Caption = 'Liste BT Preventive Enreg';
//     ApplicationArea = all;
//     UsageCategory = lists;
//     InsertAllowed = false;
//     CardPageId = "Entete BT Preventive Enreg";
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

