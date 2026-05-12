pageextension 50304 "Invt. Receipt SubformEXT" extends "Invt. Receipt Subform"
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
                Visible = false;
            }
            field(Heure; Rec.Heure)
            {
                //   Visible = HeureVISIBLE;
                ApplicationArea = all;
                Visible = false;

            }
            field("Lieu De Livraison / Provenance"; Rec."Lieu De Livraison / Provenance")
            {
                //   Visible = "Lieu De Livraison / ProvenanceVISIBLE";
                ApplicationArea = all;
                Visible = false;
            }
            field("Quantité Demandé"; Rec."Quantité Demandé")
            {
                ApplicationArea = all;
                Visible = false;
            }

            field("Shelf No."; Rec."Shelf No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Filtre Materiel"; Rec."Filtre Materiel")
            {
                ApplicationArea = all;
                Visible = false;
            }
            // field("N° Materiel"; Rec."N° Materiel")
            // {
            //     Visible = "N° MaterielVISIBLE";
            //     ApplicationArea = all;
            // }
            field("Vehicule Transporteur"; Rec."Vehicule Transporteur")
            {
                ApplicationArea = all;
                Visible = FALSE;
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
                Visible = FALSE;
            }
            field("Index Horaire"; Rec."Index Horaire")
            {
                // Visible = "Index HoraireVISIBLE";
                ApplicationArea = all;
                Visible = FALSE;
            }
            field("Index Kilometrique"; Rec."Index Kilometrique")
            {
                //  Visible = "Index KilometriqueVISIBLE";
                ApplicationArea = all;
                Visible = FALSE;
            }
            field(Chauffeur; Rec.Chauffeur)
            {
                //   Visible = ChauffeurVISIBLE;
                ApplicationArea = all;
                Visible = FALSE;
            }
            field("Nom Utilisateur"; Rec."Nom Utilisateur")
            {
                // Visible = "Nom UtilisateurVISIBLE";
                ApplicationArea = all;
                Visible = FALSE;
            }
        }
        addafter("ShortcutDimCode[8]")
        {
            field(Observation; Rec.Observation)
            {
                ApplicationArea = all;
                Visible = FALSE;
            }
            field("Affectation Marche"; Rec."Affectation Marche")
            {
                ApplicationArea = all;
                Visible = FALSE;
            }
            field("Sous Affectation Marche"; Rec."Sous Affectation Marche")
            {
                ApplicationArea = all;
                Visible = FALSE;
            }
        }
        addafter(Description)
        {
            field("DYSJob No."; Rec."DYSJob No.")
            {
                ApplicationArea = all;
                Caption = 'N° affaire';
            }
            field("DYSJob Task No."; Rec."DYSJob Task No.")
            {
                ApplicationArea = all;
            }
            field("DYSJob Planning Line No."; Rec."DYSJob Planning Line No.") { ApplicationArea = all; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}