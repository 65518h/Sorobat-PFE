Page 50048 "Ligne Fiche Gasoil"
{
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Ligne Fiche Gasoil";
    Caption = 'Ligne Fiche Gasoil';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Numero Ligne"; rec."Numero Ligne")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field(Journee; rec.Journee)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
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

                // field(Fournisseur; rec.Fournisseur)
                // {
                //     ApplicationArea = all;
                // }
                field("Nom Engin"; rec."Nom Engin")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Type Index"; rec."Type Index")
                {
                    ApplicationArea = all;

                    // Visible = false;
                }
                field("Compteur En Panne"; Rec."Compteur En Panne")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Dernier Index"; rec."Dernier Index")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = AttentionAccent;
                    StyleExpr = true;
                }
                field("Valeur Compteur"; rec."Valeur Compteur")
                {
                    ApplicationArea = all;
                }


                field("Index Horaire"; rec."Index Horaire")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if rec."Type Index" <> rec."type index"::Horaire then Error(Text003);
                    end;
                }
                field("Index Kilometrique"; rec."Index Kilometrique")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if rec."Type Index" <> rec."type index"::Kilometrage then Error(Text004);
                    end;
                }
                field("Immatricule Vehicule"; rec."Immatricule Vehicule")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Affaire; rec.Affaire)
                {
                    ApplicationArea = all;
                    Caption = 'Affaire';
                    Editable = false;
                    Enabled = true;
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
                    StyleExpr = true;
                }
                field("Consommation Max"; Rec."Consommation Max")
                {
                    ApplicationArea = all;
                    Style = AttentionAccent;
                    StyleExpr = true;
                }
                field(Consommation; rec.Consommation)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }


                // field("Cuve Destination"; rec."Cuve Destination")
                // {
                //     ApplicationArea = all;
                // }
                field(Observation; rec.Observation)
                {
                    ApplicationArea = all;
                }
                field("Filtre Immatriculation"; rec."Filtre Immatriculation")
                {
                    ApplicationArea = all;

                }
                field("Index de la Citerne"; rec."Index de la Citerne")
                {
                    ApplicationArea = all;

                }

            }
        }

    }


    trigger OnAfterGetRecord()
    begin
        if RecEnteteFicheGasoil.Get(rec."Document No.") then;

        /*GL2026   if RecEnteteFicheGasoil.Statut = RecEnteteFicheGasoil.Statut::Valider then
               CurrPage.Editable := false
           else
               CurrPage.Editable := true;*/
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        Header: Record "Entete Fiche Gasoil";
        LocationRec: Record Location;
    begin
        CurrPage.Editable := true;
        rec.Utilisateur := UpperCase(UserId);
    end;

    trigger OnOpenPage()
    begin
        if RecEnteteFicheGasoil.Get(rec."Document No.") then;
        /* GL2026    if RecEnteteFicheGasoil.Statut = RecEnteteFicheGasoil.Statut::Valider then
                CurrPage.Editable := false
            else
                CurrPage.Editable := true;*/
    end;



    var
        Text003: label 'Indexed Type Different from Schedule.';
        Text004: label 'Indexed Type Different from Mileage.';
        Text005: label 'You must choose a tank.';
        RecEnteteFicheGasoil: Record "Entete Fiche Gasoil";
}

