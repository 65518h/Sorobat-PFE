Page 52049035 "Détail réparation"
{//GL2024  ID dans Nav 2009 : "39004698"
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Détail Reparation";
    ApplicationArea = All;
    Caption = 'Détail réparation';
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                //GL2024
                field("N° Reparation"; Rec."N° Reparation")
                {
                    ApplicationArea = Basic;

                }
                field("N° Ligne"; Rec."N° Ligne")
                {
                    ApplicationArea = Basic;

                }
                field("N° Véhicule"; Rec."N° Véhicule")
                {
                    ApplicationArea = Basic;

                }
                //GL2024
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

