Page 50171 "Alerte Fiche Gasoil"
{
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Ligne Fiche Gasoil";
    //  SourceTableView = sorting(Materiel, Journee, Heure);
    SourceTableView = SORTING(Materiel, Journee, Heure)
                    WHERE("Consommation Max" = FILTER(<> 0));
    ApplicationArea = all;
    Caption = 'Alerte Fiche Gasoil';

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = true;
                ShowCaption = false;
                field(Journee; REC.Journee)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Heure; REC.Heure)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Materiel; REC.Materiel)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Immatricule Vehicule"; REC."Immatricule Vehicule")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Quantité Gasoil"; REC."Quantité Gasoil")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Valeur Compteur"; REC."Valeur Compteur")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Dernier Index"; Rec."Dernier Index")
                {
                    ApplicationArea = all;
                }
                field("Consommation Max"; REC."Consommation Max")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Trajet; Rec."Valeur Compteur" - Rec."Dernier Index")
                {
                    ApplicationArea = all;
                }
                field(Ecart; Rec.Consommation - Rec."Consommation Max")
                {
                    ApplicationArea = all;
                }
                field(Consommation; REC.Consommation)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field(Cuve; REC.Cuve)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Affaire; REC.Affaire)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Destination; REC.Destination)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = true;
                }
                field("Alerte Consommation Gasoil"; REC."Alerte Consommation Gasoil")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CurrPage.Editable := true;
        REC.Utilisateur := UpperCase(UserId);
    end;

    var
        Text003: label 'Type Indexe Different De Horraire';
        Text004: label 'Type Index Different De Kilometrage';
        Text005: label 'Vous Devez Choisir Une Cuve';
        RecEnteteFicheGasoil: Record "Entete Fiche Gasoil";
}

