Page 52049028 "Prise carburant Enregistré"
{//GL2024  ID dans Nav 2009 : "39004690"
    PageType = ListPart;
    SourceTable = "Prise carburant Enregistré";
    ApplicationArea = All;
    Caption = 'Prise carburant Enregistré';

    layout
    {
        area(content)
        {
            repeater(Control1120000)
            {
                Editable = false;
                field("N° Véhicule"; Rec."N° Véhicule")
                {
                    ApplicationArea = Basic;
                }
                field("N° Mission"; Rec."N° Mission")
                {
                    ApplicationArea = Basic;
                }
                field("Date de Prise"; Rec."Date de Prise")
                {
                    ApplicationArea = Basic;
                }
                field("N° Carte Carburant"; Rec."N° Carte Carburant")
                {
                    ApplicationArea = Basic;
                }
                field(Energie; Rec.Energie)
                {
                    ApplicationArea = Basic;
                }
                field("N° Bon Gasoil"; Rec."N° Bon Gasoil")
                {
                    ApplicationArea = Basic;
                }
                field("Gasoil Consommé"; Rec."Gasoil Consommé")
                {
                    ApplicationArea = Basic;
                }
                field("Consommation Moyenne"; Rec."Consommation Moyenne")
                {
                    ApplicationArea = Basic;
                }
                field("Côut unitaire"; Rec."Côut unitaire")
                {
                    ApplicationArea = Basic;
                }
                field("Gasoil Consommé Prevu"; Rec."Gasoil Consommé Prevu")
                {
                    ApplicationArea = Basic;
                }
                field("Coût Réel Mission"; Rec."Coût Réel Mission")
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

