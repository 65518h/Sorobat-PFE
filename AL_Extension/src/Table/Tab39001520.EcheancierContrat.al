// Table 39001520 "Echeancier Contrat"
// {
//     //GL2024  ID dans Nav 2009 : "39001520"
//     fields
//     {
//         field(1; "N°"; Integer)
//         {
//         }
//         field(2; Contrat; Code[20])
//         {
//         }
//         field(3; "Date Echeance"; Date)
//         {
//         }
//         field(4; "Loyer TTC"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(5; "Restant Du"; Decimal)
//         {
//         }
//         field(6; Annee; Integer)
//         {
//         }
//         field(7; "Total Annee"; Boolean)
//         {
//         }
//         field(8; Total; Decimal)
//         {
//         }
//         field(9; "Mode Paiement"; Option)
//         {
//             OptionMembers = Traite,Cheque;
//         }
//     }

//     keys
//     {
//         key(STG_Key1; "N°", Contrat)
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }
// }

