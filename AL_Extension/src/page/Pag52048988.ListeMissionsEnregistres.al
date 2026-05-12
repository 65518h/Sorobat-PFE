Page 52048988 "Liste Missions Enregistrées"
{//GL2024  ID dans Nav 2009 : "39004728"
    Editable = false;
    PageType = List;
    SourceTable = "Mission Enregistré";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("N° Mission"; Rec."N° Mission")
                {
                    ApplicationArea = Basic;
                }
                field("Date Mission"; Rec."Date Mission")
                {
                    ApplicationArea = Basic;
                }
                field("Nom Demandeur"; Rec."Nom Demandeur")
                {
                    ApplicationArea = Basic;
                }
                field("Date Départ"; Rec."Date Départ")
                {
                    ApplicationArea = Basic;
                }
                field("Date Arrivée"; Rec."Date Arrivée")
                {
                    ApplicationArea = Basic;
                }
                field("Lieu départ"; Rec."Lieu départ")
                {
                    ApplicationArea = Basic;
                }
                field("Lieu Arrivé"; Rec."Lieu Arrivé")
                {
                    ApplicationArea = Basic;
                }
                field("N° Véhicule"; Rec."N° Véhicule")
                {
                    ApplicationArea = Basic;
                }
                field("Km Parcourus"; Rec."Km Parcourus")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Code Utilisateur"; Rec."Code Utilisateur")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

