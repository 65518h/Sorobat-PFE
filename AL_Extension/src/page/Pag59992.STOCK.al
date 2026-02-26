Page 59992 STOCK
{
    PageType = List;
    SourceTable = "Item Ledger Entry";
    Caption = 'STOCK';
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Entry No."; REC."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Item No."; REC."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; REC."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Entry Type"; REC."Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Source No."; REC."Source No.")
                {
                    ApplicationArea = all;
                }
                field("Document No."; REC."Document No.")
                {
                    ApplicationArea = all;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                }
                field("Location Code"; REC."Location Code")
                {
                    ApplicationArea = all;
                }
                field(Quantity; REC.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Remaining Quantity"; REC."Remaining Quantity")
                {
                    ApplicationArea = all;
                }
                field("Invoiced Quantity"; REC."Invoiced Quantity")
                {
                    ApplicationArea = all;
                }
                field("Applies-to Entry"; REC."Applies-to Entry")
                {
                    ApplicationArea = all;
                }
                field(Open; REC.Open)
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; REC."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; REC."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field(Positive; REC.Positive)
                {
                    ApplicationArea = all;
                }
                field("Source Type"; REC."Source Type")
                {
                    ApplicationArea = all;
                }
                field("Drop Shipment"; REC."Drop Shipment")
                {
                    ApplicationArea = all;
                }
                field("Transaction Type"; REC."Transaction Type")
                {
                    ApplicationArea = all;
                }
                field("Transport Method"; REC."Transport Method")
                {
                    ApplicationArea = all;
                }
                field("Country/Region Code"; REC."Country/Region Code")
                {
                    ApplicationArea = all;
                }
                field("Entry/Exit Point"; REC."Entry/Exit Point")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; REC."Document Date")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; REC."External Document No.")
                {
                    ApplicationArea = all;
                }
                field("Area"; REC.Area)
                {
                    ApplicationArea = all;
                }
                field("Transaction Specification"; REC."Transaction Specification")
                {
                    ApplicationArea = all;
                }
                field("No. Series"; REC."No. Series")
                {
                    ApplicationArea = all;
                }
                field("Reserved Quantity"; REC."Reserved Quantity")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; REC."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Document Line No."; REC."Document Line No.")
                {
                    ApplicationArea = all;
                }
                field("Job No."; REC."Job No.")
                {
                    ApplicationArea = all;
                }
                field("Job Task No."; REC."Job Task No.")
                {
                    ApplicationArea = all;
                }
                field("Job Purchase"; REC."Job Purchase")
                {
                    ApplicationArea = all;
                }
                /*
                //DYS champs supprimer
                field("Prod. Order No."; REC."Prod. Order No.")
                {
                    ApplicationArea = all;
                }
                */
                field("Variant Code"; REC."Variant Code")
                {
                    ApplicationArea = all;
                }
                field("Qty. per Unit of Measure"; REC."Qty. per Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure Code"; REC."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("Derived from Blanket Order"; REC."Derived from Blanket Order")
                {
                    ApplicationArea = all;
                }
                /*
                //DYS champs supprimer
                field("Cross-Reference No."; REC."Cross-Reference No.")
                {
                    ApplicationArea = all;
                }
                */
                field("Originally Ordered No."; REC."Originally Ordered No.")
                {
                    ApplicationArea = all;
                }
                field("Originally Ordered Var. Code"; REC."Originally Ordered Var. Code")
                {
                    ApplicationArea = all;
                }
                field("Out-of-Stock Substitution"; REC."Out-of-Stock Substitution")
                {
                    ApplicationArea = all;
                }
                field("Item Category Code"; REC."Item Category Code")
                {
                    ApplicationArea = all;
                }
                field(Nonstock; REC.Nonstock)
                {
                    ApplicationArea = all;
                }
                field("Purchasing Code"; REC."Purchasing Code")
                {
                    ApplicationArea = all;
                }
                /*
                //DYS champs supprimer
                field("Product Group Code"; REC."Product Group Code")
                {
                    ApplicationArea = all;
                }
                field("Transfer Order No."; REC."Transfer Order No.")
                {
                    ApplicationArea = all;
                }
                */
                field("Completely Invoiced"; REC."Completely Invoiced")
                {
                    ApplicationArea = all;
                }
                field("Last Invoice Date"; REC."Last Invoice Date")
                {
                    ApplicationArea = all;
                }
                field("Applied Entry to Adjust"; REC."Applied Entry to Adjust")
                {
                    ApplicationArea = all;
                }
                field("Cost Amount (Expected)"; REC."Cost Amount (Expected)")
                {
                    ApplicationArea = all;
                }
                field("Cost Amount (Actual)"; REC."Cost Amount (Actual)")
                {
                    ApplicationArea = all;
                }
                field("Cost Amount (Non-Invtbl.)"; REC."Cost Amount (Non-Invtbl.)")
                {
                    ApplicationArea = all;
                }
                field("Cost Amount (Expected) (ACY)"; REC."Cost Amount (Expected) (ACY)")
                {
                    ApplicationArea = all;
                }
                field("Cost Amount (Actual) (ACY)"; REC."Cost Amount (Actual) (ACY)")
                {
                    ApplicationArea = all;
                }
                field("Cost Amount (Non-Invtbl.)(ACY)"; REC."Cost Amount (Non-Invtbl.)(ACY)")
                {
                    ApplicationArea = all;
                }
                field("Purchase Amount (Expected)"; REC."Purchase Amount (Expected)")
                {
                    ApplicationArea = all;
                }
                field("Purchase Amount (Actual)"; REC."Purchase Amount (Actual)")
                {
                    ApplicationArea = all;
                }
                field("Sales Amount (Expected)"; REC."Sales Amount (Expected)")
                {
                    ApplicationArea = all;
                }
                field("Sales Amount (Actual)"; REC."Sales Amount (Actual)")
                {
                    ApplicationArea = all;
                }
                field(Correction; REC.Correction)
                {
                    ApplicationArea = all;
                }
                field("Shipped Qty. Not Returned"; REC."Shipped Qty. Not Returned")
                {
                    ApplicationArea = all;
                }
                /*
                //DYS champs supprimer
                field("Prod. Order Line No."; REC."Prod. Order Line No.")
                {
                    ApplicationArea = all;
                }
                */
                field("Prod. Order Comp. Line No."; REC."Prod. Order Comp. Line No.")
                {
                    ApplicationArea = all;
                }
                /*
                //DYS champs supprimer
                field("Service Order No."; REC."Service Order No.")
                {
                    ApplicationArea = all;
                }
                */
                field("Serial No."; REC."Serial No.")
                {
                    ApplicationArea = all;
                }
                field("Lot No."; REC."Lot No.")
                {
                    ApplicationArea = all;
                }
                field("Warranty Date"; REC."Warranty Date")
                {
                    ApplicationArea = all;
                }
                field("Expiration Date"; REC."Expiration Date")
                {
                    ApplicationArea = all;
                }
                field("Item Tracking"; REC."Item Tracking")
                {
                    ApplicationArea = all;
                }
                field("Return Reason Code"; REC."Return Reason Code")
                {
                    ApplicationArea = all;
                }
                field("N° dossier"; REC."N° dossier")
                {
                    ApplicationArea = all;
                }
                field("Centre de Gestion"; REC."Centre de Gestion")
                {
                    ApplicationArea = all;
                }
                field(Famille; REC.Famille)
                {
                    ApplicationArea = all;
                }
                field("Code Nature"; REC."Code Nature")
                {
                    ApplicationArea = all;
                }
                field(Materiel; REC.Materiel)
                {
                    ApplicationArea = all;
                }
                field(Chantier; REC."N° Affaire")
                {
                    ApplicationArea = all;
                }
                field("Type Index"; REC."Type Index")
                {
                    ApplicationArea = all;
                }
                field("Nom Utilisateur"; REC."Nom Utilisateur")
                {
                    ApplicationArea = all;
                }
                field(Heure; REC.Heure)
                {
                    ApplicationArea = all;
                }
                field(Chauffeur; REC.Chauffeur)
                {
                    ApplicationArea = all;
                }
                field(Destination; REC.Destination)
                {
                    ApplicationArea = all;
                }
                field("Index Horaire"; REC."Index Horaire")
                {
                    ApplicationArea = all;
                }
                field("Index Kilometrique"; REC."Index Kilometrique")
                {
                    ApplicationArea = all;
                }
                field("Magasin Destination"; REC."Magasin Destination")
                {
                    ApplicationArea = all;
                }
                field("N° Véhicule"; REC."N° Véhicule")
                {
                    ApplicationArea = all;
                }
                field(Consommation; REC.Consommation)
                {
                    ApplicationArea = all;
                }
                field("Consommation Intégré"; REC."Consommation Intégré")
                {
                    ApplicationArea = all;
                }
                field("Num Ligne Commande"; REC."Num Ligne Commande")
                {
                    ApplicationArea = all;
                }
                field("Numero Commande"; REC."Numero Commande")
                {
                    ApplicationArea = all;
                }
                field(Synchronise; REC.Synchronise)
                {
                    ApplicationArea = all;
                }
                field("Num Bl Fournisseur"; REC."Num Bl Fournisseur")
                {
                    ApplicationArea = all;
                }
                // field(Emplacement; REC.Emplacement)
                // {
                //     ApplicationArea = all;
                // }
                field(Receptioneur; REC.Receptioneur)
                {
                    ApplicationArea = all;
                }
                field("Vehicule Transporteur"; REC."Vehicule Transporteur")
                {
                    ApplicationArea = all;
                }
                field("Num Sequence Synchro"; REC."Num Sequence Synchro")
                {
                    ApplicationArea = all;
                }
                // field("Lieu Livraison / Provenance"; REC."Lieu Livraison / Provenance")
                // {
                //     ApplicationArea = all;
                // }
                field("Job Quantity"; REC."Job Quantity")
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

