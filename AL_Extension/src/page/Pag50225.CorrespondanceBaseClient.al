// Page 50225 "Correspondance Base Client"
// {
//     PageType = List;
//     SourceTable = "Client Carriere";
//     //HS Modif SourceTableView WHERE("N° Societe"=FILTER('BZ4')); SourceTableView  (modif lors d'importation nouvelle Fob bl carriere demander par mehdi).
//     SourceTableView = WHERE("N° Societe" = FILTER('C'));
//     ApplicationArea = all;
//     Caption = 'Correspondance Base Client';
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Code Client"; REC."Code Client")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Designation Client"; REC."Designation Client")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Correspondance; REC.Correspondance)
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

