page 52049019 "Baréme De Charge"
{//  id dans nav"39001443"
    Caption = 'Baréme De Charge';
    DelayedInsert = true;
    Editable = true;
    PageType = Card;
    SourceTable = "Baréme De Charge";

    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                ShowCaption = false;
                field("Nombre De Charge"; rec."Nombre De Charge")
                {
                }
                field("% Abattement"; rec."% Abattement")
                {
                }
            }
        }
    }

    actions
    {
    }
}

