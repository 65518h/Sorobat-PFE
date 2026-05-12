page 50179 "Alerte vidange 2000H"
{
    PageType = List;
    SourceTable = Véhicule;
    Caption = 'Alerte vidange 2000H';
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(" ")
            {
                ShowCaption = false;
                field("N° Vehicule"; rec."N° Vehicule")
                {
                    ApplicationArea = all;
                }
                field(Désignation; rec.Désignation)
                {
                    ApplicationArea = all;
                }
                field("No. Series"; rec."No. Series")
                {
                    ApplicationArea = all;
                }
                field("Vidange A 2"; rec."Vidange A 2")
                {
                    ApplicationArea = all;
                }
                field("Alerte avant 2"; rec."Alerte avant 2")
                {
                    ApplicationArea = all;
                }
                field("Dernier vidange 2"; rec."Dernier vidange 2")
                {
                    ApplicationArea = all;
                }
                field("Prochain vidange 2"; rec."Prochain vidange 2")
                {
                    ApplicationArea = all;
                }
                field("Reste pour alerte 2"; rec."Reste pour alerte 2")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        IF ParamétreParc.GET THEN
            IF ParamétreParc."Filtre Chantier" <> '' THEN rec.SETRANGE(marche, ParamétreParc."Filtre Chantier");
        rec.SETFILTER("Reste pour alerte 2", '<=%1', 0);
        rec.SETFILTER("Prochain vidange 2", '<>%1', 0);
        rec.SETFILTER("Compteur Actuel", '<>%1', 0);
        IF rec.COUNT = 0 THEN CurrPage.CLOSE;
    end;

    var
        Vehicule: Record "Véhicule";
        "ParamétreParc": Record "Paramétre Parc";
}

