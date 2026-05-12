Page 52048969 "Liste Vignettes"
{//GL2024  ID dans Nav 2009 : "39004679"
    Editable = false;
    PageType = List;
    SourceTable = "Vignette Véhicule";
    ApplicationArea = All;
    Caption = 'Liste Vignettes';
    CardPageId = "Vignette Véhicule";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° Veh"; Rec."N° Veh")
                {
                    ApplicationArea = Basic;
                }
                field("Date Document"; Rec."Date Document")
                {
                    ApplicationArea = Basic;
                }
                field("code Vig"; Rec."code Vig")
                {
                    ApplicationArea = Basic;
                }
                field("Libellé"; Rec.Libellé)
                {
                    ApplicationArea = Basic;
                }
                field(Tarif; Rec.Tarif)
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

