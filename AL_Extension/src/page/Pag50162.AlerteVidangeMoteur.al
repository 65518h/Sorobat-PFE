page 50162 "Alerte  Vidange Moteur"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Véhicule;
    SourceTableView = WHERE("Prochain Vidange" = FILTER(<> 0),
                            "Reste Pour Alerte" = FILTER(<> 0),
                            "Compteur Actuel" = FILTER(<> 0),
                            Statut = FILTER(> ' '),
                            "Dernier Vidange" = FILTER(<> 0));

    Caption = 'Alerte  Vidange Moteur';

    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {


        area(content)
        {
            // group("  ")
            // {
            //     ShowCaption = false;
            //     label("")
            //     {
            //         CaptionClass = '******************************************* ALERTE VIDANGE MOTEUR **************************************************';
            //         Style = Unfavorable;
            //         StyleExpr = TRUE;
            //         ApplicationArea = all;
            //     }
            // }


            repeater(" ")
            {
                ShowCaption = false;

                field("N° Vehicule"; rec."N° Vehicule")
                {
                    Editable = false;
                    Style = Unfavorable;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
                field(Désignation; rec.Désignation)
                {
                    Editable = false;
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Vidange A"; rec."Vidange A")
                {
                    ApplicationArea = all;
                }
                field("Reste Pour Alerte2"; rec."Reste Pour Alerte")
                {
                    ApplicationArea = all;
                }
                field("Prochain Vidange"; rec."Prochain Vidange")
                {
                    ApplicationArea = all;
                }
                field("Dernier Vidange"; rec."Dernier Vidange")
                {
                    ApplicationArea = all;
                }
                field("Compteur Actuel"; rec."Compteur Actuel")
                {
                    ApplicationArea = all;
                }
                field(marche; rec.marche)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Reste Pour Alerte"; rec."Reste Pour Alerte")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        IF Vehicule.GET(rec."N° Vehicule") THEN BEGIN
                            Vehicule."Reste Pour Alerte" := rec."Reste Pour Alerte";
                            Vehicule.MODIFY;
                        END;
                    end;
                }
                field("Compteur Actuel Vidange"; rec."Compteur Actuel Vidange")
                {
                    ApplicationArea = all;
                }
                field("Alerte Avant"; rec."Alerte Avant")
                {
                    ApplicationArea = all;
                }
                field("Reste Pour Alerte1"; rec."Reste Pour Alerte")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Vidange Effectué"; rec."Vidange Effectué")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        VidangeEffectu233OnPush;
                    end;
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
        rec.SETFILTER("Reste Pour Alerte", '<=%1', 0);
        rec.SETFILTER("Prochain Vidange", '<>%1', 0);
        rec.SETFILTER("Compteur Actuel", '<>%1', 0);
        IF rec.COUNT = 0 THEN CurrPage.CLOSE;
    end;

    var
        Vehicule: Record "Véhicule";
        Text001: Label 'Vidange Effectué ?';
        "ParamétreParc": Record "Paramétre Parc";
        Text19046538: Label '********************** ALERTE VIDANGE MOTEUR *****************************';

    local procedure VidangeEffectu233OnPush()
    begin
        IF NOT CONFIRM(Text001) THEN EXIT;
        IF Vehicule.GET(rec."N° Vehicule") THEN BEGIN
            Vehicule."Dernier Vidange" := rec."Compteur Actuel Vidange";
            Vehicule."Prochain Vidange" := rec."Compteur Actuel Vidange" + Vehicule."Vidange A";
            Vehicule."Reste Pour Alerte" := Vehicule."Prochain Vidange" - Vehicule."Compteur Actuel" - Vehicule."Alerte Avant";
            Vehicule."Vidange Effectué" := FALSE;
            Vehicule.MODIFY;
        END;
    end;
}

