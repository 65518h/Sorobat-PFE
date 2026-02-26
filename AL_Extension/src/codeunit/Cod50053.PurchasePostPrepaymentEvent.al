codeunit 50053 PurchasePostPrepaymentEvent
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purchase-Post Prepayments", 'OnAfterPurchInvHeaderInsert', '', true, true)]
    local procedure OnAfterPurchInvHeaderInsert(var PurchInvHeader: Record "Purch. Inv. Header"; PurchHeader: Record "Purchase Header"; CommitIsSupressed: Boolean)
    var
        lProcessusWKFIntegr: Codeunit "Processus workflow Integr.";
    begin
        //+WKF+CUSTOM
        IF gAddOnLicencePermission.HasPermissionWKF() THEN
            lProcessusWKFIntegr.PurchInvoicePostOnHold(PurchHeader, PurchInvHeader);
        //+WKF+CUSTOM//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purchase-Post Prepayments", 'OnAfterPurchCrMemoHeaderInsert', '', true, true)]
    local procedure OnAfterPurchCrMemoHeaderInsert(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; PurchHeader: Record "Purchase Header"; CommitIsSupressed: Boolean)
    var
        lProcessusWKFIntegr: Codeunit "Processus workflow Integr.";
    begin
        //+WKF+CUSTOM
        IF gAddOnLicencePermission.HasPermissionWKF() THEN
            lProcessusWKFIntegr.PurchCreditPostOnHold(PurchHeader, PurchCrMemoHdr);
        //+WKF+CUSTOM//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purchase-Post Prepayments", 'OnBeforePurchInvLineInsert', '', true, true)]
    local procedure OnBeforePurchInvLineInsert(var PurchInvLine: Record "Purch. Inv. Line"; PurchInvHeader: Record "Purch. Inv. Header"; PrepmtInvLineBuffer: Record "Prepayment Inv. Line Buffer"; CommitIsSupressed: Boolean)
    begin
        //+ONE+PREPAYMENT
        PurchInvLine."Job No." := PrepmtInvLineBuffer."Job No.";
        PurchInvLine."Job Task No." := PrepmtInvLineBuffer."Job Task No.";
        //+ONE+PREPAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purchase-Post Prepayments", 'OnBeforePurchCrMemoLineInsert', '', true, true)]
    local procedure OnBeforePurchCrMemoLineInsert(var PurchCrMemoLine: Record "Purch. Cr. Memo Line"; PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; PrepmtInvLineBuffer: Record "Prepayment Inv. Line Buffer"; CommitIsSupressed: Boolean)
    begin
        //+ONE+PREPAYMENT
        PurchCrMemoLine."Job No." := PrepmtInvLineBuffer."Job No.";
        PurchCrMemoLine."Job Task No." := PrepmtInvLineBuffer."Job Task No.";
        //+ONE+PREPAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purchase-Post Prepayments", 'OnAfterPostPrepmtInvLineBuffer', '', true, true)]
    local procedure OnAfterPostPrepmtInvLineBuffer(var GenJnlLine: Record "Gen. Journal Line"; PrepmtInvLineBuffer: Record "Prepayment Inv. Line Buffer"; CommitIsSuppressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        lJobJnlLine: Record "Job Journal Line";
        lJobTransferLine: Codeunit "Job Transfer Line2";
        lGLAccount: Record "G/L Account";
    begin
        //+ONE+PREPAYMENT
        IF GenJnlLine."Account No." <> lGLAccount."No." THEN
            lGLAccount.GET(GenJnlLine."Account No.");
        IF (GenJnlLine."Job No." <> '') AND (GenJnlLine.Amount <> 0) AND lGLAccount."Post Job Entry" THEN BEGIN
            lJobJnlLine.INIT;
            lJobTransferLine.FromGenJnlLineToJnlLine(GenJnlLine, lJobJnlLine);
            fRunJobJnlPostLine(lJobJnlLine, PrepmtInvLineBuffer."Dimension Set ID");
        END;
        //+ONE+PREPAYMENT//
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purchase-Post Prepayments", 'OnBeforePostVendorEntry', '', true, true)]
    local procedure OnBeforePostVendorEntry(var GenJnlLine: Record "Gen. Journal Line"; TotalPrepmtInvLineBuffer: Record "Prepayment Inv. Line Buffer"; TotalPrepmtInvLineBufferLCY: Record "Prepayment Inv. Line Buffer"; CommitIsSupressed: Boolean; PurchaseHeader: Record "Purchase Header"; DocumentType: Option)
    var
        lPaymentTerms: Record "Payment Terms";
    begin
        //WORKFLOW
        GenJnlLine."On Hold" := PurchaseHeader."On Hold";
        //WORKFLOW//
        //PMT_DIRECT
        IF (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Invoice) THEN
            GenJnlLine."Apply-to Sales Order No." := PurchaseHeader."Apply-to Sales Order No.";
        //PMT_DIRECT//

        //+ONE+PREPAYMENT
        IF (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Invoice) AND lPaymentTerms.GET(PurchaseHeader."Payment Terms Code") THEN
            lPaymentTerms.CALCFIELDS("Number of Fractionation");
        // IF lPaymentTerms."Number of Fractionation" > 1 THEN
        //     lFractionationMgt.GenJnlLineFraction(GenJnlLine, TempJnlLineDim, "Payment Terms Code", GenJnlPostLine)
        // ELSE
        //+ONE+PREPAYMENT//
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purchase-Post Prepayments", 'OnAfterPostVendorEntry', '', true, true)]
    local procedure OnAfterPostVendorEntry(var GenJnlLine: Record "Gen. Journal Line"; TotalPrepmtInvLineBuffer: Record "Prepayment Inv. Line Buffer"; TotalPrepmtInvLineBufferLCY: Record "Prepayment Inv. Line Buffer"; CommitIsSupressed: Boolean)
    begin
    end;

    [EventSubscriber(ObjectType::table, Database::"Prepayment Inv. Line Buffer", 'OnAfterCopyFromPurchLine', '', true, true)]
    local procedure OnAfterCopyFromPurchLine(var PrepaymentInvLineBuffer: Record "Prepayment Inv. Line Buffer"; PurchaseLine: Record "Purchase Line")
    var
        PurchHeader: Record "Purchase Header";
    begin
        //+ONE+PREPAYMENT
        IF PurchHeader.GET(PurchaseLine."Document Type", PurchaseLine."Document No.") THEN;
        IF NOT PurchHeader."Compress Prepayment" THEN BEGIN
            PrepaymentInvLineBuffer."Gen. Prod. Posting Group" := PurchaseLine."Gen. Prod. Posting Group";
            PrepaymentInvLineBuffer."VAT Prod. Posting Group" := PurchaseLine."VAT Prod. Posting Group";
        END;
        PrepaymentInvLineBuffer."Job Task No." := PurchaseLine."Job Task No.";
        //+ONE+PREPAYMENT//
    end;

    LOCAL PROCEDURE fRunJobJnlPostLine(VAR pJobJnlLine: Record "Job Journal Line"; DimEntryNo: Integer);
    VAR
        lTempDimBuf: Record "Dimension Buffer" TEMPORARY;
        lTempJnlLineDim: Record "Dim. Value per Account" TEMPORARY;
        lDimMgt: Codeunit DimensionManagement;
        lJobJnlPostLine: Codeunit "Job Jnl.-Post Line2";
    BEGIN
        //+ONE+PREPAYMENT
        lTempDimBuf.INIT;
        lTempJnlLineDim.INIT;
        //DimBufMgt.GetDimensions(DimEntryNo,lTempDimBuf);
        //lDimMgt.CopyDimBufToJnlLineDim(
        //lTempDimBuf,lTempJnlLineDim,pJobJnlLine."Journal Template Name",
        //pJobJnlLine."Journal Batch Name",pJobJnlLine."Line No.");
        //DYS fonction RunWithCheck manquant 
        // lJobJnlPostLine.RunWithCheck(pJobJnlLine, lTempJnlLineDim);
        //+ONE+PREPAYMENT//
    END;

    var
        myInt: Integer;
        gAddOnLicencePermission: Codeunit IntegrManagement;
}