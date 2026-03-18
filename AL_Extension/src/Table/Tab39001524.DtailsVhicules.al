// Table 39001524 "Détails Véhicules"
// {
//     //GL2024  ID dans Nav 2009 : "39001524"
//     LookupPageID = "Liste Détails Véhicules";

//     fields
//     {
//         field(1; "Code"; Code[20])
//         {
//         }
//         field(2; Type; Option)
//         {
//             OptionMembers = " ",concessionnaire,Contrat,Entretien,Expertise;
//         }
//         field(3; Date; Date)
//         {
//         }
//         field(4; Observation; Text[250])
//         {
//         }
//         field(5; "Code Véhicule"; Code[20])
//         {
//             TableRelation = Véhicule;

//             trigger OnValidate()
//             begin
//                 RecVéhicule.Reset;
//                 if RecVéhicule.Get("Code Véhicule") then begin
//                     "Designation Vehicule" := RecVéhicule.Désignation;
//                     Immatriculation := RecVéhicule.Immatriculation;
//                 end;
//             end;
//         }
//         field(6; "N° Ligne"; Integer)
//         {
//         }
//         field(7; Fournisseur; Code[20])
//         {
//             TableRelation = Vendor;

//             trigger OnValidate()
//             begin
//                 RecVendor.Reset;
//                 if RecVendor.Get(Fournisseur) then "Nom Fournisseur" := RecVendor.Name;
//             end;
//         }
//         field(8; "Nom Fournisseur"; Text[250])
//         {
//         }
//         field(50000; "Date debut contrat"; Date)
//         {
//         }
//         field(50001; "Date fin contrat"; Date)
//         {
//         }
//         field(50002; "Observation Contrat"; Text[250])
//         {
//         }
//         field(50003; "Date Entretien"; Date)
//         {
//         }
//         field(50004; "Index Véhicule"; Decimal)
//         {
//         }
//         field(50005; "Observation Entretien"; Text[250])
//         {
//         }
//         field(50006; "Date Demande Expertise"; Date)
//         {
//         }
//         field(50007; "Type Expertise"; Option)
//         {
//             OptionMembers = " ",Taxe,"Activation Assurance","Désactivation Assurance",Expertise;
//         }
//         field(50008; Lieu; Text[30])
//         {
//         }
//         field(50009; Responsable; Text[30])
//         {
//         }
//         field(50010; Qualification; Text[30])
//         {
//         }
//         field(50011; Matricule; Text[30])
//         {
//         }
//         field(50012; "Type et Modele"; Text[30])
//         {
//         }
//         field(50013; Marque; Text[30])
//         {
//         }
//         field(50014; "Nature de La Panne"; Text[250])
//         {
//         }
//         field(50015; "Durée Prévue de l'arret"; Text[50])
//         {
//         }
//         field(50016; "Designation Vehicule"; Text[250])
//         {
//         }
//         field(50017; Immatriculation; Text[150])
//         {
//         }
//     }

//     keys
//     {
//         key(STG_Key1; "Code")
//         {
//             Clustered = true;
//         }
//         key(STG_Key2; Date)
//         {
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         RecVendor: Record Vendor;
//         "RecVéhicule": Record "Véhicule";
// }

