Page 52049075 "Modéle Véhicule"
{//GL2024  ID dans Nav 2009 : "39004715"
    PageType = List;
    SourceTable = "Modéle véhicule";
    ApplicationArea = All;
    Caption = 'Modéle Véhicule';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code Modéle"; Rec."Code Modéle")
                {
                    ApplicationArea = Basic;
                }
                field("Désignation"; Rec.Désignation)
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

