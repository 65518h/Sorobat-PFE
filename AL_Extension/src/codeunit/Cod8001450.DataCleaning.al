Codeunit 8001450 "Data Cleaning"
{
    // //#8518 CW 15/11/10 From codeunit 8604 VersionList=NAVW14.00.02 do not exists for NAV6
    // //NAVISION CW 30/06/08 copy from 4.02, ReverseAuction discountinued
    // //+REF+SETUP CW 25/11/04 Allow 003 Licence, Confirm, +function CleanDocuments


    trigger OnRun()
    var
        lLicensePermission: Record "License Permission";
        ltDevelopperLicense: label 'For sercurity reasons data cleaning required a developper license.';
    begin
        //+REF+SETUP
        //#8908
        with lLicensePermission do
            if not Get("object type"::Codeunit, 100000) or ("Execute Permission" <> "execute permission"::Yes) then
                Error(ltDevelopperLicense);
        //#8908//
        DoCleaning;
        DoCleaningDoc;
        //+REF+SETUP//
    end;

    var
        Text001: label 'For sercurity reasons data cleaning can only be performed\with a NSC 004/006 license.';
        Text002: label 'Current process @1@@@@@@@@@@@@@@@\';
        Text003: label 'Current status  #2###################';
        Text004: label 'Table No.';
        Window: Dialog;
        StatusCounter: Integer;
        TotalRecNo: Integer;
        tClean: label 'Do you want to delete all entries and posted documents?';
        tCleanDoc: label 'Do you want to delete all documents?';
        gClean: Boolean;


    procedure DoCleaning()
    begin
        //+REF+SETUP
        //IF (COPYSTR(SERIALNUMBER,7,3) <> '002') AND (COPYSTR(SERIALNUMBER,7,3) <> '004') AND (COPYSTR(SERIALNUMBER,7,3) <> '006') THEN
        //Window.OPEN(Text002 + Text003);
        //CLEAR(StatusCounter);
        //TotalRecNo := 50;
        //#8908
        //IF NOT (COPYSTR(SERIALNUMBER,7,3) IN ['002'..'006']) THEN
        //  ERROR(Text001);
        //#8908//
        if not Confirm(tClean) then
            exit;
        Window.Open(Text002 + Text003);
        TotalRecNo := 0;

        fPreDoCleaning;
        //+REF+SETUP//

        for gClean := false to true do begin

            CleanTable(Database::"G/L Entry");
            CleanTable(Database::"Cust. Ledger Entry");
            CleanTable(Database::"Vendor Ledger Entry");
            CleanTable(Database::"Item Ledger Entry");
            CleanTable(Database::"G/L Register");
            CleanTable(Database::"Item Register");
            CleanTable(Database::"Exch. Rate Adjmt. Reg.");
            CleanTable(Database::"Date Compr. Register");
            CleanTable(Database::"Sales Shipment Header");
            CleanTable(Database::"Sales Shipment Line");
            CleanTable(Database::"Sales Invoice Header");
            CleanTable(Database::"Sales Invoice Line");
            CleanTable(Database::"Sales Cr.Memo Header");
            CleanTable(Database::"Sales Cr.Memo Line");
            CleanTable(Database::"Purch. Rcpt. Header");
            CleanTable(Database::"Purch. Rcpt. Line");
            CleanTable(Database::"Purch. Inv. Header");
            CleanTable(Database::"Purch. Inv. Line");
            CleanTable(Database::"Purch. Cr. Memo Hdr.");
            CleanTable(Database::"Purch. Cr. Memo Line");
            CleanTable(Database::"Job Ledger Entry"); // 169 Job Ledger Entry
            CleanTable(Database::"Job Ledger Entry"); // 169 -> 8004161 Job Ledger Entry
            CleanTable(Database::"Res. Ledger Entry");
            /* GL2024  CleanTable(Database::"BOM Ledger Entry");
               CleanTable(Database::"BOM Register");*/
            CleanTable(Database::"Resource Register");
            CleanTable(Database::"Job Register"); // 241 Job Register
            CleanTable(Database::"Job Register"); // 241 -> 8004168 Job Register
            CleanTable(Database::"VAT Entry");
            CleanTable(Database::"Bank Account Ledger Entry");
            CleanTable(Database::"Check Ledger Entry");
            CleanTable(Database::"Bank Account Statement");
            CleanTable(Database::"Bank Account Statement Line");
            CleanTable(Database::"Phys. Inventory Ledger Entry");
            CleanTable(Database::"Issued Reminder Header");
            CleanTable(Database::"Issued Reminder Line");
            CleanTable(Database::"Reminder/Fin. Charge Entry");
            CleanTable(Database::"Issued Fin. Charge Memo Header");
            CleanTable(Database::"Issued Fin. Charge Memo Line");
            CleanTable(Database::"Item Application Entry");
            /* GL2024  CleanTable(Database::"Ledger Entry Dimension");
                CleanTable(Database::"Posted Document Dimension");*/
            CleanTable(Database::"Detailed Cust. Ledg. Entry");
            CleanTable(Database::"Detailed Vendor Ledg. Entry");
            CleanTable(Database::"Change Log Entry");
            CleanTable(Database::"FA Ledger Entry");
            CleanTable(Database::"FA Register");
            CleanTable(Database::"Registered Whse. Activity Hdr.");
            CleanTable(Database::"Registered Whse. Activity Line");
            CleanTable(Database::"Value Entry");
            CleanTable(Database::"Rounding Residual Buffer");
            CleanTable(Database::"Capacity Ledger Entry");

            //+REF+SETUP
            CleanTable(Database::"G/L Entry - VAT Entry link"); // 253
            CleanTable(Database::"Reminder Header"); // 295
            CleanTable(Database::"Reminder Comment Line"); // 299
            CleanTable(Database::"Finance Charge Memo Header"); // 302
            CleanTable(Database::"Fin. Charge Comment Line"); // 306
            CleanTable(Database::"Item Application Entry History"); // 343
            CleanTable(Database::"Analysis View Entry"); // 365
            CleanTable(Database::"Analysis View Budget Entry"); // 366
            CleanTable(Database::"G/L Account (Analysis View)"); // 376
            CleanTable(Database::"Sales Header Archive"); // 5107
            CleanTable(Database::"Sales Line Archive"); // 5108
            CleanTable(Database::"Purchase Header Archive"); // 5109
            CleanTable(Database::"Purchase Line Archive"); // 5110
            CleanTable(Database::"Interaction Log Entry"); // 5065
            CleanTable(Database::"Employee Absence"); // 5207
            CleanTable(Database::"Post Value Entry to G/L"); // 5811
            CleanTable(Database::"G/L - Item Ledger Relation"); // 5823
            CleanTable(Database::"Filed Contract Line"); // 5971
            CleanTable(Database::"Warehouse Entry"); // 7312
            CleanTable(Database::"Warehouse Register"); // 7313
            CleanTable(Database::"Posted Whse. Receipt Header"); // 7318
            CleanTable(Database::"Posted Whse. Shipment Header"); // 7322
            CleanTable(Database::"Whse. Pick Request"); // 7325

            CleanTable(Database::"BAR : Bank Entry"); // 8001607 BAR: Bank Entry
            CleanTable(Database::"Advanced Job Budget Entry"); // 8003919 Advanced Bob Budget Entry
            CleanTable(Database::"Purchase Rcpt. Invoiced"); // 8003990 Purchase Rcpt. Invoiced
            CleanTable(Database::"Return Receipt Invoiced"); // 8003991 Return Rcpt. Invoiced

        end; // for gClean
        //+REF+SETUP//

        Window.Close;
    end;

    local procedure CleanTable(TableNo: Integer)
    var
        RecordReference: RecordRef;
    begin
        //+REF+SETUP
        if not gClean then begin
            TotalRecNo += 1;
            exit;
        end;
        //+REF+SETUP//
        Window.Update(2, Text004 + ' ' + Format(TableNo));
        StatusCounter := StatusCounter + 1;
        Window.Update(1, ROUND(StatusCounter / TotalRecNo * 10000, 1));
        RecordReference.Open(TableNo);
        RecordReference.DeleteAll(true);
    end;


    procedure DoCleaningDoc()
    begin
        //+REF+SETUP
        //#8908
        //IF NOT (COPYSTR(SERIALNUMBER,7,3) IN ['002'..'006']) THEN
        //  ERROR(Text001);
        //#8908//
        if not Confirm(tCleanDoc) then
            exit;
        Window.Open(Text002 + Text003);
        Clear(StatusCounter);
        TotalRecNo := 0;

        fPreDoCleaningDoc();
        //+REF+SETUP//

        for gClean := false to true do begin
            CleanTableFalse(Database::"Sales Header"); // 36
            CleanTableFalse(Database::"Sales Line"); // 37
            CleanTableFalse(Database::"Purchase Header"); // 38
            CleanTableFalse(Database::"Purchase Line"); // 39
            CleanTable(Database::"Purch. Comment Line"); // 43
            CleanTable(Database::"Sales Comment Line"); // 44

            CleanTable(Database::"Gen. Journal Line"); // 81
            CleanTable(Database::"Item Journal Line"); // 83
            CleanTable(Database::"G/L Budget Name"); // 95
            CleanTable(Database::"G/L Budget Entry"); // 96
            CleanTable(Database::"Res. Journal Line"); // 207
            CleanTable(Database::"Job Journal Line"); // 210 Job Journal Line
            CleanTable(Database::"Job Journal Line"); // 210 -> 8004165
            CleanTable(Database::"Requisition Line"); // 246
            CleanTable(Database::"Intrastat Jnl. Line"); // 263
            CleanTable(Database::"Bank Acc. Reconciliation"); // 273
            CleanTable(Database::"Reservation Entry"); // 337
                                                       /*     CleanTable(Database::"Journal Line Dimension"); // 356
                                                            CleanTableFalse(Database::"Document Dimension"); // 357
                                                            CleanTable(Database::"Production Document Dimension"); // 358
                                                            CleanTable(Database::"G/L Budget Dimension"); // 361*/
            CleanTable(Database::"Posted Approval Entry"); // 456
            CleanTable(Database::"Posted Approval Comment Line"); // 457
                                                                  /* GL2024  CleanTable(Database::"Overdue Notification Entry"); // 458
                                                                     CleanTableFalse(Database::"Service Contract Dimension"); // 389*/
            CleanTable(Database::Campaign); // 5071
            CleanTable(Database::"Campaign Entry"); // 5072
            CleanTable(Database::"Campaign Status"); // 5073
            CleanTable(Database::"To-do"); // 5080
            CleanTable(Database::Opportunity); // 5092
            CleanTable(Database::"Sales Header Archive"); // 5107
            CleanTable(Database::"Purchase Header Archive"); // 5109
            CleanTable(Database::"Production Order"); // 5405
            CleanTable(Database::"FA Journal Line"); // 5621
            CleanTableFalse(Database::"Transfer Header"); // 5740
            CleanTableFalse(Database::"Transfer Line"); // 5741
            CleanTable(Database::"Transfer Shipment Header"); // 5744
            CleanTable(Database::"Transfer Receipt Header"); // 5746
            CleanTable(Database::"Warehouse Request"); // 5765
            CleanTable(Database::"Warehouse Activity Header"); // 5766
            CleanTable(Database::"Item Charge Assignment (Purch)"); // 5805
            CleanTable(Database::"Item Charge Assignment (Sales)"); // 5809

            CleanTable(Database::"Service Header"); // 5900
            CleanTable(Database::"Service Ledger Entry"); // 5907
            CleanTable(Database::"Warranty Ledger Entry"); // 5908
            CleanTable(Database::"Service Register"); // 5934
            CleanTable(Database::"Service Document Register"); // 5936
            CleanTable(Database::"Service Contract Header"); // 5965
            CleanTable(Database::"Contract Change Log"); // 5967
            CleanTable(Database::"Contract Gain/Loss Entry"); // 5969
            CleanTable(Database::"Filed Service Contract Header"); // 5970
            CleanTable(Database::"Return Shipment Header"); // 6650
            CleanTable(Database::"Return Receipt Header"); // 6660
            CleanTable(Database::"Warehouse Receipt Header"); // 7316
            CleanTable(Database::"Warehouse Shipment Header"); // 7320
            CleanTable(Database::"Whse. Put-away Request"); // 7324

            CleanTable(Database::"Planning Entry"); // 8004130 Planning Entry
            CleanTable(Database::"Planning Header"); // 8035006 Planning Header
            CleanTable(Database::"Planning Header Archive"); // 8035009 Planning Header Archive
            CleanTable(Database::"Planning Link Source ID"); // 8035011 Planning Link Source ID

        end;

        //#3763 lNoSeriesLine.MODIFYALL("Last No. Used",'');
        //#3763 lNoSeriesLine.MODIFYALL("Last Date Used",0D);

        Window.Close;
        //+REF+SETUP//
    end;

    local procedure CleanTableFalse(TableNo: Integer)
    var
        RecordReference: RecordRef;
    begin
        //+REF+SETUP
        if not gClean then begin
            TotalRecNo += 1;
            exit;
        end;
        //+REF+SETUP//
        Window.Update(2, Text004 + ' ' + Format(TableNo));
        StatusCounter := StatusCounter + 1;
        Window.Update(1, ROUND(StatusCounter / TotalRecNo * 10000, 1));
        RecordReference.Open(TableNo);
        RecordReference.DeleteAll(false);
    end;


    procedure fPreDoCleaning()
    var
        lSalesShipmentHeader: Record "Sales Shipment Header";
        lSalesShipmentLine: Record "Sales Shipment Line";
        lSalesInvoiceHeader: Record "Sales Invoice Header";
        lSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        lPurchReceiptHeader: Record "Purch. Rcpt. Header";
        lPurchReceiptLine: Record "Purch. Rcpt. Line";
        lPurchInvoiceHeader: Record "Purch. Inv. Header";
        lPurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        lReturnShipmentHeader: Record "Return Shipment Header";
        lReturnReceiptHeader: Record "Return Receipt Header";
        lItemLedgerEntry: Record "Item Ledger Entry";
        lCapacityLedgerEntry: Record "Capacity Ledger Entry";
        lPostedWhseReceiptHeader: Record "Posted Whse. Receipt Header";
        lPostedWhseReceiptLine: Record "Posted Whse. Receipt Line";
    begin
        //+REF+SETUP
        // 110
        lSalesShipmentHeader.SetRange("No. Printed", 0);
        lSalesShipmentHeader.ModifyAll("No. Printed", -1);
        // 111
        lSalesShipmentLine.SetFilter(Quantity, '<>0');
        if lSalesShipmentLine.FindSet then
            repeat
                lSalesShipmentLine."Quantity Invoiced" := lSalesShipmentLine.Quantity;
                lSalesShipmentLine.Modify;
            until lSalesShipmentLine.Next = 0;
        // 112
        lSalesInvoiceHeader.SetRange("No. Printed", 0);
        lSalesInvoiceHeader.ModifyAll("No. Printed", -1);
        // 114
        lSalesCrMemoHeader.SetRange("No. Printed", 0);
        lSalesCrMemoHeader.ModifyAll("No. Printed", -1);
        // 120
        lPurchReceiptHeader.SetRange("No. Printed", 0);
        lPurchReceiptHeader.ModifyAll("No. Printed", -1);
        // 111
        lPurchReceiptLine.SetFilter(Quantity, '<>0');
        if lPurchReceiptLine.FindSet then
            repeat
                lPurchReceiptLine."Quantity Invoiced" := lPurchReceiptLine.Quantity;
                lPurchReceiptLine.Modify;
            until lPurchReceiptLine.Next = 0;
        // 122
        lPurchInvoiceHeader.SetRange("No. Printed", 0);
        lPurchInvoiceHeader.ModifyAll("No. Printed", -1);
        // 124
        lPurchCrMemoHeader.SetRange("No. Printed", 0);
        lPurchCrMemoHeader.ModifyAll("No. Printed", -1);
        // 6650
        lReturnShipmentHeader.SetRange("No. Printed", 0);
        lReturnShipmentHeader.ModifyAll("No. Printed", -1);
        // 6660
        lReturnReceiptHeader.SetRange("No. Printed", 0);
        lReturnReceiptHeader.ModifyAll("No. Printed", -1);
        // 32
        /* GL2024  lItemLedgerEntry.SetFilter("Prod. Order No.", '<>%1', '');
           lItemLedgerEntry.ModifyAll("Prod. Order No.", '');
           // 5832
           lCapacityLedgerEntry.SetFilter("Prod. Order No.", '<>%1', '');
           lCapacityLedgerEntry.ModifyAll("Prod. Order No.", '');
           lCapacityLedgerEntry.ModifyAll("Prod. Order Line No.", 0);*/
        //+REF+SETUP//

        //+BAT+SETUP
        // 112
        lSalesInvoiceHeader.Reset;
        lSalesInvoiceHeader.SetFilter("Order No.", '<>%1', '');
        lSalesInvoiceHeader.ModifyAll("Order No.", '');
        lSalesInvoiceHeader.Reset;
        lSalesInvoiceHeader.SetFilter("Prepayment Order No.", '<>%1', '');
        lSalesInvoiceHeader.ModifyAll("Prepayment Order No.", '');
        // 114
        lSalesCrMemoHeader.Reset;
        lSalesCrMemoHeader.SetFilter("Prepayment Order No.", '<>%1', '');
        lSalesCrMemoHeader.ModifyAll("Prepayment Order No.", '');
        //+BAT+SETUP//
        //#7318
        lPostedWhseReceiptHeader.ModifyAll("Document Status", lPostedWhseReceiptHeader."document status"::"Completely Put Away");
        lPostedWhseReceiptLine.ModifyAll(Status, lPostedWhseReceiptLine.Status::"Completely Put Away");
        //#7319
    end;


    procedure fPreDoCleaningDoc()
    var
        //GL2024 lNoSeriesLine: Record 309;
        lGenJnlLine: Record "Gen. Journal Line";
        lProductionOrder: Record "Production Order";
        lServiceContractHeader: Record "Service Contract Header";
        lPurchaseLine: Record "Purchase Line";
        lOpportunity: Record Opportunity;
        lSalesInvoiceHeader: Record "Sales Invoice Header";
        lSalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        //+REF+SETUP
        // 81
        lGenJnlLine.ModifyAll("Check Printed", false);
        // 5092
        lOpportunity.ModifyAll(Status, lOpportunity.Status::"Not Started");
        // 5965
        //lServiceContractHeader.SETFILTER(Status,'<>0');
        lServiceContractHeader.ModifyAll(Status, 0);
        // 39
        lPurchaseLine.SetFilter("Prod. Order No.", '<>%1', '');
        lPurchaseLine.ModifyAll("Prod. Order No.", '');
        //+REF+SETUP//

        //+BAT+SETUP
        // 112
        lSalesInvoiceHeader.ModifyAll("Order No.", '');
        lSalesInvoiceHeader.ModifyAll("Prepayment Order No.", '');
        // 114
        lSalesCrMemoHeader.ModifyAll("Prepayment Order No.", '');
        //+BAT+SETUP//
    end;
}

