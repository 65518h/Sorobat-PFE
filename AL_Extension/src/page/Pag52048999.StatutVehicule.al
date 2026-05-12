Page 52048999 "Statut Vehicule"
{//GL2024  ID dans Nav 2009 : "39004747"
    PageType = List;
    SourceTable = "Statut Vehicule";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Statut; Rec.Statut)
                {
                    ApplicationArea = Basic;
                }
                field(Designation; Rec.Designation)
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

