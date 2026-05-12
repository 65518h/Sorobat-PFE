// Page 50285 "Véhicule Contrat"
// {
//     PageType = Card;
//     SourceTable = "Détails Véhicules";
//     SourceTableView = sorting(Code)
//                       where(Type = const(Contrat));

//     Caption = 'Véhicule Contrat';
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
//                 field("Date debut contrat"; REC."Date debut contrat")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date fin contrat"; REC."Date fin contrat")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Observation Contrat"; REC."Observation Contrat")
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
//         REC.Code := NoSeriesMgt.GetNextNo('V-CONTRV', 0D, true);
//         REC.Type := REC.Type::Contrat;
//     end;

//     var
//         NoSeriesMgt: Codeunit NoSeriesManagement;
// }

