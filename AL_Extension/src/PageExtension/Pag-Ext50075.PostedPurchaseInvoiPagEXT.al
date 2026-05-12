PageExtension 50075 "Posted Purchase Invoi_PagEXT" extends "Posted Purchase Invoices"
{
    //GL2024     SourceTableView=WHERE(Simulation=FILTER(No));
    layout
    {
        addbefore("No.")
        {
            field("Posting Date2"; Rec."Posting Date")
            {
                ApplicationArea = all;
            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = all;
            }
            field("N° Reception"; Rec."N° Reception")
            {
                ApplicationArea = all;
            }
            field("N° Commande"; Rec."N° Commande")
            {
                ApplicationArea = all;
            }
        }

        addafter("No.")
        {
            field("En instance Controle Facture"; Rec."En instance Controle Facture")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }

        addafter("Buy-from Vendor Name")
        {
            /* field("Vendor Invoice No."; Rec."Vendor Invoice No.")
             {
                 ApplicationArea = all;
             }*/
            field("Statut Facture"; Rec."Statut Facture")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(Simulation; Rec.Simulation)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Posting Description"; Rec."Posting Description")
            {
                ApplicationArea = all;
            }
            field("Order No.1"; Rec."Order No.")
            {
                ApplicationArea = all;
            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
            }
            field("On Hold"; Rec."On Hold")
            {
                ApplicationArea = all;
            }
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
            }
            field("Order No.2"; Rec."Order No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Posting Date")
        {
            field("Document Date2"; Rec."Document Date")
            {
                ApplicationArea = all;
            }
        }

    }

    trigger OnOpenPage()
    VAR

    begin
        Rec.FilterGroup(0);
        Rec.Setrange("Simulation", false);
        Rec.FilterGroup(2);
    end;


}

