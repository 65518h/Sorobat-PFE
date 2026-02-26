TableExtension 50030 "User SetupEXT" extends "User Setup"
{
    fields
    {


        field(50000; "Inventory Resp. Ctr. Filter"; Code[10])
        {
            Caption = 'Inventory Resp. Ctr. Filter';
            Description = 'HJ DSFT 23-03-2012';
            TableRelation = "Responsibility Center";
        }
        field(50001; Agence; Code[10])
        {
            Description = 'HJ';
            //GL2024
            TableRelation = Agence.Code;
            //GL2024
        }
        field(50002; Niveau; Option)
        {
            Description = 'HJ';
            OptionMembers = "Accée Interdit","Accée Bor Utilisateur","Accée Bor Agence";
        }
        field(50003; "Modif Client"; Boolean)
        {
            Description = 'HJ DSFT 23-03-2012';
        }
        field(50004; "Modif Fournisseur"; Boolean)
        {
            Description = 'HJ DSFT 23-03-2012';
        }
        field(50005; "Modif Article"; Boolean)
        {
            Description = 'HJ DSFT 23-03-2012';
        }
        field(50006; "Role Utilisateur"; Option)
        {
            Description = 'BSK 24/04/2012';
            OptionMembers = Caissier,Financier,Admin;
        }
        field(50007; Service; Option)
        {
            Description = 'HJ DSFT 30-06-2012';
            OptionMembers = " ","Direction Comptable","Direction Achat","Direction Administratif","Direction RH","Direction Parc Auto"," Direction Magasin","Direction Fianciére","Direction General";
        }
        field(50008; "Car Pool Resp. Ctr. Filter"; Code[10])
        {
            Caption = 'Inventory Resp. Ctr. Filter';
            Description = 'HJ DSFT 23-03-2012';
            TableRelation = "Responsibility Center";
        }
        field(50009; "Bureau Ordre"; Boolean)
        {
            Description = 'HJ DSFT 03-07-2012';
        }
        field(50010; "Compte EX"; Boolean)
        {
            Description = 'HJ DSFT 02-10-2012';
        }
        field(50011; Fonction; Text[250])
        {
            Description = 'HJ DSFT 02-10-2012';
        }
        field(50012; "Lancé DA 1"; Code[20])
        {
            Description = 'HJ SORO BF 24-11-2016';
            TableRelation = "User Setup";
        }
        field(50013; "Lancé DA 2"; Code[20])
        {
            Description = 'HJ SORO BF 24-11-2016';
            TableRelation = "User Setup";
        }
        field(50017; "Filtre DA"; Option)
        {
            Description = 'HJ SORO 30-12-2014';
            OptionMembers = "Acces Total",Interdiction,Utilisateur,Magasin;
        }
        field(50035; "Affaire Par Defaut"; Code[20])
        {
            Description = 'HJ SORO 12-06-2015';
            TableRelation = Job;
        }
        field(50157; approver; Boolean)
        {
            Caption = 'Approbateur';
            DataClassification = ToBeClassified;
        }
        field(50030; "Alerte Papier Vehicule"; Boolean)
        {
            Description = 'RB SORO 23/12/2015 PARC MATERIEL';
        }
        field(50031; "Alerte Vidange Vehicule"; Boolean)
        {
            Description = 'RB SORO 23/12/2015 PARC MATERIEL';
        }
        field(50032; "Alerte Min-Max"; Boolean)
        {
            Description = 'RB SORO 23/12/2015 PARC MATERIEL';
        }
        field(50033; "Alerte Generale"; Boolean)
        {
        }
        field(50034; "Approuver Brouillard"; Boolean)
        {
        }
        field(50046; "Modification Element Calc Sal"; Boolean)
        {
            Description = 'HJ 15-11-2017';
        }
        field(50066; "Permission Data Editor"; Boolean)
        {
            Caption = 'Permission Data Editor';
            DataClassification = ToBeClassified;
        }
        field(50156; "Approver ID DA"; Text[100])
        {
            Caption = 'Approver ID DA';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(50160; "PR Reopen permission"; Boolean)
        {
            Caption = 'permission Reouvrir DA';
            DataClassification = ToBeClassified;
        }
        field(50161; "PR Reopen permission Level 2"; Boolean)
        {
            Caption = 'permission Reouvrir DA Niveau 2';
            DataClassification = ToBeClassified;
        }
        field(50163; "Permission Print PR"; Boolean)
        {
            Caption = 'Permission Imprimer DA';
            DataClassification = ToBeClassified;
        }
        field(52007; "Modif Salarie"; Boolean)
        {
            Description = 'BSK 26-06-2012';
        }
        field(52008; "Default Location"; Code[50])
        {
            Caption = 'Magasin par défaut';
            TableRelation = Location;
            DataClassification = ToBeClassified;
        }
        field(52009; "N° matériel Obligatoire"; Boolean)
        {

        }
        field(50067; "Modif Commande achat"; Boolean)
        {
            Description = 'HJ DSFT 23-03-2012';
        }
        field(50068; "Réinitialiser statut à Approuver"; Boolean)
        {

        }
        field(50069; "Autoriser Modification Détail Marché"; Boolean)
        {

        }
        field(50070; "Autoriser Suppression Fichiers"; Boolean)
        {

        }
        field(50071; "Autoriser Filtre Gasoil"; Boolean)
        {
            Description = 'MH SORO 08-05-2021';
        }

        field(50072; "Autoriser Filtre Pointage Véhicule"; Boolean)
        {
            Description = 'MH SORO 08-05-2021';
        }
        field(50073; "Affaire"; Code[20])
        {
            TableRelation = Job;
        }
        field(50074; "Affectation"; Code[20])
        {
            TableRelation = "Employee Statistics Group" WHERE(Type = CONST(Service));
        }

        field(50075; "Cuve"; Code[20])
        {
            TableRelation = Location WHERE("Affaire" = FIELD(Affaire));
        }

        field(50076; "Autoriser modif caisse extra"; Boolean)
        {
            Caption = 'Autoriser la modification de la caisse';
            DataClassification = CustomerContent;
        }

        field(50077; "Autoriser Config Packages"; Boolean)
        {
            Caption = 'Autoriser Config Packages';
            DataClassification = CustomerContent;
        }
        field(50078; "Créer Commande a partir DA"; Boolean)
        {
            Caption = 'Créer Commande a partir DA';
            DataClassification = CustomerContent;
        }
        field(8003900; "Mask Code"; Code[10])
        {
            Caption = 'Code Masque';
            TableRelation = Mask;

            trigger OnValidate()
            begin
                //MASK
                Validate("Mask Filter");
                //MASK//
            end;
        }
        field(8003901; "Mask Filter"; Code[30])
        {
            Caption = 'Filter Masque';
            Description = 'HJ DSFT 03-07-2012';

            trigger OnValidate()
            var
                lUserSetupTemp: Record "User Setup" temporary;
                tIncompatible: label 'Filtre non compatible avec le code';
            begin
                //MASK
                lUserSetupTemp."Mask Code" := "Mask Code";
                lUserSetupTemp.Insert;
                lUserSetupTemp.SetFilter("Mask Code", "Mask Filter");
                if not lUserSetupTemp.Find('-') then
                    Error(tIncompatible);
                //MASK//
            end;
        }
    }

}

