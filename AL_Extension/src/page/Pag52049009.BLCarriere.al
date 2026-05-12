// page 52049009 "BL Carriere"
// {
//     //GL2024  ID dans Nav 2009 : "39001537"
//     DelayedInsert = true;
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = "BL Carriere";
//     SourceTableView = sorting(Date)
//                       where(Integré = const(false), "N° Societe" = filter(1 | 2), Chantier = const('66'));
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'BL Carriere';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1120011)
//             {
//                 ShowCaption = false;
//                 field("N° Sequence"; Rec."N° Sequence")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Date; Rec.Date)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Chantier; Rec.Chantier)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Code Produit"; Rec."Code Produit")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Quantité"; Rec.Quantité)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field("Chantier Nav"; Rec."Chantier Nav")
//                 {
//                     ApplicationArea = Basic;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Camion; Rec.Camion)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Camion Nav"; Rec."Camion Nav")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Produit Nav"; Rec."Produit Nav")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Chauffeur; Rec.Chauffeur)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Affectation Marche"; Rec."Affectation Marche")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                 }
//                 field("Sous Affectation Marche"; Rec."Sous Affectation Marche")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                 }
//                 field(Provenance; Rec.Provenance)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Destination; Rec.Destination)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Distance Parcourus"; Rec."Distance Parcourus")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Volume; Rec.Volume)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Durée Theorique (Minute)"; Rec."Durée Theorique (Minute)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Heure; Rec.Heure)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Rapproché"; Rec.Rapproché)
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         Rec.TestField("Produit Nav");
//                         Rec.TestField("Camion Nav");
//                         Rec.TestField("Chantier Nav");
//                         Rec.TestField("Camion Nav");
//                         Rec.TestField("Camion Nav");
//                         Rec.TestField(Provenance);
//                         Rec.TestField(Destination);
//                         Rec.TestField("Distance Parcourus");
//                         Rec.TestField(Volume);
//                         Rec.TestField("Durée Theorique (Minute)");
//                         Rec.TestField(Heure);
//                     end;
//                 }
//                 field(Inexistant; Rec.Inexistant)
//                 {
//                     ApplicationArea = Basic;
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
//                 ApplicationArea = Basic;
//                 Caption = 'Valider';
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 Visible = false;

//                 trigger OnAction()
//                 begin
//                     if not Confirm(Text001) then exit;
//                     if UserSetup.Get(UpperCase(UserId)) then
//                         if Job.Get(Rec."Chantier Nav") then Job.TestField(Job."Affectation Magasin");
//                     ItemJournalLine.LockTable;
//                     ItemJournalLine.SetRange("Journal Template Name", 'SYNCHRO');
//                     ItemJournalLine.SetRange("Journal Batch Name", 'SYNCHRO');
//                     ItemJournalLine.DeleteAll;

//                     BlCarriere.SetRange(Rapproché, true);
//                     BlCarriere.SetRange(Integré, false);
//                     BlCarriere.SetRange(Chantier, Rec.Chantier);
//                     BlCarriere.SetRange("Code Client", Rec."Code Client");
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
//                             if not UserSetup."BL Carriere Stockable" then begin
//                                 Ligne += 10000;
//                                 BlCarriere.CalcFields("Produit Nav", "Chantier Nav", "Camion Nav");
//                                 ItemJournalLine."Journal Template Name" := 'SYNCHRO';
//                                 ItemJournalLine."Journal Batch Name" := 'SYNCHRO';
//                                 ItemJournalLine."Line No." := Ligne;
//                                 ItemJournalLine."Source No." := 'FRL-2876';
//                                 ItemJournalLine."Document No." := CopyStr('SORTIE BL:' + BlCarriere."N° Sequence", 1, 20);
//                                 ItemJournalLine.Validate("Item No.", BlCarriere."Produit Nav");
//                                 ItemJournalLine."Posting Date" := BlCarriere.Date;
//                                 ItemJournalLine."Entry Type" := ItemJournalLine."entry type"::"Negative Adjmt.";
//                                 ItemJournalLine.Validate("Qty. per Unit of Measure", 1);
//                                 ItemJournalLine.Validate("Location Code", Job."Affectation Magasin");
//                                 ItemJournalLine.Validate(Quantity, BlCarriere.Quantité);
//                                 ItemJournalLine."Lieu De Livraison / Provenance" := BlCarriere."Chantier Nav";
//                                 ItemJournalLine."Job No." := BlCarriere."Chantier Nav";
//                                 ItemJournalLine."Sous Affectation Marche" := BlCarriere."Sous Affectation Marche";
//                                 ItemJournalLine."External Document No." := BlCarriere."N° Sequence";
//                                 ItemJournalLine.Insert;

//                                 // Partie Rendement Camion
//                                 EnteteRendemenVehEnr.Journee := BlCarriere.Date;
//                                 EnteteRendemenVehEnr.Provenance := BlCarriere.Provenance;
//                                 EnteteRendemenVehEnr.Destination := BlCarriere.Destination;
//                                 EnteteRendemenVehEnr.Vehicule := BlCarriere."Camion Nav";
//                                 EnteteRendemenVehEnr.Produit := BlCarriere."Produit Nav";
//                                 EnteteRendemenVehEnr.Marche := BlCarriere."Chantier Nav";
//                                 //EnteteRendemenVehEnr.Chauffeur:=BlCarriere.Chauffeur;
//                                 EnteteRendemenVehEnr.Volume := BlCarriere.Volume;
//                                 EnteteRendemenVehEnr."Distance Parcourus" := BlCarriere."Distance Parcourus";
//                                 EnteteRendemenVehEnr."Durée Theorique (Minute)" := BlCarriere."Durée Theorique (Minute)";
//                                 if EnteteRendemenVehEnr.Insert then;
//                                 Compteur += 60000;
//                                 LigneRendVehiculeEnr.Journee := BlCarriere.Date;
//                                 LigneRendVehiculeEnr."Code Affaire" := BlCarriere."Chantier Nav";
//                                 LigneRendVehiculeEnr.Heure := BlCarriere.Heure + Compteur;
//                                 LigneRendVehiculeEnr.Provenance := BlCarriere.Provenance;
//                                 LigneRendVehiculeEnr.Destination := BlCarriere.Destination;
//                                 LigneRendVehiculeEnr.Vehicule := BlCarriere."Camion Nav";
//                                 LigneRendVehiculeEnr.Produit := BlCarriere."Produit Nav";
//                                 // LigneRendVehiculeEnr.Chauffeur   :=BlCarriere.Chauffeur;
//                                 LigneRendVehiculeEnr."Distance Parcourus" := BlCarriere."Distance Parcourus";
//                                 LigneRendVehiculeEnr.Volume := BlCarriere.Volume;
//                                 LigneRendVehiculeEnr.Quantité := BlCarriere.Volume;
//                                 LigneRendVehiculeEnr."Durée Theorique (Minute)" := BlCarriere."Durée Theorique (Minute)";
//                                 LigneRendVehiculeEnr2.SetCurrentkey(Heure);
//                                 LigneRendVehiculeEnr2.SetRange(Journee, BlCarriere.Date);
//                                 LigneRendVehiculeEnr2.SetRange(Provenance, BlCarriere.Provenance);
//                                 LigneRendVehiculeEnr2.SetRange(Destination, BlCarriere.Destination);
//                                 LigneRendVehiculeEnr2.SetRange(Produit, BlCarriere."Produit Nav");
//                                 LigneRendVehiculeEnr2.SetRange(Vehicule, BlCarriere."Camion Nav");
//                                 if LigneRendVehiculeEnr2.FindLast then
//                                     LigneRendVehiculeEnr."Ecart (Minute)" := ((BlCarriere.Heure - LigneRendVehiculeEnr2.Heure) / 60000) -
//                                                                               BlCarriere."Durée Theorique (Minute)";
//                                 LigneRendVehiculeEnr.Insert;
//                             end;
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
//         Rec.CalcFields("Chantier Nav", "Camion Nav", "Produit Nav");
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
//                         if Compteur2 = 1 then begin
//                             Filtre := ChantierCarriere.Chantier;
//                             if ChantierCarriere.Client <> '' then FiltreClient := ChantierCarriere.Client;
//                         end
//                         else begin
//                             Filtre += '|' + ChantierCarriere.Chantier;
//                             if ChantierCarriere.Client <> '' then FiltreClient += '|' + ChantierCarriere.Client;
//                         end;
//                     until ChantierCarriere.Next = 0;
//                 Rec.SetFilter(Chantier, Filtre);
//                 if FiltreClient <> '' then Rec.SetFilter("Code Client", FiltreClient);

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
//         FiltreClient: Text[100];
// }

