page 50019 Salarier
{
    DelayedInsert = true;
    PageType = list;
    SourceTable = 50011;

    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                ShowCaption = false;
                field(Salarie; rec.Salarie)
                {
                }
                field("Nom Et Prenom"; rec."Nom Et Prenom")
                {
                }
            }
        }
    }

    actions
    {
    }
}

