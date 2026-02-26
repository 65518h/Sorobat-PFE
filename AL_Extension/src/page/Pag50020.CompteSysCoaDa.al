page 50020 "Compte SysCoaDa"
{
    PageType = list;
    SourceTable = 50020;

    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                ShowCaption = false;
                field("N° Compte"; rec."N° Compte")
                {
                }
                field(Designation; rec.Designation)
                {
                }
            }
        }
    }

    actions
    {
    }
}

