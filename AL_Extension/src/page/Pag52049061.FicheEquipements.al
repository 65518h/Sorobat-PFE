// page 52049061 "Fiche Equipements"
// {//GL2024  ID dans Nav 2009 : "39004764"
//     PageType = Card;
//     SourceTable = "Véhicule";
//     ApplicationArea = All;
//     Caption = 'Fiche Equipements';
//     UsageCategory = Administration;

//     layout
//     {
//         area(content)
//         {
//             group("Général")
//             {
//                 Caption = 'Général';
//                 field("N° Vehicule"; REC."N° Vehicule")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'N° Equipement';
//                     Editable = true;

//                     trigger OnAssistEdit()
//                     begin
//                         IF REC.AssistEdit(xRec) THEN
//                             CurrPage.UPDATE;
//                     end;
//                 }
//                 field(Désignation; REC.Désignation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Designation 2"; REC."Designation 2")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Immatriculation; REC.Immatriculation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date D'immatriculation"; REC."Date D'immatriculation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date PMC"; REC."Date PMC")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Date Premiére mise en circulation';
//                 }
//                 field("Date Fin de Garantie"; REC."Date Fin de Garantie")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Famille; REC.Famille)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Famille';
//                 }
//                 field("Sous Famille"; REC."Sous Famille")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Sous-Famille';
//                 }
//                 field(Emplacement; REC.Emplacement)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Bloquer; REC.Bloquer)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Puissance1; REC.Puissance)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Type Index"; REC."Type Index")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Statut; REC.Statut)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Marche; REC.Marche)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Sous Affaire"; REC."Sous Affaire")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Societe; REC.Societe)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Fournisseurs; REC.Fournisseurs)
//                 {
//                     ApplicationArea = all;
//                 }

//                 field("Kms Parcourus1"; REC."Kms Parcourus")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Designation Affaire"; REC."Designation Affaire")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Designation Sous Affaire"; REC."Designation Sous Affaire")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nom Fournisseurs"; REC."Nom Fournisseurs")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Date Derniére Reparation"; REC."Date Derniére Reparation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Quantité Carburant consommé"; REC."Quantité Carburant consommé")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Coût Carburant consommé"; REC."Coût Carburant consommé")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Seuil Alerte Visite Technique"; REC."Seuil Alerte Visite Technique")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Marque1; REC.Marque)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Type Marque1"; REC."Type Marque")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Gamme Debut"; REC."Gamme Debut")
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 0 : 0;
//                     Editable = false;
//                 }
//                 field("Gamme Fin"; REC."Gamme Fin")
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 0 : 0;
//                     Editable = false;
//                 }
//                 field("Gamme Actif"; REC."Gamme Actif")
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Dernier Index"; REC."Dernier Index")
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                 }
//                 field("Date Dernier Index"; REC."Date Dernier Index")
//                 {
//                     ApplicationArea = all;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                 }
//             }
//             part(liste; "Liste BT GMAO")
//             {
//                 ApplicationArea = all;
//                 SubPageLink = Equipement = FIELD("N° Vehicule"), Status = CONST(Ouvert);
//             }
//             group(Technique)
//             {
//                 Caption = 'Technique';
//                 field("Type de Carburant"; REC."Type de Carburant")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Energie';
//                 }
//                 field("Consommation Max"; REC."Consommation Max")
//                 {
//                     ApplicationArea = all;
//                     Caption = '% Consommation Max';
//                 }
//                 field("Consommation Min"; REC."Consommation Min")
//                 {
//                     ApplicationArea = all;
//                     Caption = '% Consommation Min';
//                 }
//                 field("Consommation Moyen"; REC."Consommation Moyen")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Capacité Reservoire"; REC."Capacité Reservoire")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Num Clef de porte"; REC."Num Clef de porte")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'N° Clef de porte';
//                 }
//                 field("Num Moteur"; REC."Num Moteur")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'N° Moteur';
//                 }
//                 field("Kms Parcourus"; REC."Kms Parcourus")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Index de Départ"; REC."Index de Départ")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Index Théorique Final"; REC."Index Théorique Final")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Durée visite technique"; REC."Durée visite technique")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group(Immobilisation)
//             {
//                 Caption = 'Immobilisation';
//                 field("Code Immo"; REC."Code Immo")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Code Classe Immobilisation"; REC."Code Classe Immobilisation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Code Sous-Classe Immo"; REC."Code Sous-Classe Immo")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Code Emplacement"; REC."Code Emplacement")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date d'acquisition"; REC."Date d'acquisition")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group(Accessoire)
//             {
//                 Caption = 'Accessoire';
//                 field("N°GPRS"; REC."N°GPRS")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Montage"; REC."Date Montage")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Demontage"; REC."Date Demontage")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N°Carte Carburant"; REC."N°Carte Carburant")
//                 {
//                     ApplicationArea = all;
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
//                     ApplicationArea = all;
//                 }
//                 field("Grande Famille"; REC."Grande Famille")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Marque; REC.Marque)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Type; REC.Type)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Type Marque"; REC."Type Marque")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Puissance; REC.Puissance)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Série; REC.Série)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Carrosserie; REC.Carrosserie)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Poids TTCharges"; REC."Poids TTCharges")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Poids à Vide"; REC."Poids à Vide")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Expiration TAXE"; REC."Date Expiration TAXE")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Exp Carte Grise"; REC."Date Exp Carte Grise")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Visite Tech"; REC."Date Visite Tech")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Num Police Assurance"; REC."Num Police Assurance")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Expiration Assurance"; REC."Date Expiration Assurance")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Exp Carte Exploitation"; REC."Date Exp Carte Exploitation")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group(Organes)
//             {
//                 Caption = 'Organes';
//                 part(subfor; "Subform Organe")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = Famille = FIELD(Famille), Organe = CONST(true);
//                 }
//             }
//             group(Gammes)
//             {
//                 Caption = 'Gammes';
//                 part(gamme; "Subform Gamme")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "Code sous Famille Equipement" = FIELD("Sous Famille");
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Promoted)
//         {
//             group("Véhicule1")
//             {
//                 Caption = 'Véhicule';
//                 actionref("Historique Vignette1"; "Historique Vignette") { }
//                 actionref("Historique Affectation1"; "Historique Affectation") { }
//                 group(Ecritures1)
//                 {
//                     Caption = 'Ecritures';
//                     actionref("Ecritures Vignettes1"; "Ecritures Vignettes") { }
//                     actionref("Ecritures missions1"; "Ecritures missions") { }
//                     actionref("Ecritures réparations1"; "Ecritures réparations") { }
//                     actionref("Ecritures taxes1"; "Ecritures taxes") { }
//                 }
//                 actionref(Image1; Image) { }
//                 actionref("Historique prise de carburant1"; "Historique prise de carburant") { }
//                 actionref("Historique PR1"; "Historique PR") { }

//             }

//             group(Planning1)
//             {
//                 Caption = 'Planning';

//                 actionref("Disponibilitée Véhicule1"; "Disponibilitée Véhicule") { }
//             }

//             group("Fixed &Asset1")
//             {
//                 Caption = 'I&mmo.';
//                 actionref("Depreciation &Books1"; "Depreciation &Books") { }
//                 actionref("Ledger E&ntries1"; "Ledger E&ntries") { }
//                 actionref("Co&mments1"; "Co&mments") { }
//                 actionref(Dimensions1; Dimensions) { }
//                 actionref(Picture1; Picture) { }
//                 actionref("M&ain Asset Components1"; "M&ain Asset Components") { }
//                 actionref(Statistics1; Statistics) { }

//             }
//         }
//         area(navigation)
//         {
//             group("Véhicule")
//             {
//                 Caption = 'Véhicule';

//                 /*  //GL3900  action("A&xes analytiques")
//                    {
//                        ApplicationArea = all;
//                        Caption = 'A&xes analytiques';
//                        RunObject = Page "Default Dimensions";
//                        // RunPageLink = Table ID=CONST(39004670), No.=FIELD(N° Vehicule);
//                        ShortCutKey = 'Maj+Ctrl+D';
//                    }
//                    action(Carte)
//                    {
//                        ApplicationArea = all;
//                        Caption = 'Carte';
//                        //GL3900   RunObject = Page "Carte Grise";
//                        //GL3900     RunPageLink = "N° Veh" = FIELD("N° Vehicule");
//                        Visible = false;
//                    }
//                    action(Assurance)
//                    {
//                        ApplicationArea = all;
//                        Caption = 'Assurance';
//                        //GL3900  RunObject = Page "Assurances Véhicules";
//                        //GL3900      RunPageLink = "N° Veh" = FIELD("N° Vehicule");
//                    }*/
//                 action("Historique Vignette")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Historique Vignette';
//                     RunObject = Page "Liste Vignettes";
//                     RunPageLink = "N° Veh" = FIELD("N° Vehicule");
//                 }
//                 /* //GL3900    action(Pneumatique)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Pneumatique';
//                         //GL3900   RunObject = Page Pneumatique;
//                         //GL3900   RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
//                     }*/

//                 action("Historique Affectation")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Historique Affectation';
//                     RunObject = Page "Historique Affectation";
//                     RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
//                 }
//                 group(Ecritures)
//                 {
//                     Caption = 'Ecritures';
//                     action("Ecritures Vignettes")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Ecritures Vignettes';
//                         RunObject = Page "Liste Vignettes";
//                         RunPageLink = "N° Veh" = FIELD("N° Vehicule");
//                     }
//                     /* //GL3900   action("Ecriture Visites Techniques")
//                        {
//                            ApplicationArea = all;
//                            Caption = 'Ecriture Visites Techniques';
//                            //GL3900   RunObject = Page "Liste Visites Techniques";
//                            //GL3900    RunPageLink = "N° Véhicule" = FIELD("N° Vehicule"), Valider = FILTER(true);
//                        }*/
//                     action("Ecritures missions")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Ecritures missions';
//                         RunObject = Page "Liste Missions enreg.";
//                         RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
//                     }
//                     /* //GL3900    action("Ecritures Accidents")
//                         {
//                             ApplicationArea = all;
//                             Caption = 'Ecritures Accidents';
//                             //GL3900   RunObject = Page "Liste Accidents Enregistrés";
//                             //GL3900     RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
//                         }*/
//                     action("Ecritures réparations")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Ecritures réparations';
//                         RunObject = Page "Liste Réparation Enreg.";
//                         RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
//                     }
//                     action("Ecritures taxes")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Ecritures taxes';
//                         RunObject = Page "Liste taxe";
//                         RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
//                     }
//                 }
//                 action(Image)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Image';
//                     RunObject = Page "Image Véhicule";
//                 }
//                 action("Historique prise de carburant")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Historique prise de carburant';
//                     RunObject = Page "Historique Prise de Carburant";
//                     RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
//                 }
//                 action("Historique PR")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Historique PR';
//                     RunObject = Page "Item Ledger Entries";
//                     RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
//                 }
//                 /* //GL3900   action("Réparation préventive")
//                    {
//                        ApplicationArea = all;
//                        Caption = 'Réparation préventive';
//                        //GL3900  RunObject = Page "Veh. Rep. Préventive";
//                        //GL3900   RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
//                    }
//                    action("Hist Carte Autoroute")
//                    {
//                        ApplicationArea = all;
//                        Caption = 'Hist Carte Autoroute';
//                        //GL3900   RunObject = Page "Carte Autoroute Enreg";
//                        //GL3900   RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
//                    }*/
//             }
//             group(Planning)
//             {
//                 Caption = 'Planning';
//                 action("Disponibilitée Véhicule")
//                 {
//                     ApplicationArea = all;
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
//                     ApplicationArea = all;
//                     Caption = 'Plan d''am&ortissement';
//                     Image = DepreciationBooks;
//                     RunObject = Page "FA Depreciation Books";
//                     RunPageLink = "FA No." = FIELD("Code Immo");
//                 }
//                 action("Ledger E&ntries")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Ecrit&ures';
//                     RunObject = Page "FA Ledger Entries";
//                     RunPageLink = "FA No." = FIELD("Code Immo");
//                     RunPageView = SORTING("FA No.");
//                     ShortCutKey = 'Ctrl+F7';
//                 }
//                 action("Co&mments")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Co&mmentaires';
//                     Image = ViewComments;
//                     RunObject = Page "Comment Sheet";
//                     RunPageLink = "Table Name" = CONST("Fixed Asset"), "No." = FIELD("Code Immo");
//                 }
//                 action(Dimensions)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'A&xes analytiques';
//                     Image = Dimensions;
//                     RunObject = Page "Default Dimensions";
//                     RunPageLink = "No." = FIELD("Code Immo");
//                     ShortCutKey = 'Maj+Ctrl+D';
//                 }
//                 action(Picture)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Image';
//                     RunObject = Page "Fixed Asset Picture";
//                     RunPageLink = "No." = FIELD("No. Series");
//                 }
//                 action("M&ain Asset Components")
//                 {
//                     ApplicationArea = all;
//                     Caption = '&Composants immo. principale';
//                     RunObject = Page "Main Asset Components";
//                     RunPageLink = "Main Asset No." = FIELD("Code Immo");
//                 }

//                 action(Statistics)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Statistiques';
//                     Image = Statistics;

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

