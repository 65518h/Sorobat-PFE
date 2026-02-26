// Page 50229 "Correspondance Base Chantier"
// {
//     PageType = List;
//     SourceTable = "Chantier Carriere";
//     //HS Modif SourceTableView WHERE("N° Societe"=FILTER('BZ4')); SourceTableView  (modif lors d'importation nouvelle Fob bl carriere demander par mehdi).

//     SourceTableView = sorting("N° Societe", Client, Chantier)
//                       where("N° Societe" = const('C'));
//     ApplicationArea = all;
//     Caption = 'Correspondance Base Chantier';
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("N° Societe"; REC."N° Societe")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Client; REC.Client)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Chantier; REC.Chantier)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Designation Chantier"; REC."Designation Chantier")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Correspondance; REC.Correspondance)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Correspondance Client"; REC."Correspondance Client")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
// }

