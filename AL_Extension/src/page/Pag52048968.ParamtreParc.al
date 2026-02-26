Page 52048968 "Paramétre Parc"
{//GL2024  ID dans Nav 2009 : "39004678"
    PageType = Card;
    SourceTable = "Paramétre Parc";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Paramétre Parc';

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Général';
                field("Durée Vignette"; Rec."Durée Vignette")
                {
                    ApplicationArea = Basic;
                }
                field("Durée Garantie"; Rec."Durée Garantie")
                {
                    ApplicationArea = Basic;
                }
                field("Durée Visite Technique"; Rec."Durée Visite Technique")
                {
                    ApplicationArea = Basic;
                }
                field("Durée Taxe"; Rec."Durée Taxe")
                {
                    ApplicationArea = Basic;
                }
                field("Article Gasoil"; Rec."Article Gasoil")
                {
                    ApplicationArea = Basic;
                }
                field("Coût Gasoil"; Rec."Coût Gasoil")
                {
                    ApplicationArea = Basic;
                }
                field("Journal Template"; Rec."Journal Template")
                {
                    ApplicationArea = Basic;
                }
                field("Journal Batch"; Rec."Journal Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Code Magasin"; Rec."Code Magasin")
                {
                    ApplicationArea = Basic;
                }
                field("Responsable Parc"; Rec."Responsable Parc")
                {
                    ApplicationArea = Basic;
                }
                field("Nom Responsable"; Rec."Nom Responsable")
                {
                    ApplicationArea = Basic;
                }
                field("Param Répar Vidange"; Rec."Param Répar Vidange")
                {
                    ApplicationArea = Basic;
                }
                // field("Derniere Date MAJ BTP"; Rec."Derniere Date MAJ BTP")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Heure Travail"; Rec."Heure Travail")
                {
                    ApplicationArea = Basic;
                }
                field("Nombre année Calcul AMJ"; Rec."Nombre année Calcul AMJ")
                {
                    ApplicationArea = Basic;
                }
                field("N° Bon de chargement"; Rec."N° Bon de chargement")
                {
                    ApplicationArea = Basic;
                }
                field("Pointage Serine N°"; Rec."Pointage Serine N°")
                {
                    ApplicationArea = Basic;
                }
                // field("% Disponibilité"; Rec."% Disponibilité")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("% Panne"; Rec."% Panne")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("% Charge Divers Cout Materiel"; Rec."% Charge Divers Cout Materiel")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Methode Calcul Cout Location E"; Rec."Methode Calcul Cout Location E")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Methode Calcul Cout Location M"; Rec."Methode Calcul Cout Location M")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Filtre Chantier"; Rec."Filtre Chantier")
                {
                    ApplicationArea = Basic;
                }
                field("Filtre Chantier2"; Rec."Filtre Chantier2")
                {
                    ApplicationArea = Basic;
                }
                // field("Filtre Chantier3"; Rec."Filtre Chantier3")
                // {
                //     ApplicationArea = Basic;
                // }
            }
            group("Numérotation")
            {
                Caption = 'Numérotation';
                field(Vehicule; Rec.Vehicule)
                {
                    ApplicationArea = Basic;
                    Caption = 'N° Vehicule';
                }
                field("N° Assurance"; Rec."N° Assurance")
                {
                    ApplicationArea = Basic;
                }
                field("N° Mission"; Rec."N° Mission")
                {
                    ApplicationArea = Basic;
                }
                field("N° Accident"; Rec."N° Accident")
                {
                    ApplicationArea = Basic;
                }
                field("N° Réparation"; Rec."N° Réparation")
                {
                    ApplicationArea = Basic;
                }
                field("N° Visite"; Rec."N° Visite")
                {
                    ApplicationArea = Basic;
                }
                // field("Programmation Serine N°"; Rec."Programmation Serine N°")
                // {
                //     ApplicationArea = Basic;
                // }
                field(Control1120010; Rec."Journal Template")
                {
                    ApplicationArea = Basic;
                }
                field(Control1120012; Rec."Journal Batch")
                {
                    ApplicationArea = Basic;
                }
                field(Control1120014; Rec."Code Magasin")
                {
                    ApplicationArea = Basic;
                }
                // field(Control1000000038; Rec."Programmation Serine N°")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Rendement Serie N°"; Rec."Rendement Serie N°")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Pointage Serie N°"; Rec."Pointage Serie N°")
                // {
                //     ApplicationArea = Basic;
                // }
                field("N° Rapport Chantier"; Rec."N° Rapport Chantier")
                {
                    ApplicationArea = Basic;
                }
                // field("Transport Serie N°"; Rec."Transport Serie N°")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Code Gamme"; Rec."Code Gamme")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Code BT Curative"; Rec."Code BT Curative")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Code BT Preventive"; Rec."Code BT Preventive")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Code Transfert Materiel"; Rec."Code Transfert Materiel")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Code Releve Mesure"; Rec."Code Releve Mesure")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Code Transfert Engin"; Rec."Code Transfert Engin")
                // {
                //     ApplicationArea = Basic;
                // }
            }
            group("Frais transporteur")
            {
                Caption = 'Frais transporteur';
                field("Coût heure marchandise"; Rec."Coût heure marchandise")
                {
                    ApplicationArea = Basic;
                }
                field("Coût kilometrage"; Rec."Coût kilometrage")
                {
                    ApplicationArea = Basic;
                }
                field("Coût heure livraison"; Rec."Coût heure livraison")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Image)
            {
                Caption = 'Image';
                field("Envoyer Rendement"; Rec."Envoyer Rendement")
                {
                    ApplicationArea = Basic;
                }
                field("Envoyer Production"; Rec."Envoyer Production")
                {
                    ApplicationArea = Basic;
                }
                field("Envoyer Attachement"; Rec."Envoyer Attachement")
                {
                    ApplicationArea = Basic;
                }
                field("Envoyer Pointage"; Rec."Envoyer Pointage")
                {
                    ApplicationArea = Basic;
                }
                field("Envoyer Caisse"; Rec."Envoyer Caisse")
                {
                    ApplicationArea = Basic;
                }
                field("Envoyer Magasin"; Rec."Envoyer Magasin")
                {
                    ApplicationArea = Basic;
                }
                field("Envoyer Parc"; Rec."Envoyer Parc")
                {
                    ApplicationArea = Basic;
                }
                field("Envoyer DA"; Rec."Envoyer DA")
                {
                    ApplicationArea = Basic;
                }
                field("Envoyer Gaosil"; Rec."Envoyer Gaosil")
                {
                    ApplicationArea = Basic;
                }
                field("Envoyer rapport Chantier"; Rec."Envoyer rapport Chantier")
                {
                    ApplicationArea = Basic;
                }
                // field("Envoyer BR"; Rec."Envoyer BR")
                // {
                //     ApplicationArea = Basic;
                // }
            }
        }
    }

    actions
    {
    }
}

