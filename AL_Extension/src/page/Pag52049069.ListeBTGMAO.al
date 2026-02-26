// Page 52049069 "Liste BT GMAO"
// {//GL2024  ID dans Nav 2009 : "39004774"
//     PageType = ListPart;
//     SourceTable = "Entete BT";
//     SourceTableView = sorting("Date Lancement");
//     ApplicationArea = All;
//     CardPageId = "Entete BT Preventive";
//     //GL2024  CardPageId = "Entete BT Curative";
//     layout
//     {
//         area(content)
//         {
//             label(Control1000000018)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'BT EN COURS';
//                 Style = Unfavorable;
//                 StyleExpr = true;
//             }
//             repeater(Control1000000000)
//             {
//                 Editable = false;
//                 field("Code"; Rec.Code)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Type; Rec.Type)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Date Lancement"; Rec."Date Lancement")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Equipement; Rec.Equipement)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Immatriculation; Rec.Immatriculation)
//                 {
//                     ApplicationArea = Basic;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field(Gamme; Rec.Gamme)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Frequence; Rec.Frequence)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Utilisateur; Rec.Utilisateur)
//                 {
//                     ApplicationArea = Basic;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//             }

//         }
//     }

//     actions
//     {
//     }

//     var
//         Text19075909: label 'BT EN COURS';
// }

