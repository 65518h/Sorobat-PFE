Page 50184 "Liste Main Oeuvre"
{
    PageType = List;
    SourceTable = Resource;
    SourceTableView = where(Type = const(Person));
    ApplicationArea = all;
    Caption = 'Liste Main Oeuvre';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; REC."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Name; REC.Name)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Unit Cost"; REC."Unit Cost")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

