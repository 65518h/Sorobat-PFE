Codeunit 8003952 "Copy Document Further"
{
    // //#6115 Gestion


    trigger OnRun()
    begin
    end;

    var
        Text001: label 'Des commentaires existent déjà sur le doc. %1. Voulez-vous les supprimer au préalable ?';


    procedure wCopySalesCommentLine(var ToSalesHeader: Record "Sales Header"; FromDocType: Option; FromDocNo: Code[20])
    var
        lFromSalesCommentLine: Record "Sales Comment Line";
        lToSalesCommentLine: Record "Sales Comment Line";
        lLastLineNo: Integer;
        lDialog: Dialog;
    begin
        lFromSalesCommentLine.SetRange("Document Type", FromDocType);
        lFromSalesCommentLine.SetRange("No.", FromDocNo);
        if not (lFromSalesCommentLine.IsEmpty) then begin
            //#7069
            lToSalesCommentLine.SetRange("Document Type", ToSalesHeader."Document Type");
            lToSalesCommentLine.SetRange("No.", ToSalesHeader."No.");
            if not (lToSalesCommentLine.IsEmpty) then begin
                if Confirm(StrSubstNo(Text001, ToSalesHeader."No.")) then
                    lToSalesCommentLine.DeleteAll
                else begin
                    lToSalesCommentLine.FindLast;
                    lLastLineNo := lToSalesCommentLine."Line No.";
                end;
            end;
            lToSalesCommentLine.Reset;
            //#7069//
            lFromSalesCommentLine.Find('-');
            repeat
                lToSalesCommentLine := lFromSalesCommentLine;
                lToSalesCommentLine."Document Type" := ToSalesHeader."Document Type";
                lToSalesCommentLine."No." := ToSalesHeader."No.";
                //#7069
                lToSalesCommentLine."Line No." += lLastLineNo;
                //#7069//
                lToSalesCommentLine.Insert;
            until lFromSalesCommentLine.Next = 0;
        end;
    end;


    procedure wCopyPurchaseCommentLine(var ToPurchaseHeader: Record "Purchase Header"; var FromPurchaseHeader: Record "Purchase Header")
    var
        lFromPurchCommentLine: Record "Purch. Comment Line";
        lToPurchCommentLine: Record "Purch. Comment Line";
    begin
        lFromPurchCommentLine.SetRange("Document Type", FromPurchaseHeader."Document Type");
        lFromPurchCommentLine.SetRange("No.", FromPurchaseHeader."No.");
        if not (lFromPurchCommentLine.IsEmpty) then begin
            lFromPurchCommentLine.Find('-');
            repeat
                lToPurchCommentLine := lFromPurchCommentLine;
                lToPurchCommentLine."Document Type" := ToPurchaseHeader."Document Type";
                lToPurchCommentLine."No." := ToPurchaseHeader."No.";
                lToPurchCommentLine.Insert;
            until lFromPurchCommentLine.Next = 0;
        end;
    end;

    /* GL2024
        procedure wCopyDocDimArchToHeader(var pToSalesHeader: Record 36; pFromSalesHeaderArchive: Record 5107)
        var
            lDocDim: Record 357;
            lFromDocDim: Record 5106;
        begin
            lDocDim.SetRange("Table ID", Database::"Sales Header");
            lDocDim.SetRange("Document Type", pToSalesHeader."Document Type");
            lDocDim.SetRange("Document No.", pToSalesHeader."No.");
            lDocDim.SetRange("Line No.", 0);
            if not lDocDim.IsEmpty then
                lDocDim.DeleteAll;

            pToSalesHeader."Shortcut Dimension 1 Code" := pFromSalesHeaderArchive."Shortcut Dimension 1 Code";
            pToSalesHeader."Shortcut Dimension 2 Code" := pFromSalesHeaderArchive."Shortcut Dimension 2 Code";

            lFromDocDim.SetRange("Table ID", Database::"Sales Header");
            lFromDocDim.SetRange("Document Type", pFromSalesHeaderArchive."Document Type");
            lFromDocDim.SetRange("Document No.", pFromSalesHeaderArchive."No.");
            lFromDocDim.SetRange("Doc. No. Occurrence", pFromSalesHeaderArchive."Doc. No. Occurrence");
            lFromDocDim.SetRange("Version No.", pFromSalesHeaderArchive."Version No.");
            if not lFromDocDim.IsEmpty then begin
                lFromDocDim.Find('-');
                repeat
                    lDocDim.Init;
                    lDocDim."Table ID" := Database::"Sales Header";
                    lDocDim."Document Type" := pToSalesHeader."Document Type";
                    lDocDim."Document No." := pToSalesHeader."No.";
                    lDocDim."Line No." := 0;
                    lDocDim."Dimension Code" := lFromDocDim."Dimension Code";
                    lDocDim."Dimension Value Code" := lFromDocDim."Dimension Value Code";
                    lDocDim.Insert;
                until lFromDocDim.Next = 0;
            end;
        end;

    */
    procedure wCopyDescriptionToHeader(pToSalesHeader: Record "Sales Header"; pFromSalesHeader: Record "Sales Header")
    var
        lToDescrLine: Record "Description Line";
        lFromDescrLine: Record "Description Line";
    begin
        lToDescrLine.SetRange("Table ID", Database::"Sales Header");
        lToDescrLine.SetRange("Document Type", pToSalesHeader."Document Type");
        lToDescrLine.SetRange("Document No.", pToSalesHeader."No.");
        lToDescrLine.SetRange("Document Line No.", 0);
        if not lToDescrLine.IsEmpty then
            lToDescrLine.DeleteAll;

        lFromDescrLine.SetRange("Table ID", Database::"Sales Header");
        lFromDescrLine.SetRange("Document Type", pFromSalesHeader."Document Type");
        lFromDescrLine.SetRange("Document No.", pFromSalesHeader."No.");
        lFromDescrLine.SetRange("Document Line No.", 0);
        if not lFromDescrLine.IsEmpty then begin
            lFromDescrLine.Find('-');
            repeat
                lToDescrLine := lFromDescrLine;
                lToDescrLine."Document Type" := pToSalesHeader."Document Type";
                lToDescrLine."Document No." := pToSalesHeader."No.";
                lToDescrLine.Insert;
            until lFromDescrLine.Next = 0;
        end;
    end;


    procedure wCopyDescriptionArchToHeader(pToSalesHeader: Record "Sales Header"; pFromSalesHeaderArchive: Record "Sales Header Archive")
    var
        lToDescrLine: Record "Description Line";
        lFromDescrLineArchive: Record "Description Line Archive";
    begin
        lToDescrLine.SetRange("Table ID", Database::"Sales Header");
        lToDescrLine.SetRange("Document Type", pToSalesHeader."Document Type");
        lToDescrLine.SetRange("Document No.", pToSalesHeader."No.");
        lToDescrLine.SetRange("Document Line No.", 0);
        if not lToDescrLine.IsEmpty then
            lToDescrLine.DeleteAll;

        lFromDescrLineArchive.SetRange("Table ID", Database::"Sales Header");
        lFromDescrLineArchive.SetRange("Document Type", pFromSalesHeaderArchive."Document Type");
        lFromDescrLineArchive.SetRange("Document No.", pFromSalesHeaderArchive."No.");
        lFromDescrLineArchive.SetRange("Document Line No.", 0);
        lFromDescrLineArchive.SetRange("Doc. No. Occurrence", pFromSalesHeaderArchive."Doc. No. Occurrence");
        lFromDescrLineArchive.SetRange("Version No.", pFromSalesHeaderArchive."Version No.");
        if not lFromDescrLineArchive.IsEmpty then begin
            lFromDescrLineArchive.Find('-');
            repeat
                lToDescrLine.TransferFields(lFromDescrLineArchive);
                lToDescrLine."Document Type" := pToSalesHeader."Document Type";
                lToDescrLine."Document No." := pToSalesHeader."No.";
                lToDescrLine.Insert;
            until lFromDescrLineArchive.Next = 0;
        end;
    end;


    procedure wCopyContributorToHeader(pToSalesHeader: Record "Sales Header"; pFromSalesHeader: Record "Sales Header")
    var
        lFromSalesContributor: Record "Sales Contributor";
        lToSalesContributor: Record "Sales Contributor";
    begin
        lToSalesContributor.SetRange("Document Type", pToSalesHeader."Document Type");
        lToSalesContributor.SetRange("Document No.", pToSalesHeader."No.");
        if not lToSalesContributor.IsEmpty then
            lToSalesContributor.DeleteAll;

        lFromSalesContributor.SetRange("Document Type", pFromSalesHeader."Document Type");
        lFromSalesContributor.SetRange("Document No.", pFromSalesHeader."No.");
        if not lFromSalesContributor.IsEmpty then begin
            lFromSalesContributor.Find('-');
            repeat
                lToSalesContributor.TransferFields(lFromSalesContributor);
                lToSalesContributor."Document Type" := pToSalesHeader."Document Type";
                lToSalesContributor."Document No." := pToSalesHeader."No.";
                lToSalesContributor.Insert;
            until lFromSalesContributor.Next = 0;
        end;
    end;


    procedure wCopyContributorArchToHeader(pToSalesHeader: Record "Sales Header"; pFromSalesHeaderArchive: Record "Sales Header Archive")
    var
        lFromSalesContributorArchive: Record "Sales Contributor Archive";
        lToSalesContributor: Record "Sales Contributor";
    begin
        lToSalesContributor.SetRange("Document Type", pToSalesHeader."Document Type");
        lToSalesContributor.SetRange("Document No.", pToSalesHeader."No.");
        if not lToSalesContributor.IsEmpty then
            lToSalesContributor.DeleteAll;

        lFromSalesContributorArchive.SetRange("Document Type", pFromSalesHeaderArchive."Document Type");
        lFromSalesContributorArchive.SetRange("Document No.", pFromSalesHeaderArchive."No.");
        lFromSalesContributorArchive.SetRange("Doc. No. Occurrence", pFromSalesHeaderArchive."Doc. No. Occurrence");
        lFromSalesContributorArchive.SetRange("Version No.", pFromSalesHeaderArchive."Version No.");
        if not lFromSalesContributorArchive.IsEmpty then begin
            lFromSalesContributorArchive.Find('-');
            repeat
                lToSalesContributor.TransferFields(lFromSalesContributorArchive);
                lToSalesContributor."Document Type" := pToSalesHeader."Document Type";
                lToSalesContributor."Document No." := pToSalesHeader."No.";
                lToSalesContributor.Insert;
            until lFromSalesContributorArchive.Next = 0;
        end;
    end;


    procedure wCopyBillOfQtyToHeader(pToSalesHeader: Record "Sales Header"; pFromSalesHeader: Record "Sales Header"; pIncludeHeader: Boolean; var pBOQMgt: Codeunit "BOQ Management"; var pBOQFromOk: Boolean) return: Boolean
    var
        lFromOwnerRef: RecordRef;
        lFromrRef: RecordRef;
        lToOwnerRef: RecordRef;
        lToRef: RecordRef;
        lBOQMgt: Codeunit "BOQ Management";
        lBOQCustMgt: Codeunit "BOQ Custom Management";
    begin
        //#6115
        /*
        lFromOwnerRef.GETTABLE(pFromSalesHeader);
        return := lBOQMgt.Load(lFromOwnerRef.RECORDID);
        lToOwnerRef.GETTABLE(pToSalesHeader);
        IF pIncludeHeader THEN
          lBOQCustMgt.gOndelete(lToOwnerRef,TRUE);
        
        IF NOT return THEN
          EXIT;
        
        IF pIncludeHeader THEN BEGIN
          lBOQMgt.Finalize();
          lBOQMgt.Initialize();
          lBOQMgt.AddHeader(lToOwnerRef.RECORDID);
          lBOQMgt.Save('');
        END;
        lBOQMgt.CopyBOQFrom(lFromOwnerRef.RECORDID,lFromOwnerRef.RECORDID,lToOwnerRef.RECORDID,lToOwnerRef.RECORDID,NOT pIncludeHeader);
        */
        //#6115//
        //#7202
        lFromOwnerRef.GetTable(pFromSalesHeader);
        pBOQFromOk := pBOQMgt.Load(lFromOwnerRef.RecordId);
        lToOwnerRef.GetTable(pToSalesHeader);
        if pIncludeHeader then begin
            lBOQCustMgt.gOndelete(lToOwnerRef, true);
            //On duplique
            return := lBOQCustMgt.gDuplicateBOQXMLDoc(lFromOwnerRef, lToOwnerRef);
            return := pBOQMgt.Load(lToOwnerRef.RecordId);
            // Puis on substitue l'entete
            pBOQMgt.fSearchReplaceAttValue(Format(lFromOwnerRef.RecordId), Format(lToOwnerRef.RecordId), 'Node', 'RecordID');
        end else begin
            return := pBOQMgt.Load(lToOwnerRef.RecordId);
            if (not return) then begin
                lBOQCustMgt.gLoadSalesBOQ(pToSalesHeader);
                return := pBOQMgt.Load(lToOwnerRef.RecordId);
            end;
            // On copie l'integralite des lignes du doc de reference
            //pBOQMgt.CopyBOQFrom(lFromOwnerRef.RECORDID,lFromOwnerRef.RECORDID,lToOwnerRef.RECORDID,lToOwnerRef.RECORDID,NOT pIncludeHeader);
            return := pBOQMgt.AddBOQFrom(lFromOwnerRef.RecordId, lFromOwnerRef.RecordId, lToOwnerRef.RecordId, lToOwnerRef.RecordId);
        end;
        //#7202//

    end;


    procedure wCopyBillOfQtyArchToHeader(pToSalesHeader: Record "Sales Header"; pFromSalesHeaderArchive: Record "Sales Header Archive"; pIncludeHeader: Boolean; var pBOQMgt: Codeunit "BOQ Management"; var pBOQFrom: Boolean) return: Boolean
    var
        lFromOwnerRef: RecordRef;
        lFromrRef: RecordRef;
        lToOwnerRef: RecordRef;
        lToRef: RecordRef;
        lBOQMgt: Codeunit "BOQ Management";
        lBOQCustMgt: Codeunit "BOQ Custom Management";
    begin
        /*
        //#6115
        lFromOwnerRef.GETTABLE(pFromSalesHeaderArchive);
        return := lBOQMgt.Load(lFromOwnerRef.RECORDID);
        lToOwnerRef.GETTABLE(pToSalesHeader);
        IF pIncludeHeader THEN
          lBOQCustMgt.gOndelete(lToOwnerRef,TRUE);
        
        IF NOT return THEN
          EXIT;
        
        IF pIncludeHeader THEN BEGIN
          lBOQMgt.Finalize();
          lBOQMgt.Initialize();
          lBOQMgt.AddHeader(lToOwnerRef.RECORDID);
          lBOQMgt.Save('');
        END;
        lBOQMgt.CopyBOQFrom(lFromOwnerRef.RECORDID,lFromOwnerRef.RECORDID,lToOwnerRef.RECORDID,lToOwnerRef.RECORDID,NOT pIncludeHeader);
        //#6115//
        */
        //#7202
        lFromOwnerRef.GetTable(pFromSalesHeaderArchive);
        pBOQFrom := pBOQMgt.Load(lFromOwnerRef.RecordId);
        lToOwnerRef.GetTable(pToSalesHeader);
        if pIncludeHeader then begin
            lBOQCustMgt.gOndelete(lToOwnerRef, true);
            //On duplique
            return := lBOQCustMgt.gDuplicateBOQXMLDoc(lFromOwnerRef, lToOwnerRef);
            pBOQMgt.Load(lToOwnerRef.RecordId);
            // Puis on substitue l'entete
            pBOQMgt.fSearchReplaceAttValue(Format(lFromOwnerRef.RecordId), Format(lToOwnerRef.RecordId), 'Node', 'RecordID');
        end else begin
            pBOQMgt.Load(lToOwnerRef.RecordId);
            if (not return) then begin
                lBOQCustMgt.gLoadSalesBOQ(pToSalesHeader);
                return := pBOQMgt.Load(lToOwnerRef.RecordId);
            end;
            // On copie l'integralite des lignes du doc de reference
            //pBOQMgt.CopyBOQFrom(lFromOwnerRef.RECORDID,lFromOwnerRef.RECORDID,lToOwnerRef.RECORDID,lToOwnerRef.RECORDID,NOT pIncludeHeader);
            return := pBOQMgt.AddBOQFrom(lFromOwnerRef.RecordId, lFromOwnerRef.RecordId, lToOwnerRef.RecordId, lToOwnerRef.RecordId);
        end;
        //#7202//

    end;


    procedure wCopyBillOfQtyToLine(pToSalesHeader: Record "Sales Header"; pToSalesLine: Record "Sales Line"; pFromSalesHeader: Record "Sales Header"; pFromSalesLine: Record "Sales Line"; pExist: Boolean; var pBOQMgt: Codeunit "BOQ Management")
    var
        lFromOwnerRef: RecordRef;
        lFromrRef: RecordRef;
        lToOwnerRef: RecordRef;
        lToRef: RecordRef;
        lBOQMgt: Codeunit "BOQ Management";
        lBOQExist: Boolean;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
        lFatherRef: RecordRef;
    begin
        /*
        //#7069
        IF pFromSalesLine."Line Type" = pFromSalesLine."Line Type"::" " THEN
          EXIT;
        //#7069//
        lToOwnerRef.GETTABLE(pToSalesHeader);
        lToRef.GETTABLE(pToSalesLine);
        IF lBOQMgt.Load(lToOwnerRef.RECORDID) THEN BEGIN
          lBOQCustMgt.gOnInsert(lToRef);
          lBOQMgt.Save('');
        END;
        IF NOT pExist THEN
          EXIT;
        //#6115
        lFromOwnerRef.GETTABLE(pFromSalesHeader);
        lFromrRef.GETTABLE(pFromSalesLine);
        lBOQMgt.CopyBOQFrom(lFromOwnerRef.RECORDID,lFromrRef.RECORDID,lToOwnerRef.RECORDID,lToRef.RECORDID,FALSE);
        //#6115//
        */
        //#7202
        if pFromSalesLine."Line Type" = pFromSalesLine."line type"::" " then
            exit;
        //#7069//
        lToOwnerRef.GetTable(pToSalesHeader);
        lToRef.GetTable(pToSalesLine);
        lFromOwnerRef.GetTable(pFromSalesHeader);
        lFromrRef.GetTable(pFromSalesLine);
        if (not pBOQMgt.fSearchReplaceAttValue(Format(lFromrRef.RecordId), Format(lToRef.RecordId), 'Node', 'RecordID')) then begin
            lBOQCustMgt.gGetFatherNode(lToRef, lFatherRef);
            pBOQMgt.AppendNodeAt(lFatherRef.RecordId, lToRef.RecordId);
            //lBOQCustMgt.gOnInsert(lToRef);
            pBOQMgt.CopyBOQFrom(lFromOwnerRef.RecordId, lFromrRef.RecordId, lToOwnerRef.RecordId, lToRef.RecordId, false);
        end;
        if not pExist then
            pBOQMgt.DeleteAllContains(lToRef.RecordId);
        //#7202//

    end;


    procedure wCopyBillOfQtyArchToLine(pToSalesHeader: Record "Sales Header"; pToSalesLine: Record "Sales Line"; pFromSalesHeaderArchive: Record "Sales Header Archive"; pFromSalesLineArchive: Record "Sales Line Archive"; pExist: Boolean; var pBOQMgt: Codeunit "BOQ Management")
    var
        lFromOwnerRef: RecordRef;
        lFromrRef: RecordRef;
        lToOwnerRef: RecordRef;
        lToRef: RecordRef;
        lBOQMgt: Codeunit "BOQ Management";
        lBOQExist: Boolean;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
        lFatherRef: RecordRef;
    begin
        /*
        lToOwnerRef.GETTABLE(pToSalesHeader);
        lToRef.GETTABLE(pToSalesLine);
        IF lBOQMgt.Load(lToOwnerRef.RECORDID) THEN BEGIN
          lBOQCustMgt.gOnInsert(lToRef);
          lBOQMgt.Save('');
        END;
        IF NOT pExist THEN
          EXIT;
        //#6115
        lFromOwnerRef.GETTABLE(pFromSalesHeaderArchive);
        lFromrRef.GETTABLE(pFromSalesLineArchive);
        lBOQMgt.CopyBOQFrom(lFromOwnerRef.RECORDID,lFromrRef.RECORDID,lToOwnerRef.RECORDID,lToRef.RECORDID,FALSE);
        //#6115//
        */
        //#7202
        lToOwnerRef.GetTable(pToSalesHeader);
        lToRef.GetTable(pToSalesLine);
        lFromOwnerRef.GetTable(pFromSalesHeaderArchive);
        lFromrRef.GetTable(pFromSalesLineArchive);
        if (not pBOQMgt.fSearchReplaceAttValue(Format(lFromrRef.RecordId), Format(lToRef.RecordId), 'Node', 'RecordID')) then begin
            lBOQCustMgt.gGetFatherNode(lToRef, lFatherRef);
            pBOQMgt.AppendNodeAt(lFatherRef.RecordId, lToRef.RecordId);
            pBOQMgt.CopyBOQFrom(lFromOwnerRef.RecordId, lFromrRef.RecordId, lToOwnerRef.RecordId, lToRef.RecordId, false);
        end;
        if not pExist then
            pBOQMgt.DeleteAllContains(lToRef.RecordId);
        //#7202//

    end;


    procedure wCopySheldulerToHeader(pToSalesHeader: Record "Sales Header"; pFromSalesHeader: Record "Sales Header")
    var
        lToScheduler: Record "Invoice Scheduler";
        lFromScheduler: Record "Invoice Scheduler";
    begin
        lToScheduler.SetRange("Sales Header Doc. Type", pToSalesHeader."Document Type");
        lToScheduler.SetRange("Sales Header Doc. No.", pToSalesHeader."No.");
        if not lToScheduler.IsEmpty then
            lToScheduler.DeleteAll;

        lFromScheduler.SetRange("Sales Header Doc. Type", pFromSalesHeader."Document Type");
        lFromScheduler.SetRange("Sales Header Doc. No.", pFromSalesHeader."No.");
        if not lFromScheduler.IsEmpty then begin
            lFromScheduler.Find('-');
            repeat
                lToScheduler.TransferFields(lFromScheduler);
                lToScheduler."Sales Header Doc. Type" := pToSalesHeader."Document Type";
                lToScheduler."Sales Header Doc. No." := pToSalesHeader."No.";
                Clear(lToScheduler."Forecast Date");
                Clear(lToScheduler."Due Date");
                Clear(lToScheduler."Amount Emitted");
                Clear(lToScheduler."Amount to Emit");
                Clear(lToScheduler."Amount Emitted (LCY)");
                Clear(lToScheduler."Amount to Emit (LCY)");
                Clear(lToScheduler.Invoice);
                Clear(lToScheduler."Posted Doc. type");
                Clear(lToScheduler."Posted Doc. No.");
                lToScheduler.Insert;
            until lFromScheduler.Next = 0;
        end;
    end;


    procedure wCopySheldulerArchToHeader(pToSalesHeader: Record "Sales Header"; pFromSalesHeaderArchive: Record "Sales Header Archive")
    var
        lToScheduler: Record "Invoice Scheduler";
        lFromSchedulerArchive: Record "Invoice Scheduler Archive";
    begin
        lToScheduler.SetRange("Sales Header Doc. Type", pToSalesHeader."Document Type");
        lToScheduler.SetRange("Sales Header Doc. No.", pToSalesHeader."No.");
        if not lToScheduler.IsEmpty then
            lToScheduler.DeleteAll;

        lFromSchedulerArchive.SetRange("Sales Header Doc. Type", pFromSalesHeaderArchive."Document Type");
        lFromSchedulerArchive.SetRange("Sales Header Doc. No.", pFromSalesHeaderArchive."No.");
        lFromSchedulerArchive.SetRange("Doc. No. Occurrence", pFromSalesHeaderArchive."Doc. No. Occurrence");
        lFromSchedulerArchive.SetRange("Version No.", pFromSalesHeaderArchive."Version No.");
        if not lFromSchedulerArchive.IsEmpty then begin
            lFromSchedulerArchive.Find('-');
            repeat
                lToScheduler.TransferFields(lFromSchedulerArchive);
                lToScheduler."Sales Header Doc. Type" := pToSalesHeader."Document Type";
                lToScheduler."Sales Header Doc. No." := pToSalesHeader."No.";
                Clear(lToScheduler."Forecast Date");
                Clear(lToScheduler."Due Date");
                Clear(lToScheduler."Amount Emitted");
                Clear(lToScheduler."Amount to Emit");
                Clear(lToScheduler."Amount Emitted (LCY)");
                Clear(lToScheduler."Amount to Emit (LCY)");
                Clear(lToScheduler.Invoice);
                Clear(lToScheduler."Posted Doc. type");
                Clear(lToScheduler."Posted Doc. No.");
                lToScheduler.Insert;
            until lFromSchedulerArchive.Next = 0;
        end;
    end;


    procedure wCopyOverheadToHeader(pToSalesHeader: Record "Sales Header"; pFromSalesHeader: Record "Sales Header")
    var
        lToOverHead: Record "Sales Overhead-Margin";
        lFromOverHead: Record "Sales Overhead-Margin";
    begin
        lToOverHead.SetRange("Document Type", pToSalesHeader."Document Type");
        lToOverHead.SetRange("Document No.", pToSalesHeader."No.");
        if not lToOverHead.IsEmpty then
            lToOverHead.DeleteAll;

        lFromOverHead.SetRange("Document Type", pFromSalesHeader."Document Type");
        lFromOverHead.SetRange("Document No.", pFromSalesHeader."No.");
        if not lFromOverHead.IsEmpty then begin
            lFromOverHead.Find('-');
            repeat
                lToOverHead.TransferFields(lFromOverHead, false);
                lToOverHead."Document Type" := pToSalesHeader."Document Type";
                lToOverHead."Document No." := pToSalesHeader."No.";
                lToOverHead."Gen. Prod. Post. Code" := lFromOverHead."Gen. Prod. Post. Code";
                lToOverHead.Insert;
            until lFromOverHead.Next = 0;
            Codeunit.Run(Codeunit::"Overhead Calculation", pToSalesHeader);
        end;
    end;


    procedure wCopyOverheadArchToHeader(pToSalesHeader: Record "Sales Header"; pFromSalesHeaderArchive: Record "Sales Header Archive")
    var
        lToOverHead: Record "Sales Overhead-Margin";
        lFromOverHeadArch: Record "Sales Overhead-Margin Archive";
    begin
        lToOverHead.SetRange("Document Type", pToSalesHeader."Document Type");
        lToOverHead.SetRange("Document No.", pToSalesHeader."No.");
        if not lToOverHead.IsEmpty then
            lToOverHead.DeleteAll;

        lFromOverHeadArch.SetRange("Document Type", pFromSalesHeaderArchive."Document Type");
        lFromOverHeadArch.SetRange("Document No.", pFromSalesHeaderArchive."No.");
        lFromOverHeadArch.SetRange("Doc. No. Occurrence", pFromSalesHeaderArchive."Doc. No. Occurrence");
        lFromOverHeadArch.SetRange("Version No.", pFromSalesHeaderArchive."Version No.");
        lFromOverHeadArch.SetRange(Type, lFromOverHeadArch.Type::Overhead, lFromOverHeadArch.Type::Margin);
        if not lFromOverHeadArch.IsEmpty then begin
            lFromOverHeadArch.Find('-');
            repeat
                if not lToOverHead.Get(pToSalesHeader."Document Type", pToSalesHeader."No.", lFromOverHeadArch."No.") then begin
                    lToOverHead."Document Type" := pToSalesHeader."Document Type";
                    lToOverHead."Document No." := pToSalesHeader."No.";
                    lToOverHead."Gen. Prod. Post. Code" := lFromOverHeadArch."No.";
                end;
                if lFromOverHeadArch.Type = lFromOverHeadArch.Type::Overhead then begin
                    lToOverHead.Overhead := lFromOverHeadArch.Value;
                    lToOverHead."Rule Overhead" := lFromOverHeadArch."Rule Value";
                    lToOverHead."Calculation Method Margin" := lFromOverHeadArch."Calculation Method";
                end else begin
                    lToOverHead.Margin := lFromOverHeadArch.Value;
                    lToOverHead."Rule Margin" := lFromOverHeadArch."Rule Value";
                    lToOverHead."Calculation Method Margin" := lFromOverHeadArch."Calculation Method";
                end;
                if not lToOverHead.Insert then
                    lToOverHead.Modify;
            until lFromOverHeadArch.Next = 0;
            Codeunit.Run(Codeunit::"Overhead Calculation", pToSalesHeader);
        end;
    end;


    procedure wDeleteDescriptionFromLine(pTableID: Integer; pDocType: Option; pDocNo: Code[20]; pDocLineNo: Integer)
    var
        lToDescrLine: Record "Description Line";
    begin
        lToDescrLine.SetRange("Table ID", pTableID);
        lToDescrLine.SetRange("Document Type", pDocType);
        lToDescrLine.SetRange("Document No.", pDocNo);
        lToDescrLine.SetRange("Document Line No.", pDocLineNo);
        if not lToDescrLine.IsEmpty then
            lToDescrLine.DeleteAll;
    end;


    procedure wCopyDescriptionToLine(pToSalesLine: Record "Sales Line"; pFromSalesLine: Record "Sales Line")
    var
        lToDescrLine: Record "Description Line";
        lFromDescrLine: Record "Description Line";
    begin
        lFromDescrLine.SetRange("Table ID", Database::"Sales Line");
        lFromDescrLine.SetRange("Document Type", pFromSalesLine."Document Type");
        lFromDescrLine.SetRange("Document No.", pFromSalesLine."Document No.");
        lFromDescrLine.SetRange("Document Line No.", pFromSalesLine."Line No.");
        if not lFromDescrLine.IsEmpty then begin
            lFromDescrLine.Find('-');
            repeat
                lToDescrLine := lFromDescrLine;
                lToDescrLine."Document Type" := pToSalesLine."Document Type";
                lToDescrLine."Document No." := pToSalesLine."Document No.";
                lToDescrLine."Document Line No." := pToSalesLine."Line No.";
                lToDescrLine.Insert;
            until lFromDescrLine.Next = 0;
        end;
    end;


    procedure wCopyDescriptionArchToLine(pToSalesLine: Record "Sales Line"; pFromSalesLine: Record "Sales Line"; pDocOcc: Integer; pVersion: Integer)
    var
        lToDescrLine: Record "Description Line";
        lFromDescrLineArchive: Record "Description Line Archive";
    begin
        lFromDescrLineArchive.SetRange("Table ID", Database::"Sales Line");
        lFromDescrLineArchive.SetRange("Document Type", pFromSalesLine."Document Type");
        lFromDescrLineArchive.SetRange("Document No.", pFromSalesLine."Document No.");
        lFromDescrLineArchive.SetRange("Doc. No. Occurrence", pDocOcc);
        lFromDescrLineArchive.SetRange("Version No.", pVersion);
        lFromDescrLineArchive.SetRange("Document Line No.", pFromSalesLine."Line No.");
        if not lFromDescrLineArchive.IsEmpty then begin
            lFromDescrLineArchive.Find('-');
            repeat
                lToDescrLine.TransferFields(lFromDescrLineArchive);
                lToDescrLine."Document Type" := pToSalesLine."Document Type";
                lToDescrLine."Document No." := pToSalesLine."Document No.";
                lToDescrLine."Document Line No." := pToSalesLine."Line No.";
                lToDescrLine.Insert;
            until lFromDescrLineArchive.Next = 0;
        end;
    end;


    procedure wDeleteJobCostFromLine(pDocType: Option; pDocNo: Code[20]; pDocLineNo: Integer)
    var
        lToJobCostAssgnt: Record "Job Cost Assignment";
    begin
        lToJobCostAssgnt.SetRange("Document Type", pDocType);
        lToJobCostAssgnt.SetRange("Document No.", pDocNo);
        lToJobCostAssgnt.SetRange("Document Line No.", pDocLineNo);
        if not lToJobCostAssgnt.IsEmpty then
            lToJobCostAssgnt.DeleteAll;
    end;


    procedure wInsertJobCostAssignment(var TmpJobCostAssignment: Record "Job Cost Assignment")
    var
        lToJobCostAssignment: Record "Job Cost Assignment";
    begin
        with lToJobCostAssignment do begin
            TmpJobCostAssignment.Reset;
            if not TmpJobCostAssignment.IsEmpty then begin
                if TmpJobCostAssignment.Find('-') then
                    repeat
                        TransferFields(TmpJobCostAssignment);
                        "Document Line No." := TmpJobCostAssignment."To New doc. line No.";
                        "Applies-to Doc. Line No." := TmpJobCostAssignment."To New Applies-to Line No.";
                        Clear("To New doc. line No.");
                        Clear("To New Applies-to Line No.");
                        //#6293
                        if ("Document Line No." <> 0) or ("Applies-to Doc. Line No." <> 0) then
                            //#6293//
                            Insert;
                    until TmpJobCostAssignment.Next = 0;
                TmpJobCostAssignment.DeleteAll;
            end;
        end;
    end;


    procedure wAssignJobCostAssignment(var pToJobCostAssign: Record "Job Cost Assignment"; pFromSalesLine: Record "Sales Line"; pToSalesLine: Record "Sales Line")
    begin
        with pToJobCostAssign do begin
            if (pToSalesLine."Structure Line No." = 0) and (pToSalesLine.Type <> pToSalesLine.Type::" ") then
                if pFromSalesLine."Assignment Method" = pFromSalesLine."assignment method"::Selection then begin
                    Reset;
                    SetRange("Document Type", pToSalesLine."Document Type");
                    SetRange("Document No.", pToSalesLine."Document No.");
                    SetRange("Document Line No.", pFromSalesLine."Line No.");
                    if not IsEmpty then
                        ModifyAll("To New doc. line No.", pToSalesLine."Line No.");
                end else begin
                    Reset;
                    SetCurrentkey("Document Type", "Document No.", "Applies-to Doc. Line No.");
                    SetRange("Document Type", pToSalesLine."Document Type");
                    SetRange("Document No.", pToSalesLine."Document No.");
                    SetRange("Applies-to Doc. Line No.", pFromSalesLine."Line No.");
                    if not IsEmpty then
                        ModifyAll("To New Applies-to Line No.", pToSalesLine."Line No.");
                end;
        end;
    end;
}

