Codeunit 8001419 "Import Trigger CCMX"
{
    // //IMPORT CW 09/05/05 Import paie CCMX

    TableNo = "Gen. Journal Line";

    trigger OnRun()

    var
        lRec: Record "Gen. Journal Line";
        lGLSetup: Record "General Ledger Setup";
    begin
        /*   SingleInstance.Get(ImportLog);

           lGLSetup.Get;
           if StrPos(Format(lGLSetup."Amount Rounding Precision"), ',') <> 0 then
               DecimalSeparator := ','
           else
               DecimalSeparator := '.';

           case SingleInstance.
             ImportLog.PreImport            SingleInstance.SetInit(false);

               ImportLog.BeforeUpdatebegin
               if ImportLog."Import Line No." = 1 then begin
                       lRec.SetRange("Journal Template Name", "Journal Template Name");
                       lRec.SetRange("Journal Batch Name", "Journal Batch Name");
                       if lRec.Find('-') then
                           SingleInstance.Warning(ImportLog.Level::Severe, StrSubstNo(tBatchNotEmpty, "Journal Template Name", "Journal Batch Name"));
                   end;
               "Line No." := ImportLog."Import Line No." * 10000;

               ProcessLine(SingleInstance.GetLine(), Rec);

           end;

           ImportLog.PostImport;

           else
           end;*/
    end;

    var
        ImportLog: Record "Import Log";
        SingleInstance: Codeunit "Import SingleInstance2";
        tBatchNotEmpty: label 'Batch journal %1 %2 is not empty';
        DecimalSeparator: Char;


    procedure ProcessLine(pLine: Text[1000]; var pRec: Record "Gen. Journal Line")
    var
        lAccount: Record "G/L Account";
    begin
        with pRec do begin
            "Document No." := 'PAIE' + CopyStr(pLine, 24, 4);
            "Account Type" := "account type"::"G/L Account";
            case CopyStr(pLine, 1, 5) of
                '00280':
                    begin // Général
                        Evaluate("Posting Date", CopyStr(pLine, 30, 2) + CopyStr(pLine, 28, 2) + CopyStr(pLine, 24, 4));
                        Evaluate("Account No.", CopyStr(pLine, 40, 17));
                        Validate("Account No.");
                        Amount := ToDecimal(CopyStr(pLine, 74, 18));
                        if pLine[95] = 'D' then
                            Validate(Amount)
                        else
                            Validate(Amount, -Amount);
                        Description := DelChr(CopyStr(pLine, 109, 35), '>');
                        if "Account No." <> lAccount."No." then
                            lAccount.Get("Account No.");
                        if lAccount."Income/Balance" = lAccount."income/balance"::"Income Statement" then
                            SingleInstance.SetSkip(true)
                        else begin
                            Clear("Job No.");
                        end;
                    end;
                '00300':
                    begin // Analytique
                        Evaluate("Job No.", CopyStr(pLine, 24, 15));
                        Amount := ToDecimal(CopyStr(pLine, 75, 18));
                        if pLine[96] = 'D' then
                            Validate(Amount)
                        else
                            Validate(Amount, -Amount);
                        lAccount.TestField("Income/Balance", lAccount."income/balance"::"Income Statement");
                    end;
                else
                    SingleInstance.SetSkip(true);
            end;
        end;
    end;


    procedure ToDecimal(pText: Text[30]): Decimal
    var
        lDecimal: Decimal;
    begin
        if pText = '' then
            exit(0)
        else
            if DecimalSeparator = '.' then
                pText := ConvertStr(DelChr(pText), ',', '.')
            else
                pText := ConvertStr(DelChr(pText), '.', ',');
        Evaluate(lDecimal, pText);
        exit(lDecimal);
    end;
}

