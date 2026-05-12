Page 52049012 "Liste Rendement enregistré"
{//GL2024  ID dans Nav 2009 : "39004762"
    Editable = false;
    PageType = List;
    SourceTable = "Entete rendement Vehicule Enr";
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
                field(Marche; Rec.Marche)
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

