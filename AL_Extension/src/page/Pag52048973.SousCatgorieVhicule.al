Page 52048973 "Sous-Catégorie Véhicule"
{//GL2024  ID dans Nav 2009 : "39004682"
    PageType = List;
    SourceTable = "Sous Catégorie Véhicule";
    ApplicationArea = All;
    Caption = 'Sous-Catégorie Véhicule';

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code Catégorie"; Rec."Code Catégorie")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Code Sous-Catégorie"; Rec."Code Sous-Catégorie")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

