page 50096 "Fiche Réparation Validé"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Réparation Véhicule";
    SourceTableView = WHERE(Valider = CONST(true));

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Général';
                field("N° Reparation1"; rec."N° Reparation")
                {

                    trigger OnAssistEdit()
                    begin
                        IF rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE(FALSE);
                    end;
                }
                field("N° Véhicule"; rec."N° Véhicule")
                {
                }
                field(Affectation; rec.Affectation)
                {
                }
                field("Statut Materiel"; rec."Statut Materiel")
                {
                }
                field("Date Acceptation"; rec."Date Acceptation")
                {
                }
                field("Heure Acceptation"; rec."Heure Acceptation")
                {
                }
                field(Index; rec.Index)
                {
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Nature Panne"; rec."Nature Panne")
                {
                }
                field(Statut; rec.Statut)
                {
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Date Prevision Réparation"; rec."Date Prevision Réparation")
                {
                }
                field("Heure Prevision Réparation"; rec."Heure Prevision Réparation")
                {
                }
                field("Motif  Ecart"; rec."Motif  Ecart")
                {
                }
                field("Date Début Réparation"; rec."Date Début Réparation")
                {
                }
                field("Heure Debut Réparation"; rec."Heure Debut Réparation")
                {
                }
                field("Date Fin réparation"; rec."Date Fin réparation")
                {
                }
                field("Heure Fin Réparation"; rec."Heure Fin Réparation")
                {
                }
                field(Garentie; rec.Garentie)
                {
                }
                field(Accidentée; rec.Accidentée)
                {
                    Editable = false;
                }
                field("Degré d'Urgence"; rec."Degré d'Urgence")
                {
                }
                field("Descriptif Panne"; rec."Descriptif Panne")
                {
                }
                field("Total Cout réparation"; rec."Total Cout réparation")
                {
                }
            }
            part("PR Reparation"; "PR Reparation")
            {
                SubpageLink = "N° Reparation" = FIELD("N° Reparation");
            }
        }
    }

    actions
    {
        area(Promoted)

        {



            actionref("Fiche Véhicule1"; "Fiche Véhicule") { }
            actionref(Imprimer1; Imprimer) { }
            actionref(Valider1; Valider) { }




        }

        area(navigation)
        {
            group("Réparation")
            {
                Caption = 'Réparation';

                action("Fiche Véhicule")
                {
                    Caption = 'Fiche Véhicule';
                    RunPageLink = "N° Vehicule" = FIELD("N° Véhicule");
                    RunObject = Page "Fiche Véhicule";
                    Image = Card;
                }
                action("Fiche Intervenant")
                {
                    Caption = 'Fiche Intervenant';
                    RunpageLink = "No." = FIELD("N° Intervenant");
                    RunObject = Page 27;
                    Visible = false;
                    Image = Card;
                }
                action(Imprimer)
                {
                    Caption = 'Imprimer';
                    Image = print;

                    trigger OnAction()
                    begin
                        Reparation.RESET;
                        Reparation.SETRANGE("N° Reparation", rec."N° Reparation");
                        IF Reparation.FIND('-') THEN
                            REPORT.RUN(39004672, TRUE, FALSE, Reparation);
                    end;
                }
                action(Valider)
                {
                    Caption = 'Valider';
                    ShortCutKey = 'F9';
                    Visible = false;
                    Image = Post;

                    trigger OnAction()
                    begin
                        rec.TESTFIELD("Date Acceptation");
                        rec.TESTFIELD("Date Début Réparation");
                        rec.TESTFIELD("Date Fin réparation");
                        IF rec.Statut <> rec.Statut::Clôturé THEN ERROR('Vous Devez Cloturé La Fiche');
                        IF NOT CONFIRM('Souhaitez-Vous Valider la fiche réparation !!!', TRUE) THEN EXIT;
                        rec.Valider := TRUE;
                        rec.MODIFY;
                    end;
                }
            }
        }
    }

    var
        DetailRep: Record "Détail Reparation";
        REpEnreg: Record "Réparation Véhicule Enreg.";
        DetailEnreg: Record "Détail Reparation Enreg.";
        Window: Dialog;
        PR: Record "PR Réparation";
        Pneu: Record "Reparation Pneu";
        PrEnreg: Record "PR Réparation Enreg.";
        PneuEnreg: Record "Reparation Pneu Enreg.";
        Reparation: Record "Réparation Véhicule";
        PnVeh: Record "Pneumatique Véhicule";
        Veh: Record "Véhicule";
        RecMission: Record "Missions";
        RecItemEntry: Record 83;
        CUItemJnlPostLine: Codeunit 22;
        "RecParamétreParc": Record "Paramétre Parc";
        Compteur: Integer;


    procedure InsertItemEntry()
    var
        RecItemEntry: Record 83;
        CUItemJnlPostLine: Codeunit 22;
        "RecParamétreParc": Record "Paramétre Parc";
        Text001: Label 'Sortie Sur Reparation N° : ';
        Text002: Label 'Erreur Insertion';
    begin
    end;
}

