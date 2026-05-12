Codeunit 70541 DtaMgt
{
    //GL2024  ID dans Nav 2009 : "3010541"
    // <changelog>
    //   <add id="CH9500" dev="SRYSER" date="2005-09-21" area="DT"
    //     releaseversion="CH4.00.02"  request="CH-START-400SP2-RENU">
    //     Renumber of Existing Functionality
    //     Swiss Electronic Payment System (DTA)</add>
    //   <change id="CH2310" dev="SRYSER" date="2005-10-11" area="DT"
    //     baseversion="CH4.00.02" releaseversion="CH4.00.02"  request="11742">
    //     Text Messages not ML Enabled because of _PmtType Var</change>
    //   <change id="CH2311" dev="SRYSER" date="2005-10-11" area="DT"
    //     baseversion="CH4.00.02" releaseversion="CH4.00.02"  request="11848">
    //     Text overflow in GetVendorBank</change>
    //   <change id="CH2312" dev="SRYSER" date="2005-11-02" area="DT"
    //     baseversion="CH4.00.02" releaseversion="CH4.00.02"  request="12406">
    //     Payment Slip CHF-ESR of Type 5-15</change>
    //   <change id="CH2313" dev="SRYSER" date="2006-05-18" area="DT"
    //     baseversion="CH4.00.02" releaseversion="CH4.00.03" feature="CH-START-400SP3">
    //     Corrected Text020 and Text021
    //     PurchHeadRefNoProcess The Error Message, parameters in wrong order</change>
    //   <change id="CH2314" dev="SRYSER" date="2006-05-18" area="DT"
    //     baseversion="CH4.00.03" releaseversion="CH5.00" feature="PSCORS1035">
    //     Key for table 25 changed because of CORE change</change>
    //   <change id="CH9115" dev="SRYSER" feature="PSCORS1300" date="2006-10-14" area="DT"
    //     baseversion="CH5.00" releaseversion="CH5.00">
    //     PreCall Cleanup</change>
    // </changelog>

    Permissions = TableData "Vendor Ledger Entry" = rm;

    trigger OnRun()
    begin
    end;

    var
        Text000: label 'The length of the Coding Line is not correct. It has %1 digits instead:\\';
        Text001: label '52 for ESR 9/27 \';
        Text002: label '42 for ESR+ 9/27 \';
        Text003: label '41 for ESR 9/16 \';
        Text004: label '31 for ESR+ 9/16 \';
        Text005: label '39 for ESR 5/15 \';
        Text006: label '22 for ESR+ 5/15 \';
        Text007: label '38 for Pmt. Bank \';
        Text008: label '10 for Pmt. Post.';
        Text009: label 'No vendor bank was found for payment type %1 and vendor %2. \';
        Text010: label 'Select the vendor no. on the GL line and read the document again. \';
        Text011: label 'Navision will then try to find a bank based on the coding line.';
        Text012: label 'For vendor %1, no bank is defined with payment type %2.';
        Text013: label '\\Should Navision insert a vendor bank with bank code %2 and payment type %2?';
        Text015: label 'For vendor %1, bank %2 has been created.\\';
        Text016: label 'Do you want to see the bank card to check the entry or to add balance account, bank acount no. or position of invoice number?';
        Text018: label 'There are multiple vendor banks with payment type %1 and account %2.\\';
        Text019: label 'Select an entry from the list.';
        Text020: label 'Vendor bank "%1" for vendor %2 no found.';
        Text021: label 'Referece numbers are only permitted for ESR and ESR+. \';
        Text022: label 'For vendor %1, bankcode %2 with payment type %3 is defined.';
        Text023: label 'The check digit is only used for ESR type 5/15.';
        Text024: label 'Referece numbers are only permitted for ESR and ESR+. Vendor %1 has bankcode %2 with payment type %3.';
        Text026: label 'The reference number can contain max. %1 digits plus spaces.';
        Text027: label 'Expand the reference number to %1 digits?';
        Text028: label 'The reference number must have one of the following formats:\\';
        Text029: label 'With spaces: 71010 08830 11434 \';
        Text030: label 'Without spaces: 710100883011434 \';
        Text031: label 'Without leading zeros: 30123455 \\';
        Text032: label 'Leading zeros can be added automatically. \';
        Text033: label 'Spaces will be removed after correct entry.';
        Text036: label 'The reference bumber must have one of the following formats:\\';
        Text037: label 'With spaces: 90 00070 10034 18240 00083 30411 \';
        Text038: label 'Without spaces: 9000701003418240008330411 \';
        Text039: label 'Without leading zeros: 10 35542 51050 21204 02955 \\ ';
        Text040: label 'The check digit of the reference no. is invalid.';
        Text043: label 'With spaces: 3 13947 14300 09018 \';
        Text044: label 'Without spaces: 3139471430009018 \';
        Text045: label 'Without leading zeros: 89127 \';
        Text046: label 'Vendor bank %1 is not defined.';
        Text047: label 'The reference number may only be modified for payment type ESR and ESR+.';
        Text048: label 'The reference number may only be modified for ESR type 9/16 and 9/27.';
        Text058: label 'The check digit of coding line %1 must be %2.';
        Text070: label 'The check digit of the amount on the coding line is not correct.';
        Text071: label 'For vendor %1 and document %2, a reference number is defined. \';
        Text072: label 'The document type must be "Invoice".';
        Text073: label 'The vendor bank %1 for vendor %2 and document %3 is not defined.';
        Text074: label 'The vendor bank %1 for vendor %2 and document %3 %4 has payment type %5.\';
        Text075: label 'Invoices with payment type %5 must have a reference no. before posting.';
        Text076: label 'Vendor bank %1 for vendor %2 not found.';
        Text077: label '%1 %2 cannot be posted, because the referenc number is missing. \';
        Text078: label 'The selected vendor bank %3 had payment type %4.';
        Text079: label 'Invoice amount in document %1 based on the sum of purchase lines of %2 does not match with ESR amount %3 in the purchase header.\\';
        Text081: label 'You can modify quantity, prices oder discount on the purchase lines or add a Rounding Line. Check the result in the statistics form of invoice and order.';
        Text085: label 'File %1 could not be renamed.';
        Text086: label 'Temporary file $$DTA$$.TMP could not be deleted.';
        Text094: label 'No DTA bank of type EZAG is defined.';
        Text098: label 'Modify document number\';
        Text099: label 'New number: #1########';
        Text100: label 'Do you want to modify the document number on all lines from %1 to %2?';
        Text101: label 'Do you also want to modify the exrate for the other %1 lines with currency %2?';
        Text110: label 'You have entered a %1 ESR, the expected currency is %2.';
        Text114: label 'The ISO code %1 of currency %2 is invalid. It must have 3 characters.';
        Text115: label 'Payment type %1 is only allowed in %2. Vendor %3, Amount %4.';
        Text116: label 'Payment type %1 is not allowed for DTA.\Vendor: %2, Bank Code: %3.';
        VendBank: Record "Vendor Bank Account";
        VB2: Record "Vendor Bank Account";
        DtaSetup: Record "DTA Setup";
        GlLine: Record "Gen. Journal Line";
        GlSetup: Record "General Ledger Setup";
        Currency: Record Currency;
        //GL2024  BankMgt: Codeunit 11500;
        d: Dialog;
        RefNo: Text[30];
        ChkDig: Text[10];
        EsrAmt: Decimal;


    procedure CheckSetup()
    begin
        with DtaSetup do begin
            SetRange("DTA/EZAG", "dta/ezag"::DTA);
            if Find('-') then
                repeat
                    TestField("DTA Customer ID");
                    TestField("DTA Sender ID");
                    TestField("DTA Sender Clearing");
                    TestField("DTA Debit Acc. No.");
                    TestField("DTA Sender Name");
                    TestField("DTA Sender City");
                until Next = 0;
        end;
    end;


    procedure ProcessGlLine(var _GenJnlLine: Record "Gen. Journal Line"; _CodingLine: Text[70])
    var
        CurrExch: Record "Currency Exchange Rate";
        ESRTransactionCode: Integer;
    begin
        if _CodingLine = '' then
            exit;

        with _GenJnlLine do begin
            // CHeck Pmt Method, Amt, RefNo, CheckDig, Clear. Return in VendBank2
            ProcessCodingLine(_CodingLine);

            // Get Vendor Bank according to ESR/PostAcc/Clearing. Get Vendor No
            // VB2 Aux. Record für Para. Transfer. Fetched Bank is in Rec VB
            case VB2."Payment Form" of
                // CH2310.BEGIN
                // VB2."Payment Form"::ESR,VB2."Payment Form"::"ESR+":
                // GetVendorBank(VB2."Payment Form",VB2."ESR Account No.","Account No.");
                // VB2."Payment Form"::"Post Payment Domestic": GetVendorBank(VB2."Payment Form",VB2."Giro Account No.","Account No.");
                // VB2."Payment Form"::"Bank Payment Domestic": GetVendorBank(VB2."Payment Form",VB2."Clearing No.","Account No.");
                VB2."payment form"::ESR, VB2."payment form"::"ESR+":
                    GetVendorBank(VB2, VB2."ESR Account No.", "Account No.");
                VB2."payment form"::"Post Payment Domestic":
                    GetVendorBank(VB2, VB2."Giro Account No.", "Account No.");
                VB2."payment form"::"Bank Payment Domestic":
                    GetVendorBank(VB2, VB2."Clearing No.", "Account No.");
            // CH2310.END
            end;

            // Fill in GLL according to coding line and vendor bank
            Validate("Account Type", "account type"::Vendor);
            Validate("Account No.", VendBank."Vendor No.");
            Validate("Document Type", "document type"::Invoice);
            Validate("Bank Code", VendBank.Code);
            Validate("Reference No.", RefNo);  // CHeck ref. no. get ext. doc. no
            Validate(Checksum, ChkDig);
            Validate(Amount, -EsrAmt);
            Validate("Bal. Account Type", "bal. account type"::"G/L Account");
            Validate("Bal. Account No.", VendBank."Balance Account No.");

            if (StrLen(_CodingLine) > 12) and not (StrLen(_CodingLine) in [22, 39]) then begin
                Evaluate(ESRTransactionCode, CopyStr(DelChr(_CodingLine, '=', '<'), 1, 2));
                if ESRTransactionCode > 20 then begin
                    "Currency Code" := 'EUR';
                    "Currency Factor" := CurrExch.ExchangeRate("Posting Date", "Currency Code");
                    Validate(Amount);
                end;
                CheckEsrCurrency("Currency Code", _CodingLine);
            end;

        end;
    end;


    procedure ProcessPurchHeader(var _PurchHeader: Record "Purchase Header"; _CodingLine: Text[70])
    var
        CurrExch: Record "Currency Exchange Rate";
        ESRTransactionCode: Integer;
    begin
        if _CodingLine = '' then
            exit;

        with _PurchHeader do begin
            ProcessCodingLine(_CodingLine);
            // Get Vendor Bank
            case VB2."Payment Form" of
                // CH2310.BEGIN
                // VB2."Payment Form"::ESR,VB2."Payment Form"::"ESR+":
                // GetVendorBank(VB2."Payment Form",VB2."ESR Account No.","Pay-to Vendor No.");
                // VB2."Payment Form"::"Post Payment Domestic": GetVendorBank(VB2."Payment Form",VB2."Giro Account No.","Pay-to Vendor No.");
                // VB2."Payment Form"::"Bank Payment Domestic": GetVendorBank(VB2."Payment Form",VB2."Clearing No.","Pay-to Vendor No.");
                VB2."payment form"::ESR, VB2."payment form"::"ESR+":
                    GetVendorBank(VB2, VB2."ESR Account No.", "Pay-to Vendor No.");
                VB2."payment form"::"Post Payment Domestic":
                    GetVendorBank(VB2, VB2."Giro Account No.", "Pay-to Vendor No.");
                VB2."payment form"::"Bank Payment Domestic":
                    GetVendorBank(VB2, VB2."Clearing No.", "Pay-to Vendor No.");
            // CH2310.END
            end;

            // Fill in purch header based on codingline and vendor bank
            if "Buy-from Vendor No." = '' then begin
                Validate("Buy-from Vendor No.", VendBank."Vendor No.");

                Commit;
            end;
            Validate("Bank Code", VendBank.Code);
            Validate("Reference No.", RefNo);
            Validate(Checksum, ChkDig);
            Validate("ESR Amount", EsrAmt);

            // CH2312.BEGIN
            // CheckEsrCurrency("Currency Code",_CodingLine);
            if (StrLen(_CodingLine) > 12) and not (StrLen(_CodingLine) in [22, 39]) then begin
                Evaluate(ESRTransactionCode, CopyStr(DelChr(_CodingLine, '=', '<'), 1, 2));
                if ESRTransactionCode > 20 then begin
                    "Currency Code" := 'EUR';
                    "Currency Factor" := CurrExch.ExchangeRate("Posting Date", "Currency Code");
                    Validate(Amount);
                end;
                CheckEsrCurrency("Currency Code", _CodingLine);
            end;
            // CH2312.END
        end;
    end;

    local procedure ProcessCodingLine(var _CodingLine: Text[70])
    begin
        // Call from ProcessGlLine and ProcessPurchHeader
        // VB2: Aux. record for pmt type and return of account

        Clear(VB2);
        RefNo := '';
        ChkDig := '';
        EsrAmt := 0;

        _CodingLine := DelChr(_CodingLine);  // Delete spaces

        // Payment and ESR-Type according to Length
        case StrLen(_CodingLine) of

            52:
                begin  // ESR 9/27
                    VB2."ESR Type" := VB2."esr type"::"9/27";
                    VB2."Payment Form" := VB2."payment form"::ESR;
                    RefNo := CopyStr(_CodingLine, 15, 27);
                    VB2."ESR Account No." := CopyStr(_CodingLine, 43, 9);
                    CheckAmountChkDig := CopyStr(_CodingLine, 1, 13);
                    EsrAmt := AmountInDecimal(CopyStr(_CodingLine, 3, 10));
                end;

            42:
                begin  // ESR+ 9/27
                    VB2."ESR Type" := VB2."esr type"::"9/27";
                    VB2."Payment Form" := VB2."payment form"::"ESR+";
                    RefNo := CopyStr(_CodingLine, 5, 27);
                    VB2."ESR Account No." := CopyStr(_CodingLine, 33, 9);
                end;

            41:
                begin  // ESR 9/16
                    VB2."ESR Type" := VB2."esr type"::"9/16";
                    VB2."Payment Form" := VB2."payment form"::ESR;
                    RefNo := CopyStr(_CodingLine, 15, 16);
                    VB2."ESR Account No." := CopyStr(_CodingLine, 32, 9);
                    CheckAmountChkDig := CopyStr(_CodingLine, 1, 13);
                    EsrAmt := AmountInDecimal(CopyStr(_CodingLine, 3, 10));
                end;

            31:
                begin  // ESR+ 9/16
                    VB2."ESR Type" := VB2."esr type"::"9/16";
                    VB2."Payment Form" := VB2."payment form"::"ESR+";
                    RefNo := CopyStr(_CodingLine, 5, 16);
                    VB2."ESR Account No." := CopyStr(_CodingLine, 22, 9);
                end;

            39:
                begin  // ESR 5/15
                    VB2."ESR Type" := VB2."esr type"::"5/15";
                    VB2."Payment Form" := VB2."payment form"::ESR;
                    RefNo := CopyStr(_CodingLine, 18, 15);
                    ChkDig := CopyStr(_CodingLine, 2, 2);
                    VB2."ESR Account No." := CopyStr(_CodingLine, 34, 5);
                    EsrAmt := AmountInDecimal(CopyStr(_CodingLine, 8, 9));
                end;

            22:
                begin  // ESR+ 5/15
                    VB2."ESR Type" := VB2."esr type"::"5/15";
                    VB2."Payment Form" := VB2."payment form"::"ESR+";
                    RefNo := CopyStr(_CodingLine, 1, 15);
                    VB2."ESR Account No." := CopyStr(_CodingLine, 17, 5);
                end;

            38:
                begin  // EZ Bank
                    VB2."ESR Type" := VB2."esr type"::" ";
                    VB2."Payment Form" := VB2."payment form"::"Bank Payment Domestic";
                    VB2."Clearing No." := DelChr(CopyStr(_CodingLine, 31, 5), '<', '0');
                end;

            10:
                begin  // EZ Post
                    VB2."ESR Type" := VB2."esr type"::" ";
                    VB2."Payment Form" := VB2."payment form"::"Post Payment Domestic";
                    VB2."Giro Account No." := CopyStr(_CodingLine, 1, 9);
                end;

            else
                Error(Text000 + Text001 + Text002 + Text003 + Text004 + Text005 + Text006 + Text007 + Text008, StrLen(_CodingLine));
        end;
    end;


    procedure GetVendorBank(_VendorBankAccount: Record "Vendor Bank Account"; _AccNo: Text[20]; _VendorNo: Code[20])
    begin
        // Get Vendor and Bankcode based on ESR Account ID
        Clear(VendBank);

        // CH2310.BEGIN
        // IF _PmtType >= _PmtType::"Cash Outpayment Order Domestic" THEN
        if _VendorBankAccount."Payment Form" >= _VendorBankAccount."payment form"::"Cash Outpayment Order Domestic" then
            // CH2310.END
            exit;

        // CH2310.BEGIN
        // IF _PmtType <> _PmtType::"Bank Payment Domestic" THEN
        if _VendorBankAccount."Payment Form" <> _VendorBankAccount."payment form"::"Bank Payment Domestic" then
            // CH2310.END
            _AccNo := PostAccountInsertDash(_AccNo);

        if _VendorNo <> '' then
            VendBank.SetRange("Vendor No.", _VendorNo) // from GlLine
        else
            VendBank.SetCurrentkey("ESR Account No.");

        // CH2310.BEGIN
        // VendBank.SETRANGE("Payment Form",_PmtType);
        // CASE _PmtType OF
        // _PmtType::ESR,_PmtType::"ESR+": VendBank.SETRANGE("ESR Account No.",_AccNo);
        // _PmtType::"Post Payment Domestic": VendBank.SETRANGE("Giro Account No.",_AccNo);
        // _PmtType::"Bank Payment Domestic": VendBank.SETRANGE("Clearing No.",_AccNo);
        VendBank.SetRange("Payment Form", _VendorBankAccount."Payment Form");  // from Coding Line
        case _VendorBankAccount."Payment Form" of
            _VendorBankAccount."payment form"::ESR, _VendorBankAccount."payment form"::"ESR+":
                VendBank.SetRange("ESR Account No.", _AccNo);
            _VendorBankAccount."payment form"::"Post Payment Domestic":
                VendBank.SetRange("Giro Account No.", _AccNo);
            _VendorBankAccount."payment form"::"Bank Payment Domestic":
                VendBank.SetRange("Clearing No.", _AccNo);
        // CH2310.END
        end;

        case VendBank.Count of

            1:
                VendBank.Find('-');  // Only one entry with this account

            0:
                begin  // No bank and no vendor No.
                    if _VendorNo = '' then
                        // CH2310.BEGIN
                        // ERROR(Text009 + Text010 + Text011,_PmtType,_AccNo);
                        Error(Text009 + Text010 + Text011, _VendorBankAccount."Payment Form", _AccNo);
                    // CH2310.END

                    // Define Bank
                    // CH2310.BEGIN
                    // IF NOT CONFIRM(Text012 + Text013,TRUE,_VendorNo,_PmtType) THEN
                    if not Confirm(Text012 + Text013, true, _VendorNo, Format(_VendorBankAccount."Payment Form", -MaxStrLen(VendBank.Code))) then
                        // CH2310.END
                        exit;

                    Clear(VendBank);
                    VendBank."Vendor No." := _VendorNo;
                    // CH2310.BEGIN
                    // VendBank.Code := FORMAT(_PmtType);
                    // VendBank."Payment Form" := VB2."Payment Form";
                    // VendBank."ESR Type" := VB2."ESR Type";
                    // IF VB2."Giro Account No." <> '' THEN
                    // VendBank.VALIDATE("Giro Account No.",PostAccountInsertDash(VB2."Giro Account No."));
                    // IF VB2."ESR Account No." <> '' THEN
                    // VendBank.VALIDATE("ESR Account No.",PostAccountInsertDash(VB2."ESR Account No."));
                    // IF VB2."Clearing No." <> '' THEN
                    // VendBank.VALIDATE("Clearing No.",VB2."Clearing No.");
                    // VendBank.INSERT;

                    // IF CONFIRM(Text015 + Text016,TRUE,_VendorNo,_PmtType) THEN BEGIN
                    VendBank.Code := Format(_VendorBankAccount."Payment Form", -MaxStrLen(VendBank.Code));
                    VendBank."Payment Form" := _VendorBankAccount."Payment Form";
                    VendBank."ESR Type" := _VendorBankAccount."ESR Type";
                    if VB2."Giro Account No." <> '' then
                        VendBank.Validate("Giro Account No.", PostAccountInsertDash(_VendorBankAccount."Giro Account No."));
                    if VB2."ESR Account No." <> '' then
                        VendBank.Validate("ESR Account No.", PostAccountInsertDash(_VendorBankAccount."ESR Account No."));
                    if VB2."Clearing No." <> '' then
                        VendBank.Validate("Clearing No.", _VendorBankAccount."Clearing No.");
                    VendBank.Insert;

                    if Confirm(Text015 + Text016, true, _VendorNo, Format(_VendorBankAccount."Payment Form", -MaxStrLen(VendBank.Code))) then begin
                        // CH2310.END
                        Commit;
                        if Page.RunModal(Page::"Vendor Bank Account Card", VendBank) = Action::LookupOK then;
                    end;
                end

            else begin  // select from several banks with identical account
                        // CH2310.BEGIN
                        // MESSAGE(Text018 + Text019,_PmtType,_AccNo);
                Message(Text018 + Text019, _VendorBankAccount."Payment Form", _AccNo);
                // CH2310.END

                if Page.RunModal(Page::"Vendor Bank Account List", VendBank) = Action::LookupOK then;
            end;
        end;
    end;


    procedure ProcessGlRefNo(var _GLL: Record "Gen. Journal Line")
    var
        NewRefNo: Text[30];
    begin
        with _GLL do begin
            if "Reference No." = '' then
                exit;

            if not VendBank.Get("Account No.", "Bank Code") then
                Error(Text020, "Bank Code", "Account No.");

            // Ref. No only for ESR and ESR+
            if VendBank."Payment Form" > 1 then
                Error(Text021 + Text022, "Account No.", "Bank Code", VendBank."Payment Form");

            // CHeck Digit only for ESR 5/15
            if (Checksum <> '') and
               ((VendBank."Payment Form" <> VendBank."payment form"::ESR) or (VendBank."ESR Type" <> VendBank."esr type"::"5/15")) then
                Error(Text023);

            NewRefNo := CheckRefNo("Reference No.", Checksum, Amount);

            if VendBank."Invoice No. Startposition" > 0 then
                "External Document No." := CopyStr(NewRefNo, VendBank."Invoice No. Startposition", VendBank."Invoice No. Length");

            "Reference No." := NewRefNo;
        end;
    end;


    procedure PurchHeadRefNoProcess(var _PurchHead: Record "Purchase Header")
    var
        NewRefNo: Text[30];
    begin
        with _PurchHead do begin
            if "Reference No." = '' then
                exit;

            if not VendBank.Get("Pay-to Vendor No.", "Bank Code") then
                Error(Text020, "Bank Code", "Pay-to Vendor No.");

            // Ref. No only for ESR and ESR+
            if VendBank."Payment Form" > 1 then
                Error(Text024, "Pay-to Vendor No.", "Bank Code", VendBank."Payment Form");

            // CHeck Digit only for ESR 5/15
            if (Checksum <> '') and
               ((VendBank."Payment Form" <> VendBank."payment form"::ESR) or (VendBank."ESR Type" <> VendBank."esr type"::"5/15")) then
                Error(Text023);

            NewRefNo := CheckRefNo("Reference No.", Checksum, "ESR Amount");

            if VendBank."Invoice No. Startposition" > 0 then
                "Vendor Invoice No." := CopyStr(NewRefNo, VendBank."Invoice No. Startposition", VendBank."Invoice No. Length");

            "Reference No." := NewRefNo;
        end;
    end;


    procedure CheckRefNo(_RefNo: Text[35]; _ChkDig: Text[2]; _Amt: Decimal) NewRefNo: Text[30]
    var
        Teststring: Text[30];
    begin
        if _RefNo = '' then exit;

        // Test 15-Char Ref. Number
        if VendBank."ESR Type" = VendBank."esr type"::"5/15" then begin
            _RefNo := DelChr(_RefNo);
            if StrLen(_RefNo) > 15 then
                Error(Text026, 15);

            if StrLen(_RefNo) < 15 then
                if Confirm(Text027, true, 15) then
                    _RefNo := CopyStr('0000000000000000', 1, 15 - StrLen(_RefNo)) + _RefNo;

            if StrLen(_RefNo) <> 15 then
                Error(Text028 + Text029 + Text030 + Text031 + Text032 + Text033);

            if (_Amt <> 0) and (_ChkDig <> '') then
                Modulo11(_RefNo, _ChkDig, _Amt);
        end;

        // CHeck 27-Digit Ref. No.
        if VendBank."ESR Type" = VendBank."esr type"::"9/27" then begin
            _RefNo := DelChr(_RefNo);
            if StrLen(_RefNo) > 27 then
                Error(Text026, 27);

            if StrLen(_RefNo) < 27 then
                if Confirm(Text027, true, 27) then
                    _RefNo := CopyStr('000000000000000000000000000', 1, 27 - StrLen(_RefNo)) + _RefNo;

            if StrLen(_RefNo) <> 27 then
                Error(Text036 + Text037 + Text038 + Text039 + Text032 + Text033);

            _ChkDig := CopyStr(_RefNo, StrLen(_RefNo), 1);  // Get CheckDig
            Teststring := CopyStr(_RefNo, 1, StrLen(_RefNo) - 1);  // Without CheckDig

            /*GL2024   if _ChkDig <> BankMgt.CalcCheckDigit(Teststring) then
                   Error(Text040);*/
        end;

        // CHeck 27-Digit Ref. No.
        if VendBank."ESR Type" = VendBank."esr type"::"9/16" then begin
            _RefNo := DelChr(_RefNo);
            if StrLen(_RefNo) > 16 then
                Error(Text026, 16);

            if StrLen(_RefNo) < 16 then
                if Confirm(Text027, true, 16) then
                    _RefNo := CopyStr('0000000000000000', 1, 16 - StrLen(_RefNo)) + _RefNo;

            if StrLen(_RefNo) <> 16 then
                Error(Text036 + Text043 + Text044 + Text045 + Text032 + Text033);

            _ChkDig := CopyStr(_RefNo, StrLen(_RefNo), 1);  // Get CheckDig
            Teststring := CopyStr(_RefNo, 1, StrLen(_RefNo) - 1);  // Without CheckDig

            /* GL2024   if _ChkDig <> BankMgt.CalcCheckDigit(Teststring) then
                    Error(Text040);*/
        end;

        NewRefNo := _RefNo; // Return modified Ref. No.
    end;


    procedure VendLedgEntriesCheckRefNo(_VenLedgEnt: Record "Vendor Ledger Entry")
    var
        _ChkDig: Code[1];
        Teststring: Code[30];
    begin
        // CHeck corrected 16 or 27 digit ref. no in vendor ledger entries
        if not VendBank.Get(_VenLedgEnt."Vendor No.", _VenLedgEnt."Bank Code") then
            Error(Text046, _VenLedgEnt."Bank Code");

        if VendBank."Payment Form" > 1 then  // not ESR, ESR+
            Error(Text047);

        if VendBank."ESR Type" < 2 then  // empty or 5/15
            Error(Text048);

        _ChkDig := CopyStr(_VenLedgEnt."Reference No.", StrLen(_VenLedgEnt."Reference No."), 1);  // Get CheckDig
        Teststring := CopyStr(_VenLedgEnt."Reference No.", 1, StrLen(_VenLedgEnt."Reference No.") - 1);  // without CheckDig
                                                                                                         /* GL2024 if _ChkDig <> BankMgt.CalcCheckDigit(Teststring) then
                                                                                                               Error(Text040);*/
    end;


    procedure PostAccountInsertDash(_AccWithoutDash: Text[12]): Text[12]
    begin
        if StrLen(_AccWithoutDash) = 9 then
            exit(
              CopyStr(_AccWithoutDash, 1, 2) + '-' +
              CopyStr(_AccWithoutDash, 3, 6) + '-' +
              CopyStr(_AccWithoutDash, 9, 1));
        exit(_AccWithoutDash);  // 5/15
    end;


    procedure Modulo11(_RefNo: Text[30]; _ChkDig: Text[2]; _Amt: Decimal)
    var
        Mod11Input: Text[50];
        Mod11PZ: Text[2];
        AmtTxt: Text[15];
    begin
        // From Amt always, if not ESR+
        // Of Check11, if Ref and Amount are completed
        // Of Ref, if Chekc11 and Amount are completed

        AmtTxt := Format(_Amt * 100, 0, '<Integer>');  // Amount on 9 digits, leading 0
        AmtTxt := CopyStr('000000000', 1, 9 - StrLen(AmtTxt)) + AmtTxt;

        Mod11Input := '0001' + AmtTxt + _RefNo + VendBank."ESR Account No.";
        Mod11PZ := Format(StrCheckSum(Mod11Input, '432765432765432765432765432765432', 11));

        if StrLen(Mod11PZ) = 1 then
            Mod11PZ := '0' + Mod11PZ;  // leading 0
        if Mod11PZ <> _ChkDig then
            Error(Text058, Mod11Input, Mod11PZ);
    end;


    procedure CheckAmountChkDig(_AmtString: Text[20])
    var
        ChkDig: Text[2];
    begin
        ChkDig := CopyStr(_AmtString, 13, 1);
        _AmtString := CopyStr(_AmtString, 1, 12);
        /* GL2024   if ChkDig <> BankMgt.CalcCheckDigit(_AmtString) then
               Error(Text070);*/
    end;


    procedure AmountInDecimal(_AmtString: Text[20]) AmtDec: Decimal
    begin
        Evaluate(AmtDec, _AmtString);
        AmtDec := AmtDec / 100;
    end;


    procedure CheckVenorPost(_GLL: Record "Gen. Journal Line")
    begin
        // Ref No found when ESR Invoice posted?
        with _GLL do begin

            // Reset Wait Flag (for rest payment)
            ReleaseVendorLedgerEntries(_GLL);

            if ("Account Type" = "account type"::Vendor) and
               ("Reference No." <> '') and
               ("Document Type" <> "document type"::Invoice)
            then
                Error(Text071 + Text072, "Account No.", "Document No.");

            if ("Account Type" = "account type"::Vendor) and ("Document Type" = "document type"::Invoice) and ("Bank Code" <> '') then begin
                if not VendBank.Get("Account No.", "Bank Code") then
                    Error(Text073, "Bank Code", "Account No.", "Document No.");

                if (VendBank."Payment Form" in [VendBank."payment form"::ESR, VendBank."payment form"::"ESR+"]) and ("Reference No." = '') then
                    Error(Text074 + Text075, "Bank Code", "Account No.", "Document Type", "Document No.", VendBank."Payment Form");
            end;
        end;
    end;


    procedure TransferVendorGlLine(var _GLL: Record "Gen. Journal Line")
    var
        VendBank: Record "Vendor Bank Account";
        Vendor: Record Vendor;
        lVendorBankAccount: Record "Vendor Bank Account";
    begin
        // Transfer Vendor to Table 81, for Vendor Invoice
        if _GLL."Document Type" <> _GLL."document type"::Invoice then
            exit;

        Vendor.Get(_GLL."Account No.");
        if _GLL."Bank Code" = '' then  // if not filled in yet
                                       //+CH+
                                       //  _GLL."Bank Code" := Vendor."Standard Bank";
            lVendorBankAccount.SetRange("Vendor No.", _GLL."Account No.");
        if lVendorBankAccount.Find('-') and (lVendorBankAccount.Next = 0) then
            _GLL."Bank Code" := lVendorBankAccount.Code;
        //+CH+//

        if VendBank.Get(_GLL."Account No.", _GLL."Bank Code") then
            _GLL.Validate("Bal. Account No.", VendBank."Balance Account No.");
    end;


    procedure TransferPurchHeadGLL(var _PurchHead: Record "Purchase Header"; var _GLL: Record "Gen. Journal Line")
    begin
        // Transfer of PurchHead in GlLine in C90. ESR Info Transfer to GlLine
        if not _PurchHead.Invoice then
            exit;

        if not (_PurchHead."Document Type" in [_PurchHead."document type"::Order, _PurchHead."document type"::Invoice]) then
            exit;

        if _PurchHead."Bank Code" = '' then
            exit;

        if not VendBank.Get(_PurchHead."Pay-to Vendor No.", _PurchHead."Bank Code") then
            Error(Text076, _PurchHead."Bank Code", _PurchHead."Pay-to Vendor No.");

        // Ref no. defined for ESR?
        if VendBank."Payment Form" in [VendBank."payment form"::ESR, VendBank."payment form"::"ESR+"] then
            if _PurchHead."Reference No." = '' then
                Error(Text077 + Text078, _PurchHead."Document Type", _PurchHead."No.", _PurchHead."Bank Code", VendBank."Payment Form");

        if VendBank."Payment Form" = VendBank."payment form"::ESR then begin

            if -_GLL.Amount <> _PurchHead."ESR Amount" then
                Error(Text079 + Text081, _PurchHead."No.", -_GLL.Amount, _PurchHead."ESR Amount");
        end;

        _GLL."Bank Code" := _PurchHead."Bank Code";
        _GLL."Reference No." := _PurchHead."Reference No.";
        _GLL.Checksum := _PurchHead.Checksum;
    end;

    /*//GL2024 License
        procedure RemoveCrLf(_FileName: Text[70])
        var
            _SourceFile: File;
            _TargetFile: File;
            Z: Char;
        begin
            // Removes CR/LF in File. Rename Original file and write again w/o CR/LF.
            if not Rename(_FileName, '$$DTA$$.TMP') then
                Error(Text085, _FileName);

            _SourceFile.TextMode := false;
            _SourceFile.WriteMode := false;
            _SourceFile.Open('$$DTA$$.TMP');

            _TargetFile.TextMode := false;
            _TargetFile.WriteMode := true;
            _TargetFile.Create(_FileName);

            while _SourceFile.Read(Z) = 1 do begin
                if not (Z in [10, 13]) then
                    _TargetFile.Write(Z);
            end;

            _SourceFile.Close;
            if not Erase('$$DTA$$.TMP') then
                Error(Text086);
            _TargetFile.Close;
        end;
    //GL2024 License
    */
    procedure ReleaseVendorLedgerEntries(_GenJnlLine: Record "Gen. Journal Line")
    var
        VendEntry: Record "Vendor Ledger Entry";
    begin
        if (_GenJnlLine."Account Type" = _GenJnlLine."account type"::Vendor) and
           (_GenJnlLine."Document Type" = _GenJnlLine."document type"::Payment)
        then begin
            VendEntry.Reset;
            // CH2314.BEGIN
            VendEntry.SetCurrentkey("Document No.");
            // CH2314.BEGIN
            VendEntry.SetRange("Document Type", _GenJnlLine."Applies-to Doc. Type");
            VendEntry.SetRange("Document No.", _GenJnlLine."Applies-to Doc. No.");
            if VendEntry.Find('-') then begin
                if VendEntry."On Hold" = 'DTA' then begin
                    VendEntry."On Hold" := '';
                    VendEntry.Modify;
                end;
            end;
        end;
    end;


    procedure StartYellownet()
    begin
        DtaSetup.SetRange("DTA/EZAG", DtaSetup."dta/ezag"::EZAG);
        if not DtaSetup.Find('-') then
            Error(Text094);

        DtaSetup.TestField("Yellownet Homepage");
        Hyperlink(DtaSetup."Yellownet Homepage");
    end;


    procedure ModifyDocNo(var _GenJnlLine: Record "Gen. Journal Line")
    var
        NewDocNo: Code[10];
    begin
        d.Open(
          Text098 +
          Text099);

        NewDocNo := _GenJnlLine."Document No.";

        d.Update(1, NewDocNo);
        /* GL2024  if d.INPUT(1, NewDocNo) = 0 then
               exit;*/

        d.Close;

        if not Confirm(
             Text100,
             true, _GenJnlLine."Document No.", NewDocNo)
        then
            exit;

        GlLine.SetRange("Journal Template Name", _GenJnlLine."Journal Template Name");
        GlLine.SetRange("Journal Batch Name", _GenJnlLine."Journal Batch Name");
        GlLine.ModifyAll("Document No.", NewDocNo);
    end;


    procedure ModifyExRate(_GenJnlLine: Record "Gen. Journal Line")
    begin
        with _GenJnlLine do begin
            GlLine.SetRange("Journal Template Name", "Journal Template Name");
            GlLine.SetRange("Journal Batch Name", "Journal Batch Name");
            GlLine.SetRange("Currency Code", "Currency Code");
            GlLine.SetFilter("Line No.", '<>%1', "Line No.");
            if GlLine.Find('-') then begin
                if not Confirm(
                     Text101,
                     false, GlLine.Count, "Currency Code")
                then
                    exit;
                repeat
                    GlLine.Validate("Currency Factor", "Currency Factor");
                    GlLine.Modify;
                until GlLine.Next = 0;
            end;
        end;
    end;


    procedure CheckEsrCurrency(CurrencyCode: Code[10]; DTACodingLine: Code[70])
    var
        ESRTransactionCode: Integer;
        ISOCurrencyCode: Code[10];
    begin
        if StrLen(DTACodingLine) > 12 then begin
            ISOCurrencyCode := GetIsoCurrencyCode(CurrencyCode);

            if not (ISOCurrencyCode in ['CHF', 'EUR']) then
                Error(Text110, 'EUR/CHF', ISOCurrencyCode);

            Evaluate(ESRTransactionCode, CopyStr(DelChr(DTACodingLine, '=', '<'), 1, 2));
            if (ISOCurrencyCode = 'CHF') and (ESRTransactionCode > 20) then
                Error(Text110, 'EUR', ISOCurrencyCode);
            if (ISOCurrencyCode = 'EUR') and (ESRTransactionCode < 20) then
                Error(Text110, 'CHF', ISOCurrencyCode);

        end;
    end;


    procedure IBANDELCHR(_IBAN: Code[37]) _PureIBAN: Code[37]
    begin
        // Delete all spaces and ':'
        _PureIBAN := DelChr(_IBAN);
        _PureIBAN := DelChr(_PureIBAN, '=', ':');

        // Delete 'IBAN' prefix
        if StrPos(_PureIBAN, 'IBAN') <> 0 then
            _PureIBAN := DelStr(_PureIBAN, StrPos(_PureIBAN, 'IBAN'), 4);

        exit(_PureIBAN);
    end;


    procedure GetIsoCurrencyCode(CurrencyCode: Code[10]) IsoCurrencyCode: Code[10]
    begin
        GlSetup.Get;

        if CurrencyCode in ['', GlSetup."LCY Code"] then
            // ISO-Currency Code of LCY
            IsoCurrencyCode := 'CHF'
        else begin
            //+CH+
            /*
              Currency.GET(CurrencyCode);
              IF STRLEN(Currency."ISO Currency Code") <> 3 THEN
                ERROR(Text114,Currency."ISO Currency Code",CurrencyCode);
              IsoCurrencyCode := Currency."ISO Currency Code";
            */
            IsoCurrencyCode := CurrencyCode;
            //+CH+//
        end;

    end;


    procedure GetRecordType(xISO: Code[10]; Amount: Decimal; VendorNo: Code[20]; VendBankNo: Code[20]; DtaEzag: Code[10]) RecordType: Integer
    begin
        Clear(VendBank);

        if not VendBank.Get(VendorNo, VendBankNo) then
            Error(Text012, VendorNo, VendBankNo);

        with VendBank do begin
            case "Payment Form" of
                // ***** ESR & ESR+ *****
                "payment form"::ESR, "payment form"::"ESR+":
                    begin
                        if DtaEzag = 'DTA' then begin
                            case xISO of
                                'CHF':
                                    RecordType := 826;
                                'EUR':
                                    RecordType := 830;
                                else
                                    Error(Text115, "Payment Form", 'CHF/EUR', VendorNo, Amount);
                            end;
                        end else begin
                            case xISO of
                                'CHF':
                                    RecordType := 28;
                                'EUR':
                                    RecordType := 28;
                                else
                                    Error(Text115, "Payment Form", 'CHF/EUR', VendorNo, Amount);
                            end;
                        end;
                    end;

                // ***** Postzahlung Inland *****
                "payment form"::"Post Payment Domestic":
                    begin
                        if DtaEzag = 'DTA' then begin
                            // CH2302.begin
                            // IF xISO = 'CHF' THEN
                            // RecordType := 827
                            case xISO of
                                'CHF':
                                    RecordType := 827;
                                'EUR':
                                    RecordType := 830;
                                // CH2302.end
                                else
                                    Error(Text115, "Payment Form", 'CHF/EUR', VendorNo, Amount);
                            end;  // CH2302
                        end else
                            RecordType := 22;
                    end;

                // ***** Bankzahlung Inland *****
                "payment form"::"Bank Payment Domestic":
                    begin
                        if DtaEzag = 'DTA' then begin
                            if xISO = 'CHF' then
                                RecordType := 827
                            else
                                RecordType := 830;
                        end else
                            RecordType := 27
                    end;

                // ***** Zahlungsanweisung Inland *****
                "payment form"::"Cash Outpayment Order Domestic":
                    begin
                        if DtaEzag = 'DTA' then
                            Error(Text116, "Payment Form", VendorNo, VendBankNo);
                        if not (xISO = 'CHF') then
                            Error(Text115, "Payment Form", 'CHF', VendorNo, Amount);
                        RecordType := 24
                    end;

                // ***** Postzahlung Ausland *****
                "payment form"::"Post Payment Abroad":
                    begin
                        if DtaEzag = 'DTA' then
                            Error(Text116, "Payment Form", VendorNo, VendBankNo);
                        RecordType := 32;
                    end;

                // ***** Bankzahlung Ausland & SWIFT-Zahlung Ausland *****
                "payment form"::"Bank Payment Abroad", "payment form"::"SWIFT Payment Abroad":
                    begin
                        if DtaEzag = 'DTA' then
                            RecordType := 830
                        else
                            RecordType := 37;
                    end;

                // ***** Postanweisung Ausland *****
                "payment form"::"Cash Outpayment Order Abroad":
                    begin
                        if DtaEzag = 'DTA' then
                            Error(Text116, "Payment Form", VendorNo, VendBankNo);
                        RecordType := 34;
                    end;
            end;
        end;

        if (VendBank.Iban <> '') and (RecordType in [827, 830]) then
            RecordType := 836;
    end;
}

