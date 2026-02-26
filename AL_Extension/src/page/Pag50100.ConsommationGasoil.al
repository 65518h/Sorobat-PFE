page 50100 "Consommation Gasoil"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = 50017;
    SourceTableView = SORTING(Materiel, Journee, Heure);

    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                ShowCaption = false;
                field(Heure; rec.Heure)
                {
                }
                field(Journee; rec.Journee)
                {
                }
                field(Affaire; rec.Affaire)
                {
                }
                field("Valeur Compteur"; rec."Valeur Compteur")
                {
                }
                field(Consommation; rec.Consommation)
                {
                }
                field("Compteur En Panne"; rec."Compteur En Panne")
                {
                }
                field(Chauffeur; rec.Chauffeur)
                {
                }
                field(Destination; rec.Destination)
                {
                }
                field("Quantité Gasoil"; rec."Quantité Gasoil")
                {
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
    }
}

