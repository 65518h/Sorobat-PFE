Page 52049009 "Liste Programmation"
{//GL2024  ID dans Nav 2009 : "39004760"
    Editable = false;
    PageType = List;
    SourceTable = "Entete Progrmmation";
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
                field(Chantier; Rec.Chantier)
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

