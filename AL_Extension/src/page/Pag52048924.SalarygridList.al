page 52048924 "Salary grid List"
{
    //GL2024  ID dans Nav 2009 : "39001445"
    Caption = 'Salary grid List';
    Editable = false;
    PageType = List;
    SourceTable = "Salary grid header";
    //ABZ ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1180250000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Date Debut"; Rec."Date Debut")
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

