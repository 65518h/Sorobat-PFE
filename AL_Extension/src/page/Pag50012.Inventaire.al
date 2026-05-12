Page 50012 Inventaire
{
    PageType = List;
    SourceTable = "Phys. Inventory Ledger Entry";
    Caption = 'Inventaire';
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                Editable = false;
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Qty. (Calculated)"; rec."Qty. (Calculated)")
                {
                    ApplicationArea = all;
                }
                field("Qty. (Phys. Inventory)"; rec."Qty. (Phys. Inventory)")
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                    Caption = 'Ecart';
                }
            }
        }
    }

    actions
    {
    }
}

