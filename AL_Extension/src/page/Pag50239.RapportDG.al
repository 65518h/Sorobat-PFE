// page 50239 "Rapport DG"
// {
//     PageType = Card;
//     SourceTable = "Entete rapport DG";
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     Caption = 'Rapport DG';
//     layout
//     {
//         area(content)
//         {
//             group("Rapport DG")
//             {
//                 Caption = 'Rapport DG';
//                 field("N° Rapport"; rec."N° Rapport")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Rapport"; rec."Date Rapport")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Marché; rec.Marché)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Prix Gasoil"; rec."Prix Gasoil")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Rabais; rec.Rabais)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Remise Location Materiel"; rec."Remise Location Materiel")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Cloturé; rec.Cloturé)
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         IF NOT CONFIRM(Text003) THEN EXIT;
//                     end;
//                 }
//                 field(Description; rec.Description)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Centrale; rec.Centrale)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Correspandance Marché"; rec."Correspandance Marché")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Code Centrale Materiel"; rec."Code Centrale Materiel")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Cout Location Terrain"; rec."Cout Location Terrain")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             part("Detail rapport DG"; "Detail rapport DG")
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "N° Rapport" = FIELD("N° Rapport");
//             }
//             group("Nouvelle Entrée")
//             {
//                 Caption = 'Nouvelle Entrée';
//                 part("Regroupement Rapport DG"; "Regroupement Rapport DG")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = Chantier = FIELD(Marché);
//                     SubPageView = WHERE(Type = FILTER("Nouvelle Entrée"));
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("Update Materiaux")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Update Materiaux';
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 Visible = true;

//                 trigger OnAction()
//                 begin
//                     ItemLedgerEntry.SETRANGE("Job No.", rec.Marché);
//                     REPORT.RUNMODAL(REPORT::"Update Materiaux Rapport DG", TRUE, FALSE, ItemLedgerEntry);
//                 end;
//             }
//             action(MAJ)
//             {
//                 ApplicationArea = all;
//                 Caption = 'MAJ';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 var
//                     Wind: Dialog;
//                 begin
//                     IF NOT CONFIRM(Text001) THEN EXIT;
//                     RecDetailRapportDG.RESET;
//                     RecDetailRapportDG.SETRANGE("N° Rapport", rec."N° Rapport");
//                     RecDetailRapportDG.SETRANGE("Charge Fixe", FALSE);
//                     RecDetailRapportDG.DELETEALL;
//                     Wind.OPEN('Traitement En Cours :  #1############### \');
//                     IF rec.Centrale = TRUE THEN BEGIN
//                         Annee := DATE2DMY(rec."Date Rapport", 3);
//                         Mois := DATE2DMY(rec."Date Rapport", 2);
//                         DateDebut := DMY2DATE(1, Mois, Annee);
//                         DateFin := CALCDATE('FM', DateDebut);
//                         MateriauxCentrale(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         GasoilCentrale(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         MSRLCentrale(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         MaterielCentral(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         DecompteCentrale(rec."N° Rapport", rec.Marché, rec."Date Rapport", rec."Correspandance Marché");
//                         DiversCentrale(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         RatioMatriaux(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         Bilanmateriaux(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         Bilan(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         Archiver;

//                     END
//                     ELSE BEGIN
//                         // MateriauxDivers("N° Rapport",Marché,"Date Rapport");
//                         Wind.UPDATE(1, 'Traitement Rendement');
//                         Rendement(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         Wind.UPDATE(1, 'Traitement Materiaux');
//                         Materiaux(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         MateriauxDivers(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         Wind.UPDATE(1, 'Traitement Gasoil');
//                         Gasoil(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         Wind.UPDATE(1, 'Traitement Masse Salariale');
//                         MSRL(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         Wind.UPDATE(1, 'Traitement Materiel');
//                         Materiel(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         Wind.UPDATE(1, 'Traitement Fraix Annexe');
//                         FraixAnnexe(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         Wind.UPDATE(1, 'Traitement Loyer');
//                         Loyer(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         Wind.UPDATE(1, 'Traitement Decompte');
//                         Decompte(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         Wind.UPDATE(1, 'Traitement Divers');
//                         Divers(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         Wind.UPDATE(1, 'Traitement Ratios');
//                         RatioMatriaux(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         Wind.UPDATE(1, 'Traitement Reste a factuer');
//                         DiffSansRegroupement(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         DiffAveRegroupement(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         Wind.UPDATE(1, 'Traitement Bilan');
//                         Bilanmateriaux(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         Bilan(rec."N° Rapport", rec.Marché, rec."Date Rapport");
//                         Wind.UPDATE(1, 'Traitement Arhivage');
//                         Archiver;
//                         Wind.CLOSE;
//                     END;

//                     MESSAGE(Text002);
//                 end;
//             }
//             action(Archiver2)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Archiver';
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 Visible = false;

//                 trigger OnAction()
//                 begin
//                     DetailRapportDGArchive.SETRANGE("N° Rapport", rec."N° Rapport");
//                     DetailRapportDGArchive.SETRANGE("Date Rapport", rec."Date Rapport");
//                     DetailRapportDGArchive.DELETEALL;
//                     DetailRapportDGArchive.RESET;
//                     DetailRapportDG.SETRANGE("N° Rapport", rec."N° Rapport");
//                     DetailRapportDG.SETRANGE("Date Rapport", xRec."Date Rapport");
//                     IF DetailRapportDG.FINDFIRST THEN
//                         REPEAT
//                             DetailRapportDGArchive.TRANSFERFIELDS(DetailRapportDG);
//                             DetailRapportDGArchive.INSERT;
//                         UNTIL DetailRapportDG.NEXT = 0;
//                     MESSAGE(Text004);
//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         IF rec.Cloturé THEN
//             CurrPage.EDITABLE(FALSE) ELSE
//             CurrPage.EDITABLE(TRUE);
//     end;

//     trigger OnOpenPage()
//     begin
//         IF rec.Cloturé THEN
//             CurrPage.EDITABLE(FALSE) ELSE
//             CurrPage.EDITABLE(TRUE);
//         //if findlast then;
//     end;

//     var
//         Text001: Label 'Lancer Mise à Jour ?';
//         Text002: Label 'Mise à Jour Terminée';
//         Text003: Label 'Cloturer ?';
//         RecDetailRapportDG: Record "Detail Rapport DG";
//         DetailRapportDG: Record "Detail Rapport DG";
//         DetailRapportDGArchive: Record "Detail Rapport DG Archivé";
//         ItemLedgerEntry: Record "Item Ledger Entry";
//         Compteur: Integer;
//         CoutUnitaire: Decimal;
//         TotalCharge: Decimal;
//         Text004: Label 'Archivage Terminé';
//         ST: Decimal;
//         DateDebut: Date;
//         DateFin: Date;
//         Mois: Integer;
//         Annee: Integer;
//         Tempo: Record tempo01;
//         i2: Integer;


//     procedure Materiaux(var NumRapport: Code[20]; var "CodeMarché": Code[20]; DateRapport: Date)
//     var
//         RecItemLedgerEntry: Record "Item Ledger Entry";
//         ValueEntry: Record "Value Entry";
//         RecCorrespondanRapportDG: Record "Correspondan Rapport DG";
//         RegroupementRapportDG: Record "Regroupement Rapport DG";
//         SalesHeader: Record "Sales Header";
//         SalesLine: Record "Sales Line";
//         "SumQuantitéMarché": Decimal;
//         "QuantitéMarché": Decimal;
//         "QuantitéExécuté": Decimal;
//         "SumQuantitéExécuté": Decimal;
//         "SumQuantitéMateriaux": Decimal;
//         "SumMontantMarché": Decimal;
//         Item: Record Item;
//         "Quantité": Decimal;
//         Cout: Decimal;
//         Difference: Decimal;
//         tmp01: Record tempo01;
//     begin
//         CLEAR(RecDetailRapportDG);
//         Quantité := 0;
//         RecCorrespondanRapportDG.SETRANGE(Marché, CodeMarché);
//         RecCorrespondanRapportDG.SETRANGE(Type, RecCorrespondanRapportDG.Type::Depense);
//         //RecCorrespondanRapportDG.SETFILTER("Correspandance Article",'%1','PC-11-09-0004|PC-11-09-0008|PC-11-09-0007');
//         IF RecCorrespondanRapportDG.FINDFIRST THEN
//             REPEAT

//                 IF RecCorrespondanRapportDG."Correspandance Article" <> '' THEN BEGIN
//                     Compteur += 1000;
//                     SumQuantitéMateriaux := 0;
//                     Cout := 0;
//                     RecItemLedgerEntry.RESET;
//                     RecItemLedgerEntry.SETCURRENTKEY("Posting Date", Famille, "N° Véhicule", "Entry Type", "Item No.");
//                     RecItemLedgerEntry.SETFILTER("Job No.", RecCorrespondanRapportDG.Marché + '*');
//                     RecItemLedgerEntry.SETFILTER("Item No.", RecCorrespondanRapportDG."Correspandance Article");
//                     RecItemLedgerEntry.SETFILTER("Posting Date", '<=%1', DateRapport);
//                     RecItemLedgerEntry.SETFILTER("Entry Type", '%1|%2', RecItemLedgerEntry."Entry Type"::Purchase,
//                                                  RecItemLedgerEntry."Entry Type"::Output);
//                     IF RecItemLedgerEntry.FINDFIRST THEN
//                         REPEAT
//                             ValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Entry Type");
//                             ValueEntry.SETRANGE("Item Ledger Entry No.", RecItemLedgerEntry."Entry No.");
//                             IF ValueEntry.FINDFIRST THEN BEGIN
//                                 Cout += RecItemLedgerEntry.Quantity * ValueEntry."Cost per Unit";
//                             END;
//                             Quantité := RecItemLedgerEntry.Quantity;
//                             IF Item.GET(RecItemLedgerEntry."Item No.") THEN BEGIN
//                                 IF (Item."Type Operation" = Item."Type Operation"::M) AND (Item.Coeficient <> 0) THEN
//                                     Quantité := Quantité * Item.Coeficient;
//                                 IF (Item."Type Operation" = Item."Type Operation"::D) AND (Item.Coeficient <> 0) THEN
//                                     Quantité := ROUND(Quantité / Item.Coeficient, 0.001);

//                             END;

//                             SumQuantitéMateriaux += Quantité;
//                             RegroupementRapportDG.Code := RecItemLedgerEntry."Item No.";
//                             RegroupementRapportDG.Chantier := RecItemLedgerEntry."Job No.";
//                             RegroupementRapportDG.Type := RegroupementRapportDG.Type::Materiaux;
//                             RegroupementRapportDG.Designation := Item.Description;
//                             IF NOT RegroupementRapportDG.INSERT THEN RegroupementRapportDG.MODIFY;
//                         UNTIL RecItemLedgerEntry.NEXT = 0;

//                     CLEAR(RecDetailRapportDG);
//                     RecDetailRapportDG."N° Rapport" := NumRapport;
//                     RecDetailRapportDG.Marché := CodeMarché;
//                     RecDetailRapportDG."Date Rapport" := DateRapport;
//                     RecDetailRapportDG.Designatiion := UPPERCASE(RecCorrespondanRapportDG.Désignation);
//                     RecDetailRapportDG.Niveau := RecCorrespondanRapportDG.Niveau;
//                     RecDetailRapportDG."Regroupement Bilan" := RecCorrespondanRapportDG."Regroupement Bilan";
//                     RecDetailRapportDG."N° Ligne" := Compteur;
//                     RecDetailRapportDG.Montant := Cout;
//                     RecDetailRapportDG."Quantité Livré" := SumQuantitéMateriaux;
//                     RecDetailRapportDG."Quantité Origine" := SumQuantitéMateriaux;
//                     IF RecCorrespondanRapportDG."Type Operation" = 1 THEN // Division
//                       BEGIN
//                         RecDetailRapportDG."Quantité Livré" := SumQuantitéMateriaux / RecCorrespondanRapportDG.Coeficion;
//                     END
//                     ELSE
//                         IF RecCorrespondanRapportDG."Type Operation" = 2 THEN    // Multiplication
//                      BEGIN
//                             RecDetailRapportDG."Quantité Livré" := SumQuantitéMateriaux * RecCorrespondanRapportDG.Coeficion;
//                         END;

//                     RecDetailRapportDG."Coeficent Colisage T/M3" := RecCorrespondanRapportDG.Coeficion;
//                     // Decompte
//                     SumQuantitéMarché := 0;
//                     SumMontantMarché := 0;
//                     SumQuantitéExécuté := 0;
//                     SalesHeader.SETRANGE("Commande Affaire", TRUE);
//                     SalesHeader.SETFILTER("Job No.", CodeMarché + '*');
//                     IF SalesHeader.FINDFIRST THEN
//                         //BEGIN
//                         REPEAT
//                             CoutUnitaire := 0;
//                             SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
//                             SalesLine.SETRANGE("Document No.", SalesHeader."No.");
//                             IF RecCorrespondanRapportDG."Correspandance Decompte" <> '' THEN
//                                 SalesLine.SETFILTER("No.", RecCorrespondanRapportDG."Correspandance Decompte")
//                             ELSE
//                                 SalesLine.SETFILTER("No.", 'XXXX');
//                             IF SalesLine.FINDFIRST THEN
//                                 REPEAT
//                                     IF SalesHeader."Prices Including VAT" THEN
//                                         SalesLine."Unit Price" := ROUND(SalesLine."Unit Price" / (1 + SalesLine."VAT %" / 100), 0.001);
//                                     QuantitéMarché := SalesLine.Quantity;
//                                     IF (SalesLine."Type Operation" = SalesLine."Type Operation"::M) AND (SalesLine."Coeficient Rapport" <> 0) THEN
//                                         QuantitéMarché := SalesLine.Quantity * SalesLine."Coeficient Rapport";
//                                     IF (SalesLine."Type Operation" = SalesLine."Type Operation"::D) AND (SalesLine."Coeficient Rapport" <> 0) THEN
//                                         QuantitéMarché := ROUND(SalesLine.Quantity / SalesLine."Coeficient Rapport", 0.001);
//                                     QuantitéExécuté := GetQteExeuté(SalesHeader."No.", SalesLine."No.", DateRapport);
//                                     //SalesLine."Quantity Shipped";
//                                     IF (SalesLine."Type Operation" = SalesLine."Type Operation"::M) AND (SalesLine."Coeficient Rapport" <> 0) THEN
//                                         QuantitéExécuté := SalesLine."Quantity Shipped" * SalesLine."Coeficient Rapport";
//                                     IF (SalesLine."Type Operation" = SalesLine."Type Operation"::D) AND (SalesLine."Coeficient Rapport" <> 0) THEN
//                                         QuantitéExécuté := ROUND(SalesLine."Quantity Shipped" / SalesLine."Coeficient Rapport", 0.001);

//                                     SumQuantitéMarché += QuantitéMarché;
//                                     SumQuantitéExécuté += QuantitéExécuté;
//                                     SumMontantMarché += SalesLine.Amount;
//                                     IF SalesLine."Coeficient Rapport" = 0 THEN
//                                         CoutUnitaire := SalesLine."Unit Price"
//                                     ELSE BEGIN
//                                         IF CoutUnitaire = 0 THEN CoutUnitaire := SalesLine."Unit Price" / SalesLine."Coeficient Rapport";
//                                     END;
//                                 UNTIL SalesLine.NEXT = 0;
//                             RecDetailRapportDG."Quantité Marché" := SumQuantitéMarché;
//                             RecDetailRapportDG."Quantité Exécuté" := SumQuantitéExécuté;
//                             IF (SumQuantitéMarché <> 0) AND (CoutUnitaire <> 0) THEN
//                                 RecDetailRapportDG."Prix Unitaire Moy  Marché" := CoutUnitaire;    // Calculer le moyen prix unitaire
//                         UNTIL SalesHeader.NEXT = 0;
//                     // END;
//                     // Decompte
//                     //  IF RecCorrespondanRapportDG."Prix Marché"<>0 THEN   RecDetailRapportDG."Prix Unitaire Moy  Marché":=
//                     RecDetailRapportDG."Regroupement Foison." := RecCorrespondanRapportDG."Regroupement Difference";
//                     RecDetailRapportDG."Type Diff" := RecCorrespondanRapportDG."Type Diff";
//                     RecDetailRapportDG."Non Inclu Reste à facturer" := RecCorrespondanRapportDG."Non Inclu Reste à facturer";
//                     RecDetailRapportDG."Taux Foisonnement" := RecCorrespondanRapportDG."Taux Foisonnement";
//                     RecDetailRapportDG."Montant Marché" := SumMontantMarché;
//                     IF RecDetailRapportDG.INSERT THEN;

//                 END;
//             UNTIL RecCorrespondanRapportDG.NEXT = 0;
//     end;


//     procedure Rendement(var NumRapport: Code[20]; var "CodeMarché": Code[20]; DateRapport: Date)
//     var
//         LigneRendementVehiculeEnr: Record "Ligne Rendement Vehicule Enr";
//         RecCorrespondanRapportDG: Record "Correspondan Rapport DG";
//         SalesHeader: Record "Sales Header";
//         SalesLine: Record "Sales Line";
//         "SumQuantitéMarché": Decimal;
//         "QuantitéMarché": Decimal;
//         "QuantitéExécuté": Decimal;
//         "SumQuantitéExécuté": Decimal;
//         "SumQuantitéMateriaux": Decimal;
//         "SumMontantMarché": Decimal;
//         RecDetailRapportDG: Record "Detail Rapport DG";
//         Item: Record Item;
//         "Quantité": Decimal;
//     begin
//         CLEAR(RecDetailRapportDG);
//         Quantité := 0;
//         RecCorrespondanRapportDG.SETRANGE(Marché, CodeMarché);
//         RecCorrespondanRapportDG.SETRANGE(Type, RecCorrespondanRapportDG.Type::Rendement);
//         //RecCorrespondanRapportDG.SETRANGE("Correspandance Article",'PC-11-07-0011');
//         IF RecCorrespondanRapportDG.FINDFIRST THEN
//             REPEAT

//                 IF RecCorrespondanRapportDG."Correspandance Article" <> '' THEN BEGIN
//                     Compteur += 1000;
//                     SumQuantitéMateriaux := 0;

//                     LigneRendementVehiculeEnr.RESET;
//                     LigneRendementVehiculeEnr.SETCURRENTKEY("Code Affaire", Journee, Produit);
//                     LigneRendementVehiculeEnr.SETFILTER("Code Affaire", RecCorrespondanRapportDG.Marché + '*');
//                     LigneRendementVehiculeEnr.SETFILTER(Produit, RecCorrespondanRapportDG."Correspandance Article");
//                     LigneRendementVehiculeEnr.SETFILTER(Journee, '<=%1', DateRapport);
//                     IF LigneRendementVehiculeEnr.FINDFIRST THEN
//                         REPEAT

//                             Quantité := LigneRendementVehiculeEnr.Volume;
//                             IF Item.GET(LigneRendementVehiculeEnr.Produit) THEN BEGIN
//                                 IF (Item."Type Operation" = Item."Type Operation"::M) AND (Item.Coeficient <> 0) THEN
//                                     Quantité := Quantité * Item.Coeficient;
//                                 IF (Item."Type Operation" = Item."Type Operation"::D) AND (Item.Coeficient <> 0) THEN
//                                     Quantité := ROUND(Quantité / Item.Coeficient, 0.001);

//                             END;

//                             SumQuantitéMateriaux += Quantité;
//                         UNTIL LigneRendementVehiculeEnr.NEXT = 0;
//                     CLEAR(RecDetailRapportDG);
//                     RecDetailRapportDG."N° Rapport" := NumRapport;
//                     RecDetailRapportDG.Marché := CodeMarché;
//                     RecDetailRapportDG."Date Rapport" := DateRapport;
//                     RecDetailRapportDG.Designatiion := UPPERCASE(RecCorrespondanRapportDG.Désignation);
//                     RecDetailRapportDG.Niveau := RecCorrespondanRapportDG.Niveau;
//                     RecDetailRapportDG."Regroupement Bilan" := RecCorrespondanRapportDG."Regroupement Bilan";
//                     RecDetailRapportDG."N° Ligne" := Compteur;
//                     RecDetailRapportDG."Quantité Livré" := SumQuantitéMateriaux;
//                     IF RecCorrespondanRapportDG."Type Operation" = 1 THEN // Division
//                       BEGIN
//                         RecDetailRapportDG."Quantité Livré" := SumQuantitéMateriaux / RecCorrespondanRapportDG.Coeficion;
//                     END
//                     ELSE
//                         IF RecCorrespondanRapportDG."Type Operation" = 2 THEN    // Multiplication
//                      BEGIN
//                             RecDetailRapportDG."Quantité Livré" := SumQuantitéMateriaux * RecCorrespondanRapportDG.Coeficion;
//                         END;
//                     // Decompte
//                     SumQuantitéMarché := 0;
//                     SumMontantMarché := 0;
//                     SumQuantitéExécuté := 0;
//                     SalesHeader.SETRANGE("Commande Affaire", TRUE);
//                     SalesHeader.SETFILTER("Job No.", CodeMarché + '*');
//                     IF SalesHeader.FINDFIRST THEN
//                         //BEGIN
//                         REPEAT
//                             CoutUnitaire := 0;
//                             SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
//                             SalesLine.SETRANGE("Document No.", SalesHeader."No.");
//                             IF RecCorrespondanRapportDG."Correspandance Decompte" <> '' THEN
//                                 SalesLine.SETFILTER("No.", RecCorrespondanRapportDG."Correspandance Decompte")
//                             ELSE
//                                 SalesLine.SETFILTER("No.", 'XXXXX');
//                             IF SalesLine.FINDFIRST THEN
//                                 REPEAT
//                                     IF SalesHeader."Prices Including VAT" THEN
//                                         SalesLine."Unit Price" := ROUND(SalesLine."Unit Price" / (1 + SalesLine."VAT %" / 100), 0.001);
//                                     QuantitéMarché := SalesLine.Quantity;
//                                     IF (SalesLine."Type Operation" = SalesLine."Type Operation"::M) AND (SalesLine."Coeficient Rapport" <> 0) THEN
//                                         QuantitéMarché := SalesLine.Quantity * SalesLine."Coeficient Rapport";
//                                     IF (SalesLine."Type Operation" = SalesLine."Type Operation"::D) AND (SalesLine."Coeficient Rapport" <> 0) THEN
//                                         QuantitéMarché := ROUND(SalesLine.Quantity / SalesLine."Coeficient Rapport", 0.001);
//                                     QuantitéExécuté := SalesLine."Quantity Shipped";
//                                     IF (SalesLine."Type Operation" = SalesLine."Type Operation"::M) AND (SalesLine."Coeficient Rapport" <> 0) THEN
//                                         QuantitéExécuté := SalesLine."Quantity Shipped" * SalesLine."Coeficient Rapport";
//                                     IF (SalesLine."Type Operation" = SalesLine."Type Operation"::D) AND (SalesLine."Coeficient Rapport" <> 0) THEN
//                                         QuantitéExécuté := ROUND(SalesLine."Quantity Shipped" / SalesLine."Coeficient Rapport", 0.001);

//                                     SumQuantitéMarché += QuantitéMarché;
//                                     SumQuantitéExécuté += QuantitéExécuté;
//                                     SumMontantMarché += SalesLine.Amount;
//                                     IF SalesLine."Coeficient Rapport" = 0 THEN
//                                         CoutUnitaire := SalesLine."Unit Price"
//                                     ELSE BEGIN
//                                         IF CoutUnitaire = 0 THEN CoutUnitaire := SalesLine."Unit Price" / SalesLine."Coeficient Rapport";
//                                     END;

//                                 UNTIL SalesLine.NEXT = 0;
//                             RecDetailRapportDG."Quantité Marché" := SumQuantitéMarché;
//                             RecDetailRapportDG."Quantité Exécuté" := SumQuantitéExécuté;
//                             RecDetailRapportDG."Prix Unitaire Moy  Marché" := CoutUnitaire;   // Calculer le moyen prix unitaire
//                                                                                               //END;
//                         UNTIL SalesHeader.NEXT = 0;
//                     // Decompte

//                     RecDetailRapportDG."Regroupement Foison." := RecCorrespondanRapportDG."Regroupement Difference";
//                     RecDetailRapportDG."Type Diff" := RecCorrespondanRapportDG."Type Diff";
//                     RecDetailRapportDG."Taux Foisonnement" := RecCorrespondanRapportDG."Taux Foisonnement";
//                     RecDetailRapportDG."Non Inclu Reste à facturer" := RecCorrespondanRapportDG."Non Inclu Reste à facturer";
//                     RecDetailRapportDG."Montant Marché" := SumMontantMarché;
//                     IF RecDetailRapportDG.INSERT THEN;

//                 END;
//             UNTIL RecCorrespondanRapportDG.NEXT = 0;
//     end;


//     procedure Gasoil(var NumRapport: Code[20]; var "CodeMarché": Code[20]; DateRapport: Date)
//     var
//         LigneFicheGasoil: Record "Ligne Fiche Gasoil";
//         "SumQuantitéGasoil": Decimal;
//     begin
//         CLEAR(RecDetailRapportDG);
//         Compteur += 1000;
//         SumQuantitéGasoil := 0;
//         LigneFicheGasoil.RESET;
//         LigneFicheGasoil.SETCURRENTKEY(Journee);
//         LigneFicheGasoil.SETFILTER(Affaire, CodeMarché + '*');
//         LigneFicheGasoil.SETRANGE(Statut, 1);
//         LigneFicheGasoil.SETFILTER(Materiel, '<>%1', '');
//         LigneFicheGasoil.SETFILTER(Journee, '<=%1', DateRapport);
//         IF LigneFicheGasoil.FINDFIRST THEN
//             REPEAT
//                 SumQuantitéGasoil += LigneFicheGasoil."Quantité Gasoil";
//             UNTIL LigneFicheGasoil.NEXT = 0;
//         CLEAR(RecDetailRapportDG);
//         RecDetailRapportDG."Type Ligne" := RecDetailRapportDG."Type Ligne"::Gasoil;
//         RecDetailRapportDG."N° Rapport" := NumRapport;
//         RecDetailRapportDG.Marché := CodeMarché;
//         RecDetailRapportDG."Date Rapport" := DateRapport;
//         RecDetailRapportDG.Designatiion := 'GASOIL';
//         RecDetailRapportDG.Montant := SumQuantitéGasoil * rec."Prix Gasoil";
//         RecDetailRapportDG.Niveau := 1;
//         RecDetailRapportDG."N° Ligne" := Compteur;
//         RecDetailRapportDG."Quantité Livré" := SumQuantitéGasoil;
//         IF RecDetailRapportDG.INSERT THEN;
//     end;


//     procedure MSRL(var NumRapport: Code[20]; var "CodeMarché": Code[20]; DateRapport: Date)
//     var
//         LignePointageVehicule: Record "Ligne Pointage Vehicule";
//         BonReglement: record "Bon Reglement";
//         STC: Record "STC Salaries";
//         Complement: Record "Detail Complement";
//         MS: Decimal;
//         MS1: Decimal;
//         MSActuelle: Decimal;
//         Effectif: Integer;
//         "MSCumulées": Decimal;
//         "JoursPayés": Decimal;
//         RecSalaryLines: Record "Rec. Salary Lines";
//         LAnnee: Integer;
//         LMois: Integer;
//         DatePaie: Date;
//         DernierePaie: Code[20];
//     begin
//         CLEAR(RecDetailRapportDG);
//         Compteur += 1000;
//         Effectif := 0;
//         MS := 0;
//         MSCumulées := 0;
//         MSActuelle := 0;
//         JoursPayés := 0;
//         // Derniere Paie Avant Date Rapport
//         IF DATE2DWY(DateRapport, 2) = 12 THEN
//             LAnnee := DATE2DMY(DateRapport, 3) - 1
//         ELSE
//             LAnnee := DATE2DMY(DateRapport, 3);
//         LMois := DATE2DMY(DateRapport, 2);
//         //Actuelle
//         // Actuelle
//         RecSalaryLines.RESET;
//         RecSalaryLines.SETCURRENTKEY(Month, Year, Employee);
//         RecSalaryLines.SETFILTER(Chantier, CodeMarché + '*');
//         RecSalaryLines.SETRANGE(Year, LAnnee);
//         IF RecSalaryLines.FINDLAST THEN DernierePaie := RecSalaryLines."No.";
//         RecSalaryLines.RESET;
//         RecSalaryLines.SETCURRENTKEY(Affectation, Month, Year, Employee);
//         RecSalaryLines.SETFILTER(Chantier, CodeMarché + '*');
//         RecSalaryLines.SETFILTER("No.", DernierePaie);
//         IF RecSalaryLines.FINDFIRST THEN
//             REPEAT
//                 MS := RecSalaryLines."Gross Salary" * 1.2337;
//                 IF COPYSTR(RecSalaryLines.Catégorie, 1, 2) = 'SV' THEN MS := RecSalaryLines."Gross Salary";
//                 IF COPYSTR(RecSalaryLines.Catégorie, 1, 2) = 'KR' THEN MS := RecSalaryLines."Gross Salary" * 1.073;
//                 MSActuelle += MS;
//                 Effectif += 1;
//                 JoursPayés += RecSalaryLines."Paied days";
//             UNTIL RecSalaryLines.NEXT = 0;
//         RecSalaryLines.RESET;
//         RecSalaryLines.SETCURRENTKEY(Month, Year, Employee);
//         RecSalaryLines.SETFILTER(Chantier, CodeMarché + '*');
//         //*RecSalaryLines.SETRANGE(Year,LAnnee);
//         //*RecSalaryLines.SETRANGE(Month,LMois-2); // Janvier=0, Decembre=11
//         IF RecSalaryLines.FINDFIRST THEN
//             REPEAT
//                 IF RecSalaryLines.Month > 12 THEN
//                     LMois := 1
//                 ELSE
//                     LMois := RecSalaryLines.Month + 1;
//                 DatePaie := DMY2DATE(1, LMois, RecSalaryLines.Year);
//                 IF DatePaie <= DateRapport THEN BEGIN
//                     MS1 := RecSalaryLines."Gross Salary" * 1.2337;
//                     IF COPYSTR(RecSalaryLines.Catégorie, 1, 2) = 'SV' THEN MS1 := RecSalaryLines."Gross Salary";
//                     IF COPYSTR(RecSalaryLines.Catégorie, 1, 2) = 'KR' THEN MS1 := RecSalaryLines."Gross Salary" * 1.073;
//                     MSCumulées += MS1;

//                 END;
//             UNTIL RecSalaryLines.NEXT = 0;
//         // BR
//         // Annee En Cours
//         BonReglement.RESET;
//         BonReglement.SETFILTER(Chantier, CodeMarché + '*');
//         //BonReglement.SETRANGE(Annee,LAnnee);
//         //BonReglement.SETRANGE(Mois,LMois-1);
//         IF BonReglement.FINDFIRST THEN
//             REPEAT
//                 DatePaie := DMY2DATE(1, BonReglement.Mois, BonReglement.Annee);
//                 IF DatePaie <= DateRapport THEN MSCumulées += BonReglement."Net à Payer";
//             UNTIL BonReglement.NEXT = 0;


//         //COMPLEMENT
//         // Annee En Cours
//         Complement.RESET;
//         Complement.SETFILTER(Chantier, CodeMarché + '*');
//         //Complement.SETRANGE(Annee,LAnnee);
//         //Complement.SETRANGE(Mois,LMois-2);
//         IF Complement.FINDFIRST THEN
//             REPEAT
//                 IF Complement.Mois < 12 THEN
//                     LMois := Complement.Mois + 1
//                 ELSE
//                     LMois := 1;
//                 DatePaie := DMY2DATE(1, LMois, Complement.Annee);
//                 IF DatePaie <= DateRapport THEN MSCumulées += Complement."Montant Complement";
//             UNTIL Complement.NEXT = 0;
//         //STC
//         // Annee En Cours
//         STC.RESET;
//         STC.SETFILTER(Chantier, CodeMarché + '*');
//         //STC.SETRANGE(Annee,LAnnee);
//         //STC.SETRANGE(Mois,LMois-2);
//         IF STC.FINDFIRST THEN
//             REPEAT
//                 DatePaie := DMY2DATE(1, STC.Mois + 1, STC.Annee);
//                 MSCumulées += STC."Net A Payer";
//             UNTIL STC.NEXT = 0;

//         CLEAR(RecDetailRapportDG);
//         RecDetailRapportDG."Type Ligne" := RecDetailRapportDG."Type Ligne"::MO;
//         RecDetailRapportDG."N° Rapport" := NumRapport;
//         RecDetailRapportDG.Marché := CodeMarché;
//         RecDetailRapportDG."Date Rapport" := DateRapport;
//         RecDetailRapportDG.Designatiion := 'MASSE SALARIALE';
//         RecDetailRapportDG.Niveau := 1;
//         RecDetailRapportDG."N° Ligne" := Compteur;
//         RecDetailRapportDG."Quantité Livré" := 0;
//         RecDetailRapportDG."MS Actuelle" := MSActuelle;
//         RecDetailRapportDG."MS Cumulée" := MSCumulées;
//         RecDetailRapportDG.Effectif := Effectif;
//         RecDetailRapportDG."Jours Payés" := JoursPayés;
//         IF RecDetailRapportDG.INSERT THEN;
//     end;


//     procedure Materiel(var NumRapport: Code[20]; var "CodeMarché": Code[20]; DateRapport: Date)
//     var
//         LignePointageVehicule: Record "Ligne Pointage Vehicule";
//         "Véhicule": Record "Véhicule";
//         "GenreVéhicule": Record "Genre Véhicule";
//         NbrF: Integer;
//         NbrD: Integer;
//         NbrP: Integer;
//         NbrC: Integer;
//         NbrMT: Integer;
//         NbrRF: Integer;
//         GrandeFamilleTmp: Code[20];
//         Pointeur: Integer;
//         CoutLocation: Decimal;
//         Tmp: Record tempo01;
//         i: Integer;
//     begin
//         CLEAR(RecDetailRapportDG);
//         IF GenreVéhicule.FINDFIRST THEN
//             REPEAT
//                 NbrF := 0;
//                 NbrD := 0;
//                 NbrP := 0;
//                 NbrC := 0;
//                 NbrMT := 0;
//                 NbrRF := 0;
//                 CoutLocation := 0;
//                 LignePointageVehicule.RESET;
//                 LignePointageVehicule.SETCURRENTKEY("Grande Famille");
//                 LignePointageVehicule.SETFILTER(Chantier, CodeMarché + '*');
//                 // LignePointageVehicule.SETRANGE(Vehicule,'BD-001');

//                 LignePointageVehicule.SETRANGE("Grande Famille", GenreVéhicule."Code Genre");
//                 LignePointageVehicule.SETRANGE("Statut Entete", 1);
//                 LignePointageVehicule.SETFILTER(Journee, '<=%1', DateRapport);
//                 IF LignePointageVehicule.FINDFIRST THEN
//                     // BEGIN
//                     REPEAT
//                         IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Fonctionnel THEN BEGIN
//                             NbrF += 1;
//                             IF Véhicule.GET(LignePointageVehicule.Vehicule) THEN BEGIN
//                                 IF rec."Remise Location Materiel" = 0 THEN
//                                     CoutLocation += Véhicule."Cout Location Journaliere"
//                                 ELSE
//                                     CoutLocation += Véhicule."Cout Location Journaliere" * (1 - rec."Remise Location Materiel" / 100);
//                             END;
//                         END;
//                         IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Disponible THEN NbrD += 1;
//                         IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Panne THEN NbrP += 1;
//                         IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Conger THEN NbrC += 1;
//                         IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::"Mauvais Temps" THEN NbrMT += 1;
//                         IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Reformer THEN NbrRF += 1;

//                     UNTIL LignePointageVehicule.NEXT = 0;

//                 Compteur += 1000;
//                 // CLEAR(RecDetailRapportDG);
//                 RecDetailRapportDG."Type Ligne" := RecDetailRapportDG."Type Ligne"::Materiel;
//                 RecDetailRapportDG."N° Rapport" := NumRapport;
//                 RecDetailRapportDG.Marché := CodeMarché;
//                 RecDetailRapportDG."Date Rapport" := DateRapport;
//                 RecDetailRapportDG.Designatiion := UPPERCASE(GenreVéhicule."Code Genre");
//                 RecDetailRapportDG.Niveau := 1;
//                 RecDetailRapportDG."N° Ligne" := Compteur;
//                 RecDetailRapportDG."Nombre F" := NbrF;
//                 RecDetailRapportDG."Nombre P" := NbrP;
//                 RecDetailRapportDG."Nombre D" := NbrD;
//                 RecDetailRapportDG."Nombre C" := NbrC;
//                 RecDetailRapportDG."Nombre Ref" := NbrRF;
//                 RecDetailRapportDG."Nombre M.T" := NbrMT;
//                 RecDetailRapportDG."Grande famille Materiel" := GenreVéhicule."Code Genre";
//                 RecDetailRapportDG.Montant := CoutLocation;
//                 IF RecDetailRapportDG.INSERT THEN;
//             //  END;

//             UNTIL GenreVéhicule.NEXT = 0;
//     end;


//     procedure FraixAnnexe(var NumRapport: Code[20]; var "CodeMarché": Code[20]; DateRapport: Date)
//     var
//         RegroupementRapportDG: Record "Regroupement Rapport DG";
//         PurchRcptLine: Record "Purch. Inv. Line";
//         ItemCharge: Record "Item Charge";
//         MontantFrais: Decimal;
//     begin
//         CLEAR(RecDetailRapportDG);
//         IF ItemCharge.FINDFIRST THEN
//             REPEAT
//                 MontantFrais := 0;
//                 PurchRcptLine.RESET;
//                 PurchRcptLine.SETCURRENTKEY("Job No.", Type, "No.", "Posting Date");
//                 PurchRcptLine.SETFILTER("Job No.", CodeMarché + '*');
//                 PurchRcptLine.SETRANGE(Type, PurchRcptLine.Type::"Charge (Item)");
//                 PurchRcptLine.SETRANGE("No.", ItemCharge."No.");
//                 PurchRcptLine.SETFILTER("Posting Date", '<=%1', DateRapport);
//                 IF PurchRcptLine.FINDFIRST THEN
//                     REPEAT
//                         MontantFrais += PurchRcptLine.Quantity * PurchRcptLine."Unit Cost (LCY)";
//                         RegroupementRapportDG.Code := PurchRcptLine."No.";
//                         RegroupementRapportDG.Chantier := PurchRcptLine."Job No.";
//                         RegroupementRapportDG.Type := RegroupementRapportDG.Type::Materiaux;
//                         RegroupementRapportDG.Designation := ItemCharge.Description;
//                         IF NOT RegroupementRapportDG.INSERT THEN RegroupementRapportDG.MODIFY;

//                     UNTIL PurchRcptLine.NEXT = 0;
//                 Compteur += 1000;
//                 CLEAR(RecDetailRapportDG);
//                 RecDetailRapportDG."Type Ligne" := RecDetailRapportDG."Type Ligne"::"Frais Annexe";
//                 RecDetailRapportDG."N° Rapport" := NumRapport;
//                 RecDetailRapportDG.Marché := CodeMarché;
//                 RecDetailRapportDG."Date Rapport" := DateRapport;
//                 IF ItemCharge."Description Bilan" = '' THEN
//                     RecDetailRapportDG.Designatiion := UPPERCASE(ItemCharge.Description)
//                 ELSE
//                     RecDetailRapportDG.Designatiion := UPPERCASE(ItemCharge."Description Bilan");
//                 IF ItemCharge."Sous Traitance" THEN RecDetailRapportDG."Sous Traitance" := TRUE;
//                 RecDetailRapportDG.Niveau := 1;
//                 RecDetailRapportDG."N° Ligne" := Compteur;
//                 RecDetailRapportDG.Montant := MontantFrais;
//                 RecDetailRapportDG."Code Frais" := ItemCharge."No.";
//                 IF MontantFrais <> 0 THEN IF RecDetailRapportDG.INSERT THEN;

//             UNTIL ItemCharge.NEXT = 0;
//     end;


//     procedure Loyer(var NumRapport: Code[20]; var "CodeMarché": Code[20]; DateRapport: Date)
//     var
//         ChantierLoyer: Record "Chantier Loyer";
//         PaymentLine: Record "Payment Line";
//         MontantLoyer: Decimal;
//     begin
//         CLEAR(RecDetailRapportDG);
//         ChantierLoyer.SETFILTER(Affaire, CodeMarché + '*');
//         IF ChantierLoyer.FINDFIRST THEN
//             REPEAT
//                 PaymentLine.RESET;
//                 PaymentLine.SETRANGE(Chantier, ChantierLoyer.Code);
//                 PaymentLine.SETRANGE("Copied To Line", 0);
//                 PaymentLine.SETFILTER("Due Date", '<=%1', DateRapport);
//                 IF PaymentLine.FINDFIRST THEN
//                     REPEAT
//                         MontantLoyer += ABS(PaymentLine.Amount);
//                     UNTIL PaymentLine.NEXT = 0;

//             UNTIL ChantierLoyer.NEXT = 0;
//         Compteur += 1000;
//         CLEAR(RecDetailRapportDG);
//         RecDetailRapportDG."Type Ligne" := RecDetailRapportDG."Type Ligne"::Loyer;
//         RecDetailRapportDG."N° Rapport" := NumRapport;
//         RecDetailRapportDG.Marché := CodeMarché;
//         RecDetailRapportDG."Date Rapport" := DateRapport;
//         RecDetailRapportDG.Designatiion := 'LOYER';
//         RecDetailRapportDG.Niveau := 1;
//         RecDetailRapportDG."N° Ligne" := Compteur;
//         RecDetailRapportDG.Montant := MontantLoyer;
//         IF RecDetailRapportDG.INSERT THEN;
//     end;


//     procedure Decompte(var NumRapport: Code[20]; var "CodeMarché": Code[20]; DateRapport: Date)
//     var
//         SalesHeader: Record "Sales Header";
//         SalesLine: Record "Sales Line";
//         SalesShipmentHeader: Record "Sales Shipment Header";
//         SalesShipmentLine: Record "Sales Shipment Line";
//         "MontantMarché": Decimal;
//         MontantDecompte: Decimal;
//         DateOrdreService: Date;
//         DateMAJ: Date;
//         NbrMois: Integer;
//         DelaiSusp: Decimal;
//         DateFinPrev: Date;
//     begin
//         Tempo.DELETEALL;
//         CLEAR(RecDetailRapportDG);
//         SalesHeader.SETRANGE("Commande Affaire", TRUE);
//         SalesHeader.SETFILTER("Job No.", CodeMarché + '*');
//         IF SalesHeader.FINDFIRST THEN
//             //BEGIN
//             REPEAT
//                 SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
//                 SalesLine.SETRANGE("Document No.", SalesHeader."No.");
//                 IF SalesLine.FINDFIRST THEN
//                     REPEAT
//                         MontantMarché += SalesLine.Amount;
//                     //  IF SalesHeader."Prices Including VAT" THEN
//                     //    MontantDecompte+=(SalesLine."Quantity Shipped"*SalesLine."Unit Price")/(1+SalesLine."VAT %"/100)
//                     //  ELSE MontantDecompte+=(SalesLine."Quantity Shipped"*SalesLine."Unit Price")
//                     UNTIL SalesLine.NEXT = 0;
//                 DateOrdreService := SalesHeader."Date Ordre Service";
//                 DelaiSusp := SalesHeader."Delai Suspension";
//                 NbrMois := SalesHeader."Nbre Mois Marché";
//                 DateFinPrev := SalesHeader."Order Date";
//                 SalesShipmentHeader.SETRANGE("Order No.", SalesHeader."No.");
//                 SalesShipmentHeader.SETFILTER("Date Debut Decompte", '<=%1', DateRapport);
//                 IF SalesShipmentHeader.FINDFIRST THEN
//                     REPEAT
//                         SalesShipmentLine.SETRANGE("Document No.", SalesShipmentHeader."No.");
//                         IF SalesShipmentLine.FINDFIRST THEN
//                             REPEAT
//                                 IF NOT SalesHeader."Prices Including VAT" THEN
//                                     MontantDecompte += SalesShipmentLine.Quantity * SalesShipmentLine."Unit Price"
//                                 ELSE
//                                     IF SalesShipmentLine."VAT %" <> 0 THEN
//                                         MontantDecompte += SalesShipmentLine.Quantity * (SalesShipmentLine."Unit Price" / (1 + SalesShipmentLine."VAT %" / 100))
//                     ;
//                             // KA 19-02-18
//                             //i2+=1;
//                             //Tempo.CLE:=i2;
//                             //Tempo.numdoc:=SalesShipmentLine."Document No.";
//                             //Tempo.numligne:=SalesShipmentLine."Line No.";
//                             //Tempo.quantite:=SalesShipmentLine.Quantity;
//                             //Tempo."pu decompte":=SalesShipmentLine."Unit Price";
//                             //Tempo.marche:=SalesShipmentLine."Job No.";
//                             //Tempo.PRIX:=FORMAT(SalesShipmentLine."Unit Price");
//                             //Tempo.qte:=FORMAT(SalesShipmentLine.Quantity);
//                             //IF SalesShipmentLine.Quantity<>0 THEN Tempo.INSERT;
//                             UNTIL SalesShipmentLine.NEXT = 0;
//                         DateMAJ := SalesShipmentHeader."Date Fin Decompte";
//                     UNTIL SalesShipmentHeader.NEXT = 0;

//             UNTIL SalesHeader.NEXT = 0;
//         // END;
//         Compteur += 1000;
//         CLEAR(RecDetailRapportDG);
//         RecDetailRapportDG."Type Ligne" := RecDetailRapportDG."Type Ligne"::Decompte;
//         RecDetailRapportDG."N° Rapport" := NumRapport;
//         RecDetailRapportDG.Marché := CodeMarché;
//         RecDetailRapportDG."Date Rapport" := DateRapport;
//         RecDetailRapportDG.Designatiion := 'DECOMPTE';
//         RecDetailRapportDG.Niveau := 1;
//         RecDetailRapportDG."N° Ligne" := Compteur;
//         RecDetailRapportDG."Date Ordre Service" := DateOrdreService;
//         RecDetailRapportDG."Date Mise a Jour" := rec."Date Rapport";
//         RecDetailRapportDG."Date Fin Previsionnelle" := DateFinPrev;
//         RecDetailRapportDG."Nombre De Mois" := NbrMois;
//         RecDetailRapportDG."Delai Suspension" := DelaiSusp;
//         RecDetailRapportDG."Montant Marché" := MontantMarché;
//         IF rec.Rabais = 0 THEN rec.Rabais := 0;
//         RecDetailRapportDG."Montant Decompte" := MontantDecompte * (1 - (rec.Rabais / 100));
//         IF RecDetailRapportDG.INSERT THEN;
//     end;


//     procedure Divers(var NumRapport: Code[20]; var "CodeMarché": Code[20]; var DateRapport: Date)
//     var
//         Boucle: Integer;
//     begin
//         Compteur += 1000;
//         CLEAR(RecDetailRapportDG);
//         RecDetailRapportDG."Type Ligne" := RecDetailRapportDG."Type Ligne"::"Puce TelePhonique";
//         RecDetailRapportDG."N° Rapport" := NumRapport;
//         RecDetailRapportDG.Marché := CodeMarché;
//         RecDetailRapportDG."Date Rapport" := DateRapport;
//         RecDetailRapportDG.Designatiion := 'LIGNE TELEPHONIQUE';
//         RecDetailRapportDG.Niveau := 1;
//         RecDetailRapportDG."N° Ligne" := Compteur;
//         IF NOT RecDetailRapportDG.INSERT THEN RecDetailRapportDG.MODIFY;
//         FOR Boucle := 1 TO 9 DO BEGIN
//             Compteur += 1000;
//             CLEAR(RecDetailRapportDG);
//             RecDetailRapportDG."Type Ligne" := RecDetailRapportDG."Type Ligne"::Divers;
//             RecDetailRapportDG."N° Rapport" := NumRapport;
//             RecDetailRapportDG.Marché := CodeMarché;
//             RecDetailRapportDG."Date Rapport" := DateRapport;
//             RecDetailRapportDG.Designatiion := 'DIVERS';
//             RecDetailRapportDG.Niveau := 1;
//             RecDetailRapportDG."N° Ligne" := Compteur;
//             RecDetailRapportDG.Quantité := 0;
//             RecDetailRapportDG."Reste a Facturer" := FALSE;
//             IF RecDetailRapportDG.INSERT THEN;
//         END;
//         Compteur += 1000;
//         CLEAR(RecDetailRapportDG);
//         RecDetailRapportDG."Type Ligne" := RecDetailRapportDG."Type Ligne"::"Revision Prix";
//         RecDetailRapportDG."N° Rapport" := NumRapport;
//         RecDetailRapportDG.Marché := CodeMarché;
//         RecDetailRapportDG."Date Rapport" := DateRapport;
//         RecDetailRapportDG.Designatiion := 'REVISION PRIX';
//         RecDetailRapportDG.Niveau := 1;
//         RecDetailRapportDG."N° Ligne" := Compteur;
//         RecDetailRapportDG.Quantité := 0;
//         RecDetailRapportDG."Reste a Facturer" := FALSE;

//         IF NOT RecDetailRapportDG.INSERT THEN RecDetailRapportDG.MODIFY;
//     end;


//     procedure ResteaFacturer(var NumRapport: Code[20]; var "CodeMarché": Code[20]; DateRapport: Date)
//     var
//         RegroupementRapportDG: Record "Regroupement Rapport DG";
//         SumMontantDif: Decimal;
//         Compteur: Integer;
//     begin
//         RegroupementRapportDG.SETRANGE(Code, CodeMarché);
//         IF RegroupementRapportDG.FINDFIRST THEN
//             REPEAT
//                 SumMontantDif := 0;
//                 RecDetailRapportDG.SETRANGE(Marché, CodeMarché);
//                 RecDetailRapportDG.SETRANGE("Regroupement Bilan", RegroupementRapportDG.Designation);
//                 RecDetailRapportDG.SETRANGE("Type Ligne", RecDetailRapportDG."Type Ligne"::Materiaux);
//                 IF RecDetailRapportDG.FINDFIRST THEN
//                     REPEAT
//                         SumMontantDif := SumMontantDif + RecDetailRapportDG."Montant Diff";
//                     UNTIL RecDetailRapportDG.NEXT = 0;
//                 CLEAR(RecDetailRapportDG);
//                 Compteur += 1000;
//                 RecDetailRapportDG."N° Rapport" := NumRapport;
//                 RecDetailRapportDG.Marché := CodeMarché;
//                 RecDetailRapportDG."N° Ligne" := Compteur;
//                 RecDetailRapportDG."Type Ligne" := RecDetailRapportDG."Type Ligne"::"Reste à Facturer";
//                 RecDetailRapportDG."Date Rapport" := DateRapport;
//                 RecDetailRapportDG.Designatiion := RegroupementRapportDG.Designation;
//                 RecDetailRapportDG.Montant := SumMontantDif;
//                 RecDetailRapportDG.INSERT;

//             UNTIL RegroupementRapportDG.NEXT = 0;
//     end;


//     procedure DiffSansRegroupement(var NumRapport: Code[20]; var "CodeMarché": Code[20]; var DateRapport: Date)
//     var
//         "QunantitéAFaturée": Decimal;
//     begin
//         RecDetailRapportDG.RESET;
//         RecDetailRapportDG.SETFILTER("Regroupement Foison.", '=%1', '');
//         RecDetailRapportDG.SETFILTER(Marché, CodeMarché + '*');
//         IF RecDetailRapportDG.FINDFIRST THEN
//             REPEAT
//                 IF RecDetailRapportDG."Type Diff" = RecDetailRapportDG."Type Diff"::S THEN BEGIN
//                     QunantitéAFaturée := 0;
//                     RecDetailRapportDG.Difference := RecDetailRapportDG."Quantité Exécuté" - RecDetailRapportDG."Quantité Livré";
//                     QunantitéAFaturée := RecDetailRapportDG.Difference;
//                     RecDetailRapportDG."Montant Diff" := RecDetailRapportDG.Difference * RecDetailRapportDG."Prix Unitaire Moy  Marché";
//                     RecDetailRapportDG.Quantité := RecDetailRapportDG."Quantité Livré";
//                     RecDetailRapportDG."Quantitée Difference" := RecDetailRapportDG."Quantité Exécuté" - RecDetailRapportDG."Quantité Livré";
//                     RecDetailRapportDG."Quantité Decompte" := RecDetailRapportDG."Quantité Exécuté";
//                     RecDetailRapportDG."Reste a Facturer" := TRUE;
//                     RecDetailRapportDG.MODIFY;

//                 END;
//                 IF RecDetailRapportDG."Type Diff" = RecDetailRapportDG."Type Diff"::D THEN BEGIN
//                     QunantitéAFaturée := 0;
//                     IF RecDetailRapportDG."Quantité Exécuté" <> 0 THEN
//                         RecDetailRapportDG.Difference := RecDetailRapportDG."Quantité Livré" / RecDetailRapportDG."Quantité Exécuté";
//                     IF (RecDetailRapportDG."Taux Foisonnement" <> 0) AND
//                        (RecDetailRapportDG.Difference > RecDetailRapportDG."Taux Foisonnement") THEN BEGIN
//                         QunantitéAFaturée := (RecDetailRapportDG."Quantité Livré" / RecDetailRapportDG."Taux Foisonnement");
//                         RecDetailRapportDG."Montant Diff" := (RecDetailRapportDG."Quantité Exécuté" - QunantitéAFaturée) *
//                                                             RecDetailRapportDG."Prix Unitaire Moy  Marché";
//                     END;
//                     RecDetailRapportDG.Quantité := QunantitéAFaturée;
//                     RecDetailRapportDG."Quantitée Difference" := RecDetailRapportDG."Quantité Exécuté" - QunantitéAFaturée;
//                     RecDetailRapportDG."Quantité Decompte" := RecDetailRapportDG."Quantité Exécuté";
//                     RecDetailRapportDG."Reste a Facturer" := TRUE;
//                     RecDetailRapportDG.MODIFY;

//                 END;

//             UNTIL RecDetailRapportDG.NEXT = 0;
//     end;


//     procedure DiffAveRegroupement(var NumRapport: Code[20]; var "CodeMarché": Code[20]; var DateRapport: Date)
//     var
//         RegroupementRapportDG: Record "Regroupement Rapport DG";
//         LDetailRapportDG: Record "Detail Rapport DG";
//         "QunantitéExuté": Decimal;
//         "QunantitéLivré": Decimal;
//         "QuantitéReste": Decimal;
//         TauxFoisonnement: Decimal;
//         PuMoyenne: Decimal;
//         "MontantMarhé": Decimal;
//         "QuantitéMarhé": Decimal;
//         "QunantitéAFaturée": Decimal;
//         MontantDiff: Decimal;
//         Difference: Decimal;
//     begin

//         IF RegroupementRapportDG.FINDFIRST THEN
//             REPEAT
//                 RecDetailRapportDG.SETFILTER("Regroupement Foison.", RegroupementRapportDG.Code);
//                 RecDetailRapportDG.SETFILTER(Marché, CodeMarché + '*');
//                 IF RecDetailRapportDG.FINDFIRST THEN BEGIN
//                     QunantitéExuté := 0;
//                     QunantitéLivré := 0;
//                     MontantMarhé := 0;
//                     QuantitéMarhé := 0;
//                     MontantDiff := 0;
//                     QunantitéAFaturée := 0;
//                     REPEAT
//                         QunantitéExuté += RecDetailRapportDG."Quantité Exécuté";
//                         QunantitéLivré += RecDetailRapportDG."Quantité Livré";
//                         MontantMarhé += RecDetailRapportDG."Montant Marché";
//                         QuantitéMarhé += RecDetailRapportDG."Quantité Marché";
//                     UNTIL RecDetailRapportDG.NEXT = 0;
//                     IF MontantMarhé <> 0 THEN IF QuantitéMarhé <> 0 THEN PuMoyenne := MontantMarhé / QuantitéMarhé;

//                     IF RecDetailRapportDG."Type Diff" = RecDetailRapportDG."Type Diff"::S THEN BEGIN
//                         Difference := QunantitéExuté - QunantitéLivré;
//                         QunantitéAFaturée := Difference;
//                         MontantDiff := RecDetailRapportDG.Difference * PuMoyenne;
//                     END;
//                     IF RecDetailRapportDG."Type Diff" = RecDetailRapportDG."Type Diff"::D THEN BEGIN
//                         IF QunantitéExuté <> 0 THEN
//                             Difference := QunantitéLivré / QunantitéExuté;
//                         IF (RecDetailRapportDG."Taux Foisonnement" <> 0) AND
//                            (Difference > RecDetailRapportDG."Taux Foisonnement") THEN BEGIN
//                             QunantitéAFaturée := (QunantitéLivré / RecDetailRapportDG."Taux Foisonnement");
//                             MontantDiff := (QunantitéExuté - QunantitéAFaturée) * PuMoyenne;
//                         END;
//                     END;
//                     CLEAR(LDetailRapportDG);
//                     Compteur += 1000;
//                     LDetailRapportDG."N° Rapport" := NumRapport;
//                     LDetailRapportDG.Marché := CodeMarché;
//                     LDetailRapportDG."N° Ligne" := Compteur;
//                     LDetailRapportDG."Type Ligne" := LDetailRapportDG."Type Ligne"::"Reste à Facturer";
//                     LDetailRapportDG."Date Rapport" := DateRapport;
//                     LDetailRapportDG.Designatiion := RegroupementRapportDG.Designation;
//                     LDetailRapportDG."Montant Diff" := MontantDiff;
//                     LDetailRapportDG.Difference := Difference;
//                     LDetailRapportDG."Prix Unitaire Moy  Marché" := PuMoyenne;
//                     LDetailRapportDG."Taux Foisonnement" := RecDetailRapportDG."Taux Foisonnement";
//                     LDetailRapportDG.Quantité := QunantitéAFaturée;
//                     LDetailRapportDG."Quantitée Difference" := QunantitéExuté - QunantitéAFaturée;
//                     LDetailRapportDG."Quantité Decompte" := QunantitéExuté;
//                     LDetailRapportDG."Reste a Facturer" := TRUE;
//                     IF LDetailRapportDG.INSERT THEN;

//                 END;

//             UNTIL RegroupementRapportDG.NEXT = 0;
//     end;


//     procedure RatioMatriaux(var NumRapport: Code[20]; var "CodeMarché": Code[20]; var DateRapport: Date)
//     var
//         RecDetailRapportDG2: Record "Detail Rapport DG";
//         SumMontantTotal: Decimal;
//         RatioLigne: Decimal;
//         SumMontantLigneMateriel: Decimal;
//         SumMontantLigneGasoil: Decimal;
//         SumMontantLigneMO: Decimal;
//         SumMontantLignefraixAnnexeST: Decimal;
//         SumMontantLignefraixAnnexe: Decimal;
//         SumMontantLigneMateriaux: Decimal;
//         SumMontantLignePueTelephonique: Decimal;
//         SumMontantLigneLoyer: Decimal;
//         SumMontantLigneDivers: Decimal;
//         Pointeur: Integer;
//         Ratios: Decimal;
//         Desription: Text[30];
//     begin
//         CLEAR(RecDetailRapportDG2);
//         Compteur += 1000;
//         SumMontantLigneMateriel := 0;
//         SumMontantLigneGasoil := 0;
//         SumMontantLigneMO := 0;
//         SumMontantLignefraixAnnexe := 0;
//         SumMontantLignefraixAnnexeST := 0;
//         SumMontantLigneMateriaux := 0;
//         SumMontantLignePueTelephonique := 0;
//         SumMontantLigneDivers := 0;
//         ST := 0;
//         RecDetailRapportDG2.SETRANGE("N° Rapport", NumRapport);
//         //RecDetailRapportDG2.SETFILTER("Type Ligne",'<>%1',RecDetailRapportDG2."Type Ligne"::"Reste à Facturer");
//         IF RecDetailRapportDG2.FINDFIRST THEN
//             REPEAT
//                 IF (RecDetailRapportDG2."Type Ligne" = RecDetailRapportDG2."Type Ligne"::Decompte)
//                 OR (RecDetailRapportDG2."Type Ligne" = RecDetailRapportDG2."Type Ligne"::"Revision Prix") THEN
//                     SumMontantTotal += RecDetailRapportDG2.Montant + RecDetailRapportDG2."Montant Decompte";
//             UNTIL RecDetailRapportDG2.NEXT = 0;

//         TotalCharge := SumMontantTotal;
//         CLEAR(RecDetailRapportDG2);
//         RecDetailRapportDG2.SETRANGE("N° Rapport", NumRapport);
//         IF RecDetailRapportDG2.FINDFIRST THEN
//             REPEAT
//                 IF RecDetailRapportDG2."Type Ligne" = RecDetailRapportDG2."Type Ligne"::Materiaux THEN
//                     SumMontantLigneMateriaux += RecDetailRapportDG2.Montant;
//                 IF RecDetailRapportDG2."Type Ligne" = RecDetailRapportDG2."Type Ligne"::Materiel THEN
//                     SumMontantLigneMateriel += RecDetailRapportDG2.Montant;

//                 IF RecDetailRapportDG2."Type Ligne" = RecDetailRapportDG2."Type Ligne"::Gasoil THEN
//                     SumMontantLigneGasoil += RecDetailRapportDG2.Montant;

//                 IF RecDetailRapportDG2."Type Ligne" = RecDetailRapportDG2."Type Ligne"::MO THEN
//                     SumMontantLigneMO += RecDetailRapportDG2."MS Cumulée";

//                 IF RecDetailRapportDG2."Type Ligne" = RecDetailRapportDG2."Type Ligne"::"Frais Annexe" THEN BEGIN
//                     IF NOT RecDetailRapportDG2."Sous Traitance" THEN
//                         SumMontantLignefraixAnnexe += RecDetailRapportDG2.Montant
//                     ELSE
//                         SumMontantLignefraixAnnexeST += RecDetailRapportDG2.Montant;
//                 END;
//                 IF RecDetailRapportDG2."Type Ligne" = RecDetailRapportDG2."Type Ligne"::Divers THEN
//                     SumMontantLigneDivers += RecDetailRapportDG2.Montant;

//                 IF RecDetailRapportDG2."Type Ligne" = RecDetailRapportDG2."Type Ligne"::"Puce TelePhonique" THEN
//                     SumMontantLignePueTelephonique += RecDetailRapportDG2.Montant;

//                 IF RecDetailRapportDG2."Type Ligne" = RecDetailRapportDG2."Type Ligne"::Loyer THEN
//                     SumMontantLigneLoyer += RecDetailRapportDG2.Montant;

//             UNTIL RecDetailRapportDG2.NEXT = 0;
//         ST := SumMontantLignefraixAnnexeST;
//         FOR Pointeur := 1 TO 8 DO BEGIN
//             IF SumMontantTotal <> 0 THEN BEGIN
//                 IF Pointeur = 1 THEN BEGIN
//                     Ratios := SumMontantLigneMateriaux / SumMontantTotal;
//                     Desription := 'MATERIAUX';
//                 END;
//                 IF Pointeur = 2 THEN BEGIN
//                     Ratios := SumMontantLigneMateriel / SumMontantTotal;
//                     Desription := 'MATERIEL';
//                 END;
//                 IF Pointeur = 3 THEN BEGIN
//                     Ratios := SumMontantLigneGasoil / (SumMontantTotal - SumMontantLignefraixAnnexeST);
//                     Desription := 'GASOIL';
//                 END;
//                 IF Pointeur = 4 THEN BEGIN
//                     Ratios := SumMontantLigneMO / (SumMontantTotal - SumMontantLignefraixAnnexeST);
//                     Desription := 'MO';
//                 END;
//                 IF Pointeur = 5 THEN BEGIN
//                     Ratios := (SumMontantLignefraixAnnexe + SumMontantLignefraixAnnexeST) / SumMontantTotal;
//                     Desription := 'FRAIX ANNEXES';
//                 END;
//                 IF Pointeur = 6 THEN BEGIN
//                     Ratios := SumMontantLignePueTelephonique / SumMontantTotal;
//                     Desription := 'PUCE TELEPHONIQUE';
//                 END;
//                 IF Pointeur = 7 THEN BEGIN
//                     Ratios := SumMontantLigneLoyer / SumMontantTotal;
//                     Desription := 'LOYER';
//                 END;

//                 IF Pointeur = 8 THEN BEGIN
//                     Ratios := SumMontantLigneDivers / SumMontantTotal;
//                     IF NOT rec.Centrale THEN
//                         Desription := 'DIVERS'
//                     ELSE
//                         Desription := 'FRAIX GENEREAUX';
//                 END;

//             END;
//             CLEAR(RecDetailRapportDG2);
//             Compteur += 1000;
//             RecDetailRapportDG2."N° Rapport" := NumRapport;
//             RecDetailRapportDG2.Marché := CodeMarché;
//             RecDetailRapportDG2."N° Ligne" := Compteur;
//             RecDetailRapportDG2."Type Ligne" := RecDetailRapportDG2."Type Ligne"::Ratios;
//             RecDetailRapportDG2."Date Rapport" := DateRapport;
//             RecDetailRapportDG2.Montant := Ratios * 100;
//             RecDetailRapportDG2.Designatiion := Desription;
//             IF Ratios <> 0 THEN IF NOT RecDetailRapportDG2.INSERT THEN RecDetailRapportDG2.MODIFY;
//         END;
//     end;


//     procedure Bilan(var NumRapport: Code[20]; var "CodeMarché": Code[20]; var DateRapport: Date)
//     var
//         RecDetailRapportDG3: Record "Detail Rapport DG";
//         RecDetailRapportDG4: Record "Detail Rapport DG";
//         SumMontant: Decimal;
//         i: Integer;
//     begin
//         //Materiaux
//         IF rec.Centrale THEN BEGIN
//             SumMontant := 0;
//             RecDetailRapportDG4.RESET;
//             RecDetailRapportDG4.SETRANGE("N° Rapport", NumRapport);
//             RecDetailRapportDG4.SETRANGE("Type Ligne", RecDetailRapportDG4."Type Ligne"::Materiaux);
//             IF RecDetailRapportDG4.FINDFIRST THEN
//                 REPEAT
//                     SumMontant += RecDetailRapportDG4.Montant;
//                 UNTIL RecDetailRapportDG4.NEXT = 0;
//             CLEAR(RecDetailRapportDG3);
//             Compteur += 1000;
//             RecDetailRapportDG3."N° Rapport" := NumRapport;
//             RecDetailRapportDG3.Marché := CodeMarché;
//             RecDetailRapportDG3."N° Ligne" := Compteur;
//             RecDetailRapportDG3."Type Ligne" := RecDetailRapportDG3."Type Ligne"::Bilan;
//             RecDetailRapportDG3."Date Rapport" := DateRapport;
//             RecDetailRapportDG3."Regroupement Bilan" := 'B00';
//             RecDetailRapportDG3.Designatiion := 'MATERIAUX';
//             RecDetailRapportDG3.Montant := SumMontant;
//             IF TotalCharge <> 0 THEN RecDetailRapportDG3.Ratios := SumMontant / (TotalCharge);
//             RecDetailRapportDG3.INSERT;

//             SumMontant := 0;
//             RecDetailRapportDG4.RESET;
//             RecDetailRapportDG4.SETRANGE("N° Rapport", NumRapport);
//             RecDetailRapportDG4.SETRANGE("Type Ligne", RecDetailRapportDG4."Type Ligne"::Divers);
//             i := 14;
//             IF RecDetailRapportDG4.FINDFIRST THEN
//                 REPEAT
//                     SumMontant := RecDetailRapportDG4.Montant;
//                     CLEAR(RecDetailRapportDG3);
//                     Compteur += 1000;
//                     i += 1;
//                     RecDetailRapportDG3."N° Rapport" := NumRapport;
//                     RecDetailRapportDG3.Marché := CodeMarché;
//                     RecDetailRapportDG3."N° Ligne" := Compteur;
//                     RecDetailRapportDG3."Type Ligne" := RecDetailRapportDG3."Type Ligne"::Bilan;
//                     RecDetailRapportDG3."Date Rapport" := DateRapport;
//                     RecDetailRapportDG3."Regroupement Bilan" := 'B' + FORMAT(i);
//                     RecDetailRapportDG3.Designatiion := RecDetailRapportDG4.Designatiion;
//                     RecDetailRapportDG3.Montant := SumMontant;
//                     IF TotalCharge <> 0 THEN RecDetailRapportDG3.Ratios := SumMontant / (TotalCharge);
//                     RecDetailRapportDG3.INSERT;

//                 UNTIL RecDetailRapportDG4.NEXT = 0;


//         END;

//         // MO
//         SumMontant := 0;
//         RecDetailRapportDG4.RESET;
//         RecDetailRapportDG4.SETRANGE("N° Rapport", NumRapport);
//         RecDetailRapportDG4.SETRANGE("Type Ligne", RecDetailRapportDG4."Type Ligne"::MO);
//         IF RecDetailRapportDG4.FINDFIRST THEN BEGIN
//             SumMontant := RecDetailRapportDG4."MS Cumulée";
//             CLEAR(RecDetailRapportDG3);
//             Compteur += 1000;
//             RecDetailRapportDG3."N° Rapport" := NumRapport;
//             RecDetailRapportDG3.Marché := CodeMarché;
//             RecDetailRapportDG3."N° Ligne" := Compteur;
//             RecDetailRapportDG3."Type Ligne" := RecDetailRapportDG3."Type Ligne"::Bilan;
//             RecDetailRapportDG3."Date Rapport" := DateRapport;
//             RecDetailRapportDG3."Regroupement Bilan" := 'B01';
//             RecDetailRapportDG3.Designatiion := 'MASSE SALARIALE';
//             RecDetailRapportDG3.Montant := SumMontant;
//             IF TotalCharge <> 0 THEN RecDetailRapportDG3.Ratios := SumMontant / (TotalCharge - ST);
//             RecDetailRapportDG3.INSERT;

//         END;

//         // GASOIL
//         SumMontant := 0;
//         RecDetailRapportDG4.RESET;
//         RecDetailRapportDG4.SETRANGE("N° Rapport", NumRapport);
//         RecDetailRapportDG4.SETRANGE("Type Ligne", RecDetailRapportDG4."Type Ligne"::Gasoil);
//         IF RecDetailRapportDG4.FINDFIRST THEN BEGIN
//             SumMontant := RecDetailRapportDG4.Montant;
//             CLEAR(RecDetailRapportDG3);
//             Compteur += 1000;
//             RecDetailRapportDG3."N° Rapport" := NumRapport;
//             RecDetailRapportDG3.Marché := CodeMarché;
//             RecDetailRapportDG3."N° Ligne" := Compteur;
//             RecDetailRapportDG3."Type Ligne" := RecDetailRapportDG3."Type Ligne"::Bilan;
//             RecDetailRapportDG3."Date Rapport" := DateRapport;
//             RecDetailRapportDG3."Regroupement Bilan" := 'B02';
//             RecDetailRapportDG3.Designatiion := 'CARBURANT';
//             RecDetailRapportDG3.Montant := SumMontant;
//             IF TotalCharge <> 0 THEN RecDetailRapportDG3.Ratios := SumMontant / (TotalCharge - ST);
//             RecDetailRapportDG3.INSERT;

//         END;

//         // MATERIEL TRANSPORT
//         SumMontant := 0;
//         RecDetailRapportDG4.RESET;
//         RecDetailRapportDG4.SETRANGE("N° Rapport", NumRapport);
//         RecDetailRapportDG4.SETRANGE("Type Ligne", RecDetailRapportDG4."Type Ligne"::Materiel);
//         RecDetailRapportDG4.SETFILTER("Grande famille Materiel", '=%1', 'CAMION');
//         IF RecDetailRapportDG4.FINDFIRST THEN
//             REPEAT
//                 SumMontant += RecDetailRapportDG4.Montant;
//                 CLEAR(RecDetailRapportDG3);
//                 Compteur += 1000;
//                 RecDetailRapportDG3."N° Rapport" := NumRapport;
//                 RecDetailRapportDG3.Marché := CodeMarché;
//                 RecDetailRapportDG3."N° Ligne" := Compteur;
//                 RecDetailRapportDG3."Type Ligne" := RecDetailRapportDG3."Type Ligne"::Bilan;
//                 RecDetailRapportDG3."Date Rapport" := DateRapport;
//                 RecDetailRapportDG3."Regroupement Bilan" := 'B03';
//                 RecDetailRapportDG3.Designatiion := 'MATERIEL TRANSPORT';
//                 RecDetailRapportDG3.Montant := SumMontant;
//                 IF TotalCharge <> 0 THEN RecDetailRapportDG3.Ratios := SumMontant / TotalCharge;
//                 RecDetailRapportDG3.INSERT;

//             UNTIL RecDetailRapportDG4.NEXT = 0;

//         // MATERIEL EXPLOITATION
//         SumMontant := 0;
//         RecDetailRapportDG4.RESET;
//         RecDetailRapportDG4.SETRANGE("N° Rapport", NumRapport);
//         RecDetailRapportDG4.SETRANGE("Type Ligne", RecDetailRapportDG4."Type Ligne"::Materiel);
//         RecDetailRapportDG4.SETFILTER("Grande famille Materiel", '<>%1', 'CAMION');
//         IF RecDetailRapportDG4.FINDFIRST THEN
//             REPEAT
//                 SumMontant += RecDetailRapportDG4.Montant;
//             UNTIL RecDetailRapportDG4.NEXT = 0;
//         CLEAR(RecDetailRapportDG3);
//         Compteur += 1000;
//         RecDetailRapportDG3."N° Rapport" := NumRapport;
//         RecDetailRapportDG3.Marché := CodeMarché;
//         RecDetailRapportDG3."N° Ligne" := Compteur;
//         RecDetailRapportDG3."Type Ligne" := RecDetailRapportDG3."Type Ligne"::Bilan;
//         RecDetailRapportDG3."Date Rapport" := DateRapport;
//         RecDetailRapportDG3."Regroupement Bilan" := 'B04';
//         RecDetailRapportDG3.Designatiion := 'MATERIEL EXPLOITATION';
//         RecDetailRapportDG3.Montant := SumMontant;
//         IF TotalCharge <> 0 THEN RecDetailRapportDG3.Ratios := SumMontant / TotalCharge;
//         RecDetailRapportDG3.INSERT;


//         // SERVICE
//         SumMontant := 0;
//         RecDetailRapportDG4.RESET;
//         RecDetailRapportDG4.SETRANGE("N° Rapport", NumRapport);
//         RecDetailRapportDG4.SETRANGE("Type Ligne", RecDetailRapportDG4."Type Ligne"::"Frais Annexe");
//         IF RecDetailRapportDG4.FINDFIRST THEN
//             REPEAT
//                 SumMontant += RecDetailRapportDG4.Montant;
//             UNTIL RecDetailRapportDG4.NEXT = 0;
//         CLEAR(RecDetailRapportDG3);
//         Compteur += 1000;
//         RecDetailRapportDG3."N° Rapport" := NumRapport;
//         RecDetailRapportDG3.Marché := CodeMarché;
//         RecDetailRapportDG3."N° Ligne" := Compteur;
//         RecDetailRapportDG3."Type Ligne" := RecDetailRapportDG3."Type Ligne"::Bilan;
//         RecDetailRapportDG3."Date Rapport" := DateRapport;
//         RecDetailRapportDG3."Regroupement Bilan" := 'B08';
//         RecDetailRapportDG3.Designatiion := 'SERVICES';
//         RecDetailRapportDG3.Montant := SumMontant - ST;
//         IF TotalCharge <> 0 THEN RecDetailRapportDG3.Ratios := (SumMontant - ST) / TotalCharge;
//         RecDetailRapportDG3.INSERT;

//         // SOUS TRAITANCE
//         CLEAR(RecDetailRapportDG3);
//         Compteur += 1000;
//         RecDetailRapportDG3."N° Rapport" := NumRapport;
//         RecDetailRapportDG3.Marché := CodeMarché;
//         RecDetailRapportDG3."N° Ligne" := Compteur;
//         RecDetailRapportDG3."Type Ligne" := RecDetailRapportDG3."Type Ligne"::Bilan;
//         RecDetailRapportDG3."Date Rapport" := DateRapport;
//         RecDetailRapportDG3."Regroupement Bilan" := 'B08';
//         RecDetailRapportDG3.Designatiion := 'SOUS TRAITANCE';
//         RecDetailRapportDG3.Montant := ST;
//         IF TotalCharge <> 0 THEN RecDetailRapportDG3.Ratios := ST / TotalCharge;
//         RecDetailRapportDG3.INSERT;

//         // LOYER
//         SumMontant := 0;
//         RecDetailRapportDG4.RESET;
//         RecDetailRapportDG4.SETRANGE("N° Rapport", NumRapport);
//         RecDetailRapportDG4.SETRANGE("Type Ligne", RecDetailRapportDG4."Type Ligne"::Loyer);
//         IF RecDetailRapportDG4.FINDFIRST THEN
//             REPEAT
//                 SumMontant += RecDetailRapportDG4.Montant;
//             UNTIL RecDetailRapportDG4.NEXT = 0;
//         CLEAR(RecDetailRapportDG3);
//         Compteur += 1000;
//         RecDetailRapportDG3."N° Rapport" := NumRapport;
//         RecDetailRapportDG3.Marché := CodeMarché;
//         RecDetailRapportDG3."N° Ligne" := Compteur;
//         RecDetailRapportDG3."Type Ligne" := RecDetailRapportDG3."Type Ligne"::Bilan;
//         RecDetailRapportDG3."Date Rapport" := DateRapport;
//         RecDetailRapportDG3."Regroupement Bilan" := 'B13';
//         RecDetailRapportDG3.Designatiion := 'LOYER';
//         RecDetailRapportDG3.Montant := SumMontant;
//         IF TotalCharge <> 0 THEN RecDetailRapportDG3.Ratios := SumMontant / TotalCharge;
//         RecDetailRapportDG3.INSERT;

//         // PUCE TEL
//         SumMontant := 0;
//         RecDetailRapportDG4.RESET;
//         RecDetailRapportDG4.SETRANGE("N° Rapport", NumRapport);
//         RecDetailRapportDG4.SETRANGE("Type Ligne", RecDetailRapportDG4."Type Ligne"::"Puce TelePhonique");
//         IF RecDetailRapportDG4.FINDFIRST THEN
//             REPEAT
//                 SumMontant += RecDetailRapportDG4.Montant;
//             UNTIL RecDetailRapportDG4.NEXT = 0;
//         CLEAR(RecDetailRapportDG3);
//         Compteur += 1000;
//         RecDetailRapportDG3."N° Rapport" := NumRapport;
//         RecDetailRapportDG3.Marché := CodeMarché;
//         RecDetailRapportDG3."N° Ligne" := Compteur;
//         RecDetailRapportDG3."Type Ligne" := RecDetailRapportDG3."Type Ligne"::Bilan;
//         RecDetailRapportDG3."Date Rapport" := DateRapport;
//         RecDetailRapportDG3."Regroupement Bilan" := 'B14';
//         RecDetailRapportDG3.Designatiion := 'PUCE TELEPHONIQUE';
//         RecDetailRapportDG3.Montant := SumMontant;
//         IF TotalCharge <> 0 THEN RecDetailRapportDG3.Ratios := SumMontant / TotalCharge;
//         RecDetailRapportDG3.INSERT;
//     end;


//     procedure Bilanmateriaux(var NumRapport: Code[20]; var "CodeMarché": Code[20]; var DateRapport: Date)
//     var
//         RecDetailRapportDG3: Record "Detail Rapport DG";
//         RegroupementRapportDG: Record "Regroupement Rapport DG";
//         SumMontantMS: Decimal;
//         SumMontantGasoil: Decimal;
//         SumMontantMTransport: Decimal;
//         SumMontantMExploitation: Decimal;
//         SumMontantMService: Decimal;
//         SumMontant: Decimal;
//         SumMontantDecompte: Decimal;
//         SumMontantRevision: Decimal;
//         SumMontantresteAfacturer: Decimal;
//         SumMontantCharge: Decimal;
//         SumMontantCA: Decimal;
//     begin
//         RegroupementRapportDG.SETRANGE(Type, RegroupementRapportDG.Type::Bilan);
//         IF RegroupementRapportDG.FINDFIRST THEN
//             REPEAT
//                 SumMontant := 0;
//                 RecDetailRapportDG.RESET;
//                 RecDetailRapportDG.SETRANGE("N° Rapport", NumRapport);
//                 RecDetailRapportDG.SETRANGE("Regroupement Bilan", RegroupementRapportDG.Code);
//                 IF RecDetailRapportDG.FINDFIRST THEN
//                     REPEAT
//                         SumMontant += RecDetailRapportDG.Montant;
//                     UNTIL RecDetailRapportDG.NEXT = 0;
//                 CLEAR(RecDetailRapportDG3);
//                 Compteur += 1000;
//                 RecDetailRapportDG3."N° Rapport" := NumRapport;
//                 RecDetailRapportDG3.Marché := CodeMarché;
//                 RecDetailRapportDG3."N° Ligne" := Compteur;
//                 RecDetailRapportDG3."Type Ligne" := RecDetailRapportDG3."Type Ligne"::Bilan;
//                 RecDetailRapportDG3."Date Rapport" := DateRapport;
//                 RecDetailRapportDG3."Regroupement Bilan" := RegroupementRapportDG.Code;
//                 RecDetailRapportDG3.Designatiion := RegroupementRapportDG.Designation;
//                 RecDetailRapportDG3.Montant := SumMontant;
//                 IF TotalCharge <> 0 THEN RecDetailRapportDG3.Ratios := SumMontant / TotalCharge;
//                 RecDetailRapportDG3.Quantité := 0;
//                 IF SumMontant <> 0 THEN RecDetailRapportDG3.INSERT;

//             UNTIL RegroupementRapportDG.NEXT = 0;

//         // Decompte
//         SumMontantCA := 0;
//         IF NOT rec.Centrale THEN BEGIN
//             SumMontantDecompte := 0;
//             RecDetailRapportDG.RESET;
//             RecDetailRapportDG.SETRANGE("N° Rapport", NumRapport);
//             RecDetailRapportDG.SETRANGE("Type Ligne", RecDetailRapportDG."Type Ligne"::Decompte);
//             IF RecDetailRapportDG.FINDFIRST THEN
//                 REPEAT
//                     SumMontantDecompte += RecDetailRapportDG."Montant Decompte";
//                 UNTIL RecDetailRapportDG.NEXT = 0;
//             CLEAR(RecDetailRapportDG3);
//             Compteur += 1000;
//             RecDetailRapportDG3."N° Rapport" := NumRapport;
//             RecDetailRapportDG3.Marché := CodeMarché;
//             RecDetailRapportDG3."N° Ligne" := Compteur;
//             RecDetailRapportDG3."Type Ligne" := RecDetailRapportDG3."Type Ligne"::Resultat;
//             RecDetailRapportDG3."Date Rapport" := DateRapport;
//             RecDetailRapportDG3."Regroupement Bilan" := 'B90';
//             RecDetailRapportDG3.Designatiion := 'DECOMPTE';
//             RecDetailRapportDG3.Montant := SumMontantDecompte;
//             RecDetailRapportDG3.Quantité := 0;
//             RecDetailRapportDG3.INSERT;
//         END
//         ELSE BEGIN
//             SumMontantDecompte := 0;
//             RecDetailRapportDG.RESET;
//             RecDetailRapportDG.SETRANGE("N° Rapport", NumRapport);
//             RecDetailRapportDG.SETRANGE("Type Ligne", RecDetailRapportDG."Type Ligne"::Decompte);
//             IF RecDetailRapportDG.FINDFIRST THEN
//                 REPEAT
//                     SumMontantCA := RecDetailRapportDG."Montant Decompte";
//                     SumMontantDecompte += RecDetailRapportDG."Montant Decompte";
//                     CLEAR(RecDetailRapportDG3);
//                     Compteur += 1000;
//                     RecDetailRapportDG3."N° Rapport" := NumRapport;
//                     RecDetailRapportDG3.Marché := CodeMarché;
//                     RecDetailRapportDG3."N° Ligne" := Compteur;
//                     RecDetailRapportDG3."Type Ligne" := RecDetailRapportDG3."Type Ligne"::Resultat;
//                     RecDetailRapportDG3."Date Rapport" := DateRapport;
//                     RecDetailRapportDG3."Regroupement Bilan" := 'B90';
//                     RecDetailRapportDG3.Designatiion := RecDetailRapportDG.Designatiion;
//                     RecDetailRapportDG3.Montant := SumMontantCA;
//                     RecDetailRapportDG3.Quantité := 0;
//                     RecDetailRapportDG3.INSERT;

//                 UNTIL RecDetailRapportDG.NEXT = 0;
//             CLEAR(RecDetailRapportDG3);
//             Compteur += 1000;
//             RecDetailRapportDG3."N° Rapport" := NumRapport;
//             RecDetailRapportDG3.Marché := CodeMarché;
//             RecDetailRapportDG3."N° Ligne" := Compteur;
//             RecDetailRapportDG3."Type Ligne" := RecDetailRapportDG3."Type Ligne"::Resultat;
//             RecDetailRapportDG3."Date Rapport" := DateRapport;
//             RecDetailRapportDG3."Regroupement Bilan" := 'B91';
//             RecDetailRapportDG3.Designatiion := ' ----- TOTAL PRODUIT :';
//             RecDetailRapportDG3.Montant := SumMontantDecompte;
//             RecDetailRapportDG3.Quantité := 0;
//             RecDetailRapportDG3.INSERT;

//         END;
//         // Revision
//         SumMontantRevision := 0;
//         RecDetailRapportDG.RESET;
//         RecDetailRapportDG.SETRANGE("N° Rapport", NumRapport);
//         RecDetailRapportDG.SETRANGE("Type Ligne", RecDetailRapportDG."Type Ligne"::"Revision Prix");
//         IF RecDetailRapportDG.FINDFIRST THEN
//             REPEAT
//                 SumMontantRevision += RecDetailRapportDG.Montant;
//             UNTIL RecDetailRapportDG.NEXT = 0;
//         CLEAR(RecDetailRapportDG3);
//         Compteur += 1000;
//         RecDetailRapportDG3."N° Rapport" := NumRapport;
//         RecDetailRapportDG3.Marché := CodeMarché;
//         RecDetailRapportDG3."N° Ligne" := Compteur;
//         RecDetailRapportDG3."Type Ligne" := RecDetailRapportDG3."Type Ligne"::Resultat;
//         RecDetailRapportDG3."Date Rapport" := DateRapport;
//         RecDetailRapportDG3."Regroupement Bilan" := 'B91';
//         RecDetailRapportDG3.Designatiion := 'REVISIONS PRIX';
//         RecDetailRapportDG3.Montant := SumMontantRevision;
//         RecDetailRapportDG3.Quantité := 0;
//         RecDetailRapportDG3.INSERT;

//         // Reste a facturer
//         SumMontantresteAfacturer := 0;
//         RecDetailRapportDG.RESET;
//         RecDetailRapportDG.SETRANGE("N° Rapport", NumRapport);
//         RecDetailRapportDG.SETFILTER("Montant Diff", '<%1', 0);
//         RecDetailRapportDG.SETRANGE("Non Inclu Reste à facturer", FALSE);
//         IF RecDetailRapportDG.FINDFIRST THEN
//             REPEAT
//                 SumMontantresteAfacturer += RecDetailRapportDG."Montant Diff";
//             UNTIL RecDetailRapportDG.NEXT = 0;
//         CLEAR(RecDetailRapportDG3);
//         Compteur += 1000;
//         RecDetailRapportDG3."N° Rapport" := NumRapport;
//         RecDetailRapportDG3.Marché := CodeMarché;
//         RecDetailRapportDG3."N° Ligne" := Compteur;
//         RecDetailRapportDG3."Type Ligne" := RecDetailRapportDG3."Type Ligne"::Resultat;
//         RecDetailRapportDG3."Date Rapport" := DateRapport;
//         RecDetailRapportDG3."Regroupement Bilan" := 'B92';
//         RecDetailRapportDG3.Designatiion := 'RESTE A FACTURER';
//         RecDetailRapportDG3.Montant := ABS(SumMontantresteAfacturer);
//         RecDetailRapportDG3.Quantité := 0;
//         RecDetailRapportDG3.INSERT;

//         // Charge
//         SumMontantCharge := 0;
//         RecDetailRapportDG.RESET;
//         RecDetailRapportDG.SETRANGE("N° Rapport", NumRapport);
//         IF RecDetailRapportDG.FINDFIRST THEN
//             REPEAT
//                 IF (RecDetailRapportDG."Type Ligne" = RecDetailRapportDG."Type Ligne"::Materiaux)
//                 OR (RecDetailRapportDG."Type Ligne" = RecDetailRapportDG."Type Ligne"::Materiel)
//                 OR (RecDetailRapportDG."Type Ligne" = RecDetailRapportDG."Type Ligne"::MO)
//                 OR (RecDetailRapportDG."Type Ligne" = RecDetailRapportDG."Type Ligne"::Gasoil)
//                 OR (RecDetailRapportDG."Type Ligne" = RecDetailRapportDG."Type Ligne"::Loyer)
//                 OR (RecDetailRapportDG."Type Ligne" = RecDetailRapportDG."Type Ligne"::"Puce TelePhonique")
//                 OR (RecDetailRapportDG."Type Ligne" = RecDetailRapportDG."Type Ligne"::"Frais Annexe")
//                 OR (RecDetailRapportDG."Type Ligne" = RecDetailRapportDG."Type Ligne"::Divers) THEN
//                     SumMontantCharge += RecDetailRapportDG.Montant + RecDetailRapportDG."MS Cumulée";
//             UNTIL RecDetailRapportDG.NEXT = 0;
//         CLEAR(RecDetailRapportDG3);
//         Compteur += 1000;
//         RecDetailRapportDG3."N° Rapport" := NumRapport;
//         RecDetailRapportDG3.Marché := CodeMarché;
//         RecDetailRapportDG3."N° Ligne" := Compteur;
//         RecDetailRapportDG3."Type Ligne" := RecDetailRapportDG3."Type Ligne"::Resultat;
//         RecDetailRapportDG3."Date Rapport" := DateRapport;
//         RecDetailRapportDG3."Regroupement Bilan" := 'B93';
//         RecDetailRapportDG3.Designatiion := 'CHARGE';
//         RecDetailRapportDG3.Montant := -SumMontantCharge;
//         RecDetailRapportDG3.Quantité := 0;
//         RecDetailRapportDG3.INSERT;


//         //Resultat
//         CLEAR(RecDetailRapportDG3);
//         Compteur += 1000;
//         RecDetailRapportDG3."N° Rapport" := NumRapport;
//         RecDetailRapportDG3.Marché := CodeMarché;
//         RecDetailRapportDG3."N° Ligne" := Compteur;
//         RecDetailRapportDG3."Type Ligne" := RecDetailRapportDG3."Type Ligne"::Resultat;
//         RecDetailRapportDG3."Date Rapport" := DateRapport;
//         RecDetailRapportDG3."Regroupement Bilan" := 'B99';
//         RecDetailRapportDG3.Designatiion := 'RESULTAT';
//         RecDetailRapportDG3.Montant := SumMontantDecompte + SumMontantRevision + ABS(SumMontantresteAfacturer) - SumMontantCharge;
//         RecDetailRapportDG3.Quantité := 0;
//         RecDetailRapportDG3.INSERT;
//     end;


//     procedure Archiver()
//     begin
//         DetailRapportDGArchive.SETRANGE("N° Rapport", rec."N° Rapport");
//         DetailRapportDGArchive.SETRANGE("Date Rapport", rec."Date Rapport");
//         DetailRapportDGArchive.DELETEALL;
//         DetailRapportDGArchive.RESET;
//         DetailRapportDG.SETRANGE("N° Rapport", rec."N° Rapport");
//         DetailRapportDG.SETRANGE("Date Rapport", xRec."Date Rapport");
//         IF DetailRapportDG.FINDFIRST THEN
//             REPEAT
//                 DetailRapportDGArchive.TRANSFERFIELDS(DetailRapportDG);
//                 DetailRapportDGArchive.INSERT;
//             UNTIL DetailRapportDG.NEXT = 0;
//     end;


//     procedure "GetQteExeuté"(var NumCommande: Code[20]; var CodeArticle: Code[20]; DateRapport: Date) QteExec: Decimal
//     var
//         SalesShipmentHeader: Record "Sales Shipment Header";
//         SalesShipmentLine: Record "Sales Shipment Line";
//         Quantite: Decimal;
//     begin
//         QteExec := 0;
//         SalesShipmentHeader.SETRANGE("Order No.", NumCommande);
//         SalesShipmentHeader.SETFILTER("Date Debut Decompte", '<=%1', DateRapport);
//         IF SalesShipmentHeader.FINDFIRST THEN
//             REPEAT
//                 SalesShipmentLine.SETRANGE("Document No.", SalesShipmentHeader."No.");
//                 SalesShipmentLine.SETRANGE("No.", CodeArticle);
//                 IF SalesShipmentLine.FINDFIRST THEN
//                     REPEAT
//                         QteExec += SalesShipmentLine.Quantity;
//                     UNTIL SalesShipmentLine.NEXT = 0;
//             UNTIL SalesShipmentHeader.NEXT = 0;
//         EXIT(QteExec);
//     end;


//     procedure MateriauxCentrale(var NumRapport: Code[20]; var "CodeMarché": Code[20]; DateRapport: Date)
//     var
//         "Quantité": Decimal;
//         DetailsConsommationBLBeton: Record "Details Consommation BL Beton";
//         BLCarriere: Record "BL Carriere";
//         MateriauxBLBeton: Record "Materiaux BL Beton";
//         RecItem: Record Item;
//     begin
//         CLEAR(RecDetailRapportDG);
//         Quantité := 0;
//         MateriauxBLBeton.RESET;
//         IF MateriauxBLBeton.FINDFIRST THEN
//             REPEAT
//                 Compteur += 1000;
//                 Quantité := 0;
//                 DetailsConsommationBLBeton.RESET;
//                 DetailsConsommationBLBeton.SETCURRENTKEY(Mat_Code);
//                 DetailsConsommationBLBeton.SETRANGE(DetailsConsommationBLBeton.Mat_Code, MateriauxBLBeton.Mat_Code);
//                 DetailsConsommationBLBeton.SETRANGE(DetailsConsommationBLBeton."Date BL", DateDebut, DateFin);
//                 IF DetailsConsommationBLBeton.FINDFIRST THEN
//                     REPEAT
//                         DetailsConsommationBLBeton.CALCFIELDS(DetailsConsommationBLBeton."Date BL");
//                         Quantité := Quantité + DetailsConsommationBLBeton.Quantité;
//                     UNTIL DetailsConsommationBLBeton.NEXT = 0;

//                 IF Quantité > 0 THEN BEGIN
//                     RecItem.RESET;
//                     RecItem.SETRANGE("No.", MateriauxBLBeton.Correspondance);
//                     IF RecItem.FINDFIRST THEN;
//                     CLEAR(RecDetailRapportDG);
//                     RecDetailRapportDG."N° Rapport" := NumRapport;
//                     RecDetailRapportDG.Marché := CodeMarché;
//                     RecDetailRapportDG."Date Rapport" := DateRapport;
//                     RecDetailRapportDG.Designatiion := UPPERCASE(RecItem.Description);
//                     RecDetailRapportDG."N° Ligne" := Compteur;
//                     RecDetailRapportDG."Prix Unitaire Moy  Marché" := RecItem."Last Direct Cost";
//                     IF MateriauxBLBeton.Mat_Unité = 'KG' THEN BEGIN
//                         RecDetailRapportDG."Quantité Livré" := Quantité / 1000;
//                         RecDetailRapportDG.Montant := RecItem."Last Direct Cost" * (Quantité / 1000);
//                     END
//                     ELSE BEGIN
//                         RecDetailRapportDG."Quantité Livré" := Quantité;
//                         RecDetailRapportDG.Montant := RecItem."Last Direct Cost" * Quantité;
//                     END;
//                     IF RecDetailRapportDG.INSERT THEN;
//                 END;

//             UNTIL MateriauxBLBeton.NEXT = 0;
//     end;


//     procedure GasoilCentrale(var NumRapport: Code[20]; var "CodeMarché": Code[20]; DateRapport: Date)
//     var
//         LigneFicheGasoil: Record "Ligne Fiche Gasoil";
//         "SumQuantitéGasoil": Decimal;
//     begin
//         CLEAR(RecDetailRapportDG);
//         Compteur += 1000;
//         SumQuantitéGasoil := 0;
//         LigneFicheGasoil.RESET;
//         LigneFicheGasoil.SETCURRENTKEY(Journee);
//         LigneFicheGasoil.SETFILTER(Affaire, CodeMarché + '*');
//         LigneFicheGasoil.SETRANGE(Statut, 1);
//         LigneFicheGasoil.SETFILTER(Materiel, '<>%1', '');
//         LigneFicheGasoil.SETRANGE(Journee, DateDebut, DateFin);
//         IF LigneFicheGasoil.FINDFIRST THEN
//             REPEAT
//                 SumQuantitéGasoil += LigneFicheGasoil."Quantité Gasoil";
//             UNTIL LigneFicheGasoil.NEXT = 0;
//         CLEAR(RecDetailRapportDG);
//         RecDetailRapportDG."Type Ligne" := RecDetailRapportDG."Type Ligne"::Gasoil;
//         RecDetailRapportDG."N° Rapport" := NumRapport;
//         RecDetailRapportDG.Marché := CodeMarché;
//         RecDetailRapportDG."Date Rapport" := DateRapport;
//         RecDetailRapportDG.Designatiion := 'GASOIL';
//         RecDetailRapportDG.Montant := SumQuantitéGasoil * rec."Prix Gasoil";
//         RecDetailRapportDG.Niveau := 1;
//         RecDetailRapportDG."N° Ligne" := Compteur;
//         RecDetailRapportDG."Quantité Livré" := SumQuantitéGasoil;
//         IF RecDetailRapportDG.INSERT THEN;
//     end;


//     procedure MaterielCentral(var NumRapport: Code[20]; var "CodeMarché": Code[20]; DateRapport: Date)
//     var
//         LignePointageVehicule: Record "Ligne Pointage Vehicule";
//         "Véhicule": Record "Véhicule";
//         "GenreVéhicule": Record "Genre Véhicule";
//         NbrF: Integer;
//         NbrD: Integer;
//         NbrP: Integer;
//         NbrC: Integer;
//         NbrMT: Integer;
//         NbrRF: Integer;
//         GrandeFamilleTmp: Code[20];
//         Pointeur: Integer;
//         CoutLocation: Decimal;
//         Tmp: Record tempo01;
//         i: Integer;
//     begin
//         CLEAR(RecDetailRapportDG);
//         IF GenreVéhicule.FINDFIRST THEN
//             REPEAT
//                 NbrF := 0;
//                 NbrD := 0;
//                 NbrP := 0;
//                 NbrC := 0;
//                 NbrMT := 0;
//                 NbrRF := 0;
//                 CoutLocation := 0;
//                 LignePointageVehicule.RESET;
//                 LignePointageVehicule.SETCURRENTKEY("Grande Famille");
//                 LignePointageVehicule.SETFILTER(Chantier, CodeMarché + '*');
//                 // LignePointageVehicule.SETRANGE(Vehicule,'BD-001');

//                 LignePointageVehicule.SETRANGE("Grande Famille", GenreVéhicule."Code Genre");
//                 LignePointageVehicule.SETRANGE("Statut Entete", 1);
//                 LignePointageVehicule.SETRANGE(Journee, DateDebut, DateFin);
//                 IF LignePointageVehicule.FINDFIRST THEN
//                     // BEGIN
//                     REPEAT
//                         IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Fonctionnel THEN BEGIN
//                             NbrF += 1;
//                             IF Véhicule.GET(LignePointageVehicule.Vehicule) THEN
//                                 CoutLocation += Véhicule."Cout Location Journaliere";
//                         END;
//                         IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Disponible THEN NbrD += 1;
//                         IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Panne THEN NbrP += 1;
//                         IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Conger THEN NbrC += 1;
//                         IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::"Mauvais Temps" THEN NbrMT += 1;
//                         IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Reformer THEN NbrRF += 1;

//                     UNTIL LignePointageVehicule.NEXT = 0;

//                 Compteur += 1000;
//                 // CLEAR(RecDetailRapportDG);
//                 RecDetailRapportDG."Type Ligne" := RecDetailRapportDG."Type Ligne"::Materiel;
//                 RecDetailRapportDG."N° Rapport" := NumRapport;
//                 RecDetailRapportDG.Marché := CodeMarché;
//                 RecDetailRapportDG."Date Rapport" := DateRapport;
//                 RecDetailRapportDG.Designatiion := UPPERCASE(GenreVéhicule."Code Genre");
//                 RecDetailRapportDG.Niveau := 1;
//                 RecDetailRapportDG."N° Ligne" := Compteur;
//                 RecDetailRapportDG."Nombre F" := NbrF;
//                 RecDetailRapportDG."Nombre P" := NbrP;
//                 RecDetailRapportDG."Nombre D" := NbrD;
//                 RecDetailRapportDG."Nombre C" := NbrC;
//                 RecDetailRapportDG."Nombre Ref" := NbrRF;
//                 RecDetailRapportDG."Nombre M.T" := NbrMT;
//                 RecDetailRapportDG."Grande famille Materiel" := GenreVéhicule."Code Genre";
//                 RecDetailRapportDG.Montant := CoutLocation;
//                 IF RecDetailRapportDG.Montant <> 0 THEN RecDetailRapportDG.INSERT;
//             //  END;

//             UNTIL GenreVéhicule.NEXT = 0;
//     end;


//     procedure DecompteCentrale(var NumRapport: Code[20]; var "CodeMarché": Code[10]; DateRapport: Date; var CodeCorrespandance: Text[30])
//     var
//         TempBeton: Record "Temp Beton";
//         SalesLine: Record "Sales Line";
//         PrixLigne: Decimal;
//         "Quantité": Decimal;
//         TotalHT: Decimal;
//         SalesInvoiceLine: Record "Sales Invoice Line";
//         SalesPrice: Record "Sales Price";
//         SalesLine2: Record "Sales Line";
//     begin
//         CLEAR(RecDetailRapportDG);
//         Quantité := 0;
//         TotalHT := 0;

//         // ****************** Commande vente Interne Client Divers

//         SalesLine.RESET;
//         SalesLine.SETRANGE("Date Comptabilisation", DateDebut, DateFin);
//         SalesLine.SETRANGE("Sell-to Customer No.", 'CPV-0999');
//         SalesLine.SETFILTER("Job No.", '=%1', CodeCorrespandance);
//         IF SalesLine.FINDFIRST THEN
//             REPEAT
//                 PrixLigne := 0;
//                 PrixLigne := SalesLine."Unit Price" * SalesLine.Quantity;
//                 TotalHT := TotalHT + PrixLigne;
//             UNTIL SalesLine.NEXT = 0;

//         Compteur += 1000;
//         CLEAR(RecDetailRapportDG);
//         RecDetailRapportDG."Type Ligne" := RecDetailRapportDG."Type Ligne"::Decompte;
//         RecDetailRapportDG."N° Rapport" := NumRapport;
//         RecDetailRapportDG.Marché := CodeMarché;
//         RecDetailRapportDG."Date Rapport" := DateRapport;
//         RecDetailRapportDG."Date Mise a Jour" := rec."Date Rapport";
//         RecDetailRapportDG.Designatiion := 'CA CLIENTS INTERNES PASSAGERS';
//         RecDetailRapportDG."N° Ligne" := Compteur;
//         RecDetailRapportDG."Quantité Livré" := Quantité;
//         RecDetailRapportDG.Montant := 0;
//         RecDetailRapportDG."Montant Decompte" := TotalHT;
//         IF RecDetailRapportDG.INSERT THEN;
//         TotalHT := 0;
//         // ****************** Commande vente Interne Client Divers

//         // ****************** Commande vente Interne Chantier

//         SalesLine2.RESET;
//         SalesLine2.SETRANGE("Date Comptabilisation", DateDebut, DateFin);
//         SalesLine2.SETFILTER("Sell-to Customer No.", '<>%1', 'CPV-0999');
//         SalesLine2.SETFILTER("Job No.", '=%1', CodeCorrespandance);
//         IF SalesLine2.FINDFIRST THEN
//             REPEAT
//                 SalesPrice.RESET;
//                 SalesPrice.SETRANGE("Item No.", SalesLine2."No.");
//                 IF SalesPrice.FINDFIRST THEN BEGIN
//                     PrixLigne := 0;
//                     PrixLigne := SalesPrice."Unit Price" * SalesLine2.Quantity;
//                 END;
//                 TotalHT := TotalHT + PrixLigne;
//             UNTIL SalesLine2.NEXT = 0;
//         Compteur += 1000;
//         CLEAR(RecDetailRapportDG);
//         RecDetailRapportDG."Type Ligne" := RecDetailRapportDG."Type Ligne"::Decompte;
//         RecDetailRapportDG."N° Rapport" := NumRapport;
//         RecDetailRapportDG.Marché := CodeMarché;
//         RecDetailRapportDG."Date Rapport" := DateRapport;
//         RecDetailRapportDG.Designatiion := 'CA CLIENTS INTERNES CHANTIERS';
//         RecDetailRapportDG."N° Ligne" := Compteur;
//         RecDetailRapportDG."Quantité Livré" := Quantité;
//         RecDetailRapportDG.Montant := 0;
//         RecDetailRapportDG."Montant Decompte" := TotalHT;
//         IF RecDetailRapportDG.INSERT THEN;
//         TotalHT := 0;

//         // ****************** Commande vente Interne Chantier

//         // **************** Fature Vente Enregistrée

//         SalesInvoiceLine.RESET;
//         SalesInvoiceLine.SETRANGE("Posting Date", DateDebut, DateFin);
//         SalesInvoiceLine.SETFILTER("Job No.", '=%1', CodeCorrespandance);
//         IF SalesInvoiceLine.FINDFIRST THEN
//             REPEAT
//                 PrixLigne := 0;
//                 PrixLigne := SalesInvoiceLine."Unit Price" * SalesInvoiceLine.Quantity;
//                 TotalHT := TotalHT + PrixLigne;
//             UNTIL SalesInvoiceLine.NEXT = 0;

//         // **************** Fature Vente Enregistrée
//         Compteur += 1000;
//         CLEAR(RecDetailRapportDG);
//         RecDetailRapportDG."Type Ligne" := RecDetailRapportDG."Type Ligne"::Decompte;
//         RecDetailRapportDG."N° Rapport" := NumRapport;
//         RecDetailRapportDG.Marché := CodeMarché;
//         RecDetailRapportDG."Date Rapport" := DateRapport;
//         RecDetailRapportDG.Designatiion := 'CA CLIENTS FACTURÉS';
//         RecDetailRapportDG."N° Ligne" := Compteur;
//         RecDetailRapportDG."Quantité Livré" := Quantité;
//         RecDetailRapportDG.Montant := 0;
//         RecDetailRapportDG."Montant Decompte" := TotalHT;
//         IF RecDetailRapportDG.INSERT THEN;
//     end;


//     procedure MSRLCentrale(var NumRapport: Code[20]; var "CodeMarché": Code[20]; DateRapport: Date)
//     var
//         LignePointageVehicule: Record "Ligne Pointage Vehicule";
//         BonReglement: record "Bon Reglement";
//         STC: Record "STC Salaries";
//         Complement: Record "Detail Complement";
//         MS: Decimal;
//         MS1: Decimal;
//         MSActuelle: Decimal;
//         Effectif: Integer;
//         "MSCumulées": Decimal;
//         "JoursPayés": Decimal;
//         RecSalaryLines: Record "Rec. Salary Lines";
//         LAnnee: Integer;
//         LMois: Integer;
//         DatePaie: Date;
//         DernierePaie: Code[20];
//     begin
//         CLEAR(RecDetailRapportDG);
//         Compteur += 1000;
//         Effectif := 0;
//         MS := 0;
//         MSCumulées := 0;
//         MSActuelle := 0;
//         JoursPayés := 0;
//         // Derniere Paie Avant Date Rapport
//         IF DATE2DWY(DateRapport, 2) = 12 THEN
//             LAnnee := DATE2DMY(DateRapport, 3) - 1
//         ELSE
//             LAnnee := DATE2DMY(DateRapport, 3);
//         LMois := DATE2DMY(DateRapport, 2);
//         //Actuelle
//         // Actuelle
//         RecSalaryLines.RESET;
//         RecSalaryLines.SETCURRENTKEY(Month, Year, Employee);
//         RecSalaryLines.SETFILTER(Chantier, CodeMarché + '*');
//         RecSalaryLines.SETRANGE(Year, LAnnee);
//         RecSalaryLines.SETRANGE(Month, LMois - 1);
//         IF RecSalaryLines.FINDFIRST THEN
//             REPEAT
//                 MS := RecSalaryLines."Gross Salary" * 1.2337;
//                 IF COPYSTR(RecSalaryLines.Catégorie, 1, 2) = 'SV' THEN MS := RecSalaryLines."Gross Salary";
//                 IF COPYSTR(RecSalaryLines.Catégorie, 1, 2) = 'KR' THEN MS := RecSalaryLines."Gross Salary" * 1.073;
//                 MSCumulées += MS;
//                 Effectif += 1;
//                 JoursPayés += RecSalaryLines."Paied days";
//             UNTIL RecSalaryLines.NEXT = 0;
//         // Annee En Cours
//         MS := 0;
//         BonReglement.RESET;
//         BonReglement.SETFILTER(Chantier, CodeMarché + '*');
//         BonReglement.SETRANGE(Annee, LAnnee);
//         BonReglement.SETRANGE(Mois, LMois);
//         IF BonReglement.FINDFIRST THEN
//             REPEAT
//                 MSCumulées += BonReglement."Net à Payer";
//             UNTIL BonReglement.NEXT = 0;

//         //COMPLEMENT
//         // Annee En Cours
//         MS := 0;
//         Complement.RESET;
//         Complement.SETFILTER(Chantier, CodeMarché + '*');
//         Complement.SETRANGE(Annee, LAnnee);
//         Complement.SETRANGE(Mois, LMois);
//         IF Complement.FINDFIRST THEN
//             REPEAT
//                 MSActuelle += Complement."Montant Complement";
//             UNTIL Complement.NEXT = 0;
//         //STC
//         // Annee En Cours
//         MS := 0;
//         STC.RESET;
//         STC.SETFILTER(Chantier, CodeMarché + '*');
//         STC.SETRANGE(Annee, LAnnee);
//         STC.SETRANGE(Mois, LMois - 1);
//         IF STC.FINDFIRST THEN
//             REPEAT
//                 MSCumulées += STC."Net A Payer";
//             UNTIL STC.NEXT = 0;
//         CLEAR(RecDetailRapportDG);
//         RecDetailRapportDG."Type Ligne" := RecDetailRapportDG."Type Ligne"::MO;
//         RecDetailRapportDG."N° Rapport" := NumRapport;
//         RecDetailRapportDG.Marché := CodeMarché;
//         RecDetailRapportDG."Date Rapport" := DateRapport;
//         RecDetailRapportDG.Designatiion := 'MASSE SALARIALE';
//         RecDetailRapportDG.Niveau := 1;
//         RecDetailRapportDG."N° Ligne" := Compteur;
//         RecDetailRapportDG."Quantité Livré" := 0;
//         RecDetailRapportDG."MS Actuelle" := MSActuelle;
//         RecDetailRapportDG."MS Cumulée" := MSCumulées;
//         RecDetailRapportDG.Effectif := Effectif;
//         RecDetailRapportDG."Jours Payés" := JoursPayés;
//         IF RecDetailRapportDG.INSERT THEN;
//     end;


//     procedure DiversCentrale(var NumRapport: Code[20]; var "CodeMarché": Code[20]; var DateRapport: Date)
//     var
//         Boucle: Integer;
//         SumMontantCharge: Decimal;
//     begin
//         // Charge
//         SumMontantCharge := 0;
//         RecDetailRapportDG.RESET;
//         RecDetailRapportDG.SETRANGE("N° Rapport", NumRapport);
//         IF RecDetailRapportDG.FINDFIRST THEN
//             REPEAT
//                 IF (RecDetailRapportDG."Type Ligne" = RecDetailRapportDG."Type Ligne"::Materiaux)
//                 OR (RecDetailRapportDG."Type Ligne" = RecDetailRapportDG."Type Ligne"::Materiel)
//                 OR (RecDetailRapportDG."Type Ligne" = RecDetailRapportDG."Type Ligne"::MO)
//                 OR (RecDetailRapportDG."Type Ligne" = RecDetailRapportDG."Type Ligne"::Gasoil)
//                 OR (RecDetailRapportDG."Type Ligne" = RecDetailRapportDG."Type Ligne"::Loyer)
//                 OR (RecDetailRapportDG."Type Ligne" = RecDetailRapportDG."Type Ligne"::"Puce TelePhonique")
//                 OR (RecDetailRapportDG."Type Ligne" = RecDetailRapportDG."Type Ligne"::"Frais Annexe") THEN
//                     SumMontantCharge += RecDetailRapportDG.Montant + RecDetailRapportDG."MS Cumulée";
//             UNTIL RecDetailRapportDG.NEXT = 0;
//         // LOCATION CENTRALE
//         CLEAR(RecDetailRapportDG);
//         Compteur += 1000;
//         RecDetailRapportDG."Type Ligne" := RecDetailRapportDG."Type Ligne"::Divers;
//         RecDetailRapportDG."N° Rapport" := NumRapport;
//         RecDetailRapportDG.Marché := CodeMarché;
//         RecDetailRapportDG."Date Rapport" := DateRapport;
//         RecDetailRapportDG.Designatiion := 'LOCATION CENTRALE';
//         RecDetailRapportDG.Niveau := 1;
//         RecDetailRapportDG."N° Ligne" := Compteur;
//         RecDetailRapportDG.Montant := 700 * (DateFin - DateDebut);
//         RecDetailRapportDG."Reste a Facturer" := FALSE;
//         IF RecDetailRapportDG.INSERT THEN;
//         // LOCATION CENTRALE
//         CLEAR(RecDetailRapportDG);
//         Compteur += 1000;
//         RecDetailRapportDG."Type Ligne" := RecDetailRapportDG."Type Ligne"::Divers;
//         RecDetailRapportDG."N° Rapport" := NumRapport;
//         RecDetailRapportDG.Marché := CodeMarché;
//         RecDetailRapportDG."Date Rapport" := DateRapport;
//         RecDetailRapportDG.Designatiion := 'LOCATION TERRAIN';
//         RecDetailRapportDG.Niveau := 1;
//         RecDetailRapportDG."N° Ligne" := Compteur;
//         RecDetailRapportDG.Montant := rec."Cout Location Terrain";
//         RecDetailRapportDG."Reste a Facturer" := FALSE;
//         IF RecDetailRapportDG.INSERT THEN;

//         // FRAIS DE SIEGE
//         Compteur += 1000;
//         CLEAR(RecDetailRapportDG);
//         RecDetailRapportDG."Type Ligne" := RecDetailRapportDG."Type Ligne"::Divers;
//         RecDetailRapportDG."N° Rapport" := NumRapport;
//         RecDetailRapportDG.Marché := CodeMarché;
//         RecDetailRapportDG."Date Rapport" := DateRapport;
//         RecDetailRapportDG.Designatiion := 'FRAIS SIEGE (3%)';
//         RecDetailRapportDG.Niveau := 1;
//         RecDetailRapportDG."N° Ligne" := Compteur;
//         RecDetailRapportDG.Montant := ROUND((SumMontantCharge + 700 * (DateFin - DateDebut) + rec."Cout Location Terrain") * 0.03, 1);
//         RecDetailRapportDG."Reste a Facturer" := FALSE;
//         IF RecDetailRapportDG.INSERT THEN;
//     end;


//     procedure MateriauxDivers(var NumRapport: Code[20]; var "CodeMarché": Code[20]; DateRapport: Date)
//     var
//         RecItemLedgerEntry: Record "Item Ledger Entry";
//         ValueEntry: Record "Value Entry";
//         RecCorrespondanRapportDG: Record "Correspondan Rapport DG";
//         RegroupementRapportDG: Record "Regroupement Rapport DG";
//         RegroupementRapportDG2: Record "Regroupement Rapport DG";
//         SalesHeader: Record "Sales Header";
//         SalesLine: Record "Sales Line";
//         "SumQuantitéMarché": Decimal;
//         "QuantitéMarché": Decimal;
//         "QuantitéExécuté": Decimal;
//         "SumQuantitéExécuté": Decimal;
//         "SumQuantitéMateriaux": Decimal;
//         "SumMontantMarché": Decimal;
//         Item: Record Item;
//         "Quantité": Decimal;
//         Cout: Decimal;
//         Difference: Decimal;
//         tmp01: Record tempo01;
//     begin
//         CLEAR(RecDetailRapportDG);
//         Quantité := 0;
//         Cout := 0;
//         RegroupementRapportDG.SETRANGE(Chantier, CodeMarché);
//         RegroupementRapportDG.SETRANGE(Type, RegroupementRapportDG.Type::"Nouvelle Entrée");
//         RegroupementRapportDG.SETRANGE(Integer, TRUE);
//         //RecCorrespondanRapportDG.SETFILTER("Correspandance Article",'%1','PC-11-09-0004|PC-11-09-0008|PC-11-09-0007');
//         IF RegroupementRapportDG.FINDFIRST THEN
//             REPEAT
//                 RegroupementRapportDG2.SETRANGE(Chantier, CodeMarché);
//                 RegroupementRapportDG2.SETRANGE(Type, RegroupementRapportDG.Type::Materiaux);
//                 RegroupementRapportDG2.SETRANGE(Code, RegroupementRapportDG.Code);
//                 IF NOT RegroupementRapportDG2.FINDFIRST THEN BEGIN
//                     Compteur += 1000;
//                     SumQuantitéMateriaux := 0;
//                     RecItemLedgerEntry.RESET;
//                     RecItemLedgerEntry.SETCURRENTKEY("Posting Date", Famille, "N° Véhicule", "Entry Type", "Item No.");
//                     RecItemLedgerEntry.SETFILTER("Job No.", CodeMarché + '*');
//                     RecItemLedgerEntry.SETFILTER("Item No.", RegroupementRapportDG.Code);
//                     RecItemLedgerEntry.SETFILTER("Posting Date", '<=%1', DateRapport);
//                     RecItemLedgerEntry.SETFILTER("Entry Type", '%1|%2', RecItemLedgerEntry."Entry Type"::Purchase,
//                                                  RecItemLedgerEntry."Entry Type"::Output);
//                     IF RecItemLedgerEntry.FINDFIRST THEN
//                         REPEAT
//                             ValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Entry Type");
//                             ValueEntry.SETRANGE("Item Ledger Entry No.", RecItemLedgerEntry."Entry No.");
//                             IF ValueEntry.FINDFIRST THEN BEGIN
//                                 Cout += RecItemLedgerEntry.Quantity * ValueEntry."Cost per Unit";
//                             END;
//                         UNTIL RecItemLedgerEntry.NEXT = 0;


//                 END;
//             UNTIL RegroupementRapportDG.NEXT = 0;
//         CLEAR(RecDetailRapportDG);
//         RecDetailRapportDG."N° Rapport" := NumRapport;
//         RecDetailRapportDG.Marché := CodeMarché;
//         RecDetailRapportDG."Date Rapport" := DateRapport;
//         RecDetailRapportDG."Type Ligne" := RecDetailRapportDG."Type Ligne"::Materiaux;
//         RecDetailRapportDG.Designatiion := 'DIVERS MATERIAUX';
//         RecDetailRapportDG.Niveau := RecCorrespondanRapportDG.Niveau;
//         RecDetailRapportDG."Regroupement Bilan" := 'B15';
//         RecDetailRapportDG."N° Ligne" := Compteur;
//         RecDetailRapportDG.Montant := Cout;
//         RecDetailRapportDG."Quantité Livré" := 0;
//         RecDetailRapportDG."Quantité Origine" := 0;
//         RecDetailRapportDG."Non Inclu Reste à facturer" := TRUE;
//         IF RecDetailRapportDG.INSERT THEN;
//     end;
// }

