// Page 50257 "Prix Produit BL Best Beton"
// {
//     Editable = false;
//     PageType = List;
//     SourceTable = "BL Carriere";
//     SourceTableView = sorting("N° Societe", "N° Sequence", Annee, ID)
//                       where("N° Societe" = const('B'));
//     ApplicationArea = all;
//     Caption = 'Prix Produit BL Best Beton';
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
//                 }
//                 field("N° Sequence"; REC."N° Sequence")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'N° BL Best Beton';
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Annee; REC.Annee)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Date; REC.Date)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Code Produit"; REC."Code Produit")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Code Produit Best Beton';
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Description Produit"; REC."Description Produit")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Description Produit Best Beton';
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Produit Nav"; REC."Produit Nav")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Description Produit Nav"; REC."Description Produit Nav")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Quantité"; REC.Quantité)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Prix; REC.Prix)
//                 {
//                     ApplicationArea = all;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field(Chantier; REC.Chantier)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Code Chantier Client"; REC."Code Chantier Client")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Chantier Nav Best-Beton"; REC."Chantier Nav Best-Beton")
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

