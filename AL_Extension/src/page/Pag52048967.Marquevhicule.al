page 52048967 "Marque véhicule"
{//GL2024  ID dans Nav 2009 : "39004677"
    PageType = List;
    SourceTable = "Marque Véhicule";
    ApplicationArea = All;
    Caption = 'Marque véhicule';

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code Marque"; REC."Code Marque")
                {
                    ApplicationArea = all;
                }
                field(Désignation; REC.Désignation)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            //GL2024 action("Modéles")
            // {ApplicationArea = all;
            //     Caption = 'Modéles';
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page 70048;
            //     RunPageLink = Field1 = FIELD("Code Marque");
            // }
        }
    }
}

