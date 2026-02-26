Page 52049008 "Liste Rendement"
{//GL2024  ID dans Nav 2009 : "39004759"
    Editable = false;
    PageType = List;
    SourceTable = "Entete rendement Vehicule";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Journee; Rec.Journee)
                {
                    ApplicationArea = Basic;
                }
                field(Provenance; Rec.Provenance)
                {
                    ApplicationArea = Basic;
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = Basic;
                }
                field(Vehicule; Rec.Vehicule)
                {
                    ApplicationArea = Basic;
                }
                field(Produit; Rec.Produit)
                {
                    ApplicationArea = Basic;
                }
                field(Marche; Rec.Marche)
                {
                    ApplicationArea = Basic;
                }
                field("Designation Affectation"; Rec."Designation Affectation")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

