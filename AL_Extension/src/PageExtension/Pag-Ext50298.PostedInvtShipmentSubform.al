pageextension 50298 "Posted Invt. Shipment Subform" extends "Posted Invt. Shipment Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Code Variante"; Rec."Code Variante")
            {
                //   Visible = "Code VarianteVISIBLE";
                ApplicationArea = all;
                Editable = FALSE;
            }
            field(Heure; Rec.Heure)
            {
                //   Visible = HeureVISIBLE;
                ApplicationArea = all;

            }
            field("Lieu De Livraison / Provenance"; Rec."Lieu De Livraison / Provenance")
            {
                //   Visible = "Lieu De Livraison / ProvenanceVISIBLE";
                ApplicationArea = all;
            }
            field("Quantité Demandé"; Rec."Quantité Demandé")
            {
                ApplicationArea = all;
            }

            field("Shelf No."; Rec."Shelf No.")
            {
                ApplicationArea = all;
            }
            field("Filtre Materiel"; Rec."Filtre Materiel")
            {
                ApplicationArea = all;
            }
            // field("N° Materiel"; Rec."N° Materiel")
            // {
            //     Visible = "N° MaterielVISIBLE";
            //     ApplicationArea = all;
            // }
            field("Vehicule Transporteur"; Rec."Vehicule Transporteur")
            {
                ApplicationArea = all;
            }
            field(Heure2; Rec.Heure)
            {
                ApplicationArea = all;
                Visible = FALSE;
            }
            field("Type Index"; Rec."Type Index")
            {
                // Visible = "Type IndexVISIBLE";
                ApplicationArea = all;
            }
            field("Index Horaire"; Rec."Index Horaire")
            {
                // Visible = "Index HoraireVISIBLE";
                ApplicationArea = all;
            }
            field("Index Kilometrique"; Rec."Index Kilometrique")
            {
                //  Visible = "Index KilometriqueVISIBLE";
                ApplicationArea = all;
            }
            field(Chauffeur; Rec.Chauffeur)
            {
                //   Visible = ChauffeurVISIBLE;
                ApplicationArea = all;
            }
            field("Nom Utilisateur"; Rec."Nom Utilisateur")
            {
                // Visible = "Nom UtilisateurVISIBLE";
                ApplicationArea = all;
            }
        }
        addafter("ShortcutDimCode[8]")
        {
            field(Observation; Rec.Observation)
            {
                ApplicationArea = all;
            }
            field("Affectation Marche"; Rec."Affectation Marche")
            {
                ApplicationArea = all;
            }
            field("Sous Affectation Marche"; Rec."Sous Affectation Marche")
            {
                ApplicationArea = all;
            }
        }
        addafter(Description)
        {
            field("DYSJob No."; Rec."DYSJob No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("DYSJob Task No."; Rec."DYSJob Task No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("DYSJob Planning Line No."; Rec."DYSJob Planning Line No.") { ApplicationArea = all; Editable = false; }
            field("N° Piéce"; Rec."N° Piéce")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}