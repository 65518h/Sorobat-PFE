codeunit 50029 "Gen. Jnl.-Post Line_CDU12"
{
    //GL2024 Procédure spécifique et event de la codeunit standard "Gen. Jnl.-Post Line" 12


    Permissions = TableData "Analytical Distribution Setup" = r;


    procedure PrepareCheckForUnreaVat(TransactionNo: Integer; var TempVATEntry: Record "VAT Entry" temporary)
    var
        VATEntry: Record "VAT Entry";
    begin
        //NAVISION
        VATEntry.Reset;
        VATEntry.SetCurrentkey("Transaction No.");
        VATEntry.SetRange("Transaction No.", TransactionNo);
        TempVATEntry.DeleteAll;
        if VATEntry.Find('-') then
            repeat
                TempVATEntry := VATEntry;
                TempVATEntry.Insert;
            until VATEntry.Next = 0;
        //NAVISION//
    end;


    procedure CheckUnrealizeVAT(var VATEntry: Record "VAT Entry"; NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer")
    var
        VATPostingSetup: Record "VAT Posting Setup";
        NumberOfVATGroups: Integer;
        UnrealizeVATonAppEntry: Boolean;
        UnrealizeVATEntryToBeApp: Boolean;
    begin
        //NAVISION
        UnrealizeVATonAppEntry := false;
        UnrealizeVATEntryToBeApp := false;
        NumberOfVATGroups := 0;
        with VATEntry do begin
            Reset;
            SetCurrentkey(
              Type,
              Closed,
              "VAT Bus. Posting Group",
              "VAT Prod. Posting Group",
              "Tax Jurisdiction Code",
              "Use Tax",
              //BE_VAT
              "Document Type",
              //BE_VAT//
              "Posting Date");
            if Find('-') then
                repeat
                    SetRange("VAT Bus. Posting Group", "VAT Bus. Posting Group");
                    SetRange("VAT Prod. Posting Group", "VAT Prod. Posting Group");
                    VATPostingSetup.Get("VAT Bus. Posting Group", "VAT Prod. Posting Group");
                    if VATPostingSetup."Unrealized VAT Type" <> VATPostingSetup."unrealized vat type"::" " then begin
                        SetFilter("Transaction No.", '<>%1', NewCVLedgEntryBuf."Transaction No.");
                        if Find('-') then
                            UnrealizeVATEntryToBeApp := true;
                        SetRange("Transaction No.", NewCVLedgEntryBuf."Transaction No.");
                        if Find('-') then
                            UnrealizeVATonAppEntry := true;
                        SetRange("Transaction No.");
                        NumberOfVATGroups := NumberOfVATGroups + 1;
                        Find('+');
                    end;
                    SetRange("VAT Bus. Posting Group");
                    SetRange("VAT Prod. Posting Group");
                until Next = 0;

            if not UnrealizeVATonAppEntry and not UnrealizeVATEntryToBeApp then begin
                DeleteAll;
                exit;
            end;

            if UnrealizeVATonAppEntry and not UnrealizeVATEntryToBeApp then
                Error(Text019);

            if (UnrealizeVATonAppEntry and UnrealizeVATEntryToBeApp) and (NumberOfVATGroups > 1) then
                if Find('-') then
                    repeat
                        SetRange("VAT Bus. Posting Group", "VAT Bus. Posting Group");
                        SetRange("VAT Prod. Posting Group", "VAT Prod. Posting Group");
                        VATPostingSetup.Get("VAT Bus. Posting Group", "VAT Prod. Posting Group");
                        if VATPostingSetup."Unrealized VAT Type" <> VATPostingSetup."unrealized vat type"::" " then begin
                            CalcSums("Remaining Unrealized Amount");
                            if "Remaining Unrealized Amount" <> 0 then begin
                                case NewCVLedgEntryBuf."Document Type" of
                                    NewCVLedgEntryBuf."document type"::Invoice:
                                        Error(Text018);
                                    NewCVLedgEntryBuf."document type"::"Credit Memo":
                                        Error(Text017);
                                    else
                                        Error(
                                          Text016,
                                          FieldCaption("VAT Bus. Posting Group"),
                                         "VAT Bus. Posting Group",
                                          FieldCaption("VAT Prod. Posting Group"),
                                         "VAT Prod. Posting Group");
                                end;
                            end;
                        end;
                        DeleteAll;
                        SetRange("VAT Bus. Posting Group");
                        SetRange("VAT Prod. Posting Group");
                    until Next = 0;

            if not UnrealizeVATonAppEntry and UnrealizeVATEntryToBeApp and (NumberOfVATGroups > 1) then
                if Find('-') then
                    repeat
                        SetRange("VAT Bus. Posting Group", "VAT Bus. Posting Group");
                        SetRange("VAT Prod. Posting Group", "VAT Prod. Posting Group");
                        VATPostingSetup.Get("VAT Bus. Posting Group", "VAT Prod. Posting Group");
                        if VATPostingSetup."Unrealized VAT Type" <> VATPostingSetup."unrealized vat type"::" " then begin
                            if not NewCVLedgEntryBuf.Positive then
                                SetFilter("Unrealized Amount", '>%1', 0)
                            else
                                SetFilter("Unrealized Amount", '<%1', 0);
                            if Find('-') then
                                case NewCVLedgEntryBuf."Document Type" of
                                    NewCVLedgEntryBuf."document type"::Invoice:
                                        Error(Text018);
                                    NewCVLedgEntryBuf."document type"::"Credit Memo":
                                        Error(Text017)
                                    else
                                        Error(
                                          Text016,
                                          FieldCaption("VAT Bus. Posting Group"),
                                         "VAT Bus. Posting Group",
                                          FieldCaption("VAT Prod. Posting Group"),
                                         "VAT Prod. Posting Group");
                                end;
                        end;
                        DeleteAll;
                        SetRange("VAT Bus. Posting Group");
                        SetRange("VAT Prod. Posting Group");
                    until Next = 0;
            DeleteAll;
        end;
        //NAVISION//
    end;


    procedure wInitGLEntryWithJob(var pGenJnlLine: Record "Gen. Journal Line"; pAccNo: Code[20])
    var
        lGLAcc: Record "G/L Account";
    begin

        //PROJET
        wFromDetail := TRUE;
        //PROJET//
        //PROJET
        if not wFromDetail then
            exit;

        lGLAcc.Get(pAccNo);
        //#5429
        /*
        IF (lGLAcc."Job No." <> '') AND (pGenJnlLine."Job No." = '') AND
           (lGLAcc."Job Posting" IN [lGLAcc."Job Posting"::"Same Code",lGLAcc."Job Posting"::"Code Mandatory"]) THEN
          pGenJnlLine."Job No." := lGLAcc."Job No."
        ELSE
          IF (lGLAcc."Job No." <> '') AND (lGLAcc."Job Posting" = lGLAcc."Job Posting"::"Same Code") THEN
            pGenJnlLine."Job No." := lGLAcc."Job No.";
        
        IF lGLAcc."Gen. Prod. Posting Group" <> '' THEN
        */
        if (lGLAcc."Gen. Prod. Posting Group" <> '') and (pGenJnlLine."Gen. Prod. Posting Group" = '') then
            //#5429//
            pGenJnlLine."Gen. Prod. Posting Group" := lGLAcc."Gen. Prod. Posting Group";

        Clear(wFromDetail);
        //PROJET//

    end;




    procedure wGLEntry(var pGLEntry: Record "G/L Entry" temporary; pAccNo: Code[20])
    var
        lGLAcc: Record "G/L Account";
    begin
        //PROJET
        lGLAcc.Get(pAccNo);
        if lGLAcc."Gen. Prod. Posting Group" <> '' then
            pGLEntry."Gen. Prod. Posting Group" := lGLAcc."Gen. Prod. Posting Group";
        //PROJET//
    end;

    local procedure wCopyCheckDocDimToTempDocDim()
    var
        lDocDim: Record "Dim. Value per Account";
    begin
        //DYS table 356 doc dim supprimer
        /*
        //PROJET
        TempDocDim.Reset;
        TempDocDim.DeleteAll;
        lDocDim.Reset;
        lDocDim.SetRange("Table ID", Database::"Gen. Journal Line");
        lDocDim.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
        lDocDim.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
        if lDocDim.Find('-') then begin
            repeat
                TempDocDim.Init;
                TempDocDim := lDocDim;
                TempDocDim.Insert;
            until lDocDim.Next = 0;
        end;
        TempDocDim.Reset;
        */
        //PROJET//
    end;

    procedure wReverseJobLedgEntry()
    var
        lFromJobLedgEntry: Record "Job Ledger Entry";
        lGLAcc: Record "G/L Account";
        lJobLedgEntry: Record "Job Ledger Entry";
        lNextEntryNo: Integer;
    begin

        //REVERSE
        lFromJobLedgEntry.SETCURRENTKEY("Document No.", "Posting Date");
        lFromJobLedgEntry.SETRANGE("Document No.", GLEntry."Document No.");
        lFromJobLedgEntry.SETRANGE("Posting Date", GLEntry."Posting Date");
        lFromJobLedgEntry.SETRANGE("Ledger Entry Type", lFromJobLedgEntry."Ledger Entry Type"::"G/L Account");
        lFromJobLedgEntry.SETRANGE("Ledger Entry No.", wReverseGLEntryNo);
        IF NOT lFromJobLedgEntry.FIND('-') THEN
            EXIT;

        IF NOT lGLAcc.GET(lFromJobLedgEntry."No.") THEN
            EXIT;

        IF (CLOSINGDATE(GLEntry."Posting Date") <> GLEntry."Posting Date") THEN
            IF ((NOT wCheckline) AND (lGLAcc."Post Job Entry" = TRUE) AND
               ((lGLAcc."Job Posting" = lGLAcc."Job Posting"::"Code Mandatory") OR
               (lGLAcc."Job Posting" = lGLAcc."Job Posting"::"Same Code"))) THEN BEGIN
                lJobLedgEntry.LOCKTABLE;
                IF lJobLedgEntry.FIND('+') THEN
                    lNextEntryNo := lJobLedgEntry."Entry No.";
                lNextEntryNo := lNextEntryNo + 1;

                lJobLedgEntry := lFromJobLedgEntry;
                lJobLedgEntry.Quantity := -lFromJobLedgEntry.Quantity;
                lJobLedgEntry."Total Cost (LCY)" := -lFromJobLedgEntry."Total Cost (LCY)";
                lJobLedgEntry."Total Price (LCY)" := -lFromJobLedgEntry."Total Price (LCY)";
                lJobLedgEntry."Line Amount (LCY)" := -lFromJobLedgEntry."Line Amount (LCY)";
                lJobLedgEntry."Total Cost" := -lFromJobLedgEntry."Total Cost";
                lJobLedgEntry."Total Price" := -lFromJobLedgEntry."Total Price";
                lJobLedgEntry."Line Amount" := -lFromJobLedgEntry."Line Amount";
                lJobLedgEntry."Line Discount Amount" := -lFromJobLedgEntry."Line Discount Amount";
                lJobLedgEntry."Line Discount Amount (LCY)" := -lFromJobLedgEntry."Line Discount Amount (LCY)";
                lJobLedgEntry."Original Total Cost (LCY)" := -lFromJobLedgEntry."Original Total Cost (LCY)";
                lJobLedgEntry."Original Total Cost" := -lFromJobLedgEntry."Original Total Cost";
                lJobLedgEntry."Original Total Cost (ACY)" := -lFromJobLedgEntry."Original Total Cost (ACY)";
                lJobLedgEntry."Add.-Currency Line Amount" := -lFromJobLedgEntry."Add.-Currency Line Amount";
                lJobLedgEntry."Quantity (Base)" := -lFromJobLedgEntry."Quantity (Base)";
                //#6304
                //  lJobLedgEntry."Overhead Amount" := -lFromJobLedgEntry."Overhead Amount";
                //#6304//
                lJobLedgEntry."Ledger Entry No." := GLEntry."Entry No.";
                lJobLedgEntry."Journal Batch Name" := GLEntry."Journal Batch Name";
                lJobLedgEntry."Source Code" := GLEntry."Source Code";
                lJobLedgEntry."User ID" := USERID;
                lJobLedgEntry."Entry No." := lNextEntryNo;
                lJobLedgEntry.INSERT;
                //  DimMgt.CopyLedgEntryDimToLedgEntryDim(
                //  DATABASE::"Job Ledger Entry", lFromJobLedgEntry."Entry No.", DATABASE::"Job Ledger Entry", lNextEntryNo);
            END;
        //REVERSE//
    end;


    procedure wReverseJobLedgEntry2(var TempRevertTransactionNo: record Integer)
    var
        lFromJobLedgEntry: Record "Job Ledger Entry";
        lLedgEntryDim: Record "Dimension Set ID Filter Line";
        lGLAcc: Record "G/L Account";
        lJobLedgEntry: Record "Job Ledger Entry";
        lNextEntryNo: Integer;


    begin
        //GL2024
        GLEntry.Reset();
        GLEntry.SETRANGE("Transaction No.", TempRevertTransactionNo.Number);
        if GLEntry.FindFirst() then begin

            //REVERSE
            CLEAR(wReverseGLEntryNo);
            wReverseGLEntryNo := GLEntry."Entry No.";
            //REVERSE//  

            //GL2024

            //REVERSE
            lFromJobLedgEntry.SetCurrentkey("Document No.", "Posting Date");
            lFromJobLedgEntry.SetRange("Document No.", GLEntry."Document No.");
            lFromJobLedgEntry.SetRange("Posting Date", GLEntry."Posting Date");
            lFromJobLedgEntry.SetRange("Ledger Entry Type", lFromJobLedgEntry."ledger entry type"::"G/L Account");
            lFromJobLedgEntry.SetRange("Ledger Entry No.", wReverseGLEntryNo);
            if not lFromJobLedgEntry.Find('-') then
                exit;
        end;
        if not lGLAcc.Get(lFromJobLedgEntry."No.") then
            exit;

        if (ClosingDate(GLEntry."Posting Date") <> GLEntry."Posting Date") then
            if ((not wCheckline) and (lGLAcc."Post Job Entry" = true) and
               ((lGLAcc."Job Posting" = lGLAcc."job posting"::"Code Mandatory") or
               (lGLAcc."Job Posting" = lGLAcc."job posting"::"Same Code"))) then begin
                lJobLedgEntry.LockTable;
                if lJobLedgEntry.Find('+') then
                    lNextEntryNo := lJobLedgEntry."Entry No.";
                lNextEntryNo := lNextEntryNo + 1;

                lJobLedgEntry := lFromJobLedgEntry;
                lJobLedgEntry.Quantity := -lFromJobLedgEntry.Quantity;
                lJobLedgEntry."Total Cost (LCY)" := -lFromJobLedgEntry."Total Cost (LCY)";
                lJobLedgEntry."Total Price (LCY)" := -lFromJobLedgEntry."Total Price (LCY)";
                lJobLedgEntry."Line Amount (LCY)" := -lFromJobLedgEntry."Line Amount (LCY)";
                lJobLedgEntry."Total Cost" := -lFromJobLedgEntry."Total Cost";
                lJobLedgEntry."Total Price" := -lFromJobLedgEntry."Total Price";
                lJobLedgEntry."Line Amount" := -lFromJobLedgEntry."Line Amount";
                lJobLedgEntry."Line Discount Amount" := -lFromJobLedgEntry."Line Discount Amount";
                lJobLedgEntry."Line Discount Amount (LCY)" := -lFromJobLedgEntry."Line Discount Amount (LCY)";
                lJobLedgEntry."Original Total Cost (LCY)" := -lFromJobLedgEntry."Original Total Cost (LCY)";
                lJobLedgEntry."Original Total Cost" := -lFromJobLedgEntry."Original Total Cost";
                lJobLedgEntry."Original Total Cost (ACY)" := -lFromJobLedgEntry."Original Total Cost (ACY)";
                lJobLedgEntry."Add.-Currency Line Amount" := -lFromJobLedgEntry."Add.-Currency Line Amount";
                lJobLedgEntry."Quantity (Base)" := -lFromJobLedgEntry."Quantity (Base)";
                //#6304
                lJobLedgEntry."Overhead Amount" := -lFromJobLedgEntry."Overhead Amount";
                //#6304//
                lJobLedgEntry."Ledger Entry No." := GLEntry."Entry No.";
                lJobLedgEntry."Journal Batch Name" := GLEntry."Journal Batch Name";
                lJobLedgEntry."Source Code" := GLEntry."Source Code";
                lJobLedgEntry."User ID" := UserId;
                lJobLedgEntry."Entry No." := lNextEntryNo;
                lJobLedgEntry.Insert;
                //DYS focntion CopyLedgEntryDimToLedgEntryDim supprimer
                //    DimMgt.CopyLedgEntryDimToLedgEntryDim(
                //    Database::"Job Ledger Entry", lFromJobLedgEntry."Entry No.", Database::"Job Ledger Entry", lNextEntryNo);
            end;
        //REVERSE//
    end;



    /* procedure LettrageAutomatique(ParaCdeNumDoc: Code[20]; ParaTxtPaymentClass: Text[30]; ParaStatut: Integer)
     var
         RecPaymentLine: Record "Payment Line";
         RecPaymentStatus: Record "Payment Status";
         RecGeneralLedgerSetup: Record "General Ledger Setup";
         RecGLEntry: Record "G/L Entry";
         RecLGLEntry: Record "G/L Entry";
         GLEntryTmp: Record "G/L Entry";
         RecGlAccount: Record "G/L Account";
         GLEntriesApplication: Codeunit "G/L Entry Application2";
         TxtLetter: Text[4];
         CdeTiers: Code[20];
         IntSequenceDebit: Integer;
         IntSequenceCredit: Integer;
         BlnSens: Code[1];
     begin
         //>> HJ SORO 10-08-2015  RAPPROCHEMENT COMPTABLE AUTOMATIQUE
         if RecGeneralLedgerSetup.Get then;
         if not RecGeneralLedgerSetup."Activer Rapproch. Auto" then exit;
         RecPaymentLine.SetRange("No.", ParaCdeNumDoc);
         if RecPaymentLine.FindFirst then
             repeat
                 RecPaymentStatus.SetRange("Payment Class", ParaTxtPaymentClass);
                 RecPaymentStatus.SetRange(Rapprocher, true);
                 RecPaymentStatus.SetRange(Line, ParaStatut);
                 if RecPaymentStatus.FindFirst then begin
                     TxtLetter := GLEntriesApplication.GetLetter2(RecPaymentStatus."Compte Rapprochement");
                     CdeTiers := RecPaymentLine."Account No.";
                     RecLGLEntry.Reset;
                     RecLGLEntry.SetCurrentkey(Letter, "Source No.", "External Document No.", "Posting Date", Amount, "G/L Account No.");
                     RecLGLEntry.SetRange(Letter, '');
                     RecLGLEntry.SetRange("Source No.", CdeTiers);
                     RecLGLEntry.SetRange("External Document No.", RecPaymentLine."External Document No.");
                     RecLGLEntry.SetFilter("Posting Date", '>=%1', RecGeneralLedgerSetup."Date Debut Lettarge Auto");
                     RecLGLEntry.SetFilter(Amount, '%1|%2', Abs(RecPaymentLine.Amount), -Abs(RecPaymentLine.Amount));
                     RecLGLEntry.SetRange("G/L Account No.", RecPaymentStatus."Compte Rapprochement");
                     RecLGLEntry.ModifyAll(Letter, TxtLetter);

                 end;
             until RecPaymentLine.Next = 0;
         //>> HJ SORO 10-08-2015  RAPPROCHEMENT COMPTABLE AUTOMATIQUE
     end;*/


    /*  procedure UpdateAffectationFinancier(var ParmNumSequence: Integer; var ParmAffectationFinancier: Code[60])
      var
          RecBankAccountLedgerEntry: Record "Bank Account Ledger Entry";
      begin
          if RecBankAccountLedgerEntry.Get(ParmNumSequence) then begin
              RecBankAccountLedgerEntry."Affectation Financiere" := ParmAffectationFinancier;
              RecBankAccountLedgerEntry.Modify;
          end;
      end;*/


    //*************************************Codeunit 12************************************************//
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeCode', '', true, true)]
    local procedure OnBeforeCode(var GenJnlLine: Record "Gen. Journal Line"; CheckLine: Boolean; var IsPosted: Boolean; var GLReg: Record "G/L Register"; var GLEntryNo: Integer)
    begin
        //PROJET
        wCheckline := CheckLine;
        //PROJET//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterFindJobLineSign', '', true, true)]
    local procedure OnAfterFindJobLineSign(var GenJnlLine: Record "Gen. Journal Line"; var IsJobLine: Boolean)
    var
        lGLAcc: Record "G/L Account";
    begin

        //#7612
        IF lGLAcc.GET(GenJnlLine."Account No.") THEN
            IsJobLine := (GenJnlLine."Job No." <> '') AND (lGLAcc."Post Job Entry");
        //#7612
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostGLAccOnBeforeInsertGLEntry', '', true, true)]
    local procedure OnPostGLAccOnBeforeInsertGLEntry(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var IsHandled: Boolean; Balancing: Boolean)
    begin
        //#8874
        //+ABO+
        IF GenJournalLine."Subscription Entry No." <> 0 THEN
            IsHandled := true;
        //+ABO+//
        //#8874//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostVAT', '', true, true)]
    local procedure OnBeforePostVAT(GenJnlLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; VATPostingSetup: Record "VAT Posting Setup"; var IsHandled: Boolean; var AddCurrGLEntryVATAmt: Decimal; var NextConnectionNo: Integer)
    begin
        //#8874
        //+ABO+
        IF GenJnlLine."Subscription Entry No." <> 0 THEN
            IsHandled := true;
        //+ABO+//
        //#8874//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostCustOnAfterInitCustLedgEntry', '', true, true)]
    local procedure OnPostCustOnAfterInitCustLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; var CustLedgEntry: Record "Cust. Ledger Entry"; Cust: Record Customer; CustPostingGr: Record "Customer Posting Group")
    var

        wNavibatSetup: Record NavibatSetup;

        ErrControlJob: label 'Job No. is obligatory on Customer Entries.';
        ErrControlJobFC: label 'Job No. is obligatory on Invoices and Cr.Memo.';

        gAddOnLicencePermission: Codeunit IntegrManagement;
    begin
        IF gAddOnLicencePermission.HasPermissionRAP() THEN
            CustLedgEntry.VALIDATE("Due Date", GenJournalLine."Due Date")
        ELSE
            //+RAP+TRESO//
           CustLedgEntry."Due Date" := GenJournalLine."Due Date";
        //PROJET
        CustLedgEntry."Job No." := GenJournalLine."Job No.";
        //PROJET//
        //#6849
        CustLedgEntry."Sales Order No." := GenJournalLine."Apply-to Sales Order No.";
        //#6849//


        //PROJET
        CustLedgEntry."Job No." := GenJournalLine."Job No.";
        IF GenJournalLine."Job No." = '' THEN BEGIN
            IF wNavibatSetup.GET THEN;
            CASE wNavibatSetup."Job Control Obligatory" OF
                wNavibatSetup."Job Control Obligatory"::"Invoice and Cr.Memo":
                    IF CustLedgEntry."Document Type" IN [CustLedgEntry."Document Type"::Invoice, CustLedgEntry."Document Type"::"Credit Memo"]
              THEN
                        ERROR(ErrControlJobFC);
                wNavibatSetup."Job Control Obligatory"::All:
                    ERROR(ErrControlJob);
                ELSE
                    ;
            END;
        END;
        //PROJET//
        //RETENTION
        CustLedgEntry."Retention Code" := GenJournalLine."Retention Code";
        //#3380
        IF EVALUATE(CustLedgEntry."Retention %", CustLedgEntry."On Hold") THEN
            CustLedgEntry."On Hold" := GenJournalLine."Retention Code";
        //#3380//
        //RETENTION//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostCustOnBeforeInsertDtldCVLedgEntry', '', true, true)]
    local procedure OnPostCustOnBeforeInsertDtldCVLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; var TempDetailedCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; var CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; var CustLedgerEntry: Record "Cust. Ledger Entry"; var IsHandled: Boolean)
    var
        gAddOnLicencePermission: Codeunit IntegrManagement;
    begin
        //+RAP+TRESO
        IF gAddOnLicencePermission.HasPermissionRAP() THEN
            TempDetailedCVLedgEntryBuffer."Value Date" := CustLedgerEntry."Value Date";
        //+RAP+TRESO//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Check Line", 'OnCheckSalesDocNoIsNotUsedOnAfterSetFilters', '', true, true)]
    local procedure OnCheckSalesDocNoIsNotUsedOnAfterSetFilters(GenJournalLine: Record "Gen. Journal Line"; var OldCustLedgerEntry: Record "Cust. Ledger Entry")
    var
        gAddOnLicencePermission: Codeunit IntegrManagement;
    begin
        //+PMT+MULTI
        IF gAddOnLicencePermission.HasPermissionPMT THEN
            OldCustLedgerEntry.SETFILTER("Customer No.", '<>%1', GenJournalLine."Source No.");
        //+PMT+MULTI//

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostVendOnAfterInitVendLedgEntry', '', true, true)]
    local procedure OnPostVendOnAfterInitVendLedgEntry(var GenJnlLine: Record "Gen. Journal Line"; var VendLedgEntry: Record "Vendor Ledger Entry"; Vendor: Record Vendor)
    var
        DtaSetup: Record "DTA Setup";
        DtaMgt: Codeunit DtaMgt;
        gAddOnLicencePermission: Codeunit IntegrManagement;

    begin
        //+RAP+TRESO
        IF gAddOnLicencePermission.HasPermissionRAP() THEN
            VendLedgEntry.VALIDATE("Due Date", GenJnlLine."Due Date")
        ELSE
            //+RAP+TRESO//
           VendLedgEntry."Due Date" := GenJnlLine."Due Date";


        // RB SORO 22/03/2016 FACTURE SIMULATION
        // VendLedgEntry.Simulation := GenJnlLine.Simulation;
        // RB SORO 22/03/2016 FACTURE SIMULATION



        //PROJET
        VendLedgEntry."Job No." := GenJnlLine."Job No.";
        //PROJET//
        //PMT_DIRECT
        VendLedgEntry."Apply-to Sales Order No." := GenJnlLine."Apply-to Sales Order No.";
        //PMT_DIRECT//
        // CH2300.begin
        IF DtaSetup.READPERMISSION THEN
            DtaMgt.CheckVenorPost(GenJnlLine);
        VendLedgEntry."Reference No." := GenJnlLine."Reference No." + ' ' + GenJnlLine.Checksum;
        VendLedgEntry."Bank Code" := GenJnlLine."Payment Bank Account";
        // CH2300.end
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostVendAfterTempDtldCVLedgEntryBufInit', '', true, true)]
    local procedure OnPostVendAfterTempDtldCVLedgEntryBufInit(var GenJnlLine: Record "Gen. Journal Line"; var TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer" temporary)
    var
        gAddOnLicencePermission: Codeunit IntegrManagement;

        VendLedgEntry: Record "Vendor Ledger Entry";

    begin
        //GL2024
        if VendLedgEntry.get(GenJnlLine."Entry No.") then
            //GL2024
            //+RAP+TRESO
            IF gAddOnLicencePermission.HasPermissionRAP() THEN
                TempDtldCVLedgEntryBuf."Value Date" := VendLedgEntry."Value Date";
        //+RAP+TRESO//

        //--INSERT N° DOSSIER
        TempDtldCVLedgEntryBuf."N° Dossier" := GenJnlLine."N° Dossier";
        //--INSERT N° DOSSIER
    end;

    /* [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitBankAccLedgEntry', '', true, true)]
     local procedure OnAfterInitBankAccLedgEntry(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
     begin
         // >> HJ SORO 17-02-2015
         BankAccountLedgerEntry."N° Folio" := GenJournalLine."N° Bordereau";
         BankAccountLedgerEntry."Affectation Financiere" := GenJournalLine."Affectation Financiere";
         // >> HJ SORO 17-02-2015
     end;*/

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostBankAccOnBeforeBankAccLedgEntryInsert', '', true, true)]
    local procedure OnPostBankAccOnBeforeBankAccLedgEntryInsert(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; BankAccount: Record "Bank Account"; var TempGLEntryBuf: Record "G/L Entry" temporary; var NextTransactionNo: Integer; GLRegister: Record "G/L Register")
    VAR
        // lCountCheck: Integer;
        lGenJnlPaymentIntegr: Codeunit "Gen. Jnl-Post Payment Integr.";
        gAddOnLicencePermission: Codeunit IntegrManagement;
    begin
        //+RAP+TRESO
        IF gAddOnLicencePermission.HasPermissionRAP() THEN
            BankAccountLedgerEntry."Due Date" := GenJournalLine."Due Date";
        //+RAP+TRESO//
        //+PMT+PAYMENT
        IF gAddOnLicencePermission.HasPermissionPMT THEN
            lGenJnlPaymentIntegr.SetBankAccLedgEntry(BankAccountLedgerEntry, GenJournalLine);
        //+PMT+PAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostBankAccOnBeforeCheckLedgEntry2Modify', '', true, true)]
    local procedure OnPostBankAccOnBeforeCheckLedgEntry2Modify(var CheckLedgEntry: Record "Check Ledger Entry"; var BankAccLedgEntry: Record "Bank Account Ledger Entry"; var CheckLedgerEntry2: Record "Check Ledger Entry")
    var
        gAddOnLicencePermission: Codeunit IntegrManagement;
        lGenJnlPaymentIntegr: Codeunit "Gen. Jnl-Post Payment Integr.";
        lCountCheck: Integer;
        GenJnlLine: Record "Gen. Journal Line";
    begin



        //+PMT+PAYMENT
        IF gAddOnLicencePermission.HasPermissionPMT THEN
            lCountCheck := lGenJnlPaymentIntegr.GetCountCheck(CheckLedgEntry, GenJnlLine);
        //+PMT+PAYMENT//
        //+PMT+PAYMENT
        IF gAddOnLicencePermission.HasPermissionPMT THEN
            lGenJnlPaymentIntegr.SetCheckType(CheckLedgerEntry2, lCountCheck);
        //+PMT+PAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostBankAccOnBeforeCheckLedgEntryInsert', '', true, true)]
    local procedure OnPostBankAccOnBeforeCheckLedgEntryInsert(var CheckLedgerEntry: Record "Check Ledger Entry"; var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; BankAccount: Record "Bank Account")
    var
        gAddOnLicencePermission: Codeunit IntegrManagement;
        lGenJnlPaymentIntegr: Codeunit "Gen. Jnl-Post Payment Integr.";
    begin
        //+PMT+PAYMENT
        IF gAddOnLicencePermission.HasPermissionPMT THEN
            lGenJnlPaymentIntegr.SetManualCheck(CheckLedgerEntry, GenJournalLine);
        //+PMT+PAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostFixedAssetOnAfterSaveGenJnlLineValues', '', true, true)]
    local procedure OnPostFixedAssetOnAfterSaveGenJnlLineValues(var GenJournalLine: Record "Gen. Journal Line")

    var
        lGenJnlTemplate: Record "Gen. Journal Template";
    begin
        //PROJET_IMMO (#5444)
        lGenJnlTemplate.SETRANGE(Type, lGenJnlTemplate.Type::Assets);
        lGenJnlTemplate.FINDFIRST;
        //PROJET_IMMO/
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeFinishPosting', '', true, true)]
    local procedure OnBeforeFinishPosting(var GenJournalLine: Record "Gen. Journal Line"; var TempGLEntryBuf: Record "G/L Entry" temporary)
    VAR

        lAnaDistribIntegr: Codeunit "Analytical Distrib.Integr.";
        gAddOnLicencePermission: Codeunit IntegrManagement;
    begin
        //+REP+
        IF gAddOnLicencePermission.HasPermissionREP THEN
            lAnalytical := lAnaDistribIntegr.GetDistribEntriesBufFromGen(GenJournalLine);
        //+REP+//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertGlobalGLEntry', '', true, true)]
    local procedure OnBeforeInsertGlobalGLEntry(var GlobalGLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line"; GLRegister: Record "G/L Register")
    begin
        //+REP+
        GLEntry."Analytical Distribution" := lAnalytical;
        //+REP+//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnInitGLEntryOnBeforeCheckGLAccountBlocked', '', true, true)]
    local procedure OnInitGLEntryOnBeforeCheckGLAccountBlocked(GenJournalLine: Record "Gen. Journal Line"; GLAccount: Record "G/L Account"; var IsHandled: Boolean)
    begin
        //PROJET
        wInitGLEntryWithJob(GenJournalLine, GLAccount."No.");
        //PROJET//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnInitGLEntryOnBeforeCheckGLAccDimError', '', true, true)]
    local procedure OnInitGLEntryOnBeforeCheckGLAccDimError(var GenJnlLine: Record "Gen. Journal Line"; var GLAcc: Record "G/L Account")
    var
        lBARIntegr: Codeunit "BAR Integration";
    begin
        //PROJET
        IF CLOSINGDATE(GenJnlLine."Posting Date") <> GenJnlLine."Posting Date" THEN BEGIN
            CASE GLAcc."Job Posting" OF
                GLAcc."Job Posting"::"Code Mandatory":
                    IF GenJnlLine."Job No." = '' THEN
                        ERROR(
                          wText020,
                          GLAcc.FIELDCAPTION(GLAcc."Job No."),
                          GenJnlLine.TABLECAPTION,
                          GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name",
                          GenJnlLine."Line No.",
                          GLAcc.FIELDCAPTION(GLAcc."Job No."),
                          GLAcc.TABLECAPTION, GLAcc."No.");
                GLAcc."Job Posting"::"Same Code":
                    IF GLAcc."Job No." <> GenJnlLine."Job No." THEN
                        ERROR(
                          wText021,
                          GLAcc.FIELDCAPTION(GLAcc."Job No."),
                          GenJnlLine.TABLECAPTION, GenJnlLine."Journal Template Name",
                          GenJnlLine."Journal Batch Name", GenJnlLine."Line No.",
                          GLAcc.FIELDCAPTION(GLAcc."Job No."),
                          GLAcc."Job No.",
                          GLAcc.TABLECAPTION, GLAcc."No.");
                GLAcc."Job Posting"::"No Code":
                    IF GenJnlLine."Job No." <> '' THEN
                        ERROR(
                          wText022,
                          GLAcc.FIELDCAPTION(GLAcc."Job No."),
                          GenJnlLine.TABLECAPTION, GenJnlLine."Journal Template Name",
                          GenJnlLine."Journal Batch Name", GenJnlLine."Line No.",
                          GLAcc.FIELDCAPTION(GLAcc."Job No."),
                          GLAcc."Job No.",
                          GLAcc.TABLECAPTION, GLAcc."No.");
            END;
        END;
        //PROJET//
        //+RAP+RAPPRO  : contr“le code motif
        //#8882
        IF NOT GenJnlLine."System-Created Entry" THEN
            //#8882//
            IF gAddOnLicencePermission.HasPermissionRAP() THEN
                lBARIntegr.CheckReasonCode(GenJnlLine, GLAcc);
        //+RAP+RAPPRO//
        //+ABO+
        //DYS
        //IF gAddOnLicencePermission.HasPermissionABO THEN
        //  gGenJnlSubscriptionIntegr.ControlDateSubscription(GenJnlLine, GLAcc);
        //+ABO+//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', true, true)]
    local procedure OnAfterInitGLEntry(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line"; Amount: Decimal; AddCurrAmount: Decimal; UseAddCurrAmount: Boolean; var CurrencyFactor: Decimal; var GLRegister: Record "G/L Register")
    begin
        // >> HJ SORO 09-09-2014
        /* GLEntry."Date Echeance" := GenJournalLine."Date Echeance";
         GLEntry.Lettre := GenJournalLine.Lettre;
         GLEntry.salarie := GenJournalLine.Salarie;
         IF GenJournalLine."N° Bordereau" <> '' THEN
             GFolio := GenJournalLine."N° Bordereau"
         ELSE
             IF GFolio = '' THEN GFolio := GenJournalLine."Document No.";*/

        //  GLEntry."Folio N°" := GFolio;

        // GLEntry."Folio N°" := GFolio;

        //GLEntry.salarie:=GenJnlLine.Salarie;
        // >> HJ SORO 09-09-2014

        // RB SORO 27/04/2015
        // GLEntry."Folio N° RS" := GenJournalLine."Folio N° RS";
        // RB SORO 27/04/2015

        //PROJET
        GLEntry."Gen. Prod. Posting Group" := GenJournalLine."Gen. Prod. Posting Group";
        //PROJET//

        //+ABO+
        //DYS
        //   IF gAddOnLicencePermission.HasPermissionABO THEN
        //     gGenJnlSubscriptionIntegr.SetGLEntrySubscription(GLEntry, GenJournalLine);
        //+ABO+//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnInsertGLEntryOnBeforeUpdateCheckAmounts', '', true, true)]
    local procedure OnInsertGLEntryOnBeforeUpdateCheckAmounts(GeneralLedgerSetup: Record "General Ledger Setup"; var GLEntry: Record "G/L Entry"; var BalanceCheckAmount: Decimal; var BalanceCheckAmount2: Decimal; var BalanceCheckAddCurrAmount: Decimal; var BalanceCheckAddCurrAmount2: Decimal);
    VAR
        lGenJnlPaymentIntegr: Codeunit "Gen. Jnl-Post Payment Integr.";
        gAddOnLicencePermission: Codeunit IntegrManagement;
        TempGLEntryVAT: Record "G/L Entry" temporary;

    begin
        //+PMT+PAYMENT
        IF gAddOnLicencePermission.HasPermissionPMT THEN
            lGenJnlPaymentIntegr.SetGLEntry(GLEntry, TempGLEntryVAT);
        //+PMT+PAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeApplyCustLedgEntry', '', true, true)]
    local procedure OnBeforeApplyCustLedgEntry(var NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; var GenJnlLine: Record "Gen. Journal Line"; Cust: Record Customer; var IsAmountToApplyCheckHandled: Boolean; var IsHandled: Boolean)
    var
        TempVATEntry: Record "VAT Entry" temporary;
        GLSetup: Record "General Ledger Setup";
    begin
        //NAVISION
        GLSetup.GET;
        TempVATEntry.DELETEALL;
        IF GLSetup."Unrealized VAT" THEN
            PrepareCheckForUnreaVat(NewCVLedgEntryBuf."Transaction No.", TempVATEntry);
        //NAVISION//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnApplyCustLedgEntryOnBeforePrepareTempCustLedgEntry', '', true, true)]
    local procedure OnApplyCustLedgEntryOnBeforePrepareTempCustLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; var NewCVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; var DetailedCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; var NextEntryNo: Integer)
    var
        lGenJnlPaymentIntegr: Codeunit "Gen. Jnl-Post Payment Integr.";
    begin
        //+PMT+PAYMENT
        IF gAddOnLicencePermission.HasPermissionPMT THEN
            lGenJnlPaymentIntegr.SetDueDateGenJnlLine(GenJournalLine, NewCVLedgerEntryBuffer);
        //+PMT+PAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePrepareTempCustledgEntry', '', true, true)]
    local procedure OnBeforePrepareTempCustledgEntry(var GenJnlLine: Record "Gen. Journal Line"; var CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; Customer: Record Customer; var ApplyingDate: Date; var Result: Boolean; var IsHandled: Boolean; var TempOldCustLedgEntry: Record "Cust. Ledger Entry" temporary)
    var
        ErrJob: label 'You can''t apply between differents jobs';
        wNavibatSetup: Record NavibatSetup;

    begin
        //PROJET
        IF (CVLedgerEntryBuffer."Job No." <> TempOldCustLedgEntry."Job No.") AND
           (wNavibatSetup."Appln. between Job" = wNavibatSetup."Appln. between Job"::"Same Job") THEN
            ERROR(ErrJob);


    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnApplyCustLedgEntryOnBeforeCopyFromCustLedgEntry', '', true, true)]
    local procedure OnApplyCustLedgEntryOnBeforeCopyFromCustLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; var OldCVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; var TempOldCustLedgEntry: Record "Cust. Ledger Entry"; var NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer")
    var
        ErrJob: label 'You can''t apply between differents jobs';
        wNavibatSetup: Record NavibatSetup;
    begin
        //PROJET
        IF (OldCVLedgerEntryBuffer."Job No." <> TempOldCustLedgEntry."Job No.") AND
           (wNavibatSetup."Appln. between Job" = wNavibatSetup."Appln. between Job"::"Same Job") THEN
            ERROR(ErrJob);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeFindNextOldCustLedgEntryToApply', '', true, true)]
    local procedure OnBeforeFindNextOldCustLedgEntryToApply(var GenJournalLine: Record "Gen. Journal Line"; var TempOldCustLedgerEntry: Record "Cust. Ledger Entry" temporary; var NewCVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; var Completed: Boolean; var IsHandled: Boolean)
    var
        gAddOnLicencePermission: Codeunit IntegrManagement;
    begin
        //+PMT+PAYMENT
        //  if GenJournalLine."Applies-to Doc. No." <> '' then      
        IF (GenJournalLine."Applies-to Doc. No." <> '') AND NOT gAddOnLicencePermission.HasPermissionPMT THEN
            //+PMT+PAYMENT//
            begin
            Completed := true;

            IsHandled := true;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnInsertVATOnAfterAssignVATEntryFields', '', true, true)]
    local procedure OnInsertVATOnAfterAssignVATEntryFields(GenJnlLine: Record "Gen. Journal Line"; var VATEntry: Record "VAT Entry"; CurrExchRate: Record "Currency Exchange Rate")
    var
        lGenJnlPaymentIntegr: Codeunit "Gen. Jnl-Post Payment Integr.";
        gAddOnLicencePermission: Codeunit IntegrManagement;
    begin

        //+PMT+PAYMENT
        IF gAddOnLicencePermission.HasPermissionPMT THEN
            lGenJnlPaymentIntegr.SetVATEntry(VATEntry, GenJnlLine, TRUE);
        //+PMT+PAYMENT//
    end;

    [EventSubscriber(ObjectType::table, Database::"Detailed CV Ledg. Entry Buffer", 'OnBeforeInsertDtldCVLedgEntry', '', true, true)]
    local procedure OnBeforeInsertDtldCVLedgEntry(var DetailedCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; GenJournalLine: Record "Gen. Journal Line"; var IsHanled: Boolean; var CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer")
    begin
        //Insert Dossier Importation
        DetailedCVLedgEntryBuffer."N° Dossier" := GenJournalLine."N° Dossier";
        //Insert Dossier Importation

        //+RAP+TRESO
        IF gAddOnLicencePermission.HasPermissionRAP() THEN
            DetailedCVLedgEntryBuffer."Value Date" := CVLedgerEntryBuffer."Value Date";
        //+RAP+TRESO//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnCustUnrealizedVATOnAfterCalcPaidAmount', '', true, true)]
    local procedure OnCustUnrealizedVATOnAfterCalcPaidAmount(GenJnlLine: Record "Gen. Journal Line"; var CustLedgEntry2: Record "Cust. Ledger Entry"; SettledAmount: Decimal; var PaidAmount: Decimal)
    var
        gAddOnLicencePermission: Codeunit IntegrManagement;
        gGenJnlPaymentIntegr: Codeunit "Gen. Jnl-Post Payment Integr.";

    begin
        //+PMT+MULTI     //Retrouver le montant total du document
        IF gAddOnLicencePermission.HasPermissionPMT THEN BEGIN
            gGenJnlPaymentIntegr.GetAmtLCY(CustLedgEntry2, CustLedgEntry2."Original Amt. (LCY)",
                                              CustLedgEntry2."Amount (LCY)", CustLedgEntry2."Remaining Amt. (LCY)");
            PaidAmount := CustLedgEntry2."Amount (LCY)" - CustLedgEntry2."Remaining Amt. (LCY)";
            IF PaidAmount = 0 THEN
                PaidAmount := (SettledAmount / CustLedgEntry2.GetOriginalCurrencyFactor);
        END;
        //  ELSE
        //     //+PMT+MULTI//
        //     PaidAmount := CustLedgEntry2."Amount (LCY)" - CustLedgEntry2."Remaining Amt. (LCY)";

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertPostUnrealVATEntry', '', true, true)]
    local procedure OnBeforeInsertPostUnrealVATEntry(var VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line"; var VATEntry2: Record "VAT Entry")
    var
        gAddOnLicencePermission: Codeunit IntegrManagement;
    begin
        //+PMT+PAYMENT
        IF gAddOnLicencePermission.HasPermissionPMT THEN
            //#9356
            //        gGenJnlPaymentIntegr.SetVATEntry(VATEntry,GenJnlLine,FAlse);
            IF (GenJournalLine."Due Date" > GenJournalLine."Posting Date") AND
                 ((GenJournalLine."Document Type" = GenJournalLine."Document Type"::Payment) OR
                  (GenJournalLine."Journal Template Name" = '')) THEN
                VATEntry."Posting Date" := GenJournalLine."Due Date";
        //#9356//
        //+PMT+PAYMENT//

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostDtldCVLedgEntry', '', true, true)]

    local procedure OnBeforePostDtldCVLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; var DetailedCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; var AccNo: Code[20]; var Unapply: Boolean; var AdjAmount: array[4] of Decimal; var IsHandled: Boolean; AddCurrencyCode: Code[10]; MultiplePostingGroups: Boolean)
    var
        gAddOnLicencePermission: Codeunit IntegrManagement;
        lGenJnlPaymentIntegr: Codeunit "Gen. Jnl-Post Payment Integr.";
    begin
        //  Message('Type : %1  -  Transaction No. : %2', Format(DetailedCVLedgEntryBuffer."Entry Type"), Format(DetailedCVLedgEntryBuffer."Transaction No."));
        // MultiplePostingGroups := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldCustLedgEntry', '', true, true)]
    local procedure OnBeforeInsertDtldCustLedgEntry(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; GLRegister: Record "G/L Register")
    var
        gAddOnLicencePermission: Codeunit IntegrManagement;
        lGenJnlPaymentIntegr: Codeunit "Gen. Jnl-Post Payment Integr.";
    begin
        //  Message('Type : %1  -  Transaction No. : %2', Format(DtldCustLedgEntry."Entry Type"), Format(DtldCustLedgEntry."Transaction No."));
        DtldCVLedgEntryBuffer."Transaction No." := DtldCustLedgEntry."Transaction No.";

        //+PMT+SELL-TO
        IF gAddOnLicencePermission.HasPermissionPMT THEN
            lGenJnlPaymentIntegr.SetDtldCustLedgEntry(DtldCustLedgEntry, GenJournalLine);
        //+PMT+SELL-TO//

        DtldCustLedgEntry."Transaction No. Soroubat" := DtldCustLedgEntry."Transaction No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostDtldCustLedgEntriesOnBeforePostDtldCustLedgEntry', '', true, true)]
    local procedure OnPostDtldCustLedgEntriesOnBeforePostDtldCustLedgEntry(var DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; AddCurrencyCode: Code[10]; var GenJnlLine: Record "Gen. Journal Line"; CustPostingGr: Record "Customer Posting Group"; AdjAmount: array[4] of Decimal; var IsHandled: Boolean; var NextEntryNo: Integer)

    begin
        //PROJET
        wFromDetail := TRUE;
        //PROJET//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeApplyVendLedgEntry', '', true, true)]
    local procedure OnBeforeApplyVendLedgEntry(var NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; var GenJnlLine: Record "Gen. Journal Line"; Vend: Record Vendor; var IsAmountToApplyCheckHandled: Boolean)
    var
        TempVATEntry: Record "VAT Entry" TEMPORARY;
        GLSetup: Record "General Ledger Setup";
        CDUGenJnlPostLine_CDU12: Codeunit "Gen. Jnl.-Post Line_CDU12";

    begin
        //NAVISION
        TempVATEntry.DELETEALL;
        IF GLSetup."Unrealized VAT" THEN
            CDUGenJnlPostLine_CDU12.PrepareCheckForUnreaVat(NewCVLedgEntryBuf."Transaction No.", TempVATEntry);
        //NAVISION//


        //+PMT+PAYMENT
        IF GenJnlLine."Due Date" = 0D THEN
            GenJnlLine."Due Date" := NewCVLedgEntryBuf."Due Date";
        //+PMT+PAYMENT//
    end;

    [EventSubscriber(ObjectType::table, Database::"CV Ledger Entry Buffer", 'OnAfterCopyFromVendLedgerEntry', '', true, true)]
    local procedure OnAfterCopyFromVendLedgerEntry(var CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        //+RAP+TRESO
        IF gAddOnLicencePermission.HasPermissionRAP() THEN
            CVLedgerEntryBuffer."Value Date" := VendorLedgerEntry."Value Date";
        //+RAP+TRESO//
    end;

    [EventSubscriber(ObjectType::table, Database::"CV Ledger Entry Buffer", 'OnAfterCopyFromCustLedgerEntry', '', true, true)]
    local procedure OnAfterCopyFromCustLedgerEntry(var CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        //+RAP+TRESO
        IF gAddOnLicencePermission.HasPermissionRAP() THEN
            CVLedgerEntryBuffer."Value Date" := CustLedgerEntry."Value Date";
        //+RAP+TRESO//
    end;

    [EventSubscriber(ObjectType::table, Database::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromCVLedgEntryBuffer', '', true, true)]
    local procedure OnAfterCopyVendLedgerEntryFromCVLedgEntryBuffer(var VendorLedgerEntry: Record "Vendor Ledger Entry"; CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer")
    begin
        //+RAP+TRESO
        IF gAddOnLicencePermission.HasPermissionRAP() THEN
            VendorLedgerEntry."Value Date" := CVLedgerEntryBuffer."Value Date";
        //+RAP+TRESO//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldVendLedgEntry', '', true, true)]
    local procedure OnBeforeInsertDtldVendLedgEntry(var DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; GLRegister: Record "G/L Register")
    begin
        //--INSERT N° DOSSIER
        DtldVendLedgEntry."N° Dossier" := DtldCVLedgEntryBuffer."N° Dossier";
        //DtldVendLedgEntry."Transaction No. Soroubat" := DtldVendLedgEntry."Transaction No.";
        //--INSERT N° DOSSIER

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInitGLEntryVATOnVendUnrealizedVATForRevChargeVAT', '', true, true)]
    local procedure OnBeforeInitGLEntryVATOnVendUnrealizedVATForRevChargeVAT(var VATEntry: Record "VAT Entry"; var GenJournalLine: Record "Gen. Journal Line"; var NextEntryNo: Integer; var IsHandled: Boolean)
    var
        lGenJnlPaymentIntegr: Codeunit "Gen. Jnl-Post Payment Integr.";
    begin
        //+PMT+PAYMENT
        IF gAddOnLicencePermission.HasPermissionPMT THEN
            //#9356
          lGenJnlPaymentIntegr.SetVATEntry(VATEntry, GenJournalLine, FALSE);
        IF (GenJournalLine."Due Date" > GenJournalLine."Posting Date") AND
               ((GenJournalLine."Document Type" = GenJournalLine."Document Type"::Payment) OR
                (GenJournalLine."Journal Template Name" = '')) THEN
            VATEntry."Posting Date" := GenJournalLine."Due Date";
        //#9356//
        //+PMT+PAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", 'OnReverseGLEntryOnBeforeInsertGLEntry', '', true, true)]
    local procedure OnReverseGLEntryOnBeforeInsertGLEntry(var GLEntry: Record "G/L Entry"; GenJnlLine: Record "Gen. Journal Line"; GLEntry2: Record "G/L Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")

    begin
        //#8234
        //REVERSE
        CLEAR(wReverseGLEntryNo);
        wReverseGLEntryNo := GLEntry."Entry No.";
        //REVERSE//
        //#8234//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", 'OnReverseGLEntryOnBeforeInsertGLEntry', '', true, true)]
    local procedure OnReverseGLEntryOnAfterInsertGLEntry(var GLEntry: Record "G/L Entry"; GenJnlLine: Record "Gen. Journal Line"; GLEntry2: Record "G/L Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    begin
        //#8234
        //#5020
        wReverseJobLedgEntry;
        //#5020//
        //#8234//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostJob', '', true, true)]
    local procedure OnBeforePostJob(var GenJournalLine: Record "Gen. Journal Line"; GLEntry: Record "G/L Entry"; var IsJobLine: Boolean; var IsHandled: Boolean)
    var
        JobPostLine: Codeunit "Job Post-Line";
        GLAcc: Record "G/L Account";

    begin
        //PROJET_IMMO (#5444)
        //#7220
        //IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::"Fixed Asset" THEN
        //  EXIT;
        //#7220//
        //PROJET_IMMO//


        GLAcc.Get(GenJournalLine."Account No.");
        IF (NOT GLAcc."Post Job Entry") OR (GenJournalLine."System-Created Entry") THEN
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnCodeOnBeforeFinishPosting', '', true, true)]
    local procedure OnCodeOnBeforeFinishPosting(var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean; FirstEntryNo: Integer)
    var
        lGLAcc: Record "G/L Account";
        "// HJ": Integer;
        GLEntryApplication: Codeunit "G/L Entry Application2";
        JobLine: Boolean;
        wAnalyticalSetup: Record "Analytical Distribution Setup";
        wDistributedEntriesBuffer: Record "Distributed Entries Buffer";
        wAnalytical: Boolean;
    begin
        case GenJournalLine."Account Type" of
            GenJournalLine."Account Type"::"G/L Account":
                BEGIN
                    //#7612
                    IF lGLAcc.GET(GenJournalLine."Account No.") THEN
                        JobLine := (GenJournalLine."Job No." <> '') AND (lGLAcc."Post Job Entry");
                    //#7612
                END;


        end;

        //+REP+
        IF (wAnalyticalSetup.READPERMISSION) THEN
            IF wAnalyticalSetup.GET THEN
                IF (GenJournalLine."Journal Template Name" = wAnalyticalSetup."Gen Ledger Jnl Template Name") AND
                   (GenJournalLine."Journal Batch Name" = wAnalyticalSetup."Gen Ledger Journal Batch Name") THEN BEGIN
                    wDistributedEntriesBuffer.SETRANGE(Type, wDistributedEntriesBuffer.Type::"G/L Journal");
                    wDistributedEntriesBuffer.SETRANGE("Entry no.", GenJournalLine."Line No.");
                    wDistributedEntriesBuffer.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                    wDistributedEntriesBuffer.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                    IF wDistributedEntriesBuffer.FIND('-') THEN
                        wAnalytical := TRUE
                    ELSE
                        wAnalytical := FALSE;
                END;
        //+REP+//

        // >> HJ SORO 27-05-2015 LETTRAGE AUTO AVEC LETTRE
        GLEntryApplication.GetLettrage;
        //  GLEntryApplication.GetLettrageClt;
        // >> HJ SORO 27-05-2015 LETTRAGE AUTO AVEC LETTRE
    end;



    ///////////
    /*[EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnVendPostApplyVendLedgEntryOnBeforeCheckPostingGroup', '', true, true)]

    local procedure OnVendPostApplyVendLedgEntryOnBeforeCheckPostingGroup(var GenJournalLine: Record "Gen. Journal Line"; Vendor: Record Vendor)
    var
        "Gen.Jnl.PostLine": Codeunit "Gen. Jnl.-Post Line";
    begin
        "Gen.Jnl.PostLine".ContinuePosting(GenJournalLine);
    end;*/

    //  [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterVendPostApplyVendLedgEntry', '', true, true)]

    // local procedure OnAfterVendPostApplyVendLedgEntry(var GenJnlLine: Record "Gen. Journal Line"; GLReg: Record "G/L Register")
    // var

    //     lAnalytical: Boolean;
    //     lAnaDistribIntegr: Codeunit "Analytical Distrib.Integr.";

    //     GLSetup: Record "General Ledger Setup";
    // begin
    //     /*      
    //   //Unrealized VAT Check
    //   IF CheckUnrealizedCust AND (CurrentBalance = 0) THEN BEGIN
    //     CustUnrealizedVAT(UnrealizedCustLedgEntry,UnrealizedRemainingAmountCust);
    //     CheckUnrealizedCust := FALSE;
    //   END;
    //   IF CheckUnrealizedVend AND (CurrentBalance = 0) THEN BEGIN
    //     VendUnrealizedVAT(UnrealizedVendLedgEntry,UnrealizedRemainingAmountVend);
    //     CheckUnrealizedVend := FALSE;
    //   END;
    //   */
    //     GLSetup.GET;
    //     WITH GenJnlLine DO BEGIN
    //         //+REP+
    //         IF gAddOnLicencePermission.HasPermissionREP THEN
    //             lAnalytical := lAnaDistribIntegr.GetDistribEntriesBufFromGen(GenJnlLine);
    //         //+REP+//
    //         IF GLEntryTmp.FINDSET THEN BEGIN
    //             REPEAT
    //                 GLEntry := GLEntryTmp;
    //                 IF GLSetup."Additional Reporting Currency" = '' THEN BEGIN
    //                     GLEntry."Additional-Currency Amount" := 0;
    //                     GLEntry."Add.-Currency Debit Amount" := 0;
    //                     GLEntry."Add.-Currency Credit Amount" := 0;
    //                     //+REP+
    //                     GLEntry."Analytical Distribution" := lAnalytical;
    //                     //+REP+//
    //                 END;
    //                 GLEntry.INSERT;
    //                 IF NOT InsertFAAllocDim(GLEntry."Entry No.") THEN
    //                     DimMgt.MoveJnlLineDimToLedgEntryDim(
    //                       TempJnlLineDim, DATABASE::"G/L Entry", GLEntry."Entry No.");
    //             UNTIL GLEntryTmp.NEXT = 0;

    //             GLReg."To VAT Entry No." := NextVATEntryNo - 1;
    //             IF GLReg."To Entry No." = 0 THEN BEGIN
    //                 GLReg."To Entry No." := GLEntry."Entry No.";
    //                 GLReg.INSERT;
    //             END ELSE BEGIN
    //                 GLReg."To Entry No." := GLEntry."Entry No.";
    //                 GLReg.MODIFY;
    //             END;
    //         END;
    //       /*GL2024  GLEntry.CONSISTENT(
    //           (BalanceCheckAmount = 0) AND (BalanceCheckAmount2 = 0) AND
    //           (BalanceCheckAddCurrAmount = 0) AND (BalanceCheckAddCurrAmount2 = 0));*/
    //     END;
    // end;

    //GL2024 Insert dans G/L Entry
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeCheckVendMultiplePostingGroups', '', true, true)]
    local procedure OnBeforeCheckVendMultiplePostingGroups(var DetailedCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; var IsMultiplePostingGroups: Boolean; var IsHandled: Boolean)
    begin
        IsMultiplePostingGroups := true;
        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeCheckCustMultiplePostingGroups', '', true, true)]
    local procedure OnBeforeCheckCustMultiplePostingGroups(var DetailedCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; var IsMultiplePostingGroups: Boolean; var IsHandled: Boolean)
    begin
        IsMultiplePostingGroups := true;
        IsHandled := true;
    end;



    ////////
    var
        //DYS table supprimer
        //  TempDocDim: Record "Journal Line Dimension";
        wFromDetail: Boolean;
        wReverseGLEntryNo: Integer;
        lAnalytical: Boolean;
        GFolio: Code[20];
        wText020: Label 'The %1 used in %2 , %4, %5 has caused an error. Select a %6 for the %7 %8.';
        wText021: Label 'The %1 used in %2 , %4, %5 has caused an error. Select the %6 %7 for the %7 %8.';
        wText022: Label 'The %1 used in %2 , %4, %5 has caused an error. %6 %7 must not be mentioned for the %8 %9.';
        GLEntry: Record "G/L Entry";
        gAddOnLicencePermission: Codeunit IntegrManagement;
        //DYS cdu manquant
        //   gGenJnlSubscriptionIntegr: Codeunit "Gen. Jnl. Subscription Integr.";
        wCheckline: Boolean;

        DimMgt: Codeunit "DimensionManagement";
        Text016: label 'The unrealized VAT for %1 %2 and %3 %4 is out of balance';
        Text017: label 'You cannot apply a document with unrealized VAT as an applying entry to an entry without unrealized VAT. Use the entry without the unrealized VAT as an applying entry.';
        Text018: label 'You cannot apply an inovice to part of a credit memo when the invoice contains lines with different VAT groups and you use unrealized VAT. Create a full invoice and issue a new credit memo.';
        Text019: label 'You cannot apply an invoice to a payment when you use unrealized VAT. Use the payment as the applying entry.';

}