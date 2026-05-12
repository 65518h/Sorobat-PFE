Codeunit 8003987 "Job Info-Pane Management"
{
    // //BAT_ABO CW 25/02/09 +Subscription Lookup
    // //+ONE+PREPAYMENT CW 21/07/09


    trigger OnRun()
    begin
    end;


    procedure LookUpPostedInvoice(var pJob: Record Job)
    var
        lSalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        lSalesInvoiceHeader.SetCurrentkey("Job No.");
        lSalesInvoiceHeader.SetRange("Job No.", pJob."No.");
        if not lSalesInvoiceHeader.IsEmpty then begin
            if lSalesInvoiceHeader.Count > 1 then
                Page.RunModal(Page::"Posted Sales Invoices", lSalesInvoiceHeader)
            else
                Page.RunModal(Page::"Posted Sales Invoice", lSalesInvoiceHeader);
        end;
    end;


    procedure LookUpPostedCrMemo(var pJob: Record Job)
    var
        lSalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        lSalesCrMemoHeader.SetCurrentkey("Job No.");
        lSalesCrMemoHeader.SetRange("Job No.", pJob."No.");
        if not lSalesCrMemoHeader.IsEmpty then begin
            if lSalesCrMemoHeader.Count > 1 then
                Page.RunModal(Page::"Posted Sales Credit Memos", lSalesCrMemoHeader)
            else
                Page.RunModal(Page::"Posted Sales Credit Memo", lSalesCrMemoHeader);
        end;
    end;


    procedure LookUpArchiveQuote(var pJob: Record Job)
    var
        lSalesHeaderArchive: Record "Sales Header Archive";
    begin
        lSalesHeaderArchive.SetCurrentkey("Job No.");
        lSalesHeaderArchive.SetRange("Document Type", lSalesHeaderArchive."document type"::Quote);
        lSalesHeaderArchive.SetRange("Job No.", pJob."No.");
        if not lSalesHeaderArchive.IsEmpty then begin
            if lSalesHeaderArchive.Count > 1 then
                Page.RunModal(Page::"Sales List Archive", lSalesHeaderArchive);
            //GL2024 NAVIBAT      else
            //GL2024 NAVIBAT       Page.RunModal(Page::"NaviBat Sales Archive", lSalesHeaderArchive);
        end;
    end;


    procedure LookUpPurchaseInvoice(var pJob: Record Job)
    var
        lVendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        lVendorLedgerEntry.SetCurrentkey("Job No.");
        lVendorLedgerEntry.SetRange("Job No.", pJob."No.");
        if not lVendorLedgerEntry.IsEmpty then
            Page.RunModal(Page::"Vendor Ledger Entries", lVendorLedgerEntry);
    end;


    procedure LookUpArchivePurchase(var pJob: Record Job)
    var
        lPurchaseHeaderArchive: Record "Purchase Header Archive";
    begin
        lPurchaseHeaderArchive.SetRange("Document Type", lPurchaseHeaderArchive."document type"::Order);
        lPurchaseHeaderArchive.SetRange("Job No.", pJob."No.");
        if not lPurchaseHeaderArchive.IsEmpty then begin
            if lPurchaseHeaderArchive.Count > 1 then
                Page.RunModal(Page::"Purchase List Archive", lPurchaseHeaderArchive)
            else
                Page.RunModal(Page::"Purchase Order Archive", lPurchaseHeaderArchive);
        end;
    end;


    procedure LookUpPrepayment(var pJob: Record Job)
    var
        lSalesHeader: Record "Sales Header";
    begin
        lSalesHeader.SetCurrentkey("Job No.");
        lSalesHeader.SetRange("Document Type", lSalesHeader."document type"::Order);
        lSalesHeader.SetRange("Job No.", pJob."No.");
        lSalesHeader.SetRange("Order Type", 0);
        if not lSalesHeader.IsEmpty then begin
            /*  //GL2024 NAVIBAT NAVIBAT  if lSalesHeader.Count > 1 then
                  //    Page.RunModal(Page::"NaviBat Sales List",lSalesHeader)
                  Page.RunModal(Page::"NaviBat Prepayment List", lSalesHeader)
              else
                  Page.RunModal(Page::"Sales Prepayments", lSalesHeader);*/
        end;
    end;


    procedure LookupSalesHeader(var pJob: Record Job; pDocumentType: Integer; pOrderType: Integer)
    var
        lSalesHeader: Record "Sales Header";
        lListForm: Integer;
        lCardForm: Integer;
    begin
        with lSalesHeader do begin
            SetCurrentkey("Job No.");
            SetRange("Document Type", pDocumentType);
            SetRange("Job No.", pJob."No.");
            SetRange("Order Type", pOrderType);
            if Count < 1 then
                //GL2024 NAVIBAT   Page.RunModal(Page::"NaviBat Sales List", lSalesHeader)
                //GL2024 NAVIBAT    else
                if pOrderType = 0 then
                    case pDocumentType of
                        "document type"::Quote:
                            Page.RunModal(Page::"Sales Quote", lSalesHeader);
                        "document type"::Order:
                            Page.RunModal(Page::"Sales Order", lSalesHeader);
                        "document type"::Invoice:
                            Page.RunModal(Page::"Sales Invoice", lSalesHeader);
                        "document type"::"Credit Memo":
                            Page.RunModal(Page::"Sales Credit Memo", lSalesHeader);
                    //BAT_ABO
                    /* //GL2024 NAVIBAT  "document type"::Subscription:
                           Page.RunModal(Page::"Sales Contract", lSalesHeader);*/
                    //BAT_ABO//
                    end;
            /*  //GL2024 NAVIBAT else
                 if pOrderType = "order type"::Transfer then
                     case pDocumentType of
                         "document type"::Quote:
                             Page.RunModal(Page::"Internal Quote", lSalesHeader);
                         "document type"::Order:
                             Page.RunModal(Page::"Internal Order", lSalesHeader);
                     end
                 else
                     if pOrderType = "order type"::"Supply Order" then
                       //#8426
                       begin
                         //#8426
                         //#8147
                         SetRange("Document Type");
                         SetRange("Order Type");
                         //#8147//
                         Page.RunModal(Page::"Reordering Requisition", lSalesHeader);
                         //#8426
                     end;*/
            //#8426//
        end;
    end;


    procedure LookupPurchaseHeader(var pJob: Record Job; pDocumentType: Integer)
    var
        lPurchaseHeader: Record "Purchase Header";
    begin
        with lPurchaseHeader do begin
            SetCurrentkey("Job No.");
            SetRange("Document Type", pDocumentType);
            SetRange("Job No.", pJob."No.");
            SetRange("Attached to Doc. No.", '');
            if Count > 1 then
                Page.RunModal(Page::"Purchase List", lPurchaseHeader)
            else
                case pDocumentType of
                    "document type"::Quote:
                        Page.RunModal(Page::"Purchase Quote", lPurchaseHeader);
                    "document type"::Order:
                        Page.RunModal(Page::"Purchase Order", lPurchaseHeader);
                //BAT_ABO
                /*   //GL2024 NAVIBAT "document type"::Subscription:
                     Page.RunModal(Page::"Purchase Contract", lPurchaseHeader);*/
                //BAT_ABO//
                end;
        end;
    end;


    procedure LookUpServiceContract(var pJob: Record Job)
    var
        lServiceContractHeader: Record "Service Contract Header";
    begin
        lServiceContractHeader.SetCurrentkey("Job No.");
        lServiceContractHeader.SetRange("Contract Type", lServiceContractHeader."contract type"::Contract);
        lServiceContractHeader.SetRange("Job No.", pJob."No.");
        //lSalesHeader.SETRANGE("Order Type",0);
        if not lServiceContractHeader.IsEmpty then begin
            if lServiceContractHeader.Count > 1 then
                Page.RunModal(Page::"Service Contract List", lServiceContractHeader)
            else
                Page.RunModal(Page::"Service Contract", lServiceContractHeader);
        end;
    end;
}

