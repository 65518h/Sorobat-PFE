Page 52049011 "Liste Pointage Enregistré"
{//GL2024  ID dans Nav 2009 : "39004761"
    Editable = false;
    PageType = List;
    SourceTable = "Entete Pointage Chauffeur Enre";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("N° Document"; Rec."N° Document")
                {
                    ApplicationArea = Basic;
                }
                field(Journee; Rec.Journee)
                {
                    ApplicationArea = Basic;
                }
                field(Affectation; Rec.Affectation)
                {
                    ApplicationArea = Basic;
                }
                field("Designation Affectation"; Rec."Designation Affectation")
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

