// Table 39001523 "Details Commande Vente Beton"
// {
//     //GL2024  ID dans Nav 2009 : "39001523"
//     DrillDownPageID = "Ligne Rappels Caisse";
//     LookupPageID = "Ligne Rappels Caisse";

//     fields
//     {
//         field(1; "Code Commande"; Code[20])
//         {
//         }
//         field(2; "Nom Et Prenom"; Text[100])
//         {
//         }
//         field(3; Affectation; Code[20])
//         {
//             //  TableRelation = Section;
//         }
//         field(4; Qualification; Code[20])
//         {
//             TableRelation = Qualification;
//         }
//         field(5; Statut; Option)
//         {
//             OptionMembers = Actif,STC,Mission;
//         }
//         field(6; "Description Affectation"; Text[30])
//         {
//             // CalcFormula = lookup(Section.Decription where(Section = field(Affectation)));
//             // Editable = false;
//             // FieldClass = FlowField;
//         }
//         field(7; "Description Qualification"; Text[30])
//         {
//             CalcFormula = lookup(Qualification.Description where(Code = field(Qualification)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(50001; "1er Gachet"; Time)
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50002; Chauffeur; Text[30])
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50003; "Matricule Véhicule"; Code[20])
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50004; Destination; Text[30])
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50005; "Pompage Béton"; Boolean)
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50006; "Matricule Pompe"; Code[20])
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50007; "Arrivé Chantier"; Time)
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50008; "Debut de Déchargement"; Time)
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50009; "Fin de Déchargement"; Time)
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50010; "Arrivé Centrale"; Time)
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50011; "Bon de Livraison"; Text[30])
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50012; Volume; Decimal)
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50013; "Réference Commande"; Text[30])
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50014; "Réference ordre de Livraison"; Text[30])
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50015; "Classe D'exposition"; Text[30])
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50016; "Classe de Chlorure"; Text[30])
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50017; "Classe de Résistance"; Text[30])
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50018; "Type et Classe du Ciment"; Text[30])
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50019; "Type additions"; Text[30])
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50020; "Classe de Consistance"; Text[30])
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50021; "D (max)"; Text[30])
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50022; "Type Adjuvant"; Text[30])
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//         field(50023; "Produit Spécial"; Text[250])
//         {
//             Description = 'MH SORO 03-06-2021';
//         }
//     }

//     keys
//     {
//         key(Key1; "Code Commande")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         Text001: label 'Suppression Impossible Car Des Lignes Sont Affectées a Cette Puce';
// }

