page 50050 "Ligne Commande"
{
    Editable = false;
    PageType = Card;
    SourceTable = 39;
    SourceTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE(Quantity = FILTER(<> 0), "Document Type" = CONST(Order), Type = CONST(Item));

    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                ShowCaption = false;
                field("Expected Receipt Date"; rec."Expected Receipt Date")
                {
                    Caption = 'Expected Receipt Date';
                }
                field("Document No."; rec."Document No.")
                {
                }
                field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
                {
                }
                field(Type; rec.Type)
                {
                }
                field("No."; rec."No.")
                {
                }
                field(Description; rec.Description)
                {
                }
                field("Location Code"; rec."Location Code")
                {
                }
                field(Quantity; rec.Quantity)
                {
                }
                field("Outstanding Quantity"; rec."Outstanding Quantity")
                {
                }
                field("Quantity Received"; rec."Quantity Received")
                {
                }
                field(Amount; rec.Amount)
                {
                }
                field("Qty. Rcd. Not Invoiced"; rec."Qty. Rcd. Not Invoiced")
                {
                }
                field("Quantity Invoiced"; rec."Quantity Invoiced")
                {
                }
            }
        }
    }

    actions
    {
    }
}

