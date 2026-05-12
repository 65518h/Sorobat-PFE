page 52048966 Direction
{
    //GL2024  ID dans Nav 2009 : "39001492"
    PageType = List;
    SourceTable = Direction;
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Direction';
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
                field(Designation; Rec.Designation)
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

