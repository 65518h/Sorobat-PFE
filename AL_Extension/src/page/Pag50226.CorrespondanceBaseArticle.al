// Page 50226 "Correspondance Base Article"
// {
//     PageType = List;
//     SourceTable = "Produit Carriere";
//     //HS Modif SourceTableView WHERE("N° Societe"=FILTER('BZ4')); SourceTableView  (modif lors d'importation nouvelle Fob bl carriere demander par mehdi).
//     SourceTableView = WHERE("N° Societe" = FILTER('C'));
//     ApplicationArea = all;
//     Caption = 'Correspondance Base Article';
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Code Produit"; REC."Code Produit")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Designation Produit"; REC."Designation Produit")
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

