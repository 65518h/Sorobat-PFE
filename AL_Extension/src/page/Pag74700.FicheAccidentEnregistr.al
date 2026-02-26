//GL3900 
// page 74700 "Fiche Accident Enregistré"
// {//GL2024  ID dans Nav 2009 : "39004700"
//     Editable = false;
//     PageType = Card;
//     SourceTable = "Accidents Enregistrés";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             group("Général")
//             {
//                 Caption = 'Général';
//                 field("N° Accident"; REC."N° Accident")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Document"; REC."Date Document")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Affaire"; REC."N° Affaire")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Tache Affaire"; REC."N° Tache Affaire")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Centre de Gestion"; REC."Centre de Gestion")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Accident"; REC."Date Accident")
//                 {
//                 }
//                 field("N° Mission"; REC."N° Mission")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Véhicule"; REC."N° Véhicule")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Immatriculation"; REC."N° Immatriculation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Constat"; REC."N° Constat")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Conducteur"; REC."N° Conducteur")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nom Conducteur"; REC."Nom Conducteur")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Fonction Conducteur"; REC."Fonction Conducteur")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Accident)
//             {
//                 Caption = 'Accident';
//                 action("Fiche Mission")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Fiche Mission';
//                     RunObject = Page "Mission Enregistré";
//                     RunPageLink = "N° Mission" = FIELD("N° Mission");
//                 }
//                 action("Fiche Véhicule")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Fiche Véhicule';
//                     RunObject = Page "Fiche Véhicule";
//                     RunPageLink = "N° Vehicule" = FIELD("N° Véhicule");
//                 }

//                 action("Dégats")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Dégats';
//                     RunObject = Page "Ligne dégats";
//                     RunPageLink = "N° Accident" = FIELD("N° Accident"),
//                                   "N° constat" = FIELD("N° Constat");
//                 }
//             }
//         }
//     }
// }

