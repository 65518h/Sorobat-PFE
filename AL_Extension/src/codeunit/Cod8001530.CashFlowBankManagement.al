Codeunit 8001530 "CashFlow Bank Management"
{
    //GL2024  ID dans Nav 2009 : "8001609"
    trigger OnRun()
    begin
    end;

    var
        TextTitre: label 'STOCK';
        TextTotal: label 'TOTAL';


    procedure CalculMnt(pBankAccount: Code[20]; pPeriodStart: Date; pPeriodEnd: Date; pLedgerType: Option Bancaire,Comptable,"En prévision",Tous; pBalanceType: Option "Net Change","Balance at Date"; pAroundFactor: Option Standard,"1","1000","1000000"; pDateOperation: Option "Operation Date","Value Date"; pCompany: Text[255]; pCurrLCYCode: Code[10]; pCurrencyDisplay: Code[10]) Return: Decimal
    var
        lDateFilter: Text[100];
        lCustomerAmount: Decimal;
        lVendorAmount: Decimal;
        lStockAmount: Decimal;
        lSimulAmount: Decimal;
        lBankLedgerBankAmount: Decimal;
        lBankLedgerAccountAmount: Decimal;
        lBqueLoc: Record "Bank Account";
        lValLoc: Decimal;
        lGenLedgSetup: Record "General Ledger Setup";
        lDevAffLoc: Code[10];
        lLocalCurrency: Record Currency;
        lCompany: Record Company;
    begin
        if pBalanceType = Pbalancetype::"Net Change" then
            lDateFilter := StrSubstNo('%1..%2', pPeriodStart, pPeriodEnd)
        else
            lDateFilter := StrSubstNo('%1..%2', 0D, pPeriodEnd);

        Return := 0;
        if pBankAccount = '' then
            exit;
        //Ecritures clients
        lCustomerAmount := GetCustomerAmt(pBankAccount, lDateFilter, pLedgerType, pDateOperation, pCompany);

        //Ecritures fournisseurs
        lVendorAmount := GetVendorAmt(pBankAccount, lDateFilter, pLedgerType, pDateOperation, pCompany);

        //Valeur Titre
        lStockAmount := GetStockAmt(pBankAccount, lDateFilter, pLedgerType, pCompany);

        //Ecriture de simulation
        lSimulAmount := GetSimulateAmt(pBankAccount, lDateFilter, pPeriodStart, pLedgerType,
                                        pDateOperation, pCompany, pCurrLCYCode, pCurrencyDisplay);

        //Ecritures banques
        lBankLedgerBankAmount := GetBankLedgerBankAmt(pBankAccount, lDateFilter, pPeriodStart, pLedgerType,
                                                       pDateOperation, pCompany, pCurrLCYCode, pCurrencyDisplay);
        lBankLedgerAccountAmount := GetBankLedgerAccountAmt(pBankAccount, lDateFilter, pPeriodStart, pLedgerType,
                                                       pDateOperation, pCompany, pCurrLCYCode, pCurrencyDisplay);


        if pCurrencyDisplay <> '' then
            lLocalCurrency.Get(pCurrencyDisplay)
        else
            lLocalCurrency."Amount Decimal Places" := lGenLedgSetup."Amount Decimal Places";
        Return := ROUND(lBankLedgerAccountAmount + lBankLedgerBankAmount + lSimulAmount + lCustomerAmount + lVendorAmount + lStockAmount);
        Return := fFormatMnt(Return, pAroundFactor);
    end;


    procedure GetBankLedgerAccountAmt(pBankAccount: Code[20]; pDateFilter: Text[255]; pPeriodStart: Date; pLedgerType: Option Bancaire,Comptable,"En prévision",Tous; pDateOperation: Option "Operation Date","Value Date"; pCompany: Text[255]; pCurrLCYCode: Code[10]; pCurrencyDisplay: Code[10]) Return: Decimal
    var
        lGenLedgSetup: Record "General Ledger Setup";
        lCashFlowSetup: Record "BAR : Setup Cash Flow";
        lCurrencyCode: Code[10];
        lBankAccount: Record "Bank Account";
        lBARBankAccount: Record "BAR : Bank Account";
        lBankAccountLoc: Record "Bank Account";
        lCompany: Record Company;
        lCurrencyExchRate: Record "Currency Exchange Rate";
    begin
        if pLedgerType in [Pledgertype::Tous, Pledgertype::Comptable] then begin
            //Ecriture compte bancaire
            lCompany.SetFilter(Name, pCompany);
            if lCompany.FindSet(false, false) then
                repeat
                    lBARBankAccount.Init;
                    lBankAccount.Reset;
                    lBankAccount.ChangeCompany(lCompany.Name);
                    if (pBankAccount <> TextTotal) then
                        lBankAccount.SetFilter("No.", pBankAccount);
                    if pDateOperation = Pdateoperation::"Operation Date" then
                        lBankAccount.SetFilter("Date Filter", pDateFilter)
                    else
                        lBankAccount.SetFilter("Due Date Filter", pDateFilter);
                    lBankAccount.SetRange("Open Filter", true);
                    if not lBankAccount.IsEmpty then begin
                        lBankAccount.FindSet(false, false);
                        repeat
                            if (lBARBankAccount."Bank Account No." <> lBankAccount."Bank Account No.") then begin
                                //lBARBankAccount.SETCURRENTKEY("Bank Branch No.","Agency Code","Bank Account No.",Company,"Bank Account No.");
                                lBARBankAccount.SetCurrentkey(Iban, Company, "Bank Account No.");
                                lBARBankAccount.SetRange(Company, lCompany.Name);
                                lBARBankAccount.SetRange("Bank Account No.", lBankAccount."No.");
                                lBARBankAccount.FindFirst;
                            end;
                            if not lBARBankAccount."Excluded From Cash Flow" then begin
                                lBankAccount.CalcFields("Net Change (LCY)");
                                lGenLedgSetup.ChangeCompany(lCompany.Name);
                                lGenLedgSetup.Get;
                                if pCurrLCYCode = lGenLedgSetup."LCY Code" then
                                    lCurrencyCode := ''
                                else
                                    lCurrencyCode := lGenLedgSetup."LCY Code";
                                Return += lCurrencyExchRate.ExchangeAmtFCYToFCY(
                                  pPeriodStart, lCurrencyCode, pCurrencyDisplay, lBankAccount."Net Change (LCY)");
                            end;
                        until lBankAccount.Next = 0;
                    end;
                until lCompany.Next = 0;
        end;
    end;


    procedure GetBankLedgerBankAmt(pBankAccount: Code[20]; pDateFilter: Text[255]; pPeriodStart: Date; pLedgerType: Option Bancaire,Comptable,"En prévision",Tous; pDateOperation: Option "Operation Date","Value Date"; pCompany: Text[255]; pCurrLCYCode: Code[10]; pCurrencyDisplay: Code[10]) Return: Decimal
    var
        lGenLedgSetup: Record "General Ledger Setup";
        lCashFlowSetup: Record "BAR : Setup Cash Flow";
        lCurrencyCode: Code[10];
        lBankAccount: Record "Bank Account";
        lBARBankAccount: Record "BAR : Bank Account";
        lBankAccountLoc: Record "Bank Account";
        lCompany: Record Company;
        lCurrencyExchRate: Record "Currency Exchange Rate";
        lTmpAmount: Decimal;
        lBankAccountCode: Text[1024];
    begin
        if pLedgerType in [Pledgertype::Bancaire, Pledgertype::Tous] then begin
            lBARBankAccount.Reset;
            //lBARBankAccount.SETCURRENTKEY("Bank Branch No.","Agency Code","Bank Account No.",Company,"Bank Account No.");
            lBARBankAccount.SetCurrentkey(Iban, Company, "Bank Account No.");
            lBARBankAccount.SetFilter(Company, pCompany);
            lBARBankAccount.SetRange("Excluded From Import", false);
            lBARBankAccount.SetRange("Excluded From Cash Flow", false);
            if (pBankAccount <> TextTotal) then
                lBARBankAccount.SetFilter("Bank Account No.", pBankAccount);
            lBARBankAccount.SetFilter("Date Filter", pDateFilter);
            lBankAccountCode := '';
            if not lBARBankAccount.IsEmpty then begin
                lBARBankAccount.FindSet(false, false);
                repeat
                    if lBankAccountCode = '' then
                        lBankAccountCode := lBARBankAccount."Bank Account No."
                    else
                        if (StrPos(lBankAccountCode, '|' + lBARBankAccount."Bank Account No.") = 0) and
                           (StrPos(lBankAccountCode, lBARBankAccount."Bank Account No." + '|') = 0) and
                           (lBankAccountCode <> lBARBankAccount."Bank Account No.") then
                            lBankAccountCode += '|' + lBARBankAccount."Bank Account No.";
                    lTmpAmount := 0;
                    if pDateOperation = Pdateoperation::"Operation Date" then begin
                        lBARBankAccount.CalcFields(lBARBankAccount."Net Operation");
                        lTmpAmount := lBARBankAccount."Net Operation";
                    end else begin
                        lBARBankAccount.CalcFields(lBARBankAccount."Net Value");
                        lTmpAmount := lBARBankAccount."Net Value";
                    end;
                    lGenLedgSetup.ChangeCompany(lBARBankAccount.Company);
                    lGenLedgSetup.Get;
                    lBankAccountLoc.ChangeCompany(lBARBankAccount.Company);
                    lBankAccountLoc.Get(lBARBankAccount."Bank Account No.");
                    if pCurrLCYCode <> lGenLedgSetup."LCY Code" then begin
                        if lBankAccountLoc."Currency Code" = '' then
                            lBankAccountLoc."Currency Code" := lGenLedgSetup."LCY Code"
                        else
                            if lBankAccountLoc."Currency Code" = pCurrLCYCode then
                                lBankAccountLoc."Currency Code" := '';
                    end;
                    Return +=
                      lCurrencyExchRate.ExchangeAmtFCYToFCY(pPeriodStart, lBankAccountLoc."Currency Code", pCurrencyDisplay, lTmpAmount);
                until lBARBankAccount.Next = 0;
            end;
        end;
    end;


    procedure GetSimulateAmt(pBankAccount: Code[20]; pDateFilter: Text[100]; pPeriodStart: Date; pLedgerType: Option Bancaire,Comptable,"En prévision",Tous; pDateOperation: Option "Operation Date","Value Date"; pCompany: Text[255]; pCurrLCYCode: Code[10]; pCurrencyDisplay: Code[10]) Return: Decimal
    var
        lGenLedgSetup: Record "General Ledger Setup";
        lCashFlowSetup: Record "BAR : Setup Cash Flow";
        lCurrencyCode: Code[10];
        lBankAccount: Record "Bank Account";
        lBARBankAccount: Record "BAR : Bank Account";
        lGenJournalLine: Record "Gen. Journal Line";
        lCompany: Record Company;
        lCurrencyExchRate: Record "Currency Exchange Rate";
        lCustomer: Record Customer;
        lVendor: Record Vendor;
    begin
        if pLedgerType in [Pledgertype::"En prévision", Pledgertype::Tous] then begin
            //Ecriture de simulation
            lCompany.SetFilter(Name, pCompany);
            if lCompany.FindSet(false, false) then
                repeat
                    lGenLedgSetup.ChangeCompany(lCompany.Name);
                    lGenLedgSetup.Get;
                    lCashFlowSetup.ChangeCompany(lCompany.Name);
                    lCashFlowSetup.Get;
                    if pCurrLCYCode = lGenLedgSetup."LCY Code" then
                        lCurrencyCode := ''
                    else
                        lCurrencyCode := lGenLedgSetup."LCY Code";
                    lBARBankAccount.Init;
                    lBankAccount.Reset;
                    lBankAccount.ChangeCompany(lCompany.Name);
                    if (pBankAccount <> TextTotal) then
                        lBankAccount.SetFilter("No.", pBankAccount);
                    lBankAccount.SetFilter("Date Filter", pDateFilter);
                    lBankAccount.SetRange("Journal Template Name Filter", lCashFlowSetup."Journal Templates");
                    if not lBankAccount.IsEmpty then begin
                        lBankAccount.FindSet(false, false);
                        repeat
                            if (lBARBankAccount."Bank Account No." <> lBankAccount."Bank Account No.") then begin
                                lBARBankAccount.SetCurrentkey(Iban, Company, "Bank Account No.");
                                lBARBankAccount.SetRange(Company, lCompany.Name);
                                lBARBankAccount.SetRange("Bank Account No.", lBankAccount."No.");
                                lBARBankAccount.FindFirst;
                            end;
                            if not lBARBankAccount."Excluded From Cash Flow" then begin
                                lBankAccount.CalcFields("Simulation Amount (LCY)");
                                Return += lCurrencyExchRate.ExchangeAmtFCYToFCY(
                                  pPeriodStart, lCurrencyCode, pCurrencyDisplay, lBankAccount."Simulation Amount (LCY)");
                            end;
                        until lBankAccount.Next = 0;
                    end;
                    lGenJournalLine.ChangeCompany(lCompany.Name);
                    lGenJournalLine.SetCurrentkey("Journal Template Name", "Account Type");
                    lGenJournalLine.SetRange("Journal Template Name", lCashFlowSetup."Journal Templates");
                    if pDateOperation = Pdateoperation::"Operation Date" then
                        lGenJournalLine.SetFilter("Posting Date", pDateFilter)
                    else
                        lGenJournalLine.SetFilter("Value Date", pDateFilter);
                    if (pBankAccount = UpperCase(lCustomer.TableName)) or (pBankAccount = TextTotal) then begin
                        lGenJournalLine.SetRange("Account Type", lGenJournalLine."account type"::Customer);
                        if not lGenJournalLine.IsEmpty then begin
                            lGenJournalLine.CalcSums("Amount (LCY)");
                            Return += lCurrencyExchRate.ExchangeAmtFCYToFCY(
                              pPeriodStart, lCurrencyCode, pCurrencyDisplay, lGenJournalLine."Amount (LCY)");
                        end;
                    end;
                    if (pBankAccount = UpperCase(lVendor.TableName)) or (pBankAccount = TextTotal) then begin
                        lGenJournalLine.SetRange("Account Type", lGenJournalLine."account type"::Vendor);
                        if not lGenJournalLine.IsEmpty then begin
                            lGenJournalLine.CalcSums("Amount (LCY)");
                            Return += lCurrencyExchRate.ExchangeAmtFCYToFCY(
                              pPeriodStart, lCurrencyCode, pCurrencyDisplay, lGenJournalLine."Amount (LCY)");
                        end;
                    end;
                until lCompany.Next = 0;
        end;
    end;


    procedure GetCustomerAmt(pBankAccount: Code[20]; pDateFilter: Text[100]; pLedgerType: Option Bancaire,Comptable,"En prévision",Tous; pDateOperation: Option "Operation Date","Value Date"; pCompany: Text[255]) return: Decimal
    var
        lCompany: Record Company;
        lBARBankAccount: Record "BAR : Bank Account";
        lDetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        lCustomer: Record Customer;
    begin
        if (pLedgerType in [Pledgertype::Comptable, Pledgertype::Tous]) and
           ((pBankAccount = UpperCase(lCustomer.TableName)) or
            (pBankAccount = TextTotal)) then begin
            lCompany.SetFilter(Name, pCompany);
            if lCompany.FindSet(false, false) then
                repeat
                    lBARBankAccount.SetRange(Company, lCompany.Name);
                    lBARBankAccount.SetRange("Bank Account No.", UpperCase(lCustomer.TableName));
                    if not (not lBARBankAccount.FindFirst or lBARBankAccount."Excluded From Cash Flow") then begin
                        lDetailedCustLedgEntry.Reset;
                        lDetailedCustLedgEntry.ChangeCompany(lCompany.Name);
                        if pDateOperation = Pdateoperation::"Operation Date" then begin
                            lDetailedCustLedgEntry.SetCurrentkey("Customer No.", "Posting Date");
                            lDetailedCustLedgEntry.SetFilter("Posting Date", pDateFilter);
                        end else begin
                            lDetailedCustLedgEntry.SetCurrentkey("Customer No.", "Value Date", "Currency Code");
                            lDetailedCustLedgEntry.SetFilter("Value Date", pDateFilter);
                        end;
                        if not lDetailedCustLedgEntry.IsEmpty then begin
                            lDetailedCustLedgEntry.CalcSums("Amount (LCY)");
                            return += lDetailedCustLedgEntry."Amount (LCY)";
                        end;
                    end;
                until lCompany.Next = 0;
        end;
    end;


    procedure GetVendorAmt(pBankAccount: Code[20]; pDateFilter: Text[100]; pLedgerType: Option Bancaire,Comptable,"En prévision",Tous; pDateOperation: Option "Operation Date","Value Date"; pCompany: Text[255]) return: Decimal
    var
        lCompany: Record Company;
        lBARBankAccount: Record "BAR : Bank Account";
        lDetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        lVendor: Record Vendor;
    begin
        if (pLedgerType in [Pledgertype::Comptable, Pledgertype::Tous]) and
           ((pBankAccount = UpperCase(lVendor.TableName)) or
            (pBankAccount = TextTotal)) then begin
            lCompany.SetFilter(Name, pCompany);
            if lCompany.FindSet(false, false) then
                repeat
                    lBARBankAccount.SetRange(Company, lCompany.Name);
                    lBARBankAccount.SetRange("Bank Account No.", UpperCase(lVendor.TableName));
                    if not (not lBARBankAccount.FindFirst or lBARBankAccount."Excluded From Cash Flow") then begin
                        lDetailedVendorLedgEntry.Reset;
                        lDetailedVendorLedgEntry.ChangeCompany(lCompany.Name);
                        if pDateOperation = Pdateoperation::"Operation Date" then begin
                            lDetailedVendorLedgEntry.SetCurrentkey("Vendor No.", "Posting Date");
                            lDetailedVendorLedgEntry.SetFilter("Posting Date", pDateFilter);
                        end else begin
                            lDetailedVendorLedgEntry.SetCurrentkey("Vendor No.", "Value Date", "Currency Code");
                            lDetailedVendorLedgEntry.SetFilter("Value Date", pDateFilter);
                        end;
                        if not lDetailedVendorLedgEntry.IsEmpty then begin
                            lDetailedVendorLedgEntry.CalcSums("Amount (LCY)");
                            return += lDetailedVendorLedgEntry."Amount (LCY)";
                        end;
                    end;
                until lCompany.Next = 0;
        end;
    end;


    procedure GetStockAmt(pBankAccount: Code[20]; pDateFilter: Text[100]; pLedgerType: Option Bancaire,Comptable,"En prévision",Tous; pCompany: Text[255]) return: Decimal
    var
        lCompany: Record Company;
        lBARBankAccount: Record "BAR : Bank Account";
        lStockHeader: Record "Stock Header";
        lStockValue: Record "Stock Price Register";
    begin
        if (pLedgerType in [Pledgertype::Comptable, Pledgertype::Tous]) and
           ((pBankAccount = UpperCase(TextTitre)) or
            (pBankAccount = TextTotal)) then begin
            lCompany.SetFilter(Name, pCompany);
            if lCompany.FindSet(false, false) then
                repeat
                    lBARBankAccount.SetRange(Company, lCompany.Name);
                    lBARBankAccount.SetRange("Bank Account No.", UpperCase(TextTitre));
                    if not (not lBARBankAccount.FindFirst or lBARBankAccount."Excluded From Cash Flow") then begin
                        lStockHeader.Reset;
                        lStockValue.ChangeCompany(lCompany.Name);
                        lStockHeader.ChangeCompany(lCompany.Name);
                        lStockHeader.SetFilter("Date Filter", pDateFilter);
                        if not lStockHeader.IsEmpty then begin
                            lStockHeader.FindSet(false, false);
                            repeat
                                lStockHeader.CalcFields("Number of Shares");
                                if lStockHeader."Number of Shares" <> 0 then
                                    return += lStockHeader."Number of Shares" *
                                      lStockValue.SearchValue(lStockHeader.Code, lStockHeader.GetRangemax("Date Filter"), true);
                            until lStockHeader.Next = 0;
                        end;
                    end;
                until lCompany.Next = 0;
        end;
    end;

    local procedure fFormatMnt(var pAmount: Decimal; pAroundFactor: Option Standard,"1","1000","1000000") Return: Decimal
    begin
        if (pAmount = 0) then
            exit(0);
        case pAroundFactor of
            Paroundfactor::"1":
                Return := ROUND(pAmount, 1);
            Paroundfactor::"1000":
                Return := ROUND(pAmount / 1000, 0.1);
            Paroundfactor::"1000000":
                Return := ROUND(pAmount / 1000000, 0.1);
            else
                Return := pAmount;
        end;
    end;


    procedure fFormatTitle(pNbreSoc: Integer; pCompany: Text[255]; pAccount: Text[255]) Return: Text[1024]
    var
        lCust: Record Customer;
        lVendor: Record Vendor;
        TextTitre: label 'Stock';
    begin
        if pNbreSoc > 1 then
            Return := pCompany + '\';

        case pAccount of
            UpperCase(lCust.TableName), lCust.TableName:
                Return := Return + lCust.TableCaption;
            UpperCase(lVendor.TableName), lVendor.TableName:
                Return := Return + lVendor.TableCaption;
            'STOCK':
                Return := Return + TextTitre;
            else
                Return := Return + pAccount;
        end;
    end;
}

