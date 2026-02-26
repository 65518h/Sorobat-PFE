page 50130 "Entete Pointage Vehicule Enreg"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Entete Pointage Vehicule";
    SourceTableView = SORTING(Journee)
                      WHERE(Statut = CONST(Validé));

    Caption = 'Pointage Vehicule Enreg';


    layout
    {
        area(content)
        {
            group(Pointage)
            {
                Caption = 'Pointage';
                field("N° Document"; rec."N° Document")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Marche; rec.Marche)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                    Editable = false;
                }
                field(Journee; rec.Journee)
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;

                    trigger OnValidate()
                    begin
                        JourneeOnAfterValidate;
                    end;
                }
                field(Statut; rec.Statut)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
            }
            group("Dispo-Panne")
            {
                Caption = 'Dispo-Panne';
                part("Ligne Pointage Vehicule"; "Ligne Pointage Vehicule")
                {
                    ApplicationArea = all;
                    Editable = false;
                    SubPageLink = "Document N°" = FIELD("N° Document");
                }
            }
            group(Fonctionnel)
            {
                Caption = 'Fonctionnel';
                part("Ligne Pointage Vehicule Foncti"; "Ligne Pointage Vehicule Foncti")
                {
                    ApplicationArea = all;
                    SubPageLink = "Document N°" = FIELD("N° Document");
                }
            }
            group("Stat Et Ajustement")
            {
                Caption = 'Stat Et Ajustement';
                field("Total Heure Utilsation Mois"; rec."Total Heure Utilsation Mois")
                {
                    ApplicationArea = all;
                }
                field("Total Heure Immob Mois"; rec."Total Heure Immob Mois")
                {
                    ApplicationArea = all;
                }
                field(Ajustement; rec.Ajustement)
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Cout Total Ajusté"; rec."Cout Total Ajusté")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Cout Total Utilisation"; rec."Cout Total Utilisation")
                {
                    ApplicationArea = all;
                }
                field("Cout Total Immobilisation"; rec."Cout Total Immobilisation")
                {
                    ApplicationArea = all;
                }
                field("Cout Total"; rec."Cout Total")
                {
                    ApplicationArea = all;
                }
                field("Cout Total gasoil"; rec."Cout Total gasoil")
                {
                    ApplicationArea = all;
                }
                field("Total Gasoil"; rec."Total Gasoil")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {


            actionref(Valider1; Valider) { }


        }
        area(navigation)
        {

            action(Valider)
            {
                ApplicationArea = all;
                Caption = 'Valider';
                Visible = false;
                ShortCutKey = 'F9';

                trigger OnAction()
                begin
                    IF NOT CONFIRM(Text001) THEN EXIT;
                    LignePointageVehicule.SETRANGE("Document N°", rec."N° Document");
                    IF LignePointageVehicule.FINDFIRST THEN
                        REPEAT
                            LignePointageVehicule."Statut Entete" := LignePointageVehicule."Statut Entete"::Validé;
                            LignePointageVehicule.MODIFY;
                        UNTIL LignePointageVehicule.NEXT = 0;
                    rec.Statut := rec.Statut::Validé;
                    rec.MODIFY;
                end;
            }

        }
    }

    var
        Text001: Label 'Confirmer Cette Action ?';
        Text002: Label 'Vous Devez Preciser La Journee';
        Text003: Label 'Vous Devez D''abords Valider La Journee %1';
        Text004: Label 'Journee Deja Saisie';
        DteJournee: Date;
        RecVehicule: Record "Véhicule";
        LignePointageVehicule: Record "Ligne Pointage Vehicule";
        codeaffaire: code[20];

    local procedure JourneeOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

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

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        usersteup: Record "User Setup";
    begin


        if usersteup.Get(UserId) then begin
            rec.Marche := usersteup.Affaire;
        end;


    end;
}

