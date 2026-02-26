// page 52048990 "FOR-Virement Salaire"
// {
//     //GL2024  ID dans Nav 2009 : "39001518"
//     PageType = Card;
//     SourceTable = "Entete Virement Salaire";

//     Caption = 'FOR-Virement Salaire';
//     layout
//     {
//         area(content)
//         {
//             group("Général")
//             {
//                 Caption = 'Général';
//                 field("N°"; rec."N°")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'N°';
//                 }
//                 field(Montant; rec.Montant)
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3 : 3;
//                     Editable = false;
//                 }
//                 field(Annee; rec.Annee)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Mois; rec.Mois)
//                 {
//                     ApplicationArea = all;
//                     DrillDown = false;
//                     Editable = false;
//                 }
//                 field(Lot; rec.Lot)
//                 {
//                     ApplicationArea = all;
//                     DrillDown = false;
//                     Editable = false;
//                 }
//             }
//             part("SUBFOR-Virement Salaire"; "SUBFOR-Virement Salaire")
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "N°" = FIELD("N°");
//             }
//         }
//     }

//     actions
//     {
//     }
// }

