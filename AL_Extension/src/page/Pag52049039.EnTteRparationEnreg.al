page 52049039 "En-Tête Réparation Enreg."
{//GL2024  ID dans Nav 2009 : "39004708"
    Editable = false;

    SourceTable = "Réparation Véhicule Enreg.";
    Caption = 'En-Tête Réparation Enreg.';


    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Général';
                field("N° Reparation"; REC."N° Reparation")
                {
                    ApplicationArea = all;
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
                field(Type; REC.Type)
                {
                    ApplicationArea = all;
                }
                field("N° Véhicule"; REC."N° Véhicule")
                {
                    ApplicationArea = all;
                }
                field("N° Immantricule"; REC."N° Immantricule")
                {
                    ApplicationArea = all;
                }
                field("N° Intervenant"; REC."N° Intervenant")
                {
                    ApplicationArea = all;
                }
                field("Nom Intervenant"; REC."Nom Intervenant")
                {
                    ApplicationArea = all;
                }
                field("Intervenant Interne"; REC."Intervenant Interne")
                {
                    ApplicationArea = all;
                }
                field("Nom Intervenant Interne"; REC."Nom Intervenant Interne")
                {
                    ApplicationArea = all;
                }
                field("Date document"; REC."Date document")
                {
                    ApplicationArea = all;
                }
                field(Garentie; REC.Garentie)
                {
                    ApplicationArea = all;
                }
                field(Accidentée; REC.Accidentée)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Degré d'Urgence"; REC."Degré d'Urgence")
                {
                    ApplicationArea = all;
                }
                field("Date Début Réparation"; REC."Date Début Réparation")
                {
                    ApplicationArea = all;
                }
                field("Date Fin réparation"; REC."Date Fin réparation")
                {
                    ApplicationArea = all;
                }
                field(Index; REC.Index)
                {
                    ApplicationArea = all;
                }
                field("Nature de panne"; REC."Nature de panne")
                {
                    ApplicationArea = all;
                }
            }
            group(Interventions)
            {
                Caption = 'Interventions';
                part(détail; "Détail réparation enreg")
                {
                    ApplicationArea = all;
                    SubPageLink = "N° Reparation" = FIELD("N° Reparation");
                }
            }
            group("Pièce de rechange")
            {
                Caption = 'Pièce de rechange';
                part(repar; "PR Reparation Enreg.")
                {
                    ApplicationArea = all;
                    SubPageLink = "N° Reparation" = FIELD("N° Reparation");
                }
            }

            //GL3900 group(Pneumatique)
            //GL3900 {
            //GL3900   Caption = 'Pneumatique';
            //GL3900 
            /*  part(enreg; "Reparation pneu Enreg.")
              {
                  ApplicationArea = all;
                  SubPageLink = "N° Reparation" = FIELD("N° Reparation");
              }*/ //GL3900 
                  //GL3900  }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("Réparation1")
            {
                Caption = 'Réparation';

                actionref("Fiche Véhicule1"; "Fiche Véhicule") { }
                actionref("Fiche Intervenant1"; "Fiche Intervenant") { }
            }
            actionref("&Print1"; "&Print") { }
        }
        area(navigation)
        {
            group("Réparation")
            {
                Caption = 'Réparation';

                action("Fiche Véhicule")
                {
                    ApplicationArea = all;
                    Caption = 'Fiche Véhicule';
                    RunObject = Page "Fiche Véhicule";
                    RunPageLink = "N° Vehicule" = FIELD("N° Véhicule");
                }
                action("Fiche Intervenant")
                {
                    ApplicationArea = all;
                    Caption = 'Fiche Intervenant';
                    RunObject = Page "Vendor List";
                    RunPageLink = "No." = FIELD("N° Intervenant");
                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                ApplicationArea = all;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;

                ToolTip = 'Print';

                trigger OnAction()
                begin
                    DetailEnreg.RESET;
                    DetailEnreg.SETRANGE("N° Reparation", REC."N° Reparation");
                    IF DetailEnreg.FIND('-') THEN
                        REPORT.RUN(50056, TRUE, FALSE, DetailEnreg);
                end;
            }
        }
    }

    var
        DetailEnreg: Record "Détail Reparation Enreg.";
}

