page 52049055 "WIP Reports Archive"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "WIP Report Header";
    SourceTableView = where(Status = const(Released));
    CardPageId = "WIP Report Header Archive";
    Caption = 'WIP Reports Archive';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
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