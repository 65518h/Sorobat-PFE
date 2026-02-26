Page 52049040 "Détail réparation enreg"
{//GL2024  ID dans Nav 2009 : "39004709"
    PageType = ListPart;
    SourceTable = "Détail Reparation Enreg.";
    ApplicationArea = All;
    Caption = 'Détail réparation enreg';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code Réparation"; Rec."Code Réparation")
                {
                    ApplicationArea = Basic;
                }
                field("Désignation"; Rec.Désignation)
                {
                    ApplicationArea = Basic;
                }
                field("Type Réparation"; Rec."Type Réparation")
                {
                    ApplicationArea = Basic;
                }
                field("Montant Reparation"; Rec."Montant Reparation")
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

