page 52049026 "Ligne rapport Chantier Engins"
{//  id dans nav"39004765"
    PageType = Card;
    SourceTable = "Ligne Rapport Chantier";
    SourceTableView = WHERE(Ressource = CONST(Engins));

    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                ShowCaption = false;
                field(Materiel; rec.Materiel)
                {
                }
                field(Conducteur; rec.Conducteur)
                {
                }
                field("Heure Debut"; rec."Heure Debut")
                {
                }
                field("Heure Fin"; rec."Heure Fin")
                {
                }
                field("Compteur En Panne"; rec."Compteur En Panne")
                {
                }
                field("Index Depart"; rec."Index Depart")
                {
                }
                field("Index Final"; rec."Index Final")
                {
                }
                field("Heure Debut Panne"; rec."Heure Debut Panne")
                {
                }
                field("Heure Fin Panne"; rec."Heure Fin Panne")
                {
                }
                field("Tot Heure"; rec."Tot Heure")
                {
                }
                field("Tot M3"; rec."Tot M3")
                {
                }
                field("% Occupation"; rec."% Occupation")
                {
                }
                field(Localisation; rec.Localisation)
                {
                }
                field(Observation; rec.Observation)
                {
                }
                field(Cout; rec.Cout)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.Ressource := rec.Ressource::Engins;
    end;
}

