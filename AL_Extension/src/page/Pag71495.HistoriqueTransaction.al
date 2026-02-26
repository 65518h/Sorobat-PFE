//GL3900 
// page 71495 "Historique Transaction"
// {//GL2024  ID dans Nav 2009 : "39001495"
//     DeleteAllowed = false;
//     Editable = false;
//     InsertAllowed = false;
//     PageType = Card;
//     SaveValues = false;
//     SourceTable = "Carière Enreg";
//     SourceTableView = SORTING(employee, "Date Décesion");
//     UsageCategory = Administration;
//     ApplicationArea = all;
//     Caption = 'Historique Transaction';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(date; rec.date)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Name; rec.Name)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("First Name"; rec."First Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Décesion"; rec."Date Décesion")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Type; rec.Type)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Salaire Base"; rec."Salaire Base")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nbre Mois Bonification"; rec."Nbre Mois Bonification")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Status; rec.Status)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Entrée"; rec."Date Entrée")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Catégorie soc."; rec."Catégorie soc.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Collège; rec.Collège)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date debut Contrat"; rec."Date debut Contrat")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Fin Contrat"; rec."Date Fin Contrat")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Echelon; rec.Echelon)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Grade; rec.Grade)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Echelle; rec.Echelle)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Classe; rec.Classe)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Fonction; rec.Fonction)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(employee; rec.employee)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Relation de travail"; rec."Relation de travail")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Site de travail"; rec."Site de travail")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Désignation Site de travail"; rec."Désignation Site de travail")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Document Extr."; rec."N° Document Extr.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Qualification; rec.Qualification)
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
//             action("Décision Admin.")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Décision Admin.';
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 RunObject = page "Décision Administratif Enreg.";
//                 RunPageLink = "N° sequence" = FIELD("N° sequence");
//             }
//         }
//     }
// }

