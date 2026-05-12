page 50180 "Alerte chaine"
{
    PageType = List;
    SourceTable = "Véhicule";
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Alerte chaine';
    layout
    {
        area(content)
        {
            repeater("")
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
                field("Vidange A 3"; rec."Vidange A 3")
                {
                    ApplicationArea = all;
                }
                field("Alerte avant 3"; rec."Alerte avant 3")
                {
                    ApplicationArea = all;
                }
                field("Dernier vidange 3"; rec."Dernier vidange 3")
                {
                    ApplicationArea = all;
                }
                field("Prochain vidange 3"; rec."Prochain vidange 3")
                {
                    ApplicationArea = all;
                }
                field("Reste pour alerte 3"; rec."Reste pour alerte 3")
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
        rec.SETFILTER("Reste pour alerte 3", '<=%1', 0);
        rec.SETFILTER("Prochain vidange 3", '<>%1', 0);
        rec.SETFILTER("Compteur Actuel", '<>%1', 0);
        IF rec.COUNT = 0 THEN CurrPage.CLOSE;
    end;

    var
        Vehicule: Record "Véhicule";
        "ParamétreParc": Record "Paramétre Parc";
}

