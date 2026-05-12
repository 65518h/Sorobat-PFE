
Page 52048970 "Position Pneu"
{//GL2024  ID dans Nav 2009 : "39004712"
    PageType = List;
    SourceTable = "Position Pneu";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code Position"; Rec."Code Position")
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

