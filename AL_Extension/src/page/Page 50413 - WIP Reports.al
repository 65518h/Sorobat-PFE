page 52049044 "WIP Reports"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "WIP Report Header";
    SourceTableView = where(Status = const(Open));
    CardPageId = "WIP Report Header";
    caption = 'WIP Reports';
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;

                }

                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
}