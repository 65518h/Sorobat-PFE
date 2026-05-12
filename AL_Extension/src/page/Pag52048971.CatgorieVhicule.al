page 52048971 "Catégorie Véhicule"
{//GL2024  ID dans Nav 2009 : "39004681"
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Catégorie Véhicule";
    ApplicationArea = All;
    Caption = 'Catégorie Véhicule';

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code Catégorie"; REC."Code Catégorie")
                {
                    ApplicationArea = all;
                }
                field(Désignation; REC.Désignation)
                {
                    ApplicationArea = all;
                }
                // field("Cout Location Journalier"; REC."Cout Location Journalier")
                // {
                //     ApplicationArea = all;
                // }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Sous-Catégorie Véhicule")
            {
                ApplicationArea = all;
                Caption = 'Sous-Catégorie Véhicule';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Sous-Catégorie Véhicule";
                RunPageLink = "Code Catégorie" = FIELD("Code Catégorie");
                RunPageView = SORTING("Code Catégorie", "Code Sous-Catégorie");
            }
        }
    }
}

