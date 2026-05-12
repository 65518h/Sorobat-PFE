page 50102 "Compteur Panne"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = 50017;
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTableView = SORTING(Materiel, Journee, Heure) WHERE("Compteur En Panne" = CONST(true));

    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                ShowCaption = false;
                Editable = false;
                field(Heure; rec.Heure)
                {
                    ApplicationArea = all;
                }
                field("Filtre Materiel"; rec."Filtre Materiel")
                {
                    ApplicationArea = all;
                }
                field(Materiel; rec.Materiel)
                {
                    ApplicationArea = all;
                }
                field("Type Index"; rec."Type Index")
                {
                    ApplicationArea = all;
                }
                field("Compteur En Panne"; rec."Compteur En Panne")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Dernier Index"; rec."Dernier Index")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Valeur Compteur"; rec."Valeur Compteur")
                {
                    ApplicationArea = all;
                }
                field("Type Index1"; rec."Type Index")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Index Horaire"; rec."Index Horaire")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        IF rec."Type Index" <> rec."Type Index"::Horaire THEN ERROR(Text003);
                    end;
                }
                field("Index Kilometrique"; rec."Index Kilometrique")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        IF rec."Type Index" <> rec."Type Index"::Kilometrage THEN ERROR(Text004);
                    end;
                }
                field("Immatricule Vehicule"; rec."Immatricule Vehicule")
                {
                    ApplicationArea = all;
                }
                field(Affaire; rec.Affaire)
                {
                    ApplicationArea = all;
                }
                field(Utilisateur; rec.Utilisateur)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Chauffeur; rec.Chauffeur)
                {
                    ApplicationArea = all;
                }
                field(Destination; rec.Destination)
                {
                    ApplicationArea = all;
                }
                field("Quantité Gasoil"; rec."Quantité Gasoil")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Consommation Max"; rec."Consommation Max")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Consommation; rec.Consommation)
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Index 01"; rec."Index 01")
                {
                    ApplicationArea = all;
                }
                field("Index 02"; rec."Index 02")
                {
                    ApplicationArea = all;
                }
                field("Index 03"; rec."Index 03")
                {
                    ApplicationArea = all;
                }
                field("Index 04"; rec."Index 04")
                {
                }
                field("Filtre Immatriculation"; rec."Filtre Immatriculation")
                {
                    ApplicationArea = all;

                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Index de la Citerne"; rec."Index de la Citerne")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF RecEnteteFicheGasoil.GET(rec."Document No.") THEN;

        IF RecEnteteFicheGasoil.Statut = RecEnteteFicheGasoil.Statut::Valider THEN
            CurrPage.EDITABLE := FALSE
        ELSE
            CurrPage.EDITABLE := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CurrPage.EDITABLE := TRUE;
        rec.Utilisateur := UPPERCASE(USERID);
    end;

    trigger OnOpenPage()
    begin
        IF RecEnteteFicheGasoil.GET(rec."Document No.") THEN;
        IF RecEnteteFicheGasoil.Statut = RecEnteteFicheGasoil.Statut::Valider THEN
            CurrPage.EDITABLE := FALSE
        ELSE
            CurrPage.EDITABLE := TRUE;
    end;

    var
        Text003: Label 'Type Indexe Different De Horraire';
        Text004: Label 'Type Index Different De Kilometrage';
        Text005: Label 'Vous Devez Choisir Une Cuve';
        RecEnteteFicheGasoil: Record 50016;
}

