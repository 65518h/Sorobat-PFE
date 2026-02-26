Page 52048990 Energie
{//GL2024  ID dans Nav 2009 : "39004737"
    PageType = List;
    SourceTable = Energie;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1120000)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = Basic;
                }
                field("Côut unitaire"; Rec."Côut unitaire")
                {
                    ApplicationArea = Basic;
                }
                field("Article Associé"; Rec."Article Associé")
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

