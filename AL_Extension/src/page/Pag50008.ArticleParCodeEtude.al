Page 50008 "Article Par Code Etude"
{
    Editable = false;
    PageType = List;
    SourceTable = Item;
    SourceTableView = where("Code Etude" = filter(<> ''));
    Caption = 'Article Par Code Etude';
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code Etude"; rec."Code Etude")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Description; rec.Description)
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

