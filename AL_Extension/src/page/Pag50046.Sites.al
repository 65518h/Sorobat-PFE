Page 50046 Sites
{
    // // << HJ DSFT 21-01-2009: Gestion des Utilisateurs

    PageType = List;
    SourceTable = "Agence";
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Sites';
    layout
    {
        area(content)
        {
            repeater(Control1120000)
            {
                ShowCaption = false;
                field("Code"; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
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

