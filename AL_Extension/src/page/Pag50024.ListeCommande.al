page 50024 "Liste Commande"
{
    PageType = List;
    SourceTable = 38;

    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                Editable = false;
                field("No."; rec."No.")
                {
                }
                field("Pay-to Vendor No."; rec."Pay-to Vendor No.")
                {
                }
                field("Pay-to Name"; rec."Pay-to Name")
                {
                }
                field("Order Date"; rec."Order Date")
                {
                }
                field("Posting Date"; rec."Posting Date")
                {
                }
                field("N° Demande d'achat"; rec."N° Demande d'achat")
                {
                }
            }
        }
    }

    actions
    {
    }
}

