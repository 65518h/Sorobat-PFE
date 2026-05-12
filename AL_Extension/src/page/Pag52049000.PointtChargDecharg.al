Page 52049000 "Pointt Charg Decharg"
{//GL2024  ID dans Nav 2009 : "39004750"
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Chargement - Dechargement";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Code"; Rec.Code)
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

    var
        Dispo: Page "Dispo. Véhicule";
}

