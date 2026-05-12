// Page 50220 "BL Carriere Valider"
// {
//     DelayedInsert = true;
//     DeleteAllowed = false;
//     Editable = false;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = "BL Carriere";
//     SourceTableView = sorting(Chantier, Camion, Date, "N° Sequence")
//                       where("Deuxiéme Controle" = const(true), "N° Societe" = filter(1 | 2));
//     ApplicationArea = all;
//     Caption = 'BL Carriere Valider';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1120011)
//             {
//                 ShowCaption = false;
//                 field("N° Sequence"; REC."N° Sequence")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Date; REC.Date)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Code Produit"; REC."Code Produit")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Quantité"; REC.Quantité)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Chantier Nav"; REC."Chantier Nav")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Camion Nav"; REC."Camion Nav")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Produit Nav"; REC."Produit Nav")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Chauffeur; REC.Chauffeur)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Affectation Marche"; REC."Affectation Marche")
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }
//                 field("Sous Affectation Marche"; REC."Sous Affectation Marche")
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }
//                 field(Provenance; REC.Provenance)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Destination; REC.Destination)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Distance Parcourus"; REC."Distance Parcourus")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Volume; REC.Volume)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Durée Theorique (Minute)"; REC."Durée Theorique (Minute)")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Heure; REC.Heure)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Rapproché"; REC.Rapproché)
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         REC.TestField("Produit Nav");
//                         REC.TestField("Camion Nav");
//                         REC.TestField("Chantier Nav");
//                         REC.TestField("Camion Nav");
//                         REC.TestField("Camion Nav");
//                         REC.TestField(Provenance);
//                         REC.TestField(Destination);
//                         REC.TestField("Distance Parcourus");
//                         REC.TestField(Volume);
//                         REC.TestField("Durée Theorique (Minute)");
//                         REC.TestField(Heure);
//                     end;
//                 }
//                 field(Inexistant; REC.Inexistant)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Valider)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Valider';
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 Visible = false;

//                 trigger OnAction()
//                 begin
//                     if not Confirm(Text001) then exit;
//                     if Job.Get(REC."Chantier Nav") then Job.TestField(Job."Affectation Magasin");
//                     ItemJournalLine.LockTable;
//                     ItemJournalLine.SetRange("Journal Template Name", 'SYNCHRO');
//                     ItemJournalLine.SetRange("Journal Batch Name", 'SYNCHRO');
//                     ItemJournalLine.DeleteAll;

//                     BlCarriere.SetRange(Rapproché, true);
//                     BlCarriere.SetRange(Integré, false);
//                     BlCarriere.SetRange(Chantier, REC.Chantier);
//                     BlCarriere.SetCurrentkey(Chantier, Camion, Date, "N° Sequence");
//                     if BlCarriere.FindFirst then
//                         repeat
//                             //--ENTREE
//                             Ligne += 10000;
//                             BlCarriere.CalcFields("Produit Nav", "Chantier Nav", "Camion Nav");
//                             ItemJournalLine."Journal Template Name" := 'SYNCHRO';
//                             ItemJournalLine."Journal Batch Name" := 'SYNCHRO';
//                             ItemJournalLine."Line No." := Ligne;
//                             ItemJournalLine."Document No." := CopyStr('ENTREE BL:' + BlCarriere."N° Sequence", 1, 20);
//                             ItemJournalLine.Validate("Item No.", BlCarriere."Produit Nav");
//                             ItemJournalLine."Posting Date" := BlCarriere.Date;
//                             ItemJournalLine."Entry Type" := ItemJournalLine."entry type"::Purchase;
//                             ItemJournalLine."Document Type" := 5;
//                             ItemJournalLine."Source No." := 'FRL-2876';
//                             ItemJournalLine.Validate("Qty. per Unit of Measure", 1);
//                             ItemJournalLine.Validate("Location Code", Job."Affectation Magasin");
//                             ItemJournalLine.Validate(Quantity, BlCarriere.Quantité);
//                             ItemJournalLine."Lieu De Livraison / Provenance" := BlCarriere."Chantier Nav";
//                             ItemJournalLine."Job No." := BlCarriere."Chantier Nav";
//                             ItemJournalLine."Sous Affectation Marche" := BlCarriere."Sous Affectation Marche";
//                             ItemJournalLine."External Document No." := BlCarriere."N° Sequence";
//                             ItemJournalLine.Insert;
//                             //---Sortie
//                             Ligne += 10000;
//                             BlCarriere.CalcFields("Produit Nav", "Chantier Nav", "Camion Nav");
//                             ItemJournalLine."Journal Template Name" := 'SYNCHRO';
//                             ItemJournalLine."Journal Batch Name" := 'SYNCHRO';
//                             ItemJournalLine."Line No." := Ligne;
//                             ItemJournalLine."Source No." := 'FRL-2876';
//                             ItemJournalLine."Document No." := CopyStr('SORTIE BL:' + BlCarriere."N° Sequence", 1, 20);
//                             ItemJournalLine.Validate("Item No.", BlCarriere."Produit Nav");
//                             ItemJournalLine."Posting Date" := BlCarriere.Date;
//                             ItemJournalLine."Entry Type" := ItemJournalLine."entry type"::"Negative Adjmt.";
//                             ItemJournalLine.Validate("Qty. per Unit of Measure", 1);
//                             ItemJournalLine.Validate("Location Code", Job."Affectation Magasin");
//                             ItemJournalLine.Validate(Quantity, BlCarriere.Quantité);
//                             ItemJournalLine."Lieu De Livraison / Provenance" := BlCarriere."Chantier Nav";
//                             ItemJournalLine."Job No." := BlCarriere."Chantier Nav";
//                             ItemJournalLine."Sous Affectation Marche" := BlCarriere."Sous Affectation Marche";
//                             ItemJournalLine."External Document No." := BlCarriere."N° Sequence";
//                             ItemJournalLine.Insert;

//                             // Partie Rendement Camion
//                             EnteteRendemenVehEnr.Journee := BlCarriere.Date;
//                             EnteteRendemenVehEnr.Provenance := BlCarriere.Provenance;
//                             EnteteRendemenVehEnr.Destination := BlCarriere.Destination;
//                             EnteteRendemenVehEnr.Vehicule := BlCarriere."Camion Nav";
//                             EnteteRendemenVehEnr.Produit := BlCarriere."Produit Nav";
//                             EnteteRendemenVehEnr.Marche := BlCarriere."Chantier Nav";
//                             //EnteteRendemenVehEnr.Chauffeur:=BlCarriere.Chauffeur;
//                             EnteteRendemenVehEnr.Volume := BlCarriere.Volume;
//                             EnteteRendemenVehEnr."Distance Parcourus" := BlCarriere."Distance Parcourus";
//                             EnteteRendemenVehEnr."Durée Theorique (Minute)" := BlCarriere."Durée Theorique (Minute)";
//                             if EnteteRendemenVehEnr.Insert then;
//                             Compteur += 60000;
//                             LigneRendVehiculeEnr.Journee := BlCarriere.Date;
//                             LigneRendVehiculeEnr."Code Affaire" := BlCarriere."Chantier Nav";
//                             LigneRendVehiculeEnr.Heure := BlCarriere.Heure + Compteur;
//                             LigneRendVehiculeEnr.Provenance := BlCarriere.Provenance;
//                             LigneRendVehiculeEnr.Destination := BlCarriere.Destination;
//                             LigneRendVehiculeEnr.Vehicule := BlCarriere."Camion Nav";
//                             LigneRendVehiculeEnr.Produit := BlCarriere."Produit Nav";
//                             // LigneRendVehiculeEnr.Chauffeur   :=BlCarriere.Chauffeur;
//                             LigneRendVehiculeEnr."Distance Parcourus" := BlCarriere."Distance Parcourus";
//                             LigneRendVehiculeEnr.Volume := BlCarriere.Volume;
//                             LigneRendVehiculeEnr.Quantité := BlCarriere.Volume;
//                             LigneRendVehiculeEnr."Durée Theorique (Minute)" := BlCarriere."Durée Theorique (Minute)";
//                             LigneRendVehiculeEnr2.SetCurrentkey(Heure);
//                             LigneRendVehiculeEnr2.SetRange(Journee, BlCarriere.Date);
//                             LigneRendVehiculeEnr2.SetRange(Provenance, BlCarriere.Provenance);
//                             LigneRendVehiculeEnr2.SetRange(Destination, BlCarriere.Destination);
//                             LigneRendVehiculeEnr2.SetRange(Produit, BlCarriere."Produit Nav");
//                             LigneRendVehiculeEnr2.SetRange(Vehicule, BlCarriere."Camion Nav");
//                             if LigneRendVehiculeEnr2.FindLast then
//                                 LigneRendVehiculeEnr."Ecart (Minute)" := ((BlCarriere.Heure - LigneRendVehiculeEnr2.Heure) / 60000) -
//                                                                           BlCarriere."Durée Theorique (Minute)";
//                             LigneRendVehiculeEnr.Insert;
//                             BlCarriere.Integré := true;
//                             BlCarriere.Modify;
//                         until BlCarriere.Next = 0;
//                     ItemJrlLine2.SetRange("Journal Template Name", 'SYNCHRO');
//                     ItemJrlLine2.SetRange("Journal Batch Name", 'SYNCHRO');
//                     if ItemJrlLine2.FindFirst then begin
//                         ItemJournalLine.SetRange("Journal Template Name", 'SYNCHRO');
//                         ItemJournalLine.SetRange("Journal Batch Name", 'SYNCHRO');
//                         Codeunit.Run(Codeunit::"Item Jnl.-Post 2", ItemJournalLine);
//                     end;
//                     Message(Text002);
//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         REC.CalcFields("Chantier Nav", "Camion Nav", "Produit Nav");
//     end;

//     trigger OnOpenPage()
//     begin
//         Compteur2 := 0;
//         if UserSetup.Get(UpperCase(UserId)) then
//             if UserSetup."Affaire Par Defaut" <> '' then begin
//                 ChantierCarriere.SetRange(Correspondance, UserSetup."Affaire Par Defaut");

//                 if ChantierCarriere.FindFirst then
//                     repeat
//                         Compteur2 += 1;
//                         if Compteur2 = 1 then
//                             Filtre := ChantierCarriere.Chantier
//                         else
//                             Filtre += '|' + ChantierCarriere.Chantier
//                     until ChantierCarriere.Next = 0;
//                 REC.SetFilter(Chantier, Filtre);
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
//         Filtre: Text[100];
//         Compteur2: Integer;
// }

