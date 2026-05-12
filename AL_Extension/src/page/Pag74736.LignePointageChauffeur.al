// Page 74736 "Ligne Pointage Chauffeur"
// {//GL2024  ID dans Nav 2009 : "39004736"
//     DelayedInsert = true;
//     Editable = true;
//     PageType = ListPart;
//     SourceTable = "Ligne Pointage Chauffeur";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000010)
//             {
//                 field(Journee; Rec.Journee)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Chauffeur; Rec.Chauffeur)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Nom Chauffeur"; Rec."Nom Chauffeur")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Vehicule; Rec.Vehicule)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                 }
//                 field("Nom Vehicule"; Rec."Nom Vehicule")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Code Affaire"; Rec."Code Affaire")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Designation Affaire"; Rec."Designation Affaire")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Code Sous Affaire"; Rec."Code Sous Affaire")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Designation Sous Affaire"; Rec."Designation Sous Affaire")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Point Chargement"; Rec."Point Chargement")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Point Dechargement"; Rec."Point Dechargement")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Nombre Heure"; Rec."Nombre Heure")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Deplacement; Rec.Deplacement)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         PointageChauffeur: Record "Ligne Pointage Chauffeur";
//         PointageChauffeurEnregistre: Record "Ligne Pointage Chauffeur Enr";
//         DteJournee: Date;
//         Text001: label 'Confirmer Cette Action ?';
//         Text002: label 'Vous Devez Preciser La Journee';
//         Text003: label 'Vous Devez D''abords Valider La Journee %1';
//         Text004: label 'Journee Deja Saisie';
//         Affectation: Code[20];
//         RecVehicule: Record "Véhicule";
//         PointageChauffeur2: Record "Ligne Pointage Chauffeur";
// }

