// Page 50284 "Véhicule Concessionnaire"
// {
//     PageType = Card;
//     SourceTable = "Détails Véhicules";
//     SourceTableView = sorting(Code)
//                       where(Type = const(concessionnaire));

//     Caption = 'Véhicule Concessionnaire';
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
//                 field(Date; REC.Date)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Observation; REC.Observation)
//                 {
//                     ApplicationArea = all;
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
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         REC.Code := NoSeriesMgt.GetNextNo('V-CONC', 0D, true);
//         REC.Type := REC.Type::concessionnaire;
//     end;

//     var
//         NoSeriesMgt: Codeunit NoSeriesManagement;
// }

