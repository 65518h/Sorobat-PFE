Page 50175 "Commande Recu Non Facturé"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Purchase Line";
    SourceTableView = where("Document Type" = const(Order),
                            Type = const(Item),
                            "Qty. Rcd. Not Invoiced" = filter(<> 0),
                            Status = filter(<> Archived),
                            "Quantity Received" = filter(> 0),
                            "Qty. Rcd. Not Invoiced" = filter(0));
    ApplicationArea = all;
    Caption = 'Commande Recu Non Facturé';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                ShowCaption = false;
                field("Order Date"; REC."Order Date")
                {
                    ApplicationArea = all;
                }
                field("Document No."; REC."Document No.")
                {
                    ApplicationArea = all;
                }
                field("No."; REC."No.")
                {
                    ApplicationArea = all;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Quantity; REC.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Quantity Received"; REC."Quantity Received")
                {
                    ApplicationArea = all;
                }
                field("Qty. Rcd. Not Invoiced"; REC."Qty. Rcd. Not Invoiced")
                {
                    ApplicationArea = all;
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

