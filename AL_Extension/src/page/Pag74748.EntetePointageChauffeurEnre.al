// page 74748 "Entete Pointage Chauffeur Enre"
// {//GL2024  ID dans Nav 2009 : "39004748"
//     DeleteAllowed = false;
//     Editable = true;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = Card;
//     SourceTable = "Entete Pointage Chauffeur Enre";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 Editable = false;
//                 field("N° Document"; REC."N° Document")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Journee1; REC.Journee)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Affectation; REC.Affectation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Designation Affectation"; REC."Designation Affectation")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             part(ligne; "Ligne Pointage Chauffeur Enre")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//                 SubPageLink = "N° Document" = FIELD("N° Document"),
//                               Journee = FIELD(Journee),
//                               "Code Affaire" = FIELD(Affectation);
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         EntetePointageChauffeur: Record "Entete Pointage Chauffeur";
//         PointageChauffeur: Record "Ligne Pointage Chauffeur";
//         PointageChauffeurEnregistre: Record "Ligne Pointage Chauffeur Enr";
//         DteJournee: Date;
//         Affectation: Code[20];
//         RecVehicule: Record "Véhicule";
//         PointageChauffeur2: Record "Ligne Pointage Chauffeur";
//         Text001: Label 'Confirmer Cette Action ?';
//         Text002: Label 'Vous Devez Preciser La Journee';
//         Text003: Label 'Vous Devez D''abords Valider La Journee %1';
//         Text004: Label 'Journée Deja Saisie';
//         PointageChauffeurEnregistre3: Record "Ligne Pointage Chauffeur Enr";
//         EntetePointageChauffeurEnre: Record "Entete Pointage Chauffeur Enre";
// }

