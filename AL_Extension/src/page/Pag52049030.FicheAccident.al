page 52049030 "Fiche Accident"
{//GL2024  ID dans Nav 2009 : "39004692"
    PageType = Card;
    SourceTable = Accidents;
    ApplicationArea = All;
    caption = 'Fiche Accident';

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Général';
                field("N° Accident"; REC."N° Accident")
                {
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        IF REC.AssistEdit(xRec) THEN
                            CurrPage.UPDATE(FALSE);
                    end;
                }
                field("N° Affaire"; REC."N° Affaire")
                {
                    ApplicationArea = all;
                }
                field("N° Tache Affaire"; REC."N° Tache Affaire")
                {
                    ApplicationArea = all;
                }
                field("Centre de Gestion"; REC."Centre de Gestion")
                {
                    ApplicationArea = all;
                }
                field("Date Accident"; REC."Date Accident")
                {
                    ApplicationArea = all;
                }
                field("N° Mission"; REC."N° Mission")
                {
                    ApplicationArea = all;
                }
                field("N° Véhicule"; REC."N° Véhicule")
                {
                    ApplicationArea = all;
                }
                field("N° Immatriculation"; REC."N° Immatriculation")
                {
                    ApplicationArea = all;
                }
                field("N° Constat"; REC."N° Constat")
                {
                    ApplicationArea = all;
                }
                field("N° Conducteur"; REC."N° Conducteur")
                {
                    ApplicationArea = all;
                }
                field("Nom Conducteur"; REC."Nom Conducteur")
                {
                    ApplicationArea = all;
                }
                field("Fonction Conducteur"; REC."Fonction Conducteur")
                {
                    ApplicationArea = all;
                }
                field("Date Document"; REC."Date Document")
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
            group(Accident1)
            {
                Caption = 'Accident';
                actionref("Fiche Mission1"; "Fiche Mission") { }
                actionref("Fiche Véhicule1"; "Fiche Véhicule") { }
            }

            actionref(Valider1; Valider) { }

        }
        area(navigation)
        {
            group(Accident)
            {
                Caption = 'Accident';
                action("Fiche Mission")
                {
                    ApplicationArea = all;
                    Caption = 'Fiche Mission';
                    RunObject = Page "Mission Enregistré";
                    RunPageLink = "N° Mission" = FIELD("N° Mission");
                }
                action("Fiche Véhicule")
                {
                    ApplicationArea = all;
                    Caption = 'Fiche Véhicule';
                    RunObject = Page "Fiche Véhicule";
                    RunPageLink = "N° Vehicule" = FIELD("N° Véhicule");
                }

                //GL3900   action("Dégats")
                //GL3900    {
                //GL3900     ApplicationArea = all;
                //GL3900    Caption = 'Dégats';
                //GL3900   RunObject = Page "Ligne dégats";
                //GL3900   RunPageLink = "N° Accident" = FIELD("N° Accident"),
                //GL3900        "N° constat" = FIELD("N° Constat");
                //GL3900  }
            }
        }
        area(processing)
        {
            action(Valider)
            {
                ApplicationArea = all;
                Caption = 'Valider';


                trigger OnAction()
                begin
                    IF CONFIRM('Souhaitez-Vous Valider la fiche Accident', TRUE) THEN BEGIN
                        ParcSetup.GET;
                        IF ParcSetup."Réparation sur Accident" THEN BEGIN
                            Window.OPEN('Insertion Réparation N°          #########1#################\\' +
                                        'Véhicule N°                      ########2#################');

                            NoSeriesMgt.InitSeries(ParcSetup."N° Réparation", ParcSetup."N° Réparation", 0D, rep."N° Reparation", rep."No. Series");
                            Window.UPDATE(1, rep."N° Reparation");
                            Window.UPDATE(2, rep."N° Véhicule");
                            rep.VALIDATE("N° Véhicule", REC."N° Véhicule");
                            rep.VALIDATE("Date Début Réparation", TODAY);
                            rep."Date Acceptation" := TODAY;
                            rep.Accidentée := TRUE;
                            rep."N° Accident" := REC."N° Accident";
                            rep.INSERT;
                            Window.CLOSE;
                        END;
                        //GL3900     AccEnreg.TRANSFERFIELDS(Rec);
                        //GL3900    AccEnreg.INSERT;
                        REC.DELETE;
                    END;
                end;
            }
        }
    }

    var
        //GL3900    AccEnreg: Record "Accidents Enregistrés";
        Window: Dialog;
        ParcSetup: Record "Paramétre Parc";
        rep: Record "Réparation Véhicule";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

