Page 50000 "PV Reception"
{
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "PV Reception";
    Caption = 'PV Reception';
    ApplicationArea = all;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {

            label(COMMANDE)
            {
                ApplicationArea = all;
                Caption = 'Commande';
                //CaptionClass = Text19031350;
                Style = Strong;
                StyleExpr = true;
            }

            field("N° Commande"; rec."N° Commande")
            {
                ApplicationArea = all;
            }
            field("N° Article"; rec."N° Article")
            {
                ApplicationArea = all;
            }
            field("Date Commande"; rec."Date Commande")
            {
                ApplicationArea = all;
            }
            field("N° Receptipon"; rec."N° Receptipon")
            {
                ApplicationArea = all;
            }
            field("N° Affaire"; rec."N° Affaire")
            {
                ApplicationArea = all;
                Caption = 'Destination';
            }
            field("N° Reception Enregistré"; rec."N° Reception Enregistré")
            {
                ApplicationArea = all;
            }


            label("BON LIVRAISON")
            {
                ApplicationArea = all;
                Caption = 'Bon livraison';
                //CaptionClass = Text19063309;
                Style = Strong;
                StyleExpr = true;
            }

            field("Lieu De Chargement"; rec."Lieu De Chargement")
            {
                ApplicationArea = all;
            }
            field("N° BL Fournisseur"; rec."N° BL Fournisseur")
            {
                ApplicationArea = all;
            }
            field("N° Camion"; rec."N° Camion")
            {
                ApplicationArea = all;
            }
            field("Code Magasin"; rec."Code Magasin")
            {
                ApplicationArea = all;
            }
            field("Date Heure depart Chatier"; rec."Date Heure depart Chatier")
            {
                ApplicationArea = all;
            }
            field("Date Heure Chargement Frs"; rec."Date Heure Chargement Frs")
            {
                ApplicationArea = all;
            }
            field("Date Heure Retour Chantier"; rec."Date Heure Retour Chantier")
            {
                ApplicationArea = all;
            }
            label(CHARGEMENT)
            {
                ApplicationArea = all;
                Caption = 'Chargement';
                //CaptionClass = Text19004459;
                Style = Strong;
                StyleExpr = true;
            }

            field("Tare Chez Fournisseur"; rec."Tare Chez Fournisseur")
            {
                ApplicationArea = all;
            }
            field("Poids Brut Fournisseur"; rec."Poids Brut Fournisseur")
            {
                ApplicationArea = all;
            }
            field("Poids Net Fournisseur"; rec."Poids Net Fournisseur")
            {
                ApplicationArea = all;
            }


            label("RECEPTION CHANTIER")
            {
                ApplicationArea = all;
                Caption = 'Reception ChantierN';
                //CaptionClass = Text19017289;
                Style = Strong;
                StyleExpr = true;
            }
            field("Tare Chantier"; rec."Tare Chantier")
            {
                ApplicationArea = all;
            }
            field("Poids Brut Chantier"; rec."Poids Brut Chantier")
            {
                ApplicationArea = all;
            }
            field("Poids Net Chantier"; rec."Poids Net Chantier")
            {
                ApplicationArea = all;
            }
            field("Ecart Poids Net Chantier"; rec."Ecart Poids Net Chantier")
            {
                ApplicationArea = all;
            }
            field("Poids Apres SC"; rec."Poids Apres SC")
            {
                ApplicationArea = all;
            }
            field("Quantité SC"; rec."Quantité SC")
            {
                ApplicationArea = all;
            }
            field("Ecart Final"; rec."Ecart Final")
            {
                ApplicationArea = all;
            }
            field("Poids Aprés CB"; rec."Poids Aprés CB")
            {
                ApplicationArea = all;
            }
            field("Quantité CB"; rec."Quantité CB")
            {
                ApplicationArea = all;
            }
            field(Remarque; rec.Remarque)
            {
                ApplicationArea = all;
                MultiLine = true;
            }






        }
    }

    actions
    {
    }

    var
        IntChargementTare: Integer;
        IntChargementPoidBrute: Integer;
        IntChargementPoidsNet: Integer;
        IntChantierTare: Integer;
        IntChantierPoidsBrute: Integer;
        IntChantiePoidsNet: Integer;
        Text19021451: label 'PV RECEPTION';
        Text19031350: label 'COMMANDE';
        Text19063309: label 'BON LIVRAISON';
        Text19004459: label 'CHARGEMENT';
        Text19017289: label 'RECEPTION CHANTIER';

}

