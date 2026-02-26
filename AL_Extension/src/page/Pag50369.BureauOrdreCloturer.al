page 50369 "List Bureau Ordre Cloturé"
{
    Editable = false;
    PageType = List;
    SourceTable = "Bureau Ordre";
    SourceTableView = WHERE(Clôturer = FILTER(true));
    Caption = 'List Bureau Ordre Cloturé';

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
                field(Journée; rec.Journée)
                {
                    ApplicationArea = all;
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
                field(Objet; rec.Objet)
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
                    RunObject = Page "Bureau Ordre Cloturé";
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