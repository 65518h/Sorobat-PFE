
Page 52048989 "Liste Frais de mission"
{//GL2024  ID dans Nav 2009 : "39004731"
    Editable = false;
    PageType = List;
    SourceTable = "Entête Frais de mission";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("N° Frais"; Rec."N° Frais")
                {
                    ApplicationArea = Basic;
                }
                field("Code Mission"; Rec."Code Mission")
                {
                    ApplicationArea = Basic;
                }
                field("N° Salarié"; Rec."N° Salarié")
                {
                    ApplicationArea = Basic;
                }
                field("Date Comptabilisation"; Rec."Date Comptabilisation")
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

