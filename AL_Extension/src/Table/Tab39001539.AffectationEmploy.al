// Table 39001539 "Affectation Employé"
// {
//     //GL2024  ID dans Nav 2009 : "39001539"
//     LookupPageID = "Liste Affectation Employé";

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
//         field(7; Affectation; Code[20])
//         {
//             // TableRelation = Section;

//             // trigger OnValidate()
//             // begin
//             //     "Description Affectation" := '';
//             //     RecSection.Reset();
//             //     RecSection.SetRange(Section, Affectation);
//             //     if RecSection.FindFirst then "Description Affectation" := RecSection.Decription;
//             // end;
//         }
//         field(8; Annee; Integer)
//         {
//         }
//         field(9; Mois; Option)
//         {
//             OptionMembers = " ",Janvier,Fevrier,Mars,Avril,Mai,Jiun,Juillet,Aout,Septembre,Octobre,Novembre,Decembre;
//         }
//         field(10; "Description Affectation"; Text[200])
//         {
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
//     //  RecSection: Record Section;
// }

