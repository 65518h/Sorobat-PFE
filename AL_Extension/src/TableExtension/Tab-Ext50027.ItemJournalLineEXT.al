TableExtension 50027 "Item Journal LineEXT" extends "Item Journal Line"
{
    fields
    {

        /*GL2024 modify("Source No.")
             {
                Editable=true;

             }
             modify("Phys. Inventory")
             {
                Editable=true;

             } 
             */

        modify("Item No.")
        {
            TableRelation = Item where("Location Filter" = field("Location Code"));
            trigger OnBeforeValidate()
            begin
                // >> HJ DSFT 28-04-2012
                Utilisateur := USERID;
                //  Heure := TIME;
                // >> HJ DSFT 28-04-2012

            end;

            trigger OnAfterValidate()
            begin
                //  if Item."No." <> "Item No." then
                if Item.Get("Item No.") then begin
                    // >> HJ DSFT 16 AVRIL 2013
                    IF Item."Last Direct Cost" <> 0 THEN
                        "Unit Cost" := Item."Last Direct Cost"
                end;
                //IF "Unit Cost"=0 THEN IF Item."Last Direct Cost"<>0 THEN "Unit Cost":=Item."Last Direct Cost"
                // ELSE
                //"Unit Cost" := Item."Unit Cost";
                // >> HJ DSFT 16 AVRIL 2013
                // RB SORO 23/04/2015
                //  IF RecItem.GET("Item No.") THEN;
                //  Famille := RecItem."Tree Code";
                // RB SORO 23/04/2015 
            end;
        }


        modify("Location Code")
        {
            trigger OnBeforeValidate()
            begin
                // RB SORO 09/06/2015

                //"CUPurch.-Post".AutorisationMagasin("Location Code");

                // RB SORO 09/06/2015

            end;

            trigger OnAfterValidate()
            begin
                if Item."No." <> "Item No." then
                    Item.Get("Item No.");
                // >> HJ DSFT 16 AVRIL 2013
                // IF "Unit Cost" = 0 THEN
                //     IF Item."Last Direct Cost" <> 0 THEN
                //         "Unit Cost" := Item."Last Direct Cost"
                //     ELSE
                //         "Unit Cost" := Item."Unit Cost";
                // IF Location.GET("Location Code") THEN;
                // IF Location.Affectation <> '' THEN "Job No." := Location.Affectation;
                // // >> HJ DSFT 16 AVRIL 2013
                IF "Unit Cost" = 0 THEN "Unit Cost" := Item."Last Direct Cost";
                // >> HJ DSFT 16 AVRIL 2013

            end;
        }
        modify("Job No.")
        {
            TableRelation = Job;
            trigger OnBeforeValidate()
            var
                lJob: Record Job;
            begin
                //+JOB+
                IF "Job No." <> '' THEN BEGIN
                    lJob.GET("Job No.");
                    VALIDATE("Job Task No.", lJob.gGetDefaultJobTask);
                END;
                //+JOB+//

            end;
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
        field(50002; Materiel; Code[20])
        {
            Description = 'HJ DSFT 23-03-2012';
            TableRelation = Resource where(Type = const(Machine));
        }
        field(50003; "Marche"; Code[20])
        {
            Description = 'HJ DSFT 23-03-2012';
            TableRelation = Job;
        }
        field(50004; "N° Dossier"; Code[20])
        {
            Description = 'HJ DSFT 23-03-2012';
        }
        field(50005; "Currency Code"; Code[20])
        {
            Caption = 'Code devise';
            Description = 'HJ DSFT 23-03-2012';
        }
        field(50006; "Type Index"; Option)
        {
            Description = 'HJ DSFT 26-03-2012';
            OptionMembers = " ",Horaire,Kilometrage;
        }
        field(50007; "Nom Utilisateur"; Code[20])
        {
            Description = 'HJ DSFT 26-03-2012';
            TableRelation = User;
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
        field(50010; "N° Bordereau"; Code[20])
        {
            Description = 'HJ DSFT 23-03-2012';
            Editable = false;
        }
        field(50011; Chauffeur; Code[20])
        {
            Description = 'HJ DSFT 26-03-2012';
            TableRelation = "Shipping Agent";
        }
        field(50012; Destination; Code[20])
        {
            Description = 'HJ DSFT 28-04-2012';
            TableRelation = "Post Code";
        }
        field(50013; "Index Horaire"; Decimal)
        {
            Description = 'HJ DSFT 28-04-2012';
        }
        field(50014; "Index Kilometrique"; Decimal)
        {
            Description = 'HJ DSFT 28-04-2012';
        }
        field(50015; "N° Materiel"; Code[20])
        {
            Description = 'HJ DSFT 29-06-2012';
            TableRelation = Véhicule;

            /* trigger OnValidate()
             var
                 "// RB SOROU 17/04/15": Integer;
                 RecItemJournalTemplate: Record "Item Journal Template";
                 RecItemLedgerEntry: Record "Item Ledger Entry";
                 RecGenProductPostingGroup: Record "Gen. Product Posting Group";
                 RecTree: Record Tree;
                 NotificationRotation: Record "Notification Reception";
                 RecUserSetup: Record "User Setup";
             begin
                 // RB SORO 17/04/2015
                 VerifierFreqChang;
                 if RecItemJournalTemplate.Get("Journal Template Name") then;
                 if RecItemJournalTemplate."Bon Sortie" then begin
                     if RecTree.Get(RecTree.Type::Item, Famille) then;
                     if Format(RecTree."Frequence Rotation") <> '' then begin
                         RecItemLedgerEntry.SetCurrentkey("N° Véhicule", "Item No.", "Posting Date");
                         RecItemLedgerEntry.SetRange("N° Véhicule", "N° Materiel");
                         RecItemLedgerEntry.SetRange("Item No.", "Item No.");
                         if RecItemLedgerEntry.FindLast then begin
                             //MESSAGE('Dernier date comptabilisation est %1',RecItemLedgerEntry."Posting Date");
                             if CalcDate(RecTree."Frequence Rotation", RecItemLedgerEntry."Posting Date") > Today then
                                 // MESSAGE('La prochaine date de changment de l article %1 pour le vehicule %2 est %3',
                                 // "Item No.","N° Materiel",CALCDATE(RecGenProductPostingGroup."Frequence Rotation",RecItemLedgerEntry."Posting Date"));
                                 Message(Text034, "Item No.", "N° Materiel", RecItemLedgerEntry."Posting Date");
                             RecUserSetup.SetRange("Notifier Rotation", true);
                             if RecUserSetup.FindFirst then
                                 repeat
                                     NotificationRotation.Utilisateur := RecUserSetup."User ID";
                                     NotificationRotation."Type Notification" := NotificationRotation."type notification"::Rotation;
                                     //NotificationRotation."BL N °";
                                     NotificationRotation."Document N°" := "Document No.";
                                     NotificationRotation.Article := "Item No.";
                                     NotificationRotation.Description := Description;
                                     // Quantite Changement Demander
                                     NotificationRotation."Quantité Reçue" := Quantity;
                                     // Date Demande
                                     NotificationRotation."Date Reception" := "Posting Date";
                                     // Dernier Date Changement
                                     NotificationRotation."Date DA" := RecItemLedgerEntry."Posting Date";
                                     //NotificationRotation."Date Commande":= "Posting Date";
                                     // Demandeur
                                     NotificationRotation.Demandeur := UserId;
                                     // N° Materiel
                                     NotificationRotation."N° Materiel" := "N° Materiel";
                                     // Période d'utilisation
                                     NotificationRotation."Période d'utilisation" := "Posting Date" - RecItemLedgerEntry."Posting Date";
                                     // Période Restante à Utiliser
                                     NotificationRotation."Période Restante à Utiliser" :=
                                     CalcDate(RecGenProductPostingGroup."Frequence Rotation", RecItemLedgerEntry."Posting Date") - "Posting Date";
                                     // Parametre Frequence de Rotation
                                     NotificationRotation."Parametre Frequence Rotation" := RecTree."Frequence Rotation";

                                     if not NotificationRotation.Insert then NotificationRotation.Modify;
                                 until RecUserSetup.Next = 0;

                         end;
                     end;
                 end;
                 // RB SORO 17/04/2015
             end;*/
        }
        field(50016; Consommation; Boolean)
        {
            Description = 'HJ DSFT 26-03-2012';
        }
        field(50017; "Quantité Demandé"; Decimal)
        {
            Description = 'HJ SORO 09-08-2014';
        }
        field(50018; "Provenance"; Text[100])
        {
            Description = 'HJ SORO 09-08-2014';
            TableRelation = Job;
        }
        field(50019; "Traité"; Boolean)
        {
            Description = 'HJ SORO 09-08-2014';
        }
        field(50020; "N° Réception"; Code[20])
        {
            Description = 'HJ DSFT 28-04-2012';
        }
        field(50021; "N° Ligne Réception"; Integer)
        {
            Description = 'HJ DSFT 28-04-2012';
        }
        field(50022; "Filtre Materiel"; Code[20])
        {
            Description = 'HJ DSFT 26-03-2012';

            trigger OnValidate()
            begin
                "Filtre Materiel" := RecVehicule.GetListeFiltré("Filtre Materiel");
                "N° Materiel" := "Filtre Materiel";
                "Filtre Materiel" := '';
            end;
        }
        field(50023; "N° Véhicule"; Code[20])
        {
            Description = 'HJ DSFT 26-03-2012';
        }
        field(50024; Synchronise; Boolean)
        {
            Description = 'HJ SORO 16-10-2014';
            TableRelation = Salarier;
        }
        field(50025; "Num Sequence Synchro"; Integer)
        {
            Description = 'HJ SORO 16-10-2014';
        }
        /*  field(50026; Imprimer; Boolean)
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
        }*/
        field(50029; Observation; Text[100])
        {
            Description = 'HJ SORO 05-01-2015';
        }
        field(50030; "Approbé"; Boolean)
        {
            Description = 'HJ SORO 05-01-2015';
        }
        field(50031; "Code Variante"; Code[20])
        {
            Description = 'HJ SORO 13-01-2015';
            TableRelation = "Item Variant".Code;
        }
        field(50032; "Filtre Article"; Code[20])
        {
            Description = 'HJ DSFT 29-06-2012';

            trigger OnValidate()
            begin
                // >> HJ DST 02-02-2013
                "Filtre Article" := RecItem.GetItemFilter("Filtre Article");
                Validate("Item No.", "Filtre Article");
                "Filtre Article" := '';
                // >> HJ DST 02-02-2013
            end;
        }
        field(50033; Benificiaire; Text[30])
        {
            Description = 'HJ SORO 16-10-2014';
            TableRelation = Salarier;
        }
        field(50034; "Receptioneur"; Text[30])
        {
            Description = 'HJ SORO 11-10-2016';
            TableRelation = Salarier;
        }
        field(50035; "Vehicule Transporteur"; Text[30])
        {
            Description = 'HJ SORO 24-11-2015';
            TableRelation = "Sous Affectation Marche" WHERE(Marche = FIELD("Job No."));
        }
        field(50036; "Affectation Marche"; code[20])
        {
            Description = 'HJ SORO 07-08-2018';
            TableRelation = "Sous Affectation Marche" WHERE(Marche = FIELD("Job No."));
        }
        field(50037; "Sous Affectation Marche"; Code[20])
        {
            Description = 'MH SORO 10-09-2020';
            TableRelation = "Sous Affectation Marche" WHERE(Marche = FIELD("Job No."));

        }
        //NEW
        field(50038; "N° Piéce"; text[50])
        {

        }
        field(50039; "Index Vehicule"; Integer)
        {

        }
        field(51000; "Description Soroubat"; text[100])
        {

        }
        field(52001; "N° contrat"; Code[20])
        {
            Description = 'HJ DSFT 26-03-2012';
            TableRelation = "Autorisation Types Réglement";
        }
        field(52002; "Période contrat"; Integer)
        {
            Description = 'HJ DSFT 26-03-2012';
            TableRelation = "Ligne Dossiers d'Importation"."N° ligne" where("N° dossier" = field("N° contrat"));
        }
        /* field(52003; "Emplacement Mgh 113"; Text[30])
         {
             CalcFormula = lookup(Item."Emplacement MGH 113" where("No." = field("Item No.")));
             Description = 'RB SORO 31/08/2015';
             FieldClass = FlowField;
         }
         field(52004; "Ancien Code Article"; Code[20])
         {
             CalcFormula = lookup(Item."Ancien Code" where("No." = field("Item No.")));
             Description = 'RB SORO 01/09/2015';
             Editable = false;
             FieldClass = FlowField;
         }
         field(52005; "Emplacement Mgh 51"; Text[30])
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
         }*/
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
        field(60005; "Imprimer"; Boolean)
        {
        }
        field(60006; "Date Min Chagnement"; Date)
        {
        }
        field(60007; Esseyeu; Option)
        {
            OptionMembers = " ",E1,E2,E3,E4,E5,E6,E7,E8,E9,E10;

            trigger OnValidate()
            begin
                if Position <> 0 then VerifierFreqChang;
            end;
        }
        field(60008; Position; Option)
        {
            OptionMembers = " ",D1,D2,G1,G2;

            trigger OnValidate()
            begin
                if Esseyeu <> 0 then VerifierFreqChang;
            end;
        }
        field(60009; Traiter; Boolean)
        {
        }
        field(8001400; "Financial Document"; Boolean)
        {
            Caption = 'Financial Document';
        }
        field(8001401; "Shelf No."; Code[10])
        {
            Caption = 'Shelf No.';
        }
        field(8001490; "Phys. Inv. Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Phys. Inv. Journal Line"."Quantity (Base)" where("Location Code" = field("Location Code"),
                                                                                 "Item No." = field("Item No."),
                                                                                 "Variant Code" = field("Variant Code")));
            Caption = 'Phys. Inv. Quantity';
            DecimalPlaces = 0 : 5;
            Description = '+REF+PHYS_INV';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003900; "Job Quantity"; Decimal)
        {
            Caption = 'Job quantity';
        }
    }



    procedure VerifierFreqChang()
    begin
        "Alerte Frequence Changement" := false;
        if InventoryPostingGroup.Get("Inventory Posting Group") then begin
            if "Entry Type" = "entry type"::"Negative Adjmt." then
                if Format(InventoryPostingGroup."Frequence Changement") <> '' then begin
                    // DateDernierChangement:="ItemJnlPost Line".GetLastChangement("N° Materiel","Item No.",Esseyeu,Position);
                    if DateDernierChangement = 0D then exit;
                    if CalcDate(InventoryPostingGroup."Frequence Changement", DateDernierChangement)
                        >= "Posting Date" then begin
                        "Alerte Frequence Changement" := true;
                        "Derniere Date Changement" := DateDernierChangement;
                        "Date Min Chagnement" := CalcDate(InventoryPostingGroup."Frequence Changement", DateDernierChangement);
                        Message(Text034, DateDernierChangement);
                    end;
                end;
        end;
    end;

    var

        RecUserSetup: Record "User Setup";
        CduNoSeriesRespCentManagement: Codeunit NoSeriesRespCenterManagement;
        RecVehicule: Record "Véhicule";
        RecItem: Record Item;
        Text034: label 'Attention !!! Dernier Date d''echangement de l''article %1 pour la véhicule %2 est %3';
        "// RB SORO 10/06/2015": Integer;
        "CUPurch.-Post": Codeunit PurchPostEvent;
        InventoryPostingGroup: Record "Inventory Posting Group";
        DateDernierChangement: Date;
        Item: Record Item;
        Location: Record Location;


}

