// Page 50228 "Integration BL Beton Valider"
// {
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = List;
//     SourceTable = "BL Carriere";
//     //HS Modif SourceTableView WHERE("N° Societe"=FILTER('BZ4')); SourceTableView  (modif lors d'importation nouvelle Fob bl carriere demander par mehdi).
//     SourceTableView = sorting("N° Societe", "N° Sequence", Annee, ID)
//                       where("N° Societe" = filter('C'), "Integerer BL Beton" = filter(true), "Code Commande Vente" = filter(<> ' '));
//     ApplicationArea = all;
//     Caption = 'Integration BL Beton Valider';
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(Date; REC.Date)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Enabled = true;
//                 }
//                 field("N° Sequence"; REC."N° Sequence")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'BL N°';
//                     Editable = false;
//                 }
//                 field("Code Produit"; REC."Code Produit")
//                 {

//                     ApplicationArea = all;
//                     Caption = 'Produit';
//                 }

//                 field(Nature; REC.Nature)
//                 {
//                     //HS Modif Visible = false;  (modif lors d'importation nouvelle Fob bl carriere demander par mehdi).
//                     Visible = false;
//                     ApplicationArea = all;
//                 }
//                 field(Dosage; REC.Dosage)
//                 {
//                     //HS Modif Visible = false;  (modif lors d'importation nouvelle Fob bl carriere demander par mehdi).
//                     Visible = false;
//                     ApplicationArea = all;
//                 }
//                 field(Adjuvant; REC.Adjuvant)
//                 {
//                     //HS Modif Visible = false;  (modif lors d'importation nouvelle Fob bl carriere demander par mehdi).
//                     Visible = false;
//                     ApplicationArea = all;
//                 }
//                 field(Pompe; REC.Pompe)
//                 {
//                     //HS Modif Visible = false;  (modif lors d'importation nouvelle Fob bl carriere demander par mehdi).
//                     Visible = false;
//                     ApplicationArea = all;
//                 }
//                 field("Produit Nav"; REC."Produit Nav")
//                 {
//                     ApplicationArea = all;
//                 }
//                 //HS add  "Code Client" (modif lors d'importation nouvelle Fob bl carriere demander par mehdi).
//                 field("Code Client"; Rec."Code Client")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Nom Client"; REC."Nom Client")
//                 {
//                     ApplicationArea = all;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 //HS add  "Client Nav" (modif lors d'importation nouvelle Fob bl carriere demander par mehdi).

//                 field("Client Nav"; Rec."Client Nav")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 //HS add  Destination (modif lors d'importation nouvelle Fob bl carriere demander par mehdi).

//                 field(Destination; Rec.Destination)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Chantier Client"; REC."Chantier Client")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Description Produit Nav"; REC."Description Produit Nav")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Quantité"; REC.Quantité)
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 0 : 3;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 //HS add "Quantité en Tonne" (modif lors d'importation nouvelle Fob bl carriere demander par mehdi).

//                 field("Quantité en Tonne"; Rec."Quantité en Tonne")
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 0 : 3;
//                     Editable = false;
//                     Style = Attention;
//                     StyleExpr = true;
//                 }
//                 field("Commande Associer"; REC."Commande Associer")
//                 {
//                     ApplicationArea = all;

//                     trigger OnDrillDown()
//                     var
//                         LSalesHeader: Record "Sales Header";
//                     begin
//                         LSalesHeader.SetRange("No.", REC."Commande Associer");
//                         if REC.Interne then
//                             PAGE.RunModal(Page::"Sales Order II Interne", LSalesHeader)
//                         else
//                             PAGE.RunModal(Page::"Sales Order II", LSalesHeader);
//                     end;
//                 }
//                 field(Interne; REC.Interne)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         RecBLCarriere: Record "BL Carriere";
//         RecSalesReceivablesSetup: Record "Sales & Receivables Setup";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         RecSalesHeader: Record "Sales Header";
//         RecSalesLine: Record "Sales Line";
//         RecSalesHeader2: Record "Sales Header";
//         Text001: label 'Vous devez vérifier la correspondance de base client pour le client %1';
//         Text002: label 'Vous devez vérifier la correspondance de base article pour l''article %1';
//         Text003: label 'Lancer La Creation Des Commandes ?';
//         Text004: label 'Taches Achever Avec Succée';
// }

