// Table 39004737 Gamme
// {
//     //GL2024  ID dans Nav 2009 : "39004737"
//     LookupPageID = "Liste Gamme";

//     fields
//     {
//         field(1; "Code Gamme"; Code[30])
//         {
//         }
//         field(2; Desgniation; Text[200])
//         {
//         }
//         field(3; "Code sous Famille Equipement"; Code[100])
//         {
//             TableRelation = "Sous Catégorie Véhicule"."Code Sous-Catégorie";
//         }
//         field(4; "Fréquence"; Decimal)
//         {
//             DecimalPlaces = 0 : 0;
//         }
//         field(5; Status; Option)
//         {
//             OptionMembers = "En Instance","Validé";
//         }
//         field(6; "Fréquence (Tolerance)"; Decimal)
//         {
//             DecimalPlaces = 0 : 0;
//         }
//     }

//     keys
//     {
//         key(Key1; "Code Gamme")
//         {
//             Clustered = true;
//         }
//         key(Key2; "Code sous Famille Equipement", "Fréquence")
//         {
//         }
//     }

//     fieldgroups
//     {
//     }
// }

