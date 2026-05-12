
Page 52048995 "Carte Autoroute Enreg"
{//GL2024  ID dans Nav 2009 : "39004741"
    Editable = false;
    PageType = List;
    SourceTable = "Carte Autoroute enregistrer";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1120000)
            {
                field("N° Véhicule"; Rec."N° Véhicule")
                {
                    ApplicationArea = Basic;
                }
                field("N° Mission"; Rec."N° Mission")
                {
                    ApplicationArea = Basic;
                }
                field("N°Carte Autoroute"; Rec."N°Carte Autoroute")
                {
                    ApplicationArea = Basic;
                }
                field("Montant Carte"; Rec."Montant Carte")
                {
                    ApplicationArea = Basic;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Multiple; Rec.Multiple)
                {
                    ApplicationArea = Basic;
                }
                field("Date de Prise"; Rec."Date de Prise")
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
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

