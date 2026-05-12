Codeunit 8004151 "Purch. Post NoE Integr."
{

    trigger OnRun()
    begin
    end;


    procedure SetPurchHeader(var pPurchHeader: Record "Purchase Header"; pPurchInvHeader: Record "Purch. Inv. Header"; pPurchSetup: Record "Purchases & Payables Setup"; var pReceive: Boolean; var pInvoice: Boolean; var pShip: Boolean)
    var
        tNoEPostingDesc: label 'NoE %1 %2';
    begin
        pReceive := true;
        pInvoice := true;
        pShip := false;
        pPurchHeader."Applies-to Doc. Type" := pPurchInvHeader."applies-to doc. type"::"Note of Expenses";
        pPurchHeader."Posting Description" :=
          CopyStr(StrSubstNo(tNoEPostingDesc, pPurchHeader."Pay-to Name", pPurchHeader."Your Reference"),
            1, MaxStrLen(pPurchHeader."Posting Description"));
        if pPurchSetup."Ext. Doc. No. Mandatory" then begin
            if pPurchHeader."Vendor Invoice No." = '' then
                pPurchHeader."Vendor Invoice No." := pPurchHeader."No.";
            if pPurchHeader."Vendor Cr. Memo No." = '' then
                pPurchHeader."Vendor Cr. Memo No." := pPurchHeader."No.";
        end;
    end;


    procedure SetScrCode(pPurchHeader: Record "Purchase Header"; var pSrcCode: Code[20]; pSourceCodeSetup: Record "Source Code Setup") return: Boolean
    begin
        if pPurchHeader."Document Type" = pPurchHeader."document type"::"Note of Expenses" then begin
            pSourceCodeSetup.TestField("Note of Expenses Journal");
            pSrcCode := pSourceCodeSetup."Note of Expenses Journal";
            return := true;
        end else
            return := false;
    end;


    procedure JobPostLine(var pPurchHeader: Record "Purchase Header"; pPurchLine: Record "Purchase Line"; var pJobPurchLine: Record "Purchase Line"; var pPurchInvHeader: Record "Purch. Inv. Header"; var pPurchCrMemoHeader: Record "Purch. Cr. Memo Hdr."; var pTempJnlLineDim: Record "Dim. Value per Account"; pSrcCode: Code[20])
    var
        lJobPostLine: Codeunit "Job Post-Line2";
    begin
        pPurchHeader.TestField("Document Type", pPurchHeader."document type"::"Note of Expenses");
        if pPurchLine."dysJob No." <> '' then
            lJobPostLine.InsertPurchLine(pPurchHeader, pPurchInvHeader, pPurchCrMemoHeader,
                                             pJobPurchLine, pSrcCode, pTempJnlLineDim);
    end;


    procedure SetInvPostingBuffer(var pInvPostingBuffer: Record "Invoice Post. Buffer"; pPurchLine: Record "Purchase Line"; pGenPostingSetup: Record "General Posting Setup"; pTotalVAT: Decimal; pTotalVATACY: Decimal; pTotalAmount: Decimal; pTotalAmountACY: Decimal)
    var
        lResource: Record Resource;
    begin
        lResource.Get(pPurchLine."No.");
        if lResource."Note of Expenses Account" <> '' then
            pInvPostingBuffer.SetAccount(
              lResource."Note of Expenses Account",
              pTotalVAT,
              pTotalVATACY,
              pTotalAmount,
              pTotalAmountACY)
        else
            pInvPostingBuffer.SetAccount(
              pGenPostingSetup."Purch. Account",
              pTotalVAT,
              pTotalVATACY,
              pTotalAmount,
              pTotalAmountACY);
    end;
}

