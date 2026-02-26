// Table 39001527 "Ligne Suivi Mat Inf"
// {
//     //GL2024  ID dans Nav 2009 : "39001527"

//     fields
//     {
//         field(1; Matricule; Integer)
//         {
//         }
//         field(2; "Nature Materiel"; Option)
//         {
//             OptionMembers = PC,LapTop,Imprimante,Fax,Onduleur,Scanner,Photocopieuse,Disque,Autres;
//         }
//         field(3; "N° Serie"; Code[20])
//         {
//         }
//         field(4; Description; Text[250])
//         {
//         }
//         field(8; Statut; Option)
//         {
//             OptionMembers = "Fonctionnel Nouveau","Fonctionnel Ancien",Panne,Disponible,Transferer,"Hors Service";
//         }
//         field(9; Marque; Text[100])
//         {
//         }
//         field(50000; "Date Operation"; Date)
//         {
//         }
//         field(50001; "Transferer A"; Text[50])
//         {
//         }
//         field(50002; "N° Document"; Code[20])
//         {
//         }
//         field(50003; Valider; Boolean)
//         {
//         }
//         field(50004; Utilisateur; Text[100])
//         {
//             CalcFormula = lookup("Entete Suivi Materiel Inf"."Nom Et Prenom" where("N° Document" = field("N° Document")));
//             FieldClass = FlowField;
//         }
//         field(50005; "Type Document"; Option)
//         {
//             CalcFormula = lookup("Entete Suivi Materiel Inf"."Type Document" where("N° Document" = field("N° Document")));
//             FieldClass = FlowField;
//             OptionMembers = " ","Bon Sortie","Bon Retour","Bon Transfert";
//         }
//         field(50006; "Date Document"; Date)
//         {
//             CalcFormula = lookup("Entete Suivi Materiel Inf".Date where("N° Document" = field("N° Document")));
//             FieldClass = FlowField;
//         }
//     }

//     keys
//     {
//         key(Key1; "N° Document", Marque, "N° Serie")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         HistoriquePuce: Record "Temp G/L Entry";
//         Text001: label 'Suppression Impossible Des Lignes Mouvements Sont Affectées';
// }

