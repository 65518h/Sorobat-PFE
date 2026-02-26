page 52049058 "Fiche Véhicule"
{//GL2024  ID dans Nav 2009 : "39004670"
    PageType = Card;
    Editable = true;
    SourceTable = "Véhicule";

    Caption = 'Fiche Véhicule';
    SourceTableView = WHERE(Bloquer = CONST(false));

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Général';
                field("N° Vehicule"; REC."N° Vehicule")
                {
                    ApplicationArea = all;
                    Caption = 'N° Matèriel';
                    Editable = true;

                    trigger OnAssistEdit()
                    begin
                        IF REC.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Désignation; REC.Désignation)
                {
                    ApplicationArea = all;
                }
                // field("Designation 2"; REC."Designation 2")
                // {
                //     ApplicationArea = all;
                // }
                field(Immatriculation; REC.Immatriculation)
                {
                    ApplicationArea = all;
                }
                field("Date D'immatriculation"; REC."Date D'immatriculation")
                {
                    ApplicationArea = all;
                }
                field("Date PMC"; REC."Date PMC")
                {
                    ApplicationArea = all;
                    Caption = 'Date Premiére mise en circulation';
                }
                field("Date Fin de Garantie"; REC."Date Fin de Garantie")
                {
                    ApplicationArea = all;
                }

                field(Marque1; REC.Marque)
                {
                    ApplicationArea = all;
                }
                field("Modéle"; Rec."Modéle")
                {
                    ApplicationArea = all;
                }
                field("Grande Famille1"; REC."Grande Famille")
                {
                    ApplicationArea = all;
                    Caption = 'Grande Famille';
                }
                field("No. Series"; REC."No. Series")
                {
                    ApplicationArea = all;
                    Caption = 'N° Série';
                }
                field(Synchronise; REC.Synchronise)
                {
                    ApplicationArea = all;
                }
                field(Statut; REC.Statut)
                {
                    ApplicationArea = all;
                    Style = Attention;
                    StyleExpr = true;
                }
                field(Famille; REC.Famille)
                {
                    ApplicationArea = all;
                    Caption = 'Famille';
                }
                field(marche1; REC.marche)
                {
                    ApplicationArea = all;
                }
                field(Conducteur; REC.Conducteur)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Motif Panne"; REC."Motif Panne")
                {
                    ApplicationArea = all;
                }
                field("Motif Disponibilité"; REC."Motif Disponibilité")
                {
                    ApplicationArea = all;
                }
                field("Derniere Date Fonctionnel"; REC."Derniere Date Fonctionnel")
                {
                    ApplicationArea = all;
                }
                field("N° Fiche Reparation"; REC."N° Fiche Reparation")
                {
                    ApplicationArea = all;
                }
                field("DA Lancé"; REC."DA Lancé")
                {
                    ApplicationArea = all;
                }
                field("N° Da"; REC."N° Da")
                {
                    ApplicationArea = all;
                }
                field(Volume; REC.Volume)
                {
                    ApplicationArea = all;
                }
                field("Ne pas Tester Position Engin"; REC."Ne pas Tester Position Engin")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(MO; Rec.MO)
                {
                    ApplicationArea = all;

                }
                field("Type Compteur"; REC."Type Compteur")
                {
                    ApplicationArea = all;
                }
                // field("Carte Grise"; REC."Carte Grise")
                // {
                //     ApplicationArea = all;
                // }

                field("Cout Journalier"; REC."Cout Journalier")
                {
                    ApplicationArea = all;
                }
                field("Sous Famille"; REC."Sous Famille")
                {
                    ApplicationArea = all;
                    Caption = 'Sous Famille';
                }
                field(Puissance1; REC.Puissance)
                {
                    ApplicationArea = all;
                }
                field("Type Index"; REC."Type Index")
                {
                    ApplicationArea = all;
                }
                field("Num Châssis1"; REC."Num Châssis")
                {
                    ApplicationArea = all;
                    Caption = 'N° Châssis';
                    Visible = false;
                }
                field(Marche; REC.Marche)
                {
                    ApplicationArea = all;
                }
                field("Sous Affaire"; REC."Sous Affaire")
                {
                    ApplicationArea = all;
                }
                field("Designation Affaire"; REC."Designation Affaire")
                {
                    ApplicationArea = all;
                }
                // field("Designation Sous Affaire"; REC."Designation Sous Affaire")
                // {
                //     ApplicationArea = all;
                // }
                // field(Societe; REC.Societe)
                // {
                //     ApplicationArea = all;
                // }
                // field(Chauffeur; REC.Chauffeur)
                // {
                //     ApplicationArea = all;
                // }
                field(Bloquer; REC.Bloquer)
                {
                    ApplicationArea = all;
                    // Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                }
                // field("Gamme Actif"; REC."Gamme Actif")
                // {
                //     ApplicationArea = all;
                //     Visible = true;
                // }
                // field("Statut Vehicule"; REC."Statut Vehicule")
                // {
                //     ApplicationArea = all;
                //     Style = Unfavorable;
                //     StyleExpr = TRUE;
                // }
                field(Observation; REC.Observation)
                {
                    ApplicationArea = all;
                }
                field("Kms Parcourus"; REC."Kms Parcourus")
                {
                    ApplicationArea = all;
                }
                field("Date Derniére Visite"; REC."Date Derniére Visite")
                {
                    ApplicationArea = all;
                    Caption = 'Date Derniére Visite Technique';
                }
                field("Date Derniére Reparation"; REC."Date Derniére Reparation")
                {
                    ApplicationArea = all;
                }
                field("Quantité Carburant consommé"; REC."Quantité Carburant consommé")
                {
                    ApplicationArea = all;
                }
                field("Coût Carburant consommé"; REC."Coût Carburant consommé")
                {
                    ApplicationArea = all;
                }
                field("Seuil Alerte Visite Technique"; REC."Seuil Alerte Visite Technique")
                {
                    ApplicationArea = all;
                }
                field("Seuil Alerte Vignette"; REC."Seuil Alerte Vignette")
                {
                    ApplicationArea = all;
                }
                field("Seuil Alerte Assurance"; REC."Seuil Alerte Assurance")
                {
                    ApplicationArea = all;
                }
                field("Seuil Alerte Vidange"; REC."Seuil Alerte Vidange")
                {
                    ApplicationArea = all;
                }
                field(Marque0; REC.Marque)
                {
                    ApplicationArea = all;
                }
                // field("Type Marque2"; REC."Type Marque")
                // {
                //     ApplicationArea = all;
                // }
                field("Grande Famille2"; REC."Grande Famille")
                {
                    ApplicationArea = all;
                    Caption = 'Remorque';
                }
                field("Compteur Actuel2"; REC."Compteur Actuel")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                // field("Date Dernier Index"; REC."Date Dernier Index")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Style = AttentionAccent;
                //     StyleExpr = TRUE;
                // }
                // field("Cout Location Journaliere"; REC."Cout Location Journaliere")
                // {
                //     ApplicationArea = all;
                // }
                // field("Cout Supplementaire"; REC."Cout Supplementaire")
                // {
                //     ApplicationArea = all;
                // }
                // field("Cout Acquisition"; REC."Cout Acquisition")
                // {
                //     ApplicationArea = all;
                // }
                // field("Date Acquisition"; REC."Date Acquisition")
                // {
                //     ApplicationArea = all;
                // }
                // field(Enrobé; REC.Enrobé)
                // {
                //     ApplicationArea = all;
                // }
                // field("Chez Concessionnaire"; REC."Chez Concessionnaire")
                // {
                //     ApplicationArea = all;
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
                // field("Nbre Jours"; REC."Nbre Jours")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
                // field("Taux Occupation"; REC."Taux Occupation")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
            }
            group(Technique)
            {
                Caption = 'Technique';
                field("Type de Carburant"; REC."Type de Carburant")
                {
                    ApplicationArea = all;
                    Caption = 'Energie';
                }
                field("Consommation Max"; REC."Consommation Max")
                {
                    ApplicationArea = all;
                    Caption = '% Consommation Max';
                }
                field("Consommation Min"; REC."Consommation Min")
                {
                    ApplicationArea = all;
                    Caption = '% Consommation Min';
                }
                field("Consommation Moyen"; REC."Consommation Moyen")
                {
                    ApplicationArea = all;
                }
                field("Capacité Reservoire"; REC."Capacité Reservoire")
                {
                    ApplicationArea = all;
                }
                field("Num Clef de porte"; REC."Num Clef de porte")
                {
                    ApplicationArea = all;
                    Caption = 'N° Clef de porte';
                }
                field("Num Moteur"; REC."Num Moteur")
                {
                    ApplicationArea = all;
                    Caption = 'N° Moteur';
                }
                field("Num Châssis"; REC."Num Châssis")
                {
                    ApplicationArea = all;
                    Caption = 'N° Châssis';
                }
                field("Index de Départ"; REC."Index de Départ")
                {
                    ApplicationArea = all;
                }
                field("Index Théorique Final"; REC."Index Théorique Final")
                {
                    ApplicationArea = all;
                }
                field("Durée visite technique"; REC."Durée visite technique")
                {
                    ApplicationArea = all;
                }
            }
            group(Immobilisation)
            {
                Caption = 'Immobilisation';
                field("Code Immo"; REC."Code Immo")
                {
                    ApplicationArea = all;
                }
                field("Code Classe Immobilisation"; REC."Code Classe Immobilisation")
                {
                    ApplicationArea = all;
                }
                field("Code Sous-Classe Immo"; REC."Code Sous-Classe Immo")
                {
                    ApplicationArea = all;
                }
                field("Emplacement"; REC."Emplacement")
                {
                    ApplicationArea = all;
                }
                field("Transformation"; REC."Transformation")
                {
                    ApplicationArea = all;
                }
                field("Code Emplacement"; REC."Code Emplacement")
                {
                    ApplicationArea = all;
                }
                field("Date d'acquisition"; REC."Date d'acquisition")
                {
                    ApplicationArea = all;
                }
            }
            group(Accessoire)
            {
                Caption = 'Accessoire';
                field("N°GPRS"; REC."N°GPRS")
                {
                    ApplicationArea = all;
                }
                field("Date Montage"; REC."Date Montage")
                {
                    ApplicationArea = all;
                }
                field("Date Demontage"; REC."Date Demontage")
                {
                    ApplicationArea = all;
                }
                field("N°Carte Carburant"; REC."N°Carte Carburant")
                {
                    ApplicationArea = all;
                }
                field("Budget Carte Carburant"; REC."Budget Carte Carburant")
                {
                    ApplicationArea = all;
                }
            }
            group("Carte Grise1")
            {
                Caption = 'Carte Grise';
                field("N° Carte"; REC."N° Carte")
                {
                    ApplicationArea = all;
                }
                field("Grande Famille"; REC."Grande Famille")
                {
                    ApplicationArea = all;
                }
                field(Marque; REC.Marque)
                {
                    ApplicationArea = all;
                }
                // field("Type Marque"; REC."Marque")
                // {
                //     ApplicationArea = all;
                // }
                field(Type; REC.Type)
                {
                    ApplicationArea = all;
                }
                field(Puissance; REC.Puissance)
                {
                    ApplicationArea = all;
                }
                field(Série; REC.Série)
                {
                    ApplicationArea = all;
                }
                field(Carrosserie; REC.Carrosserie)
                {
                    ApplicationArea = all;
                }
                field("Poids TTCharges"; REC."Poids TTCharges")
                {
                    ApplicationArea = all;
                }
                field("Poids à Vide"; REC."Poids à Vide")
                {
                    ApplicationArea = all;
                }
                field("Carte Grise11"; Rec."Carte Grise")
                {
                    ApplicationArea = all;
                }
                // field("Date Expiration TAXE"; REC."Date Expiration TAXE")
                // {
                //     ApplicationArea = all;
                // }
                field("Date Exp Carte Grise"; REC."Date Exp Carte Grise")
                {
                    ApplicationArea = all;
                }
                // field("Date Visite Tech"; REC."Date Visite Tech")
                // {
                //     ApplicationArea = all;
                // }
                field("Num Police Assurance"; REC."Num Police Assurance")
                {
                    ApplicationArea = all;
                }

                field("Date Exp Carte Exploitation"; REC."Date Exp Carte Exploitation")
                {
                    ApplicationArea = all;//
                }
            }
            // group(Mouvements)
            // {
            //     Caption = 'Mouvements';
            //     part(mouvem; "Mouvements Stock Vehicules")
            //     {
            //         SubPageLink = "N° Véhicule" = FIELD("N° Vehicule");

            //         // Visible = ShowMouvements;
            //     }
            // }
            group(Papier)
            {
                Caption = 'Papier';
                field("Date Expiration AT"; REC."Date Expiration AT")
                {
                    ApplicationArea = all;

                }
                field("Date Expiration Assurance"; REC."Date Expiration Assurance")
                {
                    ApplicationArea = all;
                }
                field("Date Expiration Visite Tech"; rec."Date Expiration Visite Tech")
                {
                    ApplicationArea = all;
                }
                field("Date Expiration Vignette"; rec."Date Expiration Vignette")
                {
                    ApplicationArea = all;
                }
                field("Date Expiration Carte Jaune"; rec."Date Expiration Carte Jaune")
                {
                    ApplicationArea = all;
                }
                field("Date Expiration Certificat de"; rec."Date Expiration Certificat de")
                {
                    ApplicationArea = all;
                }

            }
            group(GAMO)
            {
                Group("Vidange Moteur")
                {
                    Caption = 'Vidange Moteur';
                    field("Compteur Actuel"; rec."Compteur Actuel")
                    {
                        ApplicationArea = all;
                    }
                    field("Vidange A"; rec."Vidange A")
                    {
                        ApplicationArea = all;
                    }
                    field("Alerte Avant"; rec."Alerte Avant")
                    {
                        ApplicationArea = all;
                    }
                    field("Dernier Vidange"; rec."Dernier Vidange")
                    {
                        ApplicationArea = all;
                        Caption = 'Dernier Vidange Moteur';
                        Style = Strong;
                        StyleExpr = true;
                    }
                    field("Prochain Vidange"; rec."Prochain Vidange")
                    {
                        ApplicationArea = all;
                    }

                    field("Reste Pour Alerte"; rec."Reste Pour Alerte")
                    {
                        ApplicationArea = all;
                    }
                }



                Group("Vidange Pont+Boite")
                {
                    Caption = 'Vidange Pont+Boite';
                    field("Compteur Actuel1"; rec."Compteur Actuel")
                    {
                        ApplicationArea = all;
                    }
                    field("Vidange A1"; rec."Vidange A 1")
                    {
                        ApplicationArea = all;
                    }
                    field("Alerte Avant1"; rec."Alerte Avant 1")
                    {
                        ApplicationArea = all;
                    }
                    field("Dernier Vidange1"; rec."Dernier Vidange 1")
                    {
                        ApplicationArea = all;
                        Caption = 'Dernier Vidange Moteur';
                        Style = Strong;
                        StyleExpr = true;
                    }
                    field("Prochain Vidange1"; rec."Prochain Vidange 1")
                    {
                        ApplicationArea = all;
                    }

                    field("Reste Pour Alerte1"; rec."Reste Pour Alerte 1")
                    {
                        ApplicationArea = all;
                    }
                }


                Group("Vidange 1000H")
                {
                    Caption = 'Vidange 1000H';
                    field("Compteur Actuel3"; rec."Compteur Actuel")
                    {
                        ApplicationArea = all;
                    }
                    field("Vidange A 1000H"; rec."Vidange A 1000H")
                    {
                        ApplicationArea = all;
                    }
                    field("Alerte Avant1000H"; rec."Alerte Avant 1000H")
                    {
                        ApplicationArea = all;
                    }
                    field("Dernier Vidange1000H"; rec."Dernier Vidange 1000H")
                    {
                        ApplicationArea = all;
                        Caption = 'Dernier Vidange Moteur';
                        Style = Strong;
                        StyleExpr = true;
                    }
                    field("Prochain Vidange1000H"; rec."Prochain Vidange 1000H")
                    {
                        ApplicationArea = all;
                    }

                    field("Reste Pour Alerte1000H"; rec."Reste Pour Alerte 1000H")
                    {
                        ApplicationArea = all;
                    }
                }


                Group("Vidange 2000H")
                {
                    Caption = 'Vidange 2000H';
                    field("Compteur Actuel4"; rec."Compteur Actuel")
                    {
                        ApplicationArea = all;
                    }
                    field("Vidange A 2"; rec."Vidange A 2")
                    {
                        ApplicationArea = all;
                    }
                    field("Alerte Avant2"; rec."Alerte Avant 2")
                    {
                        ApplicationArea = all;
                    }
                    field("Dernier Vidange2"; rec."Dernier Vidange 2")
                    {
                        ApplicationArea = all;
                        Caption = 'Dernier Vidange Moteur';
                        Style = Strong;
                        StyleExpr = true;
                    }
                    field("Prochain Vidange2"; rec."Prochain Vidange 2")
                    {
                        ApplicationArea = all;
                    }

                    field("Reste Pour Alerte2"; rec."Reste Pour Alerte 2")
                    {
                        ApplicationArea = all;
                    }
                }

                Group("Chaine de distribution")
                {
                    Caption = 'Chaine de distribution';
                    field("Compteur Actuel5"; rec."Compteur Actuel")
                    {
                        ApplicationArea = all;
                    }
                    field("Vidange A 3"; rec."Vidange A 3")
                    {
                        ApplicationArea = all;
                    }
                    field("Alerte Avant3"; rec."Alerte Avant 3")
                    {
                        ApplicationArea = all;
                    }
                    field("Dernier Vidange3"; rec."Dernier Vidange 3")
                    {
                        ApplicationArea = all;
                        Caption = 'Dernier Vidange Moteur';
                        Style = Strong;
                        StyleExpr = true;
                    }
                    field("Prochain Vidange3"; rec."Prochain Vidange 3")
                    {
                        ApplicationArea = all;
                    }

                    field("Reste Pour Alerte3"; rec."Reste Pour Alerte 3")
                    {
                        ApplicationArea = all;
                    }
                }
            }
            group("Consom Gasoil")
            {
                Caption = 'Consom Gasoil';
                part("ConsommationGasoil"; "Consommation Gasoil")
                {
                    SubPageLink = Materiel = FIELD("N° Vehicule");


                }
            }



        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Véhicule"),
                              "No." = field("N° Vehicule");
                // "Document Type" = field("Document Type");
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("Véhicule1")
            {
                Caption = 'Véhicule';
                actionref("Mouvements Stock Vehicules1"; "Mouvements Stock Vehicules") { }
                actionref("Historique Vignette1"; "Historique Vignette") { }
                actionref(Pneumatique1; Pneumatique) { }
                //     actionref("Historique Cout Location1"; "Historique Cout Location") { }
                group(Ecritures1)
                {
                    Caption = 'Ecritures';
                    actionref("Ecritures Vignettes1"; "Ecritures Vignettes") { }
                    actionref("Ecritures missions1"; "Ecritures missions") { }
                    actionref("Ecritures réparations1"; "Ecritures réparations") { }
                    actionref("Ecritures taxes1"; "Ecritures taxes") { }
                }
                actionref(Image1; Image) { }
                actionref("Historique prise de carburant1"; "Historique prise de carburant") { }
                actionref("Historique PR1"; "Historique PR") { }
                actionref("Creer Nouveau Engin1"; "Creer Nouveau Engin") { }
            }

            /*GL2024  group(Planning1)
              {
                  Caption = 'Planning';

                  actionref("Disponibilitée Véhicule1"; "Disponibilitée Véhicule") { }
              }*/

            group("Fixed &Asset1")
            {
                Caption = 'I&mmo.';
                actionref("Depreciation &Books1"; "Depreciation &Books") { }
                actionref("Ledger E&ntries1"; "Ledger E&ntries") { }
                actionref("Co&mments1"; "Co&mments") { }
                actionref(Dimensions1; Dimensions) { }
                actionref(Picture1; Picture) { }
                actionref("M&ain Asset Components1"; "M&ain Asset Components") { }
                actionref(Statistics1; Statistics) { }
                //   actionref(Lien1; Lien) { }
            }
        }
        area(navigation)
        {
            group("Véhicule")
            {
                Caption = 'Véhicule';

                /* GL2024  action("A&xes analytiques")
                   {
                       ApplicationArea = all;
                       Caption = 'A&xes analytiques';
                       RunObject = Page "Default Dimensions";
                       //GL2024 RunPageLink = Table ID=CONST(39004670), "No."=FIELD("N° Vehicule");
                       ShortCutKey = 'Maj+Ctrl+D';
                   }
                   action(Carte)
                   {
                       ApplicationArea = all;
                       Caption = 'Carte';
                       //GL3900   RunObject = Page "Carte Grise";
                       //GL3900   RunPageLink = "N° Veh" = FIELD("N° Vehicule");
                       Visible = false;
                   }
                   action(Assurance)
                   {
                       ApplicationArea = all;
                       Caption = 'Assurance';
                       //GL3900   RunObject = Page "Assurances Véhicules";
                       //GL3900   RunPageLink = "N° Veh" = FIELD("N° Vehicule");
                   }*/
                action("Mouvements Stock Vehicules")
                {
                    ApplicationArea = all;
                    Caption = 'Mouvements Stock Vehicules';
                    RunObject = Page "Mouvements Stock Vehicules";
                    RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
                }
                action("Historique Vignette")
                {
                    ApplicationArea = all;
                    Caption = 'Historique Vignette';
                    RunObject = Page "Liste Vignettes";
                    RunPageLink = "N° Veh" = FIELD("N° Vehicule");
                }
                action(Pneumatique)
                {
                    ApplicationArea = all;
                    Caption = 'Pneumatique';
                    RunObject = Page Pneumatique;
                    RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
                }

                action("Historique Affectation")
                {
                    ApplicationArea = all;
                    Caption = 'Historique Affectation';
                    RunObject = Page "Historique Affectation";
                    RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
                }
                group(Ecritures)
                {
                    Caption = 'Ecritures';
                    action("Ecritures Vignettes")
                    {
                        ApplicationArea = all;
                        Caption = 'Ecritures Vignettes';
                        RunObject = Page "Liste Vignettes";
                        RunPageLink = "N° Veh" = FIELD("N° Vehicule");
                    }
                    /*GL2024  action("Ecriture Visites Techniques")
                      {
                          ApplicationArea = all;
                          Caption = 'Ecriture Visites Techniques';
                          //GL3900    RunObject = Page "Liste Visites Techniques";
                          //GL3900    RunPageLink = "N° Véhicule" = FIELD("N° Vehicule"), Valider = FILTER(true);
                      }*/
                    action("Ecritures missions")
                    {
                        ApplicationArea = all;
                        Caption = 'Ecritures missions';
                        RunObject = Page "Liste Missions enreg.";
                        RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
                    }
                    /*GL2024     action("Ecritures Accidents")
                         {
                             ApplicationArea = all;
                             Caption = 'Ecritures Accidents';
                             //GL3900   RunObject = Page "Liste Accidents Enregistrés";
                             //GL3900  RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
                         }*/
                    action("Ecritures réparations")
                    {
                        ApplicationArea = all;
                        Caption = 'Ecritures réparations';
                        RunObject = Page "Liste Réparation Enreg.";
                        RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
                    }
                    action("Ecriture Chargement")
                    {
                        ApplicationArea = all;
                        Caption = 'Ecriture Chargement';
                        RunObject = Page "Ligne Rendement Vehicule Enreg";
                        RunpageLink = Vehicule = FIELD("N° Vehicule");
                    }
                    action("Ecritures taxes")
                    {
                        ApplicationArea = all;
                        Caption = 'Ecritures taxes';
                        RunObject = Page "Liste taxe";
                        RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
                    }
                }
                action(Image)
                {
                    ApplicationArea = all;
                    Caption = 'Image';
                    RunObject = Page "Image Véhicule";
                }
                action("Historique prise de carburant")
                {
                    ApplicationArea = all;
                    Caption = 'Historique prise de carburant';
                    RunObject = Page "Historique Prise de Carburant";
                    RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
                }
                action("Historique PR")
                {
                    ApplicationArea = all;
                    Caption = 'Historique PR';
                    RunObject = Page "Item Ledger Entries";
                    RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
                }
                /*GL2024   action("Réparation préventive")
                   {
                       ApplicationArea = all;
                       Caption = 'Réparation préventive';
                       //GL3900   RunObject = Page "Veh. Rep. Préventive";
                       //GL3900   RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
                   }
                   action("Hist Carte Autoroute")
                   {
                       ApplicationArea = all;
                       Caption = 'Hist Carte Autoroute';
                       //GL3900   RunObject = Page "Carte Autoroute Enreg";
                       //GL3900   RunPageLink = "N° Véhicule" = FIELD("N° Vehicule");
                   }*/
                action("Creer Nouveau Engin")
                {
                    ApplicationArea = all;
                    Caption = 'Creer Nouveau Engin';

                    trigger OnAction()
                    begin
                        IF NOT CONFIRM(Text001) THEN EXIT;
                        Vehicule2.SETFILTER("N° Vehicule", COPYSTR(REC."N° Vehicule", 1, 4) + '*');
                        IF Vehicule2.FINDLAST THEN BEGIN
                            Vehicule.COPY(Vehicule2);
                            Numero := Vehicule2."N° Vehicule";
                            //DYS a verifier
                            NoSeriesManagement.IncrementNoText(Numero, 1);
                            Vehicule."N° Vehicule" := Numero;
                            Vehicule.INSERT;
                            MESSAGE(Text002, Vehicule."N° Vehicule");
                        END;
                    end;
                }
            }
            /*   GL2024    group(Planning)
                {
                    Caption = 'Planning';
                    action("Disponibilitée Véhicule")
                    {
                        ApplicationArea = all;
                        Caption = 'Disponibilitée Véhicule';

                        trigger OnAction()
                        begin
                            CLEAR(Dispo);
                            Dispo.Set(Rec, 0);
                            Dispo.RUNMODAL;
                            CurrPage.UPDATE(FALSE);
                        end;
                    }
                }*/
            group("Fixed &Asset")
            {
                Caption = 'I&mmo.';
                action("Depreciation &Books")
                {
                    ApplicationArea = all;
                    Caption = 'Plan d''am&ortissement';
                    Image = DepreciationBooks;
                    RunObject = Page "FA Depreciation Books";
                    RunPageLink = "FA No." = FIELD("Code Immo");
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = all;
                    Caption = 'Ecrit&ures';
                    RunObject = Page "FA Ledger Entries";
                    RunPageLink = "FA No." = FIELD("Code Immo");
                    RunPageView = SORTING("FA No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = all;
                    Caption = 'Co&mmentaires';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Fixed Asset"), "No." = FIELD("Code Immo");
                }
                action(Dimensions)
                {
                    ApplicationArea = all;
                    Caption = 'A&xes analytiques';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "No." = FIELD("Code Immo");
                    ShortCutKey = 'Maj+Ctrl+D';
                }
                action(Picture)
                {
                    ApplicationArea = all;
                    Caption = 'Image';
                    RunObject = Page "Fixed Asset Picture";
                    RunPageLink = "No." = FIELD("No. Series");
                }
                action("M&ain Asset Components")
                {
                    ApplicationArea = all;
                    Caption = '&Composants immo. principale';
                    RunObject = Page "Main Asset Components";
                    RunPageLink = "Main Asset No." = FIELD("Code Immo");
                }

                action(Statistics)
                {
                    ApplicationArea = all;
                    Caption = 'Statistiques';
                    Image = Statistics;

                    RunObject = Page "Fixed Asset Statistics";
                    RunPageLink = "FA No." = FIELD("Code Immo");
                    ShortCutKey = 'Ctrl+F11';
                }
                // action(Lien)
                // {
                //     ApplicationArea = all;
                //     Caption = 'Lien';
                //     RunObject = Page "Lien Materiel - Immobilisation";
                //     RunPageLink = "N° Materiel" = FIELD("N° Vehicule");
                // }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // >> HJ DSFT 03-06-2012
        IF RecUserSetup.GET(UPPERCASE(USERID)) THEN;
        //  CurrPage.EDITABLE(RecUserSetup."Modif Materiel");

        // ShowMouvements := Rec."N° Vehicule" <> '';
    end;

    trigger OnOpenPage()
    begin
        // >> HJ DSFT 03-06-2012
        /* IF RecUserSetup.GET(UPPERCASE(USERID)) THEN;
         CurrPage.EDITABLE(RecUserSetup."Modif Materiel");*/
        // >> HJ DSFT 24-03-2012;
        //GL2024   CurrPage.EDITABLE(FALSE);
        // HJ DSFT 24-03-2012
    end;

    var
        Dispo: Page "Dispo. Véhicule";
        LigneGasoil: Record "Ligne Fiche Gasoil";
        RecUserSetup: Record "User Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        Vehicule: Record "Véhicule";
        Text001: Label 'Creer Nouveau Vehicule Dans ette Grande Famille ?';
        Text002: Label 'Engin N° %1 à Eté Créer';
        Vehicule2: Record "Véhicule";
        Numero: Code[20];

    // [InDataSet]
    //  ShowMouvements: Boolean;
}

