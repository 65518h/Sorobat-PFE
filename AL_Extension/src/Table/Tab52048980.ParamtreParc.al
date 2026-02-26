Table 52048980 "Paramétre Parc"
{
    //GL2024  ID dans Nav 2009 : "39004680"
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Prix 1L Gasoil"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(3; "Prix 1L Essence"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(4; "Durée Vignette"; DateFormula)
        {
        }
        field(5; "Durée Visite Technique"; DateFormula)
        {
        }
        field(6; "Prix 1L Ess. sans plomb"; Decimal)
        {
        }
        field(10; Vehicule; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(11; "N° Assurance"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(12; "N° Mission"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(13; "Durée Garantie"; DateFormula)
        {
        }
        field(14; "N° Accident"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(15; "N° Réparation"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(16; "N° Visite"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(17; "Réparation sur Accident"; Boolean)
        {
        }
        field(18; "Durée Taxe"; DateFormula)
        {
        }
        field(19; "Article Gasoil"; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(20; "Responsable Parc"; Code[20])
        {
            TableRelation = Employee."No.";
        }
        field(21; "Nom Responsable"; Text[60])
        {
        }
        field(22; "Coût Heure Réparation"; Decimal)
        {
        }
        field(23; "Param Répar Vidange"; Code[10])
        {
            TableRelation = Pannes."Code reparation";
        }
        field(24; "Seuil Alerte Vidange"; Decimal)
        {
        }
        field(25; "Frais Annexes Facturation"; Code[10])
        {
            TableRelation = "Item Charge"."No.";
        }
        field(26; "N° Bon de chargement"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(27; "Coût heure marchandise"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(28; "Coût kilometrage"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(29; "Coût heure livraison"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(30; "Alerte Seuil Assurance"; DateFormula)
        {
        }
        field(31; "Journal Template"; Code[20])
        {
            TableRelation = "Item Journal Template".Name;
        }
        field(32; "Journal Batch"; Code[20])
        {
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Journal Template"));
        }
        field(33; "Code Magasin"; Code[20])
        {
            TableRelation = "Item Journal Batch".Name;
        }
        field(34; "Coût Gasoil"; Decimal)
        {
            Description = 'HJ DSFT';
        }
        /* field(35; "Rendement Serie N°"; Code[20])
         {
             TableRelation = "No. Series";
         }*/
        field(36; "Pointage Serine N°"; Code[20])
        {
            TableRelation = "No. Series";
        }
        /* field(37; "Code BT Curative"; Code[20])
         {
             Description = 'RB SORO GMAO PARC';
             TableRelation = "No. Series";
         }
         field(38; "Code BT Preventive"; Code[20])
         {
             Description = 'RB SORO GMAO PARC';
             TableRelation = "No. Series";
         }
         field(40; "Code Gamme"; Code[20])
         {
             Description = 'RB SORO GMAO PARC';
             TableRelation = "No. Series";
         }
         field(41; "Code Transfert Materiel"; Code[20])
         {
             Description = 'RB SORO GMAO PARC';
             TableRelation = "No. Series";
         }
         field(42; "Derniere Date MAJ BTP"; Date)
         {
             Description = 'RB SORO GMAO PARC';
             Editable = false;
         }

         field(44; "Code Releve Mesure"; Code[20])
         {
             Description = 'RB SORO GMAO PARC';
             TableRelation = "No. Series";
         }
         field(45; "Code Transfert Engin"; Code[20])
         {
             Description = 'RB SORO 12/05/2017';
             TableRelation = "No. Series";
         }*/
        field(50000; "Heure Travail"; Integer)
        {

        }
        field(50001; "Filtre Chantier"; Code[20])
        {
            TableRelation = Job;
        }
        field(50002; "Nombre année Calcul AMJ"; Integer)
        {
        }
        field(50003; "N° Rapport Chantier"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50004; "Envoyer Rendement"; Boolean)
        {
        }
        field(50005; "Envoyer Production"; Boolean)
        {
        }
        field(50006; "Envoyer Attachement"; Boolean)
        {
        }
        field(50007; "Envoyer Pointage"; Boolean)
        {
        }
        field(50008; "Envoyer Caisse"; Boolean)
        {
        }
        field(50009; "Envoyer Magasin"; Boolean)
        {
        }
        field(50010; "Envoyer Parc"; Boolean)
        {
        }
        field(50011; "Envoyer DA"; Boolean)
        {
        }
        field(50012; "Envoyer Gaosil"; Boolean)
        {
        }
        field(50013; "Envoyer rapport Chantier"; Boolean)
        {
        }
        field(50014; "Filtre Chantier2"; Code[20])
        {
            TableRelation = Job;
        }
        /*    field(50015; "% Disponibilité"; Decimal)
            {
            }
            field(50016; "% Panne"; Decimal)
            {
            }
            field(50017; "Methode Calcul Cout Location E"; Option)
            {
                OptionMembers = "Fonct-Dispo-Panne","Fonct-Dispo",Fonct;
            }
            field(50018; "Methode Calcul Cout Location M"; Option)
            {
                OptionMembers = "Fonct-Dispo-Panne","Fonct-Dispo",Fonct;
            }
            field(50019; "% Charge Divers Cout Materiel"; Decimal)
            {
            }
            field(50020; "Transport Serie N°"; Code[20])
            {
                TableRelation = "No. Series";
            }
            field(50021; "Filtre Chantier3"; Code[20])
            {
                TableRelation = Job;
            }
            field(50022; "Envoyer BR"; Boolean)
            {
                Description = 'BR : Bon Reglement';
            }*/
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

