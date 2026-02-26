Page 50235 "Controle Production Validé"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Production Order";
    SourceTableView = where("Source No." = filter('BET*'),
                            "Integrer BL" = const(true));
    ApplicationArea = all;
    Caption = 'Controle Production Validé';
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; REC."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Source No."; REC."Source No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Due Date"; REC."Due Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Location Code"; REC."Location Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Quantity; REC.Quantity)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Centrale; REC.Centrale)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("N° BL"; REC."N° BL")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field(Destination; REC.Destination)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Code Commande Vente"; REC."Code Commande Vente")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
    }
}

