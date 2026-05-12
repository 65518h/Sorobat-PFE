page 52049027 "Mission Enregistré"
{//GL2024  ID dans Nav 2009 : "39004689"
    Editable = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Mission Enregistré";
    SourceTableView = WHERE(Status = FILTER(Lancée | Modifiée));
    ApplicationArea = All;
    Caption = 'Mission Enregistré';

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Général';
                field("N° Mission"; REC."N° Mission")
                {
                    ApplicationArea = all;
                }
                field("N° Affaire"; REC."N° Affaire")
                {
                    ApplicationArea = all;
                }
                field("N° Tache Affaire"; REC."N° Tache Affaire")
                {
                    ApplicationArea = all;
                }
                field("Centre de Gestion"; REC."Centre de Gestion")
                {
                    ApplicationArea = all;
                }
                field("Date document"; REC."Date document")
                {
                    ApplicationArea = all;
                }
                field("Date Mission"; REC."Date Mission")
                {
                    ApplicationArea = all;
                }
                field("Code Demandeur"; REC."Code Demandeur")
                {
                    ApplicationArea = all;
                }
                field("Nom Demandeur"; REC."Nom Demandeur")
                {
                    ApplicationArea = all;
                }
                field("Fonction Demandeur"; REC."Fonction Demandeur")
                {
                    ApplicationArea = all;
                }
                field("Objet mission"; REC."Objet mission")
                {
                    ApplicationArea = all;
                }
                field("Date Départ"; REC."Date Départ")
                {
                    ApplicationArea = all;
                }
                field("Date Arrivée"; REC."Date Arrivée")
                {
                    ApplicationArea = all;
                }
                field("Lieu départ"; REC."Lieu départ")
                {
                    ApplicationArea = all;
                }
                field("Lieu Arrivé"; REC."Lieu Arrivé")
                {
                    ApplicationArea = all;
                }
                field("Heure Départ"; REC."Heure Départ")
                {
                    ApplicationArea = all;
                }
                field("Heure Arrivée"; REC."Heure Arrivée")
                {
                    ApplicationArea = all;
                }
            }
            group("Véhicule")
            {
                Caption = 'Véhicule';
                field("Type Vehicule Mission"; REC."Type Vehicule Mission")
                {
                    ApplicationArea = all;
                }
                field("N° Véhicule"; REC."N° Véhicule")
                {
                    ApplicationArea = all;
                }
                field("No. Immatriculation"; REC."No. Immatriculation")
                {
                    ApplicationArea = all;
                }
                field("Type Véhicule"; REC."Type Véhicule")
                {
                    ApplicationArea = all;
                }
                field("Puissance Véhicule"; REC."Puissance Véhicule")
                {
                    ApplicationArea = all;
                }
                field("Index Cpt. Depart"; REC."Index Cpt. Depart")
                {
                    ApplicationArea = all;
                }
                field("Index Cpt. Retour"; REC."Index Cpt. Retour")
                {
                    ApplicationArea = all;
                }
                field("Km Parcourus"; REC."Km Parcourus")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
            group("Prise de carburant")
            {
                Caption = 'Prise de carburant';
                part(lign; "Prise carburant Enregistré")
                {
                    ApplicationArea = all;
                    SubPageLink = "N° Véhicule" = FIELD("N° Véhicule"), "N° Mission" = FIELD("N° Mission");
                }
            }
            group("Frais du transporteur")
            {
                Caption = 'Frais du transporteur';
                field("Nbre Heure Prepara marchandise"; REC."Nbre Heure Prepara marchandise")
                {
                    ApplicationArea = all;
                }
                field("Total Frais deplacement1"; REC."Total Frais deplacement")
                {
                    ApplicationArea = all;
                }
                field("Coût  Marchandise"; REC."Coût  Marchandise")
                {
                    ApplicationArea = all;
                }
                field("Coût de kilometrage"; REC."Coût de kilometrage")
                {
                    ApplicationArea = all;
                }
                field("Coût de livraison"; REC."Coût de livraison")
                {
                    ApplicationArea = all;
                }
                field("Nbre heure"; REC."Nbre heure")
                {
                    ApplicationArea = all;
                }
                field("Total Frais deplacement"; REC."Total Frais deplacement")
                {
                    ApplicationArea = all;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
        Area(Promoted)
        {
            group("Véhicule21")
            {
                Caption = 'Véhicule';
                actionref(Fiche1; Fiche) { }

            }
            group(Mission1)
            {
                Caption = 'Mission';

                //GL2024   actionref(Chargement1; Chargement) { }
                //GL2024  actionref("Prise de Carburant21"; "Prise de Carburant2") { }
                group("Modifier Fiche de mission1")
                {
                    Caption = 'Modifier Fiche de mission';
                    actionref(Modifier1; Modifier) { }
                    actionref(Annuler1; Annuler) { }

                }
            }

            actionref("&Navigate1"; "&Navigate") { }

        }
        area(navigation)
        {
            group("Véhicule2")
            {
                Caption = 'Véhicule';
                action(Fiche)
                {
                    ApplicationArea = all;
                    Caption = 'Fiche';
                    RunObject = Page "Fiche Véhicule";
                    RunPageLink = "N° Vehicule" = FIELD("N° Véhicule");
                }

            }
            group(Mission)
            {
                Caption = 'Mission';

                /*GL2024 action(Chargement)
                    {
                        ApplicationArea = all;
                        Caption = 'Chargement';
                        RunObject = Page "Ligne Rendement Vehicule Enreg";
                       RunPageLink = Field28=FIELD("N° Mission"), Journee=FIELD("N° Véhicule");
                    }*/

                action("Prise de Carburant2")
                {
                    ApplicationArea = all;
                    Caption = 'Prise de Carburant';
                    RunObject = Page "Prise carburant Enregistré";
                    RunPageLink = "N° Véhicule" = FIELD("N° Véhicule"), "N° Mission" = FIELD("N° Mission");
                }
                /*GL2024    action("Carte Autoroute")
                    {
                        ApplicationArea = all;
                        Caption = 'Carte Autoroute';
                        RunObject = Page "Carte Autoroute Enreg";
                        RunPageLink = "N° Mission" = FIELD("N° Mission"), "N° Véhicule" = FIELD("N° Véhicule");
                    }*/

                group("Modifier Fiche de mission")
                {
                    Caption = 'Modifier Fiche de mission';
                    action(Modifier)
                    {
                        ApplicationArea = all;
                        Caption = 'Modifier';

                        trigger OnAction()
                        begin
                            IF CONFIRM('Voulez vous modifier la fiche mission', FALSE) THEN
                                CurrPage.EDITABLE := TRUE
                            ELSE
                                CurrPage.EDITABLE := FALSE;
                        end;
                    }
                    action(Annuler)
                    {
                        ApplicationArea = all;
                        Caption = 'Annuler';

                        trigger OnAction()
                        begin
                            IF CONFIRM('Voulez vous Annulez la fiche mission', FALSE) THEN BEGIN
                                REC.Status := REC.Status::Annulée;
                                REC.MODIFY;
                            END;
                        end;
                    }
                }
            }
        }
        area(processing)
        {
            action("&Navigate")
            {
                ApplicationArea = all;
                Caption = '&Navigate';
                Image = Navigate;


                trigger OnAction()
                begin
                    REC.Navigate;
                end;
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        REC.Status := REC.Status::Modifiée;
        REC.MODIFY;
    end;

    var
        MissionEnreg: Record "Mission Enregistré";
        PCarEnreg: Record "Prise carburant Enregistré";
        Pcar: Record "Prise carburant";
}

