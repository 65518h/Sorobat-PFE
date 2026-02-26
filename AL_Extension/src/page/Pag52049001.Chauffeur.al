Page 52049001 Chauffeur
{//GL2024  ID dans Nav 2009 : "39004751"
    PageType = List;
    SourceTable = "Chauffeur Location";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000002)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Nom; Rec.Nom)
                {
                    ApplicationArea = Basic;
                }
                field("Salaire Journalier"; Rec."Salaire Journalier")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        Dispo: Page "Dispo. Véhicule";
}

