Page 50208 "Commande Central Enrobe"
{
    PageType = List;
    SourceTable = "Commande Central Enrobe";
    SourceTableView = sorting("Num Bon")
                      where(Status = filter("En cours"));
    ApplicationArea = all;
    Caption = 'Commande Central Enrobe';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Num Bon"; REC."Num Bon")
                {
                    ApplicationArea = all;
                }
                field(Date; REC.Date)
                {
                    ApplicationArea = all;
                }
                field("Type Client"; REC."Type Client")
                {
                    ApplicationArea = all;
                }
                field("Code Client"; REC."Code Client")
                {
                    ApplicationArea = all;
                }
                field(Nom; REC.Nom)
                {
                    ApplicationArea = all;
                }
                field("Code Produit"; REC."Code Produit")
                {
                    ApplicationArea = all;
                }
                field("Description Produit"; REC."Description Produit")
                {
                    ApplicationArea = all;
                }
                field("Code Central"; REC."Code Central")
                {
                    ApplicationArea = all;
                }
                field("Quantité"; REC.Quantité)
                {
                    ApplicationArea = all;
                }
                field("Prix Unitaire"; REC."Prix Unitaire")
                {
                    ApplicationArea = all;
                }
                field(Montant; REC.Montant)
                {
                    ApplicationArea = all;
                }
                field("Code Camion"; REC."Code Camion")
                {
                    ApplicationArea = all;
                }
                field("Description Camion"; REC."Description Camion")
                {
                    ApplicationArea = all;
                }
                field(Chauffeur; REC.Chauffeur)
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

