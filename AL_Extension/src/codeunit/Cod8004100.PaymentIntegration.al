Codeunit 8004100 "Payment Integration"
{
    // #8807 SD 24/02/11
    // +PMT+ AC 19/11/10
    //         --- GJL : General Journal Entry ---
    //         *GJLPmtTypeOnValidate*
    //         *GJLSetPmtBankAcc*  Option pType (Client ou Vendeur);
    //         *GJLSetBillType*
    //         *GJLSetBankPaymentType*
    //         *GJLSetReasonCode* Fonction appelée dans la table 81 permettant d'initialiser le code motif
    //         *GJLCheckBalBankAccount* Fonction qui contrôle la devise
    //                                Initialisation de la date d'échéance en fonction du type de banque " "
    //         --- CBA : Customer Bank Account ---
    //         *CBAPmtTypeOnValidate* Modification de la banque par défaut du client
    //         --- VBA : Vendor Bank Account ---
    //         *VBAPmtTypeOnValidate* Modification de la banque par défaut du fournisseur
    //         --- BPT : Bank Payment Type ---
    //         *BPTCheckExportType* Contrôle de la cohérence du paramétrage du type d'export
    //         --- général---
    //         *GetIBANFromBank* = retourne l'IBAN d'un compte banquaire
    //         *GetSWIFTFromBank* = retourne le code SWIFT d'un compte banquaire
    //         *GetIBANFromBankAccType* = retourne l'IBAN d'un compte banquaire associé à une tiers
    //         *SWIFTFromBankTiersAccType* = retourne le code SWIFT d'un compte banquaire associé à une tiers
    //         *GetCurrencyCode* : Retourne la devise par défaut du compte bancaire
    //         *lFormatIBAN* : Formatage de l'IBAN au Format SEPA
    //         *lFormatSWIFTCode* : Formatage du code SWIFT au Format SEPA


    trigger OnRun()
    begin
    end;

    var
        tOptionError: label 'Option not supported';


    procedure GJLPmtTypeOnValidate(var pRec: Record "Gen. Journal Line"; PxRec: Record "Gen. Journal Line")
    var
        lVend: Record Vendor;
    begin
        if pRec."Payment Type" <> 0 then
            pRec."Bank Payment Type" := pRec."bank payment type"::"Computer Check"
        else
            pRec."Bank Payment Type" := 0;
        if pRec."Payment Type" = pRec."payment type"::Transfer then
            pRec.TestField("Payment Bank Account");
        if pRec."Payment Type" <> PxRec."Payment Type" then
            GJLSetReasonCode(pRec);
        //#6683
        if (pRec."Account Type" = pRec."account type"::Vendor) then begin
            lVend.Get(pRec."Account No.");
            GJLSetBillType(pRec, lVend."Payment Method Code");
            if (pRec."Payment Type" = pRec."payment type"::Bill) and (pRec."Bill Type" = pRec."bill type"::" ") then
                pRec."Bill Type" := pRec."bill type"::"Not Accepted"
        end;
    end;


    procedure GJLSetPmtBankAcc(var pGenJournalLine: Record "Gen. Journal Line"; pNo: Code[20]; pType: Option Customer,Vendor)
    var
        lPaymentMgt: Codeunit "Payment Management1";
    begin
        case pType of
            Ptype::Customer:
                pGenJournalLine.Validate("Payment Bank Account", lPaymentMgt.GetCustDefBankCode(pNo));
            Ptype::Vendor:
                pGenJournalLine.Validate("Payment Bank Account", lPaymentMgt.GetVendDefBankCode(pNo));
            else
                Error(tOptionError);
        end;
    end;


    procedure GJLSetBillType(var pGenJournalLine: Record "Gen. Journal Line"; pPmtMethodCode: Code[20])
    var
        lPaymentMethod: Record "Payment Method";
    begin
        if lPaymentMethod.Get(pPmtMethodCode) then
            pGenJournalLine."Bill Type" := lPaymentMethod."Bill Type";
    end;


    procedure GJLSetBankPaymentType(var pGenJournalLine: Record "Gen. Journal Line"; pxGenJournalLine: Record "Gen. Journal Line")
    begin
        if pGenJournalLine."Payment Type" <> 0 then
            pGenJournalLine."Bank Payment Type" := pGenJournalLine."bank payment type"::"Computer Check"
        else
            pGenJournalLine."Bank Payment Type" := 0;
        if pGenJournalLine."Payment Type" = pGenJournalLine."payment type"::Transfer then
            pGenJournalLine.TestField("Payment Bank Account");
        if pGenJournalLine."Payment Type" <> pxGenJournalLine."Payment Type" then
            GJLSetReasonCode(pGenJournalLine);
    end;


    procedure GJLSetReasonCode(var pGenJournalLine: Record "Gen. Journal Line")
    var
        lBankPaymentType: Record "Bank Payment Type";
    begin
        if not (pGenJournalLine."Payment Type" = pGenJournalLine."payment type"::" ") then begin
            if pGenJournalLine."Bal. Account No." <> '' then
                lBankPaymentType.Get(pGenJournalLine."Bal. Account No.", pGenJournalLine."Payment Type");
            if lBankPaymentType."Reason Code" <> '' then
                pGenJournalLine."Reason Code" := lBankPaymentType."Reason Code";
        end;
    end;


    procedure GJLCheckBalBankAccount(var pGenJournalLine: Record "Gen. Journal Line")
    var
        lBalBankAccount: Record "Bank Account";
        tDifferentCurrency: label 'The currency must be the same one as the currency of the bank %1.';
    begin
        if pGenJournalLine."Bal. Account Type" = pGenJournalLine."bal. account type"::"Bank Account" then begin
            if lBalBankAccount.Get(pGenJournalLine."Bal. Account No.") then
                if (pGenJournalLine."Due Date" = 0D) and (lBalBankAccount."Bank Type" = lBalBankAccount."bank type"::" ") then
                    pGenJournalLine.Validate("Due Date", pGenJournalLine."Document Date");
            if (lBalBankAccount."Currency Code" <> pGenJournalLine."Currency Code") and
               (lBalBankAccount."Bank Type" = lBalBankAccount."bank type"::Receivable) then
                Error(tDifferentCurrency, lBalBankAccount."Currency Code");
        end;
    end;


    procedure CBABankAccOnValidate(var pRec: Record "Customer Bank Account"; pxRec: Record "Customer Bank Account")
    var
        lCustomerBankAccount: Record "Customer Bank Account";
    begin
        if pRec."Default Account" then begin
            lCustomerBankAccount.SetRange("Customer No.", pRec."Customer No.");
            lCustomerBankAccount.SetRange("Default Account", true);
            if lCustomerBankAccount.FindFirst then begin
                lCustomerBankAccount."Default Account" := false;
                lCustomerBankAccount.Modify;
            end;
        end;
    end;


    procedure VBABankAccOnValidate(var pRec: Record "Vendor Bank Account"; pxRec: Record "Vendor Bank Account")
    var
        lVendorBankAccount: Record "Vendor Bank Account";
    begin
        if pRec."Default Bank Account" then begin
            lVendorBankAccount.SetRange("Vendor No.", pRec."Vendor No.");
            lVendorBankAccount.SetRange("Default Bank Account", true);
            if lVendorBankAccount.FindFirst then begin
                lVendorBankAccount."Default Bank Account" := false;
                lVendorBankAccount.Modify;
            end;
        end;
    end;


    procedure BPTCheckExportType(var pRec: Record "Bank Payment Type"; pxRec: Record "Bank Payment Type")
    var
        tMustBe: label '%1 must be %2 or %3.';
        texportType: label 'ISABEL or ETEBAC Export Type can be select only for "Transfert" and "Direct Debit" payment Type.';
        lOpt1: Text[30];
        lOpt2: Text[30];
        lBankPaymentType: Record "Bank Payment Type";
    begin
        if pRec."Export Type" in [pRec."export type"::VCOM1000, pRec."export type"::"VCOM400-SG", pRec."export type"::"VCOM400-CL"] then
            pRec.TestField("Payment Type", pRec."payment type"::VCOM);

        if pRec."Export Type" in [pRec."export type"::CFONB160, pRec."export type"::ISABEL] then
            if not (pRec."Payment Type" in [pRec."payment type"::Transfer, pRec."payment type"::"Direct Debit"]) then
                Error(texportType);

        if not (pRec."Payment Type" in [pRec."payment type"::Transfer, pRec."payment type"::"Direct Debit",
                                        pRec."payment type"::VCOM]) then begin
            lBankPaymentType."Payment Type" := pRec."payment type"::Transfer;  //virement
            lOpt1 := Format(lBankPaymentType."Payment Type");
            lBankPaymentType."Payment Type" := pRec."payment type"::"Direct Debit";//prelevement
            lOpt2 := Format(lBankPaymentType."Payment Type");
            Error(tMustBe, pRec.FieldCaption("Payment Type"), lOpt1, lOpt2);
        end;
    end;


    procedure GetIBANFromBank(pBankAccountNo: Code[20]): Code[50]
    var
        lBankAccount: Record "Bank Account";
    begin
        lBankAccount.Get(pBankAccountNo);
        exit(lFormatIBAN(lBankAccount.Iban));
    end;


    procedure GetSWIFTFromBank(pBankAccountNo: Code[20]): Code[20]
    var
        lBankAccount: Record "Bank Account";
    begin
        lBankAccount.Get(pBankAccountNo);
        exit(lFormatSWIFTCode(lBankAccount."SWIFT Code"));
    end;


    procedure GetIBANFromBankAccType(pAccType: Option " 0",Customer,Vendor,"2"; pAccNo: Code[20]; pBankAcc: Code[20]): Code[50]
    var
        lCustomerBankAccount: Record "Customer Bank Account";
        lVendorBankAccount: Record "Vendor Bank Account";
    begin
        case pAccType of
            Pacctype::Customer:
                begin
                    lCustomerBankAccount.Get(pAccNo, pBankAcc);
                    exit(lFormatIBAN(lCustomerBankAccount.Iban));
                end;
            Pacctype::Vendor:
                begin
                    lVendorBankAccount.Get(pAccNo, pBankAcc);
                    exit(lFormatIBAN(lVendorBankAccount.Iban));
                end;
        end;
    end;


    procedure SWIFTFromBankTiersAccType(pAccType: Option " 0",Customer,Vendor,"2"; pAccNo: Code[20]; pBankAcc: Code[20]): Code[20]
    var
        lCustomerBankAccount: Record "Customer Bank Account";
        lVendorBankAccount: Record "Vendor Bank Account";
    begin
        case pAccType of
            Pacctype::Customer:
                begin
                    lCustomerBankAccount.Get(pAccNo, pBankAcc);
                    exit(lFormatSWIFTCode(lCustomerBankAccount."SWIFT Code"));
                end;
            Pacctype::Vendor:
                begin
                    lVendorBankAccount.Get(pAccNo, pBankAcc);
                    exit(lFormatSWIFTCode(lVendorBankAccount."SWIFT Code"));
                end;
        end;
    end;


    procedure GetCurrencyCode(pBankAcc: Code[20]): Code[10]
    var
        lBankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        lBankAccount: Record "Bank Account";
    begin
        lBankAccount.Get(pBankAcc);
        exit(lBankAccount."Currency Code");
    end;

    local procedure lFormatIBAN(pValue: Code[50]): Code[50]
    begin
        exit(DelChr(pValue, '=', ' '));
    end;

    local procedure lFormatSWIFTCode(pValue: Code[20]): Code[20]
    begin
        exit(DelChr(pValue, '=', ' '));
    end;
}

