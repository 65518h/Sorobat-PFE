page 50328 "Liste Equipements"
{//GL2024 NEW PAGE
    PageType = List;
    SourceTable = "Véhicule";
    ApplicationArea = All;
    Caption = 'Liste Equipements';
    UsageCategory = Lists;
    Editable = false;
    //   CardPageId = "Fiche Equipements";

    layout
    {
        area(content)
        {
            repeater("Général")
            {
                Caption = 'Général';
                field("N° Vehicule"; REC."N° Vehicule")
                {
                    ApplicationArea = all;
                    Caption = 'N° Equipement';



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
                field(Famille; REC.Famille)
                {
                    ApplicationArea = all;
                    Caption = 'Famille';
                }
                field("Sous Famille"; REC."Sous Famille")
                {
                    ApplicationArea = all;
                    Caption = 'Sous-Famille';
                }
                field(Emplacement; REC.Emplacement)
                {
                    ApplicationArea = all;
                }
                field(Bloquer; REC.Bloquer)
                {
                    ApplicationArea = all;
                }
                field(Puissance1; REC.Puissance)
                {
                    ApplicationArea = all;
                }
                field("Type Index"; REC."Type Index")
                {
                    ApplicationArea = all;
                }
                field(Statut; REC.Statut)
                {
                    ApplicationArea = all;
                }
                field(Marche; REC.Marche)
                {
                    ApplicationArea = all;
                }
                field("Sous Affaire"; REC."Sous Affaire")
                {
                    ApplicationArea = all;
                }
                // field(Societe; REC.Societe)
                // {
                //     ApplicationArea = all;
                // }
                field(Fournisseurs; REC.Fournisseurs)
                {
                    ApplicationArea = all;
                }

                field("Kms Parcourus1"; REC."Kms Parcourus")
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
                field("Nom Fournisseurs"; REC."Nom Fournisseurs")
                {
                    ApplicationArea = all;
                    Editable = false;
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
                field(Marque1; REC.Marque)
                {
                    ApplicationArea = all;
                }
                // field("Type Marque1"; REC."Type Marque")
                // {
                //     ApplicationArea = all;
                // }
                // field("Gamme Debut"; REC."Gamme Debut")
                // {
                //     ApplicationArea = all;
                //     DecimalPlaces = 0 : 0;
                //     Editable = false;
                // }
                // field("Gamme Fin"; REC."Gamme Fin")
                // {
                //     ApplicationArea = all;
                //     DecimalPlaces = 0 : 0;
                //     Editable = false;
                // }
                // field("Gamme Actif"; REC."Gamme Actif")
                // {
                //     ApplicationArea = all;
                //     Editable = true;
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
                // field("Dernier Index"; REC."Dernier Index")
                // {
                //     ApplicationArea = all;
                //     Editable = true;
                //     Style = Unfavorable;
                //     StyleExpr = TRUE;
                // }
                // field("Date Dernier Index"; REC."Date Dernier Index")
                // {
                //     ApplicationArea = all;
                //     Style = Unfavorable;
                //     StyleExpr = TRUE;
                // }


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
                field("Kms Parcourus"; REC."Kms Parcourus")
                {
                    ApplicationArea = all;
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
                field("Code Emplacement"; REC."Code Emplacement")
                {
                    ApplicationArea = all;
                }
                field("Date d'acquisition"; REC."Date d'acquisition")
                {
                    ApplicationArea = all;
                }


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
                }

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
                field(Type; REC.Type)
                {
                    ApplicationArea = all;
                }
                // field("Type Marque"; REC."Type Marque")
                // {
                //     ApplicationArea = all;
                // }
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
                field("Date Expiration Assurance"; REC."Date Expiration Assurance")
                {
                    ApplicationArea = all;
                }
                field("Date Exp Carte Exploitation"; REC."Date Exp Carte Exploitation")
                {
                    ApplicationArea = all;
                }


            }
        }
    }


}

