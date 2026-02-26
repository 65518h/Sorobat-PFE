
Page 52048997 "Param Payéage"
{//GL2024  ID dans Nav 2009 : "39004745"
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Payéage";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1120000)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = Basic;
                }
                field("Coût"; Rec.Coût)
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

