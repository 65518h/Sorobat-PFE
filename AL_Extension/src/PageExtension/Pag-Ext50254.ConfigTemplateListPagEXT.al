PageExtension 50254 "Config. Template List_PagEXT" extends "Config. Template List"
{
    layout
    {
    }

    actions
    {
        addlast(Creation)
        {
            group(Modèle)
            {
                Caption = 'Template';
                action(Fiche)
                {
                    Caption = 'Fiche';
                    ApplicationArea = all;
                    ShortCutKey = 'Shift+F5';
                    RunObject = Page "Config. Template Header";
                    RunPageLink = Code = FIELD(Code);
                }

            }
        }
    }

}