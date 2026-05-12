Page 52049010 "Prise carburant"
{//GL2024  ID dans Nav 2009 : "39004688"
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Prise carburant";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Date de Prise"; Rec."Date de Prise")
                {
                    ApplicationArea = Basic;
                }
                field(Energie; Rec.Energie)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sans Carte"; Rec."Sans Carte")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        SansCarteOnPush;
                    end;
                }
                field("N° Carte Carburant"; Rec."N° Carte Carburant")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = "N° Carte CarburantVisible";
                }
                field("N° Bon Gasoil"; Rec."N° Bon Gasoil")
                {
                    ApplicationArea = Basic;
                    Visible = "N° Bon GasoilVisible";
                }
                field("Gasoil Consommé"; Rec."Gasoil Consommé")
                {
                    ApplicationArea = Basic;
                }
                field("Coût Réel Mission"; Rec."Coût Réel Mission")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Côut unitaire"; Rec."Côut unitaire")
                {
                    ApplicationArea = Basic;
                }
                field("Consommation Moyenne"; Rec."Consommation Moyenne")
                {
                    ApplicationArea = Basic;
                }
                field("Gasoil Consommé Prevu"; Rec."Gasoil Consommé Prevu")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Coût Prevu Mission"; Rec."Coût Prevu Mission")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("% Indicateur Réel/Prevu"; Rec."% Indicateur Réel/Prevu")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        "N° Carte CarburantVisible" := true;
    end;

    var
        "RecParamétreParc": Record "Paramétre Parc";
        "RecVéhicule": Record "Véhicule";
        RecMissions: Record Missions;
        [InDataSet]
        "N° Bon GasoilVisible": Boolean;
        [InDataSet]
        "N° Carte CarburantVisible": Boolean;

    local procedure SansCarteOnPush()
    begin
        if Rec."Sans Carte" = true then begin
            "N° Bon GasoilVisible" := true;
            "N° Carte CarburantVisible" := false;
        end
        else begin
            "N° Bon GasoilVisible" := false;
            "N° Carte CarburantVisible" := true;

        end;
        CurrPage.Update;
    end;
}

