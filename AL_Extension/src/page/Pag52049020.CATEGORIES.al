page 52049020 CATEGORIES
{//  id dans nav"39001444"
    Caption = 'Category';
    Editable = true;
    PageType = Card;
    SourceTable = CATEGORIES;

    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                ShowCaption = false;
                field(Code; rec.Code)
                {
                }
                field(Description; rec.Description)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

