page 50280 "Rubrique Cout"
{
    PageType = Card;
    SourceTable = "Rubrique Cout";

    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                ShowCaption = false;
                field(Rubrique; rec.Rubrique)
                {
                }
            }
        }
    }

    actions
    {
    }
}

