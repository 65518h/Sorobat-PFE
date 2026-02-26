Codeunit 8004141 "Planning RecordID Mgt"
{
    // #8108 XPE 02/08/2011 Modification de la fonction SalesQuotetoOrderLine
    // //PLANNING_TASK CW 26/07/09


    trigger OnRun()
    begin
    end;

    var
        tConfirm: label 'This task is already linked to %1 %2';
        tReplace: label 'Do you want to replace this source element.';
        SalesHeader: Record "Sales Header";
        Job: Record Job;


    procedure Lookup(var pRec: Record "Planning Line")
    var
        lRecordID: RecordID;
        lRecordRef: RecordRef;
        ltStrMenu: label 'Quote,Order';
        lSalesHeader: Record "Sales Header";
        lMenuOption: Integer;
    begin
        lRecordID := pRec."Source Record ID";
        if lRecordID.TableNo <> 0 then
            if not Confirm(tConfirm + '\' + tReplace, false) then
                exit;

        lMenuOption := StrMenu(ltStrMenu);
        case lMenuOption of
            0:
                exit;
            1, 2:
                begin
                    case lMenuOption of
                        1:
                            lSalesHeader.SetRange("Document Type", lSalesHeader."document type"::Quote);
                        2:
                            lSalesHeader.SetRange("Document Type", lSalesHeader."document type"::Order);
                    end;
                    if Page.RunModal(Page::"Sales List", lSalesHeader) = Action::LookupOK then begin
                        lRecordRef.GetTable(lSalesHeader);
                        //??      pRec."Job No." := lSalesHeader."Job No.";
                    end else
                        exit;
                end;
        end;

        pRec."Source Record ID" := lRecordRef.RecordId;
        pRec.Modify;
    end;


    procedure Show(pRecordID: RecordID)
    var
        lRecordRef: RecordRef;
    begin
        if pRecordID.TableNo = 0 then
            exit;
        lRecordRef.Get(pRecordID);
        case lRecordRef.Number of
            Database::"Sales Header":
                begin
                    lRecordRef.SetTable(SalesHeader);
                    case SalesHeader."Document Type" of
                        SalesHeader."document type"::Quote:
                            Page.RunModal(Page::"Sales Quote", SalesHeader);
                        SalesHeader."document type"::Order:
                            Page.RunModal(Page::"Sales Order", SalesHeader);
                    end;
                end;
        end;
    end;


    procedure Caption(pRecordID: RecordID): Text[250]
    var
        lRecordRef: RecordRef;
    begin
        if pRecordID.TableNo = 0 then
            exit;
        lRecordRef.Get(pRecordID);
        case lRecordRef.Number of
            Database::"Sales Header":
                begin
                    lRecordRef.SetTable(SalesHeader);
                    with SalesHeader do
                        exit(Format("Document Type") + ' ' + "No." + ' ' + "Sell-to Customer Name");
                end;
        end;
    end;


    procedure Suggest(pRecordID: RecordID): Boolean
    var
    //GL2024 NAVIBAT    lPlanSalesHeader: Report 8004141;
    begin
        case pRecordID.TableNo of
            Database::"Sales Header":
                begin
                    //GL2024 NAVIBAT     lPlanSalesHeader.InitRequest(pRecordID);
                    //GL2024 NAVIBAT    lPlanSalesHeader.RunModal;
                    //GL2024 NAVIBAT     exit(lPlanSalesHeader.Done);
                end;
        end;
    end;


    procedure SalesQuoteToOrder(var pQuoteHeader: Record "Sales Header"; pOrderHeader: Record "Sales Header")
    var
        lPlanningHeader: Record "Planning Header";
        lPlanningLine: Record "Planning Line";
        lPlanningLine2: Record "Planning Line";
        lQuoteRecordRef: RecordRef;
        lOrderRecordRef: RecordRef;
        lPlanningEntry: Record "Planning Entry";
        lPlanningEntry2: Record "Planning Entry";
        lHeaderNo: Code[20];
        lWBSEcart: Integer;
        lWBSManagement: Codeunit "WBS Management";
    begin
        lQuoteRecordRef.GetTable(pQuoteHeader);
        lOrderRecordRef.GetTable(pOrderHeader);
        //#8459
        //+BAT+ Gestion des avenants
        lPlanningHeader.SetRange("Source Record ID", lOrderRecordRef.RecordId);
        if lPlanningHeader.FindFirst and (pQuoteHeader."Rider to Order No." <> '') then begin
            lHeaderNo := lPlanningHeader."No.";
            lPlanningLine.SetRange("Project Header No.", lPlanningHeader."No.");
            if not lPlanningLine.FindLast then
                lWBSEcart := 0
            else begin
                if lPlanningLine.Indentation = 1 then
                    Evaluate(lWBSEcart, lPlanningLine."WBS Code")
                else
                    Evaluate(lWBSEcart, CopyStr(lPlanningLine."WBS Code", 1, StrPos(lPlanningLine."WBS Code", '.') - 1));
            end;
            lPlanningLine.Reset;
        end;
        lPlanningHeader.Reset;
        //+BAT+ Gestion des avenants//

        lPlanningHeader.SetRange("Source Record ID", lQuoteRecordRef.RecordId);
        if not lPlanningHeader.IsEmpty then begin
            lPlanningHeader.FindSet;
            repeat
                lPlanningHeader."Job No." := pOrderHeader."Job No.";
                lPlanningHeader.Type := lPlanningHeader.Type::Scheduled;
                lPlanningHeader."Source Record ID" := lOrderRecordRef.RecordId;
                lPlanningHeader.Modify;

                lPlanningEntry.SetRange("Project Header No.", lPlanningHeader."No.");
                lPlanningEntry.SetRange(Status, lPlanningEntry.Status::Suggested);
                if lPlanningEntry.FindSet(true, false) then
                    repeat
                        lPlanningEntry2.Get(lPlanningEntry."Entry No.");
                        lPlanningEntry2.Status := lPlanningEntry2.Status::Confirm;
                        lPlanningEntry2.Modify;
                    until lPlanningEntry.Next = 0;
            until lPlanningHeader.Next = 0;
        end;
        lPlanningLine.Reset;
        lPlanningLine.SetRange("Source Record ID", lQuoteRecordRef.RecordId);

        if lHeaderNo = '' then begin
            if not lPlanningLine.IsEmpty then
                lPlanningLine.ModifyAll("Source Record ID", lOrderRecordRef.RecordId);
            //+BAT+ Gestion des avenants
        end else begin
            lPlanningLine.SetRange("Source Record ID");
            lPlanningLine.SetRange("Project Header No.", lPlanningHeader."No.");
            if not lPlanningLine.IsEmpty then begin
                lPlanningLine.FindSet;
                repeat
                    lPlanningLine."Source Record ID" := lOrderRecordRef.RecordId;
                    lPlanningLine."Project Header No." := lHeaderNo;
                    lPlanningLine.Validate("WBS Code",
                          lWBSManagement.fIncWBS(lPlanningLine."WBS Code", lPlanningLine.Indentation, 1, lWBSEcart));
                    lPlanningLine.Modify;
                until lPlanningLine.Next = 0;
            end;
            lPlanningHeader.Delete;
        end;
        //+BAT+ Gestion des avenants//
    end;


    procedure SalesQuoteLineToOrderLine(pFromRecRef: RecordRef; pToRecRef: RecordRef; pFromRecRefLine: RecordRef; pToRecRefLine: RecordRef; var pLinkSourceIDBuffer: Record "Planning Link Source ID Buffer")
    var
        lPlanningLine: Record "Planning Line";
        lPlanningLinkSourceID: Record "Planning Link Source ID";
        lFromLineNo: Integer;
        lToLineNo: Integer;
        lFieldLineNo: Integer;
        lFieldJobNo: Integer;
        lFieldJobTaskNo: Integer;
        lSalesLine: Record "Sales Line";
        lFromJobJnlLine: Record "Job Journal Line";
        lToJobJnlLine: Record "Job Journal Line";
        lFromResLedgEntry: Record "Res. Ledger Entry";
        lToResLedgEntry: Record "Res. Ledger Entry";
        lFromResJnlLine: Record "Res. Journal Line";
        lToResJnlLine: Record "Res. Journal Line";
    begin
        case pFromRecRef.RecordId.TableNo of
            Database::"Sales Header":
                begin
                    lFieldLineNo := lSalesLine.FieldNo("Line No.");
                    lFieldJobNo := lSalesLine.FieldNo("Job No.");
                    lFieldJobTaskNo := lSalesLine.FieldNo("Job Task No.");
                end;
        end;
        Evaluate(lFromLineNo, Format(pFromRecRefLine.Field(lFieldLineNo).Value));
        Evaluate(lToLineNo, Format(pToRecRefLine.Field(lFieldLineNo).Value));

        pLinkSourceIDBuffer.SetFilter("Source Record ID", Format(pFromRecRef.RecordId));
        pLinkSourceIDBuffer.SetRange("Source Line No.", lFromLineNo);

        if not pLinkSourceIDBuffer.IsEmpty then begin
            pLinkSourceIDBuffer.FindSet(true, true);
            repeat
                lPlanningLine.Get(pLinkSourceIDBuffer."Planning Task No.");
                lPlanningLine."Source Record ID" := pToRecRef.RecordId;
                lPlanningLine.Modify;
                if lFieldJobNo <> 0 then
                    lPlanningLine."Job No." := Format(pToRecRefLine.Field(lFieldJobNo).Value);
                if (lPlanningLine."Job Task No." = '') and (lFieldJobTaskNo <> 0) then
                    lPlanningLine."Job Task No." := Format(pToRecRefLine.Field(lFieldJobTaskNo).Value);
                lPlanningLine.Modify;

                lPlanningLinkSourceID."Planning Task No." := pLinkSourceIDBuffer."Planning Task No.";
                lPlanningLinkSourceID."Source Line No." := lToLineNo;
                lPlanningLinkSourceID."Task Load Purcent" := pLinkSourceIDBuffer."Task Load %";
                lPlanningLinkSourceID.Insert;
            until pLinkSourceIDBuffer.Next = 0;
        end;

        lFromJobJnlLine.SetFilter("Source Record ID", Format(pFromRecRef.RecordId));
        lFromJobJnlLine.SetRange("Source Line No.", lFromLineNo);
        if not lFromJobJnlLine.IsEmpty then begin
            lFromJobJnlLine.FindSet(false, false);
            repeat
                lToJobJnlLine.Get(lFromJobJnlLine."Journal Template Name", lFromJobJnlLine."Journal Batch Name", lFromJobJnlLine."Line No.");
                lToJobJnlLine."Source Record ID" := pToRecRef.RecordId;
                lToJobJnlLine."Source Line No." := lToLineNo;
                lToJobJnlLine.Modify;
            until lFromJobJnlLine.Next = 0;
        end;

        //#8108
        //Resource Journal Line
        lFromResJnlLine.SetFilter("Source Record ID", Format(pFromRecRef.RecordId));
        lFromResJnlLine.SetRange("Source  Line No.", lFromLineNo);
        if not lFromResJnlLine.IsEmpty then begin
            lFromResJnlLine.FindSet(false, false);
            repeat
                lToResJnlLine.Get(lFromResJnlLine."Journal Template Name", lFromResJnlLine."Journal Batch Name", lFromResJnlLine."Line No.");
                lToResJnlLine."Source Record ID" := pToRecRef.RecordId;
                lToResJnlLine."Source  Line No." := lToLineNo;
                lToResJnlLine.Modify;
            until lFromResJnlLine.Next = 0;
        end;
        //Resource Ledger Entry
        lFromResLedgEntry.SetFilter("Source Record ID", Format(pFromRecRef.RecordId));
        lFromResLedgEntry.SetRange("Source Line No.", lFromLineNo);
        if not lFromResLedgEntry.IsEmpty then begin
            lFromResLedgEntry.FindSet(false, false);
            repeat
                lToResLedgEntry.Get(lFromResLedgEntry."Entry No.");
                lToResLedgEntry."Source Record ID" := pToRecRef.RecordId;
                lToResLedgEntry."Source Line No." := lToLineNo;
                lToResLedgEntry.Modify;
            until lFromResLedgEntry.Next = 0;
        end;
        //#8108//
    end;


    procedure LoadLingSourceBuffer(pRecordRef: RecordRef; var pLinkSourceIDBuffer: Record "Planning Link Source ID Buffer")
    var
        lPlanningLinkSourceID: Record "Planning Link Source ID";
    begin
        lPlanningLinkSourceID.CalcFields("Source Record ID");
        lPlanningLinkSourceID.SetFilter("Source Record ID", Format(pRecordRef.RecordId));
        pLinkSourceIDBuffer.DeleteAll;
        if not lPlanningLinkSourceID.IsEmpty then begin
            lPlanningLinkSourceID.FindSet(true, true);
            repeat
                lPlanningLinkSourceID.CalcFields("Source Record ID");
                pLinkSourceIDBuffer.TransferFields(lPlanningLinkSourceID, true);
                pLinkSourceIDBuffer."Source Record ID" := lPlanningLinkSourceID."Source Record ID";
                pLinkSourceIDBuffer.Insert;
            until lPlanningLinkSourceID.Next = 0;
            lPlanningLinkSourceID.DeleteAll;
        end;
    end;


    procedure gPlanningRecIDLookUp(var pRec: Record "Planning Entry") Return: Boolean
    var
        lRecRef: RecordRef;
        lSalesHeader: Record "Sales Header";
        lRecID: RecordID;
    begin
        lRecID := pRec."Source Record ID";
        if lRecID.TableNo <> 0 then
            if not lRecRef.Get(lRecID) then
                Clear(lRecID);
        case lRecID.TableNo of
            Database::"Sales Header":
                begin
                    lRecRef.SetTable(lSalesHeader);
                    if pRec."Job No." <> '' then
                        lSalesHeader.SetRange("Job No.", pRec."Job No.");

                    Return := Page.RunModal(Page::"Sales List", lSalesHeader) = Action::LookupOK;
                    lRecRef.GetTable(lSalesHeader);
                    lRecID := lRecRef.RecordId;
                end;
            else
                lSalesHeader.SetRange("Document Type", lSalesHeader."document type"::Order);
                if pRec."Job No." <> '' then
                    lSalesHeader.SetRange("Job No.", pRec."Job No.");

                Return := Page.RunModal(Page::"Sales List", lSalesHeader) = Action::LookupOK;
                lRecRef.GetTable(lSalesHeader);
                lRecID := lRecRef.RecordId;
        end;
        if Return then
            pRec."Source Record ID" := lRecID;
    end;


    procedure gPlanningSourceLineLookUp(var pRec: Record "Planning Entry") return: Boolean
    var
        lRecID: RecordID;
        lRecRef: RecordRef;
        lSalesHeader: Record "Sales Header";
        lSalesLine: Record "Sales Line";
    //GL2024 NAVIBAT  lSalesDocForm: Page 8035019;
    begin
        lRecID := pRec."Source Record ID";
        case lRecID.TableNo of
            Database::"Sales Header":
                begin
                    lRecRef.Get(pRec."Source Record ID");
                    lRecRef.SetTable(lSalesHeader);
                    /*  //GL2024 NAVIBAT   lSalesDocForm.SetTableview(lSalesLine);
                       lSalesDocForm.SetRecordID(lRecID);
                       lSalesDocForm.SetTaskNo(pRec."Planning Task No.");
                       lSalesDocForm.LookupMode(true);
                       return := lSalesDocFORM.RunModal = Action::LookupOK;*/
                    if return then begin
                        //GL2024 NAVIBAT    lSalesDocForm.GetRecord(lSalesLine);
                        pRec."Source Line No." := lSalesLine."Line No.";
                    end;
                end;
            else
                return := false;
        end;
    end;


    procedure gJournalRecIDLookUp(var pRec: Record "Job Journal Line") Return: Boolean
    var
        lRecRef: RecordRef;
        lSalesHeader: Record "Sales Header";
        lRecID: RecordID;
    begin
        lRecID := pRec."Source Record ID";
        if lRecID.TableNo <> 0 then
            if not lRecRef.Get(lRecID) then
                Clear(lRecID);
        case lRecID.TableNo of
            Database::"Sales Header":
                begin
                    lRecRef.SetTable(lSalesHeader);

                    lSalesHeader.FilterGroup(10);
                    //BAT
                    lSalesHeader.SetRange("Order Type", 0);
                    //BAT//
                    if pRec."Job No." <> '' then
                        lSalesHeader.SetRange("Job No.", pRec."Job No.");
                    lSalesHeader.SetRange("Document Type", lSalesHeader."document type"::Quote, lSalesHeader."document type"::Order);
                    lSalesHeader.FilterGroup(0);

                    Return := Page.RunModal(Page::"Sales List", lSalesHeader) = Action::LookupOK;
                    lRecRef.GetTable(lSalesHeader);
                    if Return then
                        lRecID := lRecRef.RecordId;
                end;
            else
                lSalesHeader.SetRange("Document Type", lSalesHeader."document type"::Quote, lSalesHeader."document type"::Order);
                if pRec."Job No." <> '' then
                    lSalesHeader.SetRange("Job No.", pRec."Job No.");

                Return := Page.RunModal(Page::"Sales List", lSalesHeader) = Action::LookupOK;
                lRecRef.GetTable(lSalesHeader);
                if Return then
                    lRecID := lRecRef.RecordId;
        end;
        pRec."Source Record ID" := lRecID;
    end;


    procedure gJournalSourceLineLookUp(var pRec: Record "Job Journal Line") return: Boolean
    var
        lRecID: RecordID;
        lRecRef: RecordRef;
        lSalesHeader: Record "Sales Header";
        lSalesLine: Record "Sales Line";
    //GL2024 NAVIBAT   lSalesDocForm: Page 8035019;
    begin
        lRecID := pRec."Source Record ID";
        if lRecID.TableNo <> 0 then
            if not lRecRef.Get(lRecID) then
                Clear(lRecID);
        case lRecID.TableNo of
            Database::"Sales Header":
                begin
                    lRecRef.Get(lRecID);
                    lRecRef.SetTable(lSalesHeader);
                    /* //GL2024 NAVIBAT   lSalesDocForm.SetTableview(lSalesLine);
                      lSalesDocForm.SetRecordID(lRecID);
                      lSalesDocForm.SetTaskNo(pRec."Planning Task No.");
                      lSalesDocForm.LookupMode(true);
                      return := lSalesDocFORM.RunModal = Action::LookupOK;*/
                    if return then begin
                        // //GL2024 NAVIBAT    lSalesDocForm.GetRecord(lSalesLine);
                        pRec."Source Line No." := lSalesLine."Line No.";
                    end;
                end;
            else
                return := false;
        end;
    end;
}

