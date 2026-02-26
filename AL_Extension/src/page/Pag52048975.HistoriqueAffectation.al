Page 52048975 "Historique Affectation"
{//GL2024  ID dans Nav 2009 : "39004685"
    Editable = false;
    PageType = List;
    SourceTable = "Historique Affect. Véhicule";
    ApplicationArea = All;
    Caption = 'Historique Affectation';

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    OptionCaption = 'Affectation,Réaffectation,Location';
                }
                field("N° Véhicule"; Rec."N° Véhicule")
                {
                    ApplicationArea = Basic;
                }
                field("Type Affectation"; Rec."Type Affectation")
                {
                    ApplicationArea = Basic;
                }
                field(Affectation; Rec.Affectation)
                {
                    ApplicationArea = Basic;
                }
                field(Observation; Rec.Observation)
                {
                    ApplicationArea = Basic;
                }
                field("Date Affectation"; Rec."Date Affectation")
                {
                    ApplicationArea = Basic;
                }
                // field(Famille; Rec.Famille)
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Montant Location"; Rec."Montant Location")
                // {
                //     ApplicationArea = Basic;
                // }
            }
        }
    }

    actions
    {
    }

    var
    //  HistAff: Record "Historique Véhicule";
}

