Codeunit 8004106 "Payment Management1"
{
    // #8219 CW 02/09/10
    // //+PMT+PAYMENT CW 29/04/02 Contrôle IBAN,RIB belge,N° TVA belge


    trigger OnRun()
    begin
        Message('%1', CheckIBAN('FR7630027000570000010444634'));
        Message('%1', CheckIBAN('BE62510007547061'));
        Message('%1', CheckIBAN('FR14 2004 1010 0505 0001 3M02 606'));

        Message('%1', BBAN2IBAN('FR', '30027000570000010444634'));
        Message('%1', BBAN2IBAN('BE', '510007547061'));
        Message('%1', BBAN2IBAN('FR', '2004 1010 0505 0001 3m02 606'));
    end;

    var
        Text000: label 'DEFAULT';
        Text001: label 'Default Payment Journal';
        Text002: label 'Default Journal';
        Text003: label 'It is not possible to display %1 in a field with a length of %2.';
        Text11300: label '1. Row [01] and/or Row [02] and/or Row [03] \';
        Text11301: label '    => Row [54]';
        Text11302: label '2. Row [54] => Row [01] and/or Row [02] and/or \';
        Text11303: label '    Row [03]';
        Text11304: label '3. Row [86] => Row [55]';
        Text11305: label '4. Row [87] => Row [56] and/or Row [57]';
        Text11306: label '5. There is an amount in Row [65] \';
        Text11307: label '    and/or Row [66]';
        Text11308: label '6. There is a wrong amount in Row [91]';
        Text11309: label '7. Row [01] x 6% + Row [02] x 12% + \';
        Text11310: label '    Row [03] x 21% = Row [54]';
        Text11311: label '8. Row [55] =< (Row [84] + Row [86]) * 21%';
        Text11312: label '9. (Row [56] + Row [57]) =< \';
        Text11313: label '    (Row [85] + Row [87]) * 21%';
        Text11314: label '10. Row [59] =< (Row [81] + Row [82] + \';
        Text11315: label '     Row [83] + Row [84] + Row [85])';
        Text11316: label '11. Row [63] =< Row [85] * 21%';
        Text11317: label '12. Row [64] =< Row [49] * 21%';
        Text11318: label 'Error';
        Text11319: label 'OK';


    procedure CheckIBAN(pIBAN: Code[40]): Boolean
    var
        i: Integer;
        Check: Integer;
        Ascii: Integer;
    begin
        if StrLen(pIBAN) < 4 then
            exit(false);
        pIBAN := CopyStr(pIBAN, 5) + CopyStr(pIBAN, 1, 4);
        for i := 1 to StrLen(pIBAN) do begin
            Ascii := pIBAN[i];
            case Ascii of
                48 .. 57: // 0..9
                    Check := Check * 10 + Ascii - 48;
                65 .. 90: // A..Z
                    Check := Check * 100 + Ascii - 55;
                32:
                    begin
                    end; // space
                else
                    exit(false);
            end;
            Check := Check MOD 97;
        end;
        exit(Check = 1);
    end;


    procedure BBAN2IBAN(pCountryISO: Code[2]; pBBAN: Code[40]) Return: Code[40]
    var
        i: Integer;
        Check: Integer;
        Ascii: Integer;
        j: Integer;
    begin
        pBBAN := pBBAN + pCountryISO + '00';
        for i := 1 to StrLen(pBBAN) do begin
            if pBBAN[i] in ['0' .. '9', 'A' .. 'Z'] then begin
                if j MOD 4 = 0 then
                    Return := Return + ' ' + CopyStr(pBBAN, i, 1)
                else
                    Return := Return + CopyStr(pBBAN, i, 1);
                j += 1;
                Ascii := pBBAN[i];
                case Ascii of
                    48 .. 57: // 0..9
                        Check := Check * 10 + Ascii - 48;
                    65 .. 90: // A..Z
                        Check := Check * 100 + Ascii - 55;
                    else
                end;
                Check := Check MOD 97;
            end;
        end;
        Check := 98 - Check;
        if Check < 10 then
            Return := pCountryISO + '0' + Format(Check) + ' ' + Return
        else
            Return := pCountryISO + Format(Check) + ' ' + Return;
    end;


    procedure ConvertToDigit(AlphaNumValue: Text[250]; Length: Integer): Text[250]
    begin
        exit(DelChr(Format(DelChr(AlphaNumValue, '=', DelChr(AlphaNumValue, '=', '0123456789')), Length)));
    end;


    procedure DecimalNumeralZeroFormat(DecimalNumeral: Decimal; Length: Integer): Text[250]
    begin
        exit(TextZeroFormat(DelChr(Format(ROUND(Abs(DecimalNumeral), 1, '<'), 0, 1)), Length));
    end;


    procedure TextZeroFormat(Text: Text[250]; Length: Integer): Text[250]
    begin
        if StrLen(Text) > Length then
            Error(
              Text003,
              Text, Length);
        exit(PadStr('', Length - StrLen(Text), '0') + Text);
    end;


    procedure Mod97Test(var BankAccountNo: Text[30]) OK: Boolean
    var
        Decimal: Decimal;
        Check: Decimal;
        BankAccNo: Text[30];
    begin
        //*** ST3.00 Test should only be performed on Belgian Bank Account Numbers !!
        BankAccNo := ConvertToDigit(BankAccountNo, MaxStrLen(BankAccNo));
        if StrLen(BankAccNo) <> 12 then
            exit(false);

        Evaluate(Decimal, CopyStr(BankAccNo, 1, 10));
        Evaluate(Check, CopyStr(BankAccNo, 11, 2));

        Decimal := Decimal MOD 97;
        if Decimal = 0 then
            Decimal := 97;

        exit(Decimal = Check);
    end;


    procedure CheckNo("No.": Text[20]): Boolean
    var
        Vatno: Text[20];
        WorkVatNo: Decimal;
        Ctrl: Decimal;
    begin
        Vatno := DelChr("No.", '=', DelChr("No.", '=', '0123456789'));
        if StrLen(Vatno) <> 9 then
            exit(false);
        Evaluate(WorkVatNo, CopyStr(Vatno, 1, 7));
        Evaluate(Ctrl, CopyStr(Vatno, 8, 2));
        WorkVatNo := 97 - (WorkVatNo MOD 97);
        exit(WorkVatNo = Ctrl);
    end;


    procedure CheckForErrors(NoOfPeriods: Integer; Row: array[99, 12] of Decimal; Errormargin: Decimal; December: Integer; var Control: array[14] of Text[250]; var CheckList: array[14, 12] of Text[30])
    var
        i: Integer;
    begin
        for i := 1 to NoOfPeriods do begin
            Control[1] := Text11300 +
                          Text11301;
            Test(1,
                 ((Row[1, i] <> 0) or (Row[2, i] <> 0) or (Row[3, i] <> 0)) and
                 (Row[54, i] = 0), i, CheckList);

            Control[2] := Text11302 +
                          Text11303;
            Test(2,
                 (Row[54, i] <> 0) and
                 (Row[1, i] = 0) and (Row[2, i] = 0) and (Row[3, i] = 0), i, CheckList);

            Control[3] := Text11304;
            Test(3, (Row[86, i] <> 0) and (Row[55, i] = 0), i, CheckList);

            Control[4] := Text11305;
            Test(4, (Row[87, i] <> 0) and (Row[56, i] = 0) and (Row[57, i] = 0), i, CheckList);

            Control[5] := Text11306 +
                          Text11307;
            Test(5, (Row[65, i] <> 0) or (Row[66, i] <> 0), i, CheckList);

            Control[6] := Text11308;
            Test(6, (Row[91, i] <> 0) and (December <> i), i, CheckList);

            Control[7] := Text11309 +
                          Text11310;
            Test(7,
                 Abs(Row[1, i] * 0.06 + Row[2, i] * 0.12 + Row[3, i] * 0.21 - Row[54, i]) >
                 Errormargin, i, CheckList);

            Control[8] := Text11311;
            Test(8, Row[55, i] > ((Row[84, i] + Row[86, i]) * 0.21 + Errormargin), i, CheckList);

            Control[9] := Text11312 +
                          Text11313;
            Test(9, (Row[56, i] + Row[57, i]) > ((Row[85, i] + Row[87, i]) * 0.21 + Errormargin), i, CheckList);

            Control[10] := Text11314 +
                           Text11315;
            Test(10,
                 Row[59, i] > (Row[81, i] + Row[82, i] + Row[83, i] + Row[84, i] + Row[85, i]), i, CheckList);

            Control[11] := Text11316;
            Test(11, Row[63, i] > Row[85, i] * 0.21 + Errormargin, i, CheckList);

            Control[12] := Text11317;
            Test(12, Row[64, i] > Row[49, i] * 0.21 + Errormargin, i, CheckList);

        end;
    end;


    procedure Test(TestNo: Integer; LogicalTest: Boolean; Period: Integer; var MyCheckList: array[14, 12] of Text[30])
    begin
        if LogicalTest then
            MyCheckList[TestNo, Period] := Text11318
        else
            MyCheckList[TestNo, Period] := Text11319;
    end;


    procedure GetCustDefBankCode(pNo: Code[20]): Code[10]
    var
        lCustomerBankAccount: Record "Customer Bank Account";
    begin
        lCustomerBankAccount.SetRange("Customer No.", pNo);
        if lCustomerBankAccount.Find('-') and (lCustomerBankAccount.Next = 0) then
            exit(lCustomerBankAccount.Code);
        //#6411
        lCustomerBankAccount.SetRange("Default Account", true);
        if lCustomerBankAccount.Find('-') then
            exit(lCustomerBankAccount.Code)
        //#6411//
        else
            exit('');
    end;


    procedure GetVendDefBankCode(pNo: Code[20]): Code[10]
    var
        lVendorBankAccount: Record "Vendor Bank Account";
    begin
        lVendorBankAccount.SetRange("Vendor No.", pNo);
        if lVendorBankAccount.Find('-') and (lVendorBankAccount.Next = 0) then
            exit(lVendorBankAccount.Code);
        //#6411
        lVendorBankAccount.SetRange("Default Bank Account", true);
        if lVendorBankAccount.Find('-') then
            exit(lVendorBankAccount.Code)
        //#6411//
        else
            exit('');
    end;


    procedure CheckJournal(pEntryNo: Integer)
    var
        lCompanyInfo: Record "Company Information";
        lCheckLedgerEntry: Record "Check Ledger Entry";
        lBankPayment: Record "Bank Payment Type";
        lBankAccount: Record "Bank Account";
        lCustomerBankAccount: Record "Customer Bank Account";
        lVendorBankAccount: Record "Vendor Bank Account";
    begin
        //#8219
        lCompanyInfo.Get;
        lCompanyInfo.TestField(Name);
        with lCheckLedgerEntry do begin
            Get(pEntryNo);
            if ("Bank Account No." <> lBankPayment."Bank Account No.") or
               ("Payment Type" <> lBankPayment."Payment Type") then begin
                lBankPayment.Get("Bank Account No.", "Payment Type");
                lBankAccount.Get("Bank Account No.");
                lBankAccount.TestField(Iban);
                case lBankPayment."Export Type" of
                    lBankPayment."export type"::CFONB160:
                        lBankPayment.TestField("Transfer No.");
                    lBankPayment."export type"::ISABEL:
                        begin
                            lCompanyInfo.TestField("VAT Registration No.");
                            lBankAccount.TestField("Bank Branch No.");
                        end;
                end;
            end;
            /*
              INIT;
              SETCURRENTKEY("Bank Account No.","Entry Status","Check No.");
              SETRANGE("Bank Account No.",BankAccount."No.");
              SETRANGE("Payment Type",BankPayment."Payment Type");
              IF FIND('-') THEN
                REPEAT
            */
            case "Bal. Account Type" of
                "bal. account type"::Customer:
                    begin
                        lCustomerBankAccount.Get("Bal. Account No.", "Bal. Bank Account No.");
                        lVendorBankAccount.TransferFields(lCustomerBankAccount);
                    end;
                "bal. account type"::Vendor:
                    lVendorBankAccount.Get("Bal. Account No.", "Bal. Bank Account No.");
            end;
            case lBankPayment."Export Type" of
                lBankPayment."export type"::CFONB160:
                    lVendorBankAccount.TestField(Iban);
                lBankPayment."export type"::ISABEL:
                    if not Mod97Test(lVendorBankAccount."Bank Account No.") then
                        lVendorBankAccount.FieldError("Bank Account No.");
            end;
            /*
                UNTIL NEXT = 0;
            */
        end;
        //#8219//

    end;
}

