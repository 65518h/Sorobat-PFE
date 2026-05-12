Page 50135 "Navigate Suppression"
{
    // //+REF+NAVIGATE CW 04/11/04 (from NavCH SS8
    //  - Function 'ShowRecords' uses card form for Sales/Purchase Documents
    // //NAVIONE AC 15/01/07 Ajout table "Production Completion Entry", "Completion Entry","Advanced Job Budget Entry"

    Caption = 'Navigate Suppression';
    PageType = Card;
    SaveValues = true;
    SourceTable = "Document Entry";
    SourceTableTemporary = true;
    ApplicationArea = all;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Général';
                field(DocNoFilter; DocNoFilter)
                {
                    ApplicationArea = all;
                    Caption = 'N° document';

                    trigger OnValidate()
                    begin
                        SetDocNo(DocNoFilter);
                        ContactType := Contacttype::" ";
                        ContactNo := '';
                        ExtDocNo := '';
                        ClearTrackingInfo;
                        DocNoFilterOnAfterValidate;
                    end;
                }
                field(PostingDateFilter; PostingDateFilter)
                {
                    ApplicationArea = all;
                    Caption = 'Date comptabilisation';

                    trigger OnValidate()
                    begin
                        SetPostingDate(PostingDateFilter);
                        ContactType := Contacttype::" ";
                        ContactNo := '';
                        ExtDocNo := '';
                        ClearTrackingInfo;
                        PostingDateFilterOnAfterValida;
                    end;
                }
            }
            group(Source)
            {
                Caption = 'Source';
                field(DocType; DocType)
                {
                    ApplicationArea = all;
                    Caption = 'Type document';
                    Editable = false;
                    Enabled = DocTypeEnable;
                }
                field(SourceType; SourceType)
                {
                    ApplicationArea = all;
                    Caption = 'Type origine';
                    Editable = false;
                    Enabled = SourceTypeEnable;
                }
                field(SourceNo; SourceNo)
                {
                    ApplicationArea = all;
                    Caption = 'N° origine';
                    Editable = false;
                    Enabled = SourceNoEnable;
                }
                field(SourceName; SourceName)
                {
                    ApplicationArea = all;
                    Caption = 'Nom origine';
                    Editable = false;
                    Enabled = SourceNameEnable;
                }
            }

            group(External)
            {
                Caption = 'Externe';
                field(ContactType; ContactType)
                {
                    ApplicationArea = all;
                    Caption = 'Type tiers';
                    OptionCaption = ' ,Fournisseur,Client';

                    trigger OnValidate()
                    begin
                        SetDocNo('');
                        SetPostingDate('');
                        ClearTrackingInfo;
                        ContactTypeOnAfterValidate;
                    end;
                }
                field(ContactNo; ContactNo)
                {
                    ApplicationArea = all;
                    Caption = 'Identifiant tiers';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Vend: Record Vendor;
                        Cust: Record Customer;
                    begin
                        case ContactType of
                            Contacttype::Vendor:
                                if PAGE.RunModal(0, Vend) = Action::LookupOK then begin
                                    Text := Vend."No.";
                                    exit(true);
                                end;
                            Contacttype::Customer:
                                if PAGE.RunModal(0, Cust) = Action::LookupOK then begin
                                    Text := Cust."No.";
                                    exit(true);
                                end;
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        SetDocNo('');
                        SetPostingDate('');
                        ClearTrackingInfo;
                        ContactNoOnAfterValidate;
                    end;
                }
                field(ExtDocNo; ExtDocNo)
                {
                    ApplicationArea = all;
                    Caption = 'N° document';

                    trigger OnValidate()
                    begin
                        SetDocNo('');
                        SetPostingDate('');
                        ClearTrackingInfo;
                        ExtDocNoOnAfterValidate;
                    end;
                }
            }
            group("Item Tracking")
            {
                Caption = 'Traçabilité';
                field(SerialNo; SerialNoFilter)
                {
                    ApplicationArea = all;
                    Caption = 'N° de série';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        SerialNoInfo: Record "Serial No. Information";
                        SerialNoList: Page "Serial No. Information List";
                    begin
                        Clear(SerialNoList);
                        if SerialNoList.RunModal = Action::LookupOK then begin
                            Text := SerialNoList.GetSelectionFilter;
                            exit(true);
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        ClearInfo;
                        SerialNoFilterOnAfterValidate;
                    end;
                }
                field(LotNoFilter; LotNoFilter)
                {
                    ApplicationArea = all;
                    Caption = 'N° lot';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        LotNoInfo: Record "Lot No. Information";
                        LotNoList: Page "Lot No. Information List";
                    begin
                        Clear(LotNoList);
                        if LotNoList.RunModal = Action::LookupOK then begin
                            Text := LotNoList.GetSelectionFilter;
                            exit(true);
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        ClearInfo;
                        LotNoFilterOnAfterValidate;
                    end;
                }
            }
            repeater(Control16)
            {
                Editable = false;
                ShowCaption = false;
                field("Entry No."; REC."Entry No.")
                {
                    ApplicationArea = all;
                    Caption = 'N° séquence';
                    Visible = false;
                }
                field("Table ID"; REC."Table ID")
                {
                    ApplicationArea = all;
                    Caption = 'ID table';
                    Visible = false;
                }
                field("Table Name"; REC."Table Name")
                {
                    ApplicationArea = all;
                    Caption = 'Nom de la table';
                }
                field("No. of Records"; REC."No. of Records")
                {
                    ApplicationArea = all;
                    DrillDown = true;
                    Caption = 'Nombre d''enregistrements';

                    trigger OnDrillDown()
                    begin
                        ShowRecords;
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Fi&nd")
            {
                ApplicationArea = all;
                Caption = '&Rechercher';
                Image = Find;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    FindPush;
                end;
            }
            action(Show)
            {
                ApplicationArea = all;
                Caption = 'Affic&her';
                Enabled = ShowEnable;
                Image = View;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ShowRecords;
                end;
            }
            action(Print)
            {
                ApplicationArea = all;
                Caption = '&Imprimer';
                Ellipsis = true;
                Enabled = PrintEnable;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ItemTrackingNavigate: Report "Item Tracking Navigate";
                    DocumentEntries: Report "Document Entries Delete";
                begin
                    if not Confirm(Text025) then exit;
                    if ItemTrackingSearch then begin
                        Clear(ItemTrackingNavigate);
                        ItemTrackingNavigate.TransferDocEntries(Rec);
                        ItemTrackingNavigate.TransferRecordBuffer(TempRecordBuffer);
                        ItemTrackingNavigate.TransferFilters(SerialNoFilter, LotNoFilter, '', '');
                        ItemTrackingNavigate.Run;
                    end else begin
                        DocumentEntries.TransferDocEntries(Rec);
                        DocumentEntries.TransferFilters(DocNoFilter, PostingDateFilter);
                        //GL2024    DocumentEntries.Run()
                        //GL2024 
                        //   DocumentEntries.UseRequestPage(false);
                        DocumentEntries.Run;
                        //GL2024 
                    end;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        SourceNameEnable := true;
        SourceNoEnable := true;
        SourceTypeEnable := true;
        DocTypeEnable := true;
        PrintEnable := true;
        ShowEnable := true;
    end;

    trigger OnOpenPage()
    begin
        if (NewDocNo = '') and (NewPostingDate = 0D) and (NewSerialNo = '') and (NewLotNo = '') then begin
            REC.DeleteAll;
            ShowEnable := false;
            PrintEnable := false;
            SetSource(0D, '', '', 0, '');
        end else
            if (NewSerialNo <> '') or (NewLotNo <> '') then begin
                REC.SetRange("Serial No. Filter", NewSerialNo);
                REC.SetRange("Lot No. Filter", NewLotNo);
                SerialNoFilter := REC.GetFilter("Serial No. Filter");
                LotNoFilter := REC.GetFilter("Lot No. Filter");
                ClearInfo;
                FindTrackingRecords;
            end else begin
                REC.SetRange("Document No.", NewDocNo);
                REC.SetRange("Posting Date", NewPostingDate);
                DocNoFilter := REC.GetFilter("Document No.");
                PostingDateFilter := REC.GetFilter("Posting Date");
                ContactType := Contacttype::" ";
                ContactNo := '';
                ExtDocNo := '';
                ClearTrackingInfo;
                FindRecords;
            end;
    end;

    var
        Text000: label 'Le type d''identifiant tiers n''a pas été spécifié.';
        Text001: label 'Il n''existe pas d''enregistrement comptabilisé avec ce numéro de document externe.';
        Text002: label 'Comptage des enregistrements...';
        Text003: label 'Facture vente enregistrée';
        Text004: label 'Avoir vente enregistré';
        Text005: label 'Expédition vente enregistrée';
        Text006: label 'Relances émises';
        Text007: label 'Factures d''intérêts émises';
        Text008: label 'Facture achat enregistrée';
        Text009: label 'Avoir achat enregistré';
        Text010: label 'Réception achat enregistrée';
        Text011: label 'Le numéro de document a été utilisé plusieurs fois.';
        Text012: label 'Cette combinaison de numéro de document et de date de comptabilisation a été utilisée plusieurs fois.';
        Text013: label 'Il n''existe pas d''enregistrement comptabilisé avec ce numéro de document.';
        Text014: label 'Il n''existe pas d''enregistrement pour cette combinaison de numéro de document et de date de comptabilisation.';
        Text015: label 'Trop de documents externes ont été trouvés. Veuillez spécifier un identifiant tiers.';
        Text016: label 'Trop de documents externes ont été trouvés. Utilisez la fonction Naviguer à partir des écritures correspondantes.';
        Text017: label 'Réception retour enreg.';
        Text018: label 'Expédition retour enreg.';
        Text019: label 'Expédition transfert enreg.';
        Text020: label 'Réception transfert enreg.';
        Text021: label 'Commande vente';
        Text022: label 'Facture vente';
        Text023: label 'Retour vente';
        Text024: label 'Avoir vente';
        sText003: label 'Facture service enreg.';
        sText004: label 'Avoir service enreg.';
        sText005: label 'Expédition service enreg.';
        sText021: label 'Commande service';
        sText022: label 'Facture service';
        sText024: label 'Avoir service';
        Text99000000: label 'Ordre de fabrication';
        Cust: Record Customer;
        Vend: Record Vendor;
        SOSalesHeader: Record "Sales Header";
        SISalesHeader: Record "Sales Header";
        SROSalesHeader: Record "Sales Header";
        SCMSalesHeader: Record "Sales Header";
        SalesShptHeader: Record "Sales Shipment Header";
        SalesInvHeader: Record "Sales Invoice Header";
        ReturnRcptHeader: Record "Return Receipt Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SOServHeader: Record "Service Header";
        SIServHeader: Record "Service Header";
        SCMServHeader: Record "Service Header";
        ServShptHeader: Record "Service Shipment Header";
        ServInvHeader: Record "Service Invoice Header";
        ServCrMemoHeader: Record "Service Cr.Memo Header";
        IssuedReminderHeader: Record "Issued Reminder Header";
        IssuedFinChrgMemoHeader: Record "Issued Fin. Charge Memo Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        ReturnShptHeader: Record "Return Shipment Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        ProductionOrderHeader: Record "Production Order";
        TransShptHeader: Record "Transfer Shipment Header";
        TransRcptHeader: Record "Transfer Receipt Header";
        PostedWhseRcptLine: Record "Posted Whse. Receipt Line";
        PostedWhseShptLine: Record "Posted Whse. Shipment Line";
        GLEntry: Record "G/L Entry";
        VATEntry: Record "VAT Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
        PhysInvtLedgEntry: Record "Phys. Inventory Ledger Entry";
        ResLedgEntry: Record "Res. Ledger Entry";
        JobLedgEntry: Record "Job Ledger Entry";
        ValueEntry: Record "Value Entry";
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        CheckLedgEntry: Record "Check Ledger Entry";
        ReminderEntry: Record "Reminder/Fin. Charge Entry";
        FALedgEntry: Record "FA Ledger Entry";
        MaintenanceLedgEntry: Record "Maintenance Ledger Entry";
        InsuranceCovLedgEntry: Record "Ins. Coverage Ledger Entry";
        CapacityLedgEntry: Record "Capacity Ledger Entry";
        ServLedgerEntry: Record "Service Ledger Entry";
        WarrantyLedgerEntry: Record "Warranty Ledger Entry";
        WhseEntry: Record "Warehouse Entry";
        TempRecordBuffer: Record "Record Buffer" temporary;
        wProdCompletionEntry: Record "Production Completion Entry";
        wAdvancedJobBudgetEntry: Record "Advanced Job Budget Entry";
        //GL2024 CDU 1 N'EXISTE PAS DANS BC  ApplicationManagement: Codeunit ApplicationManagement;
        ItemTrackingNavigateMgt: Codeunit "Item Tracking Navigate Mgt.";
        Window: Dialog;
        DocNoFilter: Code[250];
        PostingDateFilter: Text[250];
        NewDocNo: Code[20];
        ContactNo: Code[250];
        ExtDocNo: Code[250];
        NewPostingDate: Date;
        DocType: Text[50];
        SourceType: Text[30];
        SourceNo: Code[20];
        SourceName: Text[50];
        ContactType: Option " ",Vendor,Customer;
        DocExists: Boolean;
        NewSerialNo: Code[20];
        NewLotNo: Code[20];
        SerialNoFilter: Code[1000];
        LotNoFilter: Code[1000];
        PaymentHeader: Record "Payment Header";
        PaymentLine: Record "Payment Line";
        PaymentHeaderArchive: Record "Payment Header Archive";
        PaymentLineArchive: Record "Payment Line Archive";
        Text025: label 'Attention Vous Allez Supprimer Tous Ces Enregistrements';
        [InDataSet]
        ShowEnable: Boolean;
        [InDataSet]
        PrintEnable: Boolean;
        [InDataSet]
        DocTypeEnable: Boolean;
        [InDataSet]
        SourceTypeEnable: Boolean;
        [InDataSet]
        SourceNoEnable: Boolean;
        [InDataSet]
        SourceNameEnable: Boolean;


    procedure SetDoc(PostingDate: Date; DocNo: Code[20])
    begin
        NewDocNo := DocNo;
        NewPostingDate := PostingDate;
    end;

    local procedure FindExtRecords()
    var
        VendLedgEntry2: Record "Vendor Ledger Entry";
        FoundRecords: Boolean;
        DateFilter2: Code[250];
        DocNoFilter2: Code[250];
    begin
        FoundRecords := false;
        case ContactType of
            Contacttype::Vendor:
                begin
                    VendLedgEntry2.SetCurrentkey("External Document No.");
                    VendLedgEntry2.SetFilter("External Document No.", ExtDocNo);
                    VendLedgEntry2.SetFilter("Vendor No.", ContactNo);
                    if VendLedgEntry2.FindSet then begin
                        repeat
                            MakeExtFilter(
                              DateFilter2,
                              VendLedgEntry2."Posting Date",
                              DocNoFilter2,
                              VendLedgEntry2."Document No.");
                        until VendLedgEntry2.Next = 0;
                        SetPostingDate(DateFilter2);
                        SetDocNo(DocNoFilter2);
                        FindRecords;
                        FoundRecords := true;
                    end;
                end;
            Contacttype::Customer:
                begin
                    REC.DeleteAll;
                    REC."Entry No." := 0;
                    FindUnpostedSalesDocs(SOSalesHeader."document type"::Order, Text021, SOSalesHeader);
                    FindUnpostedSalesDocs(SISalesHeader."document type"::Invoice, Text022, SISalesHeader);
                    FindUnpostedSalesDocs(SROSalesHeader."document type"::"Return Order", Text023, SROSalesHeader);
                    FindUnpostedSalesDocs(SCMSalesHeader."document type"::"Credit Memo", Text024, SCMSalesHeader);
                    if SalesShptHeader.ReadPermission then begin
                        SalesShptHeader.Reset;
                        SalesShptHeader.SetCurrentkey("Sell-to Customer No.", "External Document No.");
                        SalesShptHeader.SetFilter("Sell-to Customer No.", ContactNo);
                        SalesShptHeader.SetFilter("External Document No.", ExtDocNo);
                        InsertIntoDocEntry(
                          Database::"Sales Shipment Header", 0, Text005, SalesShptHeader.Count);
                    end;
                    if SalesInvHeader.ReadPermission then begin
                        SalesInvHeader.Reset;
                        SalesInvHeader.SetCurrentkey("Sell-to Customer No.", "External Document No.");
                        SalesInvHeader.SetFilter("Sell-to Customer No.", ContactNo);
                        SalesInvHeader.SetFilter("External Document No.", ExtDocNo);
                        InsertIntoDocEntry(
                          Database::"Sales Invoice Header", 0, Text003, SalesInvHeader.Count);
                    end;
                    if ReturnRcptHeader.ReadPermission then begin
                        ReturnRcptHeader.Reset;
                        ReturnRcptHeader.SetCurrentkey("Sell-to Customer No.", "External Document No.");
                        ReturnRcptHeader.SetFilter("Sell-to Customer No.", ContactNo);
                        ReturnRcptHeader.SetFilter("External Document No.", ExtDocNo);
                        InsertIntoDocEntry(
                          Database::"Return Receipt Header", 0, Text017, ReturnRcptHeader.Count);
                    end;
                    if SalesCrMemoHeader.ReadPermission then begin
                        SalesCrMemoHeader.Reset;
                        SalesCrMemoHeader.SetCurrentkey("Sell-to Customer No.", "External Document No.");
                        SalesCrMemoHeader.SetFilter("Sell-to Customer No.", ContactNo);
                        SalesCrMemoHeader.SetFilter("External Document No.", ExtDocNo);
                        InsertIntoDocEntry(
                          Database::"Sales Cr.Memo Header", 0, Text004, SalesCrMemoHeader.Count);
                    end;
                    FindUnpostedServDocs(SOServHeader."document type"::Order, sText021, SOServHeader);
                    FindUnpostedServDocs(SIServHeader."document type"::Invoice, sText022, SIServHeader);
                    FindUnpostedServDocs(SCMServHeader."document type"::"Credit Memo", sText024, SCMServHeader);
                    if ServShptHeader.ReadPermission then begin
                        if ExtDocNo = '' then begin
                            ServShptHeader.Reset;
                            ServShptHeader.SetCurrentkey("Customer No.");
                            ServShptHeader.SetFilter("Customer No.", ContactNo);
                            InsertIntoDocEntry(
                              Database::"Service Shipment Header", 0, sText005, ServShptHeader.Count);
                        end;
                    end;
                    if ServInvHeader.ReadPermission then begin
                        if ExtDocNo = '' then begin
                            ServInvHeader.Reset;
                            ServShptHeader.SetCurrentkey("Customer No.");
                            ServInvHeader.SetFilter("Customer No.", ContactNo);
                            InsertIntoDocEntry(
                              Database::"Service Invoice Header", 0, sText003, ServInvHeader.Count);
                        end;
                    end;
                    if ServCrMemoHeader.ReadPermission then begin
                        if ExtDocNo = '' then begin
                            ServCrMemoHeader.Reset;
                            ServShptHeader.SetCurrentkey("Customer No.");
                            ServCrMemoHeader.SetFilter("Customer No.", ContactNo);
                            InsertIntoDocEntry(
                              Database::"Service Cr.Memo Header", 0, sText004, ServCrMemoHeader.Count);
                        end;
                    end;

                    DocExists := REC.FindFirst;

                    UpdateFormAfterFindRecords;
                    FoundRecords := DocExists;
                end;
            else
                Error(Text000);
        end;

        if not FoundRecords then begin
            SetSource(0D, '', '', 0, '');
            Message(Text001);
        end;
    end;

    local procedure FindRecords()
    begin
        Window.Open(Text002);
        REC.Reset;
        REC.DeleteAll;
        REC."Entry No." := 0;
        if SalesShptHeader.ReadPermission then begin
            SalesShptHeader.Reset;
            SalesShptHeader.SetFilter("No.", DocNoFilter);
            SalesShptHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Sales Shipment Header", 0, Text005, SalesShptHeader.Count);
        end;
        if SalesInvHeader.ReadPermission then begin
            SalesInvHeader.Reset;
            SalesInvHeader.SetFilter("No.", DocNoFilter);
            SalesInvHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Sales Invoice Header", 0, Text003, SalesInvHeader.Count);
        end;
        if ReturnRcptHeader.ReadPermission then begin
            ReturnRcptHeader.Reset;
            ReturnRcptHeader.SetFilter("No.", DocNoFilter);
            ReturnRcptHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Return Receipt Header", 0, Text017, ReturnRcptHeader.Count);
        end;
        if SalesCrMemoHeader.ReadPermission then begin
            SalesCrMemoHeader.Reset;
            SalesCrMemoHeader.SetFilter("No.", DocNoFilter);
            SalesCrMemoHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Sales Cr.Memo Header", 0, Text004, SalesCrMemoHeader.Count);
        end;
        if ServShptHeader.ReadPermission then begin
            ServShptHeader.Reset;
            ServShptHeader.SetFilter("No.", DocNoFilter);
            ServShptHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Service Shipment Header", 0, sText005, ServShptHeader.Count);
        end;
        if ServInvHeader.ReadPermission then begin
            ServInvHeader.Reset;
            ServInvHeader.SetFilter("No.", DocNoFilter);
            ServInvHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Service Invoice Header", 0, sText003, ServInvHeader.Count);
        end;
        if ServCrMemoHeader.ReadPermission then begin
            ServCrMemoHeader.Reset;
            ServCrMemoHeader.SetFilter("No.", DocNoFilter);
            ServCrMemoHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Service Cr.Memo Header", 0, sText004, ServCrMemoHeader.Count);
        end;
        if IssuedReminderHeader.ReadPermission then begin
            IssuedReminderHeader.Reset;
            IssuedReminderHeader.SetFilter("No.", DocNoFilter);
            IssuedReminderHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Issued Reminder Header", 0, Text006, IssuedReminderHeader.Count);
        end;
        if IssuedFinChrgMemoHeader.ReadPermission then begin
            IssuedFinChrgMemoHeader.Reset;
            IssuedFinChrgMemoHeader.SetFilter("No.", DocNoFilter);
            IssuedFinChrgMemoHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Issued Fin. Charge Memo Header", 0, Text007,
              IssuedFinChrgMemoHeader.Count);
        end;
        if PurchRcptHeader.ReadPermission then begin
            PurchRcptHeader.Reset;
            PurchRcptHeader.SetFilter("No.", DocNoFilter);
            PurchRcptHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Purch. Rcpt. Header", 0, Text010, PurchRcptHeader.Count);
        end;
        if PurchInvHeader.ReadPermission then begin
            PurchInvHeader.Reset;
            PurchInvHeader.SetFilter("No.", DocNoFilter);
            PurchInvHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Purch. Inv. Header", 0, Text008, PurchInvHeader.Count);
        end;
        if ReturnShptHeader.ReadPermission then begin
            ReturnShptHeader.Reset;
            ReturnShptHeader.SetFilter("No.", DocNoFilter);
            ReturnShptHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Return Shipment Header", 0, Text018, ReturnShptHeader.Count);
        end;
        if PurchCrMemoHeader.ReadPermission then begin
            PurchCrMemoHeader.Reset;
            PurchCrMemoHeader.SetFilter("No.", DocNoFilter);
            PurchCrMemoHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Purch. Cr. Memo Hdr.", 0, Text009, PurchCrMemoHeader.Count);
        end;
        if ProductionOrderHeader.ReadPermission then begin
            ProductionOrderHeader.Reset;
            ProductionOrderHeader.SetRange(
              Status,
              ProductionOrderHeader.Status::Released,
              ProductionOrderHeader.Status::Finished);
            ProductionOrderHeader.SetFilter("No.", DocNoFilter);
            InsertIntoDocEntry(
              Database::"Production Order", 0, Text99000000, ProductionOrderHeader.Count);
        end;
        if TransShptHeader.ReadPermission then begin
            TransShptHeader.Reset;
            TransShptHeader.SetFilter("No.", DocNoFilter);
            TransShptHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Transfer Shipment Header", 0, Text019, TransShptHeader.Count);
        end;
        if TransRcptHeader.ReadPermission then begin
            TransRcptHeader.Reset;
            TransRcptHeader.SetFilter("No.", DocNoFilter);
            TransRcptHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Transfer Receipt Header", 0, Text020, TransRcptHeader.Count);
        end;
        if PostedWhseShptLine.ReadPermission then begin
            PostedWhseShptLine.Reset;
            PostedWhseShptLine.SetCurrentkey("Posted Source No.", "Posting Date");
            PostedWhseShptLine.SetFilter("Posted Source No.", DocNoFilter);
            PostedWhseShptLine.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Posted Whse. Shipment Line", 0,
              PostedWhseShptLine.TableCaption, PostedWhseShptLine.Count);
        end;
        if PostedWhseRcptLine.ReadPermission then begin
            PostedWhseRcptLine.Reset;
            PostedWhseRcptLine.SetCurrentkey("Posted Source No.", "Posting Date");
            PostedWhseRcptLine.SetFilter("Posted Source No.", DocNoFilter);
            PostedWhseRcptLine.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Posted Whse. Receipt Line", 0,
              PostedWhseRcptLine.TableCaption, PostedWhseRcptLine.Count);
        end;
        if GLEntry.ReadPermission then begin
            GLEntry.Reset;
            GLEntry.SetCurrentkey("Document No.", "Posting Date");
            GLEntry.SetFilter("Document No.", DocNoFilter);
            GLEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"G/L Entry", 0, GLEntry.TableCaption, GLEntry.Count);
        end;
        //BSK 03/07/2012
        /*IF Payementheader.READPERMISSION THEN BEGIN
          Payementheader.RESET;
          Payementheader.SETCURRENTKEY("No.","Posting Date");
          Payementheader.SETFILTER("No.",DocNoFilter);
         Payementheader.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Payment Header",0,Payementheader.TABLECAPTION,Payementheader.COUNT);
        END; */
        if PaymentHeader.ReadPermission then begin
            PaymentHeader.Reset;
            PaymentHeader.SetCurrentkey("Posting Date");
            PaymentHeader.SetFilter("No.", DocNoFilter);
            PaymentHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Payment Header", 0, PaymentHeader.TableCaption, PaymentHeader.Count);
        end;
        if PaymentLine.ReadPermission then begin
            PaymentLine.Reset;
            PaymentLine.SetCurrentkey("Posting Date");
            PaymentLine.SetFilter("Document No.", DocNoFilter);
            PaymentLine.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Payment Line", 0, PaymentLine.TableCaption, PaymentLine.Count);
        end;
        if PaymentHeaderArchive.ReadPermission then begin
            PaymentHeaderArchive.Reset;
            PaymentHeaderArchive.SetCurrentkey("Posting Date");
            PaymentHeaderArchive.SetFilter("No.", DocNoFilter);
            PaymentHeaderArchive.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Payment Header Archive", 0, PaymentHeaderArchive.TableCaption, PaymentHeaderArchive.Count);
        end;
        if PaymentLineArchive.ReadPermission then begin
            PaymentLineArchive.Reset;
            PaymentLineArchive.SetCurrentkey("Posting Date");
            PaymentLineArchive.SetFilter("Document No.", DocNoFilter);
            PaymentLineArchive.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Payment Line Archive", 0, PaymentLineArchive.TableCaption, PaymentLineArchive.Count);
        end;

        //BSK 03/07/2012


        if VATEntry.ReadPermission then begin
            VATEntry.Reset;
            VATEntry.SetCurrentkey("Document No.", "Posting Date");
            VATEntry.SetFilter("Document No.", DocNoFilter);
            VATEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"VAT Entry", 0, VATEntry.TableCaption, VATEntry.Count);
        end;
        if CustLedgEntry.ReadPermission then begin
            CustLedgEntry.Reset;
            CustLedgEntry.SetCurrentkey("Document No.");
            CustLedgEntry.SetFilter("Document No.", DocNoFilter);
            CustLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Cust. Ledger Entry", 0, CustLedgEntry.TableCaption, CustLedgEntry.Count);
        end;
        if DtldCustLedgEntry.ReadPermission then begin
            DtldCustLedgEntry.Reset;
            DtldCustLedgEntry.SetCurrentkey("Document No.");
            DtldCustLedgEntry.SetFilter("Document No.", DocNoFilter);
            DtldCustLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Detailed Cust. Ledg. Entry", 0, DtldCustLedgEntry.TableCaption, DtldCustLedgEntry.Count);
        end;
        if ReminderEntry.ReadPermission then begin
            ReminderEntry.Reset;
            ReminderEntry.SetCurrentkey(Type, "No.");
            ReminderEntry.SetFilter("No.", DocNoFilter);
            ReminderEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Reminder/Fin. Charge Entry", 0, ReminderEntry.TableCaption, ReminderEntry.Count);
        end;
        if VendLedgEntry.ReadPermission then begin
            VendLedgEntry.Reset;
            VendLedgEntry.SetCurrentkey("Document No.");
            VendLedgEntry.SetFilter("Document No.", DocNoFilter);
            VendLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Vendor Ledger Entry", 0, VendLedgEntry.TableCaption, VendLedgEntry.Count);
        end;
        if DtldVendLedgEntry.ReadPermission then begin
            DtldVendLedgEntry.Reset;
            DtldVendLedgEntry.SetCurrentkey("Document No.");
            DtldVendLedgEntry.SetFilter("Document No.", DocNoFilter);
            DtldVendLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Detailed Vendor Ledg. Entry", 0, DtldVendLedgEntry.TableCaption, DtldVendLedgEntry.Count);
        end;
        if ItemLedgEntry.ReadPermission then begin
            ItemLedgEntry.Reset;
            ItemLedgEntry.SetCurrentkey("Document No.");
            ItemLedgEntry.SetFilter("Document No.", DocNoFilter);
            ItemLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Item Ledger Entry", 0, ItemLedgEntry.TableCaption, ItemLedgEntry.Count);
        end;
        if ValueEntry.ReadPermission then begin
            ValueEntry.Reset;
            ValueEntry.SetCurrentkey("Document No.");
            ValueEntry.SetFilter("Document No.", DocNoFilter);
            ValueEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Value Entry", 0, ValueEntry.TableCaption, ValueEntry.Count);
        end;
        if PhysInvtLedgEntry.ReadPermission then begin
            PhysInvtLedgEntry.Reset;
            PhysInvtLedgEntry.SetCurrentkey("Document No.", "Posting Date");
            PhysInvtLedgEntry.SetFilter("Document No.", DocNoFilter);
            PhysInvtLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Phys. Inventory Ledger Entry", 0, PhysInvtLedgEntry.TableCaption, PhysInvtLedgEntry.Count);
        end;
        if ResLedgEntry.ReadPermission then begin
            ResLedgEntry.Reset;
            ResLedgEntry.SetCurrentkey("Document No.", "Posting Date");
            ResLedgEntry.SetFilter("Document No.", DocNoFilter);
            ResLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Res. Ledger Entry", 0, ResLedgEntry.TableCaption, ResLedgEntry.Count);
        end;
        if JobLedgEntry.ReadPermission then begin
            JobLedgEntry.Reset;
            JobLedgEntry.SetCurrentkey("Document No.", "Posting Date");
            JobLedgEntry.SetFilter("Document No.", DocNoFilter);
            JobLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Job Ledger Entry", 0, JobLedgEntry.TableCaption, JobLedgEntry.Count);
        end;
        if BankAccLedgEntry.ReadPermission then begin
            BankAccLedgEntry.Reset;
            BankAccLedgEntry.SetCurrentkey("Document No.", "Posting Date");
            BankAccLedgEntry.SetFilter("Document No.", DocNoFilter);
            BankAccLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Bank Account Ledger Entry", 0, BankAccLedgEntry.TableCaption, BankAccLedgEntry.Count);
        end;
        if CheckLedgEntry.ReadPermission then begin
            CheckLedgEntry.Reset;
            CheckLedgEntry.SetCurrentkey("Document No.", "Posting Date");
            CheckLedgEntry.SetFilter("Document No.", DocNoFilter);
            CheckLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Check Ledger Entry", 0, CheckLedgEntry.TableCaption, CheckLedgEntry.Count);
        end;
        if FALedgEntry.ReadPermission then begin
            FALedgEntry.Reset;
            FALedgEntry.SetCurrentkey("Document No.", "Posting Date");
            FALedgEntry.SetFilter("Document No.", DocNoFilter);
            FALedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"FA Ledger Entry", 0, FALedgEntry.TableCaption, FALedgEntry.Count);
        end;
        if MaintenanceLedgEntry.ReadPermission then begin
            MaintenanceLedgEntry.Reset;
            MaintenanceLedgEntry.SetCurrentkey("Document No.", "Posting Date");
            MaintenanceLedgEntry.SetFilter("Document No.", DocNoFilter);
            MaintenanceLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Maintenance Ledger Entry", 0, MaintenanceLedgEntry.TableCaption, MaintenanceLedgEntry.Count);
        end;
        if InsuranceCovLedgEntry.ReadPermission then begin
            InsuranceCovLedgEntry.Reset;
            InsuranceCovLedgEntry.SetCurrentkey("Document No.", "Posting Date");
            InsuranceCovLedgEntry.SetFilter("Document No.", DocNoFilter);
            InsuranceCovLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Ins. Coverage Ledger Entry", 0, InsuranceCovLedgEntry.TableCaption, InsuranceCovLedgEntry.Count);
        end;
        if CapacityLedgEntry.ReadPermission then begin
            CapacityLedgEntry.Reset;
            CapacityLedgEntry.SetCurrentkey("Document No.", "Posting Date");
            CapacityLedgEntry.SetFilter("Document No.", DocNoFilter);
            CapacityLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Capacity Ledger Entry", 0, CapacityLedgEntry.TableCaption, CapacityLedgEntry.Count);
        end;
        if WhseEntry.ReadPermission then begin
            WhseEntry.Reset;
            WhseEntry.SetCurrentkey("Reference No.", "Registering Date");
            WhseEntry.SetFilter("Reference No.", DocNoFilter);
            WhseEntry.SetFilter("Registering Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Warehouse Entry", 0, WhseEntry.TableCaption, WhseEntry.Count);
        end;

        if ServLedgerEntry.ReadPermission then begin
            ServLedgerEntry.Reset;
            ServLedgerEntry.SetCurrentkey("Document No.", "Posting Date");
            ServLedgerEntry.SetFilter("Document No.", DocNoFilter);
            ServLedgerEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Service Ledger Entry", 0, ServLedgerEntry.TableCaption, ServLedgerEntry.Count);
        end;
        if WarrantyLedgerEntry.ReadPermission then begin
            WarrantyLedgerEntry.Reset;
            WarrantyLedgerEntry.SetCurrentkey("Document No.", "Posting Date");
            WarrantyLedgerEntry.SetFilter("Document No.", DocNoFilter);
            WarrantyLedgerEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Warranty Ledger Entry", 0, WarrantyLedgerEntry.TableCaption, WarrantyLedgerEntry.Count);
        end;
        //NAVIONE
        if wProdCompletionEntry.ReadPermission then begin
            wProdCompletionEntry.Reset;
            wProdCompletionEntry.SetCurrentkey("Posting Date", "Document No.");
            wProdCompletionEntry.SetFilter("Document No.", DocNoFilter);
            wProdCompletionEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Production Completion Entry", 0, wProdCompletionEntry.TableCaption, wProdCompletionEntry.Count);
        end;
        /*
          IF wInvCompletionEntry.READPERMISSION THEN BEGIN
            wInvCompletionEntry.RESET;
            wInvCompletionEntry.SETCURRENTKEY("Posting Date","Document No.");
            wInvCompletionEntry.SETFILTER("Document No.",DocNoFilter);
            wInvCompletionEntry.SETFILTER("Posting Date",PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::Table8003980,0,wInvCompletionEntry.TABLECAPTION,wInvCompletionEntry.COUNT);
          END;
          IF wCompletion.READPERMISSION THEN BEGIN
            wCompletion.RESET;
            wCompletion.SETCURRENTKEY("Posting Date","Document No.");
            wCompletion.SETFILTER("Document No.",DocNoFilter);
            wCompletion.SETFILTER("Posting Date",PostingDateFilter);
            InsertIntoDocEntry(
              DATABASE::Table8003986,0,wCompletion.TABLECAPTION,wCompletion.COUNT);
          END;
        */
        if wAdvancedJobBudgetEntry.ReadPermission then begin
            wAdvancedJobBudgetEntry.Reset;
            wAdvancedJobBudgetEntry.SetCurrentkey("Shipment No.");
            wAdvancedJobBudgetEntry.SetFilter("Shipment No.", DocNoFilter);
            wAdvancedJobBudgetEntry.SetFilter(Date, PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Advanced Job Budget Entry", 0, wAdvancedJobBudgetEntry.TableCaption, wAdvancedJobBudgetEntry.Count);
        end;
        //NAVIONE//
        DocExists := REC.FindFirst;

        SetSource(0D, '', '', 0, '');
        if DocExists then begin
            if (NoOfRecords(Database::"Cust. Ledger Entry") + NoOfRecords(Database::"Vendor Ledger Entry") <= 1) and
               (NoOfRecords(Database::"Sales Invoice Header") + NoOfRecords(Database::"Sales Cr.Memo Header") +
                NoOfRecords(Database::"Sales Shipment Header") + NoOfRecords(Database::"Issued Reminder Header") +
                NoOfRecords(Database::"Issued Fin. Charge Memo Header") + NoOfRecords(Database::"Purch. Inv. Header") +
                NoOfRecords(Database::"Return Shipment Header") + NoOfRecords(Database::"Return Receipt Header") +
                NoOfRecords(Database::"Purch. Cr. Memo Hdr.") + NoOfRecords(Database::"Purch. Rcpt. Header") +
                NoOfRecords(Database::"Service Invoice Header") + NoOfRecords(Database::"Service Cr.Memo Header") +
                NoOfRecords(Database::"Service Shipment Header") +
                NoOfRecords(Database::"Transfer Shipment Header") + NoOfRecords(Database::"Transfer Receipt Header") <= 1)
            then begin
                // Service Management
                if NoOfRecords(Database::"Service Ledger Entry") = 1 then begin
                    ServLedgerEntry.FindFirst;
                    if ServLedgerEntry.Type = ServLedgerEntry.Type::"Service Contract" then
                        SetSource(
                          ServLedgerEntry."Posting Date", Format(ServLedgerEntry."Document Type"), ServLedgerEntry."Document No.",
                          2, ServLedgerEntry."Service Contract No.")
                    else
                        SetSource(
                          ServLedgerEntry."Posting Date", Format(ServLedgerEntry."Document Type"), ServLedgerEntry."Document No.",
                          2, ServLedgerEntry."Service Order No.")
                end;
                if NoOfRecords(Database::"Warranty Ledger Entry") = 1 then begin
                    WarrantyLedgerEntry.FindFirst;
                    SetSource(
                      WarrantyLedgerEntry."Posting Date", '', WarrantyLedgerEntry."Document No.",
                      2, WarrantyLedgerEntry."Service Order No.")
                end;

                // Sales
                if NoOfRecords(Database::"Cust. Ledger Entry") = 1 then begin
                    CustLedgEntry.FindFirst;
                    SetSource(
                      CustLedgEntry."Posting Date", Format(CustLedgEntry."Document Type"), CustLedgEntry."Document No.",
                      1, CustLedgEntry."Customer No.");
                end;
                if NoOfRecords(Database::"Detailed Cust. Ledg. Entry") = 1 then begin
                    DtldCustLedgEntry.FindFirst;
                    SetSource(
                      DtldCustLedgEntry."Posting Date", Format(DtldCustLedgEntry."Document Type"), DtldCustLedgEntry."Document No.",
                      1, DtldCustLedgEntry."Customer No.");
                end;
                if NoOfRecords(Database::"Sales Invoice Header") = 1 then begin
                    SalesInvHeader.FindFirst;
                    SetSource(
                      SalesInvHeader."Posting Date", Format(REC."Table Name"), SalesInvHeader."No.",
                      1, SalesInvHeader."Bill-to Customer No.");
                end;
                if NoOfRecords(Database::"Sales Cr.Memo Header") = 1 then begin
                    SalesCrMemoHeader.FindFirst;
                    SetSource(
                      SalesCrMemoHeader."Posting Date", Format(REC."Table Name"), SalesCrMemoHeader."No.",
                      1, SalesCrMemoHeader."Bill-to Customer No.");
                end;
                if NoOfRecords(Database::"Return Receipt Header") = 1 then begin
                    ReturnRcptHeader.FindFirst;
                    SetSource(
                      ReturnRcptHeader."Posting Date", Format(REC."Table Name"), ReturnRcptHeader."No.",
                      1, ReturnRcptHeader."Sell-to Customer No.");
                end;
                if NoOfRecords(Database::"Sales Shipment Header") = 1 then begin
                    SalesShptHeader.FindFirst;
                    SetSource(
                      SalesShptHeader."Posting Date", Format(REC."Table Name"), SalesShptHeader."No.",
                      1, SalesShptHeader."Sell-to Customer No.");
                end;
                if NoOfRecords(Database::"Posted Whse. Shipment Line") = 1 then begin
                    PostedWhseShptLine.FindFirst;
                    SetSource(
                      PostedWhseShptLine."Posting Date", Format(REC."Table Name"), PostedWhseShptLine."No.",
                      1, PostedWhseShptLine."Destination No.");
                end;
                if NoOfRecords(Database::"Issued Reminder Header") = 1 then begin
                    IssuedReminderHeader.FindFirst;
                    SetSource(
                      IssuedReminderHeader."Posting Date", Format(REC."Table Name"), IssuedReminderHeader."No.",
                      1, IssuedReminderHeader."Customer No.");
                end;
                if NoOfRecords(Database::"Issued Fin. Charge Memo Header") = 1 then begin
                    IssuedFinChrgMemoHeader.FindFirst;
                    SetSource(
                      IssuedFinChrgMemoHeader."Posting Date", Format(REC."Table Name"), IssuedFinChrgMemoHeader."No.",
                      1, IssuedFinChrgMemoHeader."Customer No.");
                end;

                if NoOfRecords(Database::"Service Invoice Header") = 1 then begin
                    ServInvHeader.Find('-');
                    SetSource(
                      ServInvHeader."Posting Date", Format(REC."Table Name"), ServInvHeader."No.",
                      1, ServInvHeader."Bill-to Customer No.");
                end;
                if NoOfRecords(Database::"Service Cr.Memo Header") = 1 then begin
                    ServCrMemoHeader.Find('-');
                    SetSource(
                      ServCrMemoHeader."Posting Date", Format(REC."Table Name"), ServCrMemoHeader."No.",
                      1, ServCrMemoHeader."Bill-to Customer No.");
                end;
                if NoOfRecords(Database::"Service Shipment Header") = 1 then begin
                    ServShptHeader.Find('-');
                    SetSource(
                      ServShptHeader."Posting Date", Format(REC."Table Name"), ServShptHeader."No.",
                      1, ServShptHeader."Customer No.");
                end;

                // Purchase
                if NoOfRecords(Database::"Vendor Ledger Entry") = 1 then begin
                    VendLedgEntry.FindFirst;
                    SetSource(
                      VendLedgEntry."Posting Date", Format(VendLedgEntry."Document Type"), VendLedgEntry."Document No.",
                      2, VendLedgEntry."Vendor No.");
                end;
                if NoOfRecords(Database::"Detailed Vendor Ledg. Entry") = 1 then begin
                    DtldVendLedgEntry.FindFirst;
                    SetSource(
                      DtldVendLedgEntry."Posting Date", Format(DtldVendLedgEntry."Document Type"), DtldVendLedgEntry."Document No.",
                      2, DtldVendLedgEntry."Vendor No.");
                end;
                if NoOfRecords(Database::"Purch. Inv. Header") = 1 then begin
                    PurchInvHeader.FindFirst;
                    SetSource(
                      PurchInvHeader."Posting Date", Format(REC."Table Name"), PurchInvHeader."No.",
                      2, PurchInvHeader."Pay-to Vendor No.");
                end;
                if NoOfRecords(Database::"Purch. Cr. Memo Hdr.") = 1 then begin
                    PurchCrMemoHeader.FindFirst;
                    SetSource(
                      PurchCrMemoHeader."Posting Date", Format(REC."Table Name"), PurchCrMemoHeader."No.",
                      2, PurchCrMemoHeader."Pay-to Vendor No.");
                end;
                if NoOfRecords(Database::"Return Shipment Header") = 1 then begin
                    ReturnShptHeader.FindFirst;
                    SetSource(
                      ReturnShptHeader."Posting Date", Format(REC."Table Name"), ReturnShptHeader."No.",
                      2, ReturnShptHeader."Buy-from Vendor No.");
                end;
                if NoOfRecords(Database::"Purch. Rcpt. Header") = 1 then begin
                    PurchRcptHeader.FindFirst;
                    SetSource(
                      PurchRcptHeader."Posting Date", Format(REC."Table Name"), PurchRcptHeader."No.",
                      2, PurchRcptHeader."Buy-from Vendor No.");
                end;
                if NoOfRecords(Database::"Posted Whse. Receipt Line") = 1 then begin
                    PostedWhseRcptLine.FindFirst;
                    SetSource(
                      PostedWhseRcptLine."Posting Date", Format(REC."Table Name"), PostedWhseRcptLine."No.",
                      2, '');
                end;
                //NAVIONE
                if NoOfRecords(Database::"Production Completion Entry") = 1 then begin
                    wProdCompletionEntry.FindFirst;
                    SetSource(
                       wProdCompletionEntry."Posting Date", Format(REC."Table Name"), wProdCompletionEntry."Document No.",
                       1, '');
                end;
                /*
                      IF NoOfRecords(DATABASE::Table8003980) = 1 THEN BEGIN
                        wInvCompletionEntry.FINDFIRST;
                        SetSource(
                           wInvCompletionEntry."Posting Date",FORMAT("Table Name"),wInvCompletionEntry."Document No.",
                           1,'');
                      END;
                      IF NoOfRecords(DATABASE::Table8003986) = 1 THEN BEGIN
                        wCompletion.FINDFIRST;
                        SetSource(
                           wCompletion."Posting Date",FORMAT("Table Name"),wCompletion."Document No.",
                           1,'');
                      END;
                */
                //NAVIONE//
            end else begin
                if DocNoFilter <> '' then
                    if PostingDateFilter = '' then
                        Message(Text011)
                    else
                        Message(Text012);
            end;
        end else
            if PostingDateFilter = '' then
                Message(Text013)
            else
                Message(Text014);

        UpdateFormAfterFindRecords;
        Window.Close;

    end;

    local procedure UpdateFormAfterFindRecords()
    begin
        ShowEnable := DocExists;
        PrintEnable := DocExists;
        CurrPage.Update(false);
        DocExists := REC.FindFirst;
        if DocExists then;
    end;

    local procedure InsertIntoDocEntry(DocTableID: Integer; DocType: Option; DocTableName: Text[1024]; DocNoOfRecords: Integer)
    begin
        if DocNoOfRecords = 0 then
            exit;
        REC.Init;
        REC."Entry No." := REC."Entry No." + 1;
        REC."Table ID" := DocTableID;
        REC."Document Type" := DocType;
        REC."Table Name" := CopyStr(DocTableName, 1, MaxStrLen(REC."Table Name"));
        REC."No. of Records" := DocNoOfRecords;
        REC.Insert;
    end;

    local procedure NoOfRecords(TableID: Integer): Integer
    begin
        REC.SetRange("Table ID", TableID);
        if not REC.FindFirst then
            REC.Init;
        REC.SetRange("Table ID");
        exit(REC."No. of Records");
    end;

    local procedure SetSource(PostingDate: Date; DocType2: Text[50]; DocNo: Text[50]; SourceType2: Integer; SourceNo2: Code[20])
    begin
        if SourceType2 = 0 then begin
            DocType := '';
            SourceType := '';
            SourceNo := '';
            SourceName := '';
        end else begin
            DocType := DocType2;
            SourceNo := SourceNo2;
            REC.SetRange("Document No.", DocNo);
            REC.SetRange("Posting Date", PostingDate);
            DocNoFilter := REC.GetFilter("Document No.");
            PostingDateFilter := REC.GetFilter("Posting Date");
            case SourceType2 of
                1:
                    begin
                        SourceType := Cust.TableCaption;
                        if not Cust.Get(SourceNo) then
                            Cust.Init;
                        SourceName := Cust.Name;
                    end;
                2:
                    begin
                        SourceType := Vend.TableCaption;
                        if not Vend.Get(SourceNo) then
                            Vend.Init;
                        SourceName := Vend.Name;
                    end;
            end;
        end;
        DocTypeEnable := SourceType2 <> 0;
        SourceTypeEnable := SourceType2 <> 0;
        SourceNoEnable := SourceType2 <> 0;
        SourceNameEnable := SourceType2 <> 0;
    end;

    local procedure ShowRecords()
    begin
        if ItemTrackingSearch then
            ItemTrackingNavigateMgt.Show(REC."Table ID")
        else begin
            case REC."Table ID" of
                Database::"Sales Header":
                    case REC."Document Type" of
                        REC."document type"::Order:
                            if REC."No. of Records" = 1 then
                                PAGE.Run(PAGE::"Sales Order", SOSalesHeader)
                            else
                                Page.Run(0, SOSalesHeader);
                        REC."document type"::Invoice:
                            if REC."No. of Records" = 1 then
                                Page.Run(Page::"Sales Invoice", SISalesHeader)
                            else
                                Page.Run(0, SISalesHeader);
                        REC."document type"::"Return Order":
                            if REC."No. of Records" = 1 then
                                Page.Run(Page::"Sales Return Order", SROSalesHeader)
                            else
                                Page.Run(0, SROSalesHeader);
                        REC."document type"::"Credit Memo":
                            if REC."No. of Records" = 1 then
                                Page.Run(Page::"Sales Credit Memo", SCMSalesHeader)
                            else
                                Page.Run(0, SCMSalesHeader);
                    end;
                Database::"Sales Invoice Header":
                    if REC."No. of Records" = 1 then
                        Page.Run(Page::"Posted Sales Invoice", SalesInvHeader)
                    else
                        Page.Run(0, SalesInvHeader);
                Database::"Sales Cr.Memo Header":
                    if REC."No. of Records" = 1 then
                        Page.Run(Page::"Posted Sales Credit Memo", SalesCrMemoHeader)
                    else
                        Page.Run(0, SalesCrMemoHeader);
                Database::"Return Receipt Header":
                    if REC."No. of Records" = 1 then
                        Page.Run(Page::"Posted Return Receipt", ReturnRcptHeader)
                    else
                        Page.Run(0, ReturnRcptHeader);
                Database::"Sales Shipment Header":
                    if REC."No. of Records" = 1 then
                        Page.Run(Page::"Posted Sales Shipment", SalesShptHeader)
                    else
                        Page.Run(0, SalesShptHeader);
                Database::"Issued Reminder Header":
                    if REC."No. of Records" = 1 then
                        Page.Run(Page::"Issued Reminder", IssuedReminderHeader)
                    else
                        Page.Run(0, IssuedReminderHeader);
                Database::"Issued Fin. Charge Memo Header":
                    if REC."No. of Records" = 1 then
                        Page.Run(Page::"Issued Finance Charge Memo", IssuedFinChrgMemoHeader)
                    else
                        Page.Run(0, IssuedFinChrgMemoHeader);
                Database::"Purch. Inv. Header":
                    if REC."No. of Records" = 1 then
                        Page.Run(Page::"Posted Purchase Invoice", PurchInvHeader)
                    else
                        Page.Run(0, PurchInvHeader);
                Database::"Purch. Cr. Memo Hdr.":
                    if REC."No. of Records" = 1 then
                        Page.Run(Page::"Posted Purchase Credit Memo", PurchCrMemoHeader)
                    else
                        Page.Run(0, PurchCrMemoHeader);
                Database::"Return Shipment Header":
                    if REC."No. of Records" = 1 then
                        Page.Run(Page::"Posted Return Shipment", ReturnShptHeader)
                    else
                        Page.Run(0, ReturnShptHeader);
                Database::"Purch. Rcpt. Header":
                    if REC."No. of Records" = 1 then
                        Page.Run(Page::"Posted Purchase Receipt", PurchRcptHeader)
                    else
                        Page.Run(0, PurchRcptHeader);
                Database::"Production Order":
                    Page.Run(0, ProductionOrderHeader);
                Database::"Transfer Shipment Header":
                    if REC."No. of Records" = 1 then
                        Page.Run(Page::"Posted Transfer Shipment", TransShptHeader)
                    else
                        Page.Run(0, TransShptHeader);
                Database::"Transfer Receipt Header":
                    if REC."No. of Records" = 1 then
                        Page.Run(Page::"Posted Transfer Receipt", TransRcptHeader)
                    else
                        Page.Run(0, TransRcptHeader);
                Database::"Posted Whse. Shipment Line":
                    Page.Run(0, PostedWhseShptLine);
                Database::"Posted Whse. Receipt Line":
                    Page.Run(0, PostedWhseRcptLine);
                Database::"G/L Entry":
                    Page.Run(0, GLEntry);
                Database::"VAT Entry":
                    Page.Run(0, VATEntry);
                Database::"Detailed Cust. Ledg. Entry":
                    Page.Run(0, DtldCustLedgEntry);
                Database::"Cust. Ledger Entry":
                    Page.Run(0, CustLedgEntry);
                Database::"Reminder/Fin. Charge Entry":
                    Page.Run(0, ReminderEntry);
                Database::"Vendor Ledger Entry":
                    Page.Run(0, VendLedgEntry);
                Database::"Detailed Vendor Ledg. Entry":
                    Page.Run(0, DtldVendLedgEntry);
                Database::"Item Ledger Entry":
                    Page.Run(0, ItemLedgEntry);
                Database::"Value Entry":
                    Page.Run(0, ValueEntry);
                Database::"Phys. Inventory Ledger Entry":
                    Page.Run(0, PhysInvtLedgEntry);
                Database::"Res. Ledger Entry":
                    Page.Run(0, ResLedgEntry);
                Database::"Job Ledger Entry":
                    Page.Run(0, JobLedgEntry);
                Database::"Bank Account Ledger Entry":
                    Page.Run(0, BankAccLedgEntry);
                Database::"Check Ledger Entry":
                    Page.Run(0, CheckLedgEntry);
                Database::"FA Ledger Entry":
                    Page.Run(0, FALedgEntry);
                Database::"Maintenance Ledger Entry":
                    Page.Run(0, MaintenanceLedgEntry);
                Database::"Ins. Coverage Ledger Entry":
                    Page.Run(0, InsuranceCovLedgEntry);
                Database::"Capacity Ledger Entry":
                    Page.Run(0, CapacityLedgEntry);
                Database::"Warehouse Entry":
                    Page.Run(0, WhseEntry);
                Database::"Service Header":
                    case REC."Document Type" of
                        REC."document type"::Order:
                            Page.Run(0, SOServHeader);
                        REC."document type"::Invoice:
                            Page.Run(0, SIServHeader);
                        REC."document type"::"Credit Memo":
                            Page.Run(0, SCMServHeader);
                    end;
                Database::"Service Invoice Header":
                    Page.Run(0, ServInvHeader);
                Database::"Service Cr.Memo Header":
                    Page.Run(0, ServCrMemoHeader);
                Database::"Service Shipment Header":
                    Page.Run(0, ServShptHeader);
                Database::"Service Ledger Entry":
                    Page.Run(0, ServLedgerEntry);
                Database::"Warranty Ledger Entry":
                    Page.Run(0, WarrantyLedgerEntry);
                //BSK 03/07/2012

                Database::"Payment Header":
                    Page.Run(0, PaymentHeader);
                Database::"Payment Line":
                    Page.Run(0, PaymentLine);
                Database::"Payment Header Archive":
                    Page.Run(0, PaymentHeaderArchive);
                Database::"Payment Line Archive":
                    Page.Run(0, PaymentLineArchive);

                //BSK 03/07/2012


                //NAVIONE

                Database::"Production Completion Entry":
                    Page.Run(0, wProdCompletionEntry);
                /*
                    DATABASE::Table8003980:
                      Page.Run(0,wInvCompletionEntry);
                    DATABASE::Table8003986:
                      Page.Run(0,wCompletion);
                */
                Database::"Advanced Job Budget Entry":
                    Page.Run(0, wAdvancedJobBudgetEntry);
            //NAVIONE
            end;
        end;

    end;

    local procedure SetPostingDate(PostingDate: Text[250])
    begin
        /*GL2024 if ApplicationManagement.MakeDateFilter(PostingDate) = 0 then;
         REC.SetFilter("Posting Date", PostingDate);*/
        PostingDateFilter := REC.GetFilter("Posting Date");
    end;

    local procedure SetDocNo(DocNo: Text[250])
    begin
        REC.SetFilter("Document No.", DocNo);
        DocNoFilter := REC.GetFilter("Document No.");
        PostingDateFilter := REC.GetFilter("Posting Date");
    end;

    local procedure ClearSourceInfo()
    begin
        if DocExists then begin
            DocExists := false;
            REC.DeleteAll;
            ShowEnable := false;
            SetSource(0D, '', '', 0, '');
            CurrPage.Update(false);
        end;
    end;

    local procedure MakeExtFilter(var DateFilter: Code[250]; AddDate: Date; var DocNoFilter: Code[250]; AddDocNo: Code[20])
    begin
        if DateFilter = '' then
            DateFilter := Format(AddDate)
        else
            if StrPos(DateFilter, Format(AddDate)) = 0 then
                if MaxStrLen(DateFilter) >= StrLen(DateFilter + '|' + Format(AddDate)) then
                    DateFilter := DateFilter + '|' + Format(AddDate)
                else
                    TooLongFilter;

        if DocNoFilter = '' then
            DocNoFilter := AddDocNo
        else
            if StrPos(DocNoFilter, AddDocNo) = 0 then
                if MaxStrLen(DocNoFilter) >= StrLen(DocNoFilter + '|' + AddDocNo) then
                    DocNoFilter := DocNoFilter + '|' + AddDocNo
                else
                    TooLongFilter;
    end;

    local procedure FindPush()
    begin
        if (DocNoFilter = '') and (PostingDateFilter = '') and
           (not ItemTrackingSearch) and
           ((ContactType <> 0) or (ContactNo <> '') or (ExtDocNo <> ''))
        then
            FindExtRecords
        else
            if ItemTrackingSearch and
              (DocNoFilter = '') and (PostingDateFilter = '') and
              (ContactType = 0) and (ContactNo = '') and (ExtDocNo = '') then
                FindTrackingRecords
            else
                FindRecords;
    end;

    local procedure TooLongFilter()
    begin
        if ContactNo = '' then
            Error(Text015)
        else
            Error(Text016);
    end;

    local procedure FindUnpostedSalesDocs(DocType: Option; DocTableName: Text[100]; var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader.ReadPermission then begin
            SalesHeader.Reset;
            SalesHeader.SetCurrentkey("Sell-to Customer No.", "External Document No.");
            SalesHeader.SetFilter("Sell-to Customer No.", ContactNo);
            SalesHeader.SetFilter("External Document No.", ExtDocNo);
            SalesHeader.SetRange("Document Type", DocType);
            InsertIntoDocEntry(Database::"Sales Header", DocType, DocTableName, SalesHeader.Count);
        end;
    end;

    local procedure FindUnpostedServDocs(DocType: Option; DocTableName: Text[100]; var ServHeader: Record "Service Header")
    begin
        if ServHeader.ReadPermission then begin
            if ExtDocNo = '' then begin
                ServHeader.Reset;
                ServHeader.SetCurrentkey("Customer No.");
                ServHeader.SetFilter("Customer No.", ContactNo);
                ServHeader.SetRange("Document Type", DocType);
                InsertIntoDocEntry(Database::"Service Header", DocType, DocTableName, ServHeader.Count);
            end;
        end;
    end;


    procedure FindTrackingRecords()
    var
        DocNoOfRecords: Integer;
    begin
        Window.Open(Text002);
        REC.DeleteAll;
        REC."Entry No." := 0;

        Clear(ItemTrackingNavigateMgt);
        ItemTrackingNavigateMgt.FindTrackingRecords(SerialNoFilter, LotNoFilter, '', '');

        ItemTrackingNavigateMgt.Collect(TempRecordBuffer);
        TempRecordBuffer.SetCurrentkey("Table No.", "Search Record ID");
        if TempRecordBuffer.Find('-') then
            repeat
                TempRecordBuffer.SetRange("Table No.", TempRecordBuffer."Table No.");

                DocNoOfRecords := 0;
                if TempRecordBuffer.Find('-') then
                    repeat
                        TempRecordBuffer.SetRange("Search Record ID", TempRecordBuffer."Search Record ID");
                        TempRecordBuffer.Find('+');
                        TempRecordBuffer.SetRange("Search Record ID");
                        DocNoOfRecords += 1;
                    until TempRecordBuffer.Next = 0;

                InsertIntoDocEntry(
                  TempRecordBuffer."Table No.", 0, TempRecordBuffer."Table Name", DocNoOfRecords);

                TempRecordBuffer.SetRange("Table No.");
            until TempRecordBuffer.Next = 0;

        DocExists := REC.Find('-');

        UpdateFormAfterFindRecords;
        Window.Close;
    end;


    procedure SetTracking(SerialNo: Code[20]; LotNo: Code[20])
    begin
        NewSerialNo := SerialNo;
        NewLotNo := LotNo;
    end;


    procedure ItemTrackingSearch(): Boolean
    begin
        exit((SerialNoFilter <> '') or (LotNoFilter <> ''));
    end;


    procedure ClearTrackingInfo()
    begin
        SerialNoFilter := '';
        LotNoFilter := '';
    end;


    procedure ClearInfo()
    begin
        SetDocNo('');
        SetPostingDate('');
        ContactType := Contacttype::" ";
        ContactNo := '';
        ExtDocNo := '';
    end;

    local procedure DocNoFilterOnAfterValidate()
    begin
        ClearSourceInfo;
    end;

    local procedure PostingDateFilterOnAfterValida()
    begin
        ClearSourceInfo;
    end;

    local procedure ExtDocNoOnAfterValidate()
    begin
        ClearSourceInfo;
    end;

    local procedure ContactTypeOnAfterValidate()
    begin
        ClearSourceInfo;
    end;

    local procedure ContactNoOnAfterValidate()
    begin
        ClearSourceInfo;
    end;

    local procedure SerialNoFilterOnAfterValidate()
    begin
        ClearSourceInfo;
    end;

    local procedure LotNoFilterOnAfterValidate()
    begin
        ClearSourceInfo;
    end;
}

