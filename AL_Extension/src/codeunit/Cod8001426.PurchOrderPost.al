Codeunit 8001426 "Purch. Order - Post"
{
    // //FACT_ACHAT_PERSO CLA 10/06/03 MAJ Ecriture Système
    // //COTFRN GESWAY 04/07/05 Appel de la fonction SetCompletePurchOrder du codeunit SingleInstance
    // //+REF+USEREXIT CW 18/12/08
    // //+REF+ACHAT CLA 04/06/03 Validation commande achat
    //           GESWAY 13/01/05 Archiver la commande si pas déjà fait
    // //+REF+SOLDE_CDE 17/08/06 Ajout "Solder la commande"

    TableNo = "Purchase Header";

    trigger OnRun()
    var
        lRecordRef: RecordRef;
        lUserExit: Codeunit UserExit;
    begin
        //+REF+USEREXIT
        lRecordRef.GetTable(Rec);
        lUserExit.CodeunitOnRun(lRecordRef, Codeunit::"Purch.-Post (Yes/No)", -1);
        lRecordRef.SetTable(Rec);
        //+REF+USEREXIT//

        PurchHeader.Copy(Rec);
        Code;
        Rec := PurchHeader;
    end;

    var
        PurchHeader: Record "Purchase Header";
        ReportSelection: Record "Report Selections";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        PurchShptHeader: Record "Return Shipment Header";
        PrintDoc: Boolean;
        ReceiptOnly: Boolean;
        AmountToInvoice: Decimal;


    procedure "Code"()
    var
        lPurchPost: Codeunit "Purch.-Post";
        lReceiptForm: Page 8001452;
        lPostingForm: Page 8001426;
        lReceive: Boolean;
        lInvoice: Boolean;
        lComplete: Boolean;
        lOK: Boolean;
        lSingleInstance: Codeunit "Import SingleInstance2";
        lPostingDate: Date;
        lRecordRef: RecordRef;
        lUserExit: Codeunit UserExit;
        lCompanySetup: Record "Company Setup";
        lWorkflowSetup: Record "Workflow Setup";
        lWorkflowMgt: Codeunit "Workflow Management2";
    begin
        with PurchHeader do begin
            //+WKF+CUSTOM
            if ("Document Type" = "document type"::Order) and (Status <> Status::Released) then
                if lWorkflowSetup.Get and lWorkflowSetup."Release Purchase Document" then
                    if lWorkflowMgt.WorkflowTypeNo(page::"Purchase Order", '', "No.", '', '') then
                        exit;
            //+WKF+CUSTOM//
            lOK := false;
            if ReceiptOnly then begin
                lReceive := true;
                lInvoice := false;
                //+REF+SOLDE_CDE
                lComplete := false;
                //+REF+SOLDE_CDE//
                //3455
                Get("Document Type", "No.");
                //#8877
                if "Document Type" = "document type"::"Return Order" then
                    Ship := lReceive
                else
                    //#8877//
                    Receive := lReceive;
                Modify;
                Commit;
                //3455//
                lReceiptForm.wInitRequest(lReceive, lInvoice, PrintDoc);
                lReceiptForm.SetRecord(PurchHeader);
                lReceiptForm.LookupMode := true;
                if lReceiptForm.RunModal = Action::LookupOK then begin
                    //#4868
                    lReceiptForm.wFinishRequest(lReceive, lInvoice, lComplete, lPostingDate, PrintDoc);
                    //#4868//
                    if not lReceive then
                        exit;
                    lOK := true;
                    PurchHeader.Get(PurchHeader."Document Type", PurchHeader."No.");
                    //#8877
                    if "Document Type" = "document type"::"Return Order" then
                        Ship := lReceive
                    else
                        //#8877//
                        Receive := lReceive;
                    Invoice := lInvoice;
                    "Posting Date" := lPostingDate;
                    Modify;
                end;
            end else begin
                lReceive := true;
                lInvoice := true;
                //+REF+SOLDE_CDE
                lComplete := true;
                //+REF+SOLDE_CDE//
                //3455
                Get("Document Type", "No.");
                //#8877
                if "Document Type" = "document type"::"Return Order" then
                    Ship := lReceive
                else
                    //#8877
                    Receive := lReceive;
                Modify;
                Commit;
                //3455//
                lPostingForm.wInitRequest(lReceive, lInvoice, PrintDoc);
                lPostingForm.SetRecord(PurchHeader);
                if lPostingform.RunModal = Action::OK then begin
                    lPostingForm.wFinishRequest(lReceive, lInvoice, lComplete, lPostingDate);
                    if not lReceive and not lInvoice then
                        exit;
                    lOK := true;
                    PurchHeader.Get(PurchHeader."Document Type", PurchHeader."No.");
                    //#8877
                    if "Document Type" = "document type"::"Return Order" then
                        Ship := lReceive
                    else
                        //#8877
                        Receive := lReceive;
                    Invoice := lInvoice;
                    "Posting Date" := lPostingDate;
                    Modify;
                end;
            end;

            if lOK then begin
                //+REF+USEREXIT
                lRecordRef.GetTable(PurchHeader);
                lUserExit.CodeunitOnRun(lRecordRef, Codeunit::"Purch.-Post (Yes/No)", +1);
                lRecordRef.SetTable(PurchHeader);
                //+REF+USEREXIT//

                StoreDocument;
                /*A conserver AC/CW 19/06/07
                //FACTURATION_ACHAT_PERSO
                //      PurchHeader.GET(PurchHeader."Document Type",PurchHeader."No.");
                //      lPurchPost.RUN(PurchHeader);
                    lCompanySetup.GET;
                    IF (lCompanySetup."ID Generate purch. difference" <> 0) AND ("Document Type" = "Document Type"::Order) THEN BEGIN
                      IF "Vendor Invoice No." = '' THEN
                        lGenerateDiff.DeletePurchLine(PurchHeader);
                      IF Invoice THEN
                        TESTFIELD("Vendor Invoice No.");
                      UpdatePurchLine;
                    END;
                    COMMIT;
                A conserver AC/CW 19/06/07*/
                //COTFRN
                lSingleInstance.SetCompletePurchOrder(lComplete);
                //COTFRN//
                /*A conserver AC/CW 19/06/07
                    IF NOT lPurchPost.RUN(PurchHeader) THEN BEGIN
                      IF (lCompanySetup."ID Generate purch. difference" <> 0) AND ("Document Type" = "Document Type"::Order) THEN
                        lGenerateDiff.DeletePurchLine(PurchHeader);
                      PurchHeader.GET(PurchHeader."Document Type",PurchHeader."No.");
                      lPurchPost.RUN(PurchHeader);
                    END
                    ELSE
                      UpdatePurchLine;
                A conserver AC/CW 19/06/07*/
                //FACTURATION_ACHAT_PERSO//
                PurchHeader.Get(PurchHeader."Document Type", PurchHeader."No.");
                lPurchPost.Run(PurchHeader);

                if PrintDoc then begin
                    case "Document Type" of
                        "document type"::Order:
                            begin
                                if Receive then begin
                                    PurchRcptHeader."No." := "Last Receiving No.";
                                    PurchRcptHeader.SetRecfilter;
                                    PrintReport(ReportSelection.Usage::"P.Receipt");
                                end;
                                if Invoice then begin
                                    PurchInvHeader."No." := "Last Posting No.";
                                    PurchInvHeader.SetRecfilter;
                                    PrintReport(ReportSelection.Usage::"P.Invoice");
                                end;
                            end;
                        "document type"::Invoice:
                            begin
                                if "Last Posting No." = '' then
                                    PurchInvHeader."No." := "No."
                                else
                                    PurchInvHeader."No." := "Last Posting No.";
                                PurchInvHeader.SetRecfilter;
                                PrintReport(ReportSelection.Usage::"P.Invoice");
                            end;
                        "document type"::"Return Order":
                            begin
                                if Ship then begin
                                    PurchShptHeader."No." := "Last Return Shipment No.";
                                    PurchShptHeader.SetRecfilter;
                                    PrintReport(ReportSelection.Usage::"P.Ret.Shpt.");
                                end;
                                if Invoice then begin
                                    PurchCrMemoHeader."No." := "Last Posting No.";
                                    PurchCrMemoHeader.SetRecfilter;
                                    PrintReport(ReportSelection.Usage::"P.Cr.Memo");
                                end;
                            end;
                        "document type"::"Credit Memo":
                            begin
                                if "Last Posting No." = '' then
                                    PurchCrMemoHeader."No." := "No."
                                else
                                    PurchCrMemoHeader."No." := "Last Posting No.";
                                PurchCrMemoHeader.SetRecfilter;
                                PrintReport(ReportSelection.Usage::"P.Cr.Memo");
                            end;
                    end;
                end;

                if lComplete and ("Document Type" = "document type"::Order) then begin
                    Codeunit.Run(Codeunit::"Complete Purch. Order", PurchHeader);
                    CalcFields("Completely Received");
                    //FACTURATION_ACHAT_PERSO
                    if not lCompanySetup."Keep Invoiced Order" then
                        //FACTURATION_ACHAT_PERSO//
                        if "Completely Received" and PurchHeader.fCompletelyInvoiced(PurchHeader) then
                            Delete(true);
                end else begin
                    if PurchHeader.Get(PurchHeader."Document Type", PurchHeader."No.") then begin
                        PurchHeader."Vendor Shipment No." := '';
                        PurchHeader.Modify;
                    end;
                end;

            end else begin
                //FACTURATION_ACHAT_PERSO
                /*
                    lCompanySetup.GET;
                    IF (lCompanySetup."ID Generate purch. difference" <> 0) AND ("Document Type" = "Document Type"::Order) THEN
                      lGenerateDiff.DeletePurchLine(PurchHeader);
                */
                //FACTURATION_ACHAT_PERSO//
            end;

        end;

    end;

    local procedure PrintReport(ReportUsage: Integer)
    begin
        ReportSelection.Reset;
        ReportSelection.SetRange(Usage, ReportUsage);
        ReportSelection.Find('-');
        repeat
            ReportSelection.TestField("Report ID");
            case ReportUsage of
                ReportSelection.Usage::"P.Invoice":
                    Report.Run(ReportSelection."Report ID", false, false, PurchInvHeader);
                ReportSelection.Usage::"P.Cr.Memo":
                    Report.Run(ReportSelection."Report ID", false, false, PurchCrMemoHeader);
                ReportSelection.Usage::"P.Receipt":
                    Report.Run(ReportSelection."Report ID", false, false, PurchRcptHeader);
                ReportSelection.Usage::"P.Ret.Shpt.":
                    Report.Run(ReportSelection."Report ID", false, false, PurchShptHeader);
            end;
        until ReportSelection.Next = 0;
    end;


    procedure UpdatePurchLine()
    var
        lPurchLine: Record "Purchase Line";
    begin
        lPurchLine.SetRange("Document Type", PurchHeader."Document Type");
        lPurchLine.SetRange("Document No.", PurchHeader."No.");
        lPurchLine.ModifyAll("System-Created Entry", false);
    end;


    procedure StoreDocument()
    var
        lPurchHeaderArchive: Record "Purchase Header Archive";
        lArchiveManagement: Codeunit ArchiveManagement;
    begin
        if (PurchHeader."Document Type" <> PurchHeader."document type"::Order) or
           not lArchiveManagement.SalesDocArchiveGranule then
            exit;

        if not lPurchHeaderArchive.Get(PurchHeader."Document Type", PurchHeader."No.", PurchHeader."Doc. No. Occurrence", 1) then
            lArchiveManagement.StorePurchDocument(PurchHeader, false);
    end;


    procedure InitRequest(pPrintDoc: Boolean; pReceipt: Boolean)
    begin
        PrintDoc := pPrintDoc;
        ReceiptOnly := pReceipt;
    end;


    procedure fCheckAllItemStockJob(pPurchaseLine: Record "Purchase Line"): Boolean
    var
        lJob: Record Job;
        tNoStockJob: label 'de l''article %1 ne doit pas être de type %2 car une affaire de type %3 est renseignée en frais annexe';
        tNoJob: label 'n''est pas renseigné sur la ligne %1';
        lJobType: Text[30];
    begin
        //#8300\\
        //* Msg erreur si une des lignes n'est pas /affaire de Stock *
        if pPurchaseLine."dysJob No." = '' then
            exit(true);
        lJob.Get(pPurchaseLine."dysJob No.");
        lJobType := Format(lJob."Job Type");
        pPurchaseLine.SetRange("Document Type", pPurchaseLine."Document Type");
        pPurchaseLine.SetRange("Document No.", pPurchaseLine."Document No.");
        pPurchaseLine.SetRange(Type, pPurchaseLine.Type::Item);
        pPurchaseLine.SetFilter(Quantity, '<>0');
        if pPurchaseLine.Find('-') then begin
            repeat
                if lJob.Get(pPurchaseLine."dysJob No.") then begin
                    if not (lJob."Job Type" = lJob."job type"::Stock) then
                        pPurchaseLine.FieldError("dysJob No.", StrSubstNo(tNoStockJob, pPurchaseLine."No.", Format(lJob."Job Type"), lJobType))
                end else
                    pPurchaseLine.FieldError("dysJob No.", StrSubstNo(tNoJob, pPurchaseLine."Line No."));
            until pPurchaseLine.Next = 0;
        end;
        exit(true);
    end;


    procedure GetPurchTotalAmountToInvoice(var pPurchaseHEader: Record "Purchase Header"; var pPurchaseLine: Record "Purchase Line"; pInvoice: Boolean) Return: Decimal
    var
        lLineAmountToInvoice: Decimal;
    begin
        //#8939
        if pInvoice then begin
            pPurchaseLine.FindSet(false, false);
            Return := 0;
            repeat
                lLineAmountToInvoice := pPurchaseLine."Qty. to Invoice" * pPurchaseLine."Unit Cost";
                if pPurchaseLine."Line Discount %" <> 0 then
                    lLineAmountToInvoice := lLineAmountToInvoice * (100 - pPurchaseLine."Line Discount %") / 100;
                Return += lLineAmountToInvoice;
            until (pPurchaseLine.Next = 0);
            if Return < 0 then
                pPurchaseHEader."Vendor Cr. Memo No." := pPurchaseHEader."Vendor Invoice No.";
        end;
        //#8939//
    end;
}

