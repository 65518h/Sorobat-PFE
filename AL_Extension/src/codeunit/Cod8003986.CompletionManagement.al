Codeunit 8003986 "Completion Management"
{
    // //PROJET_FACT MB 24/01/07 Création du codeunit pour avancement facturation


    trigger OnRun()
    begin
    end;

    var
        CurrExchRate: Record "Currency Exchange Rate";
        text8003900: label 'An invoice already exist for the scheduler Line No. %1';


    procedure UpdateInvScheduler(pSalesHeader: Record "Sales Header"; pSalesInvHeader: Record "Sales Invoice Header"; pSalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        lSalesLine: Record "Sales Line";
        lInvScheduler: Record "Invoice Scheduler";
        lSalesLineAmountLCY: Decimal;
        lSens: Integer;
        lSalesOrderLine: Record "Sales Line";
        lCurrency: Record Currency;
        lAmount: Decimal;
    begin
        if not pSalesHeader."Scheduler Origin" then
            exit;

        if pSalesHeader."Currency Code" = '' then
            lCurrency.InitRoundingPrecision
        else begin
            lCurrency.Get(pSalesHeader."Currency Code");
            lCurrency.TestField("Amount Rounding Precision");
        end;

        lSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
        lSalesLine.SetRange("Document Type", pSalesHeader."Document Type");
        lSalesLine.SetRange("Document No.", pSalesHeader."No.");
        lSalesLine.SetRange("Structure Line No.", 0);
        lSalesLine.SetFilter("Scheduler Line No.", '<>0');
        lSalesLine.SetFilter(Type, '<>0');
        lSalesLine.SetFilter(Quantity, '<>0');

        if lSalesLine.Find('-') then
            repeat
                lInvScheduler.Get(lInvScheduler."sales header doc. type"::Order, lSalesLine."Order No.", lSalesLine."Scheduler Line No.");
                if pSalesHeader."Currency Code" <> '' then
                    lSalesLineAmountLCY :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                        pSalesHeader."Posting Date", pSalesHeader."Currency Code",
                        lSalesLine."Line Amount", pSalesHeader."Currency Factor"))
                else
                    lSalesLineAmountLCY := lSalesLine."Line Amount";
                //#8463
                if lInvScheduler."Posted Doc. No." <> '' then
                    Error(text8003900, lSalesLine."Scheduler Line No.");
                //#8463//
                if pSalesInvHeader."No." <> '' then begin
                    lInvScheduler."Posted Doc. type" := lInvScheduler."posted doc. type"::Invoice;
                    lInvScheduler."Posted Doc. No." := pSalesInvHeader."No.";
                    lSens := 1;
                end else
                    if pSalesCrMemoHeader."No." <> '' then begin
                        lInvScheduler."Posted Doc. type" := lInvScheduler."posted doc. type"::"Cr. Memo";
                        lInvScheduler."Posted Doc. No." := pSalesCrMemoHeader."No.";
                        lSens := -1;
                    end;

                if lSalesLine."Document Type" <> lSalesLine."document type"::"Credit Memo" then begin
                    lInvScheduler."Amount Emitted" := lSens * lSalesLine."Line Amount";
                    lInvScheduler."Amount Emitted (LCY)" := lSens * lSalesLineAmountLCY;
                    lInvScheduler."Amount to Emit" := lInvScheduler."Amount Emitted";
                    lInvScheduler."Amount to Emit (LCY)" := lInvScheduler."Amount Emitted (LCY)";
                end else begin
                    lInvScheduler."Amount Emitted" += lSens * lSalesLine."Line Amount";
                    lInvScheduler."Amount Emitted (LCY)" += lSens * lSalesLineAmountLCY;
                    if ROUND(lInvScheduler."Amount Emitted", lCurrency."Invoice Rounding Precision") = 0 then begin
                        Clear(lInvScheduler."Posted Doc. type");
                        lInvScheduler."Posted Doc. No." := '';
                        lInvScheduler."Amount Emitted" := 0;
                        lInvScheduler."Amount Emitted (LCY)" := 0;
                        lInvScheduler.Invoice := false;
                    end;
                end;
                lInvScheduler.Modify;
            until lSalesLine.Next = 0;
    end;


    procedure MAJCompletion(pSalesHeader: Record "Sales Header"; pPostProdCompletion: Boolean)
    var
        lSalesLine: Record "Sales Line";
        TempSalesLine: Record "Sales Line";
        lSalesPost: Codeunit "Sales-Post";
        lInvScheduler: Record "Invoice Scheduler";
        lFirst: Boolean;
    begin
        if pSalesHeader."Scheduler Origin" then begin      //ECHEANCIER
            lFirst := true;
            lSalesLine.SetFilter("Scheduler Line No.", '<>0');
            if lSalesLine.Find('-') then
                repeat
                    lInvScheduler.Get(lInvScheduler."sales header doc. type"::Order, lSalesLine."Order No.",
                      lSalesLine."Scheduler Line No.");
                    TempSalesLine.SetRange("Document Type", TempSalesLine."document type"::Order);
                    TempSalesLine.SetRange("Document No.", lSalesLine."Document No.");
                    TempSalesLine.SetFilter(Type, '<>0');
                    TempSalesLine.SetRange("Structure Line No.", 0);
                    if TempSalesLine.Find('-') then
                        repeat
                            if lFirst then begin
                                TempSalesLine."Qty. to Ship" := 0;
                                TempSalesLine."Qty. to Ship (Base)" := 0;
                            end;
                            TempSalesLine."Quantity Invoiced" +=
                            TempSalesLine.Quantity * (lInvScheduler."Document Percentage" / 100);
                            TempSalesLine."Qty. Invoiced (Base)" +=
                            TempSalesLine."Quantity (Base)" * (lInvScheduler."Document Percentage" / 100);
                            TempSalesLine."Qty. to Invoice" := 0;
                            TempSalesLine."Qty. to Invoice (Base)" := 0;
                            TempSalesLine.InitOutstanding;
                            if pPostProdCompletion then begin
                                TempSalesLine."Qty. to Ship" +=
                                TempSalesLine.Quantity * (lInvScheduler."Document Percentage" / 100);
                                TempSalesLine."Qty. to Ship (Base)" +=
                                TempSalesLine."Quantity (Base)" * (lInvScheduler."Document Percentage" / 100);
                            end;
                            if (TempSalesLine."Purch. Order Line No." <> 0) and (TempSalesLine."Qty. to Invoice" = 0) then
                                lSalesPost.UpdateAssocLines(TempSalesLine);
                            //??CW 06/09/07            TempSalesLine."Completion Amount" := 0;
                            //??CW 06/09/07            TempSalesLine."New Completion %" := 0;
                            TempSalesLine.Modify;
                        until TempSalesLine.Next = 0;
                    lFirst := false;
                until lSalesLine.Next = 0;
            lSalesLine.SetRange("Scheduler Line No.");
        end;
    end;


    procedure MAJCompletion2(pSalesHeader: Record "Sales Header")
    var
        lSalesLine: Record "Sales Line";
        TempSalesLine: Record "Sales Line";
        lSalesPost: Codeunit "Sales-Post";
        lInvScheduler: Record "Invoice Scheduler";
    begin
        if pSalesHeader."Scheduler Origin" then begin      //ECHEANCIER
            lSalesLine.SetRange("Document Type", lSalesLine."document type"::Order);
            lSalesLine.SetRange("Structure Line No.", 0);
            lSalesLine.SetRange("Order No.", pSalesHeader."No.");
            lSalesLine.SetFilter(Type, '<>0');
            lSalesLine.SetFilter("Scheduler Line No.", '<>0');
            if not lSalesLine.IsEmpty then begin
                lSalesLine.Find('-');
                repeat
                    lInvScheduler.Get(lInvScheduler."sales header doc. type"::Order, lSalesLine."Document No.",
                      lSalesLine."Scheduler Line No.");
                    TempSalesLine.SetRange("Document Type", TempSalesLine."document type"::Order);
                    TempSalesLine.SetRange("Document No.", lSalesLine."Document No.");
                    TempSalesLine.SetFilter(Type, '<>0');
                    TempSalesLine.SetRange("Structure Line No.", 0);
                    if TempSalesLine.Find('-') then
                        repeat
                            TempSalesLine."Quantity Invoiced" +=
                              TempSalesLine.Quantity * (lInvScheduler."Document Percentage" / 100);
                            TempSalesLine."Qty. Invoiced (Base)" +=
                              TempSalesLine."Quantity (Base)" * (lInvScheduler."Document Percentage" / 100);
                            TempSalesLine."Qty. to Invoice" := 0;
                            TempSalesLine."Qty. to Invoice (Base)" := 0;
                            TempSalesLine.InitOutstanding;
                            if (TempSalesLine."Purch. Order Line No." <> 0) and (TempSalesLine."Qty. to Invoice" = 0) then
                                lSalesPost.UpdateAssocLines(TempSalesLine);
                            //??CW 06/09/07          TempSalesLine."Completion Amount" := 0;
                            //??CW 06/09/07          TempSalesLine."New Completion %" := 0;
                            TempSalesLine.Modify;
                        until TempSalesLine.Next = 0;
                until lSalesLine.Next = 0;
            end;
        end;
    end;


    procedure ProdCompletionPosting(pSalesHeader: Record "Sales Header"; pPostingDate: Date; pJobNo: Code[20]; pSalesInvLineOrderNo: Code[20])
    var
        lSalesHeader: Record "Sales Header";
        lSalesLine: Record "Sales Line";
    //GL2024 NAVIBAT  lBatchPost: Report 8003997;
    begin
        //#6189
        //IF NOT pSalesHeader."Scheduler Origin" THEN BEGIN
        if not pSalesHeader."Scheduler Origin" and (pSalesHeader."Order Type" = pSalesHeader."order type"::" ") then begin
            //#6189//
            lSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
            lSalesLine.SetRange("Order Type", lSalesLine."order type"::" ");
            lSalesLine.SetRange("Document Type", lSalesLine."document type"::Order);
            lSalesLine.SetRange("Structure Line No.", 0);
            lSalesLine.SetRange("Job No.", pJobNo);
            lSalesLine.SetFilter("Qty. to Ship", '<>0');
            if lSalesLine.IsEmpty then
                exit;
            if lSalesLine.Find('-') then
                repeat
                    if lSalesHeader."No." <> lSalesLine."Document No." then begin
                        lSalesHeader.Get(lSalesLine."Document Type", lSalesLine."Document No.");
                        lSalesHeader.Mark(true);
                    end;
                until lSalesLine.Next = 0;
        end
        else begin
            if lSalesHeader.Get(lSalesHeader."document type"::Order, pSalesInvLineOrderNo) then
                lSalesHeader.Mark(true);
        end;

        lSalesHeader.MarkedOnly(true);
        /* //GL2024 NAVIBAT Clear(lBatchPost);
          lBatchPost.InitializeFromPosting(pPostingDate);
          lBatchPost.SetTableview(lSalesHeader);
          lBatchPost.USEREQUESTFORM(false);
          lBatchPost.Run;*/
    end;


    procedure SalesPostProdCompletionPosting(pSalesHeader: Record "Sales Header"; pPostingDate: Date; pSalesInvLineOrderNo: Code[20]; pJobNo: Code[20]; pPostProdCompletion: Boolean)
    var
        lSalesHeader: Record "Sales Header";
        lSalesLine: Record "Sales Line";
    //GL2024 NAVIBAT   lBatchPost: Report 8003997;
    begin
        if pPostProdCompletion and not (pSalesHeader."Order Type" <> pSalesHeader."order type"::"Supply Order") then begin
            Commit;
            ProdCompletionPosting(pSalesHeader, pPostingDate, pJobNo, pSalesInvLineOrderNo);
        end;
    end;


    procedure InsertProductionCompletion(pSalesHeader: Record "Sales Header"; var pSalesLine: Record "Sales Line"; pSalesShipHeader: Record "Sales Shipment Header")
    var
        lProdCompl: Record "Production Completion Entry";
        lOrderLine: Record "Sales Line";
        lSupplyOK: Boolean;
    begin
        //PROJET_FACT : New function

        if (pSalesHeader."Order Type" = pSalesHeader."order type"::Transfer) or pSalesHeader."Scheduler Origin" or
           (pSalesHeader."Document Type" <> pSalesHeader."document type"::Order) then
            exit;

        //#6189
        lSupplyOK := (pSalesHeader."Order Type" = pSalesHeader."order type"::"Supply Order");
        if lSupplyOK then begin
            lOrderLine.SetCurrentkey("Document Type", "Supply Order No.", "Supply Order Line No.");
            lOrderLine.SetRange("Document Type", lOrderLine."document type"::Order);
            lOrderLine.SetRange("Supply Order No.", pSalesHeader."No.");
            lOrderLine.SetRange("Structure Line No.", 0);
            if lOrderLine.IsEmpty then
                exit;
        end;
        //#6189//

        pSalesLine.SetFilter(pSalesLine."Qty. to Ship", '<>0');
        if pSalesLine.Find('-') then begin
            repeat
                //#6189
                if lSupplyOK then begin
                    lOrderLine.SetRange("Supply Order Line No.", pSalesLine."Line No.");
                    if not lOrderLine.IsEmpty then begin
                        lOrderLine.FindFirst;
                        lProdCompl.Init;
                        lProdCompl."Job No." := pSalesLine."Job No.";
                        lProdCompl."Job Task No." := pSalesLine."Job Task No.";
                        lProdCompl."Closing No." := pSalesHeader."No. Prepayment Invoiced";
                        lProdCompl."Posting Date" := pSalesHeader."Posting Date";
                        lProdCompl."Line No." := lOrderLine."Line No.";
                        lProdCompl."Order No." := lOrderLine."Document No.";
                        lProdCompl."Order Line No." := lOrderLine."Line No.";
                        lProdCompl."Document No." := pSalesShipHeader."No.";
                        lProdCompl."Work Type Code" := pSalesLine."Work Type Code";
                        lProdCompl.Insert(true);
                        lProdCompl.Validate(lProdCompl."New Quantity", pSalesLine."Qty. to Ship" + pSalesLine."Quantity Shipped");
                        lProdCompl.Modify;
                    end;
                end else begin
                    //#6189//
                    lProdCompl.Init;
                    lProdCompl."Job No." := pSalesLine."Job No.";
                    lProdCompl."Job Task No." := pSalesLine."Job Task No.";
                    lProdCompl."Closing No." := pSalesHeader."No. Prepayment Invoiced";
                    lProdCompl."Posting Date" := pSalesHeader."Posting Date";
                    lProdCompl."Line No." := pSalesLine."Line No.";
                    lProdCompl."Order No." := pSalesLine."Document No.";
                    lProdCompl."Order Line No." := pSalesLine."Line No.";
                    lProdCompl."Document No." := pSalesShipHeader."No.";
                    lProdCompl."Work Type Code" := pSalesLine."Work Type Code";
                    lProdCompl.Insert(true);
                    lProdCompl.Validate(lProdCompl."New Quantity", pSalesLine."Qty. to Ship" + pSalesLine."Quantity Shipped");
                    lProdCompl.Modify;
                end;
            until pSalesLine.Next = 0;
        end;

        //#9055
        pSalesLine.SetRange(pSalesLine."Qty. to Ship");
        //#9055//
    end;


    procedure InitInvoiceNo(pSalesHeader: Record "Sales Header")
    var
        lSalesLine: Record "Sales Line";
        lSalesLine2: Record "Sales Line";
    begin
        //#8740
        if pSalesHeader."Scheduler Origin" then begin
            //#8740//
            lSalesLine.SetRange("Order No.", pSalesHeader."No.");
            if not lSalesLine.IsEmpty then begin
                lSalesLine.Find('-');
                repeat
                    lSalesLine2.Get(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Line No.");
                    lSalesLine2."Order No." := '';
                    //    lSalesLine2."Invoice Line No." := 0 ;
                    lSalesLine2.Modify;
                until lSalesLine.Next = 0;
            end;
        end;
    end;

    local procedure lSetFilter(var pSalesOrderLine: Record "Sales Line"; pSalesLine: Record "Sales Line")
    begin
        with pSalesOrderLine do begin
            SetRange("Document Type", "document type"::Order);
            SetRange("Order No.", pSalesLine."Document No.");
            //  SETRANGE("Invoice Line No.",pSalesLine."Line No.");
            SetRange("Job No.", pSalesLine."Job No.");
            SetRange("Gen. Prod. Posting Group", pSalesLine."Gen. Prod. Posting Group");
            SetRange("VAT Prod. Posting Group", pSalesLine."VAT Prod. Posting Group");
            SetRange("Gen. Bus. Posting Group", pSalesLine."Gen. Bus. Posting Group");
            SetRange("VAT Bus. Posting Group", pSalesLine."VAT Bus. Posting Group");
            SetRange("Shortcut Dimension 1 Code", pSalesLine."Shortcut Dimension 1 Code");
            SetRange("Shortcut Dimension 2 Code", pSalesLine."Shortcut Dimension 2 Code");
        end;
    end;


    procedure InsertProductionCompDropShip(pSalesHeader: Record "Sales Header"; pSalesLine: Record "Sales Line"; pSalesShipHeader: Record "Sales Shipment Header"; pQtyToShip: Decimal)
    var
        lProdCompl: Record "Production Completion Entry";
        lOrderLine: Record "Sales Line";
        lSupplyOK: Boolean;
    begin
        //6188
        if pQtyToShip = 0 then
            exit;

        if (pSalesHeader."Order Type" = pSalesHeader."order type"::Transfer) or pSalesHeader."Scheduler Origin" or
           (pSalesHeader."Document Type" <> pSalesHeader."document type"::Order) then
            exit;

        lSupplyOK := (pSalesHeader."Order Type" = pSalesHeader."order type"::"Supply Order");
        if lSupplyOK then begin
            lOrderLine.SetCurrentkey("Document Type", "Supply Order No.", "Supply Order Line No.");
            lOrderLine.SetRange("Document Type", lOrderLine."document type"::Order);
            lOrderLine.SetRange("Supply Order No.", pSalesLine."Document No.");
            lOrderLine.SetRange("Supply Order Line No.", pSalesLine."Line No.");
            lOrderLine.SetRange("Structure Line No.", 0);
            if lOrderLine.IsEmpty then
                exit;
        end else
            exit;

        lOrderLine.FindFirst;
        lProdCompl.Init;
        lProdCompl."Job No." := pSalesLine."Job No.";
        lProdCompl."Job Task No." := pSalesLine."Job Task No.";
        lProdCompl."Closing No." := pSalesHeader."No. Prepayment Invoiced";
        lProdCompl."Posting Date" := pSalesHeader."Posting Date";
        lProdCompl."Line No." := lOrderLine."Line No.";
        lProdCompl."Order No." := lOrderLine."Document No.";
        lProdCompl."Order Line No." := lOrderLine."Line No.";
        lProdCompl."Document No." := pSalesShipHeader."No.";
        lProdCompl."Work Type Code" := pSalesLine."Work Type Code";
        lProdCompl.Insert(true);
        lProdCompl.Validate(lProdCompl."New Quantity", pQtyToShip);
        lProdCompl.Modify;
        //6188//
    end;


    procedure fShowCompletion(pSalesHeader: Record "Sales Header")
    var
        lSalesLine: Record "Sales Line";
    begin
        lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.");
        lSalesLine.SetRange("Document Type", pSalesHeader."Document Type");
        lSalesLine.SetRange("Document No.", pSalesHeader."No.");
        lSalesLine.SetFilter("Structure Line No.", '0');
        lSalesLine.SetFilter("Line Type", '<>0');
        PAGE.Run(page::Completion, lSalesLine);
    end;
}

