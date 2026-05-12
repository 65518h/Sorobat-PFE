Page 80001 "Chart Sub-Form"
{
    Caption = 'Chart Sub-Form';
    Editable = false;
    MultipleNewLines = false;
    PageType = CardPart;

    layout
    {
        area(content)
        {
            field(findBox; findBox)
            {
                ApplicationArea = Basic;
                Caption = 'André';
                Visible = true;
            }
        }
    }

    actions
    {
    }

    var
        findBox: Text[30];


    procedure ActivateMe()
    begin
        CurrPage.Activate;
    end;
}

