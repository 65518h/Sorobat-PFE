Page 50274 "Parent en Charge"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Montant Parent en charge";
    ApplicationArea = all;
    Caption = 'Parent en Charge';
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

