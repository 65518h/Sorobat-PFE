Page 52049038 "Historique Prise de Carburant"
{//GL2024  ID dans Nav 2009 : "39004707"
    Editable = false;
    PageType = List;
    SourceTable = "Prise carburant Enregistré";
    ApplicationArea = All;
    Caption = 'Historique Prise de Carburant';

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° Véhicule"; Rec."N° Véhicule")
                {
                    ApplicationArea = Basic;
                }
                field("Date de Prise"; Rec."Date de Prise")
                {
                    ApplicationArea = Basic;
                }
                field("N° Mission"; Rec."N° Mission")
                {
                    ApplicationArea = Basic;
                }
                field("N° Bon Gasoil"; Rec."N° Bon Gasoil")
                {
                    ApplicationArea = Basic;
                }
                field("Coût Réel Mission"; Rec."Coût Réel Mission")
                {
                    ApplicationArea = Basic;
                }
                field("Gasoil Consommé"; Rec."Gasoil Consommé")
                {
                    ApplicationArea = Basic;
                }
                field(Energie; Rec.Energie)
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

