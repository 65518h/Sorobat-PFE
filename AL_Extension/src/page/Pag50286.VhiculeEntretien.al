// Page 50286 "Véhicule Entretien"
// {
//     PageType = Card;
//     SourceTable = "Détails Véhicules";
//     SourceTableView = sorting(Code)
//                       where(Type = const(Entretien));

//     Caption = 'Véhicule Entretien';
//     layout
//     {
//         area(content)
//         {
//             group(Control1)
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

//     actions
//     {
//     }

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         REC.Code := NoSeriesMgt.GetNextNo('V-ENTRV', 0D, true);
//         REC.Type := REC.Type::Entretien;
//     end;

//     var
//         NoSeriesMgt: Codeunit NoSeriesManagement;
// }

