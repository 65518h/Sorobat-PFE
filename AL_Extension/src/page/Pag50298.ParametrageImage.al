Page 50298 "Parametrage Image"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Parametrage Image";
    ApplicationArea = all;
    Caption = 'Parametrage Image';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Table"; REC.Table)
                {
                    ApplicationArea = all;
                }
                field("Num Table"; REC."Num Table")
                {
                    ApplicationArea = all;
                }
                field("Dernier Document"; REC."Dernier Document")
                {
                    ApplicationArea = all;
                }
                field("Dernier Code"; REC."Dernier Code")
                {
                    ApplicationArea = all;
                }

                field("Derniere Sequence"; REC."Derniere Sequence")
                {
                    ApplicationArea = all;
                }
                field("Nom Table"; REC."Nom Table")
                {
                    ApplicationArea = all;
                }
                field(Chantier; REC.Chantier)
                {
                    ApplicationArea = all;
                }
                field("Mon Chantier"; REC."Mon Chantier")
                {
                    ApplicationArea = all;
                }
                field("Date Creation"; REC."Date Creation")
                {
                    ApplicationArea = all;
                }
                // field("Année"; REC.Année)
                // {
                //     ApplicationArea = all;
                // }
                // field(Mois; REC.Mois)
                // {
                //     ApplicationArea = all;
                // }
                field("N° Caisse Chantier Extra"; REC."N° Caisse Chantier Extra")
                {
                    ApplicationArea = all;
                }
                field("N° Caisse Chantier Cpt"; REC."N° Caisse Chantier Cpt")
                {
                    ApplicationArea = all;
                }
                field("N° Caisse Chantier Aliment"; REC."N° Caisse Chantier Aliment")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

