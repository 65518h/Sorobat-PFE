Codeunit 8001409 "G/L Entry Application2"
{
    // //+REF+FR_APPLYLEDGER CLA 25/04/05 Copy from NAVFR6.00 10842

    Permissions = TableData "G/L Entry" = rimd,
                  //   TableData "Cust. Ledger Entry" = rimd,
                  TableData "Vendor Ledger Entry" = rimd,
                  //   TableData "Detailed Cust. Ledg. Entry" = rimd,
                  TableData "Detailed Vendor Ledg. Entry" = rimd;

    trigger OnRun()
    begin
    end;

    var
        xxxlettre: Text[3];
        GLEntry: Record "G/L Entry";
        LetterToSet: Text[3];
        SumPos: Decimal;
        SumNeg: Decimal;
        LetterDate: Date;
        Text1120006: label 'Successfully applied';
        Text1120007: label 'Successfully unapplied';


    procedure Validate(var Entry: Record "G/L Entry")
    begin
        GLEntry.Reset;
        LetterToSet := '';
        SumPos := 0;
        SumNeg := 0;
        LetterDate := 0D;
        if not GLEntry.Get(Entry."Entry No.") then
            exit;
        if GLEntry."Applies-to ID" = '' then
            exit;
        MarkEntries;
        GetLetter;
        if (SumPos + SumNeg <> 0) then
            LetterToSet := Lowercase(LetterToSet)
        else
            LetterToSet := UpperCase(LetterToSet);
        GLEntry.MarkedOnly(true);
        if GLEntry.Find('-') then
            repeat
                GLEntry.Letter := LetterToSet;
                GLEntry."Applies-to ID" := '';
                GLEntry."Letter Date" := LetterDate;
                GLEntry.Modify;
            until GLEntry.Next = 0;
        Message('%1', Text1120006);
    end;


    procedure MarkEntries()
    var
        EntryNumber: Integer;
        ApplicationID: Text[20];
        GLEntry2: Record "G/L Entry";
        GLEntry3: Record "G/L Entry";
        Operand1: Text[3];
        Operand2: Text[3];
    begin
        ApplicationID := GLEntry."Applies-to ID";
        GLEntry2.SetRange("G/L Account No.", GLEntry."G/L Account No.");
        GLEntry2.SetRange("Applies-to ID", ApplicationID);

        if GLEntry2.Find('-') then
            repeat
                GLEntry.Get(GLEntry2."Entry No.");
                if not GLEntry.Mark then begin
                    Operand1 := UpperCase(GLEntry.Letter);
                    Operand2 := UpperCase(LetterToSet);
                    if ((Operand1 < Operand2) and (GLEntry.Letter <> '')) or
                       (LetterToSet = '')
                    then
                        LetterToSet := GLEntry.Letter;
                    if GLEntry."Posting Date" > LetterDate then
                        LetterDate := GLEntry."Posting Date";
                    GLEntry.Mark(true);
                    if GLEntry.Amount < 0 then
                        SumNeg += GLEntry.Amount
                    else
                        SumPos += GLEntry.Amount;
                    if GLEntry.Letter <> '' then begin
                        GLEntry3.SetFilter("G/L Account No.", GLEntry."G/L Account No.");
                        GLEntry3.SetFilter(Letter, GLEntry.Letter);
                        if GLEntry3.Find('-') then
                            repeat
                                GLEntry.Get(GLEntry3."Entry No.");
                                if not GLEntry.Mark then begin
                                    GLEntry.Mark(true);
                                    Operand1 := UpperCase(GLEntry.Letter);
                                    Operand2 := UpperCase(LetterToSet);
                                    if ((Operand1 < Operand2) and (GLEntry.Letter <> '')) or
                                       (LetterToSet = '')
                                    then
                                        LetterToSet := GLEntry.Letter;
                                    if GLEntry."Posting Date" > LetterDate then
                                        LetterDate := GLEntry."Posting Date";
                                    if GLEntry.Amount < 0 then
                                        SumNeg += GLEntry.Amount
                                    else
                                        SumPos += GLEntry.Amount;
                                end;
                            until GLEntry3.Next = 0;
                    end;
                end;
            until GLEntry2.Next = 0;
    end;


    procedure GetLetter()
    var
        GLEntry2: Record "G/L Entry";
    begin
        if LetterToSet <> '' then
            exit;
        GLEntry2.SetFilter("G/L Account No.", GLEntry."G/L Account No.");
        GLEntry2.SetCurrentkey("G/L Account No.", Letter);
        if GLEntry2.Find('+') then
            LetterToSet := GLEntry2.Letter;
        if GLEntry2.Find('+') then
            if LetterToSet < UpperCase(GLEntry2.Letter) then
                LetterToSet := UpperCase(GLEntry2.Letter);
        NextLetter(LetterToSet);
    end;


    procedure NextLetter(var Letter: Text[3])
    var
        i: Integer;
    begin
        if Letter = 'ZZZ' then
            exit;
        if Letter = '' then begin
            Letter := 'AAA';
            exit;
        end;
        if Letter[3] <> 'Z' then begin
            i := Letter[3];
            i := i + 1;
            Letter[3] := i;
        end else
            if Letter[2] <> 'Z' then begin
                i := Letter[2];
                i := i + 1;
                Letter[2] := i;
                Letter[3] := 'A';
            end else begin
                i := Letter[1];
                i := i + 1;
                Letter[1] := i;
                Letter[2] := 'A';
                Letter[3] := 'A';
            end;
    end;


    procedure "HJ SORO"()
    begin
    end;


    procedure NextLetter2(Letter: Text[4]) NEWLETTERE: Text[4]
    var
        i: Integer;
    begin
        // >> HJ SORO 01-05-2015
        if Letter = 'ZZZZ' then exit;
        if Letter = '' then begin
            Letter := 'AAAA';
            exit(Letter);
        end;
        if Letter[4] <> 'Z' then begin
            i := Letter[4];
            i := i + 1;
            Letter[4] := i;
        end else
            if Letter[3] <> 'Z' then begin
                i := Letter[3];
                i := i + 1;
                Letter[3] := i;
                Letter[4] := 'A';

            end else
                if Letter[2] <> 'Z' then begin
                    i := Letter[2];
                    i := i + 1;
                    Letter[2] := i;
                    Letter[3] := 'A';
                    Letter[4] := 'A';
                end else begin
                    i := Letter[1];
                    i := i + 1;
                    Letter[1] := i;
                    Letter[2] := 'A';
                    Letter[3] := 'A';
                    Letter[4] := 'A';
                end;





        exit(Format(Letter[1]) + Format(Letter[2]) + Format(Letter[3]) + Format(Letter[4]));
    end;


    procedure GetLettrage()
    var
        LVendorLedgerEntry: Record "Vendor Ledger Entry";
        LDetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        LVendorLedgerEntry2: Record "Vendor Ledger Entry";
        LDetailedVendorLedgEntry2: Record "Detailed Vendor Ledg. Entry";
        LVendorLedgerEntry3: Record "Vendor Ledger Entry";
        LDetailedVendorLedgEntry3: Record "Detailed Vendor Ledg. Entry";
        MaLettre: Text[4];
        MaLettre2: Text[4];
        LNewLettre: Text[4];
        NumTransaction: Integer;
        LTrouver: Boolean;
        efef: Codeunit 226;

    begin
        NumTransaction := 0;
        LVendorLedgerEntry.SetCurrentkey(Lettre);
        LVendorLedgerEntry.SetFilter(Lettre, '<>%1', '');
        if LVendorLedgerEntry.FindLast then MaLettre := LVendorLedgerEntry.Lettre;
        LDetailedVendorLedgEntry.SetCurrentkey("Transaction No.");
        LDetailedVendorLedgEntry.SetRange("Entry Type", LDetailedVendorLedgEntry."entry type"::Application);
        LDetailedVendorLedgEntry.SetFilter(Lettre, '=%1', '');
        if LDetailedVendorLedgEntry.FindFirst then
            repeat
                if NumTransaction <> LDetailedVendorLedgEntry."Transaction No." then begin
                    IF (LDetailedVendorLedgEntry."Transaction No." = 40048) OR (LDetailedVendorLedgEntry."Transaction No." = 41043) THEN BEGIN
                        LTrouver := FALSE;
                        MaLettre2 := '';
                        LVendorLedgerEntry3.RESET;
                        LDetailedVendorLedgEntry2.RESET;

                    END;
                    LTrouver := false;
                    MaLettre2 := '';
                    LVendorLedgerEntry3.Reset;
                    LDetailedVendorLedgEntry2.Reset;

                    NumTransaction := LDetailedVendorLedgEntry."Transaction No.";
                    LDetailedVendorLedgEntry2.SetCurrentkey("Transaction No.");
                    LDetailedVendorLedgEntry2.SetRange("Transaction No.", NumTransaction);
                    if LDetailedVendorLedgEntry2.FindFirst then
                        repeat
                            if LVendorLedgerEntry3.Get(LDetailedVendorLedgEntry2."Vendor Ledger Entry No.") then
                                if LVendorLedgerEntry3.Lettre <> '' then begin
                                    LTrouver := true;
                                    MaLettre2 := LVendorLedgerEntry3.Lettre;
                                end;
                        until (LDetailedVendorLedgEntry2.Next = 0) or LTrouver;
                    if not LTrouver then begin
                        LVendorLedgerEntry.Reset;
                        LVendorLedgerEntry.SetCurrentkey(Lettre);
                        LVendorLedgerEntry.SetFilter(Lettre, '<>%1', '');
                        if LVendorLedgerEntry.FindLast then MaLettre := LVendorLedgerEntry.Lettre;
                        MaLettre2 := NextLetter2(MaLettre);
                        MaLettre := MaLettre2;
                    end;
                end;
                if LVendorLedgerEntry3.Get(LDetailedVendorLedgEntry."Vendor Ledger Entry No.") then begin
                    LVendorLedgerEntry3.Lettre := MaLettre2;
                    LVendorLedgerEntry3.Modify;
                end;

                LDetailedVendorLedgEntry.Lettre := MaLettre2;
                LDetailedVendorLedgEntry.Modify;

            until LDetailedVendorLedgEntry.Next = 0;
    end;


    procedure GetLettrageClt()
    var
        LCustomerLedgerEntry: Record "Cust. Ledger Entry";
        LDetailedCustomerLedgEntry: Record "Detailed Cust. Ledg. Entry";
        LCustomerLedgerEntry2: Record "Cust. Ledger Entry";
        LDetailedCustomerLedgEntry2: Record "Detailed Cust. Ledg. Entry";
        LCustomerLedgerEntry3: Record "Cust. Ledger Entry";
        LDetailedCustomerLedgEntry3: Record "Detailed Cust. Ledg. Entry";
        MaLettre: Text[4];
        MaLettre2: Text[4];
        LNewLettre: Text[4];
        NumTransaction: Integer;
        LTrouver: Boolean;
    begin
        MaLettre := '';
        MaLettre2 := '';
        NumTransaction := 0;
        LCustomerLedgerEntry.SetCurrentkey(Lettre);
        LCustomerLedgerEntry.SetFilter(Lettre, '<>%1', '');
        if LCustomerLedgerEntry.FindLast then MaLettre := LCustomerLedgerEntry.Lettre;
        LDetailedCustomerLedgEntry.SetCurrentkey("Transaction No.");
        LDetailedCustomerLedgEntry.SetRange("Entry Type", LDetailedCustomerLedgEntry."entry type"::Application);
        LDetailedCustomerLedgEntry.SetFilter(Lettre, '=%1', '');
        if LDetailedCustomerLedgEntry.FindFirst then
            repeat
                if NumTransaction <> LDetailedCustomerLedgEntry."Transaction No." then begin
                    LTrouver := false;
                    MaLettre2 := '';
                    LCustomerLedgerEntry3.Reset;
                    LDetailedCustomerLedgEntry2.Reset;

                    NumTransaction := LDetailedCustomerLedgEntry."Transaction No.";
                    LDetailedCustomerLedgEntry2.SetCurrentkey("Transaction No.");
                    LDetailedCustomerLedgEntry2.SetRange("Transaction No.", NumTransaction);
                    if LDetailedCustomerLedgEntry2.FindFirst then
                        repeat
                            if LCustomerLedgerEntry3.Get(LDetailedCustomerLedgEntry2."Cust. Ledger Entry No.") then
                                if LCustomerLedgerEntry3.Lettre <> '' then begin
                                    LTrouver := true;
                                    MaLettre2 := LCustomerLedgerEntry3.Lettre;
                                end;
                        until (LDetailedCustomerLedgEntry2.Next = 0) or LTrouver;
                    if not LTrouver then begin
                        LCustomerLedgerEntry.Reset;
                        LCustomerLedgerEntry.SetCurrentkey(Lettre);
                        LCustomerLedgerEntry.SetFilter(Lettre, '<>%1', '');
                        if LCustomerLedgerEntry.FindLast then MaLettre := LCustomerLedgerEntry.Lettre;
                        MaLettre2 := NextLetter2(MaLettre);
                        MaLettre := MaLettre2;
                    end;
                end;
                if LCustomerLedgerEntry3.Get(LDetailedCustomerLedgEntry."Cust. Ledger Entry No.") then begin
                    LCustomerLedgerEntry3.Lettre := MaLettre2;
                    LCustomerLedgerEntry3.Modify;
                end;

                LDetailedCustomerLedgEntry.Lettre := MaLettre2;
                LDetailedCustomerLedgEntry.Modify;

            until LDetailedCustomerLedgEntry.Next = 0;
    end;


    procedure "//HJ"()
    begin
    end;


    procedure GetLetter2(ParaAccount: Code[20]) Lettre: Text[4]
    var
        GLEntry2: Record "G/L Entry";
    begin
        //>> HJ TC 03 12 2001
        GLEntry2.SetFilter("G/L Account No.", ParaAccount);
        GLEntry2.SetCurrentkey("G/L Account No.", Letter);
        if GLEntry2.Find('+') then LetterToSet := GLEntry2.Letter;
        GLEntry2.SetFilter(GLEntry2.Letter, '<AAA');
        if GLEntry2.Find('+') then if LetterToSet < UpperCase(GLEntry2.Letter) then LetterToSet := UpperCase(GLEntry2.Letter);
        NextLetter(LetterToSet);
        exit(LetterToSet);
        //>> HJ TC 03 12 2001
    end;
}

