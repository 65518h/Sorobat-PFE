page 50082 "Liste Alertes Véhicules"
{
    Editable = false;
    PageType = Card;
    SourceTable = Véhicule;
    SourceTableView = WHERE(Bloquer = CONST(false));

    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                ShowCaption = false;
                field("N° Vehicule"; rec."N° Vehicule")
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Immatriculation; rec.Immatriculation)
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field(Désignation; rec.Désignation)
                {
                    Editable = false;
                }
                field("Compteur Actuel"; rec."Compteur Actuel")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(marche; rec.marche)
                {
                }
                field("Date Expiration AT"; rec."Date Expiration AT")
                {
                }
                field("Date Expiration Assurance"; rec."Date Expiration Assurance")
                {
                }
                field("Date Expiration Visite Tech"; rec."Date Expiration Visite Tech")
                {
                }
                field("Date Expiration Carte Jaune"; rec."Date Expiration Carte Jaune")
                {
                }
                field("Date Expiration Certificat de"; rec."Date Expiration Certificat de")
                {
                    Caption = 'Date Expiration Certificat de Non Imposition';
                }
                field("Date Expiration Vignette"; rec."Date Expiration Vignette")
                {
                }
                field(Conducteur; rec.Conducteur)
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Véhicule")
            {
                Caption = 'Véhicule';
                action(Fiche)
                {
                    Caption = 'Fiche';
                    RunpageLink = "N° Vehicule" = FIELD("N° Vehicule");
                    RunObject = Page "Fiche Véhicule";
                }

                /*GL2025  action("Carte Grise")
                  {
                      Caption = 'Carte Grise';
                      RunpageLink = "N° Veh"=FIELD("N° Vehicule");
                      RunObject = Page "Carte Grise"; 
                  }*/
                action("Historique Vignette")
                {
                    Caption = 'Historique Vignette';
                    RunpageLink = "N° Veh" = FIELD("N° Vehicule");
                    RunObject = Page "Liste Vignettes";
                }
                action(Pneumatique)
                {
                    Caption = 'Pneumatique';
                    RunpageLink = "N° Véhicule" = FIELD("N° Vehicule");
                    RunObject = Page "Pneumatique";
                }

                action("Historique Affectation")
                {
                    Caption = 'Historique Affectation';
                    RunpageLink = "N° Véhicule" = FIELD("N° Vehicule");
                    RunObject = Page "Historique Affectation";
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        REC.SETCURRENTKEY(Famille);
    end;
}

