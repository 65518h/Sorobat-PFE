Page 50273 "Assurance Vie Employé"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Montant Assura Vie employe";
    ApplicationArea = all;
    Caption = 'Assurance Vie Employé';
    layout
    {
        area(content)
        {
            repeater(Control1120000)
            {
                ShowCaption = false;
                field(Annee; REC.Annee)
                {
                    ApplicationArea = all;
                }
                field(Montant; REC.Montant)
                {
                    ApplicationArea = all;
                }
                field("Date Debut"; REC."Date Debut")
                {
                    ApplicationArea = all;
                }
                field("Date Fin"; REC."Date Fin")
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

