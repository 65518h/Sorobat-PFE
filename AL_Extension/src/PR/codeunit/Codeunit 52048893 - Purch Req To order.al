namespace Microsoft.Purchases.Document;

using Microsoft.Finance.ReceivablesPayables;
using Microsoft.Purchases.Comment;
using Microsoft.Purchases.Setup;
using Microsoft.Purchases.Vendor;
using Microsoft.Utilities;
using System.Automation;
using System.Utilities;

codeunit 52048893 "Purch.-Request to Order"
{
    TableNo = "Purchase Request";
    // HS 
    trigger OnRun()
    var
        Vend: Record Vendor;
        PurchCommentLine: Record "Purch. Comment Line";
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        RecordLinkManagement: Codeunit "Record Link Management";
        ShouldRedistributeInvoiceAmount: Boolean;
        IsHandled: Boolean;
        CodLVendor: Code[20];

    begin
        //  OnBeforeRun(Rec);


        //  ShouldRedistributeInvoiceAmount := PurchCalcDiscByType.ShouldRedistributeInvoiceDiscountAmount(Rec);

        Rec.CheckPurchasePostRestrictions();
        PurchReqLineToGenerate.SetCurrentKey("Vendor No.");
        // PurchReqLineToGenerate.SetAscending();
        PurchReqLineToGenerate.SetRange("Document No.", Rec."No.");
        PurchReqLineToGenerate.SetRange("Transférer", false);
        PurchReqLineToGenerate.SetRange(Statut, PurchReqLineToGenerate.Statut::approved);
        if PurchReqLineToGenerate.FindSet() then
            repeat
                PurchReqLineToGenerate.TestField("Vendor No.");
                if CodLVendor <> PurchReqLineToGenerate."Vendor No." then begin
                    Vend.Get(PurchReqLineToGenerate."Vendor No.");
                    Vend.CheckBlockedVendOnDocs(Vend, false);

                    Rec.ValidatePurchaserOnPurchHeader(Rec, true, false);

                    Rec.CheckForBlockedLines();

                    CreatePurchHeader(Rec, Vend."Prepayment %", Vend);

                    TransferQuoteToOrderLines(PurchQuoteLine, Rec, PurchOrderLine, PurchOrderHeader, Vend);
                    CodLVendor := PurchReqLineToGenerate."Vendor No.";
                    // OnAfterInsertAllPurchOrderLines(PurchOrderLine, Rec);
                end;
            until PurchReqLineToGenerate.Next() = 0;
        PurchSetup.Get();
        //  ArchivePurchaseQuote(Rec);

        if PurchSetup."Default Posting Date" = PurchSetup."Default Posting Date"::"No Date" then begin
            PurchOrderHeader."Posting Date" := 0D;
            PurchOrderHeader.Modify();
        end;

        PurchCommentLine.CopyComments(Rec."Document Type".AsInteger(), PurchOrderHeader."Document Type".AsInteger(), Rec."No.", PurchOrderHeader."No.");
        RecordLinkManagement.CopyLinks(Rec, PurchOrderHeader);

        AssignItemCharges(Rec."Document Type", Rec."No.", PurchOrderHeader."Document Type", PurchOrderHeader."No.");

        ApprovalsMgmt.CopyApprovalEntryQuoteToOrder(Rec.RecordId, PurchOrderHeader."No.", PurchOrderHeader.RecordId);

        IsHandled := false;
        //  OnBeforeDeletePurchQuote(Rec, PurchOrderHeader, IsHandled);
        /* Hs   if not IsHandled then begin
               ApprovalsMgmt.DeleteApprovalEntries(Rec.RecordId);
               PurchCommentLine.DeleteComments(Rec."Document Type".AsInteger(), Rec."No.");
               IsHandled := false;
               //   OnBeforeDeleteLinks(Rec, IsHandled);
               if not IsHandled then
                   Rec.DeleteLinks();
               Rec.Delete();
               PurchQuoteLine.DeleteAll();
           end;*/

        if not ShouldRedistributeInvoiceAmount then
            PurchCalcDiscByType.ResetRecalculateInvoiceDisc(PurchOrderHeader);

        //  OnAfterRun(Rec, PurchOrderHeader);
    end;

    var
        PurchQuoteLine, PurchReqLineToGenerate : Record "Purchase request Line";
        PurchOrderHeader: Record "Purchase Header";
        PurchOrderLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        PrepmtMgt: Codeunit "Prepayment Mgt.";

    local procedure CreatePurchHeader(PurchHeader: Record "Purchase Request"; PrepmtPercent: Decimal; Vendor: Record Vendor)
    var

    begin
        //   OnBeforeCreatePurchHeader(PurchHeader);

        //   PurchOrderHeader := PurchHeader;
        PurchOrderHeader.TransferFields(PurchHeader);
        PurchOrderHeader."Document Type" := PurchOrderHeader."Document Type"::Order;
        PurchOrderHeader."No. Printed" := 0;
        PurchOrderHeader.Status := PurchOrderHeader.Status::Open;
        PurchOrderHeader."No." := '';
        PurchOrderHeader."Posting Date" := Today;
        PurchOrderHeader."N° Demande d'achat" := PurchHeader."No.";
        PurchOrderHeader."Purchase Request No." := PurchHeader."No.";
        PurchOrderHeader."Quote No." := PurchHeader."No.";
        PurchOrderHeader.Validate("Buy-from Vendor No.", Vendor."No.");
        PurchOrderHeader.Validate(Demandeur, PurchHeader."Requester ID");
        PurchOrderHeader.Validate("Date DA", PurchHeader."Document Date");
        PurchOrderHeader.Validate(Engins, PurchHeader.Engin);
        //PurchOrderHeader."Job No." := PurchHeader."Job No.";
        //  PurchOrderHeader.Validate("Job No.", PurchHeader."Job No.");
        //    OnCreatePurchHeaderOnBeforeInitRecord(PurchOrderHeader, PurchHeader);
        PurchOrderHeader.InitRecord();

        PurchOrderLine.LockTable();
        //   OnCreatePurchHeaderOnBeforePurchOrderHeaderInsert(PurchOrderHeader, PurchHeader); 
        PurchOrderHeader.Insert(true);

        //   OnCreatePurchHeaderOnAfterPurchOrderHeaderInsert(PurchOrderHeader, PurchHeader);
        PurchOrderHeader."Location Code" := PurchHeader."Location Code";
        PurchOrderHeader."Order Date" := PurchHeader."Order Date";
        if PurchHeader."Posting Date" <> 0D then
            PurchOrderHeader."Posting Date" := PurchHeader."Posting Date";

        InitFromPurchHeader(PurchHeader, PurchOrderHeader);
        //    OnCreatePurchHeaderOnAfterInitFromPurchHeader(PurchOrderHeader, PurchHeader);
        PurchOrderHeader."Inbound Whse. Handling Time" := PurchHeader."Inbound Whse. Handling Time";

        PurchOrderHeader."Prepayment %" := PrepmtPercent;
        if PurchOrderHeader."Posting Date" = 0D then
            PurchOrderHeader."Posting Date" := WorkDate();
        PurchOrderHeader.Validate("Job No.", PurchHeader."Job No.");
        //    OnCreatePurchHeaderOnBeforePurchOrderHeaderModify(PurchOrderHeader, PurchHeader);
        PurchOrderHeader.Modify();

        //  OnAfterCreatePurchHeader(PurchOrderHeader, PurchHeader);
    end;

    local procedure ArchivePurchaseQuote(var PurchaseHeader: Record "Purchase Header")
    var
        ArchiveManagement: Codeunit ArchiveManagement;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //   OnBeforeArchivePurchaseQuote(PurchaseHeader, PurchOrderHeader, IsHandled);
        if IsHandled then
            exit;

        case PurchSetup."Archive Quotes" of
            PurchSetup."Archive Quotes"::Always:
                ArchiveManagement.ArchPurchDocumentNoConfirm(PurchaseHeader);
            PurchSetup."Archive Quotes"::Question:
                ArchiveManagement.ArchivePurchDocument(PurchaseHeader);
        end;
    end;

    local procedure AssignItemCharges(FromDocType: Enum "Purchase Document Type"; FromDocNo: Code[20]; ToDocType: Enum "Purchase Applies-to Document Type"; ToDocNo: Code[20])
    var
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
    begin
        ItemChargeAssgntPurch.Reset();
        ItemChargeAssgntPurch.SetRange("Document Type", FromDocType);
        ItemChargeAssgntPurch.SetRange("Document No.", FromDocNo);
        while ItemChargeAssgntPurch.FindFirst() do begin
            ItemChargeAssgntPurch.Delete();
            ItemChargeAssgntPurch."Document Type" := PurchOrderHeader."Document Type";
            ItemChargeAssgntPurch."Document No." := PurchOrderHeader."No.";
            if not (ItemChargeAssgntPurch."Applies-to Doc. Type" in
                    [ItemChargeAssgntPurch."Applies-to Doc. Type"::Receipt,
                     ItemChargeAssgntPurch."Applies-to Doc. Type"::"Return Shipment"])
            then begin
                ItemChargeAssgntPurch."Applies-to Doc. Type" := ToDocType;
                ItemChargeAssgntPurch."Applies-to Doc. No." := ToDocNo;
            end;
            ItemChargeAssgntPurch.Insert();
        end;
    end;

    procedure GetPurchOrderHeader(var PurchHeader: Record "Purchase Header"; PurchaseRequestHeader: Record "Purchase Request"): Integer;
    begin
        PurchHeader.SetRange("Purchase Request No.", PurchaseRequestHeader."No.");
        exit(PurchHeader.Count);
    end;

    local procedure TransferQuoteToOrderLines(var PurchQuoteLine: Record "Purchase request Line"; var PurchQuoteHeader: Record "Purchase Request"; var PurchOrderLine: Record "Purchase Line"; var PurchOrderHeader: Record "Purchase Header"; Vend: Record Vendor)
    var
        PurchLineReserve: Codeunit "Purch. Line-Reserve";
        IsHandled: Boolean;
    begin
        PurchQuoteLine.SetRange("Document Type", PurchQuoteHeader."Document Type");
        PurchQuoteLine.SetRange("Document No.", PurchQuoteHeader."No.");
        PurchQuoteLine.SetRange("Vendor No.", Vend."No.");
        PurchQuoteLine.SetRange(Statut, PurchQuoteLine.Statut::approved);
        // OnTransferQuoteToOrderLinesOnAfterPurchQuoteLineSetFilters(PurchQuoteLine, PurchQuoteHeader, PurchOrderHeader);
        if PurchQuoteLine.FindSet() then
            repeat
                Clear(PurchOrderLine);
                IsHandled := false;
                //  OnBeforeTransferQuoteLineToOrderLineLoop(PurchQuoteLine, PurchQuoteHeader, PurchOrderHeader, IsHandled);
                if not IsHandled then begin
                    //  PurchOrderLine := PurchQuoteLine;
                    PurchOrderLine.TransferFields(PurchQuoteLine);
                    PurchOrderLine."Document Type" := PurchOrderHeader."Document Type";
                    PurchOrderLine."Purchase Request No." := PurchOrderHeader."No.";
                    PurchOrderLine."Document No." := PurchOrderHeader."No.";
                    PurchOrderLine."Type article" := PurchQuoteLine."Type article";
                    PurchOrderLine.Validate("No.", PurchQuoteLine."No.");
                    //    PurchOrderLine."Purchase Request No." := PurchOrderHeader."Purchase Request No.";
                    /*   PurchLineReserve.TransferPurchLineToPurchLine(
                         PurchQuoteLine, PurchOrderLine, PurchQuoteLine."Outstanding Qty. (Base)");*/

                    PurchOrderLine."Shortcut Dimension 1 Code" := PurchQuoteLine."Shortcut Dimension 1 Code";
                    PurchOrderLine."Shortcut Dimension 2 Code" := PurchQuoteLine."Shortcut Dimension 2 Code";
                    PurchOrderLine."Dimension Set ID" := PurchQuoteLine."Dimension Set ID";
                    PurchOrderLine."Transaction Type" := PurchOrderHeader."Transaction Type";
                    if Vend."Prepayment %" <> 0 then
                        PurchOrderLine."Prepayment %" := Vend."Prepayment %";
                    PrepmtMgt.SetPurchPrepaymentPct(PurchOrderLine, PurchOrderHeader."Posting Date");
                    ValidatePurchOrderLinePrepaymentPct(PurchOrderLine);
                    PurchOrderLine.DefaultDeferralCode();

                    // OnBeforeInsertPurchOrderLine(PurchOrderLine, PurchOrderHeader, PurchQuoteLine, PurchQuoteHeader);
                    PurchOrderLine.Insert();

                    PurchOrderLine.Validate("Location Code", PurchQuoteLine."Location Code");
                    PurchOrderLine."Purchase Request No." := PurchQuoteLine."Document No.";
                    //  PurchOrderLine."DYSJob No." := PurchQuoteLine."Job No.";
                    PurchOrderLine.Validate("DYSJob No.", PurchQuoteLine."Job No.");
                    PurchOrderLine.Validate("DYSJob Task No.", PurchQuoteLine."Job Task No.");
                    //   PurchOrderLine."DYSJob Task No." := PurchQuoteLine."Job Task No.";
                    PurchOrderLine.Validate("DYSJob Planning Line No.", PurchQuoteLine."Job Planning Line No.");
                    PurchOrderLine.Description := PurchQuoteLine.Description;
                    PurchOrderLine.Observation_Ligne := PurchQuoteLine."Description 2";
                    //  PurchOrderLine."DYSJob Planning Line No." := PurchQuoteLine."Job Planning Line No.";
                    PurchOrderLine.Modify();
                    //    OnAfterInsertPurchOrderLine(PurchQuoteLine, PurchOrderLine);
                    //  PurchLineReserve.VerifyQuantity(PurchOrderLine, PurchQuoteLine);
                    //     OnTransferQuoteToOrderLinesOnAfterVerifyQuantity(PurchOrderLine, PurchOrderHeader, PurchQuoteLine, PurchQuoteHeader);
                    PurchQuoteLine."Associated Purchase Order" := PurchOrderHeader."No.";
                    PurchQuoteLine.Modify();
                end;
            until PurchQuoteLine.Next() = 0;
    end;

    local procedure ValidatePurchOrderLinePrepaymentPct(var PurchOrderLine: Record "Purchase Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeValidatePurchOrderLinePrepaymentPct(PurchOrderLine, IsHandled);
        if IsHandled then
            exit;

        PurchOrderLine.Validate("Prepayment %");
    end;

    procedure InitFromPurchHeader(SourcePurchHeader: Record "Purchase Request"; var PurchaseOrder: Record "Purchase Header")
    begin
        PurchaseOrder."Document Date" := SourcePurchHeader."Document Date";
        PurchaseOrder."Invoice Received Date" := SourcePurchHeader."Invoice Received Date";
        PurchaseOrder."Expected Receipt Date" := SourcePurchHeader."Expected Receipt Date";
        PurchaseOrder."Shortcut Dimension 1 Code" := SourcePurchHeader."Shortcut Dimension 1 Code";
        PurchaseOrder."Shortcut Dimension 2 Code" := SourcePurchHeader."Shortcut Dimension 2 Code";
        PurchaseOrder."Dimension Set ID" := SourcePurchHeader."Dimension Set ID";
        PurchaseOrder."Location Code" := SourcePurchHeader."Location Code";
        PurchaseOrder.SetShipToAddress(
          SourcePurchHeader."Ship-to Name", SourcePurchHeader."Ship-to Name 2", SourcePurchHeader."Ship-to Address",
          SourcePurchHeader."Ship-to Address 2", SourcePurchHeader."Ship-to City", SourcePurchHeader."Ship-to Post Code",
          SourcePurchHeader."Ship-to County", SourcePurchHeader."Ship-to Country/Region Code");
        PurchaseOrder."Ship-to Contact" := SourcePurchHeader."Ship-to Contact";

        //OnInitFromPurchHeader(Rec, SourcePurchHeader);
    end;

}
