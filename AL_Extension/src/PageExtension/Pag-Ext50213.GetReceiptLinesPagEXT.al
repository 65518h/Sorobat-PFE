PageExtension 50213 "Get Receipt Lines_PagEXT" extends "Get Receipt Lines"

{

    //GL2024 SourceTableView=WHERE("No."=FILTER(<>é<>66580000));
    layout
    {
        modify(OrderNo)
        {
            Visible = false;
        }

        addafter("Document No.")
        {
            //  field("Vendor Shipment No."; gVendorShipNo)
            // Ajout un champ "Vendor Ship No." dans la table pour le remplir avec la variable gVendorShipNo, car il est impossible de lire gVendorShipNo (qui existe dans l'événement du CDU) dans la PageEXT.

            field("Num BL Fournisseur"; Rec."Num BL Fournisseur")
            {
                Caption = 'N° B.L. fournisseur';
                ApplicationArea = all;
            }
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = all;
            }
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = all;
                Editable = FALSE;
            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {

    }


    trigger OnOpenPage()
    begin
        Rec.FilterGroup(0);
        rec.SetFilter("No.", '<>%1|<>%2', 'FODEC&', '66580000');

        Rec.FilterGroup(2);
    end;


}
