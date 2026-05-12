//GL3900 
// Page 74744 "Suivi Statut Vehicule Enregist"
// {//GL2024  ID dans Nav 2009 : "39004744"
//     DeleteAllowed = false;
//     Editable = true;
//     InsertAllowed = false;
//     ModifyAllowed = true;
//     PageType = List;
//     SourceTable = "Lig Programmation Enr";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1120000)
//             {
//                 Editable = false;
//                 field(Journee; Rec.Journee)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Vehicule; Rec.Vehicule)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Nom Vehicule"; Rec."Nom Vehicule")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Chauffeur; Rec.Chauffeur)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Nom Chauffeur"; Rec."Nom Chauffeur")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Index Final"; Rec."Index Final")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Tonnage; Rec.Tonnage)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("N° BL"; Rec."N° BL")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Index Depart"; Rec."Index Depart")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Code Affaire"; Rec."Code Affaire")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Designation Affaire"; Rec."Designation Affaire")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Code Sous Affaire"; Rec."Code Sous Affaire")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Designation Sous Affaire"; Rec."Designation Sous Affaire")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Nombre Voyage"; Rec."Nombre Voyage")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Point Chargement"; Rec."Point Chargement")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Point Dechargement"; Rec."Point Dechargement")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Statut; Rec.Statut)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Code Sous Affaire 2"; Rec."Code Sous Affaire 2")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Designation Sous Affaire 2"; Rec."Designation Sous Affaire 2")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Observation; Rec.Observation)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnOpenPage()
//     begin
//         if Rec.FindLast then DteJournee := Rec.Journee;
//     end;

//     var
//         Text001: label 'Confirmer Cette Action ?';
//         DteJournee: Date;
//         RecVehicule: Record "Véhicule";
//         SuiviVehiculeParStatut: Record "Linge Programmation";
//         SuiviVehiculeParStatutEnregist: Record "Lig Programmation Enr";
//         Text002: label 'Vous Devez Preciser La Journee';
//         Text003: label 'Vous Devez D''abords Valider La Journee %1';
//         Text004: label 'Journee Deja Saisie';
// }

