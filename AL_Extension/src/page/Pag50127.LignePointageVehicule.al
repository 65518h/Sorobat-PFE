Page 50127 "Ligne Pointage Vehicule"
{
    DelayedInsert = true;
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = ListPart;
    SourceTable = "Ligne Pointage Vehicule";
    SourceTableView = where(Statut = filter(<> Fonctionnel));
    ApplicationArea = All;
    Caption = 'Ligne Pointage Vehicule';

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
                    Editable = false;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Statut; REC.Statut)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;

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
                field("Motif Indispensalité"; REC."Motif Indispensalité")
                {
                    ApplicationArea = all;
                }
                field("Motif Panne"; REC."Motif Panne")
                {
                    ApplicationArea = all;
                }
                // field("Heure Panne"; REC."Heure Panne")
                // {
                //     ApplicationArea = all;
                // }
                // field("Heure Dispo"; REC."Heure Dispo")
                // {
                //     ApplicationArea = all;
                // }

                field("N° Reparation"; REC."N° Reparation")
                {
                    ApplicationArea = all;
                }
                field("N° DA"; REC."N° DA")
                {
                    ApplicationArea = all;
                }
                field("DA Lancé"; REC."DA Lancé")
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
                    Visible = false;
                }
                field("Heure Utilisation"; REC."Heure Utilisation")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Heure Immobilisation"; REC."Heure Immobilisation")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Nombre Voyage"; Rec."Nombre Voyage")
                {
                    ApplicationArea = all;
                }
                field(Marche; REC.Marche)
                {
                    ApplicationArea = all;
                }
                field("Affectation Marche"; REC."Affectation Marche")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Sous Affectation Marche"; REC."Sous Affectation Marche")
                {
                    ApplicationArea = all;
                }
                field("Cout Total Journee"; REC."Cout Total Journee")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Cout Heure Reel"; REC."Cout Heure Reel")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Cout Heure Immobilisation"; REC."Cout Heure Immobilisation")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Observation; REC.Observation)
                {
                    ApplicationArea = all;
                }
                field("Idex Kilometrique"; REC."Idex Kilometrique")
                {
                    ApplicationArea = all;
                    Visible = false;
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
                    Visible = true;
                }
                field("Chauffeur 2"; REC."Chauffeur 2")
                {
                    ApplicationArea = all;
                }
                field("Chauffeur 3"; REC."Chauffeur 3")
                {
                    ApplicationArea = all;
                }
                field(Control1000000046; REC.Observation)
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
        Text002: label 'Vous Devez Preciser La Journee';
        Text003: label 'Vous Devez D''abords Valider La Journee %1';
        Text004: label 'Journee Deja Saisie';

    local procedure StatutOnAfterValidate()
    begin
        CurrPage.Update;
    end;
}

