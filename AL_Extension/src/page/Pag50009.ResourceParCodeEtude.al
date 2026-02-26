Page 50009 "Resource Par Code Etude"
{
    Editable = false;
    PageType = List;
    SourceTable = Resource;
    SourceTableView = where("Code Etude" = filter(<> ''));
    Caption = 'Resource Par Code Etude';
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                }
                field("Code Etude"; rec."Code Etude")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = all;
                }
                field("No."; rec."No.")
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

