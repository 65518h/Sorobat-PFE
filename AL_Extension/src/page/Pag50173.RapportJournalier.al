Page 50173 "Rapport Journalier"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Item;
    SourceTableView = where("Rapport Journalier" = const(true));
    ApplicationArea = all;
    Caption = 'Rapport Journalier';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                ShowCaption = false;
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Inventory; REC.Inventory)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Quantité Commandé"; REC."Quantité Commandé")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Base Unit of Measure"; REC."Base Unit of Measure")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Quantité Reçue"; REC."Quantité Reçue")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Quantité Restante"; REC."Quantité Restante")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
    }

    var
        Choix: Text[30];
}

