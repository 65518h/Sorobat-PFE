codeunit 50032 "Item Jnl.-Post Line_CDU22"
{
    //GL2024 Procédure spécifique de la codeunit standard "Item Jnl.-Post Line" 22


    PROCEDURE wAdjJobLedgEntry(VAR pValueEntry: Record "Value Entry");
    VAR
        lJobJnlLineTmp: Record "Job Journal Line" TEMPORARY;
        lItemJnlLineDim: Record "Dim. Value per Account" TEMPORARY;
        lJobJnlLineDim: Record "Dim. Value per Account" TEMPORARY;
        lJobJnlPostLine: Codeunit "Job Jnl.-Post Line2";
        lBalJob: Codeunit "Create Bal. Job Journal Line";
    BEGIN
        //JOB_POSTING
        WITH pValueEntry DO BEGIN
            IF NOT Adjustment OR ("Source Type" <> 0) OR ("Source No." = '') THEN
                EXIT;
            //lJobJnlLine.INIT;
            lJobJnlLineTmp."Line No." := 10000;
            lJobJnlLineTmp."Posting Date" := "Posting Date";
            lJobJnlLineTmp."Document Date" := "Document Date";
            lJobJnlLineTmp."Reason Code" := "Reason Code";
            lJobJnlLineTmp."Job No." := "Source No.";
            lJobJnlLineTmp."No." := "Item No.";
            lJobJnlLineTmp."Variant Code" := "Variant Code";
            lJobJnlLineTmp.Description := Description;
            //lJobJnlLineTmp."Unit of Measure Code" := "Unit of Measure Code";
            lJobJnlLineTmp."Location Code" := "Location Code";
            lJobJnlLineTmp."Posting Group" := "Inventory Posting Group";
            lJobJnlLineTmp."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
            lJobJnlLineTmp."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
            //lJobJnlLineTmp."Phase Code" := "Phase Code";
            lJobJnlLineTmp."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
            lJobJnlLineTmp."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";

            lJobJnlLineTmp."Entry Type" := lJobJnlLineTmp."Entry Type"::Usage;
            lJobJnlLineTmp."Document No." := "Document No.";
            lJobJnlLineTmp."External Document No." := "External Document No.";
            lJobJnlLineTmp.Type := lJobJnlLineTmp.Type::Item;
            lJobJnlLineTmp.Quantity := 0;
            lJobJnlLineTmp."Quantity (Base)" := 0;
            lJobJnlLineTmp."Unit Cost" := -"Cost per Unit";
            lJobJnlLineTmp."Total Cost" := -"Cost Amount (Actual)";
            lJobJnlLineTmp."Source Code" := "Source Code";
            //lJobJnlLineTmp."Post Job Entry Only" := TRUE;

            //#5528
            IF lJobJnlLineTmp."Bal. Job No." = '' THEN BEGIN
                lJobJnlLineTmp."Bal. Job No." := lBalJob.SearchBalJobNoFromType(lJobJnlLineTmp);
                lJobJnlLineTmp."Bal. Created Entry" := (lJobJnlLineTmp."Bal. Job No." <> '');
            END;
            //#5528//
            lJobJnlLineTmp.INSERT;
            IF lJobJnlLineTmp."Bal. Job No." <> '' THEN BEGIN
                lJobJnlLineTmp."Job No." := lJobJnlLineTmp."Bal. Job No.";
                lJobJnlLineTmp."Unit Cost" := -lJobJnlLineTmp."Unit Cost";
                lJobJnlLineTmp."Total Cost" := -lJobJnlLineTmp."Total Cost";
                lJobJnlLineTmp."Line No." += 10000;
                lJobJnlLineTmp.INSERT;
            END;
            //DYS table Jnl line dim supprimer

            lJobJnlLineTmp.FINDSET;
            REPEAT
                lJobJnlLineDim.DELETEALL;
            /*   IF lItemJnlLineDim.FIND('-') THEN
                   REPEAT
                       lJobJnlLineDim.INIT;
                       lJobJnlLineDim."Table ID" := DATABASE::"Job Journal Line";
                       lJobJnlLineDim."Journal Template Name" := lJobJnlLineTmp."Journal Template Name";
                       lJobJnlLineDim."Journal Batch Name" := lJobJnlLineTmp."Journal Batch Name";
                       lJobJnlLineDim."Journal Line No." := lJobJnlLineTmp."Line No.";
                       lJobJnlLineDim."Allocation Line No." := 0;
                       lJobJnlLineDim."Dimension Code" := lItemJnlLineDim."Dimension Code";
                       lJobJnlLineDim."Dimension Value Code" := lItemJnlLineDim."Dimension Value Code";
                       lJobJnlLineDim.INSERT;
                   UNTIL lItemJnlLineDim.NEXT = 0;
*/
            //GL2024   lJobJnlPostLine.RunWithCheck(lJobJnlLineTmp, lJobJnlLineDim);
            UNTIL lJobJnlLineTmp.NEXT = 0;
        END;
        //JOB_POSTING//
    END;

    PROCEDURE UpdateItemLedgerEntry();
    VAR
        LItemLedgerEntry: Record 32;
        L_Location: Record 14;
        LPurchInvLine: Record 123;
    BEGIN
        LItemLedgerEntry.SETRANGE("Job No.", '');
        IF LItemLedgerEntry.FINDFIRST THEN
            REPEAT
                IF L_Location.GET(LItemLedgerEntry."Location Code") THEN
                    LItemLedgerEntry."Job No." := L_Location.Affaire;
                LItemLedgerEntry."N° Affaire" := L_Location.Affaire;
                LItemLedgerEntry.MODIFY;
            UNTIL LItemLedgerEntry.NEXT = 0;
        LPurchInvLine.SETRANGE("Job No.", '');
        IF LPurchInvLine.FINDFIRST THEN
            REPEAT
                IF L_Location.GET(LItemLedgerEntry."Location Code") THEN
                    LPurchInvLine."Job No." := L_Location.Affaire;
                LPurchInvLine.MODIFY;
            UNTIL LPurchInvLine.NEXT = 0;
    END;



    /* PROCEDURE UpdateEmplacement(ParamArticle: Code[20]; ParamMagasin: Code[10]; ParamNewEmplacement: Text[30]);
     VAR
         RecItemLedgerEntryEmpl: Record "Item Ledger Entry";
     BEGIN
         RecItemLedgerEntryEmpl.SETRANGE("Item No.", ParamArticle);
         RecItemLedgerEntryEmpl.SETRANGE("Location Code", ParamMagasin);
         RecItemLedgerEntryEmpl.MODIFYALL(Emplacement, ParamNewEmplacement);
     END;*/

    /*  PROCEDURE AlerteMinMax(ParaArticle: Code[20]; ParaNumDoc: Code[20]);
      VAR
          LItem: Record Item;
          LUserSetup: Record "User Setup";
          LNotification: Record "Notification Reception";
      BEGIN
          // >> HJ SORO 10-06-2015 - Notification Min - Max
          LItem.RESET;
          IF LUserSetup.GET(UPPERCASE(USERID)) THEN;
          IF LUserSetup."Filtre Magasin Min Max" <> '' THEN LItem.SETFILTER(LItem."Location Filter", LUserSetup."Filtre Magasin Min Max");
          LItem.SETRANGE("No.", ParaArticle);
          IF LItem.FINDFIRST THEN BEGIN
              LItem.CALCFIELDS(Inventory);
              IF (LItem."Seuil Min" <> 0) AND (LItem."Seuil Max" <> 0) THEN BEGIN
                  IF (LItem.Inventory <= LItem."Seuil Min") OR (LItem.Inventory >= LItem."Seuil Max") THEN BEGIN
                      LNotification.Utilisateur := USERID;
                      LNotification."BL N °" := ParaNumDoc;
                      LNotification.Article := ParaArticle;
                      LNotification.Description := 'SEUIL MIN - MAX ATTEINT POUR ARTICLE :' + LItem.Description;
                      LNotification."Type Notification" := LNotification."Type Notification"::"Min Max";
                      LNotification."Quantité Alerte Min Max" := LItem.Inventory;
                      LNotification.Min := LItem."Seuil Min";
                      LNotification.Max := LItem."Seuil Max";
                      IF LNotification.INSERT THEN;
                  END;
              END;
          END;
          // >> HJ SORO 10-06-2015 - Notification Min - Max
      END;*/

    PROCEDURE GetLastChangement(ParaMateriel: Code[20]; ParaItem: Code[20]; ParaEsseyeu: Integer; ParaPosition: Integer) LastDate: Date;
    VAR
        LItemLedgerEntry: Record "Item Ledger Entry";
    BEGIN
        LItemLedgerEntry.SETCURRENTKEY("N° Véhicule", "Item No.", "Posting Date", Esseyeu, Position);
        LItemLedgerEntry.SETRANGE("Item No.", ParaItem);
        LItemLedgerEntry.SETRANGE(Materiel, ParaMateriel);
        LItemLedgerEntry.SETRANGE(Esseyeu, ParaEsseyeu);
        LItemLedgerEntry.SETRANGE(Position, ParaPosition);
        IF LItemLedgerEntry.FINDLAST THEN EXIT(LItemLedgerEntry."Posting Date");
    END;

    /*   PROCEDURE MajEcritureArticleProd();
       VAR
           LItemLedgerEntry: Record "Item Ledger Entry";
       BEGIN
           LItemLedgerEntry.SETRANGE(Production, TRUE);
           LItemLedgerEntry.SETRANGE("Entry Type", LItemLedgerEntry."Entry Type"::"Positive Adjmt.");
           LItemLedgerEntry.MODIFYALL("Entry Type", LItemLedgerEntry."Entry Type"::Output);
       END;

       PROCEDURE MajEcritureArticleConsom();
       VAR
           LItemLedgerEntry: Record "Item Ledger Entry";
       BEGIN
           LItemLedgerEntry.SETRANGE(Consommation, TRUE);
           LItemLedgerEntry.SETRANGE("Entry Type", LItemLedgerEntry."Entry Type"::"Negative Adjmt.");
           LItemLedgerEntry.MODIFYALL("Entry Type", LItemLedgerEntry."Entry Type"::Consumption);
       END;*/

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertCapValueEntry', '', true, true)]
    local procedure OnBeforeInsertCapValueEntry(var ValueEntry: Record "Value Entry"; ItemJnlLine: Record "Item Journal Line")
    begin
        //Dossier d'importation
        ValueEntry."N° Dossier" := ItemJnlLine."N° Dossier";
        ValueEntry."N° Réception" := ItemJnlLine."N° Réception";
        ValueEntry."N° Ligne Réception" := ItemJnlLine."N° Ligne Réception";

        //Dossier d'importation
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeUpdateUnitCost', '', true, true)]
    local procedure OnBeforeUpdateUnitCost(var ValueEntry: Record "Value Entry"; var IsHandled: Boolean; ItemJournalLine: Record "Item Journal Line")
    var
        ItemCostMgt: Codeunit ItemCostManagement;
        GLSetup: Record "General Ledger Setup";
        LastDirectCost: Decimal;
        TotalAmount: Decimal;
        UpdateSKU: Boolean;
        Item: Record Item;


    begin
        GLSetup.Get();
        item.get(ItemJournalLine."Item No.");

        //STOCK
        if (Item."Item Type" = Item."Item Type"::Generic)
       //STOCK//
       then
            IsHandled := true;
    end;

    procedure TransfertSTDJobToDysJob()
    var
        RecPurchaseLine: Record "Purchase Line";
        RecPurchaseHeader: Record "Purchase Header";
        ReleasePurchDoc: Codeunit "Release Purchase Document";
        Shouldreleased: Boolean;
        ugyg: Record "Item Unit of Measure";
    begin
        RecPurchaseHeader.Reset();
        RecPurchaseHeader.SetRange("Document Type", RecPurchaseHeader."Document Type"::Order);
        if RecPurchaseHeader.FindSet() then begin
            repeat
                Shouldreleased := false;
                if RecPurchaseHeader.Status = RecPurchaseHeader.Status::Released then begin
                    RecPurchaseHeader.Status := RecPurchaseHeader.Status::Open;
                    RecPurchaseHeader.Modify();
                    Shouldreleased := true;
                end;
                RecPurchaseLine.Reset();
                RecPurchaseLine.SetRange("Document Type", RecPurchaseHeader."Document Type");
                RecPurchaseLine.SetRange("Document No.", RecPurchaseHeader."No.");
                RecPurchaseLine.SetFilter("Outstanding Quantity", '<>%1', 0);
                if RecPurchaseLine.FindSet() then begin
                    repeat
                        if RecPurchaseLine."Job No." <> '' then begin
                            RecPurchaseLine."dysJob No." := RecPurchaseLine."Job No.";
                            RecPurchaseLine."dysJob Task No." := RecPurchaseLine."Job Task No.";
                            RecPurchaseLine."DYSJob Planning Line No." := RecPurchaseLine."Job Planning Line No.";
                            RecPurchaseLine."Job No." := '';
                            RecPurchaseLine."Job Task No." := '';
                            RecPurchaseLine."Job Planning Line No." := 0;
                            RecPurchaseLine.Modify();
                        end;
                    until RecPurchaseLine.Next() = 0;
                end;
                if Shouldreleased then begin
                    RecPurchaseHeader.Status := RecPurchaseHeader.Status::Released;
                    RecPurchaseHeader.Modify();
                end;
            until RecPurchaseHeader.Next() = 0;
            Message('Transfert des chantiers standard vers les chantiers DYS terminé.');
        end;

    end;
    //GL2024 Erreur dans expédition ordre de transfert
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterApplyItemLedgEntrySetFilters', '', true, true)]
    // local procedure OnAfterApplyItemLedgEntrySetFilters(var ItemLedgerEntry2: Record "Item Ledger Entry"; ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    // begin
    //     //#8877
    //     ItemLedgerEntry2.SETRANGE("Job Purchase", ItemLedgerEntry."Job Purchase");
    //     //#8877//



    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', true, true)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    VAR
        Item: Record Item;
        Location: Record Location;
        RecLocation: Record 14;

    begin
        // >> HJ SORO 20-07-2017
        // IF Item.GET(ItemJournalLine."Item No.") THEN
        // ItemJournalLine.Description := Item.Description;
        // >> HJ SORO 20-07-2017


        //Dossier d'importation
        NewItemLedgEntry."N° dossier" := ItemJournalLine."N° Dossier";
        //Dossier d'importation
        IF RecLocation.GET(ItemJournalLine."Location Code") THEN;
        IF RecLocation.Affaire <> '' THEN BEGIN
            NewItemLedgEntry."Job No." := RecLocation.Affaire;
            NewItemLedgEntry."N° Affaire" := RecLocation.Affaire;
        END
        ELSE BEGIN
            IF ItemJournalLine.Marche <> '' THEN
                NewItemLedgEntry."N° Affaire" := ItemJournalLine.Marche
            ELSE
                NewItemLedgEntry."N° Affaire" := ItemJournalLine."Job No.";
        END;
        NewItemLedgEntry."Type Index" := ItemJournalLine."Type Index";
        NewItemLedgEntry.Production := ItemJournalLine.Production;
        // HJ SORO 19-09-2017
        // NewItemLedgEntry.Chantier := ItemJournalLine."Job No.";
        //  NewItemLedgEntry."Type Index" := ItemJournalLine."Type Index";
        NewItemLedgEntry."Nom Utilisateur" := ItemJournalLine."Nom Utilisateur";
        NewItemLedgEntry.Heure := ItemJournalLine.Heure;
        //MH SORO 10-09-2020
        //  NewItemLedgEntry."N° Fiche Gasoil" := ItemJournalLine."N° Fiche Gasoil";
        //MH SORO 10-09-2020
        NewItemLedgEntry.Chauffeur := ItemJournalLine.Chauffeur;
        NewItemLedgEntry.Destination := ItemJournalLine.Destination;
        NewItemLedgEntry.Materiel := ItemJournalLine."N° Materiel";

        //
        NewItemLedgEntry."Alerte Frequence Changement" := ItemJournalLine."Alerte Frequence Changement";
        NewItemLedgEntry."Derniere Date Changement" := ItemJournalLine."Derniere Date Changement";
        NewItemLedgEntry."Date Min Changement" := ItemJournalLine."Date Min Chagnement";
        NewItemLedgEntry."Alerte Frequence Changement" := ItemJournalLine."Alerte Frequence Changement";
        NewItemLedgEntry.Esseyeu := ItemJournalLine.Esseyeu;
        NewItemLedgEntry.Position := ItemJournalLine.Position;
        //
        NewItemLedgEntry."Index Horaire" := ItemJournalLine."Index Horaire";
        NewItemLedgEntry."Index Kilometrique" := ItemJournalLine."Index Kilometrique";
        NewItemLedgEntry."N° Véhicule" := ItemJournalLine."N° Materiel";
        NewItemLedgEntry.Consommation := ItemJournalLine.Consommation;
        NewItemLedgEntry."Affectation Marche" := ItemJournalLine."Affectation Marche";


        // RB SORO 23/04/2015
        NewItemLedgEntry.Famille := Item."Tree Code";
        // >> HJ SORO 14-03-2016
        NewItemLedgEntry."Famille" := Item."Item Category Code";
        // >> HJ SORO 14-03-2016

        NewItemLedgEntry."Code Nature" := ItemJournalLine."Gen. Prod. Posting Group";

        NewItemLedgEntry."Groupe Stock" := ItemJournalLine."Inventory Posting Group";
        NewItemLedgEntry."Num Sequence Synchro" := ItemJournalLine."Num Sequence Synchro";


        NewItemLedgEntry.Receptioneur := ItemJournalLine.Receptioneur;
        NewItemLedgEntry.Benificiaire := ItemJournalLine.Benificiaire;
        NewItemLedgEntry.Provenance := ItemJournalLine.Provenance;
        NewItemLedgEntry."Vehicule Transporteur" := ItemJournalLine."Vehicule Transporteur";
        NewItemLedgEntry."Code Nature" := ItemJournalLine."Gen. Prod. Posting Group";
        NewItemLedgEntry."Affectation Marche" := ItemJournalLine."Affectation Marche";
        NewItemLedgEntry."Sous Affectation Marche" := ItemJournalLine."Sous Affectation Marche";
        // RB SORO 23/04/2015



        //***
        // HJ DSFT 15-10-2012


    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntryProcedure', '', true, true)]
    local procedure OnBeforeInsertItemLedgEntryProcedure(var ItemLedgerEntry: Record "Item Ledger Entry"; var IsHandled: Boolean; var ItemJournalLine: Record "Item Journal Line")
    begin
        //+REF+FIN_CREDIT
        IF ItemJournalLine."Financial Document" THEN
            IsHandled := true;
        //+REF+FIN_CREDIT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnInsertItemLedgEntryOnCheckItemTracking', '', true, true)]
    local procedure OnInsertItemLedgEntryOnCheckItemTracking(ItemJnlLine: Record "Item Journal Line"; ItemLedgEntry: Record "Item Ledger Entry"; ItemTrackingCode: Record "Item Tracking Code"; var IsHandled: Boolean)
    var
        GlobalItemTrackingCode: Record "Item Tracking Code";
    begin
        // if not ((ItemJnlLine."Document Type" in [ItemJnlLine."Document Type"::"Purchase Return Shipment", ItemJnlLine."Document Type"::"Purchase Receipt"]) and
        //                (ItemJnlLine."Job No." <> ''))
        //        then
        //     if (ItemLedgEntry.Quantity < 0) and ItemTrackingCode.IsSpecific() then
        //         Error(Text018, ItemJnlLine."Serial No.", ItemJnlLine."Lot No.", ItemJnlLine."Item No.", ItemJnlLine."Variant Code");

        if not ((ItemJnlLine."Document Type" in [ItemJnlLine."Document Type"::"Purchase Return Shipment", ItemJnlLine."Document Type"::"Purchase Receipt"]) and
                        (ItemJnlLine."Job No." <> ''))
                then
            if (ItemLedgEntry.Quantity < 0) and GlobalItemTrackingCode.IsSpecific() then
                IF COPYSTR(ItemJnlLine.Description, 1, 14) <> 'Consommation :' THEN;
        // HJ SORO 05-11-206 ERROR(Text005,ItemLedgEntry."Item No.");

        IsHandled := true;
    end;


    /*GL2024  [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnInsertItemLedgEntryOnBeforeVerifyOnInventory', '', true, true)]
      local procedure OnInsertItemLedgEntryOnBeforeVerifyOnInventory(ItemJnlLine: Record "Item Journal Line"; ItemLedgEntry: Record "Item Ledger Entry"; var IsHandled: Boolean)

      begin
          IsHandled := true;

      end;*/

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', true, true)]
    local procedure OnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean; OldItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLineOrigin: Record "Item Journal Line")
    begin
        //STOCK
        //#8877
        /* {DELETE
         IF ItemJnlLine."Job Quantity" <> 0 THEN BEGIN
               ItemLedgEntry."Job Quantity" := ItemLedgEntry.Quantity;
               ItemLedgEntry.Quantity := 0;
               ItemLedgEntry."Remaining Quantity" := 0;
               ItemLedgEntry."Invoiced Quantity" := 0;
               ItemLedgEntry.Open := FALSE;
           END;
           DELETE}*/
        //#8877//
        //STOCK//
        // Dossier d'importation
        ItemLedgerEntry."N° dossier" := ItemJournalLine."N° Dossier";
        // Dossier d'importation

    end;

    /* [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInsertItemLedgEntry', '', true, true)]
     local procedure OnAfterInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer; var ValueEntryNo: Integer; var ItemApplnEntryNo: Integer; GlobalValueEntry: Record "Value Entry"; TransferItem: Boolean; var InventoryPostingToGL: Codeunit "Inventory Posting To G/L"; var OldItemLedgerEntry: Record "Item Ledger Entry")
     var
         ItemJnlPostLine_CDU22: Codeunit "Item Jnl.-Post Line_CDU22";
     begin
         // >> HJ SORO 10-06-2015 - MIN MAX
         ItemJnlPostLine_CDU22.AlerteMinMax(ItemLedgerEntry."Item No.", ItemLedgerEntry."Document No.");
         // >> HJ SORO 10-06-2015 - MIN MAX

     end;*/

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnInitValueEntryOnAfterAssignFields', '', true, true)]
    local procedure OnInitValueEntryOnAfterAssignFields(var ValueEntry: Record "Value Entry"; ItemLedgEntry: Record "Item Ledger Entry"; ItemJnlLine: Record "Item Journal Line")
    begin
        //Dossier d'importation
        ValueEntry."N° Dossier" := ItemJnlLine."N° Dossier";
        ValueEntry."N° Réception" := ItemJnlLine."N° Réception";
        ValueEntry."N° Ligne Réception" := ItemJnlLine."N° Ligne Réception";
        //Dossier d'importation
        // HJ DSFT 23-03-2012
        ValueEntry."Centre de Gestion" := ItemJnlLine."Work Center No.";
        ValueEntry.Famille := ItemJnlLine.Famille;

        // HJ DSFT 23-03-2012

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnInitValueEntryOnBeforeRoundAmtValueEntry', '', true, true)]
    local procedure OnInitValueEntryOnBeforeRoundAmtValueEntry(var ValueEntry: Record "Value Entry"; ItemJnlLine: Record "Item Journal Line")
    begin
        //+REF+FIN_CREDIT
        ValueEntry."Financial Document" := ItemJnlLine."Financial Document";
        IF ValueEntry."Financial Document" THEN BEGIN
            ValueEntry."Item Ledger Entry No." := 0;
            ValueEntry."Expected Cost" := FALSE;
            ValueEntry.Inventoriable := TRUE;
            ValueEntry."Valued Quantity" := 0;
            ValueEntry."Invoiced Quantity" := 0;
            ValueEntry."Cost Amount (Actual)" := 0;
            ValueEntry."Cost Amount (Actual) (ACY)" := 0;
            ValueEntry."Cost Amount (Expected)" := 0;
            ValueEntry."Cost Amount (Expected) (ACY)" := 0;
            //ValueEntry."Cost Amount (Non-Invt.)" := 0;
            //ValueEntry."Cost Amount (Non-Invt.) (ACY)" := 0;
        END;
        //+REF+FIN_CREDIT//
        //#8877
        /* {DELETE
           //STOCK
           IF "Job Quantity" <> 0 THEN BEGIN
               IF ValueEntry."Invoiced Quantity" <> 0 THEN BEGIN
                   ValueEntry."Job Quantity" := ValueEntry."Invoiced Quantity";
                   ValueEntry."Job Cost" := ValueEntry."Cost Amount (Actual)";
               END;
               ValueEntry."Valued Quantity" := 0;
               ValueEntry."Invoiced Quantity" := 0;
               ValueEntry."Discount Amount" := 0;
               ValueEntry."Cost Amount (Actual)" := 0;
               ValueEntry."Cost Amount (Actual) (ACY)" := 0;
               ValueEntry."Cost Amount (Expected)" := 0;
               ValueEntry."Cost Amount (Expected) (ACY)" := 0;
               ValueEntry."Cost Amount (Non-Invtbl.)" := 0;
               ValueEntry."Cost Amount (Non-Invtbl.)(ACY)" := 0;
           END;
           //STOCK//
           DELETE}*/
        //#8877
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertValueEntry', '', true, true)]
    local procedure OnBeforeInsertValueEntry(var ValueEntry: Record "Value Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgerEntry: Record "Item Ledger Entry"; var ValueEntryNo: Integer)
    var
        ItemCharge: Record "Item Charge";

    begin
        //OFE
        IF ItemLedgerEntry."Job No." <> '' THEN BEGIN
            ValueEntry."Job No." := ItemLedgerEntry."Job No.";
            ValueEntry."Job Task No." := ItemLedgerEntry."Job Task No.";
        END;
        //OFE
        // Dossier d'importation
        ValueEntry."N° Dossier" := ItemJournalLine."N° Dossier";
        ValueEntry."N° Réception" := ItemJournalLine."N° Réception";
        ValueEntry."N° Ligne Réception" := ItemJournalLine."N° Ligne Réception";
        ValueEntry."Currency Code" := ItemJournalLine."Currency Code";
        CLEAR(ItemCharge);
        IF ItemCharge.GET(ValueEntry."Item Charge No.") THEN BEGIN
            IF ItemCharge."Affect Frais Annexe" THEN
                ItemCharge.TESTFIELD("Type Frais");
            ValueEntry."Type Frais" := ItemCharge."Type Frais";
        END;
        // Dossier d'importation
        // >> HJ SORO 27-05-2015 PRODUCTION
        IF ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Output THEN BEGIN
            ValueEntry."Cost per Unit" := ItemJournalLine."Unit Amount";
            ValueEntry."Cost Amount (Actual)" := ItemJournalLine.Quantity * ItemJournalLine."Unit Amount";
            ValueEntry."Cost Amount (Expected)" := 0;
        END;
        // >> HJ SORO 27-05-2015 PRODUCTION


    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeCheckItemTrackingIsEmpty', '', true, true)]
    local procedure OnBeforeCheckItemTrackingIsEmpty(ItemJournalLine: Record "Item Journal Line"; var IsHandled: Boolean)
    begin

        ItemJournalLine.TestField("Serial No.", '');

        ItemJournalLine.CheckNewTrackingIsEmpty();
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInsertPhysInventoryEntry', '', true, true)]
    local procedure OnAfterInsertPhysInventoryEntry(var PhysInventoryLedgerEntry: Record "Phys. Inventory Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    var
        gPhysInvJournalMgt: Codeunit "Phys. Inv. JnlManagement";

    begin
        //+REF+PHYS_INV
        IF ItemJournalLine."Phys. Inventory" THEN
            gPhysInvJournalMgt.ItemJnlPostLine(ItemJournalLine);
        //+REF+PHYS_INV//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertCorrItemLedgEntry', '', true, true)]
    local procedure OnBeforeInsertCorrItemLedgEntry(var NewItemLedgerEntry: Record "Item Ledger Entry"; var OldItemLedgerEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line")
    begin
        //#5020
        //#8977 NewItemLedgEntry."Job Quantity" := -OldItemLedgEntry."Job Quantity";
        //#5020//
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeCheckItemTracking', '', true, true)]
    local procedure OnBeforeCheckItemTracking(var ItemJournalLine: Record "Item Journal Line"; ItemTrackingSetup: Record "Item Tracking Setup"; var IsHandled: Boolean; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    var
        SerialNoRequiredErr: Label 'You must assign a serial number for item %1.', Comment = '%1 - Item No.';
        LotNoRequiredErr: Label 'You must assign a lot number for item %1.', Comment = '%1 - Item No.';
        Location: Record Location;
    begin

        if ItemTrackingSetup."Serial No. Required" and (ItemJournalLine."Serial No." = '') then
            Error(GetTextStringWithLineNo(SerialNoRequiredErr, ItemJournalLine."Item No.", ItemJournalLine."Line No."));
        //+REF+LOT
        // if ItemTrackingSetup."Lot No. Required" and (ItemJournalLine."Lot No." = '') then
        IF (Location.GET(ItemJournalLine."Location Code")) THEN;
        //GL2024   IF LotRequired AND (ItemJournalLine."Lot No." = '') AND (NOT Location."Tracking Not Required") THEN
        IF ItemTrackingSetup."Lot No. Required" AND (ItemJournalLine."Lot No." = '') AND (NOT Location."Tracking Not Required") THEN
            //+REF+LOT//
                Error(GetTextStringWithLineNo(LotNoRequiredErr, ItemJournalLine."Item No.", ItemJournalLine."Line No."));


        if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Transfer then
            ItemJournalLine.CheckNewTrackingIfRequired(ItemTrackingSetup);
        IsHandled := true;
    end;

    local procedure GetTextStringWithLineNo(BasicTextString: Text; ItemNo: Code[20]; LineNo: Integer): Text
    var

        LineNoTxt: Label ' Line No. = ''%1''.', Comment = '%1 - Line No.';
    begin
        if LineNo = 0 then
            exit(StrSubstNo(BasicTextString, ItemNo));
        exit(StrSubstNo(BasicTextString, ItemNo) + StrSubstNo(LineNoTxt, LineNo));
    end;

    var
        Text018: Label 'Item Tracking Serial No. %1 Lot No. %2 for Item No. %3 Variant %4 cannot be fully applied.';
}