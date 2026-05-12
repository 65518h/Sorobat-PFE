// Table 39004720 "Lien Materiel Immobilisation"
// {
//     //GL2024  ID dans Nav 2009 : "39004720"
//     fields
//     {
//         field(1; "N° Materiel"; Code[20])
//         {
//         }
//         field(2; "N° Immobilisation"; Code[20])
//         {
//             // TableRelation = "Fixed Asset" where("Attaché Materiel" = const(false));
//         }
//     }

//     keys
//     {
//         key(STG_Key1; "N° Materiel", "N° Immobilisation")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }
// }

