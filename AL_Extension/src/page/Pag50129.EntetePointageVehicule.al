page 50129 "Entete Pointage Vehicule"
{
    Editable = true;
    PageType = Card;
    SourceTable = "Entete Pointage Vehicule";
    SourceTableView = WHERE(Statut = CONST(Ouvert));
    Caption = 'Pointage Vehicule';

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
                field("Dimanche / Ferié"; rec."Dimanche / Ferié")
                {
                    ApplicationArea = all;
                }
                field(Marche; rec.Marche)
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
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
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                // field(Utilisateur; rec.Utilisateur)
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
                // field("Date saisie"; rec."Date saisie")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
            }
            group("Dispo-Panne")
            {
                Caption = 'Dispo-Panne';
                part("Ligne Pointage Vehicule"; "Ligne Pointage Vehicule")
                {
                    ApplicationArea = all;
                    SubPageLink = "Document N°" = FIELD("N° Document"),
                                  Marche = FIELD(Marche);
                }
            }
            group(Fonctionnel)
            {
                Caption = 'Fonctionnel';
                part("Ligne Pointage Vehicule F"; "Ligne Pointage Vehicule F")
                {
                    ApplicationArea = all;
                    SubPageLink = "Document N°" = FIELD("N° Document"),
                                  Marche = FIELD(Marche);
                }
            }
            group("Materiel Marché")
            {
                Caption = 'Materiel Marché';
                part("Ligne Pointage Vehicule All"; "Ligne Pointage Vehicule All")
                {

                    ApplicationArea = all;
                    SubPageLink = "Document N°" = FIELD("N° Document");
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
                ShortCutKey = 'F9';
                Image = Post;


                trigger OnAction()
                begin
                    IF NOT CONFIRM(Text001) THEN EXIT;
                    LignePointageVehicule.SETRANGE("Document N°", rec."N° Document");
                    IF LignePointageVehicule.FINDFIRST THEN
                        REPEAT
                            //  LignePointageVehicule.TESTFIELD(LignePointageVehicule."Sous Affectation");
                            LignePointageVehicule.TESTFIELD(Marche);
                            //GL2025   LignePointageVehicule.TESTFIELD("Affectation Marche");
                            //GL2025  LignePointageVehicule.TESTFIELD("Sous Affectation Marche");
                            LignePointageVehicule."Statut Entete" := LignePointageVehicule."Statut Entete"::Validé;

                            if RecVehicule.Get(LignePointageVehicule.Vehicule) then begin
                                RecVehicule.Statut := LignePointageVehicule.Statut;
                                RecVehicule.marche := LignePointageVehicule.Marche;
                                RecVehicule."Reste Pour Alerte" := LignePointageVehicule."Index Final";
                                RecVehicule.Modify()
                            end;







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

