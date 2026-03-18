// Table 39001536 "Pointage Employé"
// {
//     LookupPageID = "Liste Pointage Employée";
//     //GL2024  ID dans Nav 2009 : "39001536"
//     fields
//     {
//         field(1; "N°"; Code[20])
//         {
//         }
//         field(2; "Journée"; Date)
//         {
//         }
//         field(3; Chantier; Code[20])
//         {
//             TableRelation = Job;
//         }
//         field(4; Utilisateur; Code[20])
//         {
//         }
//         field(5; "Validé"; Boolean)
//         {
//         }
//         field(6; "Nbre Effectif"; Integer)
//         {
//             CalcFormula = count("Ligne Pointage Employé" where("N°" = field("N°"),
//                                                                 Present = filter(> 0)));
//             FieldClass = FlowField;
//         }
//     }

//     keys
//     {
//         key(STG_Key1; "N°")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         NoSeriesMgt: Codeunit NoSeriesManagement;
// }

