
page 52048955 Echelle
{//GL2024  ID dans Nav 2009 : "39001511"
    PageType = List;
    SourceTable = Echelle;
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Echelle';
    layout
    {
        area(content)
        {
            repeater(Control1120000)
            {
                ShowCaption = false;
                field("Catégorie"; Rec.Catégorie)
                {
                    ApplicationArea = Basic;
                }
                field(Echelle; Rec.Echelle)
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

