page 52049021 "Prime Ancienneté"
{//  id dans nav"39001510"
    PageType = Card;
    SourceTable = "Prime Ancienneté";

    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                ShowCaption = false;
                field("Plage Min"; rec."Plage Min")
                {
                }
                field("Plage Max"; rec."Plage Max")
                {
                }
                field(Taux; rec.Taux)
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        SEP: Code[10];
}

