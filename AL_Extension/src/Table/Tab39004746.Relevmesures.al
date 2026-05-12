// Table 39004746 "Relevé mesures"
// {
//     //GL2024  ID dans Nav 2009 : "39004746"
//     //GL3900   LookupPageID = "Liste releve";

//     fields
//     {
//         field(1; "N°"; Code[20])
//         {
//             Caption = 'Measure point';
//         }
//         field(2; "Date Mesure"; Date)
//         {
//         }
//         field(3; "Code Releveur"; Code[20])
//         {
//             TableRelation = Salarier;

//             trigger OnValidate()
//             begin
//                 if RecEmployee.Get("Code Releveur") then;
//                 Releveur := RecEmployee."First Name";
//             end;
//         }
//         field(4; Releveur; Text[60])
//         {
//             Editable = false;
//         }
//         field(5; Observation; Text[100])
//         {
//         }
//         field(6; "Filter Affectation"; Code[20])
//         {
//             TableRelation = Job."No.";

//             trigger OnValidate()
//             begin
//                 if RecJob.Get("Filter Affectation") then;
//                 "Désignation Affectation" := RecJob.Description;
//             end;
//         }
//         field(7; "Filter Sous Famille"; Code[20])
//         {
//             TableRelation = "Sous Catégorie Véhicule"."Code Sous-Catégorie";

//             trigger OnValidate()
//             begin
//                 RecSousCategorieEquipement.SetRange("Code Sous-Catégorie", "Filter Sous Famille");
//                 if RecSousCategorieEquipement.FindFirst then
//                     "Désignation Sous Famille" := RecSousCategorieEquipement.Description;
//             end;
//         }
//         field(8; "Désignation Affectation"; Text[50])
//         {
//             Editable = false;
//         }
//         field(9; "Désignation Sous Famille"; Text[50])
//         {
//             Editable = false;
//         }
//         field(10; Status; Option)
//         {
//             Editable = true;
//             OptionMembers = "En Cours",Valider;
//         }
//         field(11; "Date Saisie"; Date)
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

//     trigger OnInsert()
//     begin
//         if RecParametreParc.Get() then;
//         "N°" := NoSeriesMgt.GetNextNo(RecParametreParc."Code Releve Mesure", 0D, true);
//         "Date Saisie" := Today;
//     end;

//     var
//         RecParametreParc: Record "Paramétre Parc";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         RecEmployee: Record Employee;
//         RecJob: Record Job;
//         RecSousCategorieEquipement: Record "Sous Catégorie Véhicule";
// }

