page 50336 "Liste Entete Pointage Veh En."
{//GL2024 NEW PAGE
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = list;
    SourceTable = "Entete Pointage Vehicule";
    SourceTableView = SORTING(Journee)
                      WHERE(Statut = CONST(Validé));

    Caption = 'Liste Pointage Vehicule Enreg';
    ApplicationArea = all;
    CardPageId = "Entete Pointage Vehicule Enreg";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Journee; REC.Journee)
                {
                    ApplicationArea = all;
                }
                field("N° Document"; REC."N° Document")
                {
                    ApplicationArea = all;
                }
                field(Marche; REC.Marche)
                {
                    ApplicationArea = all;
                }
                field(Control1000000062; REC.Journee)
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                // field(Utilisateur; REC.Utilisateur)
                // {
                //     ApplicationArea = all;
                //     Style = Strong;
                //     StyleExpr = true;
                // }
                // field("Date saisie"; REC."Date saisie")
                // {
                //     ApplicationArea = all;
                //     Style = Strong;
                //     StyleExpr = true;
                // }
                field(Mois; REC.Mois)
                {
                    ApplicationArea = all;
                }
                field(Annee; REC.Annee)
                {
                    ApplicationArea = all;
                }
                field(Vehicule; REC.Vehicule)
                {
                    ApplicationArea = all;
                }
                field("Description Vehicule"; REC."Description Vehicule")
                {
                    ApplicationArea = all;
                }
                field(Matricule; REC.Matricule)
                {
                    ApplicationArea = all;
                }
                field(Type; REC.Type)
                {
                    ApplicationArea = all;
                }
                field("Date Mise En Service"; REC."Date Mise En Service")
                {
                    ApplicationArea = all;
                }
                field("Cout Horaire"; REC."Cout Horaire")
                {
                    ApplicationArea = all;
                }
                field("Gasoil Mensulle"; REC."Gasoil Mensulle")
                {
                    ApplicationArea = all;
                }
                field(Statut; REC.Statut)
                {
                    ApplicationArea = all;
                }
                field("Heure Travail Theorique"; REC."Heure Travail Theorique")
                {
                    ApplicationArea = all;
                }
                field("Total Heure reel Mois"; REC."Total Heure reel Mois")
                {
                    ApplicationArea = all;
                }
                field("Total Heure Utilsation Mois"; REC."Total Heure Utilsation Mois")
                {
                    ApplicationArea = all;
                }
                field("Total Heure Immob Mois"; REC."Total Heure Immob Mois")
                {
                    ApplicationArea = all;
                }
                field("Cout Total Utilisation"; REC."Cout Total Utilisation")
                {
                    ApplicationArea = all;
                }
                field("Cout Total Immobilisation"; REC."Cout Total Immobilisation")
                {
                    ApplicationArea = all;
                }
                field("Cout Total"; REC."Cout Total")
                {
                    ApplicationArea = all;
                }
                field(Ajustement; REC.Ajustement)
                {
                    ApplicationArea = all;
                }
                field("Cout Total Ajusté"; REC."Cout Total Ajusté")
                {
                    ApplicationArea = all;
                }
                field("Unité Travail"; REC."Unité Travail")
                {
                    ApplicationArea = all;
                }
                field("Cout Journalier"; REC."Cout Journalier")
                {
                    ApplicationArea = all;
                }
                field(Control1000000045; REC.Marche)
                {
                    ApplicationArea = all;
                }
                field("Cout Total gasoil"; REC."Cout Total gasoil")
                {
                    ApplicationArea = all;
                }
                field("Total Gasoil"; REC."Total Gasoil")
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
    var
        RecUserSetup: Record "User Setup";
    begin
        if RecUserSetup.Get(UserId) then begin


            Rec.FilterGroup(2);
            if RecUserSetup.Affaire <> '' then
                Rec.SetRange(Marche, RecUserSetup.Affaire);
            Rec.FilterGroup(0);


        end;
    end;
}

