Codeunit 70531 EsrMgt
{
    //GL2024  ID dans Nav 2009 : "3010531"
    // <changelog>
    //   <add id="CH9500" dev="SRYSER" date="2005-09-21" area="ES"
    //     releaseversion="CH4.00.02"  request="CH-START-400SP2-RENU">
    //     Renumber of Existing Functionality
    //     Swiss Payment Documents / Payment Forms (ESR)</add>
    //   <add id="CH2810" dev="SRYSER" date="2006-04-15" area="LS"
    //     releaseversion="CH4.00.03" feature="PS9380">
    //     LSV Plus redesign</add>
    //   <change id="CH2010" dev="SRYSER" date="2006-05-15" area="ES"
    //     baseversion="CH4.00.02" releaseversion="CH4.00.03" feature="PS9879">
    //     Redesign for ESR Record Type 4</change>
    //   <change id="CH2011" dev="sryser" date="2006-08-07" area="ES"
    //     baseversion="CH4.00.03" releaseversion="CH5.00" feature="PSCORS1045">
    //     Changed CustLedgEntry.SetCurrentkey because of W1 change</change>
    //   <change id="CH9115" dev="SRYSER" feature="PSCORS1300" date="2006-10-14" area="ES"
    //     baseversion="CH5.00" releaseversion="CH5.00">
    //     PreCall Cleanup</change>
    // </changelog>


    trigger OnRun()
    begin
    end;

    var
        Text008: label 'Do you want to import the ESR file?';
        Text009: label 'You have defined more than one ESR bank in the setup. Choose a bank in the following window.\';
        Text011: label 'Import cancelled.';
        Text014: label 'Backup copy of ESR file could not be written. Please check ESR setup.';
        Text015: label 'Journal "%1" contains entries. Please process these first.';
        Text017: label 'Import ESR file\';
        Text018: label 'No of payments   #1#########\';
        Text019: label 'Total amount     #2#########';
        Text020: label 'ESR payment, inv ';
        Text021: label 'ESR correction debit ';
        Text022: label 'ESR correction ';
        Text025: label 'ESR payment ';
        Text026: label 'Checksum error on import.\\';
        Text027: label 'The number of payments or the sum of amounts does not match the checksum record.\\';
        Text029: label 'Total records read    : #1#########\';
        Text030: label 'Total of checksum     : #2#########\';
        Text031: label 'Total amounts read    : #3#########\';
        Text032: label 'Total of checksum     : #4#########\\';
        Text033: label 'Check carefully the payments in the journal. If necessary, request a new ESR file.';
        Text036: label '%1 payments for %3 %2 sucessfully imported.';
        Text039: label 'Error Recordlength from file not known.\';
        Text040: label 'Transaction not identified.\';
        EsrMgt: Record "ESR Setup";
        LsvSetup: Record "LSV Setup";
        GenJournalLine: Record "Gen. Journal Line";
        GlBatchName: Record "Gen. Journal Batch";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        GeneralLedgerSetup: Record "General Ledger Setup";
        LsvMgt: Codeunit LsvMgt;
        d: Dialog;
        TA: Code[3];
        RefNo: Code[27];
        InvoiceAmt: Decimal;
        MicroFilmNo: Code[9];
        PaymentCharges: Code[6];
        ddVA: Code[2];
        mmVA: Code[2];
        yyVA: Code[4];
        ddCR: Integer;
        mmCR: Integer;
        yyCR: Integer;
        PostDate: Date;
        FirstPostingDate: Date;
        MultiplePostingDates: Boolean;
        TotalRecAmt: Decimal;
        TotalRecCents: Integer;
        TotalRecRecords: Integer;
        TotalRecCharges: Decimal;
        NoRecords: Integer;
        TotalAmt: Decimal;
        LastLineNo: Integer;
        NextDocNo: Code[20];
        InInvoiceNo: Code[10];
        Currency: Code[3];
        Transaction: Option " ",Credit,Cancellation,Correction;
        TotalRecord: Boolean;


    procedure CheckSetup(ActEsrMgt: Record "ESR Setup")
    begin
        // Check ESR Setup
        ActEsrMgt.TestField("Bal. Account No.");
        ActEsrMgt.TestField("ESR Filename");
        ActEsrMgt.TestField("BESR Customer ID");
        ActEsrMgt.TestField("ESR Account No.");
        if ActEsrMgt."Backup Copy" then begin
            ActEsrMgt.TestField("Backup Folder");
            ActEsrMgt.TestField("Last Backup No.");
        end;
    end;


    procedure ImportEsrFile(var ActGenJnlLine: Record "Gen. Journal Line")
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        f: File;
        BackupFilename: Code[130];
        Txt: Text[250];
    begin
        // ImportESRFile from source to GLL

        // *** Select GL journal. Check if empty
        GenJournalLine.SetRange("Journal Template Name", ActGenJnlLine."Journal Template Name");
        GenJournalLine.SetRange("Journal Batch Name", ActGenJnlLine."Journal Batch Name");
        GenJournalLine.SetFilter("Account No.", '<>%1', '');
        if GenJournalLine.Find('-') then
            Error(Text015, GenJournalLine."Journal Batch Name");

        // One or multiple ESR banks
        if EsrMgt.Count = 1 then begin
            EsrMgt.Find('-');
            if not Confirm(Text008, false) then
                exit;
        end else begin
            if not Confirm(Text009 + Text008, false) then
                exit;
            if Page.RunModal(3010531, EsrMgt) = Action::LookupCancel then
                Error(Text011);
        end;

        CheckSetup(EsrMgt);

        // Save sourcefile
        if EsrMgt."Backup Copy" then begin
            EsrMgt.LockTable;
            EsrMgt."Last Backup No." := IncStr(EsrMgt."Last Backup No.");
            EsrMgt.Modify;
            BackupFilename := EsrMgt."Backup Folder" + 'ESR' + EsrMgt."Last Backup No." + '.BAK';
            /*//GL2024 License   if not Copy(EsrMgt."ESR Filename", BackupFilename) then
                   Message(Text014);//GL2024 License*/
        end;

        LastLineNo := 0;
        NoRecords := 0;
        TotalAmt := 0;

        // Journal name for no serie
        GlBatchName.Get(ActGenJnlLine."Journal Template Name", ActGenJnlLine."Journal Batch Name");
        NextDocNo := NoSeriesMgt.GetNextNo(GlBatchName."No. Series", PostDate, false);

        //GL2024 License     f.TextMode(true);
        //GL2024 License  f.Open(EsrMgt."ESR Filename");

        d.Open(
          Text017 + // Import ESR file
          Text018 + // Payments #1
          Text019); // Total amount #2

        while ReadEsrLine(f, Txt) > 1 do begin
            case StrLen(Txt) of
                100 .. 128:
                    RecordType03(Txt);
                198 .. 202:
                    RecordType04(Txt);
                else
                    Error(Text039 + Text011);
            end;

            if not TotalRecord then begin
                // Insert GL line
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := ActGenJnlLine."Journal Template Name";
                GenJournalLine."Journal Batch Name" := ActGenJnlLine."Journal Batch Name";
                LastLineNo := LastLineNo + 10000;
                GenJournalLine."Line No." := LastLineNo;
                GenJournalLine."Document No." := NextDocNo;
                GenJournalLine."Posting Date" := PostDate;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                GenJournalLine."Document Type" := GenJournalLine."document type"::Payment;

                GeneralLedgerSetup.Get;
                if GeneralLedgerSetup."LCY Code" <> Currency then
                    GenJournalLine."Currency Code" := Currency;

                // Fetch customer based on invoice no.
                // CH2011.BEGIN
                CustLedgerEntry.SetCurrentkey("Document No.");
                // CH2011.END
                CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."document type"::Invoice);
                CustLedgerEntry.SetRange("Document No.", InInvoiceNo);
                if CustLedgerEntry.Find('-') then
                    GenJournalLine.Validate("Account No.", CustLedgerEntry."Customer No.");

                GenJournalLine."Applies-to Doc. Type" := GenJournalLine."applies-to doc. type"::Invoice;
                GenJournalLine."Applies-to Doc. No." := InInvoiceNo;

                if GenJournalLine."Currency Code" <> CustLedgerEntry."Currency Code" then
                    GenJournalLine.Validate("Currency Code", CustLedgerEntry."Currency Code");

                // Process transaction of credit record
                case Transaction of
                    Transaction::Credit:
                        begin
                            GenJournalLine.Description := Text020 + ' ' + InInvoiceNo;
                            GenJournalLine.Validate(Amount, -InvoiceAmt / 100);
                        end;
                    Transaction::Cancellation:
                        begin
                            GenJournalLine."Document Type" := GenJournalLine."document type"::Invoice;
                            GenJournalLine."Applies-to Doc. Type" := GenJournalLine."applies-to doc. type"::" ";
                            GenJournalLine."Applies-to Doc. No." := '';
                            GenJournalLine.Description := Format(Text021 + ' ' + InInvoiceNo, -MaxStrLen(GenJournalLine.Description));
                            GenJournalLine.Validate(Amount, InvoiceAmt / 100);  // positive
                        end;
                    Transaction::Correction:
                        begin
                            GenJournalLine.Description := Text022 + ' ' + InInvoiceNo;
                            GenJournalLine.Validate(Amount, -InvoiceAmt / 100);
                        end;
                end;

                GenJournalLine."Source Code" := 'ESR';
                GenJournalLine."Reason Code" := GlBatchName."Reason Code";
                GenJournalLine."External Document No." := MicroFilmNo;
                GenJournalLine."ESR Information" := 'ESR ' + RefNo + '/' + PaymentCharges + '/' + ddVA + '.' + mmVA + '.' + yyVA + '/' + TA;
                GenJournalLine.Insert;

                // All lines same credit date? (one/multiple balance postings)
                if FirstPostingDate = 0D then  // Save first
                    FirstPostingDate := PostDate;
                if FirstPostingDate <> PostDate then  // Compare subsequent
                    MultiplePostingDates := true;

                // Add total
                NoRecords := NoRecords + 1;
                TotalAmt := TotalAmt - GenJournalLine.Amount;  // Amount is negative
                d.Update(1, NoRecords);
                d.Update(2, TotalAmt);
            end; // Totalrecord
        end;  // End Read File


        // *** Bal account per line or as combined entry
        if MultiplePostingDates then begin

            // Bal Account per line
            if GenJournalLine.Find('-') then
                repeat
                    if EsrMgt."Bal. Account Type" = EsrMgt."bal. account type"::"Bank Account" then
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account"
                    else
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";

                    GenJournalLine.Validate("Bal. Account No.", EsrMgt."Bal. Account No.");
                    GenJournalLine.Modify;
                until GenJournalLine.Next = 0;

        end else begin

            // Add bal. acc. line at end
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := ActGenJnlLine."Journal Template Name";
            GenJournalLine."Journal Batch Name" := ActGenJnlLine."Journal Batch Name";
            LastLineNo := LastLineNo + 10000;
            GenJournalLine."Line No." := LastLineNo;
            GenJournalLine."Document No." := NextDocNo;
            GenJournalLine."Account Type" := EsrMgt."Bal. Account Type";

            GeneralLedgerSetup.Get;
            if GeneralLedgerSetup."LCY Code" <> Currency then
                GenJournalLine."Currency Code" := Currency;

            if EsrMgt."Bal. Account Type" = EsrMgt."bal. account type"::"Bank Account" then
                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"Bank Account"
            else
                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"G/L Account";

            GenJournalLine."Posting Date" := PostDate;
            GenJournalLine."Source Code" := 'ESR';

            GenJournalLine.Validate("Account No.", EsrMgt."Bal. Account No.");
            GenJournalLine.Description := Text025 + ' ' + EsrMgt."Bank Code";
            GenJournalLine.Validate("Document Type", GenJournalLine."document type"::Payment);
            GenJournalLine.Validate(Amount, TotalAmt);
            GenJournalLine.Insert;
        end;

        d.Close;

        // Compare total record
        TotalRecAmt := TotalRecAmt + (TotalRecCents / 100);

        // CHecksum error
        if (TotalRecRecords <> NoRecords) or (TotalRecAmt <> TotalAmt) then
            Message(
              Text026 +
              Text027 +
              Text029 +
              Text030 +
              Text031 +
              Text032 +
              Text033,
              NoRecords,
              TotalRecRecords,
              Format(TotalAmt, 0, '<Sign><Integer Thousand><Decimals,3>'),
              Format(TotalRecAmt, 0, '<Sign><Integer Thousand><Decimals,3>'))
        else
            Message(Text036, NoRecords, TotalAmt, Currency);
    end;


    procedure ReadEsrLine(var f: File; var Line: Text[250]): Integer
    var
        BytesRead: Integer;
    begin
        // Reade each ESR line in ESR file
        // Textfile Mode: 130 chars read, to CR/LF. exit(0) means EOF

        Line := '';  // init

        // File with CR/LF
        //GL2024 License  BytesRead := f.Read(Line);
        if BytesRead = 0 then
            exit(0);

        Line := ConvertStr(Line, ' ', '0');  // Fill Blanks with Zero
        exit(BytesRead);
    end;


    procedure RecordType03(Line: Text[250])
    begin
        TA := CopyStr(Line, 1, 3);
        if not (CopyStr(TA, 1, 2) in ['99']) then begin
            TotalRecord := false;
            RefNo := CopyStr(Line, 13, 27);
            Currency := 'CHF';
            Evaluate(InvoiceAmt, CopyStr(Line, 40, 10));
            yyVA := CopyStr(Line, 66, 2);
            mmVA := CopyStr(Line, 68, 2);
            ddVA := CopyStr(Line, 70, 2);
            Evaluate(yyCR, CopyStr(Line, 72, 2));
            Evaluate(mmCR, CopyStr(Line, 74, 2));
            Evaluate(ddCR, CopyStr(Line, 76, 2));
            MicroFilmNo := CopyStr(Line, 78, 9);
            PaymentCharges := CopyStr(Line, 97, 4);

            InInvoiceNo := CopyStr(RefNo, 19, 8);
            InInvoiceNo := DelChr(InInvoiceNo, '<', '0');

            if yyCR > 98 then
                PostDate := Dmy2date(ddCR, mmCR, 1900 + yyCR)
            else
                PostDate := Dmy2date(ddCR, mmCR, 2000 + yyCR);
            Transaction := Transaction::" ";

            // Process transaction of credit record
            case CopyStr(TA, 3, 1) of
                '2':  // Credit
                    begin
                        Transaction := Transaction::Credit;
                        // 2810.BEGIN
                        if CopyStr(TA, 1, 1) = '2' then
                            if LsvSetup.ReadPermission then begin
                                LsvMgt.ClosedByESR(InInvoiceNo);
                            end;
                        // CH2810.END

                    end;
                '5':  // Cancellation "Storno"
                    begin
                        Transaction := Transaction::Cancellation;
                        // 2810.BEGIN
                        if CopyStr(TA, 1, 1) = '2' then
                            if LsvSetup.ReadPermission then begin
                                LsvMgt.ClosedByESR(InInvoiceNo);
                            end;
                        // CH2810.END
                    end;
                '8': // Correction
                    begin
                        Transaction := Transaction::Correction;
                        // 2810.BEGIN
                        if CopyStr(TA, 1, 1) = '2' then
                            if LsvSetup.ReadPermission then begin
                                LsvMgt.ClosedByESR(InInvoiceNo);
                            end;
                        // CH2810.END
                    end;
                else
                    Error(Text040 + Text011);
            end;
        end else begin
            TotalRecord := true;
            Evaluate(TotalRecAmt, CopyStr(Line, 40, 10));
            Evaluate(TotalRecCents, CopyStr(Line, 50, 2));
            Evaluate(TotalRecRecords, CopyStr(Line, 52, 12));
            Evaluate(TotalRecCharges, CopyStr(Line, 70, 9));

            case CopyStr(TA, 3, 3) of
                '5':  // Debit - Negative
                    begin
                        TotalRecAmt := -TotalRecAmt;
                        TotalRecCents := -TotalRecCents;
                    end;
                '9':  // Credit - Positive
                    begin
                        TotalRecAmt := TotalRecAmt;
                        TotalRecCents := TotalRecCents;
                    end;
            end;

        end;
    end;


    procedure RecordType04(Line: Text[250])
    begin
        TA := CopyStr(Line, 1, 3);
        if not (CopyStr(TA, 1, 2) in ['98', '99']) then begin
            TotalRecord := false;
            RefNo := CopyStr(Line, 16, 27);
            Currency := CopyStr(Line, 43, 3);
            Evaluate(InvoiceAmt, CopyStr(Line, 46, 12));
            yyVA := CopyStr(Line, 101, 4);
            mmVA := CopyStr(Line, 105, 2);
            ddVA := CopyStr(Line, 107, 2);
            Evaluate(yyCR, CopyStr(Line, 109, 4));
            Evaluate(mmCR, CopyStr(Line, 113, 2));
            Evaluate(ddCR, CopyStr(Line, 115, 2));

            PaymentCharges := CopyStr(Line, 121, 6);
            MicroFilmNo := '';

            InInvoiceNo := CopyStr(RefNo, 19, 8);
            InInvoiceNo := DelChr(InInvoiceNo, '<', '0');

            PostDate := Dmy2date(ddCR, mmCR, yyCR);

            Transaction := Transaction::" ";

            // Process transaction of credit record
            case CopyStr(TA, 3, 3) of
                '1':  // Credit
                    begin
                        Transaction := Transaction::Credit;
                    end;
                '2':  // Cancellation "Storno"
                    begin
                        Transaction := Transaction::Cancellation;
                    end;
                '3': // Correction
                    begin
                        Transaction := Transaction::Correction;
                    end;
                else
                    Error(Text040 + Text011);
            end;
        end else begin
            TotalRecord := true;
            Currency := CopyStr(Line, 43, 3);
            Evaluate(TotalRecAmt, CopyStr(Line, 46, 10));
            Evaluate(TotalRecCents, CopyStr(Line, 56, 2));
            Evaluate(TotalRecRecords, CopyStr(Line, 58, 12));
            Evaluate(TotalRecCharges, CopyStr(Line, 81, 11));

            case CopyStr(TA, 3, 1) of
                '1':  // Credit - Positive
                    begin
                        TotalRecAmt := TotalRecAmt;
                        TotalRecCents := TotalRecCents;
                    end;
                '2':  // Debit - Negative
                    begin
                        TotalRecAmt := -TotalRecAmt;
                        TotalRecCents := -TotalRecCents;
                    end;
            end;
        end;
    end;
}

