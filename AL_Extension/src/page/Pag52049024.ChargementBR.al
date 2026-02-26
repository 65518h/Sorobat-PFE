page 52049024 "Chargement BR"
{//  id dans nav"39004733"
    Editable = false;
    PageType = Card;
    SourceTable = 120;

    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                ShowCaption = false;
                field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
                {
                }
                field("No."; rec."No.")
                {
                }
                field("Pay-to Name"; rec."Pay-to Name")
                {
                }
                field("Pay-to Address"; rec."Pay-to Address")
                {
                }
                field("Shipment Method Code"; rec."Shipment Method Code")
                {
                }
                field("Order No."; rec."Order No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

