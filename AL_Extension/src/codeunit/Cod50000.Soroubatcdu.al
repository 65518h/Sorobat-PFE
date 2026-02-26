Codeunit 50000 "Soroubat cdu"
{
    Permissions = TableData "Vendor Ledger Entry" = rimd;


    trigger OnRun()
    begin
    end;

    var
        RecEquipement: Record "Véhicule";
        // RecGamme: Record Gamme;
        // RecDetailleGamme: Record "Ligne Gamme";
        // RecEnteteBT: Record "Entete BT";
        // "RecLigne BT": Record "Ligne BT";
        RecItem: Record Item;
        RecUserSetup: Record "User Setup";
        // NotificationGMAO: Record "Notification Reception";
        NumLigne: Integer;
        RecParametreParc: Record "Paramétre Parc";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text001: label 'Modification de l''equipement n° %1 et la gamme %2';
        Text002: label 'Erreur !!! Vous ne pouvez pas Lancer 2 BT Preventifs pour l''équipement %1';
        Text003: label 'Erreur !!! Vérifier l''Index de l''Equipement N° %1, Le Dérnier Index saisie est %2';
        Text004: label 'Confirmer Cette Action ?';
    //Hs
    [EventSubscriber(ObjectType::codeunit, codeunit::"Job Post-Line", 'OnPostJobOnPurchaseLineOnAfterCalcShouldSkipLine', '', true, true)]
    local procedure OnPostJobOnPurchaseLineOnAfterCalcShouldSkipLine(PurchaseLine: Record "Purchase Line"; var ShouldSkipLine: Boolean)
    var
        RecReceipLine: Record "Purch. Rcpt. Line";
    begin
        if PurchaseLine."Receipt No." <> '' then
            if RecReceipLine.Get(PurchaseLine."Receipt No.", PurchaseLine."Receipt Line No.") then begin
                if (RecReceipLine."Job No." <> '') then begin
                    PurchaseLine."Job Task No." := RecReceipLine."Job Task No.";
                    PurchaseLine.Modify();
                end;
            end;
        //  ShouldSkipLine := true;
    end;


    [EventSubscriber(ObjectType::codeunit, codeunit::"Job Post-Line", 'OnBeforeCheckItemQuantityPurchCredit', '', true, true)]
    local procedure OnBeforeCheckItemQuantityPurchCredit(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::codeunit, codeunit::"Job Jnl.-Check Line", 'OnBeforeCheckItemQuantityJobJnl', '', true, true)]
    local procedure OnBeforeCheckItemQuantityJobJnl(var JobJnlLine: Record "Job Journal Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::codeunit, codeunit::"Purch.-Post", 'OnPostItemJnlLineJobConsumption', '', true, true)]

    local procedure OnPostItemJnlLineJobConsumption(PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; ItemJournalLine: Record "Item Journal Line"; var TempPurchReservEntry: Record "Reservation Entry" temporary; QtyToBeInvoiced: Decimal; QtyToBeReceived: Decimal; var TempTrackingSpecification: Record "Tracking Specification" temporary; PurchItemLedgEntryNo: Integer; var IsHandled: Boolean; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr."; SrcCode: Code[10])
    begin
        // if PurchLine."Job No." <> '' then begin
        //     IsHandled := true;
        // end;
    end;

    //HS

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeInsertTransRcptLine', '', true, true)]
    local procedure OnBeforeInsertTransRcptLine(var TransRcptLine: Record "Transfer Receipt Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; TransferReceiptHeader: Record "Transfer Receipt Header")

    begin
        TransRcptLine."N° vehicule" := TransLine."N° vehicule";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeInsertTransShptLine', '', true, true)]
    local procedure OnBeforeInsertTransShptLine(var TransShptLine: Record "Transfer Shipment Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; TransShptHeader: Record "Transfer Shipment Header")
    begin
        TransShptLine."N° vehicule" := TransLine."N° vehicule";

    end;
    //HS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterTransferOrderPostShipment', '', true, true)]

    local procedure OnAfterTransferOrderPostShipment(var TransferHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean; var TransferShipmentHeader: Record "Transfer Shipment Header"; InvtPickPutaway: Boolean)
    var
        PRCodeunit: Codeunit PRcodeunit;
        l_Note: BigText;
    begin
        l_Note.ADDTEXT(STRSUBSTNO('Envoyer Ordre transfert %1 par %2', TransferHeader."No.", USERID));
        PRcodeunit.Ordre_Trans_Notif(l_Note, true, UserId, TransferHeader.RecordId, TransferShipmentHeader, TransferHeader);
    end;

    //HS
    [EventSubscriber(ObjectType::codeunit, codeunit::"Undo Posting Management", 'OnBeforeCheckMissingItemLedgers', '', true, true)]

    local procedure OnBeforeCheckMissingItemLedgers(var TempItemLedgEntry: Record "Item Ledger Entry" temporary; SourceType: Integer; DocumentNo: Code[20]; LineNo: Integer; BaseQty: Decimal; var IsHandled: Boolean)
    var

        RecPurchRcpLine: Record "Purch. Rcpt. Line";
    begin
        if RecPurchRcpLine.Get(DocumentNo, LineNo) then begin
            if RecPurchRcpLine."Type article" = RecPurchRcpLine."Type article"::Service then
                IsHandled := true;
        end;
    end;

    [EventSubscriber(ObjectType::codeunit, codeunit::"Undo Purchase Receipt Line", 'OnPostItemJnlLineOnAfterCollectItemLedgEntries', '', true, true)]
    local procedure OnPostItemJnlLineOnAfterCollectItemLedgEntries(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchRcptLine: Record "Purch. Rcpt. Line"; SourceCodeSetup: Record "Source Code Setup"; var IsHandled: Boolean)
    begin
        if PurchRcptLine."Type article" = PurchRcptLine."Type article"::Service then
            IsHandled := true;
    end;


    //HS Attachment DA + Véhicule
    [EventSubscriber(ObjectType::Table, database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', true, true)]

    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];

    begin
        if RecRef.Number = Database::"Purchase Request" then begin
            FieldRef := RecRef.Field(50211);
            RecNo := FieldRef.Value();
            DocumentAttachment.Validate("Document Type", DocumentAttachment."Document Type"::Quote);
            DocumentAttachment.Validate("No.", RecNo);
        end;
        if RecRef.Number = Database::Véhicule then begin
            FieldRef := RecRef.Field(1);
            RecNo := FieldRef.Value();
            //      DocumentAttachment.Validate("Document Type", DocumentAttachment."Document Type"::Quote);
            DocumentAttachment.Validate("No.", RecNo);
        end;
    end;
    //HS
    [EventSubscriber(ObjectType::page, page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', true, true)]

    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    var
        Fref: FieldRef;
        Recno, Rectype : Code[20];
    begin
        case RecRef.Number of
            database::"Purchase Request":
                begin
                    Fref := RecRef.Field(50211);
                    RecNo := Fref.Value;
                    DocumentAttachment.SetRange("Document Type", DocumentAttachment."Document Type"::Quote);
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
            database::Véhicule:
                begin
                    Fref := RecRef.Field(1);
                    RecNo := Fref.Value;
                    // DocumentAttachment.SetRange("Document Type", DocumentAttachment."Document Type"::Quote);
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;
    end;
    //HS
    [EventSubscriber(ObjectType::page, page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', true, true)]

    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        RecPR: Record "Purchase Request";
        RecVéhicule: Record Véhicule;
    begin
        case
            DocumentAttachment."Table ID" of
            Database::"Purchase Request":
                begin
                    RecRef.Open(Database::"Purchase Request");
                    if RecPR.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(RecPR);
                end;
            Database::"Véhicule":
                begin
                    RecRef.Open(Database::"Véhicule");
                    if RecVéhicule.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(RecVéhicule);
                end;
        end;
    end;
    //HS Attachment DA + Véhicule

    // procedure VerifierEquipement(var ParaRecEquipement: Record "Véhicule"; ParamEquipement: Code[10])
    // begin
    //     if RecEquipement.Get(ParamEquipement) then;
    //     if RecEquipement."Gamme Actif" <> '' then begin
    //         if RecGamme.Get(RecEquipement."Gamme Actif") then;
    //         if (ParaRecEquipement."Index Théorique Final" - ParaRecEquipement."Dernier Index") <= RecGamme."Fréquence (Tolerance)" then begin
    //             // CreerBTParc(ParaRecEquipement,ParamEquipement,ParaRecEquipement."Gamme Actif");
    //         end;
    //     end;
    //     // >> MHD 21-02-2018
    //     AlerteDelai(ParaRecEquipement);
    //     // >> MHD 21-02-2018
    // end;

    //HS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Invt. Doc.-Post Shipment", 'OnRunOnAfterCommitPostInvtShptDoc', '', true, true)]
    local procedure OnRunOnAfterCommitPostInvtShptDoc(var InvtDocumentHeader: Record "Invt. Document Header"; var InvtDocumentLine: Record "Invt. Document Line"; InvtShipmentHeader: Record "Invt. Shipment Header"; InvtShipmentLine: Record "Invt. Shipment Line"; ItemJournalLine: Record "Item Journal Line"; var SuppressCommit: Boolean)
    var
        RepInvMVT: Report "Inventory Movement Spec";
        InvtShipmentHeader2: Record "Invt. Shipment Header";
    begin
        InvtShipmentHeader2.Reset();
        InvtShipmentHeader2.SetRange("No.", InvtShipmentHeader."No.");
        // InvtShipmentHeader.SetRange("Document Type", InvtShipmentHeader."Document Type"::Shipment);
        if InvtShipmentHeader2.FindFirst() then begin
            RepInvMVT.SetTableView(InvtShipmentHeader2);
            RepInvMVT.Run();
            Commit();
        end;

    end;
    //HS



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterCreateItemJnlLine', '', true, true)]
    local procedure OnAfterCreateItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferShipmentHeader: Record "Transfer Shipment Header"; TransferShipmentLine: Record "Transfer Shipment Line")
    begin
        ItemJournalLine.Observation := TransferShipmentHeader.Observation;
        ItemJournalLine.Receptioneur := TransferShipmentHeader."Id Receptioneur";
        ItemJournalLine."N° Materiel" := TransferShipmentHeader."Shortcut Dimension 1 Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Invt. Doc.-Post Shipment", 'OnAfterFillItemJournalLineQtyFromInvtShipmentLine', '', true, true)]
    local procedure OnAfterFillItemJournalLineQtyFromInvtShipmentLine(var ItemJournalLine: Record "Item Journal Line"; InvtShipmentLine: Record "Invt. Shipment Line"; InvtShipmentHeader: Record "Invt. Shipment Header")
    begin
        //  ItemJournalLine."Lieu de Livraison / Provenance" := InvtShipmentHeader."Lieu Livraison / Provenance";
        ItemJournalLine.Observation := InvtShipmentHeader.Observation;
        ItemJournalLine.Benificiaire := InvtShipmentHeader.Benificiaire;
        ItemJournalLine."N° Piéce" := InvtShipmentHeader."N° Piéce";
        ItemJournalLine."Index Vehicule" := InvtShipmentHeader."Index Vehicule";
        ItemJournalLine.Receptioneur := InvtShipmentHeader.Receptioneur;
        ItemJournalLine."N° Materiel" := InvtShipmentHeader."N° Materiel";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', true, true)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    begin

        //  NewItemLedgEntry."Lieu Livraison / Provenance" := ItemJournalLine."Lieu Livraison / Provenance";
        //   NewItemLedgEntry.Observation := ItemJournalLine.Observation;
        NewItemLedgEntry.Benificiaire := ItemJournalLine.Benificiaire;
        //  NewItemLedgEntry."N° Piéce" := ItemJournalLine."N° Piéce";
        //NewItemLedgEntry."Index Vehicule" := ItemJournalLine."Index Vehicule";
        NewItemLedgEntry.Receptioneur := ItemJournalLine.Receptioneur;
        NewItemLedgEntry."Materiel" := ItemJournalLine."N° Materiel";
        //ItemJournalLine."Lieu Livraison / Provenance"
    end;
    //HS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"NoSeriesManagement", 'OnBeforeInitSeries', '', true, true)]

    local procedure OnBeforeInitSeries(var DefaultNoSeriesCode: Code[20]; OldNoSeriesCode: Code[20]; NewDate: Date; var NewNo: Code[20]; var NewNoSeriesCode: Code[20]; var NoSeries: Record "No. Series"; var IsHandled: Boolean; var NoSeriesCode: Code[20])
    var
        InvtSetup: Record "Inventory Setup";
    begin
        InvtSetup.Get();
        if InvtSetup."Invt. Shipment Nos." = DefaultNoSeriesCode then
            IsHandled := true;

        if InvtSetup."Invt. Receipt Nos." = DefaultNoSeriesCode then
            IsHandled := true;
    end;
    //HS
    //HS
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Invt. Doc.-Post Shipment", OnBeforeOnRun, '', false, false)]

    local procedure OnBeforeOnRun(var InvtDocumentHeader: Record "Invt. Document Header"; var SuppressCommit: Boolean; var HideProgressWindow: Boolean)
    var
        UserSetup: Record "User Setup";
        RecInvtDocumentLine: Record "Invt. Document Line";
    begin
        if UserSetup.Get(UserId) then begin
            if (UserSetup."N° matériel Obligatoire") and (InvtDocumentHeader."N° Materiel" = '') then
                Error('Le champ "N° Materiel" est obligatoire. Veuillez le renseigner avant de poster.');
        end;
        // if InvtDocumentHeader."Lieu Livraison / Provenance" = '' then
        //     Error('Le champ "Lieu Livraison / Provenance" est obligatoire. Veuillez le renseigner avant de poster.');
        if InvtDocumentHeader.Receptioneur = '' then
            Error('Le champ "Réceptionneur" est obligatoire. Veuillez le renseigner avant de poster.');
        RecInvtDocumentLine.Reset();
        RecInvtDocumentLine.SetRange("Document No.", InvtDocumentHeader."No.");
        RecInvtDocumentLine.SetRange("Unit Amount", 0);
        if RecInvtDocumentLine.FindFirst() then
            Error('Impossible de poster le document. Une ou plusieurs lignes ont un montant unitaire à zéro (0). Veuillez vérifier les lignes du document.');
    end;
    //5080
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Invt. Doc.-Post Receipt", 'OnBeforeOnRun', '', false, false)]

    local procedure OnBeforeOnRun5080(var InvtDocumentHeader: Record "Invt. Document Header"; var SuppressCommit: Boolean; var HideProgressWindow: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then begin
            if (UserSetup."N° matériel Obligatoire") and (InvtDocumentHeader."N° Materiel" = '') then
                Error('Le champ "N° Materiel" est obligatoire. Veuillez le renseigner avant de poster.');
        end;
        // if InvtDocumentHeader."Lieu Livraison / Provenance" = '' then
        //     Error('Le champ "Lieu Livraison / Provenance" est obligatoire. Veuillez le renseigner avant de poster.');
        if InvtDocumentHeader.Receptioneur = '' then
            Error('Le champ "Réceptionneur" est obligatoire. Veuillez le renseigner avant de poster.');
    end;



    [EventSubscriber(ObjectType::Table, Database::"Transfer Header", 'OnBeforeTransLineDeleteAll', '', true, true)]
    local procedure OnBeforeTransLineDeleteAll(TransferHeader: Record "Transfer Header"; var TransferLine: Record "Transfer Line")
    var
        RectransfertHeaderArchive: Record "Transfer Header Archive";
        RectransfertLineArchive: Record "Transfer Line Archive";
    begin
        RectransfertHeaderArchive.TransferFields(TransferHeader);
        if RectransfertHeaderArchive.Insert() then
            RectransfertLineArchive.TransferFields(TransferLine);
        if RectransfertLineArchive.Insert() then;
    end;

    //HS

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateNoOnCopyFromTempPurchLine', '', true, true)]
    local procedure OnValidateNoOnCopyFromTempPurchLine(var PurchLine: Record "Purchase Line"; TempPurchaseLine: Record "Purchase Line" temporary; xPurchLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        PurchLine."Type article" := TempPurchaseLine."Type article";
    end;

    //New vente
    [EventSubscriber(ObjectType::Table, Database::"sales Line", 'OnValidateNoOnCopyFromTempSalesLine', '', true, true)]
    local procedure OnValidateNoOnCopyFromTempSalesLine(var SalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary; xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    begin
        SalesLine."Type article" := TempSalesLine."Type article";
    end;

    /////5851
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Invt. Doc.-Post Shipment", 'OnRunOnBeforeInvtShptHeaderInsert', '', false, false)]
    local procedure OnRunOnBeforeInvtShptHeaderInsert(InvtDocHeader: Record "Invt. Document Header"; var InvtShptHeader: Record "Invt. Shipment Header")
    var
        feferf: Report 7321;
    begin
        InvtShptHeader."DYSJob No." := InvtDocHeader."DYSJob No.";
        InvtShptHeader."DYSJob Task No." := InvtDocHeader."DYSJob Task No.";
        InvtShptHeader."DYSJob Planning Line No." := InvtDocHeader."DYSJob Planning Line No.";
        InvtShptHeader.Benificiaire := InvtDocHeader.Benificiaire;
        InvtShptHeader.Observation := InvtDocHeader.Observation;
        InvtShptHeader."N° Piéce" := InvtDocHeader."N° Piéce";
        InvtShptHeader."Index Vehicule" := InvtDocHeader."Index Vehicule";
        InvtShptHeader.Receptioneur := InvtDocHeader.Receptioneur;
        InvtShptHeader."Lieu Livraison / Provenance" := InvtDocHeader."Lieu Livraison / Provenance";
        InvtShptHeader."N° Materiel" := InvtDocHeader."N° Materiel";
        InvtShptHeader."Date Saisie" := InvtDocHeader."Date Saisie";
        InvtShptHeader.Utilisateur := InvtDocHeader.Utilisateur;

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Invt. Doc.-Post Shipment", 'OnRunOnBeforeInvtShptLineInsert', '', false, false)]

    local procedure OnRunOnBeforeInvtShptLineInsert(var InvtShptLine: Record "Invt. Shipment Line"; InvtDocLine: Record "Invt. Document Line"; var InvtShipmentHeader: Record "Invt. Shipment Header"; InvtDocumentHeader: Record "Invt. Document Header")
    begin
        InvtShptLine."DYSJob No." := InvtDocLine."DYSJob No.";
        InvtShptLine."DYSJob Task No." := InvtDocLine."DYSJob Task No.";
        InvtShptLine."DYSJob Planning Line No." := InvtDocLine."DYSJob Planning Line No.";
        InvtShptLine.Famille := InvtDocLine."Famille";
        InvtShptLine.Utilisateur := InvtDocLine."Utilisateur";
        InvtShptLine."Heure" := InvtDocLine."Heure";
        InvtShptLine."N° Piéce" := InvtDocLine."N° Piéce";

    end;
    /////5850











    [EventSubscriber(ObjectType::Codeunit, codeunit::"Invt. Doc.-Post Receipt", 'OnRunOnBeforeInvtRcptHeaderInsert', '', false, false)]

    local procedure OnRunOnBeforeInvtRcptHeaderInsert(var InvtRcptHeader: Record "Invt. Receipt Header"; InvtDocHeader: Record "Invt. Document Header")
    begin
        InvtRcptHeader."DYSJob No." := InvtDocHeader."DYSJob No.";
        InvtRcptHeader."DYSJob Task No." := InvtDocHeader."DYSJob Task No.";
        InvtRcptHeader."DYSJob Planning Line No." := InvtDocHeader."DYSJob Planning Line No.";
        InvtRcptHeader.Benificiaire := InvtDocHeader.Benificiaire;
        InvtRcptHeader.Observation := InvtDocHeader.Observation;
        InvtRcptHeader."N° Piéce" := InvtDocHeader."N° Piéce";
        InvtRcptHeader."Index Vehicule" := InvtDocHeader."Index Vehicule";
        InvtRcptHeader.Receptioneur := InvtDocHeader.Receptioneur;
        InvtRcptHeader."Lieu Livraison / Provenance" := InvtDocHeader."Lieu Livraison / Provenance";
        InvtRcptHeader."N° Materiel" := InvtDocHeader."N° Materiel";
        InvtRcptHeader."Date Saisie" := InvtDocHeader."Date Saisie";
        InvtRcptHeader.Utilisateur := InvtDocHeader.Utilisateur;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Invt. Doc.-Post Receipt", 'OnRunOnBeforeInvtRcptLineInsert', '', false, false)]

    local procedure OnRunOnBeforeInvtRcptLineInsert(var InvtRcptLine: Record "Invt. Receipt Line"; InvtDocLine: Record "Invt. Document Line")
    begin
        InvtRcptLine."DYSJob No." := InvtDocLine."DYSJob No.";
        InvtRcptLine."DYSJob Task No." := InvtDocLine."DYSJob Task No.";
        InvtRcptLine."DYSJob Planning Line No." := InvtDocLine."DYSJob Planning Line No.";
        InvtRcptLine.Famille := InvtDocLine."Famille";
        InvtRcptLine.Utilisateur := InvtDocLine."Utilisateur";
        InvtRcptLine."Heure" := InvtDocLine."Heure";
    end;


    //HS
    procedure CreerBTParc(var ParaRecEquipement: Record "Véhicule"; ParmEquipement: Code[10]; ParmGamme: Code[30])
    begin
        /*
        RecParametreParc.RESET;
        RecGamme.RESET;
        RecEquipement.RESET;
        RecItem.RESET;

        IF RecParametreParc.GET() THEN;
        IF RecGamme.GET(ParmGamme) THEN;
        IF RecEquipement.GET(ParmEquipement) THEN;

        // Insertion Entete BT
        RecEnteteBT.INIT;
        RecEnteteBT.Code := NoSeriesMgt.GetNextNo(RecParametreParc."Code BT Preventive",WORKDATE,TRUE);
        RecEnteteBT.Type := RecEnteteBT.Type::Preventive;
        RecEnteteBT."Date Lancement" := WORKDATE;
        RecEnteteBT.Equipement := ParmEquipement;
        RecEnteteBT."Designiation Equipement" := RecEquipement.Désignation;
        RecEnteteBT.Gamme:= ParmGamme;
        RecEnteteBT."Designiation Gamme":= RecGamme.Desgniation;
        RecEnteteBT.Frequence := RecGamme.Fréquence;
        RecEnteteBT.INSERT(TRUE);

        // Insertion Ligne BT
        RecDetailleGamme.SETRANGE("Code Gamme",ParmGamme);
        //RecDetailleGamme.SETRANGE("Code sous Famille",RecEquipement."Code Sous-Catégorie");
        IF RecDetailleGamme.FINDFIRST THEN
        REPEAT
           NumLigne+= 10000;
           "RecLigne BT"."Code BT" := RecEnteteBT.Code ;
           "RecLigne BT"."Num Ligne" := NumLigne;
           "RecLigne BT"."Code Equipement" := ParmEquipement;
           "RecLigne BT"."Code Gamme" := ParmGamme;
           "RecLigne BT"."Code Article" := RecDetailleGamme."Code Article";
           "RecLigne BT".Designiation := RecDetailleGamme."Designiation Article";
           "RecLigne BT"."Date Lancement" :=  WORKDATE;
           "RecLigne BT"."Type BT" := "RecLigne BT"."Type BT"::Preventive;
           "RecLigne BT".Quantite := RecDetailleGamme.Quantite;
           IF RecItem.GET(RecDetailleGamme."Code Article") THEN;
           "RecLigne BT"."Cout Article" := RecItem."Last Direct Cost";
           "RecLigne BT"."Cout Ligne" := RecItem."Last Direct Cost" * RecDetailleGamme.Quantite;
           "RecLigne BT".INSERT(TRUE);
        UNTIL RecDetailleGamme.NEXT =0;


        // REMPLISSAGE TABLE NOTIFICATION LANCEMENT BT PREVENTIF GMAO
        NotificationGMAO.Utilisateur:=RecUserSetup."User ID";
        NotificationGMAO."Type Notification" := NotificationGMAO."Type Notification":: GMAO;
        //NUMERO BT PREVENTIF
        NotificationGMAO."Document N°":= RecEnteteBT.Code;
           // CODE EQUIPEMENT EN QUESTION
        NotificationGMAO.Article:= ParmEquipement;
         // DESIGNIATION EQUIPEMENT EN QUESTION
        NotificationGMAO.Description:= RecEquipement.Désignation;
           // CODE GAMME
        NotificationGMAO."N° Materiel":= ParmGamme;
          // FREQUENCE DE LA GAMME
        NotificationGMAO."Quantité Alerte Min Max" := RecEnteteBT.Frequence;
           // INDEX DEPART DELAI
        NotificationGMAO."Index Depart":=RecEquipement."Index de Départ";
           // INDEX MAX DELAI
        NotificationGMAO."Index Max":=RecEquipement."Index de Départ"+RecEnteteBT.Frequence;
        NotificationGMAO.Tolerence :=RecGamme.Fréquence- RecGamme."Fréquence (Tolerance)";
           // INSERTION DANS LA TABLE NOTIFICATION GMAO
        IF NOT NotificationGMAO.INSERT THEN NotificationGMAO.MODIFY;

        // ACTIVER LA GAMME SUIVANTE
        ActiverNextGamme(ParaRecEquipement,ParmEquipement,ParmGamme);
        */

    end;


    // procedure ActiverNextGamme(var ParaRecEquipement: Record "Véhicule"; ParmEquipement: Code[10]; ParmGamme: Code[30])
    // var
    //     RecLasteGamme: Record Gamme;
    //     RecFilterGamme: Record Gamme;
    // begin

    //     RecParametreParc.Reset;
    //     RecGamme.Reset;
    //     RecEquipement.Reset;
    //     RecFilterGamme.Reset;

    //     if RecParametreParc.Get() then;
    //     if RecLasteGamme.Get(ParmGamme) then;
    //     if RecEquipement.Get(ParmEquipement) then;
    //     RecGamme.SetCurrentkey("Code sous Famille Equipement", Fréquence);
    //     RecGamme.SetRange("Code sous Famille Equipement", ParaRecEquipement."Sous Famille");
    //     RecGamme.SetFilter(Fréquence, '> %1', RecLasteGamme.Fréquence);
    //     if RecGamme.FindFirst then begin
    //         ParaRecEquipement."Gamme Actif" := RecGamme."Code Gamme";
    //         ParaRecEquipement."Index Théorique Final" := ParaRecEquipement."Index de Départ" + RecGamme.Fréquence;
    //     end
    //     // CAS OU LA GAMME ACTIF EST LA DERNIERE GAMME
    //     else begin
    //         ParaRecEquipement.CalcFields("Gamme Debut");
    //         RecFilterGamme.SetRange("Code sous Famille Equipement", ParaRecEquipement."Sous Famille");
    //         RecFilterGamme.SetFilter(Fréquence, '%1', ParaRecEquipement."Gamme Debut");
    //         if RecFilterGamme.FindFirst then begin
    //             ParaRecEquipement."Gamme Actif" := RecFilterGamme."Code Gamme";//ParaRecEquipement."Gamme Debut";
    //             ParaRecEquipement."Index de Départ" := ParaRecEquipement."Index Théorique Final";
    //             ParaRecEquipement."Index Théorique Final" := ParaRecEquipement."Index de Départ" + RecFilterGamme.Fréquence;
    //         end;
    //     end;
    // end;


    // procedure ValiderBT(RecEnteteBTOrigine: Record "Entete BT")
    // var
    //     RecLigneBTOrigine: Record "Ligne BT";
    //     RecEnteteBTEnreg: Record "Entete BT Enreg";
    //     RecLigneBTEnreg: Record "Ligne BT Enreg";
    //     "RecVéhiculeV": Record "Véhicule";
    // begin
    //     if not Confirm(Text004) then exit;
    //     // MAJ INDEX THEORIQUE FINAL
    //     if RecVéhiculeV.Get(RecEnteteBTOrigine.Equipement) then;
    //     RecVéhiculeV."Index Théorique Final" := RecEnteteBTOrigine."Index Actuelle";
    //     RecVéhiculeV.Modify;
    //     // RB SORO 07/10/2016 Validation BT
    //     //RecEnteteBTEnreg.RESET;
    //     //RecLigneBTEnreg.RESET;
    //     // Insertion Entete BT Enregestrie
    //     RecEnteteBTEnreg.TransferFields(RecEnteteBTOrigine);
    //     RecEnteteBTEnreg.Utilisateur := UpperCase(UserId);
    //     RecEnteteBTEnreg.Status := RecEnteteBTEnreg.Status::Executé;
    //     RecEnteteBTEnreg.Insert;
    //     // Insertion Ligne BT Enregestrie
    //     RecLigneBTOrigine.SetRange("Code BT", RecEnteteBTOrigine.Code);
    //     if RecLigneBTOrigine.FindFirst then
    //         repeat
    //             RecLigneBTEnreg.TransferFields(RecLigneBTOrigine);
    //             RecLigneBTEnreg.Insert;
    //         until RecLigneBTOrigine.Next = 0;
    //     // Supprition Ligne BT
    //     RecLigneBTOrigine.Reset;
    //     RecLigneBTOrigine.SetRange("Code BT", RecEnteteBTOrigine.Code);
    //     RecLigneBTOrigine.DeleteAll;
    //     // Supprition Entete BT
    //     RecEnteteBTOrigine.Delete;

    //     NotificationGMAO.SetRange("Document N°", RecEnteteBTOrigine.Code);
    //     if NotificationGMAO.FindFirst then
    //         repeat
    //             NotificationGMAO.Validé := true;
    //             NotificationGMAO.Modify;
    //         until NotificationGMAO.Next = 0;
    // end;


    // procedure ValiderReleverMesure(RecReleveMesures: Record "Relevé mesures")
    // var
    //     RecLignesReleveMesures: Record "Lignes Relevé mesures";
    //     "RecVéhiculeMesure": Record "Véhicule";
    // begin
    //     RecLignesReleveMesures.SetRange("N° Mesure", RecReleveMesures."N°");
    //     if RecLignesReleveMesures.FindFirst then
    //         repeat
    //             // MAJ "Index Théorique Final" DES EQUIPEMENTS
    //             if RecVéhiculeMesure.Get(RecLignesReleveMesures."Code Equipement") then;
    //             if RecVéhiculeMesure."Index Théorique Final" > RecLignesReleveMesures.Index then
    //                 Error(Text003, RecLignesReleveMesures."Code Equipement", RecVéhiculeMesure."Index Théorique Final");
    //             //RecVéhiculeMesure."Index Théorique Final" := RecLignesReleveMesures.Index;
    //             RecVéhiculeMesure.Validate("Index Théorique Final", RecLignesReleveMesures.Index);
    //             RecLignesReleveMesures.Status := RecLignesReleveMesures.Status::Valider;
    //             RecVéhiculeMesure.Modify;
    //             RecLignesReleveMesures.Modify;
    //         // Proposition : Ajouter un champs "Ancien Index Theorique Final" dans la Table Vehicule pour garder l'Hestorique
    //         until RecLignesReleveMesures.Next = 0;
    //     // Modification Status Entete Releve de Mesure
    //     RecReleveMesures.Status := RecReleveMesures.Status::Valider;
    //     RecReleveMesures.Modify;
    // end;


    // procedure AppliquerFilterReleverMesure(RecReleveMesuresFilter: Record "Relevé mesures")
    // var
    //     RecVehiculeMesure: Record "Véhicule";
    //     RecLignesReleveMesuresMesure: Record "Lignes Relevé mesures";
    //     NumLigne: Integer;
    // begin
    //     RecVehiculeMesure.Reset;
    //     if RecReleveMesuresFilter."Filter Affectation" <> '' then
    //         RecVehiculeMesure.SetRange(Marche, RecReleveMesuresFilter."Filter Affectation");
    //     if RecReleveMesuresFilter."Filter Sous Famille" <> '' then
    //         RecVehiculeMesure.SetRange(RecVehiculeMesure."Sous Famille", RecReleveMesuresFilter."Filter Sous Famille");

    //     if RecVehiculeMesure.FindFirst then
    //         repeat
    //             NumLigne += 10000;
    //             RecLignesReleveMesuresMesure.Validate("N° Mesure", RecReleveMesuresFilter."N°");
    //             RecLignesReleveMesuresMesure."N° Ligne" := NumLigne;
    //             RecLignesReleveMesuresMesure.Validate("Code Equipement", RecVehiculeMesure."N° Vehicule");
    //             if not RecLignesReleveMesuresMesure.Insert then RecLignesReleveMesuresMesure.Modify;
    //         until RecVehiculeMesure.Next = 0;
    // end;


    // procedure AlerteDelai(var ParaRecEquipement: Record "Véhicule")
    // var
    //     EnteteBT: Record "Entete BT";
    //     LigneFicheGasoil: Record "Ligne Fiche Gasoil";
    //     NotificationReception: Record "Notification Reception";
    //     MoyenIndex: Decimal;
    // begin
    //     // MH SORO 21-02-2018 Delai GMAO
    //     NotificationReception.Reset;
    //     NotificationReception.SetRange("Type Notification", NotificationReception."type notification"::GMAO);
    //     NotificationReception.SetRange(Article, ParaRecEquipement."N° Vehicule");
    //     NotificationReception.SetRange(Validé, false);
    //     if NotificationReception.FindFirst then
    //         repeat
    //             MoyenIndex := (NotificationReception."Index Max" + NotificationReception."Index Depart") / 2;
    //             EnteteBT.Reset;
    //             EnteteBT.SetRange(Code, NotificationReception."Document N°");
    //             if EnteteBT.FindFirst then begin
    //                 if EnteteBT.Status = 0 then begin
    //                     NotificationReception.Delai1 := true;
    //                     // Delai2
    //                     if (ParaRecEquipement."Dernier Index" < (NotificationReception."Index Max"))
    //                        and (ParaRecEquipement."Dernier Index" > NotificationReception."Index Depart") then
    //                         NotificationReception.Delai2 := true;
    //                     // Delai3
    //                     if ParaRecEquipement."Dernier Index" > (NotificationReception."Index Max") then
    //                         NotificationReception.Delai3 := true;

    //                     NotificationReception.Modify;
    //                 end;
    //             end;
    //         until NotificationReception.Next = 0;
    //     // MH SORO 21-02-2018  Delai GMAO
    // end;

    // //DYS Automation non compatible dans version cloud
    // /*

    //     procedure SendMail(ParaTo: Text[100]; ParaObjet: Text[100]; ParaBody: Text[100])
    //     var
    //         OBJApp: Automation;
    //         Mail: Automation;
    //     begin
    //         if ISCLEAR(OBJApp) then Create(OBJApp);
    //         Mail := OBJApp.CreateItem(0);
    //         Mail."To"(ParaTo);
    //         Mail.Subject(ParaObjet);
    //         Mail.Body(ParaBody);
    //         Mail.Display();
    //         Mail.Send();
    //     end;
    //     */


    // procedure VerifMateriauxChantier(ParaChantier: Code[20]; ParaMateraiux: Code[20])
    // var
    //     LPurchasesPayablesSetup: Record "Purchases & Payables Setup";
    //     LRegroupementRapportDG: Record "Regroupement Rapport DG";
    //     TextL001: label 'Article %1 Non parametré pour ce marché, consulter votre administrateur';
    //     LJob: Record Job;
    // begin
    //     // >> HJ SORO 06-03-2018
    //     if LJob.Get(ParaChantier) then;
    //     if LJob."Activer Procedure DA" then begin
    //         if LPurchasesPayablesSetup.Get then;
    //         if LPurchasesPayablesSetup."Activer Controle Marché" then
    //             if not LRegroupementRapportDG.Get(ParaMateraiux, ParaChantier) then Error(TextL001, ParaMateraiux);
    //     end;
    //     // >> HJ SORO 06-03-2018
    // end;


    // procedure MajLettreVendorLedgerEntry(ParaLettre: Text[5])
    // var
    //     LVendorLedgerEntry: Record "Vendor Ledger Entry";
    // begin
    //     // >> HJ SORO 05-04-2018
    //     LVendorLedgerEntry.SetRange(Lettre, ParaLettre);
    //     LVendorLedgerEntry.ModifyAll(Lettre, '');
    //     // >> HJ SORO 05-04-2018
    // end;


    // procedure NotificationDa(ParaDoc: Code[20]; ParaObjet: Text[100]; ParaChantier: Code[20]; ParaDate: Date; ParaCreerPar: Code[20])
    // var
    //     LNotificationReception: Record "Notification Reception";
    // begin
    //     LNotificationReception.Utilisateur := ParaCreerPar;
    //     LNotificationReception."BL N °" := Format(Time);
    //     LNotificationReception."Document N°" := ParaDoc;
    //     LNotificationReception.Article := '';
    //     LNotificationReception.Description := ParaObjet;
    //     LNotificationReception.Chantier := ParaChantier;
    //     LNotificationReception."Date Creation" := WorkDate;
    //     LNotificationReception."Type Notification" := LNotificationReception."type notification"::DA;
    //     if not LNotificationReception.Insert then LNotificationReception.Modify;
    // end;
}

