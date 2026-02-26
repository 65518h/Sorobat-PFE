// Page 50288 "Liste Détails Véhicules"
// {
//     Editable = false;
//     PageType = List;
//     SourceTable = "Détails Véhicules";
//     ApplicationArea = all;
//     Caption = 'Liste Véhicule Entretien';
//     CardPageId = "Véhicule Entretien";
//     UsageCategory = Lists;
//     //DYS - JBS Not Used in Nav 09
//     // SourceTableView = sorting(Code)
//     //                   where(Type = const(Entretien));
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Code"; REC.Code)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Type; REC.Type)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Code Véhicule"; REC."Code Véhicule")
//                 {
//                     ApplicationArea = all;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field("Designation Vehicule"; REC."Designation Vehicule")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Immatriculation; REC.Immatriculation)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Fournisseur; REC.Fournisseur)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nom Fournisseur"; REC."Nom Fournisseur")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Date Entretien"; REC."Date Entretien")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Index Véhicule"; REC."Index Véhicule")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Observation Entretien"; REC."Observation Entretien")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }



// }