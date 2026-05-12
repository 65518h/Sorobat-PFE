Page 50275 "Bourse Etudiant"
{
    PageType = List;
    SourceTable = "Montant Bourse Etudiant";
    ApplicationArea = all;
    Caption = 'Bourse Etudiant';
    layout
    {
        area(content)
        {
            repeater(Control1)
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
                field(Bourse; REC.Bourse)
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

