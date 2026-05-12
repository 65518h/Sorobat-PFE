Codeunit 39001404 "Mgmt. of Loans and Advances"
{
    //GL2024  ID dans Nav 2009 : "39001404"
    //  //


    trigger OnRun()
    begin
    end;

    var
        errValidate: label 'Validation interrupted. Task canceled.';
        Test: Boolean;


    procedure "MntRemboursé"(LoanAdvanceHeader: Record "Loan & Advance Header"): Decimal
    begin
        LoanAdvanceHeader.CalcFields("Repaid amount");
        exit(LoanAdvanceHeader."Repaid amount");
    end;


    procedure "CréerLigneRembourcement"(var SalaryLineTmp: Record "Salary Lines")
    var
        LoanAdvanceHeader: Record "Loan & Advance Header";
        LoanAdvanceLines: Record "Loan & Advance Lines";
        LALines: Record "Loan & Advance Lines";
        ExistLoanAdvanceLine: Record "Loan & Advance Lines";
        ln: Integer;
        Employee: Record Employee;
        DateD: Date;
        DateF: Date;
        LoanAD: Record "Loan & Advance Header";
        Mnt: Decimal;
        MntTmp: Decimal;
        EntSal: Record "Rec. Salary Headers";
        RecSalaryHeaders: Record "Salary Headers";
    //GL3900    PrimeType: Record Prime;
    begin
        if SalaryLineTmp.Month < 12 then begin
            DateD := Dmy2date(1, SalaryLineTmp.Month + 1, SalaryLineTmp.Year);
            DateF := CalcDate('+FM', DateD);
        end else begin
            EntSal.Reset;
            EntSal.SetCurrentkey(Year, Month, "No.");
            EntSal.SetRange(Year, SalaryLineTmp.Year);
            EntSal.SetFilter(Month, '%1..%2', 0, 16);
            if EntSal.Find('-') then;
            DateD := Dmy2date(1, Date2dmy(SalaryLineTmp."Posting Date", 2), SalaryLineTmp.Year);
            DateF := CalcDate('+FM', DateD);
        end;

        SalaryLineTmp.Loans := 0;
        SalaryLineTmp.Advances := 0;
        LoanAdvanceLines.Reset;
        LoanAdvanceLines.SetCurrentkey("Payment No.", Paid, Employee);
        LoanAdvanceLines.SetFilter("Payment No.", SalaryLineTmp."No.");
        LoanAdvanceLines.SetRange(Paid, false);
        LoanAdvanceLines.SetFilter(Employee, SalaryLineTmp.Employee);
        LoanAdvanceLines.DeleteAll;
        /// HS 13/10/25

        //    if recSalaryHeaders.Get(SalaryLineTmp."No.") then;
        /*    if recSalaryHeaders.STC then begin
                LoanAD.RESET;
                LoanAD.SETCURRENTKEY(Employee, Type, Status, "No.", "Avance Sur Prime");
                LoanAD.SETFILTER(Employee, SalaryLineTmp.Employee);
                LoanAD.SETRANGE(Type, LoanAD.Type::Loan);
                LoanAD.SETRANGE(Status, LoanAD.Status::"In progress");
                IF LoanAD.FINDFIRST THEN
                    REPEAT
                        LoanAD.CALCFIELDS("Repaid amount");
                        IF (LoanAD."Total to repay" - LoanAD."Repaid amount") > 0 THEN begin
                            InsererLigne(SalaryLineTmp, LoanAD, ROUND(LoanAD."Total to repay" - LoanAD."Repaid amount", 0.001), 0);
                            SalaryLineTmp.Loans += ROUND(LoanAD."Total to repay" - LoanAD."Repaid amount", 0.001);
                        end;
                    UNTIL LoanAD.NEXT = 0;


                LoanAD.RESET;
                LoanAD.SETCURRENTKEY(Employee, Type, Status, "No.", "Avance Sur Prime");
                LoanAD.SETFILTER(Employee, SalaryLineTmp.Employee);
                LoanAD.SETRANGE(Type, LoanAD.Type::Advance);
                LoanAD.SETRANGE(Status, LoanAD.Status::"In progress");
                IF LoanAD.FINDFIRST THEN
                    REPEAT
                        LoanAD.CALCFIELDS("Repaid amount");
                        IF (LoanAD."Total to repay" - LoanAD."Repaid amount") > 0 THEN begin
                            InsererLigne(SalaryLineTmp, LoanAD, LoanAD."Total to repay" - LoanAD."Repaid amount", 0);
                            SalaryLineTmp.Advances += ROUND(LoanAD."Total to repay" - LoanAD."Repaid amount", 0.001);
                        end;
                    UNTIL LoanAD.NEXT = 0;



            end
            ////  HS 13/10/25
            else*/
        if (SalaryLineTmp.Month < 12) or (SalaryLineTmp.Month = 14) or (SalaryLineTmp.Month = 15) or (SalaryLineTmp.Month = 16) then  //MBY 19/12/12
  begin

            LoanAD.Reset;
            LoanAD.SetCurrentkey(Employee, Type, Status, "No.", "Avance Sur Prime");
            LoanAD.SetFilter(Employee, SalaryLineTmp.Employee);
            LoanAD.SetRange(Type, LoanAD.Type::Loan);
            LoanAD.SetRange(Status, LoanAD.Status::"In progress");



            LoanAD.SetRange("Not include", false);
            //DSFT AGA 01112010

            if (SalaryLineTmp.Month = 14) then          //MBY 19/12/2012
                LoanAD.SetRange("Avance Sur Prime", true)
            else
                if (SalaryLineTmp.Month = 16) then
                    LoanAD.SetRange("Avance sur congé", true)
                else begin
                    LoanAD.SetRange("Avance Sur Prime", false);
                    LoanAD.SetRange("Avance sur congé", false);
                end;

            LoanAD.SetRange("Avance Repas", false);
            if LoanAD.Find('-') then
                repeat

                    if calcSolde(LoanAD, SalaryLineTmp) then begin

                        SalaryLineTmp.Loans := SalaryLineTmp.Loans + ROUND(LoanAD.CalcMnPrinciPeriodeeng(DateD, DateF), 0.001) +
                                             ROUND(LoanAD.CalcMntInetretEng1(DateD, DateF), 0.001);

                        if (ROUND(LoanAD.CalcMnPrinciPeriodeeng(DateD, DateF), 0.001) <> 0) or
                           (ROUND(LoanAD.CalcMntInetretEng1(DateD, DateF), 0.001) <> 0) then begin
                            InsererLigne(SalaryLineTmp, LoanAD, ROUND(LoanAD.CalcMnPrinciPeriodeeng(DateD, DateF), 0.001),
                            ROUND(LoanAD.CalcMntInetretEng1(DateD, DateF), 0.001));
                            //>>DSFT-AGA 12/03/2010
                            if LoanAD."Double tranche" = true then begin
                                InsererLigne(SalaryLineTmp, LoanAD, ROUND(LoanAD.CalcMnPrinciPeriodeeng(DateD, DateF), 0.001),
                                ROUND(LoanAD.CalcMntInetretEng1(DateD, DateF), 0.001));
                                SalaryLineTmp.Loans := 0;
                                SalaryLineTmp.Loans := SalaryLineTmp.Loans + ROUND((LoanAD.CalcMnPrinciPeriodeeng(DateD, DateF) * 2), 0.001) +
                                                   ROUND(LoanAD.CalcMntInetretEng1(DateD, DateF), 0.001);

                            end;

                            //>>DSFT-AGA 12/03/2010
                        end;

                    end;
                until LoanAD.Next = 0;

            // Advance
            LoanAD.Reset;
            LoanAD.SetCurrentkey(Employee, Type, Status, "No.", "Avance Sur Prime");
            LoanAD.SetFilter(Employee, SalaryLineTmp.Employee);
            LoanAD.SetRange(Type, LoanAD.Type::Advance);
            LoanAD.SetRange(Status, LoanAD.Status::"In progress");

            //DSFT AGA 01112010

            if (SalaryLineTmp.Month = 14) then    //MBY 19/12/12
                LoanAD.SetRange("Avance Sur Prime", true)
            else
                if (SalaryLineTmp.Month = 16) then
                    LoanAD.SetRange("Avance sur congé", true)
                else begin
                    LoanAD.SetRange("Avance Sur Prime", false);
                    LoanAD.SetRange("Avance sur congé", false);
                end;
            LoanAD.SetRange("Not include", false);
            LoanAD.SetRange("Avance Repas", false);
            if LoanAD.Find('-') then
                repeat
                    if calcSolde(LoanAD, SalaryLineTmp) then begin
                        SalaryLineTmp.Advances := SalaryLineTmp.Advances + ROUND(LoanAD.CalcMnPrinciPeriodeeng(DateD, DateF), 0.001);
                        if (ROUND(LoanAD.CalcMnPrinciPeriodeeng(DateD, DateF), 0.001) <> 0) then
                            InsererLigne(SalaryLineTmp, LoanAD, ROUND(LoanAD.CalcMnPrinciPeriodeeng(DateD, DateF), 0.001), 0);
                    end;
                until LoanAD.Next = 0;

        end else

            if (SalaryLineTmp.Month = SalaryLineTmp.Month::STC) or (SalaryLineTmp.Month = SalaryLineTmp.Month::Prime) then begin
                //   Wrong Expression
                Mnt := 0;
                Mnt := SalaryLineTmp."Net salary";
                //GL3900   Clear(PrimeType);
                //GL3900    if PrimeType.Get(SalaryLineTmp."Type Prime") then;

                if Mnt <> 0 then begin
                    LoanAD.Reset;
                    LoanAD.SetCurrentkey(Employee, Type, Status, "No.", "Avance Sur Prime");
                    LoanAD.SetFilter(Employee, SalaryLineTmp.Employee);
                    LoanAD.SetRange(Type, LoanAD.Type::Loan);
                    LoanAD.SetRange(Status, LoanAD.Status::"In progress");
                    //GL3900
                    /*  if PrimeType."Type Calcul" = 3 then
                          LoanAD.SetRange("Avance Repas", true)
                      else
                          LoanAD.SetRange("Avance Sur Prime", true);
                      LoanAD.SetRange("Not include", false);*/
                    //GL3900

                    if LoanAD.Find('-') then
                        repeat
                            MntTmp := 0;
                            MntTmp := ROUND(LoanAD.CalcMntInetretAvPrime(DateF), 0.001);
                            if Mnt < MntTmp then begin
                                SalaryLineTmp.Loans := SalaryLineTmp.Loans + Mnt;
                                InsererLigne(SalaryLineTmp, LoanAD, (Mnt - MntTmp), MntTmp);
                                Mnt := 0;
                            end
                            else begin
                                if (Mnt - MntTmp) < LoanAD.CalcMnPRincipaleRemb then begin
                                    SalaryLineTmp.Loans := SalaryLineTmp.Loans + Mnt;
                                    InsererLigne(SalaryLineTmp, LoanAD, (Mnt - MntTmp), MntTmp);
                                    Mnt := 0;
                                end else begin
                                    SalaryLineTmp.Loans := SalaryLineTmp.Loans + LoanAD.CalcMnPRincipaleRemb;
                                    InsererLigne(SalaryLineTmp, LoanAD, LoanAD.CalcMnPRincipaleRemb, MntTmp);
                                    Mnt := Mnt - (MntTmp + LoanAD.CalcMnPRincipaleRemb);
                                end;
                            end;
                        until (LoanAD.Next = 0) or (Mnt = 0);


                    // Advance sur prime
                    LoanAD.Reset;
                    LoanAD.SetCurrentkey(Employee, Type, Status, "No.", "Avance Sur Prime");
                    LoanAD.SetFilter(Employee, SalaryLineTmp.Employee);
                    LoanAD.SetRange(Type, LoanAD.Type::Advance);
                    LoanAD.SetRange(Status, LoanAD.Status::"In progress");
                    //GL3900
                    /*    if PrimeType."Type Calcul" = 3 then
                            LoanAD.SetRange("Avance Repas", true)
                        else
                            LoanAD.SetRange("Avance Sur Prime", true);
    */
                    //GL3900
                    LoanAD.SetRange("Not include", false);
                    if LoanAD.Find('-') then
                        repeat

                            MntTmp := 0;
                            MntTmp := ROUND(LoanAD.CalcMntInetretAvPrime(DateF), 0.001);
                            if Mnt < MntTmp then begin
                                SalaryLineTmp.Advances := SalaryLineTmp.Advances + Mnt;
                                InsererLigne(SalaryLineTmp, LoanAD, (Mnt - MntTmp), MntTmp);
                                Mnt := 0;
                            end
                            else begin
                                if (Mnt - MntTmp) < LoanAD.CalcMnPRincipaleRemb then begin
                                    SalaryLineTmp.Advances := SalaryLineTmp.Advances + Mnt;
                                    InsererLigne(SalaryLineTmp, LoanAD, (Mnt - MntTmp), MntTmp);
                                    Mnt := 0;
                                end else begin
                                    SalaryLineTmp.Advances := SalaryLineTmp.Advances + LoanAD.CalcMnPRincipaleRemb;
                                    InsererLigne(SalaryLineTmp, LoanAD, LoanAD.CalcMnPRincipaleRemb, MntTmp);
                                    Mnt := Mnt - (MntTmp + LoanAD.CalcMnPRincipaleRemb);
                                end;
                            end;
                        until (LoanAD.Next = 0) or (Mnt = 0);
                    //GL3900
                    /*   if PrimeType."Type Calcul" <> 3 then begin
                           LoanAD.Reset;
                           LoanAD.SetCurrentkey(Employee, Type, Status, "No.", "Avance Sur Prime");
                           LoanAD.SetFilter(Employee, SalaryLineTmp.Employee);
                           LoanAD.SetRange(Type, LoanAD.Type::Advance);
                           LoanAD.SetRange(Status, LoanAD.Status::"In progress");
                           LoanAD.SetRange("Avance Sur Prime", false);
                           LoanAD.SetRange("Avance Aid", false);
                           LoanAD.SetRange("Not include", false);
                           if LoanAD.Find('-') then
                               repeat
                                   MntTmp := 0;
                                   MntTmp := ROUND(LoanAD.CalcMntInetretAvPrime(DateF), 0.001);
                                   if Mnt < MntTmp then begin
                                       SalaryLineTmp.Advances := SalaryLineTmp.Advances + Mnt;
                                       InsererLigne(SalaryLineTmp, LoanAD, (Mnt - MntTmp), MntTmp);
                                       Mnt := 0;
                                   end
                                   else begin
                                       if (Mnt - MntTmp) < LoanAD.CalcMnPRincipaleRemb then begin
                                           SalaryLineTmp.Advances := SalaryLineTmp.Advances + Mnt;
                                           InsererLigne(SalaryLineTmp, LoanAD, (Mnt - MntTmp), MntTmp);
                                           Mnt := 0;
                                       end else begin
                                           SalaryLineTmp.Advances := SalaryLineTmp.Advances + LoanAD.CalcMnPRincipaleRemb;
                                           InsererLigne(SalaryLineTmp, LoanAD, LoanAD.CalcMnPRincipaleRemb, MntTmp);
                                           Mnt := Mnt - (MntTmp + LoanAD.CalcMnPRincipaleRemb);
                                       end;
                                   end;
                               until (LoanAD.Next = 0) or (Mnt = 0);
                       end;*/
                    //GL3900
                end;
            end;
    end;


    procedure InsererLigneRembourcement(var SalaryLine: Record "Salary Lines"; LoanAdvanceHeader: Record "Loan & Advance Header")
    var
        LoanAdvanceLines: Record "Loan & Advance Lines";
        ExistLoanAdvanceLine: Record "Loan & Advance Lines";
        ln: Integer;
        Employee: Record Employee;
    begin
        LoanAdvanceLines.Reset;
        LoanAdvanceLines.SetRange("No.", LoanAdvanceHeader."No.");
        if LoanAdvanceLines.Find('+') then
            ln := LoanAdvanceLines."Entry No." + 10000
        else
            ln := 10000;

        Employee.Get(SalaryLine.Employee);

        LoanAdvanceHeader.CalcFields("Repaiment lines", "Repaid amount", "Repaid %");

        LoanAdvanceLines.Reset;
        LoanAdvanceLines."No." := LoanAdvanceHeader."No.";
        LoanAdvanceLines."Entry No." := ln;
        LoanAdvanceLines.Employee := LoanAdvanceHeader.Employee;
        LoanAdvanceLines."Employee Posting Group" := Employee."Employee Posting Group";
        LoanAdvanceLines."Employee Statistic Group" := Employee."Statistics Group Code";
        // RK
        LoanAdvanceLines."Global dimension 1" := Employee."Global Dimension 1 Code";
        LoanAdvanceLines."Global dimension 2" := Employee."Global Dimension 2 Code";
        // RK
        //MBY 11/02/2010
        //LoanAdvanceLines.direction  := Employee.Direction;
        LoanAdvanceLines.service := Employee.Service;
        LoanAdvanceLines.section := Employee.Section;
        //MBY 11/02/2010
        LoanAdvanceLines.Type := LoanAdvanceHeader.Type;
        LoanAdvanceLines."Document type" := LoanAdvanceHeader."Document type";
        LoanAdvanceLines."Line Amount" := (LoanAdvanceHeader."Total to repay" - LoanAdvanceHeader."Repaid amount")
                                                       /
                                                       (LoanAdvanceHeader."Repayment slices" - LoanAdvanceHeader."Repaiment lines");
        LoanAdvanceLines."Line %" := (LoanAdvanceLines."Line Amount" * 100) / LoanAdvanceHeader."Total to repay";
        LoanAdvanceLines.Status := 0;
        LoanAdvanceLines.Paid := false;
        LoanAdvanceLines."Payment No." := SalaryLine."No.";
        LoanAdvanceLines.Month := SalaryLine.Month;
        LoanAdvanceLines.Year := SalaryLine.Year;

        LoanAdvanceLines."Date Paie" := SalaryLine."Posting Date";
        LoanAdvanceLines."User ID" := UserId;
        LoanAdvanceLines."Last Date Modified" := WorkDate;
        LoanAdvanceLines."Avance Repas" := LoanAdvanceHeader."Avance Repas";
        ExistLoanAdvanceLine.SetRange("No.", LoanAdvanceHeader."No.");
        ExistLoanAdvanceLine.SetRange(Employee, LoanAdvanceHeader.Employee);
        ExistLoanAdvanceLine.SetRange("Payment No.", SalaryLine."No.");

        LoanAdvanceLines.Insert
    end;


    procedure CloturerDocument(Header: Record "Loan & Advance Header")
    var
        Lines: Record "Loan & Advance Lines";
        Test: Boolean;
        LoanAdvanceEntry: Record "Loan & Advance Entry";
    begin
        Header.CalcFields("Repaid amount", "Repaid %", "Principal Amount");
        if ((Header."Principal Amount" = Header.Amount)) then begin
            Test := true;
            Lines.SetRange("No.", Header."No.");
            if Lines.Find('-') then
                repeat
                    if not Lines.Paid then
                        Test := false;
                until Lines.Next = 0;
            if Test then begin
                Header.Status := 1;
                Header."User ID" := UserId;
                Header."Last Date Modified" := WorkDate;
                Header.Modify;

                Lines.Reset;
                Lines.SetRange("No.", Header."No.");
                if Lines.Find('-') then begin
                    Lines.Status := 1;
                    Lines.Modify;
                end;
                LoanAdvanceEntry.Reset;
                LoanAdvanceEntry.SetRange("No.", Header."No.");
                if LoanAdvanceEntry.Find('-') then
                    repeat
                        LoanAdvanceEntry.Status := 1;
                        LoanAdvanceEntry.Modify;
                    until LoanAdvanceEntry.Next = 0;
            end;
        end;
    end;


    procedure EnregDocument(LoanAdvance: Record "Loan & Advance"; DateCompta: Date)
    var
        LoanAdvanceHeader: Record "Loan & Advance Header";
        errMC: label 'Validation impossible.\Some important parameter aren''t mentionned.';
        LoanAdvanceEntry: Record "Loan & Advance Entry";
    begin
        if not TestValiditeDocument(LoanAdvance) then
            Error(errMC);

        if ((LoanAdvance."Repayment slices" <> 0)
            and
            (LoanAdvance.Amount <> 0)
           ) then begin
            LoanAdvanceHeader.Reset;
            LoanAdvanceHeader.Init;
            LoanAdvanceHeader.TransferFields(LoanAdvance);
            LoanAdvanceHeader."No." := LoanAdvance."No.";
            // LoanAdvanceHeader."N° Bon Caisse" := LoanAdvance."N° Bon Caisse";
            LoanAdvanceHeader.Employee := LoanAdvance.Employee;
            LoanAdvanceHeader.Name := LoanAdvance.Name;
            LoanAdvanceHeader."Job Title" := LoanAdvance."Job Title";
            LoanAdvanceHeader."Employee Posting Group" := LoanAdvance."Employee Posting Group";
            LoanAdvanceHeader."Employee Statistic Group" := LoanAdvance."Employee Statistic Group";
            // RK
            LoanAdvanceHeader."Global dimension 1" := LoanAdvance."Global dimension 1";
            LoanAdvanceHeader."Global dimension 2" := LoanAdvance."Global dimension 2";
            // RK
            //MBY 11/02/2010
            LoanAdvanceHeader.direction := LoanAdvance.direction;
            LoanAdvanceHeader.service := LoanAdvance.service;
            LoanAdvanceHeader.section := LoanAdvance.section;
            //MBY 11/02/2010
            //    LoanAdvanceHeader."Pret CNSS" := LoanAdvance."Type Pret";
            LoanAdvanceHeader.Type := LoanAdvance.Type;
            LoanAdvanceHeader."Document type" := LoanAdvance."Document type";
            LoanAdvanceHeader.Amount := LoanAdvance.Amount;
            LoanAdvanceHeader."Interest %" := LoanAdvance."Interest %";
            LoanAdvanceHeader."Total to repay" := LoanAdvance."Total to repay";
            LoanAdvanceHeader."N° document Extr." := LoanAdvance."N° document Extr.";
            LoanAdvanceHeader."Montant tranche" := LoanAdvance."Montant tranche";
            LoanAdvanceHeader."Date d'effet" := LoanAdvance."Date d'effet";

            LoanAdvanceHeader."Avance Sur Prime" := LoanAdvance."Avance Sur Prime";
            LoanAdvanceHeader."Avance sur congé" := LoanAdvance."Avance sur congé";
            LoanAdvanceHeader."Repayment slices" := LoanAdvance."Repayment slices";
            LoanAdvanceHeader."No. Series" := LoanAdvance."No. Series";
            LoanAdvanceHeader."Validation date" := WorkDate;
            LoanAdvanceHeader."Date Comptabilisation" := DateCompta;
            LoanAdvanceHeader.Status := 0;
            LoanAdvanceHeader."User ID" := UserId;
            LoanAdvanceHeader."Last Date Modified" := LoanAdvance."Last Date Modified";
            LoanAdvanceHeader."Avance Repas" := LoanAdvance."Avance Repas";
            //LoanAdvanceHeader.INSERT;
            //       Test := TRUE;
            //       IF TRUE THEN
            if LoanAdvanceHeader.Insert then begin
                LoanAdvanceEntry.Reset;
                LoanAdvanceEntry.Init;
                LoanAdvanceEntry."No." := LoanAdvance."No.";
                LoanAdvanceEntry."Entry No." := 0;
                LoanAdvanceEntry.Employee := LoanAdvance.Employee;
                LoanAdvanceEntry.Name := LoanAdvance.Name;
                LoanAdvanceEntry."Employee Posting Group" := LoanAdvance."Employee Posting Group";
                LoanAdvanceEntry."Employee Statistic Group" := LoanAdvance."Employee Statistic Group";
                // RK
                LoanAdvanceEntry."Global dimension 1" := LoanAdvance."Global dimension 1";
                LoanAdvanceEntry."Global dimension 2" := LoanAdvance."Global dimension 2";
                // MESSAGE('%1',LoanAdvance."Date Comptabilisation");
                // RK
                //MBY 11/02/2010
                LoanAdvanceEntry.direction := LoanAdvance.direction;
                LoanAdvanceEntry.service := LoanAdvance.service;
                LoanAdvanceEntry.section := LoanAdvance.section;
                //MBY 11/02/2010

                LoanAdvanceEntry.Month := Date2dmy(DateCompta, 2) - 1;
                LoanAdvanceEntry.Year := Date2dmy(DateCompta, 3);
                LoanAdvanceEntry."Date Paie" := DateCompta;
                LoanAdvanceEntry.Type := LoanAdvance.Type;
                LoanAdvanceEntry."Document type" := LoanAdvance."Document type";
                LoanAdvanceEntry."Entry type" := 0;
                LoanAdvanceEntry.Amount := LoanAdvance."Total to repay";
                LoanAdvanceEntry."User ID" := UserId;
                LoanAdvanceEntry."Last Date Modified" := WorkDate;
                LoanAdvanceEntry."Avance Repas" := LoanAdvance."Avance Repas";
                LoanAdvanceEntry.Insert;
                LoanAdvance.Delete;
            end
            else
                Error(errValidate);
        end
    end;


    procedure TestValiditeDocument(LoanAdvance: Record "Loan & Advance"): Boolean
    var
        TypeDoc: Record "Loan & Advance Type";
    begin
        Clear(TypeDoc);
        TypeDoc.Get(LoanAdvance."Document type");
        if TypeDoc."Imputation Comptable" = 0 then begin
            if ((LoanAdvance.Employee <> '')
                and (LoanAdvance."Employee Posting Group" <> '')
                and (LoanAdvance."Document type" <> '')
                and (LoanAdvance.Amount > 0)
                and (LoanAdvance."Total to repay" > 0)
                and (LoanAdvance."Repayment slices" > 0)
                and (LoanAdvance."Bal. Account No." <> '')
               ) then
                exit(true)
            else
                exit(false);
        end else
            if ((LoanAdvance.Employee <> '')
                and (LoanAdvance."Employee Posting Group" <> '')
                and (LoanAdvance."Document type" <> '')
                and (LoanAdvance.Amount > 0)
                and (LoanAdvance."Total to repay" > 0)
                and (LoanAdvance."Repayment slices" > 0)
                   ) then
                exit(true)
            else
                exit(false);
    end;


    procedure EcrComptaPaiement(LoanAdvance: Record "Loan & Advance"; DateValidation: Date; TypeValidation: Option)
    var
        HumResSetup: Record "Human Resources Setup";
        errConfig: label 'General Journal Template empty in Human Resource Parameter.';
        LAType: Record "Loan & Advance Type";
        errLATypeMissing: label 'Loan & Advance Type missing.';
        errWrongParam: label 'Account No. or Bal. Account No. empty in Loan & Advance type parameter.';
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        success: label 'Document posting operation successfull.\Lines inserted on Journal : %1 - %2.';
        Line: Integer;
        BankAccount: Record "Bank Account";
        CourtT: Decimal;
        LongT: Decimal;
        SuccesV: label 'Document Validé Avec Succées.';
        T1: Record "Payment Header";
        T2: Record "Payment Line";
        Slr: Record Employee;
        "Compte bancaire salarié": Record "Employee Bank Account";
        N: Text[30];
    begin
        HumResSetup.Get();

        if not LAType.Get(LoanAdvance."Document type") then
            Error(errLATypeMissing);

        if ((LAType."Account No." = '') or (LAType."Bal. Account No." = '')) then
            Error(errWrongParam);

        if TypeValidation <> 2 then begin
            if (HumResSetup."General Journal Template" = '') then
                Error(errConfig);
            GenJournalLine.SetRange("Journal Template Name", HumResSetup."General Journal Template");
            GenJournalLine.SetRange("Journal Batch Name", HumResSetup."Gen. Journal Batch (L&A)");
            //GenJournalLine.SETRANGE ("Line No.",Line);
            GenJournalLine.SetRange("Document No.", LoanAdvance."No.");
            GenJournalLine.DeleteAll;
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", HumResSetup."General Journal Template");
            GenJournalLine.SetRange("Journal Batch Name", HumResSetup."Gen. Journal Batch (L&A)");

            if GenJournalLine.Find('+') then
                Line := GenJournalLine."Line No." + 10000
            else
                Line := 10000;

            GenJournalLine.Reset;
            GenJournalLine."Journal Template Name" := HumResSetup."General Journal Template";
            if HumResSetup."Gen. Journal Batch (L&A)" <> '' then
                GenJournalLine."Journal Batch Name" := HumResSetup."Gen. Journal Batch (L&A)"
            else begin
                GenJournalBatch.SetRange("Journal Template Name", HumResSetup."General Journal Template");
                if GenJournalBatch.Find('-') then
                    GenJournalLine."Journal Batch Name" := HumResSetup."Gen. Journal Batch (Payroll)";
            end;

            GenJournalLine.Validate("Line No.", Line);
            GenJournalLine.Validate("Posting Date", DateValidation);
            case LAType."Account Type" of
                0:
                    GenJournalLine.Validate("Account Type", 0);
                1:
                    begin
                        GenJournalLine.Validate("Account Type", 3);
                        if BankAccount.Get(LAType."Bal. Account No.") then
                            GenJournalLine.Validate("Currency Code", BankAccount."Currency Code");
                    end;
            end;

            GenJournalLine.Validate("Account No.", LAType."Account No.");
            GenJournalLine.Validate("Posting Date", DateValidation);
            GenJournalLine."Source Code" := LAType."Source Code";
            GenJournalLine.Validate("Document Type", 0);
            GenJournalLine.Validate("Document No.", LoanAdvance."No.");
            case LAType."Bal. Account Type" of
                0:
                    begin
                        GenJournalLine.Validate("Bal. Account Type", 0);
                        GenJournalLine.Validate("Currency Code", '');
                    end;
                1:
                    begin
                        GenJournalLine.Validate("Bal. Account Type", 3);
                        if BankAccount.Get(LAType."Bal. Account No.") then
                            GenJournalLine.Validate("Currency Code", BankAccount."Currency Code");
                    end;
            end;

            GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
            GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
            GenJournalLine."Source No." := LoanAdvance.Employee;
            GenJournalLine."External Document No." := LoanAdvance."N° document Extr.";
            if LoanAdvance.Type = 0 then begin
                GenJournalLine.Validate("Bal. Account No.", LoanAdvance."Bal. Account No.");
                GenJournalLine.Validate("Debit Amount", LoanAdvance.Amount);
                GenJournalLine.Insert;
            end else begin
                //MBY 03/03/2010
                //LoanAdvance.CalcPrêtLongetCourtTerme(CourtT,LongT);
                CourtT := LoanAdvance.Amount;
                LongT := LoanAdvance."Total to repay" - LoanAdvance.Amount;
                //MBY 03/803/2010
                GenJournalLine.Validate("Posting Date", DateValidation);

                if CourtT <> 0 then begin
                    case LAType."Account Type" of
                        0:
                            begin
                                GenJournalLine.Validate("Account Type", 0);
                                GenJournalLine.Validate("Account No.", LAType."Account No.");
                                GenJournalLine.Validate("Currency Code", '');
                            end;
                        1:
                            begin
                                GenJournalLine.Validate("Account Type", 3);
                                GenJournalLine.Validate("Account No.", LAType."Account No.");
                                if BankAccount.Get(LAType."Account No.") then
                                    GenJournalLine.Validate("Currency Code", BankAccount."Currency Code");
                            end;
                    end;
                    GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
                    GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
                    GenJournalLine."Source No." := LoanAdvance.Employee;
                    GenJournalLine.Validate("Debit Amount", CourtT);
                    GenJournalLine.Insert;
                end;
                //
                if LongT <> 0 then begin
                    Line := Line + 10000;
                    GenJournalLine."Line No." := Line;
                    GenJournalLine.Validate("Posting Date", DateValidation);

                    case LAType."Account Type Long Terme" of
                        0:
                            begin
                                GenJournalLine.Validate("Account Type", 0);
                                GenJournalLine.Validate("Account No.", LAType."Account No. Lng Termeo");
                                GenJournalLine.Validate("Currency Code", '');
                            end;
                        1:
                            begin
                                GenJournalLine.Validate("Account Type", 3);
                                GenJournalLine.Validate("Account No.", LAType."Account No. Lng Termeo");
                                if BankAccount.Get(LAType."Account No. Lng Termeo") then
                                    GenJournalLine.Validate("Currency Code", BankAccount."Currency Code");
                            end;
                    end;
                    GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
                    GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
                    GenJournalLine."External Document No." := LoanAdvance."N° document Extr.";
                    GenJournalLine."Source No." := LoanAdvance.Employee;
                    GenJournalLine.Validate("Credit Amount", LongT);
                    GenJournalLine.Insert;
                end;
                //
                Line := Line + 10000;
                GenJournalLine."Line No." := Line;
                GenJournalLine.Validate("Posting Date", DateValidation);

                case LoanAdvance."Bal. Account Type" of
                    0:
                        begin
                            GenJournalLine.Validate("Bal. Account Type", 0);
                            GenJournalLine.Validate("Account No.", LoanAdvance."Bal. Account No.");
                            GenJournalLine.Validate("Currency Code", '');
                        end;
                    1:
                        begin
                            GenJournalLine.Validate("Account Type", 3);
                            GenJournalLine.Validate("Account No.", LoanAdvance."Bal. Account No.");
                            if BankAccount.Get(LoanAdvance."Bal. Account No.") then
                                GenJournalLine.Validate("Currency Code", BankAccount."Currency Code");
                        end;
                end;
                GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
                GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
                GenJournalLine."Source No." := LoanAdvance.Employee;
                GenJournalLine."External Document No." := LoanAdvance."N° document Extr.";
                //MBY 03/03/2010
                //GenJournalLine.VALIDATE ("Credit Amount",LoanAdvance.Amount);
                GenJournalLine.Validate("Credit Amount", CourtT);
                //MBY 03/03/2010

                GenJournalLine.Insert;
                //-------------------------------MBY 03/03/2010
                if LongT <> 0 then begin
                    Line := Line + 10000;
                    GenJournalLine."Line No." := Line;
                    GenJournalLine.Validate("Posting Date", DateValidation);

                    case LAType."Account Type" of
                        0:
                            begin
                                GenJournalLine.Validate("Account Type", 0);
                                GenJournalLine.Validate("Account No.", LAType."Account No.");
                                GenJournalLine.Validate("Currency Code", '');
                            end;
                        1:
                            begin
                                GenJournalLine.Validate("Account Type", 3);
                                GenJournalLine.Validate("Account No.", LAType."Account No.");
                                if BankAccount.Get(LAType."Account No.") then
                                    GenJournalLine.Validate("Currency Code", BankAccount."Currency Code");
                            end;
                    end;
                    GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
                    GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
                    GenJournalLine."Source No." := LoanAdvance.Employee;
                    GenJournalLine."External Document No." := LoanAdvance."N° document Extr.";
                    //MBY 03/03/2010
                    //GenJournalLine.VALIDATE ("Credit Amount",LoanAdvance.Amount);
                    GenJournalLine.Validate("Debit Amount", LongT);
                    //MBY 03/03/2010

                    GenJournalLine.Insert;
                end;
                //-------------------------------MBY 03/03/2010

            end;

            case TypeValidation of
                //MBY 09/04/2009 0 :  MESSAGE (success,HumResSetup."General Journal Template", HumResSetup."Gen. Journal Batch (Payroll)");
                1:
                    begin
                        GenJournalLine.SetRange("Journal Template Name", HumResSetup."General Journal Template");
                        GenJournalLine.SetRange("Journal Batch Name", HumResSetup."Gen. Journal Batch (L&A)");
                        //GenJournalLine.SETRANGE ("Line No.",Line);
                        GenJournalLine.SetRange("Document No.", LoanAdvance."No.");
                        if GenJournalLine.Find('-') then
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
                        //MESSAGE (SuccesV);
                    end;
            end;
        end else begin
            LoanAdvance.TestField("Type reglement");
            T1.Init;
            T1.Validate("Payment Class", LoanAdvance."Type reglement");
            T1."No." := LoanAdvance."No.";
            T1.Validate("Posting Date", DateValidation);
            case LoanAdvance."Bal. Account Type" of
                0:
                    T1."Account Type" := 0;
                1:
                    T1."Account Type" := 3;
            end;

            T1.Validate("Account No.", LoanAdvance."Bal. Account No.");
            if T1.Insert then begin
                Slr.Get(LoanAdvance.Employee);


                if Slr."Default Bank Account Code" <> '' then begin
                    "Compte bancaire salarié".Reset;
                    "Compte bancaire salarié".SetRange("Employee No.", LoanAdvance.Employee);
                    "Compte bancaire salarié".SetRange(Code, Slr."Default Bank Account Code");

                    if not "Compte bancaire salarié".Get(LoanAdvance.Employee, Slr."Default Bank Account Code")
                      then
                        N := ''
                    else begin
                        if ("Compte bancaire salarié"."Bank Account No." <> '')
                          then
                            N := "Compte bancaire salarié"."Bank Branch No." + "Compte bancaire salarié"."Agency Code" +
                            "Compte bancaire salarié"."Bank Account No." + CopyStr(Format("Compte bancaire salarié"."RIB Key"), 2, 2)
                        else
                            N := 'RIB non mentionné'
                    end;
                end;
                T2.Init;
                T2."No." := LoanAdvance."No.";
                T2."Line No." := 1000;
                T2."Account Type" := 5;
                T2.Validate("Account No.", LoanAdvance.Employee);
                T2."Posting Group" := LoanAdvance."Employee Posting Group";
                T2."Payment Class" := LoanAdvance."Type reglement";
                T2.Validate("Bank Account Code", "Compte bancaire salarié".Code);
                T2."Document No." := LoanAdvance."No.";
                T2."Due Date" := DateValidation;
                T2."Posting Date" := DateValidation;
                T2.Validate("Debit Amount", LoanAdvance.Amount);
                T2."External Document No." := LoanAdvance."N° document Extr.";
                if T2.Insert then
                    Message('Validation Avec Succes');
            end;
        end;
    end;


    procedure EcrComptaPaiementRepas(var LoanAdvance: Record "Loan & Advance"; DateValidation: Date; TypeValidation: Option)
    var
        HumResSetup: Record "Human Resources Setup";
        errConfig: label 'General Journal Template empty in Human Resource Parameter.';
        LAType: Record "Loan & Advance Type";
        errLATypeMissing: label 'Loan & Advance Type missing.';
        errWrongParam: label 'Account No. or Bal. Account No. empty in Loan & Advance type parameter.';
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        success: label 'Document posting operation successfull.\Lines inserted on Journal : %1 - %2.';
        Line: Integer;
        BankAccount: Record "Bank Account";
        CourtT: Decimal;
        LongT: Decimal;
        SuccesV: label 'Document Validé Avec Succées.';
        T1: Record "Payment Header";
        T2: Record "Payment Line";
        Slr: Record Employee;
        "Compte bancaire salarié": Record "Employee Bank Account";
        N: Text[30];
        LoanAdvanceTmp: Record "Loan & Advance";
        Process: Record "Payment Class";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GetProcess: Record "Payment Class";
        LN: Integer;
    begin
        HumResSetup.Get();

        if not LAType.Get(LoanAdvance."Document type")
          then
            Error(errLATypeMissing);

        if ((LAType."Account No." = '')
            or
            (LAType."Bal. Account No." = ''))
          then
            Error(errWrongParam);
        if TypeValidation = 2 then begin
            LoanAdvance.TestField("Type reglement");
            LoanAdvanceTmp.Reset;
            LoanAdvanceTmp.CopyFilters(LoanAdvance);

            if not LoanAdvanceTmp.Find('-') then
                exit;

            T1.Init;
            if T1."No." = '' then begin
                Process.Get(LoanAdvanceTmp."Type reglement");
                Process.TestField("Header No. Series");
                T1."No. Series" := Process."Header No. Series";
                NoSeriesMgt.InitSeries(Process."Header No. Series", T1."No. Series", 0D, T1."No.", T1."No. Series");
                T1.Validate("Payment Class", LoanAdvanceTmp."Type reglement");
            end;
            //GL2024 License  T1.InitHeader;
            //GL2024 License
            T1."Posting Date" := WorkDate();
            T1."Document Date" := WorkDate();
            T1.Validate("Account Type", T1."Account Type"::"Bank Account");
            //GL2024 License

            T1.Insert(true);
            //T1."No.":= LoanAdvance."No.";
            T1.Validate("Posting Date", DateValidation);
            case LoanAdvanceTmp."Bal. Account Type" of
                0:
                    T1."Account Type" := 0;
                1:
                    T1."Account Type" := 3;
            end;

            T1.Validate("Account No.", LoanAdvanceTmp."Bal. Account No.");
            T1."Document Date" := WorkDate;
            if T1.Modify then begin
                LN := 0;
                repeat
                    Slr.Get(LoanAdvanceTmp.Employee);


                    if Slr."Default Bank Account Code" <> '' then begin
                        "Compte bancaire salarié".Reset;
                        "Compte bancaire salarié".SetRange("Employee No.", LoanAdvanceTmp.Employee);
                        "Compte bancaire salarié".SetRange(Code, Slr."Default Bank Account Code");

                        if not "Compte bancaire salarié".Find('-')
                          then
                            N := ''
                        else begin
                            if ("Compte bancaire salarié"."Bank Account No." <> '')
                              then
                                N := "Compte bancaire salarié"."Bank Branch No." + "Compte bancaire salarié"."Agency Code" +
                                "Compte bancaire salarié"."Bank Account No." + CopyStr(Format("Compte bancaire salarié"."RIB Key"), 2, 2)
                            else
                                N := 'RIB non mentionné'
                        end;
                    end;
                    T2.Init;
                    T2."No." := T1."No.";
                    LN := LN + 1000;
                    T2."Line No." := LN;
                    T2."Account Type" := 5;
                    T2.Validate("Account No.", LoanAdvanceTmp.Employee);
                    T2."Posting Group" := LoanAdvance."Employee Posting Group";
                    T2."Payment Class" := LoanAdvance."Type reglement";
                    if N <> '' then
                        T2.Validate("Bank Account Code", "Compte bancaire salarié".Code);
                    T2."Document No." := LoanAdvanceTmp."No.";
                    T2."Due Date" := DateValidation;
                    T2."Posting Date" := DateValidation;
                    T2.Validate("Debit Amount", LoanAdvanceTmp.Amount);
                    T2."External Document No." := LoanAdvanceTmp."N° document Extr.";
                    if T2.Insert then;

                until LoanAdvanceTmp.Next = 0;
                Message('Validation Avec Succes');
            end;
        end;
    end;


    procedure EcrComptaPaiement2ln(LoanAdvance: Record "Loan & Advance"; DateValidation: Date; TypeValidation: Option)
    var
        HumResSetup: Record "Human Resources Setup";
        errConfig: label 'General Journal Template empty in Human Resource Parameter.';
        LAType: Record "Loan & Advance Type";
        errLATypeMissing: label 'Loan & Advance Type missing.';
        errWrongParam: label 'Account No. or Bal. Account No. empty in Loan & Advance type parameter.';
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        success: label 'Document posting operation successfull.\Lines inserted on Journal : %1 - %2.';
        Line: Integer;
        BankAccount: Record "Bank Account";
        JTN: Code[10];
        JBN: Code[10];
    begin
        HumResSetup.Get();

        if not LAType.Get(LoanAdvance."Document type")
          then
            Error(errLATypeMissing);

        if ((LAType."Account No." = '')
            or
            (LAType."Bal. Account No." = ''))
          then
            Error(errWrongParam);

        if (HumResSetup."General Journal Template" = '')
          then
            Error(errConfig);

        GenJournalLine.SetRange("Journal Template Name", HumResSetup."General Journal Template");
        if GenJournalLine.Find('+') then
            Line := GenJournalLine."Line No." + 10000
        else
            Line := 10000;

        // Ecriture N°1
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := HumResSetup."General Journal Template";
        if HumResSetup."Gen. Journal Batch (L&A)" <> '' then
            GenJournalLine."Journal Batch Name" := HumResSetup."Gen. Journal Batch (L&A)"
        else begin
            GenJournalBatch.SetRange("Journal Template Name", HumResSetup."General Journal Template");
            if GenJournalBatch.Find('-') then
                GenJournalLine."Journal Batch Name" := HumResSetup."Gen. Journal Batch (Payroll)";
        end;

        JTN := GenJournalLine."Journal Template Name";
        JBN := GenJournalLine."Journal Batch Name";
        GenJournalLine."Source Code" := LAType."Source Code";
        GenJournalLine.Validate("Line No.", Line);
        GenJournalLine.Validate("Posting Date", DateValidation);

        case LAType."Account Type" of
            0:
                GenJournalLine.Validate("Account Type", 0);
            1:
                begin
                    GenJournalLine.Validate("Account Type", 3);
                    if BankAccount.Get(LAType."Bal. Account No.") then
                        GenJournalLine.Validate("Currency Code", BankAccount."Currency Code");
                end;
        end;
        GenJournalLine.Validate("Account No.", LAType."Account No.");
        GenJournalLine.Validate("Posting Date", DateValidation);
        GenJournalLine.Validate("Document Type", 0);
        GenJournalLine.Validate("Document No.", LoanAdvance."No.");
        GenJournalLine.Validate("Debit Amount", LoanAdvance."Total to repay");
        GenJournalLine.Insert;

        // Ecriture N°2 : Contre partie
        Line := Line + 1000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := HumResSetup."General Journal Template";
        if HumResSetup."Gen. Journal Batch (L&A)" <> '' then
            GenJournalLine."Journal Batch Name" := HumResSetup."Gen. Journal Batch (L&A)"

        else begin
            GenJournalBatch.SetRange("Journal Template Name", HumResSetup."General Journal Template");
            if GenJournalBatch.Find('-') then
                GenJournalLine."Journal Batch Name" := HumResSetup."Gen. Journal Batch (Payroll)";
        end;

        GenJournalLine.Validate("Line No.", Line + 10000);
        GenJournalLine.Validate("Posting Date", DateValidation);
        GenJournalLine."Source Code" := LAType."Source Code";
        case LAType."Account Type" of
            0:
                GenJournalLine.Validate("Account Type", 0);
            1:
                begin
                    GenJournalLine.Validate("Account Type", 3);
                    if BankAccount.Get(LAType."Bal. Account No.") then
                        GenJournalLine.Validate("Currency Code", BankAccount."Currency Code");
                end;
        end;
        GenJournalLine.Validate("Account No.", LAType."Bal. Account No.");
        GenJournalLine.Validate("Posting Date", DateValidation);
        GenJournalLine.Validate("Document Type", 0);
        GenJournalLine.Validate("Document No.", LoanAdvance."No.");
        GenJournalLine.Validate("Credit Amount", LoanAdvance."Total to repay");
        GenJournalLine.Insert;

        // Validation selon type

        case TypeValidation of
            0:
                Message(success, HumResSetup."General Journal Template", HumResSetup."Gen. Journal Batch (Payroll)");
            1:
                begin
                    GenJournalLine.SetRange("Journal Template Name", JTN);
                    GenJournalLine.SetRange("Journal Batch Name", JBN);
                    //GenJournalLine.SETFILTER ("Line No.",'%1|%2',Line,Line+10000);
                    GenJournalLine.SetRange("Document No.", LoanAdvance."No.");
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                    end;
                end;
        end;
    end;


    procedure Valider(var GenJournalLine: Record "Gen. Journal Line")
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin
    end;


    procedure "-------------"()
    begin
    end;


    procedure Solder(var Header: Record "Loan & Advance Header"; var Datecompta: Date; var TypeCpt: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset",Employee; NumCpt: Code[20]; NumDoc: Code[20]; DateP: Date)
    var
        Lines: Record "Loan & Advance Lines";
        ln: Integer;
        DateF: Date;
        ResSetup: Record "Human Resources Setup";
        MontantPrin: Decimal;
        Montantint: Decimal;
        Mnttot: Decimal;
        Ltype: Record "Loan & Advance Type";
    begin
        Header.CalcFields("Repaid amount", "Repaid %", "Principal Amount", "Interest Amount");
        if Header."Repaid amount" >= Header."Total to repay" then
            Error('Ce document a fait l''objet d''un remboursement complet !');
        if Header.Status = 1 then
            Error('Statut du document = %1, impossible de poursuivre !', Header.Status);
        ResSetup.Get;
        DateF := CalcDate(StrSubstNo('-%1J+FM', ResSetup."Applquer Le Prêt après"), Datecompta);
        MontantPrin := Header.Amount - Header."Principal Amount";
        Montantint := Header.CalcMntInetretEng1(Header."Date d'effet", Datecompta) - Header."Interest Amount";
        Clear(Ltype);
        Ltype.Get(Header."Document type");

        if Confirm('Etes vous sur de vouloir solder ce document ?\' +
                    'N° document : %1 au bénéfice de %2\' +
                    'Type : %3 - %4\' +
                    'Reste à rembourser : %5', false, Header."No.", Header.Employee + ' ' + Header.Name,
                    Header.Type, Header."Document type", ROUND(MontantPrin + Montantint, 0.001))
          then begin
            Lines.SetRange("No.", Header."No.");
            Lines.SetRange(Type, Header.Type);
            Lines.SetRange("Document type", Header."Document type");
            if Lines.Find('+') then
                ln := Lines."Entry No." + 10000
            else
                ln := 10000;
            Mnttot := (MontantPrin + Montantint);
            if Ltype."Imputation Comptable" = 0 then
                if not CreerEcrtTresorerie(Header, Datecompta, TypeCpt, NumCpt, NumDoc, Mnttot) then
                    Error('Verifier Réglement');
            ;

            Lines.Init;
            Lines."No." := Header."No.";
            Lines."Entry No." := ln;
            Lines.Employee := Header.Employee;
            Lines."Employee Posting Group" := Header."Employee Posting Group";
            Lines."Employee Statistic Group" := Header."Employee Statistic Group";
            Lines."Global dimension 1" := Header."Global dimension 1";
            Lines."Global dimension 2" := Header."Global dimension 2";
            Lines.Type := Header.Type;
            Lines."Document type" := Header."Document type";
            Lines."Line Amount" := MontantPrin + Montantint;
            Lines."Line %" := ROUND(MontantPrin / Header.Amount, 0.0001) * 100;
            Lines.Status := 0;
            Lines."Payment No." := 'SLD MANUEL';
            Lines."Date Paie" := DateP;
            //>>MBY 04/05/2009
            Lines."Date comptabilisation" := DateP;
            //<<MBY
            //  Message(format(Date2dmy(DateP, 2) - 1));
            Lines.Month := Date2dmy(DateP, 2) - 1;

            Lines.Year := Date2dmy(DateP, 3);

            Lines.Paid := true;
            Lines."Principal Amount" := MontantPrin;
            Lines."Interest Amount" := Montantint;
            Lines."User ID" := UserId;
            Lines."Last Date Modified" := Today;
            Lines."Type Compte" := TypeCpt;
            Lines."N° Compte" := NumCpt;
            Lines."N° Doc Extern" := NumDoc;
            Lines."Avance Repas" := Header."Avance Repas";
            if not Lines.Insert then
                Error('Insertion échouée, contactez votre administareur base de données !')
            else
                "Creer LigneEntry"(Lines);

        end;
    end;


    procedure SolderDepasser(var Header: Record "Loan & Advance Header"; var Datecompta: Date; TypeCpt: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset",Employee; NumCpt: Code[20]; NumDoc: Code[20]; DateP: Date)
    var
        Lines: Record "Loan & Advance Lines";
        ln: Integer;
        DateF: Date;
        ResSetup: Record "Human Resources Setup";
        MontantPrin: Decimal;
        Montantint: Decimal;
        Mnttot: Decimal;
        Ltype: Record "Loan & Advance Type";
    begin
        Header.CalcFields("Repaid amount", "Repaid %", "Principal Amount", "Interest Amount");
        if Header."Repaid amount" >= Header."Total to repay" then
            Error('Ce document a fait l''objet d''un remboursement complet !');
        if Header.Status = 1 then
            Error('Statut du document = %1, impossible de poursuivre !', Header.Status);
        ResSetup.Get;
        DateF := CalcDate(StrSubstNo('-%1J+FM', ResSetup."Applquer Le Prêt après"), Datecompta);
        MontantPrin := Header.CalcMnPrinciPeriodeeng(Header."Date d'effet", DateF) - Header."Principal Amount";
        Montantint := Header.CalcMntInetretEng1(Header."Date d'effet", DateF) - Header."Interest Amount";
        Clear(Ltype);
        Ltype.Get(Header."Document type");

        if Confirm('Etes vous sur de vouloir solder ce document ?\' +
                    'N° document : %1 au bénéfice de %2\' +
                    'Type : %3 - %4\' +
                    'Reste à rembourser : %5', false, Header."No.", Header.Employee + ' ' + Header.Name,
                    Header.Type, Header."Document type", ROUND(MontantPrin + Montantint, 0.001))
          then begin
            Lines.SetRange("No.", Header."No.");
            Lines.SetRange(Type, Header.Type);
            Lines.SetRange("Document type", Header."Document type");
            if Lines.Find('+') then
                ln := Lines."Entry No." + 10000
            else
                ln := 10000;
            Mnttot := (MontantPrin + Montantint);
            if Ltype."Imputation Comptable" = 0 then
                if not CreerEcrtTresorerie(Header, Datecompta, TypeCpt, NumCpt, NumDoc, Mnttot) then
                    Error('Verifier Réglement');
            ;
            Lines.Init;
            Lines."No." := Header."No.";
            Lines."Entry No." := ln;
            Lines.Employee := Header.Employee;
            Lines."Employee Posting Group" := Header."Employee Posting Group";
            Lines."Employee Statistic Group" := Header."Employee Statistic Group";
            Lines."Global dimension 1" := Header."Global dimension 1";
            Lines."Global dimension 2" := Header."Global dimension 2";
            //MBY 11/02/2010
            Lines.direction := Header.direction;
            Lines.service := Header.service;
            Lines.section := Header.section;
            //MBY 11/02/2010
            Lines.Type := Header.Type;
            Lines."Document type" := Header."Document type";
            Lines."Line Amount" := MontantPrin + Montantint;
            Lines."Line %" := 100 - Header."Repaid %";
            Lines.Status := 0;
            Lines."Payment No." := 'SLD MANUEL';
            Lines."Date Paie" := DateP;
            Lines.Month := Date2dmy(DateP, 2) - 1;


            Lines.Year := Date2dmy(DateP, 3);

            Lines.Paid := true;
            Lines."Principal Amount" := MontantPrin;
            Lines."Interest Amount" := Montantint;
            Lines."User ID" := UserId;
            Lines."Last Date Modified" := Today;
            Lines."Type Compte" := TypeCpt;
            Lines."N° Compte" := NumCpt;
            Lines."N° Doc Extern" := NumDoc;
            Lines."Avance Repas" := Header."Avance Repas";
            if not Lines.Insert then
                Error('Insertion échouée, contactez votre administareur base de données !')
            else
                "Creer LigneEntry"(Lines);

        end;
    end;


    procedure ReglerMnt(var Header: Record "Loan & Advance Header"; var Datecompta: Date; TypeCpt: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset",Employee; NumCpt: Code[20]; NumDoc: Code[20]; Mntreg: Decimal; DateP: Date)
    var
        Lines: Record "Loan & Advance Lines";
        ln: Integer;
        DateF: Date;
        ResSetup: Record "Human Resources Setup";
        MontantPrin: Decimal;
        Montantint: Decimal;
        Mnttot: Decimal;
        Ltype: Record "Loan & Advance Type";
    begin
        Header.CalcFields("Repaid amount", "Repaid %", "Principal Amount", "Interest Amount");
        if Header."Repaid amount" >= Header."Total to repay" then
            Error('Ce document a fait l''objet d''un remboursement complet !');
        if Header.Status = 1 then
            Error('Statut du document = %1, impossible de poursuivre !', Header.Status);
        ResSetup.Get;
        DateF := CalcDate(StrSubstNo('-%1J+FM', ResSetup."Applquer Le Prêt après"), Datecompta);
        Montantint := Header.CalcMntInetretEng1(Header."Date d'effet", DateF) - Header."Interest Amount";
        if (Header.Amount - Header."Principal Amount") >= (Mntreg - Montantint) then
            MontantPrin := (Mntreg - Montantint)
        else
            MontantPrin := (Header.Amount - Header."Principal Amount");
        Clear(Ltype);
        Ltype.Get(Header."Document type");
        if Confirm('Etes vous sur de vouloir solder ce document ?\' +
                    'N° document : %1 au bénéfice de %2\' +
                    'Type : %3 - %4\' +
                    'Reste à rembourser : %5', false, Header."No.", Header.Employee + ' ' + Header.Name,
                    Header.Type, Header."Document type", ROUND(MontantPrin + Montantint, 0.001))
          then begin
            Lines.SetRange("No.", Header."No.");
            Lines.SetRange(Type, Header.Type);
            Lines.SetRange("Document type", Header."Document type");
            if Lines.Find('+') then
                ln := Lines."Entry No." + 10000
            else
                ln := 10000;
            Mnttot := (MontantPrin + Montantint);
            if Ltype."Imputation Comptable" = 0 then
                if not CreerEcrtTresorerie(Header, Datecompta, TypeCpt, NumCpt, NumDoc, Mnttot) then
                    Error('Verifier Réglement');
            ;
            Lines.Init;
            Lines."No." := Header."No.";
            Lines."Entry No." := ln;
            Lines.Employee := Header.Employee;
            Lines."Employee Posting Group" := Header."Employee Posting Group";
            Lines."Employee Statistic Group" := Header."Employee Statistic Group";
            Lines."Global dimension 1" := Header."Global dimension 1";
            Lines."Global dimension 2" := Header."Global dimension 2";
            //MBY 11/02/2010
            Lines.direction := Header.direction;
            Lines.service := Header.service;
            Lines.section := Header.section;
            //MBY 11/02/2010

            Lines.Type := Header.Type;
            Lines."Document type" := Header."Document type";
            Lines."Line Amount" := MontantPrin + Montantint;
            Lines."Line %" := ROUND(MontantPrin / Header.Amount, 0.0001) * 100;
            Lines.Status := 0;
            Lines."Payment No." := 'SLD MANUEL';
            Lines.Paid := true;
            Lines."Date Paie" := DateP;
            Lines.Month := Date2dmy(DateP, 2) - 1;


            Lines.Year := Date2dmy(DateP, 3);
            Lines."Principal Amount" := MontantPrin;
            Lines."Interest Amount" := Montantint;
            Lines."User ID" := UserId;
            Lines."Last Date Modified" := Today;
            Lines."Type Compte" := TypeCpt;
            Lines."N° Compte" := NumCpt;
            Lines."N° Doc Extern" := NumDoc;
            Lines."Avance Repas" := Header."Avance Repas";

            if not Lines.Insert then
                Error('Insertion échouée, contactez votre administareur base de données !')
            else
                "Creer LigneEntry"(Lines);

        end;
    end;


    procedure CreerEcrtTresorerie(var Header: Record "Loan & Advance Header"; Datecompta: Date; TypeCpt: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset",Employee; NumCpt: Code[20]; NumDoc: Code[20]; Mnt: Decimal): Boolean
    var
        HumResSetup: Record "Human Resources Setup";
        LAType: Record "Loan & Advance Type";
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        errConfig: label 'General Journal Template empty in Human Resource Parameter.';
        errLATypeMissing: label 'Loan & Advance Type missing.';
        errWrongParam: label 'Account No. or Bal. Account No. empty in Loan & Advance type parameter.';
        success: label 'Document posting operation successfull.\Lines inserted on Journal : %1 - %2.';
        SuccesV: label 'Document Validé Avec Succées.';
        Line: Integer;
        BankAccount: Record "Bank Account";
    begin
        HumResSetup.Get();

        if not LAType.Get(Header."Document type")
          then
            Error(errLATypeMissing);
        if Mnt = 0 then
            Error('Verifier Montant !!!');
        if LAType."Imputation Comptable" = 1 then
            exit(true);

        if ((LAType."Account No." = '')
            or
            (LAType."Bal. Account No." = ''))
          then
            Error(errWrongParam);
        begin
            if (HumResSetup."General Journal Template" = '')
              then
                Error(errConfig);
            GenJournalLine.SetRange("Journal Template Name", HumResSetup."General Journal Template");
            GenJournalLine.SetRange("Journal Batch Name", HumResSetup."Gen. Journal Batch (L&A)");
            //GenJournalLine.SETRANGE ("Line No.",Line);
            GenJournalLine.SetRange("Document No.", Header."No.");
            GenJournalLine.DeleteAll;
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", HumResSetup."General Journal Template");
            GenJournalLine.SetRange("Journal Batch Name", HumResSetup."Gen. Journal Batch (L&A)");

            if GenJournalLine.Find('+') then
                Line := GenJournalLine."Line No." + 10000
            else
                Line := 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := HumResSetup."General Journal Template";
            GenJournalLine."Journal Batch Name" := HumResSetup."Gen. Journal Batch (L&A)";


            GenJournalLine.Validate("Line No.", Line);
            GenJournalLine.Validate("Posting Date", Datecompta);

            case LAType."Account Type" of
                0:
                    GenJournalLine.Validate("Account Type", 0);
                1:
                    begin
                        GenJournalLine.Validate("Account Type", 3);
                        if BankAccount.Get(LAType."Account No.") then
                            GenJournalLine.Validate("Currency Code", BankAccount."Currency Code");
                    end;
            end;
            GenJournalLine.Validate("Account No.", LAType."Account No.");
            GenJournalLine.Validate("Posting Date", Datecompta);
            GenJournalLine."Source Code" := LAType."Source Code";
            GenJournalLine.Validate("Document Type", 0);
            GenJournalLine.Validate("Document No.", Header."No.");
            GenJournalLine."External Document No." := NumDoc;
            GenJournalLine.Validate("Bal. Account Type", TypeCpt);
            GenJournalLine.Validate("Bal. Account No.", NumCpt);
            GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
            GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
            GenJournalLine."Source No." := Header.Employee;

            GenJournalLine.Validate("Credit Amount", Mnt);

            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Line", GenJournalLine);
            exit(true);
            //MESSAGE (SuccesV);
        end;
    end;


    procedure InsererLigne(var SalaryLine: Record "Salary Lines"; LoanAdvanceHeader: Record "Loan & Advance Header"; MntPrinc: Decimal; MntInt: Decimal)
    var
        LoanAdvanceLines: Record "Loan & Advance Lines";
        LALines: Record "Loan & Advance Lines";
        ExistLoanAdvanceLine: Record "Loan & Advance Lines";
        ln: Integer;
        Employee: Record Employee;
    begin
        LoanAdvanceLines.Reset;
        LoanAdvanceLines.SetRange("No.", LoanAdvanceHeader."No.");
        if LoanAdvanceLines.Find('+') then
            ln := LoanAdvanceLines."Entry No." + 10000
        else
            ln := 10000;

        Employee.Get(SalaryLine.Employee);

        LoanAdvanceLines.Reset;
        LoanAdvanceLines.Init;
        LoanAdvanceLines."No." := LoanAdvanceHeader."No.";
        LoanAdvanceLines."Entry No." := ln;
        LoanAdvanceLines.Employee := LoanAdvanceHeader.Employee;
        LoanAdvanceLines."Employee Posting Group" := Employee."Employee Posting Group";
        LoanAdvanceLines."Employee Statistic Group" := Employee."Statistics Group Code";
        LoanAdvanceLines."Global dimension 1" := Employee."Global Dimension 1 Code";
        LoanAdvanceLines."Global dimension 2" := Employee."Global Dimension 2 Code";
        //MBY 11/02/2010
        // LoanAdvanceLines.direction  := Employee.Direction;
        LoanAdvanceLines.service := Employee.Service;
        LoanAdvanceLines.section := Employee.Section;
        //MBY 11/02/2010

        LoanAdvanceLines.Type := LoanAdvanceHeader.Type;
        LoanAdvanceLines."Document type" := LoanAdvanceHeader."Document type";
        LoanAdvanceLines.Month := SalaryLine.Month;
        LoanAdvanceLines.Year := SalaryLine.Year;

        LoanAdvanceLines."Line Amount" := MntPrinc + MntInt;
        LoanAdvanceLines."Principal Amount" := MntPrinc;
        LoanAdvanceLines."Interest Amount" := MntInt;
        LoanAdvanceLines."Line %" := (LoanAdvanceLines."Line Amount" * 100) / LoanAdvanceHeader.
"Total to repay";
        LoanAdvanceLines.Status := 0;
        LoanAdvanceLines.Paid := false;
        LoanAdvanceLines."Payment No." := SalaryLine."No.";
        LoanAdvanceLines."User ID" := UserId;
        LoanAdvanceLines."Last Date Modified" := WorkDate;
        LoanAdvanceLines."Date Paie" := SalaryLine."Posting Date";
        LoanAdvanceLines."Avance Repas" := LoanAdvanceHeader."Avance Repas";

        if LoanAdvanceLines.Insert then;
    END;

    procedure calcSolde(Header: Record "Loan & Advance Header"; var SalaryLineTmp: Record "Salary Lines") Verif: Boolean
    var
        Lines: Record "Loan & Advance Lines";
        Mnt: Decimal;
    begin
        with Header do begin
            Verif := true;
            Mnt := 0;
            Lines.Reset;
            Lines.SetCurrentkey("No.", Employee, Paid);
            Lines.SetFilter("No.", "No.");
            Lines.SetFilter(Employee, Employee);
            Lines.SetRange(Paid, true);
            Lines.CalcSums("Principal Amount", "Line Amount");
            Mnt := Lines."Principal Amount";
            if ROUND(Amount - Mnt, 0.1) = 0 then
                Verif := false
            else begin
                Lines.SetRange(Year, SalaryLineTmp.Year);
                Lines.SetRange(Month, SalaryLineTmp.Month);
                Lines.SetFilter("Payment No.", '<>SLD MANUEL');
                Lines.SetFilter("Line Amount", '<>0');
                // IF Lines.FIND('-') THEN
                //    Verif:=FALSE;
            end;

        end;
    end;


    procedure "Creer LigneEntry"(LoanAdvanceLine: Record "Loan & Advance Lines")
    var
        LoanAdvanceEntry: Record "Loan & Advance Entry";
        nbr: Integer;
        LoanAdvanceHeader: Record "Loan & Advance Header";
    begin
        LoanAdvanceEntry.SetRange("No.", LoanAdvanceLine."No.");
        LoanAdvanceEntry.Ascending(true);
        if LoanAdvanceEntry.Find('+') then
            nbr := LoanAdvanceEntry."Entry No." + 1
        else
            nbr := 1;

        LoanAdvanceEntry.Init;
        LoanAdvanceEntry."No." := LoanAdvanceLine."No.";
        LoanAdvanceEntry."Entry No." := nbr;
        LoanAdvanceEntry.Employee := LoanAdvanceLine.Employee;
        if LoanAdvanceHeader.Get(LoanAdvanceLine."No.") then
            LoanAdvanceEntry.Name := LoanAdvanceHeader.Name;
        LoanAdvanceEntry."Employee Posting Group" := LoanAdvanceLine."Employee Posting Group";
        LoanAdvanceEntry."Employee Statistic Group" := LoanAdvanceLine."Employee Statistic Group";
        // RK
        LoanAdvanceEntry."Global dimension 1" := LoanAdvanceLine."Global dimension 1";
        LoanAdvanceEntry."Global dimension 2" := LoanAdvanceLine."Global dimension 2";
        // RK
        //MBY 11/02/2010
        LoanAdvanceEntry.direction := LoanAdvanceLine.direction;
        LoanAdvanceEntry.service := LoanAdvanceLine.service;
        LoanAdvanceEntry.section := LoanAdvanceLine.section;
        //MBY 11/02/2010

        LoanAdvanceEntry.Month := LoanAdvanceLine.Month;
        LoanAdvanceEntry.Year := LoanAdvanceLine.Year;
        LoanAdvanceEntry."Date Paie" := LoanAdvanceLine."Date Paie";
        LoanAdvanceEntry."Payment No." := LoanAdvanceLine."Payment No.";
        LoanAdvanceEntry.Type := LoanAdvanceLine.Type;
        LoanAdvanceEntry."Document type" := LoanAdvanceLine."Document type";
        LoanAdvanceEntry."Entry type" := 1;
        LoanAdvanceEntry.Amount := -LoanAdvanceLine."Line Amount";
        LoanAdvanceEntry.Status := LoanAdvanceLine.Status;
        LoanAdvanceEntry."User ID" := UserId;
        LoanAdvanceEntry."Last Date Modified" := WorkDate;
        LoanAdvanceEntry."Avance Repas" := LoanAdvanceLine."Avance Repas";

        LoanAdvanceEntry.Insert;

        if LoanAdvanceHeader.Get(LoanAdvanceLine."No.") then
            CloturerDocument(LoanAdvanceHeader);
    end;


    procedure AnEcrComptaPaiement(LoanAdvanceeng: Record "Loan & Advance Header")
    var
        HumResSetup: Record "Human Resources Setup";
        errConfig: label 'General Journal Template empty in Human Resource Parameter.';
        LAType: Record "Loan & Advance Type";
        errLATypeMissing: label 'Loan & Advance Type missing.';
        errWrongParam: label 'Account No. or Bal. Account No. empty in Loan & Advance type parameter.';
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        success: label 'Document posting operation successfull.\Lines inserted on Journal : %1 - %2.';
        Line: Integer;
        BankAccount: Record "Bank Account";
        CourtT: Decimal;
        LongT: Decimal;
        SuccesV: label 'Document Validé Avec Succées.';
        LoanAdvance: Record "Loan & Advance";
    begin
        HumResSetup.Get();

        if not LAType.Get(LoanAdvanceeng."Document type")
          then
            Error(errLATypeMissing);

        if ((LAType."Account No." = '')
            or
            (LAType."Bal. Account No." = ''))
          then
            Error(errWrongParam);

        if (HumResSetup."General Journal Template" = '') then
            Error(errConfig);

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", HumResSetup."General Journal Template");
        GenJournalLine.SetRange("Journal Batch Name", HumResSetup."Gen. Journal Batch (L&A)");
        //GenJournalLine.SETRANGE ("Line No.",Line);
        GenJournalLine.SetRange("Document No.", LoanAdvanceeng."No.");
        GenJournalLine.DeleteAll;
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", HumResSetup."General Journal Template");
        GenJournalLine.SetRange("Journal Batch Name", HumResSetup."Gen. Journal Batch (L&A)");

        if GenJournalLine.Find('+') then
            Line := GenJournalLine."Line No." + 10000
        else
            Line := 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := HumResSetup."General Journal Template";
        GenJournalLine."Journal Batch Name" := HumResSetup."Gen. Journal Batch (L&A)";

        GenJournalLine.Validate("Line No.", Line);
        GenJournalLine.Validate("Posting Date", LoanAdvanceeng."Date Comptabilisation");

        case LAType."Account Type" of
            0:
                GenJournalLine.Validate("Account Type", 0);
            1:
                begin
                    GenJournalLine.Validate("Account Type", 3);
                    if BankAccount.Get(LAType."Bal. Account No.") then
                        GenJournalLine.Validate("Currency Code", BankAccount."Currency Code");
                end;
        end;
        GenJournalLine.Validate("Account No.", LAType."Account No.");
        GenJournalLine.Validate("Posting Date", LoanAdvanceeng."Date Comptabilisation");
        GenJournalLine."Source Code" := LAType."Source Code";
        GenJournalLine.Validate("Document Type", 0);
        GenJournalLine.Validate("Document No.", LoanAdvanceeng."No.");
        case LAType."Bal. Account Type" of
            0:
                begin
                    GenJournalLine.Validate("Bal. Account Type", 0);
                    GenJournalLine.Validate("Currency Code", '');
                end;
            1:
                begin
                    GenJournalLine.Validate("Bal. Account Type", 3);
                    if BankAccount.Get(LAType."Bal. Account No.") then
                        GenJournalLine.Validate("Currency Code", BankAccount."Currency Code");
                end;
        end;
        GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
        GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
        GenJournalLine."Source No." := LoanAdvanceeng.Employee;
        GenJournalLine."External Document No." := LoanAdvanceeng."N° document Extr.";
        if LoanAdvanceeng.Type = 0 then begin
            GenJournalLine.Validate("Bal. Account No.", LoanAdvanceeng."Bal. Account No.");
            GenJournalLine.Validate("Credit Amount", LoanAdvanceeng.Amount);  // Credit
            GenJournalLine.Description := 'Annulation Avance ' + LoanAdvanceeng."No.";
            GenJournalLine.Insert;
        end else begin
            //MBY 03/03/2010
            //LoanAdvanceeng.CalcPrêtLongetCourtTerme(CourtT,LongT);
            CourtT := LoanAdvanceeng.Amount;
            LongT := LoanAdvanceeng."Total to repay" - LoanAdvanceeng.Amount;
            //MBY 03/03/2010
            GenJournalLine.Validate("Posting Date", LoanAdvanceeng."Date Comptabilisation");

            if CourtT <> 0 then begin
                case LAType."Account Type" of
                    0:
                        begin
                            GenJournalLine.Validate("Account Type", 0);
                            GenJournalLine.Validate("Account No.", LAType."Account No.");
                            GenJournalLine.Validate("Currency Code", '');
                        end;
                    1:
                        begin
                            GenJournalLine.Validate("Account Type", 3);
                            GenJournalLine.Validate("Account No.", LAType."Account No.");
                            if BankAccount.Get(LAType."Account No.") then
                                GenJournalLine.Validate("Currency Code", BankAccount."Currency Code");
                        end;
                end;
                GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
                GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
                GenJournalLine."Source No." := LoanAdvanceeng.Employee;
                //MBY 03/03/2010
                //GenJournalLine.VALIDATE("Bal. Account Type",3);
                //GenJournalLine.VALIDATE("Bal. Account No." ,LoanAdvanceeng."Bal. Account No.");
                //MBY 03/03/2010
                GenJournalLine.Validate("Credit Amount", CourtT);  // Credit
                GenJournalLine.Description := 'Annulation Avance ' + LoanAdvanceeng."No.";

                GenJournalLine.Insert;
            end;
            //
            if LongT <> 0 then begin
                Line := Line + 10000;
                GenJournalLine."Line No." := Line;
                GenJournalLine.Validate("Posting Date", LoanAdvanceeng."Date Comptabilisation");

                case LAType."Account Type Long Terme" of
                    0:
                        begin
                            GenJournalLine.Validate("Account Type", 0);
                            GenJournalLine.Validate("Account No.", LAType."Account No. Lng Termeo");
                            GenJournalLine.Validate("Currency Code", '');
                        end;
                    1:
                        begin
                            GenJournalLine.Validate("Account Type", 3);
                            GenJournalLine.Validate("Account No.", LAType."Account No. Lng Termeo");

                            if BankAccount.Get(LAType."Account No. Lng Termeo") then
                                GenJournalLine.Validate("Currency Code", BankAccount."Currency Code");
                        end;
                end;
                GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
                GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
                GenJournalLine."External Document No." := LoanAdvanceeng."N° document Extr.";

                GenJournalLine."Source No." := LoanAdvanceeng.Employee;
                GenJournalLine.Validate("Debit Amount", LongT);  // debit
                GenJournalLine.Description := 'Annulation Avance ' + LoanAdvanceeng."No.";

                GenJournalLine.Insert;
            end;
            //
            Line := Line + 10000;
            GenJournalLine."Line No." := Line;
            case LoanAdvanceeng."Bal. Account Type" of
                0:
                    begin
                        GenJournalLine.Validate("Bal. Account Type", 0);
                        GenJournalLine.Validate("Account No.", LoanAdvanceeng."Bal. Account No.");
                        GenJournalLine.Validate("Currency Code", '');
                    end;
                1:
                    begin
                        GenJournalLine.Validate("Account Type", 3);
                        GenJournalLine.Validate("Account No.", LoanAdvanceeng."Bal. Account No.");

                        if BankAccount.Get(LoanAdvanceeng."Bal. Account No.") then
                            GenJournalLine.Validate("Currency Code", BankAccount."Currency Code");
                    end;
            end;
            GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
            GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
            GenJournalLine."Source No." := LoanAdvanceeng.Employee;
            GenJournalLine."External Document No." := LoanAdvanceeng."N° document Extr.";
            GenJournalLine.Validate("Debit Amount", LoanAdvanceeng.Amount);
            GenJournalLine.Description := 'Annulation Avance ' + LoanAdvanceeng."No.";

            GenJournalLine.Insert;

            //-------------------------------MBY 03/03/2010
            if LongT <> 0 then begin
                Line := Line + 10000;
                GenJournalLine."Line No." := Line;
                GenJournalLine.Validate("Posting Date", LoanAdvanceeng."Date Comptabilisation");

                case LAType."Account Type" of
                    0:
                        begin
                            GenJournalLine.Validate("Account Type", 0);
                            GenJournalLine.Validate("Account No.", LAType."Account No.");
                            GenJournalLine.Validate("Currency Code", '');
                        end;
                    1:
                        begin
                            GenJournalLine.Validate("Account Type", 3);
                            GenJournalLine.Validate("Account No.", LAType."Account No.");
                            if BankAccount.Get(LAType."Account No.") then
                                GenJournalLine.Validate("Currency Code", BankAccount."Currency Code");
                        end;
                end;
                GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
                GenJournalLine."Source Type" := GenJournalLine."source type"::"IC Partner";
                GenJournalLine."Source No." := LoanAdvanceeng.Employee;
                GenJournalLine."External Document No." := LoanAdvanceeng."N° document Extr.";
                //MBY 03/03/2010
                //GenJournalLine.VALIDATE ("Credit Amount",LoanAdvance.Amount);
                GenJournalLine.Validate("Credit Amount", LongT);
                //MBY 03/03/2010

                GenJournalLine.Insert;
            end;
            //-------------------------------MBY 03/03/2010

        end;
        /*MBY 03/03/2010
            GenJournalLine.SETRANGE ("Journal Template Name",HumResSetup."General Journal Template");
            GenJournalLine.SETRANGE ("Journal Batch Name",HumResSetup."Gen. Journal Batch (L&A)");
            //GenJournalLine.SETRANGE ("Line No.",Line);
            GenJournalLine.SETRANGE  ("Document No.",LoanAdvanceeng."No.");
            IF GenJournalLine.FIND ('-') THEN
              CODEUNIT.RUN(13,GenJournalLine);
            //MESSAGE (SuccesV);
         MBY 03/03/2010*/

    end;


    procedure AnnEnregDocument(LoanAdvanceHeader: Record "Loan & Advance Header")
    var
        errMC: label 'Validation impossible.\Some important parameter aren''t mentionned.';
        LoanAdvanceEntry: Record "Loan & Advance Entry";
        LoanAdvance: Record "Loan & Advance";
        LAType: Record "Loan & Advance Type";
    begin
        //IF NOT TestValiditeDocument (LoanAdvanceHeader) THEN
        /// ERROR (errMC);
        LoanAdvanceHeader.CalcFields("Principal Amount");
        if LoanAdvanceHeader."Principal Amount" <> 0 then
            Error('Vous ne pouvez Pas Annuler Avance !!!');
        LAType.Get(LoanAdvanceHeader."Document type");
        if LAType."Imputation Comptable" = 0 then
            AnEcrComptaPaiement(LoanAdvanceHeader);
        if ((LoanAdvanceHeader."Repayment slices" <> 0)
            and
            (LoanAdvanceHeader."Total to repay" <> 0)
           ) then begin
            LoanAdvance.Reset;
            LoanAdvance.Init;
            LoanAdvance.TransferFields(LoanAdvance);
            LoanAdvance."No." := LoanAdvanceHeader."No.";
            LoanAdvance.Employee := LoanAdvanceHeader.Employee;
            LoanAdvance.Name := LoanAdvanceHeader.Name;
            LoanAdvance."Job Title" := LoanAdvanceHeader."Job Title";
            LoanAdvance."Employee Posting Group" := LoanAdvanceHeader."Employee Posting Group";
            LoanAdvance."Employee Statistic Group" := LoanAdvanceHeader."Employee Statistic Group";
            // RK
            LoanAdvance."Global dimension 1" := LoanAdvanceHeader."Global dimension 1";
            LoanAdvance."Global dimension 2" := LoanAdvanceHeader."Global dimension 2";
            // RK

            //MBY 11/02/2010
            LoanAdvance.direction := LoanAdvanceHeader.direction;
            LoanAdvance.service := LoanAdvanceHeader.service;
            LoanAdvance.section := LoanAdvanceHeader.section;
            //MBY 11/02/2010

            LoanAdvance.Type := LoanAdvanceHeader.Type;
            LoanAdvance."Document type" := LoanAdvanceHeader."Document type";
            LoanAdvance.Amount := LoanAdvanceHeader.Amount;
            LoanAdvance."Interest %" := LoanAdvanceHeader."Interest %";
            LoanAdvance."Total to repay" := LoanAdvanceHeader."Total to repay";
            LoanAdvance."N° document Extr." := LoanAdvanceHeader."N° document Extr.";
            LoanAdvance."Montant tranche" := LoanAdvanceHeader."Montant tranche";

            //MBY 03/03/2010
            LoanAdvance."Date d'effet" := LoanAdvanceHeader."Date d'effet";
            //LoanAdvance."Date Deblocage"           := LoanAdvanceHeader."Date Deblocage";
            LoanAdvance."Date Comptabilisation" := LoanAdvanceHeader."Date Comptabilisation";
            LoanAdvance."Date fin Prêt" := LoanAdvanceHeader."Date fin Prêt";
            //MBY 03/03/2010
            LoanAdvance."Avance Sur Prime" := LoanAdvanceHeader."Avance Sur Prime";
            LoanAdvance."Avance sur congé" := LoanAdvanceHeader."Avance sur congé";
            LoanAdvance."Repayment slices" := LoanAdvanceHeader."Repayment slices";
            LoanAdvance."No. Series" := LoanAdvanceHeader."No. Series";

            LoanAdvance."User ID" := UserId;
            LoanAdvance."Last Date Modified" := LoanAdvanceHeader."Last Date Modified";
            LoanAdvance."Precision Arrondi Principale" := LoanAdvanceHeader."Precision Arrondi Principale";
            LoanAdvance."affectation Diff Arrondi" := LoanAdvanceHeader."affectation Diff Arrondi";
            LoanAdvance."Avance Repas" := LoanAdvanceHeader."Avance Repas";

            if LoanAdvance.Insert then begin
                LoanAdvanceEntry.Reset;
                LoanAdvanceEntry.SetCurrentkey("No.", Employee, "Entry No.");
                LoanAdvanceEntry.SetFilter("No.", LoanAdvanceHeader."No.");
                LoanAdvanceEntry.SetFilter(Employee, LoanAdvanceHeader.Employee);
                LoanAdvanceEntry.DeleteAll;

                if LoanAdvanceHeader.Delete then
                    Message('Annulation Réussite');
                ;
            end
            else
                Error(errValidate);
        end
    end;
}

