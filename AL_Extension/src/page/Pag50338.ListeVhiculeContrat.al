// Page 50338 "Liste Véhicule Contrat"
// {//GL2024 NEW PAGE
//     PageType = list;
//     SourceTable = "Détails Véhicules";
//     SourceTableView = sorting(Code)
//                       where(Type = const(Contrat));
//     ApplicationArea = all;
//     Caption = 'Liste Véhicule Contrat';
//     CardPageId = "Véhicule Contrat";
//     Editable = false;
//     UsageCategory = Lists;

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
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Type; REC.Type)
//                 {
//                     ApplicationArea = all;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field(Observation; REC.Observation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Code Véhicule"; REC."Code Véhicule")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Designation Vehicule"; REC."Designation Vehicule")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Immatriculation; REC.Immatriculation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Date; REC.Date)
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

// }

