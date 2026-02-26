Page 52048965 "Liste Genres Véhicules"
{//GL2024  ID dans Nav 2009 : "39004676"
    PageType = List;
    SourceTable = "Genre Véhicule";
    ApplicationArea = All;
    Caption = 'Liste Genres Véhicules';

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code Genre"; Rec."Code Genre")
                {
                    ApplicationArea = Basic;
                }
                field("Désignation"; Rec.Désignation)
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

