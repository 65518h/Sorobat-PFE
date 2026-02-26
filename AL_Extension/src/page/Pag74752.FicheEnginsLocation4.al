// page 74752 "Fiche Engins Location4"
// {//GL2024  ID dans Nav 2009 : "39004752"
//     PageType = Card;
//     SourceTable = "Véhicule";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             group("Général")
//             {
//                 Caption = 'Général';
//                 field("N° Vehicule"; REC."N° Vehicule")
//                 {
//                     Caption = 'N° Matèriel';
//                     Editable = true;

//                     trigger OnAssistEdit()
//                     begin
//                         IF REC.AssistEdit(xRec) THEN
//                             CurrPage.UPDATE;
//                     end;
//                 }
//                 field(Désignation; REC.Désignation)
//                 {
//                 }
//                 field("Designation 2"; REC."Designation 2")
//                 {
//                 }
//                 field(Immatriculation; REC.Immatriculation)
//                 {
//                 }
//                 field("Date D'immatriculation"; REC."Date D'immatriculation")
//                 {
//                 }
//                 field("Date PMC"; REC."Date PMC")
//                 {
//                     Caption = 'Date Premiére mise en circulation';
//                 }
//                 field("Date Fin de Garantie"; REC."Date Fin de Garantie")
//                 {
//                 }
//                 field(Famille; REC.Famille)
//                 {
//                     Caption = 'Catégorie';
//                 }
//                 field("Sous Famille"; REC."Sous Famille")
//                 {
//                     Caption = 'Sous-Catégorie';
//                 }
//                 field(Emplacement; REC.Emplacement)
//                 {
//                 }
//                 field(Bloquer; REC.Bloquer)
//                 {
//                 }
//                 field(Puissance1; REC.Puissance)
//                 {
//                 }
//                 field("Type Index"; REC."Type Index")
//                 {
//                 }
//                 field("Num Châssis"; REC."Num Châssis")
//                 {
//                     Caption = 'N° Châssis';
//                 }
//                 field(Statut; REC.Statut)
//                 {
//                 }
//                 field(Marche; REC.Marche)
//                 {
//                 }
//                 field("Sous Affaire"; REC."Sous Affaire")
//                 {
//                 }
//                 field("Designation Affaire"; REC."Designation Affaire")
//                 {
//                 }
//                 field("Designation Sous Affaire"; REC."Designation Sous Affaire")
//                 {
//                 }
//                 field(Societe; REC.Societe)
//                 {
//                 }
//                 field(Chauffeur; REC.Chauffeur)
//                 {
//                 }
//                 field("Cout Location Journaliere"; REC."Cout Location Journaliere")
//                 {
//                 }
//                 field("Kms Parcourus"; REC."Kms Parcourus")
//                 {
//                 }
//                 field("Date Derniére Visite"; REC."Date Derniére Visite")
//                 {
//                     Caption = 'Date Derniére Visite Technique';
//                 }
//                 field("Date Derniére Reparation"; REC."Date Derniére Reparation")
//                 {
//                 }
//                 field("Quantité Carburant consommé"; REC."Quantité Carburant consommé")
//                 {
//                 }
//                 field("Coût Carburant consommé"; REC."Coût Carburant consommé")
//                 {
//                 }
//                 field("Seuil Alerte Visite Technique"; REC."Seuil Alerte Visite Technique")
//                 {
//                 }
//                 field("Seuil Alerte Vignette"; REC."Seuil Alerte Vignette")
//                 {
//                 }
//                 field("Seuil Alerte Assurance"; REC."Seuil Alerte Assurance")
//                 {
//                 }
//                 field("Seuil Alerte Vidange"; REC."Seuil Alerte Vidange")
//                 {
//                 }
//                 field(Marque1; REC.Marque)
//                 {
//                 }
//                 field("Type Marque"; REC."Type Marque")
//                 {
//                 }
//                 field("Grande Famille"; REC."Grande Famille")
//                 {
//                     Caption = 'Remorque';
//                 }
//             }
//             group(Technique)
//             {
//                 Caption = 'Technique';
//                 field("Type de Carburant"; REC."Type de Carburant")
//                 {
//                     Caption = 'Energie';
//                 }
//                 field("Consommation Max"; REC."Consommation Max")
//                 {
//                     Caption = '% Consommation Max';
//                 }
//                 field("Consommation Min"; REC."Consommation Min")
//                 {
//                     Caption = '% Consommation Min';
//                 }
//                 field("Consommation Moyen"; REC."Consommation Moyen")
//                 {
//                 }
//                 field("Capacité Reservoire"; REC."Capacité Reservoire")
//                 {
//                 }
//                 field("Num Clef de porte"; REC."Num Clef de porte")
//                 {
//                     Caption = 'N° Clef de porte';
//                 }
//                 field("Num Moteur"; REC."Num Moteur")
//                 {
//                     Caption = 'N° Moteur';
//                 }
//                 field("Num Châssis1"; REC."Num Châssis")
//                 {
//                     Caption = 'N° Châssis';
//                 }
//                 field("Index de Départ"; REC."Index de Départ")
//                 {
//                 }
//                 field("Index Théorique Final"; REC."Index Théorique Final")
//                 {
//                 }
//                 field("Durée visite technique"; REC."Durée visite technique")
//                 {
//                 }
//             }
//             group(Immobilisation)
//             {
//                 Caption = 'Immobilisation';
//                 field("Code Immo"; REC."Code Immo")
//                 {
//                 }
//                 field("Code Classe Immobilisation"; REC."Code Classe Immobilisation")
//                 {
//                 }
//                 field("Code Sous-Classe Immo"; REC."Code Sous-Classe Immo")
//                 {
//                 }
//                 field("Code Emplacement"; REC."Code Emplacement")
//                 {
//                 }
//                 field("Date d'acquisition"; REC."Date d'acquisition")
//                 {
//                 }
//             }
//             group(Accessoire)
//             {
//                 Caption = 'Accessoire';
//                 field("N°GPRS"; REC."N°GPRS")
//                 {
//                 }
//                 field("Date Montage"; REC."Date Montage")
//                 {
//                 }
//                 field("Date Demontage"; REC."Date Demontage")
//                 {
//                 }
//                 field("N°Carte Carburant"; REC."N°Carte Carburant")
//                 {
//                 }
//                 field("Budget Carte Carburant"; REC."Budget Carte Carburant")
//                 {
//                 }
//             }
//             group(Papier)
//             {
//                 Caption = 'Papier';
//                 field("N° Carte"; REC."N° Carte")
//                 {
//                 }
//                 field("Grande Famille1"; REC."Grande Famille")
//                 {
//                 }
//                 field(Marque; REC.Marque)
//                 {
//                 }
//                 field(Type; REC.Type)
//                 {
//                 }
//                 field("Type Marque1"; REC."Type Marque")
//                 {
//                 }
//                 field(Puissance; REC.Puissance)
//                 {
//                 }
//                 field(Série; REC.Série)
//                 {
//                 }
//                 field(Carrosserie; REC.Carrosserie)
//                 {
//                 }
//                 field("Poids TTCharges"; REC."Poids TTCharges")
//                 {
//                 }
//                 field("Poids à Vide"; REC."Poids à Vide")
//                 {
//                 }
//                 field("Date Expiration TAXE"; REC."Date Expiration TAXE")
//                 {
//                 }
//                 field("Date Exp Carte Grise"; REC."Date Exp Carte Grise")
//                 {
//                 }
//                 field("Date Visite Tech"; REC."Date Visite Tech")
//                 {
//                 }
//                 field("Num Police Assurance"; REC."Num Police Assurance")
//                 {
//                 }
//                 field("Date Expiration Assurance"; REC."Date Expiration Assurance")
//                 {
//                 }
//                 field("Date Exp Carte Exploitation"; REC."Date Exp Carte Exploitation")
//                 {
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("Véhicule")
//             {
//                 Caption = 'Véhicule';

//                 action("A&xes analytiques")
//                 {
//                     Caption = 'A&xes analytiques';
//                     RunObject = Page "Default Dimensions";
//                     // RunPageLink = Table ID=CONST(39004670), No.=FIELD(N° Vehicule);
//                     ShortCutKey = 'Maj+Ctrl+D';
//                 }
//                 action(Carte)
//                 {
//                     Caption = 'Carte';
//                     //GL3900   RunObject = Page "Carte Grise";
//                     //GL3900    RunPageLink = "N° Veh" = FIELD("N° Vehicule");
//                     Visible = false;
//                 }
//                 action(Assurance)
//                 {
//                     Caption = 'Assurance';
//                     //GL3900   RunObject = Page "Assurances Véhicules";
//                     //GL3900    RunPageLink = "N° Veh" = FIELD("N° Vehicule");
//                 }
//                 action("Historique Vignette")
//                 {
//                     Caption = 'Historique Vignette';
//                     RunObject = Page "Liste Vignettes";
//                     RunPageLink = "N° Veh" = FIELD("N° Vehicule");
//                 }
//                 action(Pneumatique)
//                 {
//                     Caption = 'Pneumatique';
//                     //GL3900   RunObject = Page Pneumatique;
//                     //GL3900    RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
//                 }

//                 action("Historique Affectation")
//                 {
//                     Caption = 'Historique Affectation';
//                     RunObject = Page "Historique Affectation";
//                     RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
//                 }
//                 group(Ecritures)
//                 {
//                     Caption = 'Ecritures';
//                     action("Ecritures Vignettes")
//                     {
//                         Caption = 'Ecritures Vignettes';
//                         RunObject = Page "Liste Vignettes";
//                         RunPageLink = "N° Veh" = FIELD("N° Vehicule");
//                     }
//                     action("Ecriture Visites Techniques")
//                     {
//                         Caption = 'Ecriture Visites Techniques';
//                         //GL3900   RunObject = Page "Liste Visites Techniques";
//                         //GL3900    RunPageLink = "N° Véhicule" = FIELD("N° Vehicule"), Valider = FILTER(true);
//                     }
//                     action("Ecritures missions")
//                     {
//                         Caption = 'Ecritures missions';
//                         RunObject = Page "Liste Missions enreg.";
//                         RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
//                     }
//                     action("Ecritures Accidents")
//                     {
//                         Caption = 'Ecritures Accidents';
//                         //GL3900   RunObject = Page "Liste Accidents Enregistrés";
//                         //GL3900   RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
//                     }
//                     action("Ecritures réparations")
//                     {
//                         Caption = 'Ecritures réparations';
//                         RunObject = Page "Liste Réparation Enreg.";
//                         RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
//                     }
//                     action("Ecritures taxes")
//                     {
//                         Caption = 'Ecritures taxes';
//                         RunObject = Page "Liste taxe";
//                         RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
//                     }
//                 }
//                 action(Image)
//                 {
//                     Caption = 'Image';
//                     RunObject = Page "Image Véhicule";
//                 }
//                 action("Historique prise de carburant")
//                 {
//                     Caption = 'Historique prise de carburant';
//                     RunObject = Page "Historique Prise de Carburant";
//                     RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
//                 }
//                 action("Historique PR")
//                 {
//                     Caption = 'Historique PR';
//                     RunObject = Page "Item Ledger Entries";
//                     RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
//                 }
//                 action("Réparation préventive")
//                 {
//                     Caption = 'Réparation préventive';
//                     //GL3900  RunObject = Page "Veh. Rep. Préventive";
//                     //GL3900    RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
//                 }
//                 action("Hist Carte Autoroute")
//                 {
//                     Caption = 'Hist Carte Autoroute';
//                     //GL3900     RunObject = Page "Carte Autoroute Enreg";
//                     //GL3900     RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
//                 }
//             }
//             group(Planning)
//             {
//                 Caption = 'Planning';
//                 action("Disponibilitée Véhicule")
//                 {
//                     Caption = 'Disponibilitée Véhicule';

//                     trigger OnAction()
//                     begin
//                         CLEAR(Dispo);
//                         Dispo.Set(Rec, 0);
//                         Dispo.RUNMODAL;
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//             }
//             group("Fixed &Asset")
//             {
//                 Caption = 'Fixed &Asset';
//                 action("Depreciation &Books")
//                 {
//                     Caption = 'Depreciation &Books';
//                     Image = DepreciationBooks;
//                     RunObject = Page "FA Depreciation Books";
//                     RunPageLink = "FA No." = FIELD("Code Immo");
//                 }
//                 action("Ledger E&ntries")
//                 {
//                     Caption = 'Ledger E&ntries';
//                     RunObject = Page "FA Ledger Entries";
//                     RunPageLink = "FA No." = FIELD("Code Immo");
//                     RunPageView = SORTING("FA No.");
//                     ShortCutKey = 'Ctrl+F7';
//                 }
//                 action("Co&mments")
//                 {
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page "Comment Sheet";
//                     RunPageLink = "Table Name" = CONST("Fixed Asset"), "No." = FIELD("Code Immo");
//                 }
//                 action(Dimensions)
//                 {
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     RunObject = Page "Default Dimensions";
//                     RunPageLink = "No." = FIELD("Code Immo");
//                     ShortCutKey = 'Maj+Ctrl+D';
//                 }
//                 action(Picture)
//                 {
//                     Caption = 'Picture';
//                     RunObject = Page "Fixed Asset Picture";
//                     RunPageLink = "No." = FIELD("No. Series");
//                 }
//                 action("M&ain Asset Components")
//                 {
//                     Caption = 'M&ain Asset Components';
//                     RunObject = Page "Main Asset Components";
//                     RunPageLink = "Main Asset No." = FIELD("Code Immo");
//                 }

//                 action(Statistics)
//                 {
//                     Caption = 'Statistics';
//                     Image = Statistics;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = Page "Fixed Asset Statistics";
//                     RunPageLink = "FA No." = FIELD("Code Immo");
//                     ShortCutKey = 'Ctrl+F11';
//                 }
//             }
//         }
//     }

//     var
//         Dispo: Page "Dispo. Véhicule";
// }

