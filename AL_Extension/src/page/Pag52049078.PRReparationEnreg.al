Page 52049078 "PR Reparation Enreg."
{//GL2024  ID dans Nav 2009 : "39004718"
    PageType = ListPart;
    SourceTable = "PR Réparation Enreg.";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Réf. PR"; Rec."Réf. PR")
                {
                    ApplicationArea = Basic;
                }
                field("Désignation Piéce"; Rec."Désignation Piéce")
                {
                    ApplicationArea = Basic;
                }
                field("Quantité"; Rec.Quantité)
                {
                    ApplicationArea = Basic;
                }
                field("Coût Unitaire"; Rec."Coût Unitaire")
                {
                    ApplicationArea = Basic;
                }
                field("Coût Total"; Rec."Coût Total")
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

