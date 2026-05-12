// Table 39001538 "Ligne Pointage Employé"
// {
//     //GL2024  ID dans Nav 2009 : "39001538"
//     fields
//     {
//         field(1; "N°"; Code[20])
//         {
//         }
//         field(3; "Employé"; Code[20])
//         {
//             TableRelation = Employee;

//             // trigger OnValidate()
//             // begin
//             //     "Salaire Brut" := 0;
//             //     "Salaire de Base" := 0;
//             //     RecEmployee.Reset();
//             //     RecEmployee.SetRange("No.", Employé);
//             //     if RecEmployee.FindFirst then begin
//             //         "Nom et Prenom" := RecEmployee."First Name";
//             //         Affectation := RecEmployee.Affectation;
//             //         Qualification := RecEmployee.Qualification;
//             //         Categorie := RecEmployee.Collège;
//             //         RecEmployee.CalcFields("Indemnité imposable");
//             //         RecEmployee.CalcFields("Total Indemnité Par Defaut");
//             //         if RecEmployee."Salaire De Base Horaire" = 0 then
//             //             "Salaire Brut" := RecEmployee."Total Indemnité Par Defaut" + RecEmployee."Basis salary"
//             //         else
//             //             "Salaire Brut" := RecEmployee."Total Indemnité Par Defaut" + RecEmployee."Salaire De Base Horaire";
//             //         "Salaire de Base" := RecEmployee."Basis salary";

//             //         RecPointageEmployé.Reset();
//             //         RecPointageEmployé.SetRange("N°", "N°");
//             //         if RecPointageEmployé.FindFirst then begin
//             //             Journée := RecPointageEmployé.Journée;
//             //             Chantier := RecPointageEmployé.Chantier;
//             //         end;

//             //     end;
//             // end;
//         }
//         field(4; "Journée"; Date)
//         {
//         }
//         field(5; Chantier; Code[20])
//         {
//             TableRelation = Job;
//         }
//         field(6; "Nom et Prenom"; Text[100])
//         {
//         }
//         field(7; Affectation; Code[20])
//         {
//         }
//         field(8; Qualification; Code[20])
//         {
//         }
//         field(9; Categorie; Code[10])
//         {
//         }
//         field(10; "Salaire Brut"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(11; "Salaire de Base"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(12; Present; Integer)
//         {
//         }
//         field(13; "Heure Debut Service"; Time)
//         {
//         }
//         field(14; "Heure Fin Service"; Time)
//         {
//         }
//         field(15; Observation; Text[250])
//         {
//         }
//         field(16; "Nbre Heure"; Decimal)
//         {
//         }
//     }

//     keys
//     {
//         key(STG_Key1; "N°", "Employé")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         RecEmployee: Record Employee;
//         "RecPointageEmployé": Record "Pointage Employé";
// }

