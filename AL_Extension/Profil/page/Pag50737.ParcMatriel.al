page 50737 "Parc_Matriel"
{
    ApplicationArea = All;
    Caption = 'Tableau de bord ';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {

            // Tu peux ajouter ici des tuiles ou part si nécessaire
            part(Headlines; "Surveillant Headline")
            {
                caption = 'Hello';
            }
            // part(Magasin; CueMagasin)
            // {
            // }
            part(Statistiques; CueCaisse)
            {
            }
            part(AffectationVeh; CueAffectationVehicule)
            {
            }
            part(Véhicules; CueVehicule)
            {
            }
            part("Cue Réparation"; "Cue Réparation")
            {
            }
            part("CueGasoil"; "CueGasoil")
            {

            }
        }
    }
    actions
    {
        area(Sections)
        {

            group("Véhicules1")
            {
                Caption = 'Véhicules';
                action("Liste Véhicules.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Liste Véhicules';
                    RunObject = page "List Véhicules";
                    ToolTip = 'Liste Véhicules';
                }
            }
            /*action("Suivie Engins")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Suivie Engins';
                    RunObject = page "Suivi Engins";
                    ToolTip = 'Suivie Engins';
                }*/

            // Pointage Vehicule ...........
            group("Pointage Véhicules")
            {

                action("Liste Pointage ouvert")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Liste Pointage ouvert';
                    RunObject = page "Liste Entete Pointage";
                    ToolTip = 'Liste Pointage ouvert';
                }
                action("Liste Pointage Validée")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Liste Pointage Validée';
                    RunObject = page "Liste Entete Pointage Veh En.";
                    ToolTip = 'Liste_Pointage_Validée';
                }

            }
            group("Gasoil")
            {
                Caption = 'Gasoil';

                action("Fiche Gasoil")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Fiche Gasoil';
                    RunObject = page "Entete Gasoil";
                    ToolTip = 'Afficher la liste des Demandes Achat';
                }
                action("Fiche Gasoil validé")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Fiche Gasoil validé';
                    RunObject = page "Liste Gasoil Validé";
                    ToolTip = 'Afficher la liste des Demandes Achat';
                }
            }
            group("Caisse")
            {
                Caption = 'Caisse';

                action("Caisse Chantier")
                {
                    ApplicationArea = All;
                    Caption = 'Caisse Chantier';
                    RunObject = page "Liste Caisse Chantier";
                    ToolTip = 'Afficher la Liste Caisse Chantier.';
                }

            }
            group(Exécution)
            {
                action("Liste Missions")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Liste Missions';
                    RunObject = page "Liste Missions";

                }

                // action("Liste Accidents")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Liste Accidents';
                //     RunObject = page "Liste Accidents";

                // }
                action("Liste Réparation")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Liste Réparation';
                    RunObject = page "Liste Réparation";

                }
                action(Affectation)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Affectation';
                    RunObject = page Affectation;

                }


            }

            group(Traitements)
            {
                action("Liste taxe")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Liste taxe';
                    RunObject = page "Liste taxe";

                }
                action("Liste Vignettes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Liste Vignettes';
                    RunObject = page "Liste Vignettes";

                }





            }
            group(Historique)
            {
                action("Historique Affectation")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Historique Affectation';
                    RunObject = page "Historique Affectation";

                }

                action("Liste Missions enreg")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Liste Missions enreg';
                    RunObject = page "Liste Missions enreg.";

                }

                action("Liste Réparation Validé")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Liste Réparation Validé';
                    RunObject = page "Liste Réparation Validé";

                }




            }
            group(Paramétres)
            {
                action("Paramétre Parc")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Paramétre Parc';
                    RunObject = page "Paramétre Parc";

                }

                action("Energie")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Energie';
                    RunObject = page "Energie";

                }

                action("Catégorie Véhicule")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Catégorie Véhicule';
                    RunObject = page "Catégorie Véhicule";

                }





            }

            group("Les Alertes")
            {
                action("Alertes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Alertes';
                    RunObject = page "Alertes";
                    ToolTip = 'Alertes';
                }
                action("Alerte Seuil min")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Alerte Seuil min';
                    RunObject = page "Alerte Seuil min";
                    ToolTip = 'Alerte Seuil min';
                }
                action("Alerte DA")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Alerte DA';
                    RunObject = page "Alerte DA";
                    ToolTip = 'Alerte DA';
                }
                action("Alerte  Vidange Moteur")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Alerte  Vidange Moteur';
                    RunObject = page "Alerte  Vidange Moteur";
                    ToolTip = 'Alerte  Vidange Moteur';
                }
                action("Alerte vidange boite")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Alerte vidange boite';
                    RunObject = page "Alerte vidange boite";
                    ToolTip = 'Alerte vidange boite';
                }
                action("Alerte vidange 1000H")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Alerte vidange 1000H';
                    RunObject = page "Alerte vidange 1000H";
                    ToolTip = 'Alerte vidange 1000H';
                }
                action("Alerte vidange 2000H")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Alerte vidange 2000H';
                    RunObject = page "Alerte vidange 2000H";
                    ToolTip = 'Alerte vidange 2000H';
                }
                action("Alerte chaine")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Alerte chaine';
                    RunObject = page "Alerte chaine";
                    ToolTip = 'Alerte chaine';
                }
                action("Alerte Fiche Gasoil")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Alerte Fiche Gasoil';
                    RunObject = page "Alerte Fiche Gasoil";
                    ToolTip = 'Alerte Fiche Gasoil';
                }
                action("Alerte Compteur Panne")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Alerte Compteur Panne';
                    RunObject = page "Compteur Panne";
                    ToolTip = 'Alerte Compteur Panne';
                }
                action("Alerte Papier")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Alerte Papier';
                    RunObject = page "Alerte Papier";
                    ToolTip = 'Alerte Alerte Papier';
                }
                action("Alerte Imminente DA")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Alerte Imminente DA';
                    RunObject = page "Alerte Imminente DA";
                    ToolTip = 'Alerte Imminente DA';
                }
                // action("Alerte  Frequence Changement")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Alerte  Frequence Changement';
                //     RunObject = page "Alerte  Frequence Changement";
                //     ToolTip = 'Alerte  Frequence Changement';

                // }
            }

        }
        area(Embedding)
        {
            action("Liste_Véhicule")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Liste Véhicule';
                RunObject = page "List Véhicules";
                ToolTip = 'Liste_Véhicule';
            }
            // action("Mouvements stock Véhicule")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Mouvements stock Véhicule';
            //     RunObject = page 50753;
            //     ToolTip = 'Mouvements stock Véhicules';
            // }
            action("Article")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Article';
                RunObject = page "Item List";
                ToolTip = 'Consulter la liste des Articles';
            }
            // action("Article de Service")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Article de Service';
            //     RunObject = page "Article Service Liste";
            //     ToolTip = 'Consulter la liste des Articles';
            // }
            action("Demandes Achat ")
            {
                ApplicationArea = Basic, Suite;
                Caption = ' Demandes Achat';
                RunObject = page "Purchase Request List";
                ToolTip = 'Consulter la liste Demandes Achat ';
            }
            action("Demandes Achat Approuvé")
            {
                ApplicationArea = Basic, Suite;
                Caption = ' Demandes Achat Approuvé';
                RunObject = page "Purchase Request List Approved";
                ToolTip = 'Consulter la liste Demandes Achat ';
            }
            action("Commande Achat ")
            {
                ApplicationArea = Basic, Suite;
                Caption = ' Commande Achat';
                RunObject = page 53;
                ToolTip = 'Consulter la liste Demandes Achat ';
            }
            action("Liste Réception achat")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Liste Réception achat';
                RunObject = page "Liste Réception achat";

            }
            action("Feuilles reclassement article")
            {
                ApplicationArea = All;
                Caption = 'Feuilles reclassement article';
                RunObject = Page "Item Reclass. Journal";

            }
        }
        area(Creation)
        {
            action("Nouveau Fiche Véhicule")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Nouveau Fiche Véhicule';
                RunObject = page "Fiche Véhicule";
                ToolTip = 'Nouveau Fiche Véhicule';
                RunPageMode = Create;
                Image = Create;
            }
            action("Nouveau Fiche Réparation")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Nouveau Fiche Réparation';
                RunObject = page "En-Tête Réparation";
                ToolTip = 'Nouveau Fiche Réparation';
                RunPageMode = Create;
                Image = Create;
            }
            action("Nouveau Fiche Mission")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Nouveau Fiche Mission';
                RunObject = page "Fiche Mission";
                ToolTip = 'Nouveau Fiche Mission';
                RunPageMode = Create;
                Image = Create;
            }
            // action("Nouveau Pointage Journalière")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Nouveau Pointage Journalière';
            //     RunObject = page "Entete Pointage Journalier";
            //     ToolTip = 'Nouveau Pointage Journalière';
            //     RunPageMode = Create;
            //     Image = Create;
            // }
        }
        // area(Reporting)
        // {
        // }
    }
}
