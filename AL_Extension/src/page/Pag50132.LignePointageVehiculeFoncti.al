Page 50132 "Ligne Pointage Vehicule Foncti"
{
    DelayedInsert = true;
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = ListPart;
    SourceTable = "Ligne Pointage Vehicule";
    SourceTableView = where(Statut = const(Fonctionnel));
    ApplicationArea = All;
    Caption = 'Ligne Pointage Vehicule Foncti';

    layout
    {
        area(content)
        {
            repeater(Control1120000)
            {
                ShowCaption = false;
                field(Vehicule; REC.Vehicule)
                {
                    ApplicationArea = all;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Marche; REC.Marche)
                {
                    ApplicationArea = all;
                }
                // field(Affectation; REC.Affectation)
                // {
                //     ApplicationArea = all;
                // }
                field("Sous Affectation Marche"; REC."Sous Affectation Marche")
                {
                    ApplicationArea = all;
                }
                field(Statut; REC.Statut)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        StatutOnAfterValidate;
                    end;
                }
                field("Index Depart"; REC."Index Depart")
                {
                    ApplicationArea = all;
                }
                field("Index Final"; REC."Index Final")
                {
                    ApplicationArea = all;
                }
                field("Heure Travailler"; REC."Heure Travailler")
                {
                    ApplicationArea = all;
                }
                field("Cout Horaire"; REC."Cout Horaire")
                {
                    ApplicationArea = all;
                }
                field("Heure Utilisation"; REC."Heure Utilisation")
                {
                    ApplicationArea = all;
                }
                field("Heure Immobilisation"; REC."Heure Immobilisation")
                {
                    ApplicationArea = all;
                }
                field("Cout Total Journee"; REC."Cout Total Journee")
                {
                    ApplicationArea = all;
                }
                field("Cout Heure Reel"; REC."Cout Heure Reel")
                {
                    ApplicationArea = all;
                }
                field("Cout Heure Immobilisation"; REC."Cout Heure Immobilisation")
                {
                    ApplicationArea = all;
                }
                field("Idex Kilometrique"; REC."Idex Kilometrique")
                {
                    ApplicationArea = all;
                }
                field(Gasoil; REC.Gasoil)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Cout Gasoil"; REC."Cout Gasoil")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Chauffeur; REC.Chauffeur)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        Text001: label 'Confirmer Cette Action ?';
        DteJournee: Date;
        RecVehicule: Record "Véhicule";
        SuiviVehiculeParStatut: Record "Linge Programmation";
        SuiviVehiculeParStatut2: Record "Linge Programmation";
        Text002: label 'Vous Devez Preciser La Journee';
        Text003: label 'Vous Devez D''abords Valider La Journee %1';
        Text004: label 'Journee Deja Saisie';

    local procedure StatutOnAfterValidate()
    begin
        CurrPage.Update;
    end;
}

