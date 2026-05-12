Page 52049041 "Liste Réparation Enreg."
{//GL2024  ID dans Nav 2009 : "39004710"
    Editable = false;
    PageType = List;
    SourceTable = "Réparation Véhicule Enreg.";

    ApplicationArea = All;
    Caption = 'Liste Réparation Enreg';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° Reparation"; Rec."N° Reparation")
                {
                    ApplicationArea = Basic;
                }
                field("N° Véhicule"; Rec."N° Véhicule")
                {
                    ApplicationArea = Basic;
                }
                field("N° Intervenant"; Rec."N° Intervenant")
                {
                    ApplicationArea = Basic;
                }
                field("Date Début Réparation"; Rec."Date Début Réparation")
                {
                    ApplicationArea = Basic;
                }
                field("Date Fin réparation"; Rec."Date Fin réparation")
                {
                    ApplicationArea = Basic;
                }
                field("Intervenant Interne"; Rec."Intervenant Interne")
                {
                    ApplicationArea = Basic;
                }
                field("N° Affaire"; Rec."N° Affaire")
                {
                    ApplicationArea = Basic;
                }
                field(Control1000000008; Rec."Intervenant Interne")
                {
                    ApplicationArea = Basic;
                }
                field("Nom Intervenant Interne"; Rec."Nom Intervenant Interne")
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

