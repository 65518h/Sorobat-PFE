Page 50027 "Liste Utilisateurs"
{
    Editable = true;
    PageType = list;
    SourceTable = Demandeur;
    Caption = 'Liste Utilisateurs';
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Nom Et Prenom"; rec."Nom Et Prenom")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {


            /* GL2024  action(Modifier)
               {
                   ApplicationArea = all;
                   Caption = 'Edit';
                   ShortCutKey = 'Ctrl+M';
                   Promoted=true;
                   PromotedCategory=Process;

                   trigger OnAction()
                   begin
                       CurrPage.Editable(true);
                   end;
               }*/

        }
    }

    trigger OnOpenPage()
    begin
        //  CurrPage.Editable(not CurrPage.LookupMode);
    end;
}

