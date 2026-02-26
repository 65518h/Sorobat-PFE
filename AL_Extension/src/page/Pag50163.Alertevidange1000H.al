page 50163 "Alerte vidange 1000H"
{
    PageType = List;
    SourceTable = Véhicule;
    Caption = 'Alerte vidange 1000H';
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
                field("Vidange A 1000H"; rec."Vidange A 1000H")
                {
                    ApplicationArea = all;
                }
                field("Alerte avant 1000H"; rec."Alerte avant 1000H")
                {
                    ApplicationArea = all;
                }
                field("Dernier vidange 1000H"; rec."Dernier vidange 1000H")
                {
                    ApplicationArea = all;
                }
                field("Prochain vidange 1000H"; rec."Prochain vidange 1000H")
                {
                    ApplicationArea = all;
                }
                field("Reste pour alerte 1000H"; rec."Reste pour alerte 1000H")
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
        rec.SETFILTER("Reste pour alerte 1000H", '<=%1', 0);
        rec.SETFILTER("Prochain vidange 1000H", '<>%1', 0);
        rec.SETFILTER("Compteur Actuel", '<>%1', 0);
        IF rec.COUNT = 0 THEN CurrPage.CLOSE;
    end;

    var
        Vehicule: Record "Véhicule";
        "ParamétreParc": Record "Paramétre Parc";
}

