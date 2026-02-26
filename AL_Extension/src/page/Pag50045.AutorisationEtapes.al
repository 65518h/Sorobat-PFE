Page 50045 "Autorisation Etapes"
{
    // // << HJ DSFT 21-01-2009: Gestion des Utilisateurs

    DelayedInsert = true;
    Editable = true;
    PageType = List;
    SourceTable = "Autorisation Etapes2";
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Autorisation Etapes';
    layout
    {
        area(content)
        {
            repeater(Control1120000)
            {
                ShowCaption = false;
                field("Type Reglement"; rec."Type Reglement")
                {
                    ApplicationArea = all;
                    //   Editable = false;
                }
                field(Etape; rec.Etape)
                {
                    ApplicationArea = all;
                    //  Editable = false;
                }
                field("Nom Etapes"; rec."Nom Etapes")
                {
                    ApplicationArea = all;
                    //   Editable = false;
                }
                field(User; rec.User)
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

