
Page 52048960 "Type Dégats"
{//GL2024  ID dans Nav 2009 : "39004695"
    PageType = List;
    SourceTable = "Type Dégats";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code Type Dégat"; Rec."Code Type Dégat")
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

