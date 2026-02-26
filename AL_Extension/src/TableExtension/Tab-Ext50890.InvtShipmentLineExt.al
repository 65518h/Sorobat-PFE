tableextension 50890 "Invt. Shipment Line Ext" extends "Invt. Shipment Line"
{
    fields
    {
        field(60009; Traiter; Boolean)
        {
        }
        field(8001400; "Financial Document"; Boolean)
        {
            Caption = 'Financial Document';
        }
        field(8001401; "Shelf No."; Code[30])
        {
            Caption = 'Shelf No.';
        }
        field(50038; "N° Piéce"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8003900; "Job Quantity"; Decimal)
        {
            Caption = 'Job quantity';
        }
        field(60000; RG; Boolean)
        {
            Description = 'HJ DSFT 26-03-2012';
        }
        field(60001; Avance; Boolean)
        {
            Description = 'HJ DSFT 26-03-2012';
        }
        field(60002; "Derniere Date Changement"; Date)
        {
        }
        field(60003; Production; Boolean)
        {
        }
        field(60004; "Alerte Frequence Changement"; Boolean)
        {
        }
        field(60006; "Date Min Chagnement"; Date)
        {
        }
        /*  field(52005; "Emplacement Mgh 51"; Text[30])
          {
              CalcFormula = lookup(Item."Emplacement MGH 51" where("No." = field("Item No.")));
              Description = 'RB SORO 04/09/2015';
              FieldClass = FlowField;
          }
          field(52006; "Emplacement Mgh 13"; Text[30])
          {
              CalcFormula = lookup(Item."Emplacement Bati Depot z4" where("No." = field("Item No.")));
              Description = 'RB SORO 09/10/2015';
              FieldClass = FlowField;
          }
          field(52007; "Emplacement Beja Lot 3"; Text[30])
          {
              CalcFormula = lookup(Item."Emplacement BEJA LOT3" where("No." = field("Item No.")));
              Description = 'RB SORO 09/11/2015';
              FieldClass = FlowField;
          }
          field(52004; "Ancien Code Article"; Code[20])
          {
              CalcFormula = lookup(Item."Ancien Code" where("No." = field("Item No.")));
              Description = 'RB SORO 01/09/2015';
              Editable = false;
              FieldClass = FlowField;
          }
          field(52003; "Emplacement Mgh 113"; Text[30])
          {
              CalcFormula = lookup(Item."Emplacement MGH 113" where("No." = field("Item No.")));
              Description = 'RB SORO 31/08/2015';
              FieldClass = FlowField;
          }*/
        field(52002; "Période contrat"; Integer)
        {
            Description = 'HJ DSFT 26-03-2012';
            // TableRelation = "Ligne Dossiers d'Importation"."N° ligne" where("N° dossier" = field("N° contrat"));
        }
        field(50036; "Transfert Inter Chantier"; Boolean)
        {
            Description = 'HJ SORO 07-08-2018';
        }
        field(50037; "N° Fiche Gasoil"; Code[20])
        {
            Description = 'MH SORO 10-09-2020';
        }
        field(52001; "N° contrat"; Code[20])
        {
            Description = 'HJ DSFT 26-03-2012';
            //GL2024  TableRelation = Table50086;
        }
        field(50035; "Sous Affectation Marche"; Code[20])
        {
            Description = 'HJ SORO 24-11-2015';
            TableRelation = "Sous Affectation Marche";
        }
        field(50034; "Affectation Marche"; Code[20])
        {
            Description = 'HJ SORO 11-10-2016';
            TableRelation = "Affectation Marche" where(Marche = field("DYSJob No."));
        }
        field(50033; Benificiaire; Text[30])
        {
            Description = 'HJ SORO 16-10-2014';
            TableRelation = Salarier;
        }
        field(50031; "Code Variante"; Code[20])
        {
            Description = 'HJ SORO 13-01-2015';
            TableRelation = "Item Variant".Code;
        }
        field(50026; Imprimer; Boolean)
        {
            Description = 'HJ SORO 17-10-2014';
            Editable = false;
        }
        field(50027; "Num Sequence Synchro"; Integer)
        {
            Description = 'HJ SORO 20-11-2014';
        }
        field(50028; Synchronise; Boolean)
        {
            Description = 'HJ SORO 20-11-2014';
        }
        field(50029; Observation; Text[100])
        {
            Description = 'HJ SORO 05-01-2015';
        }
        field(50030; "Approbé"; Boolean)
        {
            Description = 'HJ SORO 05-01-2015';
        }
        field(50025; "Vehicule Transporteur"; Text[30])
        {
            Description = 'HJ SORO 16-10-2014';
        }
        field(50023; "N° Véhicule"; Code[20])
        {
            Description = 'HJ DSFT 26-03-2012';
        }
        field(50022; "Filtre Materiel"; Code[20])
        {
            Description = 'HJ DSFT 26-03-2012';

            trigger OnValidate()
            begin
                // "Filtre Materiel" := RecVehicule.GetListeFiltré("Filtre Materiel");
                // "N° Materiel" := "Filtre Materiel";
                // "Filtre Materiel" := '';
            end;
        }
        field(50019; "Traité"; Boolean)
        {
            Description = 'HJ SORO 09-08-2014';
        }
        field(50016; Consommation; Boolean)
        {
            Description = 'HJ DSFT 26-03-2012';
        }
        field(50017; "Quantité Demandé"; Decimal)
        {
            Description = 'HJ SORO 09-08-2014';
        }
        field(50018; "Lieu Livraison / Provenance"; Text[100])
        {
            Description = 'HJ SORO 09-08-2014';
            TableRelation = Job2;
        }
        field(50014; "Index Kilometrique"; Decimal)
        {
            Description = 'HJ DSFT 28-04-2012';
        }
        field(50013; "Index Horaire"; Decimal)
        {
            Description = 'HJ DSFT 28-04-2012';
        }
        field(50012; Destination; Code[20])
        {
            Description = 'HJ DSFT 28-04-2012';
            TableRelation = "Post Code";
        }
        field(50011; Chauffeur; Code[20])
        {
            Description = 'HJ DSFT 26-03-2012';
            TableRelation = "Shipping Agent";
        }
        field(50010; "N° Bordereau"; Code[20])
        {
            Description = 'HJ DSFT 23-03-2012';
            Editable = false;
        }
        field(50007; "Nom Utilisateur"; Code[20])
        {
            Description = 'HJ DSFT 26-03-2012';
            TableRelation = User;
        }
        field(50006; "Type Index"; Option)
        {
            Description = 'HJ DSFT 26-03-2012';
            OptionMembers = " ",Horaire,Kilometrage;
        }
        field(50003; "Lieu De Livraison / Provenance"; Code[20])
        {
            Description = 'HJ DSFT 23-03-2012';
            TableRelation = Job2;
        }
        field(50002; Materiel; Code[20])
        {
            Description = 'HJ DSFT 23-03-2012';
            TableRelation = Resource where(Type = const(Machine));
        }
        field(50000; "External Invoice No."; Code[30])
        {
            Caption = 'N° Facture Externe';
            Description = 'HJ DSFT 23-03-2012';
            Editable = false;
        }
        field(50001; Famille; Code[20])
        {
            Description = 'HJ DSFT 23-03-2012';
        }
        field(50008; Utilisateur; Code[20])
        {
            Description = 'HJ DSFT 26-03-2012';
        }
        field(50009; Heure; Time)
        {
            Description = 'HJ DSFT 26-03-2012';
            Editable = false;
        }
        ////From 2009

        //>> ABZ 03/07/24
        field(85000; "DYSJob No."; code[20])
        {
            Caption = 'N° affaire';
            TableRelation = Job;
        }
        field(85001; "DYSJob Task No."; code[20])
        {
            Caption = 'N° tâche projet';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("DYSjob No."));
        }
        field(85002; "DYSJob Planning Line No."; Integer)
        {
            Caption = 'N° Ligne planning projet';
            TableRelation = "Job Planning Line"."Line No." where("Job No." = field("DYSJob No."), "Job Task No." = field("DYSJob Task No."));
        }
        //>> ABZ 03/07/24

    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}