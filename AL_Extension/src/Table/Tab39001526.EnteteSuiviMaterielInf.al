// Table 39001526 "Entete Suivi Materiel Inf"
// {
//     //GL2024  ID dans Nav 2009 : "39001526"
//     DrillDownPageID = "Liste Suivi Mat Inf";
//     LookupPageID = "Liste Suivi Mat Inf";

//     fields
//     {
//         field(1; Matricule; Integer)
//         {
//             AutoIncrement = false;
//         }
//         field(2; "Nom Et Prenom"; Text[100])
//         {
//         }
//         field(3; Affectation; Code[20])
//         {
//             TableRelation = "Tranche STC";
//         }
//         field(4; Qualification; Code[20])
//         {
//             TableRelation = Qualification;
//         }
//         field(5; Statut; Option)
//         {
//             OptionMembers = Actif,STC,Mission;
//         }
//         field(6; "Description Affectation"; Text[150])
//         {
//             // CalcFormula = lookup("Section".Decription where(Section = field(Affectation)));
//             // Editable = false;
//             // FieldClass = FlowField;
//         }
//         field(7; "Description Qualification"; Text[150])
//         {
//             CalcFormula = lookup(Qualification.Description where(Code = field(Qualification)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(50001; "N° Document"; Code[20])
//         {
//         }
//         field(50002; Employee; Code[10])
//         {
//             TableRelation = Employee;

//             // trigger OnValidate()
//             // begin
//             //     RecSalarier.Reset;
//             //     RecSalarier.SetRange(RecSalarier."No.", Employee);
//             //     if RecSalarier.FindFirst() then begin
//             //         "Nom Et Prenom" := RecSalarier."First Name";
//             //         Affectation := RecSalarier.Affectation;
//             //         Qualification := RecSalarier.Qualification;
//             //         if RecAffectation.Get(RecSalarier.Affectation) then "Description Affectation" := RecAffectation.Decription;
//             //         if RecQualification.Get(RecSalarier.Qualification) then "Description Qualification" := RecQualification.Description;
//             //     end;
//             // end;
//         }
//         field(50003; Date; Date)
//         {
//         }
//         field(50004; Observation; Text[250])
//         {
//         }
//         field(50005; "N° BL"; Text[100])
//         {
//         }
//         field(50006; "N° BC"; Text[100])
//         {
//         }
//         field(50007; "N° Doc Externe"; Text[100])
//         {
//         }
//         field(50008; "Type Document"; Option)
//         {
//             OptionMembers = " ","Bon Sortie","Bon Retour","Bon Transfert";
//         }
//         field(50009; Preleveur; Code[10])
//         {
//             TableRelation = Employee;

//             trigger OnValidate()
//             begin
//                 RecSalarier.Reset;
//                 RecSalarier.SetRange(RecSalarier."No.", Preleveur);
//                 if RecSalarier.FindFirst() then "Nom Preleveur" := RecSalarier."First Name";
//             end;
//         }
//         field(50010; "Nom Preleveur"; Text[100])
//         {
//         }
//         field(50011; Affaire; Code[20])
//         {
//             TableRelation = Job;
//         }
//         field(50012; Valider; Boolean)
//         {
//         }
//         field(50013; "Statut Bon De Sortie"; Option)
//         {
//             OptionMembers = "En Attente de Signature","Signé";
//         }
//     }

//     keys
//     {
//         key(Key1; "N° Document")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnDelete()
//     begin
//         LigneSuiviMatInf.SetRange(Matricule, Matricule);
//         if LigneSuiviMatInf.FindFirst then Error(Text001);
//     end;

//     var
//         LigneSuiviMatInf: Record "Ligne Suivi Mat Inf";
//         Text001: label 'Suppression Impossible Car Des Lignes Sont Affectées a Cette Puce';
//         RecSalarier: Record Employee;
//         RecQualification: Record Qualification;
//         RecAffectation: Record "Tranche STC";
// }

