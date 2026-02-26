page 50010 "Bureau Ordre Lister"
{
    Editable = false;
    PageType = List;
    SourceTable = "Bureau Ordre";
    // SourceTableView = SORTING("Document N°");
    Caption = 'Bureau Ordre Lister';

    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Document N°"; rec."Document N°")
                {
                    ApplicationArea = all;
                }
                field("Date Reception"; rec."Date Reception")
                {
                    ApplicationArea = all;
                }
                field(Journée; rec.Journée)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Receptionné Par"; rec."Receptionné Par")
                {
                    ApplicationArea = all;
                }
                field("Receptionné Le"; rec."Receptionné Le")
                {
                    ApplicationArea = all;
                }
                field("Categorie Document"; rec."Categorie Document")
                {
                    ApplicationArea = all;
                }
                field("Urgence"; rec."Urgence")
                {
                    ApplicationArea = all;
                }
                field("Type Tiers"; rec."Type Tiers")
                {
                    ApplicationArea = all;
                }
                field("Tiers"; rec."Tiers")
                {
                    ApplicationArea = all;
                }
                field("Nom Tiers"; rec."Nom Tiers")
                {
                    ApplicationArea = all;
                }


                field(Objet; rec.Objet)
                {
                    ApplicationArea = all;
                }
                field("livré par"; rec."livré par")
                {
                    ApplicationArea = all;
                }
                field(Clôturer; rec.Clôturer)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Fiche)
            {
                Caption = 'Card';
                action(Fiche1)
                {
                    Caption = 'Card';
                    RunObject = Page "Bureau Ordre";
                    RunPageLink = "Document N°" = FIELD("Document N°");
                    ShortCutKey = 'Maj+F7';
                    ApplicationArea = all;

                }
            }
        }
        area(Promoted)
        {
            group(Fiche2)
            {
                Caption = 'Card';
                actionref(Fiche3; Fiche1)
                { }

            }
        }
    }

}