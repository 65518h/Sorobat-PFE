codeunit 50051 SalesPostPrepaymentEvent
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnBeforeCheckPrepmtDoc', '', true, true)]
    local procedure OnBeforeCheckPrepmtDoc(SalesHeader: Record "Sales Header"; DocumentType: Option; CommitIsSuppressed: Boolean)
    var
        lPrepaymentManagement: Codeunit "Prepayment Management";
    begin
        SalesHeader.TESTFIELD("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.TESTFIELD("Sell-to Customer No.");
        SalesHeader.TESTFIELD("Bill-to Customer No.");
        SalesHeader.TESTFIELD("Posting Date");
        SalesHeader.TESTFIELD("Document Date");
        //+ONE+PREPAYMENT
        //#9077 +ONE+NEG_AMOUNT
        //  lPrepaymentManagement.SalesPostingDate(SalesHeader2,DocumentType);
        lPrepaymentManagement.fDateCompare(SalesHeader, DocumentType, gReversal, gPartialCredit);
        //#9077//
        //#7849 A supprimer commentaire
        IF SalesHeader."Invoicing Method" = SalesHeader."Invoicing Method"::Completion THEN
            //#7849
            SalesHeader."Compress Prepayment" := FALSE;
        //+ONE+PREPAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnBeforeCheckOpenPrepaymentLines', '', true, true)]
    local procedure OnBeforeCheckOpenPrepaymentLines(SalesHeader: Record "Sales Header"; DocumentType: Option; var Found: Boolean; var IsHandled: Boolean)
    var
        CduSalesPostPrep: Codeunit "Sales-Post Prepayments";
    begin
        //+ONE+PREPAYMENT
        IF NOT gReversal THEN begin
            IsHandled := false;
            IF NOT CduSalesPostPrep.CheckOpenPrepaymentLines(SalesHeader, DocumentType) THEN
                //#8374
                IF (SalesHeader."Invoicing Method" = SalesHeader."Invoicing Method"::Direct) AND gReversal THEN
                    ERROR(tReverseDirectInvError)
        end

        else
            IsHandled := true;
        //+ONE+PREPAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnAfterCheckPrepmtDoc', '', true, true)]
    local procedure OnAfterCheckPrepmtDoc(SalesHeader: Record "Sales Header"; DocumentType: Option Invoice,"Credit Memo"; CommitIsSuppressed: Boolean; var ErrorMessageMgt: Codeunit "Error Message Management")
    var
        SalesLine: Record "Sales Line";
    begin
        //#8302 +ONE+NEG_AMOUNT
        fCheckAmount(SalesHeader, SalesLine, DocumentType);
        //#8302//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnAfterSalesInvHeaderInsert', '', true, true)]
    local procedure OnAfterSalesInvHeaderInsert(var SalesInvoiceHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    begin
        //#6386
        fDescriptionLine(SalesHeader."No.", SalesInvoiceHeader."No.", 0);
        //#6386//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnBeforeSalesInvHeaderInsert', '', true, true)]
    local procedure OnBeforeSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; GenJnlDocNo: Code[20])
    begin
        //#8302 - 18/05/11 +ONE+NEG_AMOUNT
        IF gReversal THEN
            SalesInvHeader."Prepayment Rank No." := SalesHeader."No. Prepayment Invoiced" + 1;
        //#8302 - 18/05/11//
        //#8625
        SalesInvHeader."Order No." := SalesHeader."No.";
        //#8625//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnBeforeSalesCrMemoHeaderInsert', '', true, true)]
    local procedure OnBeforeSalesCrMemoHeaderInsert(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    begin
        //       //+ONE+PREPAYMENT (#5092)
        //           IF gReversal THEN BEGIN
        //             SalesCrMemoHeader."Prepayment Rank No." := SalesHeader."No. Prepayment Invoiced" + 1;
        //   //#8302 - 18/05/11 +ONE+NEG_AMOUNT
        //             IF GenJnlLineDocNo <> '' THEN
        //               SalesCrMemoHeader."Posting Description" :=
        //                 COPYSTR(
        //                   STRSUBSTNO(tNegInvoiceCancel,SELECTSTR(1 + DocumentType,Text019),SalesHeader."No. Prepayment Invoiced" + 1,SalesHeader."No."),
        //                   1,MAXSTRLEN(SalesHeader."Posting Description"))
        //             ELSE
        //   //#8302 - 18/05/11//
        //             SalesCrMemoHeader."Posting Description" :=
        //               COPYSTR(
        //                 STRSUBSTNO(tPostDescReversal,SELECTSTR(1 + DocumentType,Text019),SalesHeader."Document Type",SalesHeader."No.",
        //                 SalesCrMemoHeader."Prepayment Rank No."),
        //                 1,MAXSTRLEN(SalesHeader."Posting Description"));
        //   //#7680
        //             PostingDescription := SalesCrMemoHeader."Posting Description";
        //   //#7680//
        //           END;
        //   //+ONE+PREPAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnAfterSalesCrMemoHeaderInsert', '', true, true)]
    local procedure OnAfterSalesCrMemoHeaderInsert(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    begin
        //#6386
        fDescriptionLine(SalesHeader."No.", SalesCrMemoHeader."No.", 1);
        //#6386//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnBeforeCreateLinesFromBuffer', '', true, true)]
    local procedure OnBeforeCreateLinesFromBuffer(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var TempGlobalPrepmtInvLineBuf: Record "Prepayment Inv. Line Buffer" temporary; var LineCount: Integer; var SalesInvHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var PostedDocTabNo: Integer; DocumentType: Option; var LastLineNo: Integer; GenJnlLineDocNo: Code[20]; var IsHandled: Boolean)
    begin
        //+ONE+PREPAYMENT
        //Insertion des lignes sur facture ou avoir
        //Si on compress l'accompte
        IF SalesHeader."Compress Prepayment" THEN
            IsHandled := false
        else
            IsHandled := true;

        //+ONE+PREPAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnBeforeSalesInvLineInsert', '', true, true)]
    local procedure OnBeforeSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; PrepmtInvLineBuffer: Record "Prepayment Inv. Line Buffer"; CommitIsSuppressed: Boolean)
    begin
        //+ONE+PREPAYMENT (#5174)
        SalesInvLine."Job No." := PrepmtInvLineBuffer."Job No.";
        SalesInvLine."Job Task No." := PrepmtInvLineBuffer."Job Task No.";
        //+ONE+PREPAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnBeforeSalesCrMemoLineInsert', '', true, true)]
    local procedure OnBeforeSalesCrMemoLineInsert(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; PrepmtInvLineBuffer: Record "Prepayment Inv. Line Buffer"; CommitIsSuppressed: Boolean)
    begin
        //+ONE+PREPAYMENT (#5174)
        SalesCrMemoLine."Job No." := PrepmtInvLineBuffer."Job No.";
        SalesCrMemoLine."Job Task No." := PrepmtInvLineBuffer."Job Task No.";
        //+ONE+PREPAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnAfterCreateLinesOnBeforeGLPosting', '', true, true)]
    local procedure OnAfterCreateLinesOnBeforeGLPosting(var SalesHeader: Record "Sales Header"; SalesInvHeader: Record "Sales Invoice Header"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var TempPrepmtInvLineBuffer: Record "Prepayment Inv. Line Buffer" temporary; DocumentType: Option; var LastLineNo: Integer)
    var
        SalesLine: Record "Sales Line";
        PrepmtInvBuffer: Record "Prepayment Inv. Line Buffer";
        SalesInvLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        TempDimBuf: Record "Dimension Buffer";
        LineCount, LineNo : Integer;
        Window: Dialog;
        opDocumentType: Option Invoice,"Credit Memo";
        DimBufMgt: Codeunit "Dimension Buffer Management";
        DimMgt: Codeunit DimensionManagement;
        PostedDocTabNo: Integer;
        tTotPrepayment: Decimal;
        lTotOrderAmount: Decimal;
    begin
        //+ONE+PREPAYMENT
        opDocumentType := DocumentType;
        // dans le cas ou l'on ne compresse pas l'accompte
        IF NOT SalesHeader."Compress Prepayment" THEN BEGIN
            SalesLine.RESET;
            SalesLine.SETCURRENTKEY("Order Type", "Document Type", "Document No.", "Presentation Code");
            SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
            SalesLine.SETRANGE("Document No.", SalesHeader."No.");
            SalesLine.SETRANGE("Structure Line No.", 0);
            SalesLine.SETRANGE("Assignment Basis", 0);
            //#7596
            SalesLine.SETFILTER("Order Date", '..%1|%2', SalesHeader."Document Date", 0D);
            //#7596//
            SalesLine.FINDSET;
            TempDimBuf.INIT;
            REPEAT
                LineCount := LineCount + 1;
                Window.UPDATE(2, LineCount);
                LineNo := LastLineNo + 10000;

                //+ONE+PREPAYMENT      //ML
                PrepmtInvBuffer.SETRANGE("Line No.", SalesLine."Line No.");
                IF PrepmtInvBuffer.FINDFIRST THEN;
                PrepmtInvBuffer.SETRANGE("Line No.");
                //+ONE+PREPAYMENT//
                SalesInvLine.INIT;
                SalesInvLine."Document No." := SalesInvHeader."No.";
                //#7416    SalesInvLine."Line No." := SalesLine."Line No.";
                SalesInvLine."Line No." := LineNo;
                //#7416//
                //#8141
                SalesInvLine.Marker := SalesLine.Marker;
                //#8141//

                SalesInvLine."Attached to Line No." := SalesLine."Attached to Line No.";
                SalesInvLine."Sell-to Customer No." := SalesInvHeader."Sell-to Customer No.";
                SalesInvLine."Presentation Code" := SalesLine."Presentation Code";
                SalesInvLine.Level := SalesLine.Level;
                SalesInvLine.Description := SalesLine.Description;
                SalesInvLine."Prepayment Order No." := SalesHeader."No.";
                SalesInvLine."Prepayment Order Line No." := SalesLine."Line No.";
                SalesInvLine."Quote No." := SalesLine."Quote No.";
                //#6796
                SalesInvLine."Rider Rank" := SalesLine."Rider Rank";
                //#6796//

                IF SalesLine.Type = 0 THEN BEGIN
                    SalesInvLine."Line Type" := SalesLine."Line Type";
                    //#6796
                    //#7664
                    //      IF fCtrlTitleRider(SalesInvLine) THEN BEGIN
                    IF fCtrlTitleRider(SalesInvLine) OR fCtrlStandardText(SalesLine) THEN BEGIN
                        //#7664
                        SalesInvLine."No." := SalesLine."No.";
                    END;
                    IF SalesLine."Line Type" = SalesLine."Line Type"::Totaling THEN
                        SalesInvLine."No." := SalesLine."No.";
                    //#6796//
                END ELSE BEGIN
                    SalesInvLine.Type := SalesInvLine.Type::"G/L Account";
                    SalesInvLine."No." := PrepmtInvBuffer."G/L Account No.";
                    SalesInvLine."Line Type" := SalesLine."Line Type"::"G/L Account";
                    //#6319
                    IF SalesLine."Line Type" = SalesLine."Line Type"::Other THEN BEGIN
                        SalesInvLine."Line Type" := SalesInvLine."Line Type"::Other;
                    END;
                    //#6319//
                    SalesInvLine."Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
                    SalesInvLine."Shortcut Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";
                    SalesInvLine.Quantity := 1;
                    IF SalesHeader."Prices Including VAT" THEN BEGIN
                        SalesInvLine."Unit Price" := SalesLine."Prepmt. Amt. Incl. VAT";
                        SalesInvLine."Line Amount" := SalesLine."Prepmt. Amt. Incl. VAT";
                    END ELSE BEGIN
                        SalesInvLine."Unit Price" := SalesLine."Prepayment Amount";
                        SalesInvLine."Line Amount" := SalesLine."Prepayment Amount";
                    END;
                    SalesInvLine."Gen. Bus. Posting Group" := SalesLine."Gen. Bus. Posting Group";
                    SalesInvLine."Gen. Prod. Posting Group" := SalesLine."Gen. Prod. Posting Group";
                    SalesInvLine."VAT Bus. Posting Group" := SalesLine."VAT Bus. Posting Group";
                    SalesInvLine."VAT Prod. Posting Group" := SalesLine."VAT Prod. Posting Group";
                    SalesInvLine."VAT %" := SalesLine."Prepayment VAT %";
                    SalesInvLine.Amount := SalesLine."Prepayment Amount";
                    SalesInvLine."Amount Including VAT" := SalesLine."Prepmt. Amt. Incl. VAT";
                    SalesInvLine."VAT Calculation Type" := SalesLine."VAT Calculation Type";
                    SalesInvLine."VAT Base Amount" := SalesLine."Prepayment Amount";
                    SalesInvLine."VAT Identifier" := SalesLine."Prepayment VAT Identifier";
                    SalesInvLine."Order Quantity" := SalesLine.Quantity;
                    SalesInvLine."Order Amount" := SalesLine."Line Amount";
                    SalesInvLine."Job No." := SalesLine."Job No.";
                    SalesInvLine."Job Task No." := SalesLine."Job Task No.";
                    //#5259-----------------
                    IF SalesInvLine."Line Amount" <> 0 THEN
                        SalesInvLine."Prepayment %" := SalesLine."Prepayment %";
                    //#5259-----------------//
                    //#5349-----------------
                    SalesInvLine."Unit of Measure" := SalesLine."Unit of Measure";
                    //#5349-----------------//
                    //#5134-----------------
                    IF (SalesLine."Prepmt. Line Amount" = SalesLine."Prepmt. Amt. Inv.") THEN BEGIN
                        SalesInvLine."Line Amount" := 0;
                        SalesInvLine.Amount := 0;
                        SalesInvLine."Amount Including VAT" := 0;
                        SalesInvLine."VAT Base Amount" := 0;
                    END;
                    //#5134-----------------//
                END;

                CASE opDocumentType OF
                    opDocumentType::Invoice:
                        BEGIN
                            // FACTURE----------------------------------------
                            SalesInvLine."Invoiced Amount" := SalesLine."Prepmt. Line Amount";
                            //#5535
                            tTotPrepayment += SalesInvLine."Line Amount" - SalesInvLine."Inv. Discount Amount";
                            //#5535//

                            SalesInvLine.INSERT;
                            PostedDocTabNo := DATABASE::"Sales Invoice Line";
                        END;
                    opDocumentType::"Credit Memo":
                        BEGIN
                            // AVOIR----------------------------------------
                            SalesCrMemoLine.TRANSFERFIELDS(SalesInvLine);
                            SalesCrMemoLine."Document No." := SalesCrMemoHeader."No.";
                            //#8302 remonte...  +ONE+NEG_AMOUNT
                            SalesCrMemoLine."Invoiced Amount" := SalesLine."Prepmt. Amt. Inv.";
                            //#8302//
                            //#6639
                            IF NOT gReversal THEN BEGIN
                                //#8302 +ONE+NEG_AMOUNT
                                IF fCheckPartialCredit(DocumentType) THEN BEGIN
                                    IF NOT SalesHeader."Prices Including VAT" THEN BEGIN
                                        SalesCrMemoLine."Unit Price" := SalesLine."Prepmt. Amt. Inv." - SalesLine."Prepmt. Line Amount";
                                        SalesCrMemoLine."Line Amount" := SalesLine."Prepmt. Amt. Inv." - SalesLine."Prepmt. Line Amount";
                                        SalesCrMemoLine.Amount := SalesCrMemoLine."Line Amount";
                                        SalesCrMemoLine."VAT Base Amount" := SalesCrMemoLine.Amount;
                                        IF SalesCrMemoLine."Line Amount" <> 0 THEN BEGIN
                                            SalesCrMemoLine."Amount Including VAT" := PrepmtInvBuffer."Amount Incl. VAT";
                                            //SalesCrMemoLine."Invoiced Amount" := SalesCrMemoLine."Line Amount";
                                            SalesCrMemoLine."Invoiced Amount" := SalesLine."Prepmt. Line Amount";
                                        END;
                                    END ELSE BEGIN
                                        SalesCrMemoLine."Unit Price" := SalesLine."Prepmt. Amt. Incl. VAT" - SalesLine."Prepmt. Line Amount";
                                        SalesCrMemoLine."Line Amount" := SalesLine."Prepmt. Amt. Incl. VAT" - SalesLine."Prepmt. Line Amount";
                                        SalesCrMemoLine.Amount := SalesCrMemoLine."Line Amount";
                                        SalesCrMemoLine."VAT Base Amount" := PrepmtInvBuffer."VAT Amount";
                                        SalesCrMemoLine."Amount Including VAT" := PrepmtInvBuffer."Amount Incl. VAT";
                                        //SalesCrMemoLine."Invoiced Amount" := SalesCrMemoLine."Line Amount";
                                        SalesCrMemoLine."Invoiced Amount" := SalesLine."Prepmt. Line Amount";
                                    END;
                                END
                                ELSE BEGIN
                                    //#8302//
                                    IF NOT SalesHeader."Prices Including VAT" THEN
                                        SalesCrMemoLine."Line Amount" := SalesLine."Prepayment Amount"
                                    ELSE
                                        SalesCrMemoLine."Line Amount" := SalesLine."Prepmt. Amt. Incl. VAT";
                                    SalesCrMemoLine.Amount := SalesLine."Prepayment Amount";
                                    SalesCrMemoLine."Amount Including VAT" := SalesLine."Prepmt. Amt. Incl. VAT";
                                    //#8302 +ONE+NEG_AMOUNT
                                END;
                                //#8302//
                            END;
                            //#6639//
                            //#8302 ...remonte +ONE+NEG_AMOUNT          SalesCrMemoLine."Invoiced Amount" := SalesLine."Prepmt. Amt. Inv.";
                            SalesCrMemoLine.INSERT;
                            //#5535
                            tTotPrepayment += SalesCrMemoLine."Line Amount" - SalesCrMemoLine."Inv. Discount Amount";
                            //#5535//
                            PostedDocTabNo := DATABASE::"Sales Cr.Memo Line";

                        END;
                END;
                TempDimBuf.RESET;
                TempDimBuf.DELETEALL;
                DimBufMgt.GetDimensions(PrepmtInvBuffer."Dimension Set ID", TempDimBuf);
                // DimMgt.MoveDimBufToPostedDocDim(TempDimBuf, PostedDocTabNo, GenJnlLineDocNo, LineNo);
                LastLineNo := LineNo;

                //#5535
                IF SalesLine."Line Type" >= SalesLine."Line Type"::Item THEN
                    lTotOrderAmount += ROUND((SalesLine."Line Amount" - SalesLine."Inv. Discount Amount") *
                                     (1 + (SalesLine."VAT %" / 100)), 0.01);
            //#5535//

            UNTIL SalesLine.NEXT = 0;
        END;
        //+ONE+PREPAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnAfterPostPrepmtInvLineBuffer', '', true, true)]
    local procedure OnAfterPostPrepmtInvLineBuffer(var GenJnlLine: Record "Gen. Journal Line"; PrepmtInvLineBuffer: Record "Prepayment Inv. Line Buffer"; CommitIsSuppressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        lGLAccount: Record "G/L Account";
        lJobJnlLine: Record "Job Journal Line";
    //lJobTransferLine: Record "Job Transfer Line";
    begin
        //+ONE+PREPAYMENT
        //#6332
        //    IF (GenJnlLine."Job No." <> '') AND (GenJnlLine.Amount <> 0) THEN BEGIN
        IF GenJnlLine."Account No." <> lGLAccount."No." THEN
            lGLAccount.GET(GenJnlLine."Account No.");
        IF (GenJnlLine."Job No." <> '') AND (GenJnlLine.Amount <> 0) AND lGLAccount."Post Job Entry" THEN BEGIN
            //#6332//
            lJobJnlLine.INIT;
            // lJobTransferLine.FromGenJnlLineToJnlLine(GenJnlLine, lJobJnlLine);
            //#5702
            IF gPrepaymentRankNo = 0 THEN
                //#5702//
                fRunJobJnlPostLine(lJobJnlLine, PrepmtInvLineBuffer."Dimension Set ID");
        END;
        //+ONE+PREPAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnBeforePostCustomerEntry', '', true, true)]
    local procedure OnBeforePostCustomerEntry(var GenJnlLine: Record "Gen. Journal Line"; TotalPrepmtInvLineBuffer: Record "Prepayment Inv. Line Buffer"; TotalPrepmtInvLineBufferLCY: Record "Prepayment Inv. Line Buffer"; CommitIsSuppressed: Boolean; SalesHeader: Record "Sales Header"; DocumentType: Option Invoice,"Credit Memo")
    begin
        //+ONE+PREPAYMENT
        GenJnlLine."Job No." := TotalPrepmtInvLineBuffer."Job No.";
        IF gReversal THEN BEGIN
            //#8302 +ONE+NEG_AMOUNT
            IF DocumentType = DocumentType::"Credit Memo" THEN BEGIN
                //#8302//
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := gSalesInvoiceHeader."No.";
                //#8302 +ONE+NEG_AMOUNT
            END ELSE BEGIN
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::"Credit Memo";
                GenJnlLine."Applies-to Doc. No." := gSalesCrMemoHeader."No.";
            END;
            //#8302//
        END;
        GenJnlLine."Apply-to Sales Order No." := SalesHeader."No.";
        //+ONE+PREPAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnPostBalancingEntryOnBeforeGenJnlPostLineRunWithCheck', '', true, true)]
    local procedure OnPostBalancingEntryOnBeforeGenJnlPostLineRunWithCheck(var GenJnlLine: Record "Gen. Journal Line"; CustLedgEntry: Record "Cust. Ledger Entry"; TotalPrepmtInvLineBuffer: Record "Prepayment Inv. Line Buffer"; TotalPrepmtInvLineBufferLCY: Record "Prepayment Inv. Line Buffer"; CommitIsSuppressed: Boolean; SalesHeader: Record "Sales Header"; DocType: enum "Gen. Journal Document Type")
    begin
        //+ONE+PREPAYMENT (#5174)
        GenJnlLine."Job No." := TotalPrepmtInvLineBuffer."Job No.";
        //#6175
        GenJnlLine."Due Date" := SalesHeader."Due Date";
        //#6175//
        //+ONE+PREPAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnAfterPostBalancingEntry', '', true, true)]
    local procedure OnAfterPostBalancingEntry(var GenJnlLine: Record "Gen. Journal Line"; CustLedgEntry: Record "Cust. Ledger Entry"; TotalPrepmtInvLineBuffer: Record "Prepayment Inv. Line Buffer"; TotalPrepmtInvLineBufferLCY: Record "Prepayment Inv. Line Buffer"; CommitIsSuppressed: Boolean; SalesHeader: Record "Sales Header")
    var
        TempDocDim: Record "Gen. Jnl. Dim. Filter";
    begin
        //+ONE+PREPAYMENT
        IF NOT gReversal THEN
            //#5702
            IF gPrepaymentRankNo = 0 THEN
                //#5702//
                fDirectPayment(SalesHeader, GenJnlLine, TempDocDim, TotalPrepmtInvLineBuffer."Amount Incl. VAT");
        //+ONE+PREPAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnAfterApplyFilter', '', true, true)]
    local procedure OnAfterApplyFilter(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; DocumentType: Option)
    var
        opDocumentType: Option Invoice,"Credit Memo",Statistic;
    begin
        opDocumentType := DocumentType;
        SalesLine.Reset();
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetFilter(Type, '<>%1', SalesLine.Type::" ");
        //#5866---------//
        //+ONE+PREPAYMENT
        IF opDocumentType = opDocumentType::Statistic THEN BEGIN
            SalesLine.SETRANGE(Type);
            SalesLine.SETRANGE("Prepmt. Line Amount");
        END;
        SalesLine.SETRANGE("Structure Line No.", 0);
        //#7596
        //#7596
        SalesLine.SETFILTER("Order Date", '..%1|%2', SalesHeader."Document Date", 0D);
        //#7596//

        //#7596//
        //+ONE+PREPAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnBeforePrepmtAmount', '', true, true)]
    local procedure OnBeforePrepmtAmount(var SalesLine: Record "Sales Line"; DocumentType: Option Invoice,"Credit Memo",Statistic; var Result: Decimal; var IsHandled: Boolean);
    begin
        case DocumentType of
            DocumentType::Statistic:
                Result := SalesLine."Prepmt. Line Amount";
            DocumentType::Invoice:
                Result := SalesLine."Prepmt. Line Amount" - SalesLine."Prepmt. Amt. Inv.";
            else
                //+ONE+PREPAYMENT
                IF gReversal THEN
                    Result := -(SalesLine."Prepmt. Line Amount" - SalesLine."Prepmt. Amt. Inv.")
                ELSE
                    //+ONE+PREPAYMENT//
                    //#8302 +ONE+NEG_AMOUNT
                    IF (SalesLine."Line Amount" < 0) THEN
                        Result := SalesLine."Prepmt. Line Amount"
                    ELSE
                        //#8302//
                       Result := SalesLine."Prepmt. Amt. Inv." - SalesLine."Prepmt Amt Deducted";
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnBeforeCheckSalesLineIsNegative', '', true, true)]
    local procedure OnBeforeCheckSalesLineIsNegative(SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        lPrepmtAmount: Decimal;
    begin
        //#9310
        // IF (gNegativeAmount) AND (SalesLine."Prepmt. Line Amount" <> 0) AND (SalesLine."Prepmt. Amt. Inv." = 0) THEN
        //     lPrepmtAmount := (SalesLine."Prepmt. Line Amount" <> 0)
        // ELSE
        //     lPrepmtAmount := (PrepmtAmount(SalesLine, DocumentType) <> 0);
        // //      IF PrepmtAmount(SalesLine,DocumentType) <> 0 THEN BEGIN
        // IF lPrepmtAmount THEN
        //#9310//
        //+ONE+PREPAYMENT
        IF NOT (SalesLine.Type IN [SalesLine.Type::"G/L Account", SalesLine.Type::Item, SalesLine.Type::Resource]) THEN
            IsHandled := false
        else
            IsHandled := true;
        //+ONE+PREPAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnAfterFillInvLineBuffer', '', true, true)]
    local procedure OnAfterFillInvLineBuffer(var PrepmtInvLineBuf: Record "Prepayment Inv. Line Buffer"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; SalesHeader: Record "Sales Header")
    begin
        //#8350
        //  "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
        PrepmtInvLineBuf."Gen. Prod. Posting Group" := SalesLine."Gen. Prod. Posting Group";
        //#8361//
        //#7671
        //+ONE+PREPAYMENT
        //  "VAT Prod. Posting Group" := GLAcc."VAT Prod. Posting Group";
        PrepmtInvLineBuf."VAT Prod. Posting Group" := SalesLine."VAT Prod. Posting Group";
        //+ONE+PREPAYMENT//
        //#7671//

        //+ONE+PREPAYMENT
        PrepmtInvLineBuf."Job Task No." := SalesLine."Job Task No.";
        //+ONE+PREPAYMENT//

        //#8141
        PrepmtInvLineBuf.Marker := SalesLine.Marker;
        //#8141//
    end;


    [EventSubscriber(ObjectType::table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromPrepmtInvBuffer', '', true, true)]
    local procedure OnAfterCopyGenJnlLineFromPrepmtInvBuffer(PrepmtInvLineBuffer: Record "Prepayment Inv. Line Buffer"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        //+ONE+PREPAYMENT
        //#8018?
        GenJournalLine.VALIDATE("Job No.", PrepmtInvLineBuffer."Job No.");
        GenJournalLine.VALIDATE("Job Task No.", PrepmtInvLineBuffer."Job Task No.");
        GenJournalLine.VALIDATE("Job Total Cost (LCY)", PrepmtInvLineBuffer.Amount);
        GenJournalLine.VALIDATE(Amount);
        //#8018
        //+ONE+PREPAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnCodeOnBeforeWindowOpen', '', true, true)]
    local procedure OnCodeOnBeforeWindowOpen(var SalesHeader: Record "Sales Header"; DocumentType: Option Invoice,"Credit Memo")
    var
        lSalesLine: Record "Sales Line";
        lSalesInvoiceLine: Record "Sales Invoice Line";
        lContract: Record "Contract Type";
        CduSalespostprep: Codeunit "Sales-Post Prepayments";
    begin
        //+ONE+PREPAYMENT
        //----------------------------------------------------
        // gestion du Nø de situation suivant type de doc
        // -Facture
        // -Avoir global
        // -annulation situation pr‚c‚dente (avoir)
        //-----------------------------------------------------
        IF DocumentType = DocumentType::Invoice THEN BEGIN
            // FACTURE------------------------------
            //5702--------------
            //"No. Prepayment Invoiced" += 1;
            IF gPrepaymentRankNo = 0 THEN
                SalesHeader."No. Prepayment Invoiced" += 1
            ELSE
                SalesHeader."No. Prepayment Invoiced" += gPrepaymentRankNo;
            //5702---------------//
            SalesHeader."Prepmt. Posting Description" :=
              COPYSTR(
                STRSUBSTNO(tPostDescInvoice, SELECTSTR(1 + DocumentType, Text019), SalesHeader."Document Type", SalesHeader."No.", SalesHeader."No. Prepayment Invoiced"),
                1, MAXSTRLEN(SalesHeader."Posting Description"));

            //#7688
            IF lContract.GET(SalesHeader."Contract Type") THEN BEGIN
                IF lContract."Invoicing Method" = lContract."Invoicing Method"::Completion THEN BEGIN
                    IF lContract."Completion Posting Description" <> '' THEN BEGIN
                        SalesHeader."Prepmt. Posting Description" := lContract."Completion Posting Description";
                        SalesHeader."Prepmt. Posting Description" := SalesHeader.wShowPostingDescription(SalesHeader."Prepmt. Posting Description");
                    END;
                END;
            END;
            //#7688//
            //#8302 +ONE+NEG_AMOUNT
            IF gReversal THEN BEGIN
                fReversalCrMemoFromCrMemo(SalesHeader, DocumentType);
                //#8302
                SalesHeader."Prepmt. Posting Description" :=
                  COPYSTR(
                    STRSUBSTNO(tNegInvoiceCancel, SELECTSTR(1 + DocumentType, Text019), SalesHeader."No. Prepayment Invoiced" + 1, SalesHeader."No."),
                    1, MAXSTRLEN(SalesHeader."Posting Description"));
            END;
            //#8302//
            // AVOIR------------------------------
        END ELSE IF NOT gReversal THEN BEGIN
            //#8302 +ONE+NEG_AMOUNT
            IF gPartialCredit THEN BEGIN
                SalesHeader."No. Prepayment Invoiced" += 1;
                SalesHeader."Prepmt. Posting Description" :=
                  COPYSTR(
                    STRSUBSTNO(tNegInvoice, SELECTSTR(1 + DocumentType, Text019), SalesHeader."No. Prepayment Invoiced", SalesHeader."Job Description"),
                    1, MAXSTRLEN(SalesHeader."Posting Description"));
            END ELSE BEGIN
                //#8302//
                SalesHeader."No. Prepayment Invoiced" := 0;
                SalesHeader."Prepmt. Posting Description" :=
                  COPYSTR(
                    STRSUBSTNO(tPostDescCrMemo, SELECTSTR(1 + DocumentType, Text019), SalesHeader."Document Type", SalesHeader."No."),
                    1, MAXSTRLEN(SalesHeader."Posting Description"));
                //#8302 +ONE+NEG_AMOUNT
            END
            //#8302//
        END ELSE BEGIN
            SalesHeader."No. Prepayment Invoiced" -= 1;
            //#8302 +ONE+NEG_AMOUNT
            IF gPartialCredit THEN
                SalesHeader."Prepmt. Posting Description" :=
                  COPYSTR(
                    STRSUBSTNO(tNegInvoice, DocumentType, SalesHeader."No. Prepayment Invoiced", SalesHeader."Job Description"),
                    1, MAXSTRLEN(SalesHeader."Posting Description"))
            ELSE
                //#8302//
                SalesHeader."Prepmt. Posting Description" :=
            COPYSTR(
              STRSUBSTNO(tPostDescReversal, SELECTSTR(1 + DocumentType, Text019), SalesHeader."Document Type", SalesHeader."No.", SalesHeader."No. Prepayment Invoiced"),
              1, MAXSTRLEN(SalesHeader."Posting Description"));
            lSalesLine.SuspendStatusCheck(TRUE);
            lSalesLine.fPrepaymentReversal(TRUE);
            lSalesInvoiceLine.SETRANGE("Document No.", gSalesInvoiceHeader."No.");
            lSalesInvoiceLine.SETFILTER("Prepayment Order Line No.", '<>0');
            lSalesInvoiceLine.SETFILTER(Amount, '<>0');
            IF lSalesInvoiceLine.FINDSET THEN
                REPEAT
                    lSalesLine.GET(
                      SalesHeader."Document Type"::Order, gSalesInvoiceHeader."Prepayment Order No.", lSalesInvoiceLine."Prepayment Order Line No.");
                    //#7210
                    //        lSalesLine.VALIDATE("Prepmt. Line Amount",lSalesLine."Prepmt. Line Amount" - lSalesInvoiceLine.Amount);
                    IF gSalesInvoiceHeader."Prices Including VAT" THEN
                        lSalesLine.VALIDATE("Prepmt. Line Amount", lSalesLine."Prepmt. Line Amount" - lSalesInvoiceLine."Amount Including VAT")
                    ELSE
                        lSalesLine.VALIDATE("Prepmt. Line Amount", lSalesLine."Prepmt. Line Amount" - lSalesInvoiceLine.Amount);
                    //#7210//
                    lSalesLine.MODIFY;
                UNTIL lSalesInvoiceLine.NEXT = 0;
            IF NOT CduSalespostprep.CheckOpenPrepaymentLines(SalesHeader, DocumentType) THEN
                ERROR(Text001);
        END;
        //+ONE+PREPAYMENT//
    end;


    var
        myInt: Integer;
        gReversal: Boolean;
        gSalesInvoiceHeader: Record "Sales Invoice Header";
        tPostDescInvoice: Label 'Invoice Prepayment No. %4, %2 %3.';
        tPostDescCrMemo: Label 'Prepayment Cr. Memo, %2 %3.';
        tPostDescReversal: Label 'Cr. Memo Prepayment No. %4, %2 %3.';
        tDirectPaiementFrom: Label 'Direct Payment from %1';
        tDirectPaiementTo: Label 'Direct Payment to %1';
        tDirectPaymentReversal: Label 'Direct Payment Reversal';
        tReverseDirectInvError: Label 'You must make a global credit memo to cancel the prepayment';
        gPrepaymentRankNo: Integer;
        gPartialCredit: Boolean;
        gSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        tNegInvoice: Label '%1 Sit. n°%2 - %3';
        tNegInvoiceCancel: Label '%1, Annulation Sit. n°%2, Cde %3';
        gNegativeAmount: Boolean;
        gTempVATAmountLine: Record "VAT Amount Line" temporary;
        Text019: Label 'Invoice,Credit Memo';
        Text001: Label 'There is nothing to post.';
        CduSalespostprep: Codeunit "Sales-Post Prepayments";

    PROCEDURE fReversal(VAR pSalesHeader: Record "Sales Header"; VAR pSalesInvoiceHeader: Record "Sales Invoice Header");
    VAR
        lSalesLine: Record "Sales Line";
        lSalesInvoiceLine: Record "Sales Invoice Line";
        lPrepaymentManagement: Codeunit "Prepayment Management";
    BEGIN
        gReversal := TRUE;
        gSalesInvoiceHeader := pSalesInvoiceHeader;
        //#6249
        lPrepaymentManagement.ResetSalesLine(pSalesHeader);
        //#6249//
        //#6251
        //pSalesHeader."Posting Date" := pSalesInvoiceHeader."Posting Date";
        //#6251//
        //Fonction standard local
        // Code(pSalesHeader, 1);
    END;

    PROCEDURE fDirectPayment(VAR pSalesHeader: Record "Sales Header"; VAR pGenJnlLine: Record "Gen. Journal Line"; VAR pTempDocDim: Record "Gen. Jnl. Dim. Filter"; pAmountInclVAT: Decimal);
    VAR
        lFractionation: Record Fractionation;
        lRetention: Record Retention;
        lVendor: Record Vendor;
        lVendorLedgerEntry: Record "Vendor Ledger Entry";
        lLineNo: Integer;
        lSalesInvoiceLine: Record "Sales Invoice Line";
        lGenJnlLine: Record "Gen. Journal Line";
        lDimMgt: Codeunit DimensionManagement;
        lTempJnlLineDim: Record "Dim. Value per Account" TEMPORARY;
        lLedgerEntryDim: Record "Dimension Set ID Filter Line";
        lTempDocDim: Record "Gen. Jnl. Dim. Filter" TEMPORARY;
        lCurrency: Record Currency;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    BEGIN
        IF pSalesHeader."Currency Code" <> '' THEN
            lCurrency.GET(pSalesHeader."Currency Code")
        ELSE
            lCurrency.InitRoundingPrecision;
        lFractionation.SETRANGE("Payment Terms Code", pSalesHeader."Payment Terms Code");
        lFractionation.SETFILTER("Retention Code", '<>%1', '');
        IF lFractionation.FINDSET THEN BEGIN
            REPEAT
                lRetention.GET(lFractionation."Retention Code");
                // Append SalesInvoiceLine
                lLineNo += 10000;
                lSalesInvoiceLine."Document No." := pGenJnlLine."Document No.";
                lSalesInvoiceLine."Line No." := lLineNo + 2000000000; // Placed at the end
                lSalesInvoiceLine."Sell-to Customer No." := pSalesHeader."Sell-to Customer No.";
                lSalesInvoiceLine.Description :=
                  STRSUBSTNO('%1 %2%', lRetention.Description, FORMAT(lFractionation."Fractionation %", 0, '<Precision,0:2><Standard Format,0>'));
                lSalesInvoiceLine."Prepayment Order No." := pSalesHeader."No.";
                lSalesInvoiceLine."Line Amount" :=
                  ROUND(pAmountInclVAT * lFractionation."Fractionation %" / 100, lCurrency."Amount Rounding Precision");
                lSalesInvoiceLine.INSERT;
            UNTIL lFractionation.NEXT = 0;
        END;

        lVendorLedgerEntry.SETCURRENTKEY("Apply-to Sales Order No.");
        lVendorLedgerEntry.SETRANGE("Apply-to Sales Order No.", pSalesHeader."No.");
        lVendorLedgerEntry.SETRANGE(Open, TRUE);
        lVendorLedgerEntry.SETRANGE("On Hold", '');
        lVendorLedgerEntry.SETRANGE("Posting Date", 0D, pSalesHeader."Posting Date");
        lVendorLedgerEntry.SETRANGE("Currency Code", pSalesHeader."Currency Code");
        IF lVendorLedgerEntry.FINDSET THEN
            REPEAT
                lVendorLedgerEntry.CALCFIELDS("Remaining Amount");
                IF lVendorLedgerEntry."Vendor No." <> lVendor."No." THEN
                    IF NOT lVendor.GET(lVendorLedgerEntry."Vendor No.") THEN
                        lVendor.INIT;

                // Append SalesInvoiceLine
                lLineNo += 10000;
                lSalesInvoiceLine."Document No." := pGenJnlLine."Document No.";
                lSalesInvoiceLine."Line No." := lLineNo + 2000000000; // Placed at the end
                lSalesInvoiceLine."Sell-to Customer No." := pSalesHeader."Sell-to Customer No.";
                lSalesInvoiceLine.Description := lVendor.Name;
                lSalesInvoiceLine."Prepayment Order No." := pSalesHeader."No.";
                // lSalesInvoiceLine."Cross-Reference No." := lVendorLedgerEntry."External Document No.";
                lSalesInvoiceLine."Vendor Ledger Entry No." := lVendorLedgerEntry."Entry No.";
                lSalesInvoiceLine."Line Amount" := lVendorLedgerEntry."Remaining Amount";
                lSalesInvoiceLine.INSERT;

                // Apply Direct Payment
                WITH lGenJnlLine DO BEGIN
                    INIT;
                    "Document No." := pGenJnlLine."Document No.";
                    "Posting Date" := pGenJnlLine."Posting Date";
                    "Document Date" := pGenJnlLine."Document Date";
                    "Source Code" := pGenJnlLine."Source Code";
                    "Posting No. Series" := pGenJnlLine."Posting No. Series";
                    "System-Created Entry" := TRUE;
                    "Currency Code" := pGenJnlLine."Currency Code";
                    "Currency Factor" := pGenJnlLine."Currency Factor";
                    "Job No." := pGenJnlLine."Job No.";
                    //#5933
                    pGenJnlLine."Apply-to Sales Order No." := pSalesHeader."No.";
                    //#5933//
                END;

                // Vendor
                lGenJnlLine."Document Type" := lGenJnlLine."Document Type"::Payment;
                lGenJnlLine."Account Type" := lGenJnlLine."Account Type"::Vendor;
                //#5818
                //    lGenJnlLine."Account No." := lVendorLedgerEntry."Vendor No.";
                lGenJnlLine.VALIDATE("Account No.", lVendorLedgerEntry."Vendor No.");
                //#5818//
                //#7370
                lGenJnlLine."Job No." := pGenJnlLine."Job No.";
                //#7370//
                IF gReversal THEN BEGIN
                    lGenJnlLine."External Document No." := lVendorLedgerEntry."External Document No.";
                    lVendorLedgerEntry."External Document No." :=
                      COPYSTR('*' + lVendorLedgerEntry."External Document No.", 1, MAXSTRLEN(lVendorLedgerEntry."External Document No."));
                    lVendorLedgerEntry.MODIFY;
                    lGenJnlLine."Document Type" := lGenJnlLine."Document Type"::Payment;
                    lGenJnlLine.Description := tDirectPaymentReversal;
                    lGenJnlLine.Amount := -lVendorLedgerEntry."Closed by Amount";
                END ELSE BEGIN
                    lGenJnlLine."Document Type" := lGenJnlLine."Document Type"::Payment;
                    lGenJnlLine.Description :=
                      COPYSTR(STRSUBSTNO(tDirectPaiementFrom, pSalesHeader."Bill-to Name"), 1, MAXSTRLEN(lGenJnlLine.Description));
                    lGenJnlLine."Applies-to Doc. Type" := lVendorLedgerEntry."Document Type";
                    lGenJnlLine."Applies-to Doc. No." := lVendorLedgerEntry."Document No.";
                    lGenJnlLine.Amount := -lVendorLedgerEntry."Remaining Amount";
                    ;
                END;

                IF lVendorLedgerEntry."Currency Code" = '' THEN
                    lGenJnlLine."Amount (LCY)" := lGenJnlLine.Amount
                ELSE
                    lGenJnlLine."Amount (LCY)" := ROUND(lGenJnlLine.Amount / lGenJnlLine."Currency Factor");

                lTempJnlLineDim.DELETEALL;
                //   lLedgerEntryDim.SETRANGE(lLedgerEntryDim."Table ID", DATABASE::"Vendor Ledger Entry");
                //  lLedgerEntryDim.SETRANGE(lLedgerEntryDim."Entry No.", lVendorLedgerEntry."Entry No.");
                // lDimMgt.CopyLedgEntryDimToJnlLineDim(lLedgerEntryDim, lTempJnlLineDim);
                GenJnlPostLine.RunWithCheck(lGenJnlLine);

                // Customer
                lGenJnlLine."Account Type" := lGenJnlLine."Account Type"::Customer;
                //#5818
                //    lGenJnlLine."Account No." := pSalesHeader."Bill-to Customer No.";
                lGenJnlLine.VALIDATE("Account No.", pSalesHeader."Bill-to Customer No.");
                //#5818//
                //#7370
                lGenJnlLine."Job No." := pGenJnlLine."Job No.";
                //#7370//
                lGenJnlLine.Amount := -lGenJnlLine.Amount;
                lGenJnlLine."Amount (LCY)" := -lGenJnlLine."Amount (LCY)";
                lGenJnlLine.Description :=
                  COPYSTR(STRSUBSTNO(tDirectPaiementTo, lVendor.Name), 1, MAXSTRLEN(lGenJnlLine.Description));
                IF gReversal THEN BEGIN
                    lGenJnlLine."Applies-to Doc. Type" := lGenJnlLine."Applies-to Doc. Type"::"Credit Memo";
                    lGenJnlLine."Applies-to Doc. No." := pSalesHeader."Prepmt. Cr. Memo No.";
                END ELSE BEGIN
                    lGenJnlLine."Applies-to Doc. Type" := lGenJnlLine."Applies-to Doc. Type"::Invoice;
                    lGenJnlLine."Applies-to Doc. No." := pSalesHeader."Prepayment No.";
                END;
                lTempJnlLineDim.DELETEALL;
                //  pTempDocDim.SETRANGE("Table ID", DATABASE::"Sales Header");
                //lDimMgt.CopyDocDimToJnlLineDim(pTempDocDim, lTempJnlLineDim);
                GenJnlPostLine.RunWithCheck(lGenJnlLine);

            UNTIL lVendorLedgerEntry.NEXT = 0;

    END;

    LOCAL PROCEDURE fRunJobJnlPostLine(VAR pJobJnlLine: Record "Job Journal Line"; DimEntryNo: Integer);
    VAR
        lTempDimBuf: Record "Dimension Buffer" TEMPORARY;
        lTempJnlLineDim: Record "Dim. Value per Account" TEMPORARY;
        lDimMgt: Codeunit DimensionManagement;
        lJobJnlPostLine: Codeunit "Job Jnl.-Post Line2";
    BEGIN
        lTempDimBuf.INIT;
        lTempJnlLineDim.INIT;
        //  DimBufMgt.GetDimensions(DimEntryNo, lTempDimBuf);
        // lDimMgt.CopyDimBufToJnlLineDim(
        //   lTempDimBuf, lTempJnlLineDim, pJobJnlLine."Journal Template Name",
        //   pJobJnlLine."Journal Batch Name", pJobJnlLine."Line No.");
        // lJobJnlPostLine.RunWithCheck(pJobJnlLine, lTempJnlLineDim);
    END;

    PROCEDURE fSetPrepaymentRankNo(VAR pSalesHeader: Record "Sales Header"; pPrepaymentRankNo: Integer);
    BEGIN
        pSalesHeader.TESTFIELD("No. Prepayment Invoiced", 0);
        gPrepaymentRankNo := pPrepaymentRankNo;
        //#7124
        //FOCNTION standard local
        //Code(pSalesHeader, 0);
        //#7124//
    END;

    LOCAL PROCEDURE fDescriptionLine(pOldDocNo: Code[20]; pNewDocNo: Code[20]; pDocType: Option Invoice,"Credit Memo");
    VAR
        lDescriptionLine: Record "Description Line";
        lNewDescriptionLine: Record "Description Line";
    BEGIN
        //#6257
        lDescriptionLine.SETRANGE("Table ID", 36);
        lDescriptionLine.SETRANGE("Document Type", 1);
        lDescriptionLine.SETRANGE("Document No.", pOldDocNo);
        IF lDescriptionLine.FIND('-') THEN BEGIN
            //#6386
            REPEAT
                IF pDocType = pDocType::Invoice THEN
                    lNewDescriptionLine."Table ID" := DATABASE::"Sales Invoice Header"
                ELSE
                    lNewDescriptionLine."Table ID" := DATABASE::"Sales Cr.Memo Header";
                //#6386//
                lNewDescriptionLine."Document Type" := 2;
                lNewDescriptionLine."Document No." := pNewDocNo;
                lNewDescriptionLine."Document Line No." := 0;
                lNewDescriptionLine."Line No." := lDescriptionLine."Line No.";
                lNewDescriptionLine.Description := lDescriptionLine.Description;
                lNewDescriptionLine.INSERT;
            //#6386
            UNTIL lDescriptionLine.NEXT = 0;
            //#6386//
        END;
    END;

    PROCEDURE fCtrlTitleRider(pSalesInvoiceLine: Record "Sales Invoice Line"): Boolean;
    BEGIN
        IF ((pSalesInvoiceLine."Line Type" = pSalesInvoiceLine."Line Type"::" ")
              AND (pSalesInvoiceLine."Rider Rank" > 0)
              AND (pSalesInvoiceLine.Level = 1)
              AND (pSalesInvoiceLine."Attached to Line No." = 0))
            OR (pSalesInvoiceLine."No." = '-') THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    END;

    PROCEDURE fPrepaymentAmount(SalesHeader: Record "Sales Header"; DocumentType: Option Invoice,"Credit Memo") retour: Decimal;
    VAR
        SalesLine: Record "Sales Line";
        CduSalespostprep: Codeunit "Sales-Post Prepayments";
    BEGIN
        retour := 0;
        WITH SalesLine DO BEGIN
            CduSalespostprep.ApplyFilter(SalesHeader, DocumentType, SalesLine);
            IF FIND('-') THEN BEGIN
                REPEAT
                    retour += CduSalespostprep.PrepmtAmount(SalesLine, DocumentType);
                UNTIL NEXT = 0;
            END;
        END;
    END;

    PROCEDURE fCtrlStandardText(pSalesLine: Record "Sales Line"): Boolean;
    BEGIN
        //#7625\\
        IF ((pSalesLine.Type = pSalesLine.Type::" ") AND
            (pSalesLine."Line Type" = pSalesLine."Line Type"::" ") AND
            (pSalesLine."Attached to Line No." = 0) AND
            (pSalesLine.Level = 1) AND
            (pSalesLine."No." <> '')) THEN
            EXIT(TRUE);
    END;

    PROCEDURE fCheckPartialCredit(DocumentType: option Invoice,"Credit Memo"): Boolean;
    BEGIN
        //#8302 +ONE+NEG_AMOUNT\\
        IF gPartialCredit AND
            (DocumentType = DocumentType::"Credit Memo") AND
            NOT gReversal THEN
            EXIT(TRUE);
    END;

    PROCEDURE fCheckAmount(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; VAR DocumentType: Option Invoice,"Credit Memo",Statistic);
    VAR
        lPreAmount: Decimal;
        CduSalespostprep: Codeunit "Sales-Post Prepayments";
    BEGIN
        //#8302 +ONE+NEG_AMOUNT\\
        WITH SalesLine DO BEGIN
            CduSalespostprep.ApplyFilter(SalesHeader, DocumentType, SalesLine);
            IF FIND('-') THEN
                REPEAT
                    lPreAmount += (SalesLine."Prepmt. Line Amount" - SalesLine."Prepmt. Amt. Inv.");
                UNTIL NEXT = 0;
        END;
        gPartialCredit := (lPreAmount < 0);
        //#9077
        gNegativeAmount := gPartialCredit;
        //#9077//
        IF gPartialCredit THEN
            DocumentType := DocumentType::"Credit Memo";
    END;

    PROCEDURE fCrMemoReversal(VAR pSalesHeader: Record "Sales Header"; VAR pSalesCrMemoHeader: Record "Sales Cr.Memo Header");
    VAR
        lSalesLine: Record "Sales Line";
        lSalesCrMemoLine: Record "Sales Cr.Memo Line";
        lPrepaymentManagement: Codeunit "Prepayment Management";
    BEGIN
        //#8302 +ONE+NEG_AMOUNT\\
        gReversal := TRUE;
        gSalesCrMemoHeader := pSalesCrMemoHeader;

        lPrepaymentManagement.ResetSalesLine(pSalesHeader);
        //FONCTION STANDARD LOCAL
        //Code(pSalesHeader,0);
    END;

    PROCEDURE fReversalCrMemoFromCrMemo(VAR pSalesHeader: Record "Sales Header"; pDocumentType: OPTION Invoice,"Credit Memo");
    VAR
        lSalesLine: Record "Sales Line";
        lSalesCrMemoLine: Record "Sales Cr.Memo Line";
    BEGIN
        //#8302 +ONE+NEG_AMOUNT\\
        pSalesHeader."No. Prepayment Invoiced" -= 2;
        lSalesLine.SuspendStatusCheck(TRUE);
        lSalesLine.fPrepaymentReversal(TRUE);
        lSalesCrMemoLine.SETRANGE("Document No.", gSalesCrMemoHeader."No.");
        lSalesCrMemoLine.SETFILTER("Prepayment Order Line No.", '<>0');
        lSalesCrMemoLine.SETFILTER(Amount, '<>0');
        IF lSalesCrMemoLine.FINDSET THEN
            REPEAT
                lSalesLine.GET(
                  pSalesHeader."Document Type"::Order, gSalesCrMemoHeader."Prepayment Order No.", lSalesCrMemoLine."Prepayment Order Line No.");
                IF gSalesCrMemoHeader."Prices Including VAT" THEN
                    lSalesLine.VALIDATE("Prepmt. Line Amount", lSalesLine."Prepmt. Line Amount" + lSalesCrMemoLine."Amount Including VAT")
                ELSE
                    lSalesLine.VALIDATE("Prepmt. Line Amount", lSalesLine."Prepmt. Line Amount" + lSalesCrMemoLine.Amount);
                lSalesLine.MODIFY;
            UNTIL lSalesCrMemoLine.NEXT = 0;
    END;

    LOCAL PROCEDURE fReversalToVATAmountLines(pSalesHeader: Record "Sales Header"; pSalesLine: Record "Sales Line"; VAR VATAmountLine: Record "VAT Amount Line"; DocumentType: Option Invoice,"Credit Memo",Statistic);
    VAR
        lSalesInvLine: Record "Sales Invoice Line";
        lSalesCrMemoLine: Record "Sales Cr.Memo Line";
        PrevVatAmountLine: Record "VAT Amount Line";
        Currency: Record Currency;
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        NewAmount: Decimal;
        NewPrepmtVATDiffAmt: Decimal;
        CduSalespostprep: Codeunit "Sales-Post Prepayments";
    BEGIN
        //#9177\\
        //Extourne : alimente la table des totaux VAT directement avec le document d'origine
        IF NOT gReversal THEN
            EXIT;

        IF pSalesHeader."Currency Code" = '' THEN
            Currency.InitRoundingPrecision
        ELSE
            Currency.GET(pSalesHeader."Currency Code");

        VATAmountLine.DELETEALL;

        WITH pSalesLine DO BEGIN
            CduSalespostprep.ApplyFilter(pSalesHeader, DocumentType, pSalesLine);
            IF FIND('-') THEN
                REPEAT
                    IF "Prepmt. VAT Calc. Type" IN
                       ["VAT Calculation Type"::"Reverse Charge VAT", "VAT Calculation Type"::"Sales Tax"]
                    THEN
                        "VAT %" := 0;
                    IF NOT VATAmountLine.GET(
                         "Prepayment VAT Identifier",
                         "Prepmt. VAT Calc. Type",
                         "Prepayment Tax Group Code",
                         FALSE,
                         //#9077 +ONE+NEG_AMOUNT
                         //NewAmount >= 0)
                         NOT gNegativeAmount)
                    //#9077//
                    THEN BEGIN
                        VATAmountLine.INIT;
                        VATAmountLine."VAT Identifier" := "Prepayment VAT Identifier";
                        VATAmountLine."VAT Calculation Type" := "Prepmt. VAT Calc. Type";
                        VATAmountLine."Tax Group Code" := "Prepayment Tax Group Code";
                        VATAmountLine."VAT %" := "Prepayment VAT %";
                        VATAmountLine.Modified := TRUE;
                        //#9077 +ONE+NEG_AMOUNT
                        //VATAmountLine.Positive := NewAmount >= 0;
                        VATAmountLine.Positive := NOT gNegativeAmount;
                        //#9077//
                        VATAmountLine."Includes Prepayment" := TRUE;
                        VATAmountLine.INSERT;
                    END;

                    //Recuperation des montants des lignes de Facture ou Avoir
                    IF gSalesCrMemoHeader."No." <> '' THEN BEGIN
                        // recherche Avoir a extourner
                        lSalesCrMemoLine.SETRANGE("Document No.", gSalesCrMemoHeader."No.");
                        lSalesCrMemoLine.SETRANGE("Prepayment Order No.", pSalesHeader."No.");
                        lSalesCrMemoLine.SETRANGE("Prepayment Order Line No.", pSalesLine."Line No.");
                        IF lSalesCrMemoLine.FIND('+') THEN BEGIN
                            VATAmountLine."VAT Base" := VATAmountLine."VAT Base" + lSalesCrMemoLine.Amount;
                            VATAmountLine."VAT Amount" := VATAmountLine."VAT Amount" +
                                (lSalesCrMemoLine."Amount Including VAT" - lSalesCrMemoLine.Amount);
                            VATAmountLine."Amount Including VAT" := VATAmountLine."Amount Including VAT" + lSalesCrMemoLine."Amount Including VAT"
                ;
                            VATAmountLine."Line Amount" := VATAmountLine."Line Amount" + lSalesCrMemoLine.Amount;
                        END;
                    END ELSE BEGIN
                        // recherche Facture a extourner
                        lSalesInvLine.SETRANGE("Document No.", gSalesInvoiceHeader."No.");
                        lSalesInvLine.SETRANGE("Prepayment Order No.", pSalesHeader."No.");
                        lSalesInvLine.SETRANGE("Prepayment Order Line No.", pSalesLine."Line No.");
                        IF lSalesInvLine.FIND('+') THEN BEGIN
                            VATAmountLine."VAT Base" := VATAmountLine."VAT Base" + lSalesInvLine.Amount;
                            VATAmountLine."VAT Amount" := VATAmountLine."VAT Amount" +
                                (lSalesInvLine."Amount Including VAT" - lSalesInvLine.Amount);
                            VATAmountLine."Amount Including VAT" := VATAmountLine."Amount Including VAT" + lSalesInvLine."Amount Including VAT";
                            VATAmountLine."Line Amount" := VATAmountLine."Line Amount" + lSalesInvLine.Amount;
                        END;
                    END;
                    VATAmountLine.MODIFY;
                UNTIL NEXT = 0;
        END;
    END;
}