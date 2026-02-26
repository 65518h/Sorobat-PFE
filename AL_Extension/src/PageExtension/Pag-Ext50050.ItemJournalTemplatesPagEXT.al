PageExtension 50050 "Item Journal Templates_PagEXT" extends "Item Journal Templates"
{
    layout
    {

        addafter(type)
        {
            field("Entry Type"; rec."Entry Type")
            {
                ApplicationArea = all;
            }
            field("Transfert Inter Chantier"; rec."Transfert Inter Chantier")
            {
                ApplicationArea = all;
            }
            field("Inverser Signe"; rec."Inverser Signe")
            {
                ApplicationArea = all;
            }
            field(Magasin; rec.Magasin)
            {
                ApplicationArea = all;
            }
            field(Consommation; rec.Consommation)
            {
                ApplicationArea = all;
            }
            field(Production; rec.Production)
            {
                ApplicationArea = all;
            }
            field("Bon Sortie"; rec."Bon Sortie")
            {
                ApplicationArea = all;

                trigger OnValidate()
                begin
                    rec."Entry Type" := rec."Entry Type"::"Negative Adjmt.";
                end;
            }
            field("Affaire Obligatoire"; rec."Affaire Obligatoire")
            {
                ApplicationArea = all;
            }
            field("PC-PCHANTIER"; rec."PC-PCHANTIER")
            {
                ApplicationArea = all;
            }
            field("Affectation Marche Obligatoire"; rec."Affectation Marche Obligatoire")
            {
                ApplicationArea = all;
            }
            field("Sous Affect Marche Obligatoire"; rec."Sous Affect Marche Obligatoire")
            {
                ApplicationArea = all;
            }
            field("Materiel Obligatoire"; rec."Materiel Obligatoire")
            {
                ApplicationArea = all;
            }
            field("Synchronisation Automatique"; rec."Synchronisation Automatique")
            {
                ApplicationArea = all;
            }
            field("Filtre Utilisateur"; rec."Filtre Utilisateur")
            {
                ApplicationArea = all;
            }

            field("Approbateur 01"; rec."Approbateur 01")
            {
                ApplicationArea = all;
            }
            field("Approbateur 02"; rec."Approbateur 02")
            {
                ApplicationArea = all;
            }
            field("Approbateur 03"; rec."Approbateur 03")
            {
                ApplicationArea = all;
            }
            field("Feuille Affectaion Charge"; rec."Feuille Affectaion Charge")
            {
                ApplicationArea = all;
            }

            field("Afficher Index"; rec."Afficher Index")
            {
                ApplicationArea = all;
            }
            field("Afficher Heure"; rec."Afficher Heure")
            {
                ApplicationArea = all;
            }
            field("Afficher Nom Utilisateur"; rec."Afficher Nom Utilisateur")
            {
                ApplicationArea = all;
            }
            field("Afficher Destination"; rec."Afficher Destination")
            {
                ApplicationArea = all;
            }
            field("Afficher Materiel"; rec."Afficher Materiel")
            {
                ApplicationArea = all;
            }
            field("Afficher Affaire"; rec."Afficher Affaire")
            {
                ApplicationArea = all;
            }
            field("Afficher Chauffeur"; rec."Afficher Chauffeur")
            {
                ApplicationArea = all;
            }
        }

        addafter("Whse. Register Report Caption")
        {
            field("Affecter Utilisateur"; rec."Affecter Utilisateur")
            {
                ApplicationArea = all;
            }
        }

        addafter("Force Posting Report")
        {
            field("Synchronisation Automatique2"; rec."Synchronisation Automatique")
            {
                ApplicationArea = all;
            }
            field("Posting Report ID2"; rec."Posting Report ID")
            {
                ApplicationArea = all;
            }
        }
    }

}



