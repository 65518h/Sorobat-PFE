page 52049023 "Chargement BL"
{//  id dans nav"39004732"
    Editable = false;
    PageType = Card;
    SourceTable = 110;

    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                ShowCaption = false;
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                }
                field("No."; rec."No.")
                {
                }
                field("Bill-to Name"; rec."Bill-to Name")
                {
                }
                field("Bill-to Address"; rec."Bill-to Address")
                {
                }
                field("Shipment Method Code"; rec."Shipment Method Code")
                {
                }
                field("Order No."; rec."Order No.")
                {
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                }
                field("Promised Delivery Date"; rec."Promised Delivery Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

