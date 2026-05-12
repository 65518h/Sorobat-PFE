page 50013 "Entete Suivi Puce"
{
    //GL2024 Page not compiled in Nav 2009
    Caption = 'Transfer Order Shipment';
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = Demandeur;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Nom Et Prenom"; rec."Nom Et Prenom")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }

            }
            part("Transfer Order Subf Shipment"; "Transfer Order Subf Shipment")
            {
                ApplicationArea = all;
                Caption = 'Transfer Order Subf Shipment';
                SubPageLink = "Document No." = FIELD("Nom Et Prenom");
            }
        }
    }

    actions
    {
    }

    var
        TransferPostShipment: Codeunit "TransferOrder-Post Shipment";
}

