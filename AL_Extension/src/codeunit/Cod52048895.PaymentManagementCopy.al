// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.Bank.Payment;

using Microsoft.Bank.BankAccount;
using Microsoft.Bank.DirectDebit;
using Microsoft.Finance.Currency;
using Microsoft.Finance.Dimension;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.AuditCodes;
using Microsoft.Foundation.NoSeries;
using Microsoft.Purchases.Vendor;
using Microsoft.Purchases.Payables;
using Microsoft.Sales.Receivables;
using Microsoft.Sales.Customer;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Bank.Ledger;

codeunit 52048895 "Payment Management Copy"
{
    Permissions = TableData "Cust. Ledger Entry" = rm,
                  TableData "Vendor Ledger Entry" = rm;

    trigger OnRun()
    begin
        CreatePaymentHeaders();
    end;

    var
        // GroupeRetenu: Record 50002;
        Desc: Text[50];
        Text001: Label 'Le numéro %1 ne peut pas être étendu à plus de 20 caractères.';
        Text002: Label 'La valeur d''un ou plusieurs codes acceptation est Non';
        Text003: Label 'Une ou plusieurs lignes indiquent un code RIB incorrect';
        Text004: Label 'Aucun bordereau à créer';
        Text005: Label 'Validation en comptabilité';
        Text006: Label 'Une ou plusieurs dates d''échéance ne sont pas spécifiées.';
        Text007: Label 'L''action a été annulée';
        Text008: Label 'Le RIB de l''en-tête est incorrect';
        Text009: Label 'La combinaison d''axes analytiques utilisée dans le bordereau %1 est bloquée. %2';
        Text010: Label 'La combinaison d''axes analytiques utilisée dans le bordereau %1, ligne n° %2, est bloquée. %3';
        InvPostingBuffer: array[2] of Record "Payment Post. Buffer" temporary;
        CustomerPostingGroup: Record "Customer Posting Group";
        VendorPostingGroup: Record "Vendor Posting Group";
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLsetup: Record "General Ledger Setup";
        iSbANK: Boolean;
        //     RecReasonCode: Record "Groupe Retenue";
        Folio: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BankAccount: Record "Bank Account";
        // RB SORO	Integer		
        RecPaymentHeaderRS: Record "Payment Header";
        RecPaymentHeader2: Record "Payment Header";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        GenJnlLine: Record "Gen. Journal Line";
        PaymentLine: Record "Payment Line";
        OldPaymentLine: Record "Payment Line";
        StepLedger: Record "Payment Step Ledger";
        Step: Record "Payment Step";
        PaymentHeader: Record "Payment Header";
        PaymentClass: Record "Payment Class";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        DimMgt: Codeunit DimensionManagement;
        N: Integer;
        Suffix: Text;
        EntryTypeDebit: Enum "Gen. Journal Account Type";
        EntryNoAccountDebit: Code[20];
        EntryPostGroupDebit: Code[20];
        EntryTypeCredit: Enum "Gen. Journal Account Type";
        EntryNoAccountCredit: Code[20];
        EntryPostGroupCredit: Code[20];
        GLEntryNoTmp: Integer;
        Text011: Label 'XX';
        Text012: Label 'Le groupe compta. client %1 n''existe pas.';

        Text013: label 'Le groupe compta. fournisseur %1 n''existe pas.';
        Text014: Label 'Vous devez entrer un compte général pour le groupe compta. client %1.';

        Text015: Label 'Vous devez entrer un compte général pour le groupe compta. fournisseur %1.';
        Text016: Label 'Une ligne validée ne peut pas être supprimée.';
        Text017: Label 'Le code source %1 n''existe pas.';
        HeaderAccountUsedGlobally: Boolean;
        Text018: Label 'Vous devez spécifier un numéro de compte de débit à l''étape %1 du type de règlement %2.';
        Text019: Label 'Vous devez spécifier un numéro de compte de crédit à l''étape %1 du type de règlement %2.';
        Text020: Label 'Vous devez spécifier un n° de compte dans le bordereau.';
        Text021: Label 'Le code %1 ne contient pas de nombre.';
        Text022: Label 'Le statut du document %1 n''autorise pas l''archivage.';
        CheckDimVauePostingLineErr: Label 'Une dimension utilisée dans %1 %2 %3 a provoqué une erreur. %4';
        CheckDimVauePostingHeaderErr: Label 'Une dimension utilisée dans %1 a provoqué une erreur. %2';
        Text100: Label 'Arrondi sur %1';

        StepParametres_lr: Record "Payment Step";
        Text023: Label 'Veuillez saisir le compte d''entête.';

        PayClass: Record "Payment Status";
        DocDim: Record 357;
        Statement: Record 10865;

    procedure Actualiserstat(VAR Rec: Record "Payment Header")
    var

        RecTmp: Record "Payment Line";
    begin
        WITH Rec DO BEGIN
            CLEAR(PayClass);
            IF PayClass.GET("Payment Class", "Status No.") AND ((PayClass."Calculer Retenue à la source") OR
              (PayClass."Calculer Retenue Sur TVA") OR (PayClass."Tva Sur Commission") OR (PayClass.Commission) OR
              (PayClass."Calculer Retenue sur Garantie")) THEN BEGIN
                CLEAR(RecTmp);
                RecTmp.RESET;
                RecTmp.SETFILTER("Payment Class", "Payment Class");
                RecTmp.SETFILTER("Status No.", '%1', "Status No.");
                RecTmp.SETFILTER("No.", "No.");
                IF RecTmp.FIND('-') THEN BEGIN
                    REPEAT
                        RecTmp.CalcRetenu;
                        RecTmp.CalcAmount;
                        RecTmp.MODIFY;
                    UNTIL RecTmp.NEXT = 0;
                    COMMIT;
                END;
            END;
        END;
    end;

    local procedure ProcessPaymentStep(PaymentHeaderNo: Code[20]; PaymentStep: Record "Payment Step")
    var
        PaymentStatus: Record "Payment Status";
        ActionValidated: Boolean;
    begin
        OnBeforeProcessPaymentStep(PaymentHeaderNo, PaymentStep, PaymentLine);

        PaymentHeader.Get(PaymentHeaderNo);
        PaymentHeader.SetRange("No.", PaymentHeader."No.");
        // HS Retenus Fix
        //>>>MBK:24/11/2010
        IF StepParametres_lr.GET(PaymentStep."Payment Class", PaymentStep.Line) THEN;
        IF PaymentStep."Code Origine Obligatoire" THEN
            IF PaymentHeader."Account No." = '' THEN
                ERROR(Text023);
        //>>>MBK:24/11/2010
        Actualiserstat(PaymentHeader);
        // HS Retenus Fix
        if PaymentStep."Verify Header RIB" and not PaymentHeader."RIB Checked" then
            Error(Text008);

        PaymentLine.SetRange("No.", PaymentHeader."No.");
        PaymentLine.SetRange("Copied To No.", '');

        if PaymentStep."Acceptation Code<>No" then begin
            PaymentLine.SetRange("Acceptation Code", PaymentLine."Acceptation Code"::No);
            if PaymentLine.Find('-') then
                Error(Text002);
            PaymentLine.SetRange("Acceptation Code");
        end;

        if PaymentStep."Verify Lines RIB" then begin
            PaymentLine.SetRange("RIB Checked", false);
            if PaymentLine.Find('-') then
                Error(Text003);
            PaymentLine.SetRange("RIB Checked");
        end;

        if PaymentStep."Verify Due Date" then begin
            PaymentLine.SetRange("Due Date", 0D);
            if PaymentLine.Find('-') then
                Error(Text006);
            PaymentLine.SetRange("Due Date");
        end;
        OnProcessPaymentStepOnAfterCheckPaymentStep(PaymentStep, PaymentHeader, PaymentLine);

        Step.Get(PaymentStep."Payment Class", PaymentStep.Line);

        ActionValidated := ProcessPaymentStepByActionType();

        if ActionValidated then begin
            PaymentHeader.Validate("Status No.", Step."Next Status");
            PaymentHeader.Modify();
            PaymentLine.SetRange("No.", PaymentHeader."No.");
            PaymentLine.ModifyAll("Status No.", Step."Next Status");
            PaymentStatus.Get(PaymentHeader."Payment Class", Step."Next Status");
            PaymentLine.ModifyAll("Payment in Progress", PaymentStatus."Payment in Progress");
        end else
            Message(Text007);

        OnAfterProcessPaymentStep(PaymentHeaderNo, PaymentStep);
    end;

    local procedure ProcessPaymentStepByActionType() ActionValidated: Boolean
    var
        Window: Dialog;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeProcessPaymentStepByActionType(PaymentLine, Step, ActionValidated, IsHandled);
        if IsHandled then
            exit(ActionValidated);

        case Step."Action Type" of
            Step."Action Type"::None:
                exit(true);
            Step."Action Type"::"Cancel File":
                begin
                    PaymentHeader."File Export Completed" := false;
                    PaymentHeader.Modify();
                    exit(true);
                end;
            Step."Action Type"::File:
                begin
                    PaymentHeader."File Export Completed" := false;
                    PaymentHeader.Modify();
                    Commit();

                    case Step."Export Type" of
                        Step."Export Type"::Report:
                            REPORT.RunModal(Step."Export No.", true, false, PaymentHeader);
                        Step."Export Type"::XMLport:
                            RunXmlPortExport(Step."Export No.", PaymentHeader);
                    end;

                    PaymentHeader.Find();
                    exit(PaymentHeader."File Export Completed");
                end;
            Step."Action Type"::Report:
                begin

                    //GL2024  REPORT.RunModal(Step."Report No.", true, true, PaymentLine);
                    CLEAR(Statement);
                    Statement.SETCURRENTKEY("Payment Class", "Status No.", "No.");
                    Statement.SETFILTER("Payment Class", PaymentHeader."Payment Class");
                    Statement.SETFILTER("Status No.", '%1', PaymentHeader."Status No.");
                    Statement.SETFILTER("No.", PaymentHeader."No.");
                    REPORT.RUNMODAL(Step."Report No.", TRUE, TRUE, Statement);
                    exit(true);
                end;
            Step."Action Type"::Ledger:
                begin
                    InvPostingBuffer[1].DeleteAll();
                    CheckDim();
                    Window.Open(
                      '#1#################################\\' +
                      Text005);
                    if PaymentLine.Find('-') then
                        repeat
                            Window.Update(1, Text005 + ' ' + PaymentLine."No." + ' ' + Format(PaymentLine."Line No."));
                            OldPaymentLine := PaymentLine;
                            HeaderAccountUsedGlobally := false;
                            GenerInvPostingBuffer();
                            PaymentLine."Acc. Type Last Entry Debit" := EntryTypeDebit;
                            PaymentLine."Acc. No. Last Entry Debit" := EntryNoAccountDebit;
                            PaymentLine."P. Group Last Entry Debit" := EntryPostGroupDebit;
                            PaymentLine."Acc. Type Last Entry Credit" := EntryTypeCredit;
                            PaymentLine."Acc. No. Last Entry Credit" := EntryNoAccountCredit;
                            PaymentLine."P. Group Last Entry Credit" := EntryPostGroupCredit;
                            PaymentLine.Validate("Status No.", Step."Next Status");
                            //    Message(Format(Step."Next Status"));
                            CLEAR(PayClass);
                            IF PayClass.GET(PaymentLine."Payment Class", Step."Next Status") THEN;
                            IF (PayClass."Compte en-tête") AND (PaymentHeader."Account No." = '') THEN
                                ERROR('Vous devez spécifiez Compte en-tête !!!!');
                            PaymentLine."Payment in Progress" := PayClass."Payment in Progress";
                            PaymentLine."En Banque" := PayClass."En Banque";
                            PaymentLine.Posted := true;
                            PaymentLine.Modify();
                        until PaymentLine.Next() = 0;
                    Window.Close();
                    GenerEntries();
                    exit(true);
                end;
            else
                OnProcessPaymentStepOnCaseElse(Step, PaymentLine, ActionValidated, PaymentHeader);
        end;
    end;


    procedure UpdtBuffer()
    var
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        InvPostingBuffer[2] := InvPostingBuffer[1];
        if InvPostingBuffer[2].Find() then begin
            InvPostingBuffer[2].Validate(Amount, InvPostingBuffer[2].Amount + InvPostingBuffer[1].Amount);
            InvPostingBuffer[2]."Amount (LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY(PaymentHeader."Posting Date",
                  PaymentHeader."Currency Code", InvPostingBuffer[2].Amount, PaymentHeader."Currency Factor"));
            InvPostingBuffer[2]."VAT Amount" :=
              InvPostingBuffer[2]."VAT Amount" + InvPostingBuffer[1]."VAT Amount";
            InvPostingBuffer[2]."Line Discount Amount" :=
              InvPostingBuffer[2]."Line Discount Amount" + InvPostingBuffer[1]."Line Discount Amount";
            if InvPostingBuffer[1]."Line Discount Account" <> '' then
                InvPostingBuffer[2]."Line Discount Account" := InvPostingBuffer[1]."Line Discount Account";
            InvPostingBuffer[2]."Inv. Discount Amount" :=
              InvPostingBuffer[2]."Inv. Discount Amount" + InvPostingBuffer[1]."Inv. Discount Amount";
            if InvPostingBuffer[1]."Inv. Discount Account" <> '' then
                InvPostingBuffer[2]."Inv. Discount Account" := InvPostingBuffer[1]."Inv. Discount Account";
            InvPostingBuffer[2]."VAT Base Amount" :=
              InvPostingBuffer[2]."VAT Base Amount" + InvPostingBuffer[1]."VAT Base Amount";
            InvPostingBuffer[2]."Amount (ACY)" :=
              InvPostingBuffer[2]."Amount (ACY)" + InvPostingBuffer[1]."Amount (ACY)";
            InvPostingBuffer[2]."VAT Amount (ACY)" :=
              InvPostingBuffer[2]."VAT Amount (ACY)" + InvPostingBuffer[1]."VAT Amount (ACY)";
            InvPostingBuffer[2]."VAT Difference" :=
              InvPostingBuffer[2]."VAT Difference" + InvPostingBuffer[1]."VAT Difference";
            InvPostingBuffer[2]."Line Discount Amt. (ACY)" :=
              InvPostingBuffer[2]."Line Discount Amt. (ACY)" +
              InvPostingBuffer[1]."Line Discount Amt. (ACY)";
            InvPostingBuffer[2]."Inv. Discount Amt. (ACY)" :=
              InvPostingBuffer[2]."Inv. Discount Amt. (ACY)" +
              InvPostingBuffer[1]."Inv. Discount Amt. (ACY)";
            InvPostingBuffer[2]."VAT Base Amount (ACY)" :=
              InvPostingBuffer[2]."VAT Base Amount (ACY)" +
              InvPostingBuffer[1]."VAT Base Amount (ACY)";
            InvPostingBuffer[2].Quantity :=
              InvPostingBuffer[2].Quantity + InvPostingBuffer[1].Quantity;
            if not InvPostingBuffer[1]."System-Created Entry" then
                InvPostingBuffer[2]."System-Created Entry" := false;
            InvPostingBuffer[2].Modify();
        end else begin
            GLEntryNoTmp += 1;
            InvPostingBuffer[1]."GL Entry No." := GLEntryNoTmp;
            InvPostingBuffer[1].Insert();
        end;
    end;


    procedure CopyLigBor(var FromPaymentLine: Record "Payment Line"; NewStep: Integer; var PayNum: Code[20])
    var
        ToBord: Record "Payment Header";
        ToPaymentLine: Record "Payment Line";
        Step: Record "Payment Step";
        Process: Record "Payment Class";
        PaymentStatus: Record "Payment Status";
        NoSeries: Codeunit "No. Series";
#if not CLEAN24
        NoSeriesMgt: Codeunit NoSeriesManagement;


        IsHandled: Boolean;
#endif
        i: Integer;
    begin
        if FromPaymentLine.Find('-') then begin
            Step.Get(FromPaymentLine."Payment Class", NewStep);
            Process.Get(FromPaymentLine."Payment Class");
            if PayNum = '' then begin
                i := 10000;
#if not CLEAN24
                NoSeriesMgt.RaiseObsoleteOnBeforeInitSeries(Step."Header Nos. Series", '', 0D, ToBord."No.", ToBord."No. Series", IsHandled);
                if not IsHandled then begin
#endif
                    ToBord."No. Series" := Step."Header Nos. Series";
                    ToBord."No." := NoSeries.GetNextNo(ToBord."No. Series");
#if not CLEAN24
                    NoSeriesMgt.RaiseObsoleteOnAfterInitSeries(ToBord."No. Series", Step."Header Nos. Series", 0D, ToBord."No.");
                end;
#endif
                ToBord."Payment Class" := FromPaymentLine."Payment Class";
                ToBord."Status No." := Step."Next Status";
                PaymentStatus.Get(ToBord."Payment Class", ToBord."Status No.");
                ToBord."Archiving Authorized" := PaymentStatus."Archiving Authorized";
                ToBord."Currency Code" := FromPaymentLine."Currency Code";
                ToBord."Currency Factor" := FromPaymentLine."Currency Factor";
                OnCopyLigBorOnBeforeInitHeader(ToBord, Process, i);

                //GL2024      ToBord.InitHeader();
                //GL2024   
                ToBord."Posting Date" := WorkDate();
                ToBord."Document Date" := WorkDate();
                ToBord.Validate("Account Type", ToBord."Account Type"::"Bank Account");
                //GL2024   
                ToBord.Insert();
            end else begin
                ToBord.Get(PayNum);
                ToPaymentLine.SetRange("No.", PayNum);
                if ToPaymentLine.FindLast() then
                    i := ToPaymentLine."Line No." + 10000
                else
                    i := 10000;
            end;
            repeat
                ToPaymentLine.Copy(FromPaymentLine);
                ToPaymentLine."No." := ToBord."No.";
                ToPaymentLine."Line No." := i;
                ToPaymentLine.IsCopy := true;
                ToPaymentLine."Status No." := Step."Next Status";
                ToPaymentLine."Copied To No." := '';
                ToPaymentLine."Copied To Line" := 0;
                ToPaymentLine.Posted := false;
                ToPaymentLine."Created from No." := FromPaymentLine."No.";
                ToPaymentLine."Dimension Set ID" := FromPaymentLine."Dimension Set ID";
                OnCopyLigBorOnBeforeToPaymentLineInsert(ToPaymentLine, Process);
                ToPaymentLine.Insert(true);
                FromPaymentLine."Copied To No." := ToPaymentLine."No.";
                FromPaymentLine."Copied To Line" := ToPaymentLine."Line No.";




                //GL2024


                ToPaymentLine."Montant Retenue" := FromPaymentLine."Montant Retenue";
                ToPaymentLine."Montant Retenue Validé" := FromPaymentLine."Montant Retenue Validé";
                ToPaymentLine."Montant Retenue DS" := FromPaymentLine."Montant Retenue DS";
                ToPaymentLine."Montant Retenue Validé DS" := FromPaymentLine."Montant Retenue Validé DS";
                ToPaymentLine."Montant Retenue TVA" := FromPaymentLine."Montant Retenue TVA";
                ToPaymentLine."Montant Retenue TVA Validé" := FromPaymentLine."Montant Retenue TVA Validé";
                ToPaymentLine."Montant Retenue TVA DS" := FromPaymentLine."Montant Retenue TVA DS";
                ToPaymentLine."Montant Retenue TVA Validé DS" := FromPaymentLine."Montant Retenue TVA Validé DS";
                ToPaymentLine."Montant TVA sur Commission" := FromPaymentLine."Montant TVA sur Commission";
                ToPaymentLine."Montant TVA sur Commission DS" := FromPaymentLine."Montant TVA sur Commission DS";
                ToPaymentLine."Montant Commission" := FromPaymentLine."Montant Commission";
                ToPaymentLine."Montant Commission DS" := FromPaymentLine."Montant Commission DS";
                ToPaymentLine."Montant TVA sur Com. validé" := FromPaymentLine."Montant TVA sur Com. validé";
                ToPaymentLine."Montant TVA sur Com. validé DS" := FromPaymentLine."Montant TVA sur Com. validé DS";
                ToPaymentLine."Montant Commission Validé" := FromPaymentLine."Montant Commission Validé";
                ToPaymentLine."Montant Commission Validé DS" := FromPaymentLine."Montant Commission Validé DS";
                ToPaymentLine."Montant Retenue G." := FromPaymentLine."Montant Retenue G.";
                ToPaymentLine."Code Retenue de Garantie" := FromPaymentLine."Code Retenue de Garantie";
                ToPaymentLine."Montant Retenue G." := FromPaymentLine."Montant Retenue G.";
                ToPaymentLine."Montant Retenue G. Validé" := FromPaymentLine."Montant Retenue G. Validé";
                ToPaymentLine."Montant Retenue G. DS" := FromPaymentLine."Montant Retenue G. DS";
                ToPaymentLine."Montant Retenue G. Validé DS" := FromPaymentLine."Montant Retenue G. Validé DS";
                //>> IMS 11 05 2011

                ToPaymentLine."Intérêt FED" := FromPaymentLine."Intérêt FED";
                IF FromPaymentLine."Currency Code" <> '' THEN
                    ToPaymentLine."Intérêt FED (DS)" := ROUND(FromPaymentLine."Intérêt FED (DS)" / FromPaymentLine."Currency Factor", 0.001);

                ToPaymentLine."Intérêt Escompte" := FromPaymentLine."Intérêt Escompte";
                IF FromPaymentLine."Currency Code" <> '' THEN
                    ToPaymentLine."Intérêt Escompte (DS)" := ROUND(FromPaymentLine."Intérêt Escompte (DS)" / FromPaymentLine."Currency Factor", 0.001);
                //<< IMS 11 05 2011
                //>> IMS 02 06 2011
                ToPaymentLine."Intérêt sur Prêt" := FromPaymentLine."Intérêt sur Prêt";
                IF FromPaymentLine."Currency Code" <> '' THEN
                    ToPaymentLine."Intérêt sur Prêt (DS)" := ROUND(FromPaymentLine."Intérêt sur Prêt (DS)" / FromPaymentLine."Currency Factor", 0.001);
                //<< IMS 02 06 2011

                ToPaymentLine.MODIFY;
                FromPaymentLine."Copied To No." := ToPaymentLine."No.";
                FromPaymentLine."Copied To Line" := ToPaymentLine."Line No.";
                /*GL2024  DocDim.SETRANGE("Table ID",DATABASE::"Payment Line");
                  DocDim.SETRANGE("Document Type",DocDim."Document Type"::" ");
                  DocDim.SETRANGE("Document No.",FromPaymentLine."No.");
                  DocDim.SETRANGE("Line No.",FromPaymentLine."Line No.");
                  DimManagement.MoveDocDimToDocDim(DocDim,DATABASE::"Payment Line",ToBord."No.",DocDim."Document Type"::" ",i);*/
                //GL2024

















                FromPaymentLine.Modify();
                i += 10000;
            until FromPaymentLine.Next() = 0;
            PayNum := ToBord."No.";
        end;
    end;


    procedure DeleteLigBorCopy(var FromPaymentLine: Record "Payment Line")
    var
        ToPaymentLine: Record "Payment Line";
    begin
        ToPaymentLine.SetCurrentKey("Copied To No.", "Copied To Line");

        if FromPaymentLine.Find('-') then
            if FromPaymentLine.Posted then
                Message(Text016)
            else
                repeat
                    ToPaymentLine.SetRange("Copied To No.", FromPaymentLine."No.");
                    ToPaymentLine.SetRange("Copied To Line", FromPaymentLine."Line No.");
                    ToPaymentLine.FindFirst();
                    ToPaymentLine."Copied To No." := '';
                    ToPaymentLine."Copied To Line" := 0;
                    ToPaymentLine.Modify();
                    FromPaymentLine.Delete(true);
                until FromPaymentLine.Next() = 0;
    end;


    procedure GenerInvPostingBuffer()
    var
        PaymentClass: Record "Payment Class";
        NoSeriesBatch: Codeunit "No. Series - Batch";
        Description: Text[98];
        StepLedgerTmp: Record "Payment Step Ledger";
    //  GroupeRetenu: Record "Groupe Retenue";
    begin
        StepLedger.SetRange("Payment Class", Step."Payment Class");
        StepLedger.SetRange(Line, Step.Line);
        CLEAR(StepLedgerTmp);
        StepLedgerTmp.RESET;
        if StepLedger.Find('-') then begin
            repeat
                Clear(InvPostingBuffer[1]);
                SetPostingGroup();
                SetAccountNo();
                InvPostingBuffer[1]."System-Created Entry" := true;

                if StepLedger.Sign = StepLedger.Sign::Debit then begin
                    // HS Fix Retenue a la source entries
                    IF StepLedgerTmp.GET(Step."Payment Class", Step.Line, StepLedger.Sign::Credit) THEN;
                    if (StepLedgerTmp."Compta. Retenue à la source") then begin
                        InvPostingBuffer[1].Validate(Amount, (PaymentLine.Amount - PaymentLine."Montant Retenue"));
                        InvPostingBuffer[1].Validate("Amount (LCY)", (PaymentLine."Amount (LCY)" - PaymentLine."Montant Retenue DS"));
                    end
                    else begin///////////
                        if StepLedgerTmp."Annuler Compta Retn. à la Sour" then begin ///////////////////////////
                            InvPostingBuffer[1].Validate(Amount, (PaymentLine.Amount - PaymentLine."Montant Retenue Validé"));
                            InvPostingBuffer[1].Validate("Amount (LCY)", (PaymentLine."Amount (LCY)" - PaymentLine."Montant Retenue Validé DS"));

                        end
                        else begin////////////////////
                            InvPostingBuffer[1].Validate(Amount, (PaymentLine.Amount));
                            InvPostingBuffer[1].Validate("Amount (LCY)", (PaymentLine."Amount (LCY)"));
                            //GL2024 Message('debit %1  %2', format(InvPostingBuffer[1].amount), format(InvPostingBuffer[1]."Amount (LCY)"));
                            //<< AGA DSFT 09/06/2011
                            if StepLedgerTmp."Compta montant intial" then begin
                                InvPostingBuffer[1].Validate(Amount, (PaymentLine."Montant Initial"));
                                InvPostingBuffer[1].Validate("Amount (LCY)", (PaymentLine."Montant Initial DS"));
                            end;
                            //>> AGA DSFT 09/06/2011
                        end;

                    end;
                    if StepLedgerTmp."Compta. Retenue Sur TVA" then begin
                        InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount - PaymentLine."Montant Retenue TVA");
                        InvPostingBuffer[1].Validate("Amount (LCY)", InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."Montant Retenue TVA DS");
                    end;

                    if StepLedgerTmp."Retenue sur Garantie" then begin
                        InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount - PaymentLine."Montant Retenue G.");
                        InvPostingBuffer[1].Validate("Amount (LCY)", InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."Montant Retenue G. DS");
                    end;

                    if (PaymentLine."Account Type" = PaymentLine."account type"::Vendor) then begin
                        if (StepLedgerTmp."Inclure Commission") and (StepLedgerTmp."Compte Commission" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount + PaymentLine."Montant Commission");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" + PaymentLine."Montant Commission DS"));
                        end;
                        if (StepLedgerTmp."Inclure Commission") and (StepLedgerTmp."Compte TVA/Commission" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount + PaymentLine."Montant TVA sur Commission");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" +
                                                  PaymentLine."Montant TVA sur Commission DS"));
                        end;
                        // IMS 11 05 2011 MAJ INTERET FED/ESCOMPTE   type four
                        if (StepLedgerTmp."Inclure IntérêtFED") and (StepLedgerTmp."Compte Intérêt FED" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount + PaymentLine."Intérêt FED");
                            Message(Format(PaymentLine."Intérêt FED"));
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" + PaymentLine."Intérêt FED (DS)"));
                        end;
                        if (StepLedgerTmp."Inclure Intérêt Escompte") and (StepLedgerTmp."Compte Intérêt Escompte" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount + PaymentLine."Intérêt Escompte");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" + PaymentLine."Intérêt Escompte (DS)"));
                        end;
                        //>> IMS 02 06 INTERET SUR PRET
                        if (StepLedgerTmp."Inclure Interêt sur Prêt") and (StepLedgerTmp."Compte Intérêt sur Prêt" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount + PaymentLine."Intérêt sur Prêt");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" + PaymentLine."Intérêt sur Prêt (DS)"));
                        end;
                        //<< IMS 02 06 INTERET SUR PRET

                        // IMS 11 05 2011 MAJ INTERET FED/ESCOMPTE   type four

                    end;
                    // >>IMS 07 06 2011 typ compte gen
                    if (PaymentLine."Account Type" = PaymentLine."account type"::"G/L Account") then begin
                        if (StepLedgerTmp."Inclure IntérêtFED") and (StepLedgerTmp."Compte Intérêt FED" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount - PaymentLine."Intérêt FED");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."Intérêt FED (DS)"));
                        end;
                    end;
                    if (PaymentLine."Account Type" = PaymentLine."account type"::"G/L Account") then begin
                        if (StepLedgerTmp."Inclure Intérêt Escompte") and (StepLedgerTmp."Compte Intérêt Escompte" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount - PaymentLine."Intérêt Escompte");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."Intérêt Escompte (DS)"));
                        end;
                    end;

                    if (PaymentLine."Account Type" = PaymentLine."account type"::"G/L Account") then begin
                        if (StepLedgerTmp."Inclure Interêt sur Prêt") and (StepLedgerTmp."Compte Intérêt sur Prêt" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount - PaymentLine."Intérêt sur Prêt");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."Intérêt sur Prêt (DS)"));
                        end;
                    end;
                    // <<IMS 07 06 2011 typ compte gen

                    if (PaymentLine."Account Type" = PaymentLine."account type"::Customer) then begin
                        if (StepLedger."Inclure Commission") and (StepLedger."Compte Commission" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount + PaymentLine."Montant Commission");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" + PaymentLine."Montant Commission DS"));
                        end;
                        if (StepLedger."Inclure Commission") and (StepLedger."Compte TVA/Commission" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount + PaymentLine."Montant TVA sur Commission");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" +
                                                  PaymentLine."Montant TVA sur Commission DS"));
                        end;
                        // IMS 11 05 2011 MAJ INTERET FED/ESCOMPTE   type cust
                        if (StepLedgerTmp."Inclure IntérêtFED") and (StepLedgerTmp."Compte Intérêt FED" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount + PaymentLine."Intérêt FED");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" + PaymentLine."Intérêt FED (DS)"));
                        end;
                        if (StepLedgerTmp."Inclure Intérêt Escompte") and (StepLedgerTmp."Compte Intérêt Escompte" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount + PaymentLine."Intérêt Escompte");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" + PaymentLine."Intérêt Escompte (DS)"));
                        end;
                        //>> IMS 02 06 2011 INTERET SUR PRET
                        if (StepLedgerTmp."Inclure Interêt sur Prêt") and (StepLedgerTmp."Compte Intérêt sur Prêt" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount + PaymentLine."Intérêt sur Prêt");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" + PaymentLine."Intérêt sur Prêt (DS)"));
                        end;
                        // IMS 02 06 2011 INTERET SUR PRET
                        // IMS 11 05 2011 MAJ INTERET FED/ESCOMPTE   type cust

                    end;

                    if not StepLedger."Forcer Imputation débit/crédit" then begin
                        InvPostingBuffer[1].Validate(Amount, Abs(InvPostingBuffer[1].Amount));
                        InvPostingBuffer[1].Validate("Amount (LCY)", Abs(InvPostingBuffer[1]."Amount (LCY)"));
                    end;
                    if (StepLedger."Accounting Type" = StepLedger."accounting type"::"Header Payment Account") and
                       (StepLedger."Forcer Imputation débit/crédit") then begin
                        InvPostingBuffer[1].Validate(Amount, -InvPostingBuffer[1].Amount);
                        InvPostingBuffer[1].Validate("Amount (LCY)", -InvPostingBuffer[1]."Amount (LCY)");
                    end;
                    // HS Fix Retenue a la source entries
                    // InvPostingBuffer[1].Validate(Amount, Abs(PaymentLine.Amount));
                    // InvPostingBuffer[1].Validate("Amount (LCY)", Abs(PaymentLine."Amount (LCY)"));
                end else begin
                    // HS Fix Retenue a la source entries
                    if StepLedgerTmp.Get(Step."Payment Class", Step.Line, StepLedger.Sign::Debit) then;
                    if (StepLedgerTmp."Compta. Retenue à la source") then begin
                        InvPostingBuffer[1].Validate(Amount, (PaymentLine.Amount - PaymentLine."Montant Retenue") * -1);
                        InvPostingBuffer[1].Validate("Amount (LCY)", (PaymentLine."Amount (LCY)" - PaymentLine."Montant Retenue DS") * -1);
                    end else begin
                        if StepLedgerTmp."Annuler Compta Retn. à la Sour" then begin
                            InvPostingBuffer[1].Validate(Amount, (PaymentLine.Amount - PaymentLine."Montant Retenue Validé") * -1);
                            InvPostingBuffer[1].Validate("Amount (LCY)", (PaymentLine."Amount (LCY)" - PaymentLine."Montant Retenue Validé DS") * -1);
                            //GL2024  Message('credit %1  %2', format(InvPostingBuffer[1].amount), format(InvPostingBuffer[1]."Amount (LCY)"));
                        end else begin
                            InvPostingBuffer[1].Validate(Amount, (PaymentLine.Amount) * -1);
                            InvPostingBuffer[1].Validate("Amount (LCY)", (PaymentLine."Amount (LCY)") * -1);
                            //<< AGA DSFT 09/06/2011
                            if StepLedgerTmp."Compta montant intial" then begin
                                InvPostingBuffer[1].Validate(Amount, (PaymentLine."Montant Initial"));
                                InvPostingBuffer[1].Validate("Amount (LCY)", (PaymentLine."Montant Initial DS"));
                            end;
                            //>> AGA DSFT 09/06/2011

                        end;
                    end;

                    if StepLedgerTmp."Compta. Retenue Sur TVA" then begin
                        InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount + PaymentLine."Montant Retenue TVA");
                        InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" + PaymentLine."Montant Retenue TVA DS"));
                    end;
                    if StepLedgerTmp."Retenue sur Garantie" then begin
                        InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount + PaymentLine."Montant Retenue G.");
                        InvPostingBuffer[1].Validate("Amount (LCY)", InvPostingBuffer[1]."Amount (LCY)" + PaymentLine."Montant Retenue G. DS");
                    end;

                    if (PaymentLine."Account Type" = PaymentLine."account type"::Vendor) then begin
                        if (StepLedgerTmp."Inclure Commission") and (StepLedgerTmp."Compte Commission" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount - PaymentLine."Montant Commission");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."Montant Commission DS"));
                        end;
                        if (StepLedgerTmp."Inclure Commission") and (StepLedgerTmp."Compte TVA/Commission" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount - PaymentLine."Montant TVA sur Commission");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" -
                                                  PaymentLine."Montant TVA sur Commission DS"));
                        end;
                        // IMS 11 05 2011 MAJ INTERET FED/ESCOMPTE   type four
                        if (StepLedgerTmp."Inclure IntérêtFED") and (StepLedgerTmp."Compte Intérêt FED" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount - PaymentLine."Intérêt FED");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."Intérêt FED (DS)"));
                        end;
                        if (StepLedgerTmp."Inclure Intérêt Escompte") and (StepLedgerTmp."Compte Intérêt Escompte" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount - PaymentLine."Intérêt Escompte");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."Intérêt Escompte (DS)"));
                        end;
                        // IMS 11 05 2011 MAJ INTERET FED/ESCOMPTE   type four
                        // IMS 02 06 2011 INTERET SUR PRET
                        if (StepLedgerTmp."Inclure Interêt sur Prêt") and (StepLedgerTmp."Compte Intérêt sur Prêt" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount - PaymentLine."Intérêt sur Prêt");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."Intérêt sur Prêt (DS)"));
                        end;
                        // IMS 02 06 2011 INTERET SUR PRET
                    end;

                    // >>IMS 07 06 2011 typ compte gen //************************
                    if (PaymentLine."Account Type" = PaymentLine."account type"::"G/L Account") then begin
                        if (StepLedgerTmp."Inclure IntérêtFED") and (StepLedgerTmp."Compte Intérêt FED" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount - PaymentLine."Intérêt FED");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."Intérêt FED (DS)"));
                        end;
                    end;
                    if (PaymentLine."Account Type" = PaymentLine."account type"::"G/L Account") then begin
                        if (StepLedgerTmp."Inclure Intérêt Escompte") and (StepLedgerTmp."Compte Intérêt Escompte" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount - PaymentLine."Intérêt Escompte");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."Intérêt Escompte (DS)"));
                        end;
                    end;

                    if (PaymentLine."Account Type" = PaymentLine."account type"::"G/L Account") then begin
                        if (StepLedgerTmp."Inclure Interêt sur Prêt") and (StepLedgerTmp."Compte Intérêt sur Prêt" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount - PaymentLine."Intérêt sur Prêt");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."Intérêt sur Prêt (DS)"));
                        end;
                    end;
                    // <<IMS 07 06 2011 typ compte gen


                    if (PaymentLine."Account Type" = PaymentLine."account type"::Customer) then begin
                        if (StepLedger."Inclure Commission") and (StepLedger."Compte Commission" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount - PaymentLine."Montant Commission");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."Montant Commission DS"));
                        end;
                        if (StepLedger."Inclure Commission") and (StepLedger."Compte TVA/Commission" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount - PaymentLine."Montant TVA sur Commission");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" -
                                                  PaymentLine."Montant TVA sur Commission DS"));
                        end;
                        // IMS 11 05 2011 MAJ INTERET FED/ESCOMPTE   type cust
                        if (StepLedgerTmp."Inclure IntérêtFED") and (StepLedgerTmp."Compte Intérêt FED" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount - PaymentLine."Intérêt FED");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."Intérêt FED (DS)"));
                        end;
                        if (StepLedgerTmp."Inclure Intérêt Escompte") and (StepLedgerTmp."Compte Intérêt Escompte" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount - PaymentLine."Intérêt Escompte");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."Intérêt Escompte (DS)"));
                        end;
                        //>> IMS 02 06 2011 INTERET SUR PRET
                        if (StepLedgerTmp."Inclure Interêt sur Prêt") and (StepLedgerTmp."Compte Intérêt sur Prêt" <> '') then begin
                            InvPostingBuffer[1].Validate(Amount, InvPostingBuffer[1].Amount - PaymentLine."Intérêt sur Prêt");
                            InvPostingBuffer[1].Validate("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."Intérêt sur Prêt (DS)"));
                        end;
                        //<< IMS 02 06 2011 INTERET SUR PRET
                        // IMS 11 05 2011 MAJ INTERET FED/ESCOMPTE   type cust

                    end;

                    if not StepLedger."Forcer Imputation débit/crédit" then begin
                        InvPostingBuffer[1].Validate(Amount, -Abs(InvPostingBuffer[1].Amount));
                        InvPostingBuffer[1].Validate("Amount (LCY)", -Abs(InvPostingBuffer[1]."Amount (LCY)"));
                    end;

                    if (StepLedgerTmp."Accounting Type" = StepLedgerTmp."accounting type"::"Header Payment Account") and
                       (StepLedger."Forcer Imputation débit/crédit") then begin
                        InvPostingBuffer[1].Validate(Amount, -InvPostingBuffer[1].Amount);
                        InvPostingBuffer[1].Validate("Amount (LCY)", -InvPostingBuffer[1]."Amount (LCY)");
                    end;

                    // HS Fix Retenue a la source entries
                    /*GL2025    InvPostingBuffer[1].Validate(Amount, Abs(PaymentLine.Amount) * -1);
                        InvPostingBuffer[1].Validate("Amount (LCY)", Abs(PaymentLine."Amount (LCY)") * -1);*/
                end;


                // <<IMS 07 06 2011 typ compte gen
                if PaymentLine.Commentaires <> '' then
                    InvPostingBuffer[1].Commentaires := PaymentLine.Commentaires;
                // HS Fix Retenue a la source entries
                if (StepLedger."Accounting Type" = StepLedger."accounting type"::"Header Payment Account") then begin
                    InvPostingBuffer[1]."Currency Code" := PaymentHeader."Currency Code";
                    InvPostingBuffer[1]."Currency Factor" := PaymentHeader."Currency Factor";
                end else begin
                    InvPostingBuffer[1]."Currency Code" := PaymentLine."Currency Code";
                    InvPostingBuffer[1]."Currency Factor" := PaymentLine."Currency Factor";
                end;
                InvPostingBuffer[1].Correction := PaymentLine.Correction xor Step.Correction;
                if StepLedger."Detail Level" = StepLedger."Detail Level"::Line then
                    InvPostingBuffer[1]."Payment Line No." := PaymentLine."Line No."
                else
                    if StepLedger."Detail Level" = StepLedger."Detail Level"::"Due Date" then
                        InvPostingBuffer[1]."Due Date" := PaymentLine."Due Date";

                InvPostingBuffer[1]."Document Type" := StepLedger."Document Type";
                if StepLedger."Document No." = StepLedger."Document No."::"Header No." then
                    InvPostingBuffer[1]."Document No." := PaymentHeader."No."
                else begin
                    if (InvPostingBuffer[1].Sign = InvPostingBuffer[1].Sign::Positive) and
                       (PaymentLine."Entry No. Debit" = 0) and (PaymentLine."Entry No. Credit" = 0)
                    then begin
                        PaymentClass.Get(PaymentHeader."Payment Class");
                        if PaymentClass."Line No. Series" = '' then
                            PaymentLine.TestField("Document No.", NoSeriesBatch.GetNextNo(PaymentHeader."No. Series", PaymentLine."Posting Date"))
                        else
                            PaymentLine.TestField("Document No.", NoSeriesBatch.GetNextNo(PaymentClass."Line No. Series", PaymentLine."Posting Date"));
                    end;
                    InvPostingBuffer[1]."Document No." := PaymentLine."Document No.";
                end;
                InvPostingBuffer[1]."Header Document No." := PaymentHeader."No.";
                if StepLedger.Sign = StepLedger.Sign::Debit then begin
                    EntryTypeDebit := InvPostingBuffer[1]."Account Type";
                    EntryNoAccountDebit := InvPostingBuffer[1]."Account No.";
                    EntryPostGroupDebit := InvPostingBuffer[1]."Posting Group";
                end else begin
                    EntryTypeCredit := InvPostingBuffer[1]."Account Type";
                    EntryNoAccountCredit := InvPostingBuffer[1]."Account No.";
                    EntryPostGroupCredit := InvPostingBuffer[1]."Posting Group";
                end;
                InvPostingBuffer[1]."System-Created Entry" := true;
                Application();
                PaymentClass.Get(PaymentHeader."Payment Class");
                if (PaymentClass."Unrealized VAT Reversal" = PaymentClass."Unrealized VAT Reversal"::Delayed) and
                   Step."Realize VAT"
                then begin
                    InvPostingBuffer[1]."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type";
                    InvPostingBuffer[1]."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                    if InvPostingBuffer[1]."Applies-to ID" = '' then
                        InvPostingBuffer[1]."Applies-to ID" := PaymentLine."Applies-to ID";
                    InvPostingBuffer[1]."Created from No." := PaymentLine."Created from No.";
                end;
                Description := GetDescriptionForInvPostingBuffer();
                OnGenerInvPostingBufferOnAfterGetDescriptionForInvPostingBuffer(StepLedger, PaymentHeader, PaymentLine, Description);
                InvPostingBuffer[1].Description := CopyStr(Description, 1, 50);
                InvPostingBuffer[1]."Source Type" := PaymentLine."Account Type";
                InvPostingBuffer[1]."Source No." := PaymentLine."Account No.";
                InvPostingBuffer[1]."External Document No." := PaymentLine."External Document No.";
                // HS Folio Fix 
                InvPostingBuffer[1].Salarie := PaymentLine.Salarié;
                // >> HJ SORO 23-02-2017
                /// InvPostingBuffer[1]."Affectation Fianciere" := PaymentLine."Affectation Financiere";
                // >> HJ SORO 23-02-2017
                // HS Folio Fix
                InvPostingBuffer[1]."Dimension Set ID" := PaymentLine."Dimension Set ID";
                OnGenerInvPostingBufferOnBeforeUpdtBuffer(InvPostingBuffer, PaymentLine, StepLedger);
                UpdtBuffer();
                if (InvPostingBuffer[1].Amount >= 0) xor InvPostingBuffer[1].Correction then
                    PaymentLine."Entry No. Debit" := InvPostingBuffer[1]."GL Entry No."
                else
                    PaymentLine."Entry No. Credit" := InvPostingBuffer[1]."GL Entry No.";
                GenererInv;
            until StepLedger.Next() = 0;
            NoSeriesBatch.SaveState();
        end;
    end;

    procedure geninv2()
    begin

        InvPostingBuffer[1].Correction := PaymentLine.Correction xor Step.Correction;
        if (StepLedger."Detail Level" = StepLedger."detail level"::Line) then
            InvPostingBuffer[1]."Payment Line No." := PaymentLine."Line No."
        else if (StepLedger."Detail Level" = StepLedger."detail level"::"Due Date") then
            InvPostingBuffer[1]."Due Date" := PaymentLine."Due Date";

        InvPostingBuffer[1]."Document Type" := StepLedger."Document Type";
        if StepLedger."Document No." = StepLedger."document no."::"Header No." then
            InvPostingBuffer[1]."Document No." := PaymentHeader."No."
        else begin
            if (InvPostingBuffer[1].Sign = InvPostingBuffer[1].Sign::Positive) and
               (PaymentLine."Entry No. Debit" = 0) and (PaymentLine."Entry No. Credit" = 0) then begin
                PaymentClass.Get(PaymentHeader."Payment Class");
                if PaymentClass."Line No. Series" = '' then
                    PaymentLine.TestField("Document No.", NoSeriesMgt.GetNextNo(PaymentHeader."No. Series", PaymentLine."Posting Date", false))

                /* ELSE
              IF NOT ((PaymentLine."Document ID"<>'') AND (PaymentLine."Status No.">10000)
              AND (StepLedger."Document No."=StepLedger."Document No."::"Document ID Line")) THEN
               PaymentLine."Document ID":=NoSeriesMgt.GetNextNo(PaymentClass."Line No. Series",PaymentLine."Posting Date",
                 FALSE);*/
            end;
            InvPostingBuffer[1]."Document No." := PaymentLine."Document No.";
        end;
        InvPostingBuffer[1]."Header Document No." := PaymentHeader."No.";
        if StepLedger.Sign = StepLedger.Sign::Debit then begin
            EntryTypeDebit := InvPostingBuffer[1]."Account Type";
            EntryNoAccountDebit := InvPostingBuffer[1]."Account No.";
            EntryPostGroupDebit := InvPostingBuffer[1]."Posting Group";
        end else begin
            EntryTypeCredit := InvPostingBuffer[1]."Account Type";
            EntryNoAccountCredit := InvPostingBuffer[1]."Account No.";
            EntryPostGroupCredit := InvPostingBuffer[1]."Posting Group";
        end;
        InvPostingBuffer[1]."System-Created Entry" := true;
        Application;
        InvPostingBuffer[1].Description :=
        /* StrSubstNo(StepLedger.Description, PaymentLine."External Document No.", PaymentLine."Due Date",
        PaymentLine."Account No.", PaymentLine.Libellé, PaymentHeader."Bank Name");*/
       StrSubstNo(/*StepLedger.Description, PaymentLine."External Document No.", PaymentLine."Due Date",
        PaymentLine."Account No.", */PaymentLine.Libellé/*, PaymentHeader."Bank Name"*/);


        /*STRSUBSTNO(StepLedger.Description,
             PaymentLine."Due Date",PaymentLine."Account No.",PaymentLine."Document No.",
             PaymentLine."External Document No.",PaymentLine.Commentaires);*/
        InvPostingBuffer[1]."Source Type" := PaymentLine."Account Type";
        InvPostingBuffer[1]."Source No." := PaymentLine."Account No.";
        InvPostingBuffer[1]."External Document No." := PaymentLine."External Document No.";
        InvPostingBuffer[1]."Global Dimension 1 Code" := PaymentHeader."Shortcut Dimension 1 Code";
        InvPostingBuffer[1]."Global Dimension 2 Code" := PaymentHeader."Shortcut Dimension 2 Code";
        // TempDocDim.SetRange("Table ID",Database::"Payment Line");
        // TempDocDim.SetRange("Line No.",PaymentLine."Line No.");
        UpdtBuffer;

    end;

    procedure GenererInv()
    var
        PaymentClass: Record "Payment Class";
        StepLedgerTmp: Record "Payment Step Ledger";
    //  GroupeRetenu: Record 50002;
    begin
        if (StepLedger."Compta. Retenue à la source") then begin
            /*  Clear(GroupeRetenu);
              GroupeRetenu.Reset;
              InvPostingBuffer[1].Init;
              InvPostingBuffer[1]."System-Created Entry" := true;
              if GroupeRetenu.Get(0, PaymentLine."Code Retenue à la Source") then;
              InvPostingBuffer[1]."Account Type" := 0;
              InvPostingBuffer[1].Validate("Account No.", GroupeRetenu."Compte Retenue");*/
            InvPostingBuffer[1]."Currency Code" := PaymentLine."Currency Code";
            InvPostingBuffer[1]."Currency Factor" := PaymentLine."Currency Factor";

            InvPostingBuffer[1].Validate(Amount, PaymentLine."Montant Retenue");

            InvPostingBuffer[1].Validate("Amount (LCY)", PaymentLine."Montant Retenue DS");
            InvPostingBuffer[1]."Applies-to ID" := '';
            if InvPostingBuffer[1].Amount <> 0 then
                geninv2;

        end;
        if StepLedger."Annuler Compta Retn. à la Sour" then begin
            /*     Clear(GroupeRetenu);
                 GroupeRetenu.Reset;
                 InvPostingBuffer[1].Init;
                 InvPostingBuffer[1]."System-Created Entry" := true;
                 if GroupeRetenu.Get(0, PaymentLine."Code Retenue à la Source") then;*/
            InvPostingBuffer[1]."Account Type" := 0;
            InvPostingBuffer[1]."Currency Code" := PaymentLine."Currency Code";
            InvPostingBuffer[1]."Currency Factor" := PaymentLine."Currency Factor";

            // InvPostingBuffer[1].Validate("Account No.", GroupeRetenu."Compte Retenue");
            InvPostingBuffer[1].Validate(Amount, -PaymentLine."Montant Retenue Validé");
            InvPostingBuffer[1].Validate("Amount (LCY)", -PaymentLine."Montant Retenue Validé DS");
            InvPostingBuffer[1]."Applies-to ID" := '';
            //GL2024  Message('%1  %2', format(InvPostingBuffer[1].amount), format(InvPostingBuffer[1]."Amount (LCY)"));
            if InvPostingBuffer[1].Amount <> 0 then
                geninv2;
        end;

        if StepLedger."Retenue sur Garantie" then begin
            // Clear(GroupeRetenu);
            //  GroupeRetenu.Reset;
            InvPostingBuffer[1].Init;
            InvPostingBuffer[1]."System-Created Entry" := true;
            //  if GroupeRetenu.Get(1, PaymentLine."Code Retenue de Garantie") then;
            InvPostingBuffer[1]."Account Type" := 0;
            //  InvPostingBuffer[1].Validate("Account No.", GroupeRetenu."Compte Retenue");
            InvPostingBuffer[1]."Currency Code" := PaymentLine."Currency Code";
            InvPostingBuffer[1]."Currency Factor" := PaymentLine."Currency Factor";

            InvPostingBuffer[1].Validate(Amount, PaymentLine."Montant Retenue G.");
            InvPostingBuffer[1].Validate("Amount (LCY)", PaymentLine."Montant Retenue G. DS");
            if InvPostingBuffer[1].Amount <> 0 then
                geninv2;
        end;

        if StepLedger."Compta. Retenue Sur TVA" then begin
            InvPostingBuffer[1].Init;
            InvPostingBuffer[1]."Account Type" := 0;
            InvPostingBuffer[1]."System-Created Entry" := true;
            InvPostingBuffer[1].Validate("Account No.", StepLedger."Compte Retenue Sur TVA");
            InvPostingBuffer[1]."Currency Code" := PaymentLine."Currency Code";
            InvPostingBuffer[1]."Currency Factor" := PaymentLine."Currency Factor";

            InvPostingBuffer[1].Validate(Amount, PaymentLine."Montant Retenue TVA");
            InvPostingBuffer[1].Validate("Amount (LCY)", PaymentLine."Montant Retenue TVA DS");
            InvPostingBuffer[1]."Applies-to ID" := '';
            if InvPostingBuffer[1].Amount <> 0 then
                geninv2;

        end;
        if (StepLedger."Inclure Commission") and (StepLedger."Compte Commission" <> '') then begin
            InvPostingBuffer[1].Init;
            InvPostingBuffer[1]."Account Type" := 0;
            InvPostingBuffer[1]."System-Created Entry" := true;
            InvPostingBuffer[1].Validate("Account No.", StepLedger."Compte Commission");
            Clear(InvPostingBuffer[1]."Currency Code");
            //InvPostingBuffer[1]."Currency Factor" := 1;
            ////////////////DEVIIIIIIIISE/////////////////
            //InvPostingBuffer[1]."Currency Factor" := 1;
            if PaymentLine."Currency Code" <> '' then begin
                InvPostingBuffer[1]."Currency Factor" := PaymentLine."Currency Factor";
                InvPostingBuffer[1]."Currency Code" := PaymentLine."Currency Code";
            end else
                InvPostingBuffer[1]."Currency Factor" := 1;
            /////////////////////////////////////////////

            InvPostingBuffer[1].Validate(Amount, PaymentLine."Montant Commission");
            InvPostingBuffer[1].Validate("Amount (LCY)", PaymentLine."Montant Commission DS");
            InvPostingBuffer[1]."Applies-to ID" := '';
            if InvPostingBuffer[1].Amount <> 0 then
                geninv2;

        end;
        if (StepLedger."Inclure Commission") and (StepLedger."Compte TVA/Commission" <> '') then begin
            InvPostingBuffer[1].Init;
            InvPostingBuffer[1]."Account Type" := 0;
            InvPostingBuffer[1]."System-Created Entry" := true;
            InvPostingBuffer[1].Validate("Account No.", StepLedger."Compte TVA/Commission");
            Clear(InvPostingBuffer[1]."Currency Code");
            //InvPostingBuffer[1]."Currency Factor" := 1;
            ////////////////DEVIIIIIIIISE/////////////////
            //InvPostingBuffer[1]."Currency Factor" := 1;
            if PaymentLine."Currency Code" <> '' then begin
                InvPostingBuffer[1]."Currency Factor" := PaymentLine."Currency Factor";
                InvPostingBuffer[1]."Currency Code" := PaymentLine."Currency Code";
            end else
                InvPostingBuffer[1]."Currency Factor" := 1;
            /////////////////////////////////////////////

            InvPostingBuffer[1].Validate(Amount, PaymentLine."Montant TVA sur Commission");
            InvPostingBuffer[1].Validate("Amount (LCY)", PaymentLine."Montant TVA sur Commission DS");
            InvPostingBuffer[1]."Applies-to ID" := '';
            if InvPostingBuffer[1].Amount <> 0 then
                geninv2;
        end;
        //>> IMS 11 05 2011 INTERET FED
        if (StepLedger."Inclure IntérêtFED") and (StepLedger."Compte Intérêt FED" <> '') then begin
            InvPostingBuffer[1].Init;
            InvPostingBuffer[1]."Account Type" := 0;
            InvPostingBuffer[1]."System-Created Entry" := true;
            InvPostingBuffer[1].Validate("Account No.", StepLedger."Compte Intérêt FED");
            Clear(InvPostingBuffer[1]."Currency Code");
            // InvPostingBuffer[1]."Currency Factor" := 1;
            ////////////////DEVIIIIIIIISE/////////////////
            //InvPostingBuffer[1]."Currency Factor" := 1;
            if PaymentLine."Currency Code" <> '' then begin
                InvPostingBuffer[1]."Currency Factor" := PaymentLine."Currency Factor";
                InvPostingBuffer[1]."Currency Code" := PaymentLine."Currency Code";
            end else
                InvPostingBuffer[1]."Currency Factor" := 1;
            /////////////////////////////////////////////

            InvPostingBuffer[1].Validate(Amount, PaymentLine."Intérêt FED");
            InvPostingBuffer[1].Validate("Amount (LCY)", PaymentLine."Intérêt FED (DS)");
            InvPostingBuffer[1]."Applies-to ID" := '';
            if InvPostingBuffer[1].Amount <> 0 then
                geninv2;

        end;
        //>> IMS 11 05 2011 INTERET FED

        //>> IMS 11 05 2011 INTERET ESCOMPTE
        if (StepLedger."Inclure Intérêt Escompte") and (StepLedger."Compte Intérêt Escompte" <> '') then begin
            InvPostingBuffer[1].Init;
            InvPostingBuffer[1]."Account Type" := 0;
            InvPostingBuffer[1]."System-Created Entry" := true;
            InvPostingBuffer[1].Validate("Account No.", StepLedger."Compte Intérêt Escompte");
            Clear(InvPostingBuffer[1]."Currency Code");
            //InvPostingBuffer[1]."Currency Factor" := 1;
            ////////////////DEVIIIIIIIISE/////////////////
            //InvPostingBuffer[1]."Currency Factor" := 1;
            if PaymentLine."Currency Code" <> '' then begin
                InvPostingBuffer[1]."Currency Factor" := PaymentLine."Currency Factor";
                InvPostingBuffer[1]."Currency Code" := PaymentLine."Currency Code";
            end else
                InvPostingBuffer[1]."Currency Factor" := 1;
            /////////////////////////////////////////////

            InvPostingBuffer[1].Validate(Amount, PaymentLine."Intérêt Escompte");
            InvPostingBuffer[1].Validate("Amount (LCY)", PaymentLine."Intérêt Escompte (DS)");
            InvPostingBuffer[1]."Applies-to ID" := '';
            if InvPostingBuffer[1].Amount <> 0 then
                geninv2;

        end;
        //>> IMS 11 05 2011 INTERET ESCOMPTE
        //>> IMS 02 06 2011 INTERET SUR PRET
        if (StepLedger."Inclure Interêt sur Prêt") and (StepLedger."Compte Intérêt sur Prêt" <> '') then begin
            InvPostingBuffer[1].Init;
            InvPostingBuffer[1]."Account Type" := 0;
            InvPostingBuffer[1]."System-Created Entry" := true;
            InvPostingBuffer[1].Validate("Account No.", StepLedger."Compte Intérêt sur Prêt");
            Clear(InvPostingBuffer[1]."Currency Code");
            ////////////////DEVIIIIIIIISE/////////////////
            //InvPostingBuffer[1]."Currency Factor" := 1;
            if PaymentLine."Currency Code" <> '' then begin
                InvPostingBuffer[1]."Currency Factor" := PaymentLine."Currency Factor";
                InvPostingBuffer[1]."Currency Code" := PaymentLine."Currency Code";
            end else
                InvPostingBuffer[1]."Currency Factor" := 1;
            /////////////////////////////////////////////
            InvPostingBuffer[1].Validate(Amount, PaymentLine."Intérêt sur Prêt");
            InvPostingBuffer[1].Validate("Amount (LCY)", PaymentLine."Intérêt sur Prêt (DS)");
            InvPostingBuffer[1]."Applies-to ID" := '';
            if InvPostingBuffer[1].Amount <> 0 then
                geninv2;
        end;
        //>> IMS 02 06 2011 INTERET SUR PRET
    end;

    local procedure GetDescriptionForInvPostingBuffer() Description: Text[98]
    begin
        Description :=
                StrSubstNo(PaymentLine.Libellé);


        /*   Description := STRSUBSTNO(StepLedger.Description, PaymentLine."External Document No.", PaymentLine."Due Date",
           PaymentLine.Libellé, PaymentLine."Account No.", PaymentHeader."Bank Name", PaymentHeader."No.", PaymentHeader."Account No."
          , PaymentLine."Bank Account Code");*/


        OnAfterGetDescriptionForInvPostingBuffer(StepLedger, PaymentLine, Description);
    end;


    procedure SetPostingGroup()
    var
        PostingGroup: Code[20];
    begin
        if PaymentLine."Account Type" = PaymentLine."Account Type"::Customer then
            if ((StepLedger."Accounting Type" = StepLedger."Accounting Type"::"Payment Line Account") or
                (StepLedger."Accounting Type" = StepLedger."Accounting Type"::"Associated G/L Account") or
                (StepLedger."Accounting Type" = StepLedger."Accounting Type"::"Header Payment Account") or
                ((StepLedger."Accounting Type" = StepLedger."Accounting Type"::"Setup Account") and
                 (StepLedger."Account Type" = StepLedger."Account Type"::Customer)))
            then begin
                if PaymentLine."Posting Group" <> '' then
                    PostingGroup := PaymentLine."Posting Group"
                else
                    if StepLedger."Customer Posting Group" <> '' then
                        PostingGroup := StepLedger."Customer Posting Group"
                    else begin
                        Customer.Get(PaymentLine."Account No.");
                        PostingGroup := Customer."Customer Posting Group";
                    end;
                OnSetPostingGroupOnBeforeCheckPostingGroup(PaymentLine, StepLedger, PostingGroup);
                if not CustomerPostingGroup.Get(PostingGroup) then
                    Error(Text012, PostingGroup);
                if CustomerPostingGroup."Receivables Account" = '' then
                    Error(Text014, PostingGroup);
            end;

        if PaymentLine."Account Type" = PaymentLine."Account Type"::Vendor then
            if ((StepLedger."Accounting Type" = StepLedger."Accounting Type"::"Payment Line Account") or
                (StepLedger."Accounting Type" = StepLedger."Accounting Type"::"Associated G/L Account") or
                (StepLedger."Accounting Type" = StepLedger."Accounting Type"::"Header Payment Account") or
                ((StepLedger."Accounting Type" = StepLedger."Accounting Type"::"Setup Account") and
                 (StepLedger."Account Type" = StepLedger."Account Type"::Vendor)))
            then begin
                if PaymentLine."Posting Group" <> '' then
                    PostingGroup := PaymentLine."Posting Group"
                else
                    if StepLedger."Vendor Posting Group" <> '' then
                        PostingGroup := StepLedger."Vendor Posting Group"
                    else begin
                        Vendor.Get(PaymentLine."Account No.");
                        PostingGroup := Vendor."Vendor Posting Group";
                    end;
                if not VendorPostingGroup.Get(PostingGroup) then
                    Error(Text012, PostingGroup);
                if VendorPostingGroup."Payables Account" = '' then
                    Error(Text014, PostingGroup);
            end;
    end;


    procedure SetAccountNo()
    begin
        case StepLedger."Accounting Type" of
            StepLedger."Accounting Type"::"Payment Line Account":
                begin
                    InvPostingBuffer[1]."Account Type" := PaymentLine."Account Type";
                    InvPostingBuffer[1]."Account No." := PaymentLine."Account No.";
                    if PaymentLine."Account Type" = PaymentLine."Account Type"::Customer then
                        InvPostingBuffer[1]."Posting Group" := CustomerPostingGroup.Code;
                    if PaymentLine."Account Type" = PaymentLine."Account Type"::Vendor then
                        InvPostingBuffer[1]."Posting Group" := VendorPostingGroup.Code;
                    InvPostingBuffer[1]."Line No." := PaymentLine."Line No.";
                    DimMgt.UpdateGlobalDimFromDimSetID(PaymentLine."Dimension Set ID",
                      InvPostingBuffer[1]."Global Dimension 1 Code", InvPostingBuffer[1]."Global Dimension 2 Code");
                end;
            StepLedger."Accounting Type"::"Associated G/L Account":
                begin
                    InvPostingBuffer[1]."Account Type" := InvPostingBuffer[1]."Account Type"::"G/L Account";
                    if PaymentLine."Account Type" = PaymentLine."Account Type"::Customer then
                        InvPostingBuffer[1]."Account No." := CustomerPostingGroup."Receivables Account"
                    else
                        InvPostingBuffer[1]."Account No." := VendorPostingGroup."Payables Account";
                    InvPostingBuffer[1]."Line No." := PaymentLine."Line No.";
                end;
            StepLedger."Accounting Type"::"Setup Account":
                begin
                    InvPostingBuffer[1]."Account Type" := StepLedger."Account Type";
                    InvPostingBuffer[1]."Account No." := StepLedger."Account No.";
                    if StepLedger."Account No." = '' then begin
                        PaymentHeader.CalcFields("Payment Class Name");
                        if StepLedger.Sign = StepLedger.Sign::Debit then
                            Error(Text018, Step.Name, PaymentHeader."Payment Class Name");

                        Error(Text019, Step.Name, PaymentHeader."Payment Class Name");
                    end;
                    if StepLedger."Account Type" = StepLedger."Account Type"::Customer then
                        InvPostingBuffer[1]."Posting Group" := StepLedger."Customer Posting Group"
                    else
                        InvPostingBuffer[1]."Posting Group" := StepLedger."Vendor Posting Group";
                    InvPostingBuffer[1]."Line No." := PaymentLine."Line No.";
                end;
            StepLedger."Accounting Type"::"G/L Account / Month":
                begin
                    InvPostingBuffer[1]."Account Type" := InvPostingBuffer[1]."Account Type"::"G/L Account";
                    N := Date2DMY(PaymentLine."Due Date", 2);
                    if N < 10 then
                        Suffix := '0' + Format(N)
                    else
                        Suffix := Format(N);
                    InvPostingBuffer[1]."Account No." := CopyStr(StepLedger.Root + Suffix, 1, MaxStrLen(InvPostingBuffer[1]."Account No."));
                    InvPostingBuffer[1]."Line No." := PaymentLine."Line No.";
                end;
            StepLedger."Accounting Type"::"G/L Account / Week":
                begin
                    InvPostingBuffer[1]."Account Type" := InvPostingBuffer[1]."Account Type"::"G/L Account";
                    N := Date2DWY(PaymentLine."Due Date", 2);
                    if N < 10 then
                        Suffix := '0' + Format(N)
                    else
                        Suffix := Format(N);
                    InvPostingBuffer[1]."Account No." := CopyStr(StepLedger.Root + Suffix, 1, MaxStrLen(InvPostingBuffer[1]."Account No."));
                    InvPostingBuffer[1]."Line No." := PaymentLine."Line No.";
                end;
            StepLedger."Accounting Type"::"Bal. Account Previous Entry":
                begin
                    if (StepLedger.Sign = StepLedger.Sign::Debit) and not (PaymentLine.Correction xor Step.Correction) then begin
                        InvPostingBuffer[1]."Account Type" := PaymentLine."Acc. Type Last Entry Credit";
                        InvPostingBuffer[1]."Account No." := PaymentLine."Acc. No. Last Entry Credit";
                        InvPostingBuffer[1]."Posting Group" := PaymentLine."P. Group Last Entry Credit";
                    end else begin
                        InvPostingBuffer[1]."Account Type" := PaymentLine."Acc. Type Last Entry Debit";
                        InvPostingBuffer[1]."Account No." := PaymentLine."Acc. No. Last Entry Debit";
                        InvPostingBuffer[1]."Posting Group" := PaymentLine."P. Group Last Entry Debit";
                    end;
                    InvPostingBuffer[1]."Line No." := PaymentLine."Line No.";
                end;
            StepLedger."Accounting Type"::"Header Payment Account":
                begin
                    InvPostingBuffer[1]."Account Type" := PaymentHeader."Account Type";
                    InvPostingBuffer[1]."Account No." := PaymentHeader."Account No.";
                    if PaymentHeader."Account No." = '' then
                        Error(Text020);
                    if StepLedger."Detail Level" = StepLedger."Detail Level"::Account then
                        HeaderAccountUsedGlobally := true;
                    InvPostingBuffer[1]."Line No." := 0;
                    DimMgt.UpdateGlobalDimFromDimSetID(PaymentHeader."Dimension Set ID",
                      InvPostingBuffer[1]."Global Dimension 1 Code", InvPostingBuffer[1]."Global Dimension 2 Code");
                end;
        end;
    end;


    procedure Application()
    begin
        if StepLedger.Application <> StepLedger.Application::None then
            if StepLedger.Application = StepLedger.Application::"Applied Entry" then begin
                InvPostingBuffer[1]."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type";
                InvPostingBuffer[1]."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                InvPostingBuffer[1]."Applies-to ID" := PaymentLine."Applies-to ID";
            end else
                if StepLedger.Application = StepLedger.Application::"Entry Previous Step" then begin
                    InvPostingBuffer[1]."Applies-to ID" := PaymentLine."No." + '/' + Format(PaymentLine."Line No.") + Text011;
                    if InvPostingBuffer[1]."Account Type" = InvPostingBuffer[1]."Account Type"::Customer then begin
                        if (InvPostingBuffer[1].Amount < 0) xor InvPostingBuffer[1].Correction then
                            CustLedgerEntry.SetRange("Entry No.", OldPaymentLine."Entry No. Debit")
                        else
                            CustLedgerEntry.SetRange("Entry No.", OldPaymentLine."Entry No. Credit");
                        if CustLedgerEntry.FindFirst() then begin
                            CustLedgerEntry."Applies-to ID" := InvPostingBuffer[1]."Applies-to ID";
                            CustLedgerEntry.CalcFields("Remaining Amount");
                            CustLedgerEntry.Validate("Amount to Apply", CustLedgerEntry."Remaining Amount");
                            CustLedgerEntry.Modify();
                        end;
                    end else
                        if InvPostingBuffer[1]."Account Type" = InvPostingBuffer[1]."Account Type"::Vendor then begin
                            if (InvPostingBuffer[1].Amount < 0) xor InvPostingBuffer[1].Correction then
                                VendorLedgerEntry.SetRange("Entry No.", OldPaymentLine."Entry No. Debit")
                            else
                                VendorLedgerEntry.SetRange("Entry No.", OldPaymentLine."Entry No. Credit");
                            if VendorLedgerEntry.FindFirst() then begin
                                VendorLedgerEntry."Applies-to ID" := InvPostingBuffer[1]."Applies-to ID";
                                VendorLedgerEntry.CalcFields("Remaining Amount");
                                VendorLedgerEntry.Validate("Amount to Apply", VendorLedgerEntry."Remaining Amount");
                                VendorLedgerEntry.Modify();
                            end;
                        end;
                end else
                    if StepLedger.Application = StepLedger.Application::"Memorized Entry" then begin
                        InvPostingBuffer[1]."Applies-to ID" := PaymentLine."No." + '/' + Format(PaymentLine."Line No.") + Text011;
                        if InvPostingBuffer[1]."Account Type" = InvPostingBuffer[1]."Account Type"::Customer then begin
                            CustLedgerEntry.Reset();
                            if (InvPostingBuffer[1].Amount < 0) xor InvPostingBuffer[1].Correction then
                                CustLedgerEntry.SetRange("Entry No.", OldPaymentLine."Entry No. Debit Memo")
                            else
                                CustLedgerEntry.SetRange("Entry No.", OldPaymentLine."Entry No. Credit Memo");
                            if CustLedgerEntry.FindFirst() then begin
                                CustLedgerEntry."Applies-to ID" := InvPostingBuffer[1]."Applies-to ID";
                                CustLedgerEntry.CalcFields("Remaining Amount");
                                CustLedgerEntry.Validate("Amount to Apply", CustLedgerEntry."Remaining Amount");
                                CustLedgerEntry.Modify();
                            end;
                        end else
                            if InvPostingBuffer[1]."Account Type" = InvPostingBuffer[1]."Account Type"::Vendor then begin
                                if (InvPostingBuffer[1].Amount < 0) xor InvPostingBuffer[1].Correction then
                                    VendorLedgerEntry.SetRange("Entry No.", OldPaymentLine."Entry No. Debit Memo")
                                else
                                    VendorLedgerEntry.SetRange("Entry No.", OldPaymentLine."Entry No. Credit Memo");
                                if VendorLedgerEntry.FindFirst() then begin
                                    VendorLedgerEntry."Applies-to ID" := InvPostingBuffer[1]."Applies-to ID";
                                    VendorLedgerEntry.CalcFields("Remaining Amount");
                                    VendorLedgerEntry.Validate("Amount to Apply", VendorLedgerEntry."Remaining Amount");
                                    VendorLedgerEntry.Modify();
                                end;
                            end;
                    end;
        if StepLedger."Detail Level" = StepLedger."Detail Level"::Account then begin
            if (InvPostingBuffer[1]."Account Type" = InvPostingBuffer[1]."Account Type"::Vendor) or
               (InvPostingBuffer[1]."Account Type" = InvPostingBuffer[1]."Account Type"::Customer)
            then
                InvPostingBuffer[1]."Due Date" := PaymentLine."Due Date" // FR Payment due date
        end else
            InvPostingBuffer[1]."Due Date" := PaymentLine."Due Date"; // FR Payment due date

        OnAfterApplication(StepLedger, InvPostingBuffer, PaymentHeader, PaymentLine);
    end;


    procedure GenerEntries()
    var
        Currency: Record Currency;
        Difference: Decimal;
        TotalDebit: Decimal;
        TotalCredit: Decimal;
        LastGLEntryNo: Integer;
        PaymentLineTmp: Record "Payment Line";
    begin
        if InvPostingBuffer[1].Find('+') then
            repeat
                LastGLEntryNo := PostInvPostingBuffer();
                PaymentLine.Reset();
                PaymentLine.SetRange("No.", PaymentHeader."No.");
                PaymentLine.SetRange("Line No.");
                if GenJnlLine.Amount >= 0 then begin
                    TotalDebit := TotalDebit + GenJnlLine."Amount (LCY)";
                    StepLedger.Get(Step."Payment Class", Step.Line, StepLedger.Sign::Debit);
                    PaymentLine.SetRange("Entry No. Debit", InvPostingBuffer[1]."GL Entry No.");
                    if StepLedger."Memorize Entry" then
                        PaymentLine.ModifyAll(PaymentLine."Entry No. Debit Memo", LastGLEntryNo);
                    PaymentLine.ModifyAll("Entry No. Debit", LastGLEntryNo);
                    PaymentLine.SetRange("Entry No. Debit");
                end else begin
                    TotalCredit := TotalCredit + Abs(GenJnlLine."Amount (LCY)");
                    StepLedger.Get(Step."Payment Class", Step.Line, StepLedger.Sign::Credit);
                    PaymentLine.SetRange("Entry No. Credit", InvPostingBuffer[1]."GL Entry No.");
                    if StepLedger."Memorize Entry" then
                        PaymentLine.ModifyAll(PaymentLine."Entry No. Credit Memo", LastGLEntryNo);
                    PaymentLine.ModifyAll("Entry No. Credit", LastGLEntryNo);
                    PaymentLine.SetRange("Entry No. Credit");
                end;
                PaymentLineTmp.Reset;
                PaymentLineTmp.SetRange("No.", PaymentHeader."No.");
                PaymentLineTmp.SetRange("Line No.");
                if PaymentLineTmp.Find('-') then
                    repeat
                        if (PaymentLineTmp."Montant Retenue" <> 0) and
                           (StepLedger."Compta. Retenue à la source") then begin
                            PaymentLineTmp."Montant Retenue Validé" := PaymentLineTmp."Montant Retenue";
                            PaymentLineTmp."Montant Retenue Validé DS" := PaymentLineTmp."Montant Retenue DS";
                            PaymentLineTmp."Montant Retenue" := 0;
                            PaymentLineTmp."Montant Retenue DS" := 0;
                            PaymentLineTmp.Modify;
                        end;
                        if (PaymentLineTmp."Montant Retenue Validé" <> 0) and
                           (StepLedger."Annuler Compta Retn. à la Sour") then begin
                            PaymentLineTmp."Montant Retenue" := PaymentLineTmp."Montant Retenue Validé";
                            PaymentLineTmp."Montant Retenue DS" := PaymentLineTmp."Montant Retenue Validé DS";
                            PaymentLineTmp."Montant Retenue Validé" := 0;
                            PaymentLineTmp."Montant Retenue Validé DS" := 0;
                            PaymentLineTmp.Modify;
                        end;

                        if PaymentLine."Montant Retenue TVA" <> 0 then begin
                            PaymentLine."Montant Retenue TVA Validé" := PaymentLine."Montant Retenue TVA";
                            PaymentLine."Montant Retenue TVA Validé DS" := PaymentLine."Montant Retenue TVA DS";
                            PaymentLine."Montant Retenue TVA" := 0;
                            PaymentLine."Montant Retenue TVA DS" := 0;
                            PaymentLineTmp.Modify;
                        end;
                        if PaymentLine."Montant Commission" <> 0 then begin
                            PaymentLine."Montant Commission Validé" := PaymentLine."Montant Commission";
                            PaymentLine."Montant Commission Validé DS" := PaymentLine."Montant Commission DS";
                            PaymentLine."Montant Commission" := 0;
                            PaymentLine."Montant Commission DS" := 0;
                            PaymentLineTmp.Modify;
                        end;
                        if PaymentLine."Montant TVA sur Commission" <> 0 then begin
                            PaymentLine."Montant TVA sur Com. validé" := PaymentLine."Montant TVA sur Commission";
                            PaymentLine."Montant TVA sur Com. validé DS" := PaymentLine."Montant TVA sur Commission DS";
                            PaymentLine."Montant TVA sur Commission" := 0;
                            PaymentLine."Montant TVA sur Commission DS" := 0;
                            PaymentLineTmp.Modify;
                        end;
                        //>> IMS 11 05 2011 INTERET FED / ESCOMPTE
                        if PaymentLine."Intérêt FED" <> 0 then begin
                            PaymentLine."Intérêt FED Validé" := PaymentLine."Intérêt FED";
                            PaymentLine."Intérêt FED (DS) validé" := PaymentLine."Intérêt FED (DS)";
                            PaymentLine."Intérêt FED" := 0;
                            PaymentLine."Intérêt FED (DS)" := 0;
                            PaymentLineTmp.Modify;
                        end;
                        if PaymentLine."Intérêt Escompte" <> 0 then begin
                            PaymentLine."Intérêt Escompte validé" := PaymentLine."Intérêt Escompte";
                            PaymentLine."Intérêt Escompte (DS) validé" := PaymentLine."Intérêt Escompte (DS)";
                            PaymentLine."Intérêt Escompte" := 0;
                            PaymentLine."Intérêt Escompte (DS)" := 0;
                            PaymentLineTmp.Modify;
                        end;
                        //>> IMS 02 06 2011 INTERET SUR PRET
                        if PaymentLine."Intérêt sur Prêt" <> 0 then begin
                            PaymentLine."Intérêt sur Prêt Validé" := PaymentLine."Intérêt sur Prêt";
                            PaymentLine."Intérêt sur Prêt (DS) validé" := PaymentLine."Intérêt sur Prêt (DS)";
                            PaymentLine."Intérêt sur Prêt" := 0;
                            PaymentLine."Intérêt sur Prêt (DS)" := 0;
                            PaymentLineTmp.Modify;
                        end;
                        //<< IMS 02 06 2011 INTERET SUR PRET
                        //<< IMS 11 05 2011 INTERET FED / ESCOMPTE

                        if PaymentLine."Montant Retenue G." <> 0 then begin
                            PaymentLine."Montant Retenue G. Validé" := PaymentLine."Montant Retenue G.";
                            PaymentLine."Montant Retenue G. Validé DS" := PaymentLine."Montant Retenue G. DS";
                            PaymentLineTmp.Modify;
                        end;

                    until PaymentLineTmp.Next = 0;

            until InvPostingBuffer[1].Next(-1) = 0;

        if HeaderAccountUsedGlobally then begin
            Difference := TotalDebit - TotalCredit;
            if Difference <> 0 then begin
                GenJnlLine.Init();
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                Currency.Get(PaymentHeader."Currency Code");
                if Difference < 0 then begin
                    GenJnlLine."Account No." := Currency."Unrealized Losses Acc.";
                    StepLedger.Get(Step."Payment Class", Step.Line, StepLedger.Sign::Debit);
                    GenJnlLine.Validate("Debit Amount", -Difference);
                end else begin
                    GenJnlLine."Account No." := Currency."Unrealized Gains Acc.";
                    StepLedger.Get(Step."Payment Class", Step.Line, StepLedger.Sign::Credit);
                    GenJnlLine.Validate("Credit Amount", Difference);
                end;
                GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                GenJnlLine."Document No." := PaymentHeader."No.";
                GenJnlLine.Description := StrSubstNo(
                  Text100, StrSubstNo(StepLedger.Description, PaymentHeader."Document Date", '', PaymentHeader."No."));
                GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Shortcut Dimension 1 Code";
                GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Shortcut Dimension 2 Code";
                GenJnlLine."Dimension Set ID" := PaymentHeader."Dimension Set ID";
                GenJnlLine."Source Code" := PaymentHeader."Source Code";
                GenJnlLine."Reason Code" := Step."Reason Code";
                GenJnlLine."Document Date" := PaymentHeader."Document Date";
                GenJnlLine."N° Bordereau" := Folio;
                OnGenerEntriesOnBeforeGenJnlPostLineRunWithCheck(GenJnlLine, PaymentHeader, StepLedger);
                GenJnlPostLine.RunWithCheck(GenJnlLine);
            end;
        end;

        InvPostingBuffer[1].DeleteAll();
    end;

    local procedure GetIntegerPos(No: Code[20]; var StartPos: Integer; var EndPos: Integer)
    var
        IsDigit: Boolean;
        i: Integer;
    begin
        StartPos := 0;
        EndPos := 0;
        if No <> '' then begin
            i := StrLen(No);
            repeat
                IsDigit := No[i] in ['0' .. '9'];
                if IsDigit then begin
                    if EndPos = 0 then
                        EndPos := i;
                    StartPos := i;
                end;
                i := i - 1;
            until (i = 0) or (StartPos <> 0) and not IsDigit;
        end;
        if (StartPos = 0) and (EndPos = 0) then
            Error(Text021, No);
    end;


    procedure IncrementNoText(var No: Code[20]; IncrementByNo: Decimal)
    var
        DecimalNo: Decimal;
        StartPos: Integer;
        EndPos: Integer;
        NewNo: Text[30];
    begin
        GetIntegerPos(No, StartPos, EndPos);
        Evaluate(DecimalNo, CopyStr(No, StartPos, EndPos - StartPos + 1));
        NewNo := Format(DecimalNo + IncrementByNo, 0, 1);
        ReplaceNoText(No, NewNo, 0, StartPos, EndPos);
    end;

    local procedure ReplaceNoText(var No: Code[20]; NewNo: Code[30]; FixedLength: Integer; StartPos: Integer; EndPos: Integer)
    var
        StartNo: Code[20];
        EndNo: Code[20];
        ZeroNo: Code[20];
        NewLength: Integer;
        OldLength: Integer;
    begin
        if StartPos > 1 then
            StartNo := CopyStr(No, 1, StartPos - 1);
        if EndPos < StrLen(No) then
            EndNo := CopyStr(No, EndPos + 1);
        NewLength := StrLen(NewNo);
        OldLength := EndPos - StartPos + 1;
        if FixedLength > OldLength then
            OldLength := FixedLength;
        if OldLength > NewLength then
            ZeroNo := PadStr('', OldLength - NewLength, '0');
        if StrLen(StartNo) + StrLen(ZeroNo) + StrLen(NewNo) + StrLen(EndNo) > 20 then
            Error(Text001, No);

        No := CopyStr(StartNo + ZeroNo + NewNo + EndNo, 1, MaxStrLen(No));
    end;


    procedure CreatePaymentHeaders()
    begin
        Step.SetRange("Action Type", Step."Action Type"::"Create New Document");

        if StepSelect('', -1, Step, true) then
            ExecuteCreatePaymtHead(Step);
    end;


    procedure ExecuteCreatePaymtHead(PaymtStep: Record "Payment Step"): Code[20]
    var
        Bor: Record "Payment Header";
        StatementForm: Page "Payment Slip";
        InserForm: Page "Payment Lines List";
        PayNum: Code[20];
    begin
        PaymentLine.SetRange("Payment Class", PaymtStep."Payment Class");
        PaymentLine.SetRange("Status No.", PaymtStep."Previous Status");
        PaymentLine.SetRange("Copied To No.", '');
        PaymentLine.FilterGroup(2);
        //GL2024   InserForm.SetSteps(PaymtStep.Line);
        InserForm.SetTableView(PaymentLine);
        InserForm.LookupMode(true);
        InserForm.RunModal();
        //GL2024      PayNum := InserForm.GetNumBor();
        if Bor.Get(PayNum) then begin
            StatementForm.SetRecord(Bor);
            StatementForm.Run();
        end else
            Error(Text004);
        exit(PayNum);
    end;


    procedure LinesInsert(HeaderNumber: Code[20])
    var
        Header: Record "Payment Header";
        PaymentLine: Record "Payment Line";
        Step: Record "Payment Step";
        InserForm: Page "Payment Lines List";
    begin
        Header.Get(HeaderNumber);
        if StepSelect(Header."Payment Class", Header."Status No.", Step, false) then begin
            PaymentLine.SetRange("Payment Class", Header."Payment Class");
            PaymentLine.SetRange("Copied To No.", '');
            PaymentLine.SetFilter("Status No.", Format(Step."Previous Status"));
            PaymentLine.SetRange("Currency Code", Header."Currency Code");
            PaymentLine.FilterGroup(2);
            //GL2024   InserForm.SetSteps(Step.Line);
            //GL2024  InserForm.SetNumBor(Header."No.");
            InserForm.SetTableView(PaymentLine);
            InserForm.LookupMode(true);
            InserForm.RunModal();
        end;
    end;


    procedure StepSelect(Process: Text[30]; NextStatus: Integer; var Step: Record "Payment Step"; CreateDocumentFilter: Boolean) OK: Boolean
    var
        PaymentClass: Record "Payment Class";
        Options: Text[250];
        Choice: Integer;
        i: Integer;
    begin
        OK := false;
        i := 0;
        if Process = '' then begin
            PaymentClass.SetRange(Enable, true);
            if CreateDocumentFilter then
                PaymentClass.SetRange("Is Create Document", true);
            if PaymentClass.Find('-') then
                repeat
                    i += 1;
                    if Options = '' then
                        Options := PaymentClass.Code
                    else
                        Options := Options + ',' + PaymentClass.Code;
                until PaymentClass.Next() = 0;
            if i > 0 then
                Choice := StrMenu(Options, 1);
            i := 1;
            if Choice > 0 then begin
                PaymentClass.Find('-');
                while Choice > i do begin
                    i += 1;
                    PaymentClass.Next();
                end;
            end;
        end else begin
            PaymentClass.Get(Process);
            Choice := 1;
        end;
        if Choice > 0 then begin
            Options := '';
            Step.SetRange("Payment Class", PaymentClass.Code);
            Step.SetRange("Action Type", Step."Action Type"::"Create New Document");
            if NextStatus > -1 then
                Step.SetRange("Next Status", NextStatus);
            i := 0;
            if Step.Find('-') then begin
                i += 1;
                repeat
                    if Options = '' then
                        Options := Step.Name
                    else
                        Options := Options + ',' + Step.Name;
                until Step.Next() = 0;
                if i > 0 then begin
                    Choice := StrMenu(Options, 1);
                    i := 1;
                    if Choice > 0 then begin
                        Step.Find('-');
                        while Choice > i do begin
                            i += 1;
                            Step.Next();
                        end;
                        OK := true;
                    end;
                end;
            end;
        end;
    end;

    local procedure CheckDimCombAndValue(PaymentLine2: Record "Payment Line")
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        if PaymentLine."Line No." = 0 then begin
            if not DimMgt.CheckDimIDComb(PaymentHeader."Dimension Set ID") then
                Error(
                  Text009,
                  PaymentHeader."No.", DimMgt.GetDimCombErr());
            TableID[1] := DATABASE::"Payment Header";
            No[1] := PaymentHeader."No.";
            if not DimMgt.CheckDimValuePosting(TableID, No, PaymentHeader."Dimension Set ID") then
                ThrowPmtPostError(PaymentLine2, CheckDimVauePostingHeaderErr, DimMgt.GetDimValuePostingErr());
        end;

        if PaymentLine."Line No." <> 0 then begin
            if not DimMgt.CheckDimIDComb(PaymentLine2."Dimension Set ID") then
                Error(
                  Text010,
                  PaymentHeader."No.", PaymentLine2."Line No.", DimMgt.GetDimCombErr());
            TableID[1] := TypeToTableID(PaymentLine2."Account Type".AsInteger());
            No[1] := PaymentLine2."Account No.";
            if not DimMgt.CheckDimValuePosting(TableID, No, PaymentLine2."Dimension Set ID") then
                ThrowPmtPostError(PaymentLine2, CheckDimVauePostingLineErr, DimMgt.GetDimValuePostingErr());
        end;
    end;

    local procedure CheckDim()
    begin
        PaymentLine."Line No." := 0;
        CheckDimCombAndValue(PaymentLine);

        PaymentLine.SetRange("No.", PaymentHeader."No.");
        if PaymentLine.FindSet() then
            repeat
                CheckDimCombAndValue(PaymentLine);
            until PaymentLine.Next() = 0;
    end;

    local procedure TypeToTableID(Type: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset"): Integer
    begin
        case Type of
            Type::"G/L Account":
                exit(DATABASE::"G/L Account");
            Type::Customer:
                exit(DATABASE::Customer);
            Type::Vendor:
                exit(DATABASE::Vendor);
            Type::"Bank Account":
                exit(DATABASE::"Bank Account");
            Type::"Fixed Asset":
                exit(DATABASE::"Fixed Asset");
        end;
    end;

    local procedure ThrowPmtPostError(ReceivedPaymentLine: Record "Payment Line"; ErrorTemplate: Text; ErrorText: Text)
    begin
        if ReceivedPaymentLine."Line No." <> 0 then
            Error(
              ErrorTemplate, PaymentHeader."No.", ReceivedPaymentLine.TableCaption(), ReceivedPaymentLine."Line No.", ErrorText);
        Error(ErrorTemplate, PaymentHeader."No.", ErrorText);
    end;


    procedure TestSourceCode("Code": Code[10])
    var
        SourceCode: Record "Source Code";
    begin
        if not SourceCode.Get(Code) then
            Error(Text017, Code);
    end;


    procedure PaymentAddr(var AddrArray: array[8] of Text[100]; PaymentAddress: Record "Payment Address")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        FormatAddress.FormatAddr(
              AddrArray, PaymentAddress.Name, PaymentAddress."Name 2", PaymentAddress.Contact, PaymentAddress.Address, PaymentAddress."Address 2",
              PaymentAddress.City, PaymentAddress."Post Code", PaymentAddress.County, PaymentAddress."Country/Region Code");
    end;


    procedure PaymentBankAcc(var AddrArray: array[8] of Text[100]; BankAcc: Record "Payment Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        FormatAddress.FormatAddr(
              AddrArray, BankAcc."Bank Name", BankAcc."Bank Name 2", BankAcc."Bank Contact", BankAcc."Bank Address", BankAcc."Bank Address 2",
              BankAcc."Bank City", BankAcc."Bank Post Code", BankAcc."Bank County", BankAcc."Bank Country/Region Code");
    end;


    procedure ArchiveDocument(Document: Record "Payment Header")
    var
        ArchiveHeader: Record "Payment Header Archive";
        ArchiveLine: Record "Payment Line Archive";
        PaymentLine: Record "Payment Line";
    begin
        Document.CalcFields("Archiving Authorized");
        if not Document."Archiving Authorized" then
            Error(Text022, Document."No.");
        ArchiveHeader.TransferFields(Document);
        ArchiveHeader.Insert();
        //Document.Delete();
        PaymentLine.SetRange("No.", Document."No.");
        if PaymentLine.Find('-') then
            repeat
                ArchiveLine.TransferFields(PaymentLine);
                ArchiveLine.Insert();
            // PaymentLine.Delete();
            until PaymentLine.Next() = 0;
    end;


    procedure PickPaymentStep(PaymentHeader: Record "Payment Header"; var PaymentStep: Record "Payment Step"): Boolean
    var
        PaymentSteps: Page "Payment Steps";
    begin
        PaymentStep.FilterGroup(2);
        // Filter on "Action Type" is passed with PaymentStep
        PaymentStep.SetRange("Payment Class", PaymentHeader."Payment Class");
        PaymentStep.SetRange("Previous Status", PaymentHeader."Status No.");
        PaymentStep.FilterGroup(0);
        if PaymentStep.IsEmpty() then
            exit(false);

        if PaymentStep.Count = 1 then begin
            PaymentStep.FindFirst();
            exit(Confirm(PaymentStep.Name, true));
        end;

        PaymentStep.FindSet();
        PaymentSteps.LookupMode(true);
        PaymentSteps.SetTableView(PaymentStep);
        PaymentSteps.SetRecord(PaymentStep);
        PaymentSteps.Editable(false);
        if PaymentSteps.RunModal() = ACTION::LookupOK then begin
            PaymentSteps.GetRecord(PaymentStep);
            exit(true);
        end;
        exit(false);
    end;


    procedure ProcessPaymentSteps(PaymentHeader: Record "Payment Header"; var PaymentStep: Record "Payment Step")
    var
        Text00001: Label 'Il n''y a pas de ligne à traiter.';

    begin

        //GL2024  PaymentHeader.TestNbOfLines();
        //GL2024
        PaymentHeader.CalcFields("No. of Lines");
        if PaymentHeader."No. of Lines" = 0 then
            Error(Text00001);  //GL2024
        if PickPaymentStep(PaymentHeader, PaymentStep) then
            ProcessPaymentStep(PaymentHeader."No.", PaymentStep);
    end;

    local procedure RunXmlPortExport(XMLPortID: Integer; var PaymentHeader: Record "Payment Header")
    begin
        PaymentClass.Get(PaymentHeader."Payment Class");
        case PaymentClass."SEPA Transfer Type" of
            PaymentClass."SEPA Transfer Type"::"Credit Transfer":
                ExportSEPACreditTransfer(XMLPortID, PaymentHeader);
            PaymentClass."SEPA Transfer Type"::"Direct Debit":
                ExportSEPADirectDebit(PaymentHeader);
            else
                XMLPORT.Run(XMLPortID, false, false, PaymentHeader);
        end;
    end;

    local procedure ExportSEPACreditTransfer(XMLPortId: Integer; var PaymentHeader: Record "Payment Header")
    var
        GenJnlLine: Record "Gen. Journal Line";
        SEPACTExportFile: Codeunit "SEPA CT-Export File";
    begin
        GenJnlLine.SetRange("Journal Template Name", '');
        GenJnlLine.SetRange("Journal Batch Name", '');
        GenJnlLine.SetRange("Document No.", PaymentHeader."No.");
        OnExportSEPACreditTransferOnAfterGenJnlLineSetFilters(GenJnlLine, XMLPortId, PaymentHeader);
        if SEPACTExportFile.Export(GenJnlLine, XMLPortId) then begin
            PaymentHeader."File Export Completed" := true;
            PaymentHeader.Modify();
        end;
    end;

    local procedure ExportSEPADirectDebit(var PaymentHeader: Record "Payment Header")
    var
        DirectDebitCollection: Record "Direct Debit Collection";
        DirectDebitCollectionEntry: Record "Direct Debit Collection Entry";
        LastError: Text;
    begin
        PaymentHeader.TestField("Account Type", PaymentHeader."Account Type"::"Bank Account");
        DirectDebitCollection.CreateRecord(PaymentHeader."No.", PaymentHeader."Account No.", PaymentHeader."Partner Type");
        DirectDebitCollection."Source Table ID" := DATABASE::"Payment Header";
        DirectDebitCollection.Modify();
        DirectDebitCollectionEntry.SetRange("Direct Debit Collection No.", DirectDebitCollection."No.");
        Commit();
        ClearLastError();
        if CODEUNIT.Run(CODEUNIT::"SEPA DD-Export File", DirectDebitCollectionEntry) then begin
            DeleteDirectDebitCollection(DirectDebitCollection."No.");
            PaymentHeader."File Export Completed" := true;
            PaymentHeader.Modify();
            exit;
        end;

        LastError := GetLastErrorText;
        DeleteDirectDebitCollection(DirectDebitCollection."No.");
        Commit();
        Error(LastError);
    end;

    local procedure DeleteDirectDebitCollection(DirectDebitCollectionNo: Integer)
    var
        DirectDebitCollection: Record "Direct Debit Collection";
    begin
        if DirectDebitCollection.Get(DirectDebitCollectionNo) then
            DirectDebitCollection.Delete(true);
    end;

    /* procedure UpdateGeberalLedegerEntry(PDocNo: Code[20]; PIsBank: Boolean; PFolio: Code[20])
     var
         LGLEntry: Record "G/L Entry";
     begin
         IF PIsBank THEN BEGIN
             LGLEntry.SETRANGE("Document No.", PDocNo);
             LGLEntry.MODIFYALL("Folio N°", PFolio);
         END;
     end;*/


    /*   procedure UpdateBanKLedegerEntry(PDocNo: Code[20]; PIsBank: Boolean; PAffectation: Code[60])
       var
           LBankEntry: Record "Bank Account Ledger Entry";
       begin
           IF PIsBank THEN BEGIN
               LBankEntry.SETRANGE("Document No.", PDocNo);
               LBankEntry.MODIFYALL("Affectation Financiere", PAffectation);
           END;
       end;*/

    local procedure PostInvPostingBuffer(): Integer
    var
        GLEntry: Record "G/L Entry";
        CurrExchRate: Record "Currency Exchange Rate";
        Difference: Decimal;
        Currency: Record Currency;
        Text100: label 'Rounding on ';
        TempJnlLineDim: Record "Dim. Value per Account" temporary;
        PaymentLineTmp: Record "Payment Line";
        "// HJ SORO": Integer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BankAccount: Record "Bank Account";
        "// RB SORO": Integer;
        RecPaymentHeaderRS: Record "Payment Header";
        RecPaymentHeader2: Record "Payment Header";

    begin
        GenJnlLine.Init();
        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
        GenJnlLine."Document Date" := PaymentHeader."Document Date";
        GenJnlLine.Description := InvPostingBuffer[1].Description;
        GenJnlLine."Reason Code" := Step."Reason Code";
        PaymentClass.Get(PaymentHeader."Payment Class");
        GenJnlLine."Delayed Unrealized VAT" :=
          (PaymentClass."Unrealized VAT Reversal" = PaymentClass."Unrealized VAT Reversal"::Delayed);
        GenJnlLine."Realize VAT" := Step."Realize VAT";
        GenJnlLine."Created from No." := InvPostingBuffer[1]."Created from No.";
        GenJnlLine."Document Type" := InvPostingBuffer[1]."Document Type";
        GenJnlLine."Document No." := InvPostingBuffer[1]."Document No.";
        GenJnlLine."Account Type" := InvPostingBuffer[1]."Account Type";
        GenJnlLine."Account No." := InvPostingBuffer[1]."Account No.";
        // HS Folio Fix
        // >> HJ SORO 03-08-2016
        /*  GenJnlLine.Salarie := InvPostingBuffer[1].Salarie;
          // >> HJ SORO 03-08-2016
          GenJnlLine."Affectation Financiere" := InvPostingBuffer[1]."Affectation Fianciere";

          // >> HJ SORO 03-08-2016
          iSbANK := FALSE;
          // >> HJ SORO 17-02-2015


          // >> HJ SORO 17-02-2015
          IF (BankAccount.GET(InvPostingBuffer[1]."Account No.")) OR (BankAccount.GET(InvPostingBuffer[2]."Account No.")) THEN
              IF BankAccount."Souche N° Banque" <> '' THEN
                  IF Folio = '' THEN BEGIN
                      iSbANK := TRUE;
                      Folio := NoSeriesMgt.GetNextNo(BankAccount."Souche N° Banque", WORKDATE, TRUE);
                      GenJnlLine."N° Bordereau" := Folio;
                      UpdateGeberalLedegerEntry(PaymentHeader."No.", TRUE, Folio);
                      UpdateBanKLedegerEntry(PaymentHeader."No.", TRUE, InvPostingBuffer[1]."Affectation Fianciere");
                      MESSAGE(Folio);
                  END
                  ELSE
                      GenJnlLine."N° Bordereau" := Folio;

          // >> HJ SORO 17-02-2015

          // >> HJ SORO 17-02-2015

          GenJnlLine."N° Bordereau" := Folio;
          // RB SORO 27/04/2015 FOLIO RS

          // RB SORO 27/04/2015 FOLIO RS

          RecPaymentHeaderRS.GET(InvPostingBuffer[1]."Document No.");
          IF RecPaymentHeaderRS."N° Brouillard" <> '' THEN BEGIN
              RecPaymentHeader2.GET(RecPaymentHeaderRS."N° Brouillard");
              GenJnlLine."Folio N° RS" := RecPaymentHeader2."Folio N° RS";
          END;
          // RB SORO 27/04/2015 FOLIO RS
  */
        // HS Folio Fix
        GenJnlLine."System-Created Entry" := InvPostingBuffer[1]."System-Created Entry";
        GenJnlLine."Currency Code" := InvPostingBuffer[1]."Currency Code";
        GenJnlLine."Currency Factor" := InvPostingBuffer[1]."Currency Factor";
        GenJnlLine.Validate(Amount, InvPostingBuffer[1].Amount);
        // HS Folio Fix
        // imen 090212
        GenJnlLine."Amount (LCY)" := ROUND(InvPostingBuffer[1]."Amount (LCY)", 0.001);
        // imen 090212
        GenJnlLine.Correction := InvPostingBuffer[1].Correction;
        //>>>MBK:24/11/2010
        //>>>MBK:24/11/2010
        GenJnlLine."Type origine entêt" := PaymentHeader."Account Type";
        GenJnlLine."Code origine entêt" := PaymentHeader."Account No.";

        //>>>MBK:24/11/2010
        // HS Folio Fix

        if PaymentHeader."Source Code" <> '' then begin
            TestSourceCode(PaymentHeader."Source Code");
            GenJnlLine."Source Code" := PaymentHeader."Source Code";
        end;
        // HS Folio Fix
        /* if PaymentHeader."Source Code" <> '' then begin
             TestSourceCode(PaymentHeader."Source Code");
             GenJnlLine."Source Code" := PaymentHeader."Source Code";
         end else begin
             Step.TestField("Source Code");
             TestSourceCode(Step."Source Code");
             GenJnlLine."Source Code" := Step."Source Code";
         end;*/
        // HS Folio Fix
        GenJnlLine."Applies-to ID" := InvPostingBuffer[1]."Applies-to ID";
        if GenJnlLine."Applies-to ID" = '' then begin
            GenJnlLine."Applies-to Doc. Type" := InvPostingBuffer[1]."Applies-to Doc. Type";
            GenJnlLine."Applies-to Doc. No." := InvPostingBuffer[1]."Applies-to Doc. No.";
        end;
        GenJnlLine."Posting Group" := InvPostingBuffer[1]."Posting Group";
        GenJnlLine."Source Type" := InvPostingBuffer[1]."Source Type";
        GenJnlLine."Source No." := InvPostingBuffer[1]."Source No.";
        GenJnlLine."External Document No." := InvPostingBuffer[1]."External Document No.";
        GenJnlLine."Due Date" := InvPostingBuffer[1]."Due Date";
        GenJnlLine."Shortcut Dimension 1 Code" := InvPostingBuffer[1]."Global Dimension 1 Code";
        GenJnlLine."Shortcut Dimension 2 Code" := InvPostingBuffer[1]."Global Dimension 2 Code";
        GenJnlLine."Dimension Set ID" := InvPostingBuffer[1]."Dimension Set ID";

        OnPostInvPostingBufferOnBeforeGenJnlPostLineRunWithCheck(GenJnlLine, PaymentHeader, PaymentClass);
        GenJnlPostLine.RunWithCheck(GenJnlLine);

        //>> IMS 11 05 2011 VALIDATION INTERET ESCOPMTE
        if (InvPostingBuffer[1]."Compte Retenue" <> '') and (InvPostingBuffer[1]."Amount Retenue" <> 0) then begin

            GenJnlLine.Init;
            GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
            GenJnlLine."Document Date" := PaymentHeader."Document Date";

            /*  GroupeRetenu.Reset;//fff
              Desc := '';
              if GroupeRetenu.Get(0, PaymentLine."Code Retenue à la Source") then
                  Desc := Format(GroupeRetenu."Type Retenue")
              else
                  if GroupeRetenu.Get(1, PaymentLine."Code Retenue de Garantie") then
                      Desc := Format(GroupeRetenu."Type Retenue")
                  else
                      if GroupeRetenu.Get(2, PaymentLine."Code Retenue à la Source") then
                          Desc := Format(GroupeRetenu."Type Retenue")
                      else
                          if GroupeRetenu.Get(3, PaymentLine."Code Retenue à la Source") then
                              Desc := Format(GroupeRetenu."Type Retenue")
                          else
                              if GroupeRetenu.Get(4, PaymentLine."Code Retenue à la Source") then
                                  Desc := Format(GroupeRetenu."Type Retenue");*/


            GenJnlLine.Description := Desc;
            GenJnlLine."Reason Code" := Step."Reason Code";
            GenJnlLine."Document Type" := InvPostingBuffer[1]."Document Type";
            GenJnlLine."Document No." := InvPostingBuffer[1]."Document No.";
            GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
            GenJnlLine."Account No." := InvPostingBuffer[1]."Compte Retenue";
            GenJnlLine."System-Created Entry" := InvPostingBuffer[1]."System-Created Entry";
            GenJnlLine."Currency Code" := InvPostingBuffer[1]."Currency Code";
            GenJnlLine."Currency Factor" := InvPostingBuffer[1]."Currency Factor";
            GenJnlLine.Validate(Amount, InvPostingBuffer[1]."Amount Retenue");
            GenJnlLine.Correction := InvPostingBuffer[1].Correction;
            // GenJnlLine."N° Bordereau" := Folio;
            //>>>MBK:24/11/2010
            // GenJnlLine."Type origine entêt":=PaymentHeader."Account Type";
            //GenJnlLine."Code origine entêt":=PaymentHeader."Account No.";
            //>>>MBK:24/11/2010
            IF Step."Source Code" <> '' THEN BEGIN
                Step.TESTFIELD("Source Code");
                TestSourceCode(Step."Source Code");
                GenJnlLine."Source Code" := Step."Source Code";
                PaymentHeader."Source Code" := Step."Source Code";
            END
            ELSE BEGIN
                TestSourceCode(PaymentHeader."Source Code");
                GenJnlLine."Source Code" := PaymentHeader."Source Code";
            END;

            /*   if PaymentHeader."Source Code" <> '' then begin
                   TestSourceCode(PaymentHeader."Source Code");
                   GenJnlLine."Source Code" := PaymentHeader."Source Code";
               end else begin
                   Step.TestField("Source Code");
                   TestSourceCode(Step."Source Code");
                   GenJnlLine."Source Code" := Step."Source Code";
               end;*/
            GenJnlLine."Applies-to Doc. Type" := InvPostingBuffer[1]."Applies-to Doc. Type";
            GenJnlLine."Applies-to Doc. No." := InvPostingBuffer[1]."Applies-to Doc. No.";
            if GenJnlLine."Applies-to Doc. No." = '' then
                GenJnlLine."Applies-to ID" := InvPostingBuffer[1]."Applies-to ID";
            GenJnlLine."Posting Group" := InvPostingBuffer[1]."Posting Group";
            GenJnlLine."Source Type" := InvPostingBuffer[1]."Source Type";
            GenJnlLine."Source No." := InvPostingBuffer[1]."Source No.";
            GenJnlLine."External Document No." := InvPostingBuffer[1]."External Document No.";
            GenJnlLine."Due Date" := InvPostingBuffer[1]."Due Date";
            GenJnlLine."Shortcut Dimension 1 Code" := InvPostingBuffer[1]."Global Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := InvPostingBuffer[1]."Global Dimension 2 Code";

            if (ROUND(GenJnlLine."Amount (LCY)", GLsetup."Amount Rounding Precision") <> 0) then
                GenJnlPostLine.RunWithCheck(GenJnlLine);
        end;

        if (InvPostingBuffer[1]."Compte TVA" <> '') and (InvPostingBuffer[1]."Amount TVA" <> 0) then begin
            GenJnlLine.Init;
            GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
            GenJnlLine."Document Date" := PaymentHeader."Document Date";
            /* IF InvPostingBuffer[1].Commentaires<>'' THEN
              GenJnlLine.Description :=InvPostingBuffer[1].Commentaires
              ELSE*/
            GenJnlLine.Description := 'Retenue Sur T.V.A';
            GenJnlLine."Reason Code" := Step."Reason Code";
            GenJnlLine."Document Type" := InvPostingBuffer[1]."Document Type";
            GenJnlLine."Document No." := InvPostingBuffer[1]."Document No.";
            GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
            GenJnlLine."Account No." := InvPostingBuffer[1]."Compte TVA";
            GenJnlLine."System-Created Entry" := InvPostingBuffer[1]."System-Created Entry";
            GenJnlLine."Currency Code" := InvPostingBuffer[1]."Currency Code";
            GenJnlLine."Currency Factor" := InvPostingBuffer[1]."Currency Factor";
            GenJnlLine.Validate(Amount, InvPostingBuffer[1]."Amount TVA");
            GenJnlLine.Correction := InvPostingBuffer[1].Correction;
            //>>>MBK:24/11/2010
            //  GenJnlLine."Type origine entêt":=PaymentHeader."Account Type";
            //  GenJnlLine."Code origine entêt":=PaymentHeader."Account No.";
            //>>>MBK:24/11/2010
            IF Step."Source Code" <> '' THEN BEGIN
                Step.TESTFIELD("Source Code");
                TestSourceCode(Step."Source Code");
                GenJnlLine."Source Code" := Step."Source Code";
                PaymentHeader."Source Code" := Step."Source Code";
            END
            ELSE BEGIN
                TestSourceCode(PaymentHeader."Source Code");
                GenJnlLine."Source Code" := PaymentHeader."Source Code";
            END;
            /*  if PaymentHeader."Source Code" <> '' then begin
                  TestSourceCode(PaymentHeader."Source Code");
                  GenJnlLine."Source Code" := PaymentHeader."Source Code";
              end else begin
                  Step.TestField("Source Code");
                  TestSourceCode(Step."Source Code");
                  GenJnlLine."Source Code" := Step."Source Code";
              end;*/
            GenJnlLine."Applies-to Doc. Type" := InvPostingBuffer[1]."Applies-to Doc. Type";
            GenJnlLine."Applies-to Doc. No." := InvPostingBuffer[1]."Applies-to Doc. No.";
            if GenJnlLine."Applies-to Doc. No." = '' then
                GenJnlLine."Applies-to ID" := InvPostingBuffer[1]."Applies-to ID";
            GenJnlLine."Posting Group" := InvPostingBuffer[1]."Posting Group";
            GenJnlLine."Source Type" := InvPostingBuffer[1]."Source Type";
            GenJnlLine."Source No." := InvPostingBuffer[1]."Source No.";
            GenJnlLine."External Document No." := InvPostingBuffer[1]."External Document No.";
            GenJnlLine."Due Date" := InvPostingBuffer[1]."Due Date";
            GenJnlLine."Shortcut Dimension 1 Code" := InvPostingBuffer[1]."Global Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := InvPostingBuffer[1]."Global Dimension 2 Code";

            if (ROUND(GenJnlLine."Amount (LCY)", GLsetup."Amount Rounding Precision") <> 0) then
                GenJnlPostLine.RunWithCheck(GenJnlLine);
        end;
        if (InvPostingBuffer[1]."Compte Comission" <> '') and (InvPostingBuffer[1]."Amount Comission" <> 0) then begin
            GenJnlLine.Init;
            GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
            GenJnlLine."Document Date" := PaymentHeader."Document Date";
            /*IF InvPostingBuffer[1].Commentaires<>'' THEN
             GenJnlLine.Description :=InvPostingBuffer[1].Commentaires
             ELSE */

            GenJnlLine.Description := 'Commission  ';
            GenJnlLine."Reason Code" := Step."Reason Code";
            GenJnlLine."Document Type" := InvPostingBuffer[1]."Document Type";
            GenJnlLine."Document No." := InvPostingBuffer[1]."Document No.";
            GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
            GenJnlLine."Account No." := InvPostingBuffer[1]."Compte Comission";
            GenJnlLine."System-Created Entry" := InvPostingBuffer[1]."System-Created Entry";
            GenJnlLine."Currency Code" := InvPostingBuffer[1]."Currency Code";
            if InvPostingBuffer[1]."Amount Comission (LCY)" <> 0 then
                GenJnlLine."Currency Factor" := ROUND(InvPostingBuffer[1]."Amount Comission" /
                InvPostingBuffer[1]."Amount Comission (LCY)", 0.000000000001)
            else
                GenJnlLine."Currency Factor" := 1;

            GenJnlLine.Validate(Amount, InvPostingBuffer[1]."Amount Comission");
            GenJnlLine.Correction := InvPostingBuffer[1].Correction;
            //>>>MBK:24/11/2010
            // GenJnlLine."Type origine entêt":=PaymentHeader."Account Type";
            // GenJnlLine."Code origine entêt":=PaymentHeader."Account No.";
            //>>>MBK:24/11/2010
            IF Step."Source Code" <> '' THEN BEGIN
                Step.TESTFIELD("Source Code");
                TestSourceCode(Step."Source Code");
                GenJnlLine."Source Code" := Step."Source Code";
                PaymentHeader."Source Code" := Step."Source Code";
            END
            ELSE BEGIN
                TestSourceCode(PaymentHeader."Source Code");
                GenJnlLine."Source Code" := PaymentHeader."Source Code";
            END;
            /*  if PaymentHeader."Source Code" <> '' then begin
                  TestSourceCode(PaymentHeader."Source Code");
                  GenJnlLine."Source Code" := PaymentHeader."Source Code";
              end else begin
                  Step.TestField("Source Code");
                  TestSourceCode(Step."Source Code");
                  GenJnlLine."Source Code" := Step."Source Code";
              end;*/
            GenJnlLine."Applies-to Doc. Type" := InvPostingBuffer[1]."Applies-to Doc. Type";
            GenJnlLine."Applies-to Doc. No." := InvPostingBuffer[1]."Applies-to Doc. No.";
            if GenJnlLine."Applies-to Doc. No." = '' then
                GenJnlLine."Applies-to ID" := InvPostingBuffer[1]."Applies-to ID";
            GenJnlLine."Posting Group" := InvPostingBuffer[1]."Posting Group";
            GenJnlLine."Source Type" := InvPostingBuffer[1]."Source Type";
            GenJnlLine."Source No." := InvPostingBuffer[1]."Source No.";
            GenJnlLine."External Document No." := InvPostingBuffer[1]."External Document No.";
            GenJnlLine."Due Date" := InvPostingBuffer[1]."Due Date";
            GenJnlLine."Shortcut Dimension 1 Code" := InvPostingBuffer[1]."Global Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := InvPostingBuffer[1]."Global Dimension 2 Code";

            if (ROUND(GenJnlLine."Amount (LCY)", GLsetup."Amount Rounding Precision") <> 0) then
                GenJnlPostLine.RunWithCheck(GenJnlLine);
        end;
        if (InvPostingBuffer[1]."Compte TVA/Comission" <> '') and (InvPostingBuffer[1]."Amount TVA/Comission" <> 0) then begin
            GenJnlLine.Init;
            //   GenJnlLine."Posting Date" := "Posting Date";
            //   GenJnlLine."Document Date" := "Document Date";
            /*IF InvPostingBuffer[1].Commentaires<>'' THEN
             GenJnlLine.Description :=InvPostingBuffer[1].Commentaires
             ELSE*/

            GenJnlLine.Description := 'TVA Sur Commission  ';
            GenJnlLine."Reason Code" := Step."Reason Code";
            GenJnlLine."Document Type" := InvPostingBuffer[1]."Document Type";
            GenJnlLine."Document No." := InvPostingBuffer[1]."Document No.";
            GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
            GenJnlLine."Account No." := InvPostingBuffer[1]."Compte TVA/Comission";
            GenJnlLine."System-Created Entry" := InvPostingBuffer[1]."System-Created Entry";
            GenJnlLine."Currency Code" := InvPostingBuffer[1]."Currency Code";
            if InvPostingBuffer[1]."Amount TVA/Comission (LCY)" <> 0 then
                GenJnlLine."Currency Factor" := ROUND(InvPostingBuffer[1]."Amount TVA/Comission" /
                InvPostingBuffer[1]."Amount TVA/Comission (LCY)", 0.000000000001)
            else
                GenJnlLine."Currency Factor" := 1;

            GenJnlLine.Validate(Amount, InvPostingBuffer[1]."Amount TVA/Comission");
            GenJnlLine.Correction := InvPostingBuffer[1].Correction;
            //>>>MBK:24/11/2010
            // GenJnlLine."Type origine entêt":=PaymentHeader."Account Type";
            //GenJnlLine."Code origine entêt":=PaymentHeader."Account No.";
            //>>>MBK:24/11/2010
            IF Step."Source Code" <> '' THEN BEGIN
                Step.TESTFIELD("Source Code");
                TestSourceCode(Step."Source Code");
                GenJnlLine."Source Code" := Step."Source Code";
                PaymentHeader."Source Code" := Step."Source Code";
            END
            ELSE BEGIN
                TestSourceCode(PaymentHeader."Source Code");
                GenJnlLine."Source Code" := PaymentHeader."Source Code";
            END;
            /*  if PaymentHeader."Source Code" <> '' then begin
                  TestSourceCode(PaymentHeader."Source Code");
                  GenJnlLine."Source Code" := PaymentHeader."Source Code";
              end else begin
                  Step.TestField("Source Code");
                  TestSourceCode(Step."Source Code");
                  GenJnlLine."Source Code" := Step."Source Code";
        end;*/
            GenJnlLine."Applies-to Doc. Type" := InvPostingBuffer[1]."Applies-to Doc. Type";
            GenJnlLine."Applies-to Doc. No." := InvPostingBuffer[1]."Applies-to Doc. No.";
            if GenJnlLine."Applies-to Doc. No." = '' then
                GenJnlLine."Applies-to ID" := InvPostingBuffer[1]."Applies-to ID";
            GenJnlLine."Posting Group" := InvPostingBuffer[1]."Posting Group";
            GenJnlLine."Source Type" := InvPostingBuffer[1]."Source Type";
            GenJnlLine."Source No." := InvPostingBuffer[1]."Source No.";
            GenJnlLine."External Document No." := InvPostingBuffer[1]."External Document No.";
            GenJnlLine."Due Date" := InvPostingBuffer[1]."Due Date";
            GenJnlLine."Shortcut Dimension 1 Code" := InvPostingBuffer[1]."Global Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := InvPostingBuffer[1]."Global Dimension 2 Code";

            if (ROUND(GenJnlLine."Amount (LCY)", GLsetup."Amount Rounding Precision") <> 0) then
                GenJnlPostLine.RunWithCheck(GenJnlLine);
        end;
        //>> IMS 11 05 2011 VALIDATION INTETERT FED
        // MESSAGE('%1',InvPostingBuffer[1]);
        IF (InvPostingBuffer[1]."Compte Intérêt Escompte" <> '') AND (InvPostingBuffer[1]."Montant Intérêt Escompte" <> 0) THEN BEGIN
            GenJnlLine.INIT;
            GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
            GenJnlLine."Document Date" := PaymentHeader."Document Date";
            /*IF InvPostingBuffer[1].Commentaires <> '' THEN
                      GenJnlLine.Description := InvPostingBuffer[1].Commentaires
                  ELSE */
            if GLsetup.Get() then;
            GenJnlLine.Description := 'Intérêt Escompte  ';
            GenJnlLine."Reason Code" := Step."Reason Code";
            GenJnlLine."Document Type" := InvPostingBuffer[1]."Document Type";
            GenJnlLine."Document No." := InvPostingBuffer[1]."Document No.";
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            GenJnlLine."Account No." := InvPostingBuffer[1]."Compte Intérêt Escompte";
            GenJnlLine."System-Created Entry" := InvPostingBuffer[1]."System-Created Entry";
            GenJnlLine."Currency Code" := InvPostingBuffer[1]."Currency Code";
            IF InvPostingBuffer[1]."Montant Intérêt Escompte (DS)" <> 0 THEN
                GenJnlLine."Currency Factor" := ROUND(InvPostingBuffer[1]."Montant Intérêt Escompte" /
                InvPostingBuffer[1]."Montant Intérêt Escompte (DS)", 0.000000000001)
            ELSE
                GenJnlLine."Currency Factor" := 1;

            GenJnlLine.VALIDATE(Amount, InvPostingBuffer[1]."Montant Intérêt Escompte");
            GenJnlLine.Correction := InvPostingBuffer[1].Correction;
            //>>>MBK:24/11/2010
            GenJnlLine."Type origine entêt" := PaymentHeader."Account Type";
            GenJnlLine."Code origine entêt" := PaymentHeader."Account No.";

            //>>>MBK:24/11/2010


            IF PaymentHeader."Source Code" <> '' THEN BEGIN
                TestSourceCode(PaymentHeader."Source Code");
                GenJnlLine."Source Code" := PaymentHeader."Source Code";
            END ELSE BEGIN
                Step.TESTFIELD("Source Code");
                TestSourceCode(Step."Source Code");
                GenJnlLine."Source Code" := Step."Source Code";
            END;
            GenJnlLine."Applies-to Doc. Type" := InvPostingBuffer[1]."Applies-to Doc. Type";
            GenJnlLine."Applies-to Doc. No." := InvPostingBuffer[1]."Applies-to Doc. No.";
            IF GenJnlLine."Applies-to Doc. No." = '' THEN
                GenJnlLine."Applies-to ID" := InvPostingBuffer[1]."Applies-to ID";
            GenJnlLine."Posting Group" := InvPostingBuffer[1]."Posting Group";
            GenJnlLine."Source Type" := InvPostingBuffer[1]."Source Type";
            GenJnlLine."Source No." := InvPostingBuffer[1]."Source No.";
            GenJnlLine."External Document No." := InvPostingBuffer[1]."External Document No.";
            GenJnlLine."Due Date" := InvPostingBuffer[1]."Due Date";
            GenJnlLine."Shortcut Dimension 1 Code" := InvPostingBuffer[1]."Global Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := InvPostingBuffer[1]."Global Dimension 2 Code";
            //       TempJnlLineDim.DELETEALL;
            // TempDocDim.RESET;
            // TempDocDim.SETRANGE("Document Type", TempDocDim."Document Type"::" ");
            // TempDocDim.SETRANGE("Document No.", InvPostingBuffer[1]."Header Document No.");
            // TempDocDim.SETRANGE("Line No.", InvPostingBuffer[1]."Line No.");
            // IF InvPostingBuffer[1]."Line No." = 0 THEN
            //     TempDocDim.SETRANGE("Table ID", DATABASE::"Payment Header")
            // ELSE
            //     TempDocDim.SETRANGE("Table ID", DATABASE::"Payment Line");
            // DimMgt.CopyDocDimToJnlLineDim(TempDocDim, TempJnlLineDim);
            IF (ROUND(GenJnlLine."Amount (LCY)", GLsetup."Amount Rounding Precision") <> 0) THEN
                GenJnlPostLine.RunWithCheck(GenJnlLine);
        END;
        //<< IMS 11 05 2011 VALIDATION INTERET ESCOMPTE
        // MESSAGE('%1',InvPostingBuffer[1]);
        IF (InvPostingBuffer[1]."Compte Intérêt sur Prêt" <> '') AND (InvPostingBuffer[1]."Montant Intérêt sur Prêt" <> 0) THEN BEGIN
            GenJnlLine.INIT;
            GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
            GenJnlLine."Document Date" := PaymentHeader."Document Date";
            /*IF InvPostingBuffer[1].Commentaires <> '' THEN
                      GenJnlLine.Description := InvPostingBuffer[1].Commentaires
                  ELSE */

            GenJnlLine."Reason Code" := Step."Reason Code";
            //mby 02/06/2011
            /*     RecReasonCode.RESET;
                 RecReasonCode.SETRANGE(Code, GenJnlLine."Reason Code");
                 IF RecReasonCode.FIND('-') THEN
                     IF GenJnlLine.Description = '' THEN
                         GenJnlLine.Description := RecReasonCode.Designation;*/
            //mby 02/06/2011

            GenJnlLine."Document Type" := InvPostingBuffer[1]."Document Type";
            GenJnlLine."Document No." := InvPostingBuffer[1]."Document No.";
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            GenJnlLine."Account No." := InvPostingBuffer[1]."Compte Intérêt sur Prêt";
            GenJnlLine."System-Created Entry" := InvPostingBuffer[1]."System-Created Entry";
            GenJnlLine."Currency Code" := InvPostingBuffer[1]."Currency Code";
            IF InvPostingBuffer[1]."Montant Intérêt sur Prêt (DS)" <> 0 THEN
                GenJnlLine."Currency Factor" := ROUND(InvPostingBuffer[1]."Montant Intérêt sur Prêt" /
                InvPostingBuffer[1]."Montant Intérêt sur Prêt (DS)", 0.000000000001)
            ELSE
                GenJnlLine."Currency Factor" := 1;
            // MESSAGE(' source type %1',InvPostingBuffer[1]."Source Type" );
            //IF  InvPostingBuffer[1]."Source Type" = 3 THEN
            //GenJnlLine.VALIDATE(Amount, PaymentHeader.Amount + InvPostingBuffer[1]."Montant Intérêt sur Prêt");

            GenJnlLine.VALIDATE(Amount, InvPostingBuffer[1]."Montant Intérêt sur Prêt");
            GenJnlLine.Correction := InvPostingBuffer[1].Correction;
            //>>>MBK:24/11/2010
            GenJnlLine."Type origine entêt" := PaymentHeader."Account Type";
            GenJnlLine."Code origine entêt" := PaymentHeader."Account No.";

            //>>>MBK:24/11/2010
            IF Step."Source Code" <> '' THEN BEGIN
                Step.TESTFIELD("Source Code");
                TestSourceCode(Step."Source Code");
                GenJnlLine."Source Code" := Step."Source Code";
                PaymentHeader."Source Code" := Step."Source Code";
            END
            ELSE BEGIN
                TestSourceCode(PaymentHeader."Source Code");
                GenJnlLine."Source Code" := PaymentHeader."Source Code";
            END;
            /* IF PaymentHeader."Source Code" <> '' THEN BEGIN
                 TestSourceCode(PaymentHeader."Source Code");
                 GenJnlLine."Source Code" := PaymentHeader."Source Code";
             END ELSE BEGIN
                 Step.TESTFIELD("Source Code");
                 TestSourceCode(Step."Source Code");
                 GenJnlLine."Source Code" := Step."Source Code";
             END;*/
            GenJnlLine."Applies-to Doc. Type" := InvPostingBuffer[1]."Applies-to Doc. Type";
            GenJnlLine."Applies-to Doc. No." := InvPostingBuffer[1]."Applies-to Doc. No.";
            IF GenJnlLine."Applies-to Doc. No." = '' THEN
                GenJnlLine."Applies-to ID" := InvPostingBuffer[1]."Applies-to ID";
            GenJnlLine."Posting Group" := InvPostingBuffer[1]."Posting Group";
            GenJnlLine."Source Type" := InvPostingBuffer[1]."Source Type";
            GenJnlLine."Source No." := InvPostingBuffer[1]."Source No.";
            GenJnlLine."External Document No." := InvPostingBuffer[1]."External Document No.";
            GenJnlLine."Due Date" := InvPostingBuffer[1]."Due Date";
            GenJnlLine."Shortcut Dimension 1 Code" := InvPostingBuffer[1]."Global Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := InvPostingBuffer[1]."Global Dimension 2 Code";
            GenJnlLine.Description := 'Interêt sur Prêt  ' + InvPostingBuffer[1].Commentaires;
            // TempJnlLineDim.DELETEALL;
            // TempDocDim.RESET;
            // TempDocDim.SETRANGE("Document Type", TempDocDim."Document Type"::" ");
            // TempDocDim.SETRANGE("Document No.", InvPostingBuffer[1]."Header Document No.");
            // TempDocDim.SETRANGE("Line No.", InvPostingBuffer[1]."Line No.");
            // IF InvPostingBuffer[1]."Line No." = 0 THEN
            //     TempDocDim.SETRANGE("Table ID", DATABASE::"Payment Header")
            // ELSE
            //     TempDocDim.SETRANGE("Table ID", DATABASE::"Payment Line");
            // DimMgt.CopyDocDimToJnlLineDim(TempDocDim, TempJnlLineDim);
            IF (ROUND(GenJnlLine."Amount (LCY)", GLsetup."Amount Rounding Precision") <> 0) THEN
                GenJnlPostLine.RunWithCheck(GenJnlLine);
        END;
        //<< IMS 02 06 2011 VALIDATION INTERET SUR PRET
        GLEntry.SetRange("Document Type", GenJnlLine."Document Type");
        GLEntry.SetRange("Document No.", GenJnlLine."Document No.");
        if GLEntry.FindLast() then
            exit(GLEntry."Entry No.");
        exit(0);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterApplication(StepLedger: Record "Payment Step Ledger"; var InvPostingBuffer: array[2] of Record "Payment Post. Buffer" temporary; PaymentHeader: Record "Payment Header"; PaymentLine: Record "Payment Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetDescriptionForInvPostingBuffer(var StepLedger: Record "Payment Step Ledger"; var PaymentLine: Record "Payment Line"; var Description: Text[98])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeProcessPaymentStep(PaymentHeaderNo: Code[20]; PaymentStep: Record "Payment Step"; PaymentLine: Record "Payment Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeProcessPaymentStepByActionType(var PaymentLine: Record "Payment Line"; PaymentStep: Record "Payment Step"; var ActionValidated: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCopyLigBorOnBeforeInitHeader(var ToBord: Record "Payment Header"; var Process: Record "Payment Class"; var i: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCopyLigBorOnBeforeToPaymentLineInsert(var ToPaymentLine: Record "Payment Line"; var Process: Record "Payment Class")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterProcessPaymentStep(PaymentHeaderNo: Code[20]; PaymentStep: Record "Payment Step")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnGenerEntriesOnBeforeGenJnlPostLineRunWithCheck(var GenJnlLine: Record "Gen. Journal Line"; PaymentHeader: Record "Payment Header"; StepLedger: Record "Payment Step Ledger")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnExportSEPACreditTransferOnAfterGenJnlLineSetFilters(var GenJnlLine: Record "Gen. Journal Line"; var XMLPortId: Integer; var PaymentHeader: Record "Payment Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnGenerInvPostingBufferOnBeforeUpdtBuffer(var InvPostingBuffer: array[2] of Record "Payment Post. Buffer" temporary; PaymentLine: Record "Payment Line"; StepLedger: Record "Payment Step Ledger")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnGenerInvPostingBufferOnAfterGetDescriptionForInvPostingBuffer(var StepLedger: record "Payment Step Ledger"; var PaymentHeader: record "Payment Header"; var PaymentLine: record "Payment Line"; var Description: Text[98])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostInvPostingBufferOnBeforeGenJnlPostLineRunWithCheck(var GenJnlLine: Record "Gen. Journal Line"; var PaymentHeader: Record "Payment Header"; var PaymentClass: Record "Payment Class")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnProcessPaymentStepOnCaseElse(var Step: Record "Payment Step"; var PaymentLine: Record "Payment Line"; var ActionValidated: Boolean; var PaymentHeader: Record "Payment Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnProcessPaymentStepOnAfterCheckPaymentStep(var PaymentStep: Record "Payment Step"; Var PaymentHeader: Record "Payment Header"; Var PaymentLine: Record "Payment Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnSetPostingGroupOnBeforeCheckPostingGroup(var PaymentLine: Record "Payment Line"; var StepLedger: record "Payment Step Ledger"; var PostingGroup: Code[20])
    begin
    end;
}

