page 50178 "Alerte vidange boite"
{
    PageType = List;
    SourceTable = Véhicule;
    Caption = 'Alerte vidange boite';
    UsageCategory = Lists;
    ApplicationArea = all;

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
                field("Vidange A 1"; rec."Vidange A 1")
                {
                    ApplicationArea = all;
                }
                field("Alerte avant 1"; rec."Alerte avant 1")
                {
                    ApplicationArea = all;
                }
                field("Dernier vidange 1"; rec."Dernier vidange 1")
                {
                    ApplicationArea = all;
                }
                field("Prochain vidange 1"; rec."Prochain vidange 1")
                {
                    ApplicationArea = all;
                }
                field("Reste pour alerte 1"; rec."Reste pour alerte 1")
                {
                    ApplicationArea = all;
                }
                field(Désignation; rec.Désignation)
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
        rec.SETFILTER("Reste pour alerte 1", '<=%1', 0);
        rec.SETFILTER("Prochain vidange 1", '<>%1', 0);
        rec.SETFILTER("Compteur Actuel", '<>%1', 0);
        IF rec.COUNT = 0 THEN CurrPage.CLOSE;
    end;

    var
        Vehicule: Record "Véhicule";
        "ParamétreParc": Record "Paramétre Parc";
}

