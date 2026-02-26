page 52048893 "Config Regimes of work"
{
    //GL2024  ID dans Nav 2009 : "39001414"
    Caption = 'Regimes of work';
    PageType = list;
    SourceTable = "Regimes of work";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field("Désignation"; Rec.Désignation)
                {
                    ApplicationArea = Basic;
                }
                field("Default Regime"; Rec."Default Regime")
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

