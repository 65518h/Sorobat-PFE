Codeunit 50099 "Purge traitement BD"
{

    trigger OnRun()
    begin
        ERROR('Attention ce code vide la base');
        exit;
        if not Confirm('Voulez vous purger la base') then
            Error('Pas de purge');

        if not Confirm('Etes-vous sure de bien vouloir purger la base') then
            Error('Pas de purge');
        EXIT;

        RecGLEntryVATEntrylink.Reset;
        RecGLEntryVATEntrylink.DeleteAll;

        /* GL2024 JournalLineDimension.Reset;
         JournalLineDimension.DeleteAll;*/

        DocumentDimensionArchive.Reset;
        DocumentDimensionArchive.DeleteAll;

        SalesHeaderArchive.Reset;
        SalesHeaderArchive.DeleteAll;

        SalesLineArchive.Reset;
        SalesLineArchive.DeleteAll;

        PurchaseHeadeArchive.Reset;
        PurchaseHeadeArchive.DeleteAll;

        PurchaseLineArchive.Reset;
        PurchaseLineArchive.DeleteAll;

        /* GL2024  LedgerEntryDimension.Reset;
          LedgerEntryDimension.DeleteAll;*/

        DocumentDimension.Reset;
        DocumentDimension.DeleteAll;

        PostedDocumentDimension.Reset;
        PostedDocumentDimension.DeleteAll;


        /*GL2024  JournalLineDimension.Reset;
          JournalLineDimension.DeleteAll;*/

        /*
       EcrCpte.RESET;
       EcrCpte.DELETEALL;

       EcrCli.RESET;
       EcrCli.DELETEALL;

       EcrFrn.RESET;
       EcrFrn.DELETEALL;


       EcrCliDetail.RESET;
       EcrCliDetail.DELETEALL;

       EcrFrnDetail.RESET;
       EcrFrnDetail.DELETEALL;
         */
        //EcrArt.RESET;
        //EcrArt.DELETEALL;

        RecLiensEcritureVal.Reset;
        RecLiensEcritureVal.DeleteAll;

        LigVente.Reset;
        LigVente.DeleteAll;

        EnteteVente.Reset;
        EnteteVente.DeleteAll;

        LigAchat.Reset;
        LigAchat.DeleteAll;

        EnteteAchat.Reset;
        EnteteAchat.DeleteAll;

        HistoriqueCpte.Reset;
        HistoriqueCpte.DeleteAll;

        HistoriqueArticle.Reset;
        HistoriqueArticle.DeleteAll;

        CommentaireAchat.Reset;
        CommentaireAchat.DeleteAll;

        CommentaireVente.Reset;
        CommentaireVente.DeleteAll;

        LigFCpte.Reset;
        LigFCpte.DeleteAll;

        LigFArt.Reset;
        LigFArt.DeleteAll;

        EcrBudget.Reset;
        EcrBudget.DeleteAll;

        Commentaire.Reset;
        Commentaire.DeleteAll;

        LigExp.Reset;
        LigExp.DeleteAll;

        EnteteExp.Reset;
        EnteteExp.DeleteAll;

        LigFactVente.Reset;
        LigFactVente.DeleteAll;

        EnteteFactVente.Reset;
        EnteteFactVente.DeleteAll;

        LigAvoirVente.Reset;
        LigAvoirVente.DeleteAll;

        EnteteAvoirVente.Reset;
        EnteteAvoirVente.DeleteAll;

        LigRec.Reset;
        LigRec.DeleteAll;

        EnteteRec.Reset;
        EnteteRec.DeleteAll;

        LigFactAchat.Reset;
        LigFactAchat.DeleteAll;

        EnteteFactAchat.Reset;
        EnteteFactAchat.DeleteAll;

        LigAvoirAchat.Reset;
        LigAvoirAchat.DeleteAll;

        EnteteAvoirAchat.Reset;
        EnteteAvoirAchat.DeleteAll;

        LigDemandeAchat.Reset;
        LigDemandeAchat.DeleteAll;

        EcrTVA.Reset;
        EcrTVA.DeleteAll;

        //<<MYC

        R5811.Reset;
        R5811.DeleteAll;

        RecGPurchaseRequestHeader.Reset;
        RecGPurchaseRequestHeader.DeleteAll;

        RecGPostedApprovalEntry.Reset;
        RecGPostedApprovalEntry.DeleteAll;





        RecPaymentLine.Reset;
        RecPaymentLine.DeleteAll;

        RecPurchaseHeader.Reset;
        RecPurchaseHeader.DeleteAll;



        RecLigneDmdAchat.Reset;
        RecLigneDmdAchat.DeleteAll;



        RecGApprovalEntry.Reset;
        RecGApprovalEntry.DeleteAll;

        //>>MYC

        Banque.Reset;
        if Banque.Find('-') then begin
            Banque."Last Statement No." := ' ';
            Banque."Balance Last Statement" := 0;
        end;

        //EcrBanque.RESET;
        //EcrBanque.DELETEALL;

        LigRappBanque.Reset;
        LigRappBanque.DeleteAll;

        RappBanque.Reset;
        RappBanque.DeleteAll;

        LigReleve.Reset;
        LigReleve.DeleteAll;

        Releve.Reset;
        Releve.DeleteAll;

        LigInventaire.Reset;
        LigInventaire.DeleteAll;

        EcrReservation.Reset;
        EcrReservation.DeleteAll;

        EcrDocReservation.Reset;
        EcrDocReservation.DeleteAll;

        EcrLettrageArt.Reset;
        EcrLettrageArt.DeleteAll;


        LigArchiveVente.Reset;
        LigArchiveVente.DeleteAll;

        EnteteArchiveVente.Reset;
        EnteteArchiveVente.DeleteAll;

        LigArchiveAchat.Reset;
        LigArchiveAchat.DeleteAll;

        EnteteArchiveAchat.Reset;
        EnteteArchiveAchat.DeleteAll;

        LigTransfert.Reset;
        LigTransfert.DeleteAll;

        EnteteTransfert.Reset;
        EnteteTransfert.DeleteAll;

        //Echeminement.RESET;
        //Echeminement.DELETEALL;

        LigExpTransf.Reset;
        LigExpTransf.DeleteAll;

        EnteteExpTransf.Reset;
        EnteteExpTransf.DeleteAll;

        LigRecTransf.Reset;
        LigRecTransf.DeleteAll;

        EnteteRecTransf.Reset;
        EnteteRecTransf.DeleteAll;

        LigCommentTransf.Reset;
        LigCommentTransf.DeleteAll;

        DemMagasin.Reset;
        DemMagasin.DeleteAll;

        LigAct.Reset;
        LigAct.DeleteAll;

        EnteteAct.Reset;
        EnteteAct.DeleteAll;

        Transbordement.Reset;
        Transbordement.DeleteAll;

        LigActEnreg.Reset;
        LigActEnreg.DeleteAll;

        EnteteActEnreg.Reset;
        EnteteActEnreg.DeleteAll;

        EcrValeur.Reset;
        EcrValeur.DeleteAll;

        FraisAchat.Reset;
        FraisAchat.DeleteAll;

        FraisVente.Reset;
        FraisVente.DeleteAll;


        DétailSN.Reset;
        DétailSN.DeleteAll;

        DétailLot.Reset;
        DétailLot.DeleteAll;

        CommentTraç.Reset;
        CommentTraç.DeleteAll;


        LigRetExp.Reset;
        LigRetExp.DeleteAll;

        EnteteRetExp.Reset;
        EnteteRetExp.DeleteAll;

        LigRetRec.Reset;
        LigRetRec.DeleteAll;

        EntetRetRec.Reset;
        EntetRetRec.DeleteAll;


        /*DétailReçu.RESET;
        DétailReçu.DELETEALL;
        
        LigReçu.RESET;
        LigReçu.DELETEALL;
        
        Reçu.RESET;
        Reçu.DELETEALL;
        
        EffetCli.RESET;
        EffetCli.DELETEALL;
        
        SuiviBanque.RESET;
        SuiviBanque.DELETEALL;*/

        "Shipment Invoiced".Reset;
        "Shipment Invoiced".DeleteAll;

        //
        LigPrelevEnreg.Reset;
        LigPrelevEnreg.DeleteAll;

        PrevelEnreg.Reset;
        PrevelEnreg.DeleteAll;

        LigPrelev.Reset;
        LigPrelev.DeleteAll;

        Prelev.Reset;
        Prelev.DeleteAll;

        RecRequPrelev.Reset;
        RecRequPrelev.DeleteAll;

        LigExpedMagEnreg.Reset;
        LigExpedMagEnreg.DeleteAll;

        ExpedMagEnreg.Reset;
        ExpedMagEnreg.DeleteAll;

        LigExpedMag.Reset;
        LigExpedMag.DeleteAll;

        ExpedMag.Reset;
        ExpedMag.DeleteAll;

        LignTracabilite.Reset;
        LignTracabilite.DeleteAll;

        EcritureTracabilite.Reset;
        EcritureTracabilite.DeleteAll;

        DisponibiliteTracabili.Reset;
        DisponibiliteTracabili.DeleteAll;

        EcritureLienArt.Reset;
        EcritureLienArt.DeleteAll;






        //Souche.RESET;
        //Souche.FIND('-');
        //REPEAT
        // Souche."Last No. Used" := '';
        // Souche."Last Date Used" := 0D;
        //  Souche.MODIFY;
        //UNTIL Souche.NEXT = 0;

        // ************************************************* Ajout  **************************************
        // ***************************************************** 29/04/2006 *****************************************
        // -*********************************************** Purge dernier coût et coût unitaire article*************

        //Article.RESET;
        //IF Article.FIND('-') THEN
        //REPEAT
        //  Article."Unit Cost" := 0;
        //  Article."Last Direct Cost" := 0;
        //  Article.MODIFY;
        //UNTIL Article.NEXT = 0;
        // ********************************************** Purge Analyse par vue ***************************************
        AnalysisView.Reset;
        if AnalysisView.Find('-') then
            repeat
                AnalysisView."Last Entry No." := 0;
                AnalysisView."Last Budget Entry No." := 0;
                AnalysisView."Last Date Updated" := Today;
                AnalysisView.Modify;
            until AnalysisView.Next = 0;

        AnalysisViewEntry.Reset;
        AnalysisViewEntry.DeleteAll;

        // ********************************************** Purge point de stock ****************************************
        Pointstk.Reset;
        if Pointstk.Find('-') then
            repeat
                Pointstk."Unit Cost" := 0;
                Pointstk."Last Direct Cost" := 0;
                Pointstk.Modify;
            until Pointstk.Next = 0;


        ParamMag.Get;
        ParamMag."Last Whse. Posting Ref. No." := 0;
        ParamMag.Modify;

        //  Dossier.Reset;
        //  Dossier.DeleteAll;

        Job.Reset;
        Job.DeleteAll;

        EcritureMag.DeleteAll;
        TransacMag.DeleteAll;

        R00038.DeleteAll;
        //Ressources & Emplois

        // Job Ledger Entry
        RecJobLedgerEntry.Reset;
        RecJobLedgerEntry.DeleteAll;

        Message('Traitement terminé');

    end;

    var
        EcrCpte: Record "G/L Entry";
        EcrCli: Record "Cust. Ledger Entry";
        EcrFrn: Record "Vendor Ledger Entry";
        EcrArt: Record "Item Ledger Entry";
        LigVente: Record "Sales Line";
        EnteteVente: Record "Sales Header";
        LigAchat: Record "Purchase Line";
        EnteteAchat: Record "Purchase Header";
        HistoriqueCpte: Record "G/L Register";
        HistoriqueArticle: Record "Item Register";
        CommentaireAchat: Record "Purch. Comment Line";
        CommentaireVente: Record "Sales Comment Line";
        LigFCpte: Record "Gen. Journal Line";
        LigFArt: Record "Item Journal Line";
        EcrBudget: Record "G/L Budget Entry";
        Commentaire: Record "Comment Line";
        LigExp: Record "Sales Shipment Line";
        EnteteExp: Record "Sales Shipment Header";
        LigFactVente: Record "Sales Invoice Line";
        EnteteFactVente: Record "Sales Invoice Header";
        LigAvoirVente: Record "Sales Cr.Memo Line";
        EnteteAvoirVente: Record "Sales Cr.Memo Header";
        LigRec: Record "Purch. Rcpt. Line";
        EnteteRec: Record "Purch. Rcpt. Header";
        LigFactAchat: Record "Purch. Inv. Line";
        EnteteFactAchat: Record "Purch. Inv. Header";
        LigAvoirAchat: Record "Purch. Cr. Memo Line";
        EnteteAvoirAchat: Record "Purch. Cr. Memo Hdr.";
        LigDemandeAchat: Record "Requisition Line";
        EcrTVA: Record "VAT Entry";
        EcrBanque: Record "Bank Account Ledger Entry";
        RappBanque: Record "Bank Acc. Reconciliation";
        LigRappBanque: Record "Bank Acc. Reconciliation Line";
        Releve: Record "Bank Account Statement";
        LigReleve: Record "Bank Account Statement Line";
        LigInventaire: Record "Phys. Inventory Ledger Entry";
        EcrReservation: Record "Reservation Entry";
        EcrDocReservation: Record "Entry Summary";
        EcrLettrageArt: Record "Item Application Entry";
        EcrCliDetail: Record "Detailed Cust. Ledg. Entry";
        EcrFrnDetail: Record "Detailed Vendor Ledg. Entry";
        EnteteArchiveVente: Record "Sales Header Archive";
        LigArchiveVente: Record "Sales Line Archive";
        EnteteArchiveAchat: Record "Purchase Header Archive";
        LigArchiveAchat: Record "Purchase Line Archive";
        EnteteTransfert: Record "Transfer Header";
        LigTransfert: Record "Transfer Line";
        Echeminement: Record "Transfer Route";
        EnteteExpTransf: Record "Transfer Shipment Header";
        LigExpTransf: Record "Transfer Shipment Line";
        EnteteRecTransf: Record "Transfer Receipt Header";
        LigRecTransf: Record "Transfer Receipt Line";
        LigCommentTransf: Record "Inventory Comment Line";
        DemMagasin: Record "Warehouse Request";
        EnteteAct: Record "Warehouse Activity Header";
        LigAct: Record "Warehouse Activity Line";
        Transbordement: Record "Whse. Cross-Dock Opportunity";
        EnteteActEnreg: Record "Registered Whse. Activity Hdr.";
        LigActEnreg: Record "Registered Whse. Activity Line";
        EcrValeur: Record "Value Entry";
        FraisAchat: Record "Item Charge Assignment (Purch)";
        FraisVente: Record "Item Charge Assignment (Sales)";
        "DétailSN": Record "Serial No. Information";
        "DétailLot": Record "Lot No. Information";
        "CommentTraç": Record "Item Tracking Comment";
        EnteteRetExp: Record "Return Shipment Header";
        LigRetExp: Record "Return Shipment Line";
        EntetRetRec: Record "Return Receipt Header";
        LigRetRec: Record "Return Receipt Line";
        //GL20224 Souche: Record 309;
        "Shipment Invoiced": Record "Shipment Invoiced";
        PrevelEnreg: Record "Registered Whse. Activity Hdr.";
        LigPrelevEnreg: Record "Registered Whse. Activity Line";
        Prelev: Record "Warehouse Activity Header";
        LigPrelev: Record "Warehouse Activity Line";
        ExpedMagEnreg: Record "Posted Whse. Shipment Header";
        LigExpedMagEnreg: Record "Posted Whse. Shipment Line";
        ExpedMag: Record "Warehouse Shipment Header";
        LigExpedMag: Record "Warehouse Shipment Line";
        LignTracabilite: Record "Tracking Specification";
        EcritureTracabilite: Record "Item Ledger Entry";
        DisponibiliteTracabili: Record "Entry Summary";
        EcritureLienArt: Record "Item Entry Relation";
        ParamMag: Record "Warehouse Setup";
        RecRequPrelev: Record "Whse. Pick Request";
        RecLiensEcritureVal: Record "Value Entry Relation";
        //GL2024 LedgerEntryDimension: Record 355;
        DocumentDimension: Record "Gen. Jnl. Dim. Filter";
        PostedDocumentDimension: Record "Reservation Worksheet Log";
        Article: Record Item;
        AnalysisViewEntry: Record "Analysis View Entry";
        Pointstk: Record "Stockkeeping Unit";
        AnalysisView: Record "Analysis View";
        //GL2024 JournalLineDimension: Record 356;
        DocumentDimensionArchive: Record "Interaction Merge Data";
        SalesHeaderArchive: Record "Sales Header Archive";
        SalesLineArchive: Record "Sales Line Archive";
        PurchaseHeadeArchive: Record "Purchase Header Archive";
        PurchaseLineArchive: Record "Purchase Line Archive";
        Banque: Record "Bank Account";
        //  Dossier: Record "Detail Avancement Production";
        Job: Record Job;
        EcritureMag: Record "Warehouse Entry";
        TransacMag: Record "Warehouse Register";
        R5811: Record "Post Value Entry to G/L";
        R00038: Record "Purchase Header";
        RecGPurchaseRequestHeader: Record Demandeur;
        RecGPostedApprovalEntry: Record "Posted Approval Entry";
        RecPurchaseHeader: Record "Payment Header";
        RecPaymentLine: Record "Payment Line";
        RecLigneCaisse: Record "PV Reception";
        RecLigneDmdAchat: Record "Montant lettre";
        RecGApprovalEntry: Record "Approval Entry";
        RecGLEntryVATEntrylink: Record "G/L Entry - VAT Entry Link";
        RecJobLedgerEntry: Record "Job Ledger Entry";
        EnteteFicheGasoil: Record "Entete Fiche Gasoil";
        LigneFicheGasoil: Record "Ligne Fiche Gasoil";
}

