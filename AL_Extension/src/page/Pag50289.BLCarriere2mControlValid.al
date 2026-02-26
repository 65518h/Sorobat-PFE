// Page 50289 "BL Carriere 2ém Control Validé"
// {
//     DelayedInsert = true;
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = "BL Carriere";
//     SourceTableView = sorting(Date, Chantier, "Code Produit")
//                       where("N° Societe" = filter(1 | 2),
//                             Integré = const(true),
//                             Chantier = const('66'),
//                             "Deuxiéme Controle" = const(true));
//     ApplicationArea = all;
//     Caption = 'BL Carriere 2ém Control Validé';
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1120011)
//             {
//                 ShowCaption = false;
//                 field("Deuxiéme Controle"; REC."Deuxiéme Controle")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Deuxiéme Controle Validé';
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("N° Societe"; REC."N° Societe")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("User Deux Controle"; REC."User Deux Controle")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Date Deux Controle"; REC."Date Deux Controle")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("N° Sequence"; REC."N° Sequence")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'N° BL';
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field(Date; REC.Date)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Integerer BL Beton"; REC."Integerer BL Beton")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field(Chantier; REC.Chantier)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Chantier Nav"; REC."Chantier Nav")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Code Produit"; REC."Code Produit")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Produit Nav"; REC."Produit Nav")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Description Produit Nav"; REC."Description Produit Nav")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Quantité"; REC.Quantité)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Code Commande Vente"; REC."Code Commande Vente")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field(Camion; REC.Camion)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Camion Nav"; REC."Camion Nav")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Chauffeur; REC.Chauffeur)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Sous Affectation Marche"; REC."Sous Affectation Marche")
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                     Visible = false;
//                 }
//                 field("Affectation Marche"; REC."Affectation Marche")
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                     Visible = false;
//                 }
//                 field(Provenance; REC.Provenance)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Destination; REC.Destination)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Distance Parcourus"; REC."Distance Parcourus")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Volume; REC.Volume)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Durée Theorique (Minute)"; REC."Durée Theorique (Minute)")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Heure; REC.Heure)
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

//     trigger OnAfterGetRecord()
//     begin
//         REC.CalcFields("Chantier Nav", "Camion Nav", "Produit Nav");
//     end;

//     trigger OnOpenPage()
//     begin
//         if UserSetup.Get(UpperCase(UserId)) then
//             if UserSetup."Affaire Par Defaut" <> '' then begin
//                 ChantierCarriere.SetRange(Correspondance, UserSetup."Affaire Par Defaut");
//                 if ChantierCarriere.FindFirst then
//                     REC.SetRange(Chantier, ChantierCarriere.Chantier);
//             end;
//     end;

//     var
//         Text001: label '#1 lines selected.\Are you sure to want to validate the selected lines ?';
//         Job: Record Job;
//         BlCarriere: Record "BL Carriere";
//         UserSetup: Record "User Setup";
//         ChantierCarriere: Record "Chantier Carriere";
//         ItemJournalLine: Record "Item Journal Line";
//         ItemJrlLine2: Record "Item Journal Line";
//         PurchaseLine: Record "Purchase Line";
//         Ligne: Integer;
//         EnteteRendemenVehEnr: Record "Entete rendement Vehicule Enr";
//         LigneRendVehiculeEnr: Record "Ligne Rendement Vehicule Enr";
//         LigneRendVehiculeEnr2: Record "Ligne Rendement Vehicule Enr";
//         Compteur: Integer;
//         Text002: label 'Traitement Achevé Avec Succé';
// }

