page 50081 "Liste Véhicules Bloqués"
{
    Editable = true;
    PageType = list;
    SourceTable = Véhicule;
    SourceTableView = WHERE(Bloquer = CONST(true));

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
                field(Transformation; rec.Transformation)
                {
                    Editable = false;
                }
                field("Type de Carburant"; rec."Type de Carburant")
                {
                    Editable = false;
                }
                field(Bloquer; rec.Bloquer)
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Famille; rec.Famille)
                {
                    Editable = false;
                }
                field("Sous Famille"; rec."Sous Famille")
                {
                    Editable = false;
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

                /*  action("Carte Grise")
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

