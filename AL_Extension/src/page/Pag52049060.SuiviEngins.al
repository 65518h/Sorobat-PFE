// Page 52049060 "Suivi Engins"
// {//GL2024  ID dans Nav 2009 : "39004753"
//     PageType = List;
//     SourceTable = "Véhicule";
//     SourceTableView = where(Bloquer = const(false));
//     ApplicationArea = All;
//     Caption = 'Suivi Engins';
//     UsageCategory = Lists;


//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;
//                 field(Societe; Rec.Societe)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("No Vehicule"; REC."N° Vehicule")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Désignation"; Rec.Désignation)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Immatriculation; Rec.Immatriculation)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Num Châssis"; Rec."Num Châssis")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Marche; Rec.Marche)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Sous Affaire"; Rec."Sous Affaire")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Chauffeur; Rec.Chauffeur)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Statut; Rec.Statut)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
// }

