page 52049022 "Tranche STC"
{//  id dans nav"39001513"
    DelayedInsert = true;
    PageType = Card;
    SourceTable = "Tranche STC";

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
                field("Taux STC"; rec."Taux STC")
                {
                }
            }
        }
    }

    actions
    {
    }
}

