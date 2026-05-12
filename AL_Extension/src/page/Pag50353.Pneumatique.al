page 50353 Pneumatique
{//GL2024  ID dans Nav 2009 : "39004683"
    PageType = Card;
    SourceTable = "Pneumatique Véhicule";
    SourceTableView = WHERE(Enlever = FILTER(FALSE));
    ApplicationArea = All;
    Caption = 'Pneumatique';


    layout
    {
        area(content)
        {
            repeater(general)
            {
                ShowCaption = false;
                field("Réf. Pneu"; rec."Réf. Pneu")
                {
                }
                field(Désignation; rec.Désignation)
                {
                }
                field("Marque Pneu"; rec."Marque Pneu")
                {
                }
                field("Type Pneu"; rec."Type Pneu")
                {
                }
                field("Date d'installation"; rec."Date d'installation")
                {
                }
                field("durée de vie"; rec."durée de vie")
                {
                }
                field(Diamétre; rec.Diamétre)
                {
                }
                field(Largeur; rec.Largeur)
                {
                }
                field(Position; rec.Position)
                {
                }
            }
        }
    }

    actions
    {
    }
}

