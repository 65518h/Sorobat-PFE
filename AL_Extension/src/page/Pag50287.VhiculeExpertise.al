// Page 50287 "Véhicule Expertise"
// {
//     PageType = Card;
//     SourceTable = "Détails Véhicules";
//     SourceTableView = sorting(Code)
//                       where(Type = const(Expertise));

//     Caption = 'Vehicle Expertise';

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
//                 field("Date Demande Expertise"; REC."Date Demande Expertise")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Type Expertise"; REC."Type Expertise")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Lieu; REC.Lieu)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Responsable; REC.Responsable)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Qualification; REC.Qualification)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Matricule; REC.Matricule)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Type et Modele"; REC."Type et Modele")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Marque; REC.Marque)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nature de La Panne"; REC."Nature de La Panne")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Durée Prévue de l'arret"; REC."Durée Prévue de l'arret")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(BPRINT)
//             {
//                 ApplicationArea = all;
//                 Caption = '&Imprimer Format A4';
//                 Ellipsis = true;
//                 Image = Print;
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin

//                     RecDétailsVéhicules.SetRange(Code, REC.Code);
//                     Report.RunModal(Report::"Demande Expertise", true, true, RecDétailsVéhicules);
//                 end;
//             }
//         }
//     }

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         REC.Code := NoSeriesMgt.GetNextNo('V-EXPERTV', 0D, true);
//         REC.Type := REC.Type::Expertise;
//     end;

//     var
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         "RecDétailsVéhicules": Record "Détails Véhicules";
// }

