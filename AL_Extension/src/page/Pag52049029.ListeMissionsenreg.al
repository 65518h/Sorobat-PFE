page 52049029 "Liste Missions enreg."
{//GL2024  ID dans Nav 2009 : "39004691"
    Editable = false;
    PageType = List;
    SourceTable = "Mission Enregistré";
    ApplicationArea = All;
    Caption = 'Liste Missions enreg';
    UsageCategory = lists;
    CardPageId = "Mission Enregistré";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° Mission"; REC."N° Mission")
                {
                    ApplicationArea = all;
                }
                field("Date document"; REC."Date document")
                {
                    ApplicationArea = all;
                }
                field("Date Mission"; REC."Date Mission")
                {
                    ApplicationArea = all;
                }
                field("Code Demandeur"; REC."Code Demandeur")
                {
                    ApplicationArea = all;
                }
                field("Date Départ"; REC."Date Départ")
                {
                    ApplicationArea = all;
                }
                field("Date Arrivée"; REC."Date Arrivée")
                {
                    ApplicationArea = all;
                }
                field("Lieu départ"; REC."Lieu départ")
                {
                    ApplicationArea = all;
                }
                field("Lieu Arrivé"; REC."Lieu Arrivé")
                {
                    ApplicationArea = all;
                }
                field("Index Cpt. Depart"; REC."Index Cpt. Depart")
                {
                    ApplicationArea = all;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Index Cpt. Retour"; REC."Index Cpt. Retour")
                {
                    ApplicationArea = all;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Km Parcourus"; REC."Km Parcourus")
                {
                    ApplicationArea = all;
                }
                field("N° Véhicule"; REC."N° Véhicule")
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




            group(Mission1)
            {
                Caption = 'Mission';
                actionref(Fiche1; Fiche) { }

                actionref("Prise de Carburant1"; "Prise de Carburant") { }
            }
        }



        area(navigation)
        {
            group(Mission)
            {
                Caption = 'Mission';
                action(Fiche)
                {
                    ApplicationArea = all;
                    Caption = 'Fiche';
                    RunObject = Page "Mission Enregistré";
                    RunPageLink = "N° Mission" = FIELD("N° Mission");
                }

                action("Prise de Carburant")
                {
                    ApplicationArea = all;
                    Caption = 'Prise de Carburant';
                    RunObject = Page "Prise carburant Enregistré";
                    RunPageLink = "N° Véhicule" = FIELD("N° Véhicule"),
                                  "N° Mission" = FIELD("N° Mission");
                }
            }
        }
    }
}

