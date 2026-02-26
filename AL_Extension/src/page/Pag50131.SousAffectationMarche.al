page 50131 "Sous Affectation Marche"
{
    DelayedInsert = true;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Sous Affectation Marche";

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
                field(Stockable; rec.Stockable)
                {
                    Editable = false;
                }
                field(Marche; rec.Marche)
                {
                }
            }
        }
    }

    actions
    {
    }
}

