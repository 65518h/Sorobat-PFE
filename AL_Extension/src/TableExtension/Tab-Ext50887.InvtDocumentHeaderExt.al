tableextension 50887 "Invt. Document Header Ext" extends "Invt. Document Header"
{
    fields
    {
        field(50033; Benificiaire; Text[30])
        {
            Description = 'HJ SORO 16-10-2014';
            TableRelation = Salarier;
        }
        field(50029; Observation; Text[100])
        {
            Description = 'HJ SORO 05-01-2015';
        }
        field(50038; "N° Piéce"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50039; "Index Vehicule"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; Receptioneur; Text[30])
        {
            Description = 'HJ SORO 16-10-2014';
            TableRelation = Salarier;
        }
        field(50018; "Lieu Livraison / Provenance"; Text[100])
        {
            Description = 'HJ SORO 09-08-2014';
            TableRelation = Job;
        }
        field(50015; "N° Materiel"; Code[20])
        {
            Description = 'HJ DSFT 29-06-2012';
            TableRelation = "Véhicule";

            /*   trigger OnValidate()
               var
                   "// RB SOROU 17/04/15": Integer;
                   RecItemJournalTemplate: Record "Item Journal Template";
                   RecItemLedgerEntry: Record "Item Ledger Entry";
                   RecGenProductPostingGroup: Record "Gen. Product Posting Group";
                   RecTree: Record 8003929;
                   NotificationRotation: Record 39001468;
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

        field(85000; "DYSJob No."; code[20])
        {
            Caption = 'N° affaire';
            TableRelation = Job;
            trigger OnValidate()
            var
                Job: Record Job;
            begin
                if Rec."DYSJob No." <> xRec."DYSJob No." then begin
                    RecInvtDocumentLine.Reset();
                    //   RecInvtDocumentLine.SetRange("Document Type", RecInvtDocumentLine."Document Type"::Shipment);
                    RecInvtDocumentLine.SetRange("Document No.", Rec."No.");
                    if RecInvtDocumentLine.FindSet() then
                        RecInvtDocumentLine.ModifyAll("DYSJob No.", Rec."DYSJob No.");


                end;

                Validate("Shortcut Dimension 2 Code", "DYSJob No.");

            end;
        }
        field(85001; "DYSJob Task No."; code[20])
        {
            Caption = 'N° tâche projet';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("DYSjob No."));
            trigger OnValidate()
            var

            begin
                if Rec."DYSJob Task No." <> xRec."DYSJob Task No." then begin
                    RecInvtDocumentLine.Reset();
                    //  RecInvtDocumentLine.SetRange("Document Type", RecInvtDocumentLine."Document Type"::Shipment);
                    RecInvtDocumentLine.SetRange("Document No.", Rec."No.");
                    if RecInvtDocumentLine.FindSet() then
                        RecInvtDocumentLine.ModifyAll("DYSJob Task No.", Rec."DYSJob Task No.");

                end;
            end;

        }
        field(85002; "DYSJob Planning Line No."; Integer)
        {
            Caption = 'N° Ligne planning projet';
            TableRelation = "Job Planning Line"."Line No." where("Job No." = field("DYSJob No."), "Job Task No." = field("DYSJob Task No."));
            trigger OnValidate()
            var

            begin
                if Rec."DYSJob Planning Line No." <> xRec."DYSJob Planning Line No." then begin
                    RecInvtDocumentLine.Reset();
                    // RecInvtDocumentLine.SetRange("Document Type", RecInvtDocumentLine."Document Type"::Shipment);
                    RecInvtDocumentLine.SetRange("Document No.", Rec."No.");
                    if RecInvtDocumentLine.FindSet() then
                        RecInvtDocumentLine.ModifyAll("DYSJob Planning Line No.", Rec."DYSJob Planning Line No.");

                end;
            end;
        }
        field(50006; "Date Saisie"; Date)
        {
            Editable = false;
        }
        field(50007; "Utilisateur"; Code[20])
        {
            Editable = false;
        }


    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    //HS
    trigger OnInsert()
    var

        RecJLoc: Record "location";
        NoSeries: Codeunit "No. Series";
        NoSeriesBatch: Codeunit "No. Series - Batch";

    begin
        if RecUserSetup.Get(UserId) then;
        if rec."Document Type" = rec."Document Type"::Shipment then begin
            if "No." = '' then begin
                RecJLoc.Get(RecUserSetup."Default Location");
                RecJLoc.TestField("Bon de sortie Nos.");
                if NoSeries.AreRelated(RecJLoc."Bon de sortie Nos.", xRec."No. Series") then
                    "No. Series" := xRec."No. Series"

                else
                    "No. Series" := RecJLoc."Bon de sortie Nos.";
                "No." := NoSeries.GetNextNo("No. Series", WorkDate());
                Rec."Posting No. Series" := RecJLoc."Bon de sortie Nos.";
            end;
        end;
        if rec."Document Type" = rec."Document Type"::Receipt then begin
            if "No." = '' then begin
                RecJLoc.Get(RecUserSetup."Default Location");
                RecJLoc.TestField("Bon d entree Nos.");
                if NoSeries.AreRelated(RecJLoc."Bon d entree Nos.", xRec."No. Series") then
                    "No. Series" := xRec."No. Series"

                else
                    "No. Series" := RecJLoc."Bon d entree Nos.";
                "No." := NoSeries.GetNextNo("No. Series", WorkDate());
                Rec."Posting No. Series" := RecJLoc."Bon d entree Nos.";
            end;
        end;

        Rec."Location Code" := RecUserSetup."Default Location";
        if Recjob.Get(RecUserSetup."Default Location") then
            Rec."DYSJob No." := Recjob."No.";

        Rec.Validate("Gen. Bus. Posting Group", 'LOCAL');
        "Date Saisie" := Today;
        "Utilisateur" := UserId;

    end;
    //HS
    var
        myInt: Integer;
        RecInvtDocumentLine: Record "Invt. Document Line";
        RecUserSetup: Record "User setup";
        Recjob: Record Job;
}