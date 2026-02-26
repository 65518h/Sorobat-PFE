Page 50169 "Alerte Seuil min"
{
    PageType = List;
    SourceTable = Item;
    /*  SourceTableView = sorting("Seuil Min")
                        where("Seuil Min" = filter(<> 0),
                              "Stop Min Max" = const(false));*/
    SourceTableView = SORTING("Seuil Min")
                    WHERE("Seuil Min" = FILTER(<> 0),
                          "Alerte Declenche" = CONST(true));
    ApplicationArea = all;
    Caption = 'Alerte Seuil min';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                ShowCaption = false;
                field("No."; REC."No.")
                {
                    ApplicationArea = all;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                }
                field(Inventory; REC.Inventory)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Seuil Min"; REC."Seuil Min")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("DA Lancé"; REC."DA Lancé")
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

