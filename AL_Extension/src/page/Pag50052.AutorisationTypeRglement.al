Page 50052 "Autorisation Type Réglement"
{
    PageType = List;
    SourceTable = "Autorisation Types Réglement2";
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Autorisation Type Réglement';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Type réglement"; rec."Type réglement")
                {
                    ApplicationArea = all;
                    //   Editable = false;
                }
                field(Utilisateur; rec.Utilisateur)
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

