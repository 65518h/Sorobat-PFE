// table 39001542 "Document Maintenance"
// {    //GL2024  ID dans Nav 2009 : "39001542"

//     //GL2024   LookupPageID = 39001589;

//     fields
//     {
//         field(1; "N° Document"; Code[20])
//         {
//         }
//         field(2; Semaine; Code[20])
//         {
//             TableRelation = "Semaine de Année".Semaine;

//             trigger OnValidate()
//             begin
//                 RecSemaineAnnée.RESET();
//                 RecSemaineAnnée.SETRANGE(Semaine, Semaine);
//                 IF RecSemaineAnnée.FINDFIRST() THEN BEGIN
//                     Année := RecSemaineAnnée.Année;
//                     "Date Début" := RecSemaineAnnée."Date Début";
//                     "Date Fin" := RecSemaineAnnée."Date Fin";

//                 END;
//             end;
//         }
//         field(3; "Année"; Integer)
//         {
//         }
//         field(4; "Date Début"; Date)
//         {
//         }
//         field(5; "Date Fin"; Date)
//         {
//         }
//         field(6; Utilisateur; Text[100])
//         {
//         }
//         field(7; "Date Saisie"; Date)
//         {
//         }
//         field(8; Chantier; Code[20])
//         {
//             TableRelation = Job."No.";

//             trigger OnValidate()
//             begin
//                 RecJob.RESET();
//                 IF RecJob.GET(Chantier) THEN "Description Chantier" := RecJob.Description;
//             end;
//         }
//         field(9; "Description Chantier"; Text[150])
//         {
//         }
//     }

//     keys
//     {
//         key(STG_Key1; "N° Document")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         "RecSemaineAnnée": Record "Semaine de Année";
//         //GL2024  RecJob: Record 8004160;
//         RecJob: Record Job;
// }

