codeunit 39001402 "Management of salary"
{

    trigger OnRun()
    begin
    end;

    var
        f: Dialog;
        i: Integer;
        l: Integer;
        temp: Integer;
        win: Label 'Creating new lines';
        "t-date": Record 2000000007;
        SH: Record "Salary Headers";
        found: Boolean;
        ParamCpta: Record 98;
        Ins: Boolean;
        Carr: Record "Carière Enreg";
        EntPaie: Record "Rec. Salary Headers";
        NoteNet: Decimal;
        Temp1: Integer;
        Bnk: Record "Employee Bank Account";
        T2: Record "Loan & Advance Header";
        DateJ: Date;
        CoefGratif: Record "Coef Gratification";
        NoteM: Decimal;
        SalaireBrut: Decimal;
        mm: Boolean;
        Tchange: Record 330;
        NbreM: Decimal;
        calPR: Boolean;
        EMP: Record 5200;
        M: Integer;
        A: Integer;
        DatePaie: Date;
        EmployeeAbsence2: Record "Employee's days off Entry";
        SalaryHeaders: Record "Salary Headers";
        Regimesofwork: Record "Regimes of work";
        TotAbs: Decimal;
        TotHeuresEnreg: Decimal;
        Heuresoccaenregm: Record "Heures occa. enreg. m";
        DiffHours: Decimal;
        AbsenceEnreg1: Record "Employee's days off Entry";
        AbsenceEnreg: Record "Employee's days off Entry";
        Linegrid: Record "Line grid";
        GNbJour: Decimal;
        GNbHeure: Decimal;
        GRecNote: Record "Ligne Pointage Salarié Chanti";
        RecGhumainressource: Record 5218;
        RecGIndemnity: Record "Indemnity";
        DecGDefaultPanier: Decimal;
        TotJoursEnreg: Decimal;
        DecNBHeureEncouragement: Decimal;
        DecMntHoraire: Decimal;
        DecVar: Decimal;
        SBTEST: Decimal;
        RecEmpDayOFF: Record "Employee's days off Entry";
        DEDUCIMPOT: Decimal;
        HSSSS: Decimal;
        DecIMPARRONDI: Decimal;
        MntAssVie: Decimal;
        RecAssVie: Record "Parametrage Image";
        "//DSFT AGA 16/03/2010": Integer;
        "RecGRec. Salary Lines": Record "Rec. Salary Lines";
        DecGTotSalaireBrut: Decimal;
        "IntNBMoisEnregistré": Integer;
        RecSalaireEnregistre: Record "Rec. Salary Lines";
        TotalNbrJourPanier: Decimal;
        PlafondBrutPourCotisSocial: Integer;
        HumanResourcesSetup: Record 5218;
        DefaultIndemnities: Record "Default Indemnities";
        PlafonfSBase8Pct: Decimal;
        Indemnities: Record "Indemnities";
        BonnePlage: Boolean;
        Plage1: Integer;
        Plage2: Integer;
        SalaireNetSTC: Decimal;
        CotisAvec8Pct: Decimal;
        SalaireBasePlusSursalaire: Decimal;
        RecHumanResourcesSetup: Record 5218;
        RecEmployee2: Record 5200;


    procedure "CréerEnTeteSalaire"(SalaryHeader: Record "Salary Headers")
    var
        Employee: Record 5200;
        f: Dialog;
        MgmtLoansAdvances: Codeunit "Mgmt. of Loans and Advances";
        SalaryLine: Record "Salary Lines";
    begin
        f.OPEN('Salarié : #1############################################');
        IF Employee.FIND('-') THEN
            REPEAT
                IF CréerLigneSalaire(SalaryHeader, Employee, 1) THEN
                    f.UPDATE(1, Employee."No." + ' - ' + Employee."First Name" + ' ' + Employee."Last Name" + 'Inséré')
                ELSE
                    f.UPDATE(1, Employee."No." + ' - ' + Employee."First Name" + ' ' + Employee."Last Name" + 'Pas Inséré');
            UNTIL Employee.NEXT = 0;
        f.CLOSE;
    end;


    procedure "CréerLigneSalaire"(SalaryHeader: Record "Salary Headers"; Employee: Record 5200; Sim: Option Simulation,Real) OK: Boolean
    var
        SalaryLine: Record "Salary Lines";
        EmploymentContract: Record 5211;
        err1: Label 'Regime of work empty on Employment contract : %1';
        err2: Label 'Employment contract empty for the employee : %1';
        DefaultSocContribution: Record "Default Soc. Contribution";
        SocialContributions: Record "Social Contributions";
        SocialContribution: Record "Social Contribution";
        DefaultIndemnities: Record "Default Indemnities";
        Indemnities: Record "Indemnities";
        confMess: Label 'Replace the existing line ?';
        creator: Label 'Line created by :';
        nbr: Integer;
        ParamRessHum: Record 5218;
        dateD: Date;
        SB: Decimal;
        DateF: Date;
        NBJ: Decimal;
        DefaultIndemnitiesTmp: Record "Default Indemnities";
        MntInd: Decimal;
        PrimeType: Record "Prime1";
        err3: Label 'Code tranche d''imposition vide sur Contrat de travail : %1';
        Defaultindem: Record "Default Indemnities";
        RecEmployeeAbsence: Record "Employee's days off Entry";
        regimeofwork: Record "Regimes of work";
        RecHeureSupplEnreg: Record "Heures sup. eregistrées m";
        LoanAD: Record "Loan & Advance Header";
    begin
        SalaryLine.RESET;
        Employee.MAJDeductions;
        ParamCpta.GET;
        ParamRessHum.GET();
        IF EmploymentContract.GET(Employee."Emplymt. Contract Code") THEN;
        IF regimeofwork.GET(EmploymentContract."Regimes of work") THEN;
        SalaryLine.SETRANGE("No.", SalaryHeader."No.");
        SalaryLine.SETRANGE(Employee, Employee."No.");
        IF SalaryLine.FIND('-') THEN BEGIN
            // IF CONFIRM (confMess + '\%1\' + creator + ' %2 %3',FALSE
            //                                                    ,Employee."No." + ' : ' + Employee.FullName()
            //                                                  ,SalaryLine."User ID"
            //                                                ,SalaryLine."Last Date Modified")
            //THEN
            DeleteLine(SalaryLine)
            //ELSE
            // EXIT (FALSE);
        END;
        SalaryLine.INIT;
        ParamRessHum.GET();
        SalaryLine."No." := SalaryHeader."No.";
        SalaryLine.Employee := Employee."No.";
        SalaryLine."Salaire Net Contrat" := Employee."Salaire Net Contrat";
        SalaryLine."Num Mobile Money" := Employee."Num Mobile Money";
        SalaryLine.Name := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
        SalaryLine."Employee Posting Group" := Employee."Employee Posting Group";
        SalaryLine."Statistics Group Code" := Employee."Statistics Group Code";
        //HS
        SalaryLine.Fonction := Employee.Fonction;
        SalaryLine."Statistics Group Code" := Employee."Statistics Group Code";
        SalaryLine."Statistic Gpe Descrip" := Employee."Statistic Gpe Descrip";
        SalaryLine.Service := Employee.Service;
        SalaryLine."Description Service" := Employee."Description Service";
        //HS
        SalaryLine."Global Dimension 1" := Employee."Global Dimension 1 Code";
        SalaryLine."Global Dimension 2" := Employee."Global Dimension 2 Code";
        SalaryLine."Posting Date" := SalaryHeader."Posting Date";
        SalaryLine."Nombre De Charge" := Employee."Nombre de Charge";
        SalaryLine.Departement := Employee."Statistics Group Code";
        SalaryLine.Service := Employee.Service;
        SalaryLine."Date Entree" := Employee."Employment Date";
        IF Employee."Emplymt. Contract Code" <> '' THEN BEGIN
            EmploymentContract.GET(Employee."Emplymt. Contract Code");
            SalaryLine."Emplymt. Contract Code" := Employee."Emplymt. Contract Code";
            IF EmploymentContract."Regimes of work" <> '' THEN
                SalaryLine."Employee Regime of work" := EmploymentContract."Regimes of work"
            ELSE
                ERROR(err1, EmploymentContract.Code + ' - ' + EmploymentContract.Description);
        END
        ELSE
            ERROR(err2, Employee."No." + ' - ' + Employee."First Name" + ' ' + Employee."Last Name");
        CLEAR(Bnk);
        Bnk.RESET;
        // IF Employee."Default Bank Account Code"<>'' THEN
        Bnk.SETRANGE("Employee No.", Employee."No.");
        IF Bnk.FINDFIRST THEN SalaryLine."Num Compte" := Bnk.Banque;

        SalaryLine.Description := SalaryHeader.Description;
        SalaryLine.Month := SalaryHeader.Month;
        SalaryLine.Year := SalaryHeader.Year;
        CASE DATE2DMY(SalaryHeader."Posting Date", 2) OF
            1, 2, 3:
                SalaryLine.Trimestre := 1;
            4, 5, 6:
                SalaryLine.Trimestre := 2;
            7, 8, 9:
                SalaryLine.Trimestre := 3;
            10, 11, 12:
                SalaryLine.Trimestre := 4;
        END;
        SalaryLine."Bank Account Code" := Employee."Default Bank Account Code";
        SalaryLine."Employee's type" := Employee."Employee's type";
        SalaryLine."Compte Bancaire Societe" := Employee."Compte Bancaire Societe";
        SalaryLine."Adjustment of absences" := 0;
        SalaryLine."Assiduity (Paid days)" := 0;
        SalaryLine."Assiduity (Worked days)" := 0;
        SalaryLine.Note := 0;
        SalaryLine.Pourcentage := 0;
        SalaryLine.Charge := Employee.Charge;
        //mby 10/02/2010
        SalaryLine.Service := Employee.Service;
        SalaryLine.Section := Employee.Section;
        //mby 10/02/2010
        SalaryLine."Amount Days Off balacement" := 0;
        SalaryLine.congé := 0;
        SalaryLine."Assiduity (days off balacement" := 0;
        SalaryLine."Mois travaillés" := EmploymentContract."Regular payments";
        SalaryLine."Statistics Group Code" := Employee."Statistics Group Code";
        SalaryLine."Employee's Type Contrat" := Employee."Employee's Type Contrat";
        SalaryLine."Num CNSS" := Employee."Union Code";
        SalaryLine."Num CIN" := Employee."N° Pièce D'identité";
        SalaryLine."Code Mode Réglement" := Employee."Mode de règlement";
        //>> DSFT AGA 07/04/2010
        SalaryLine."Code grille de salaire" := EmploymentContract."Salary grid";
        SalaryLine.Catégorie := Employee.Catégorie;
        SalaryLine.Echellon := Employee.Echelons;
        SalaryLine."salaire de base grille" := Employee."Basis salary";
        SalaryLine.Quinzaine := SalaryHeader.Quinzaine;
        SalaryLine.Imposable := EmploymentContract.Taxable;
        //<< DSFT AGA DEV CAISSE FOND SOCIAL
        IF Employee."Caisse fond social" THEN
            SalaryLine."Montant retenu caisse FS" := ParamRessHum."Montant retenu caisse FS";

        //>> DSFT AGA DEV CAISSE FOND SOCIAL
        //<< DSFT AGA 07/04/2010

        //>>DSFT-AGA 15/08/2010
        LoanAD.RESET;
        LoanAD.SETFILTER(Employee, SalaryLine.Employee);
        LoanAD.SETRANGE(Type, LoanAD.Type::Loan);
        LoanAD.SETRANGE(Status, LoanAD.Status::"In progress");
        LoanAD.SETRANGE("Not include", TRUE);
        LoanAD.SETRANGE("Avance Sur Prime", FALSE);
        LoanAD.SETRANGE("Avance Repas", FALSE);
        IF LoanAD.FIND('-') THEN
            IF CONFIRM('Voulez Vous inclure  Le prêt du salarier'
               + ' ' + FORMAT(SalaryLine.Employee) + ' '
               + SalaryLine.Name + ' pour le mois de ' + FORMAT(SalaryLine.Month), TRUE, FALSE) THEN BEGIN
                LoanAD."Not include" := FALSE;
                LoanAD.MODIFY;
            END;
        //>>DSFT-AGA 15/08/2010
        //>> DSFT AGA 150410
        RecEmployeeAbsence.SETCURRENTKEY("Line type", "Employee No.", "Posting month", "Posting year", Quinzaine, "Motif D'absence");
        RecEmployeeAbsence.SETFILTER("Line type", '%1', 10);
        RecEmployeeAbsence.SETFILTER("Employee No.", '%1', SalaryLine.Employee);
        RecEmployeeAbsence.SETFILTER("Posting month", '%1', SalaryLine.Month);
        RecEmployeeAbsence.SETFILTER("Posting year", '%1', SalaryLine.Year);
        IF ParamRessHum."Activer régime quinzaine" THEN
            IF regimeofwork."type calcul paie" = regimeofwork."type calcul paie"::Quinzaine THEN
                RecEmployeeAbsence.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);
        RecEmployeeAbsence.CALCSUMS(RecEmployeeAbsence."Quantity (Days)");
        SalaryLine."Jours Fériés" := RecEmployeeAbsence."Quantity (Days)";

        RecEmployeeAbsence.RESET;
        RecEmployeeAbsence.SETCURRENTKEY("Line type", "Employee No.", "Posting month", "Posting year", Quinzaine, "Motif D'absence");
        RecEmployeeAbsence.SETFILTER("Line type", '%1', 11);
        RecEmployeeAbsence.SETFILTER("Employee No.", '%1', SalaryLine.Employee);
        RecEmployeeAbsence.SETFILTER("Posting month", '%1', SalaryLine.Month);
        RecEmployeeAbsence.SETFILTER("Posting year", '%1', SalaryLine.Year);
        IF ParamRessHum."Activer régime quinzaine" THEN
            IF regimeofwork."type calcul paie" = regimeofwork."type calcul paie"::Quinzaine THEN
                RecEmployeeAbsence.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);
        RecEmployeeAbsence.CALCSUMS(RecEmployeeAbsence."Quantity (Days)");
        SalaryLine."Jours Fériés travaillés" := RecEmployeeAbsence."Quantity (Days)";

        RecHeureSupplEnreg.RESET;
        RecHeureSupplEnreg.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement", Quinzaine);
        RecHeureSupplEnreg.SETFILTER("N° Salarié", '%1', SalaryLine.Employee);
        RecHeureSupplEnreg.SETFILTER("Mois de paiement", '%1', SalaryLine.Month);
        RecHeureSupplEnreg.SETFILTER("Année de paiement", '%1', SalaryLine.Year);
        IF ParamRessHum."Activer régime quinzaine" THEN
            IF regimeofwork."type calcul paie" = regimeofwork."type calcul paie"::Quinzaine THEN
                RecHeureSupplEnreg.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);
        RecHeureSupplEnreg.CALCSUMS(RecHeureSupplEnreg."Nombre d'heures");
        SalaryLine."Nombre d'heures suppl." := RecHeureSupplEnreg."Nombre d'heures";


        //<< DSFT AGA 150410

        //MBY 20/01/2009
        SalaryLine."Report en -" := Employee."Report Employee en -";
        //END MBY 20/01/2009
        Bnk.RESET;
        //Bnk.SETRANGE(Code,Employee."No.");
        Bnk.SETRANGE(Code, Employee."Default Bank Account Code");

        IF Bnk.FIND('-') THEN BEGIN
            SalaryLine."Bank Account Code" := Bnk.Code;
            SalaryLine."Banque Salarie" := Bnk.Banque;
            SalaryLine."RIB Salarié" := Bnk."Bank Branch No." + Bnk."Agency Code" + Bnk."Bank Account No." + FORMAT(Bnk."RIB Key");
        END;


        Carr.RESET;
        Carr.SETCURRENTKEY(employee, "Date Décesion");
        ;
        SB := 0;
        NBJ := 0;

        MntInd := 0;
        IF SalaryLine."Posting Date" = 0D THEN
            SalaryLine."Posting Date" := WORKDATE;
        IF Employee."Currency Code" <> '' THEN BEGIN
            DefaultIndemnitiesTmp.RESET;
            DefaultIndemnitiesTmp.SETFILTER("Employment Contract Code", Employee."Emplymt. Contract Code");
            DefaultIndemnitiesTmp.SETRANGE("Evaluation mode", 1, 2);
            DefaultIndemnitiesTmp.SETRANGE("Type Indemnité", 0);
            IF DefaultIndemnitiesTmp.FIND('-') THEN
                REPEAT
                    MntInd := MntInd + DefaultIndemnitiesTmp."Default amount";
                UNTIL DefaultIndemnitiesTmp.NEXT = 0;
        END;

        TotAbs := 0;
        TotHeuresEnreg := 0;
        M := 0;
        A := 0;
        DiffHours := 0;
        Regimesofwork.RESET;
        Regimesofwork.FIND('-');
        IF (Employee.Status = Employee.Status::Active) AND
           (Employee."Employee's type" = Employee."Employee's type"::"Month based") THEN BEGIN
            EmployeeAbsence2.RESET;
            EmployeeAbsence2.SETFILTER("Posting month", '%1', SalaryHeader.Month);
            EmployeeAbsence2.SETFILTER("Posting year", '%1', SalaryHeader.Year);
            EmployeeAbsence2.SETFILTER("Employee No.", Employee."No.");
            EmployeeAbsence2.SETFILTER("Line type", '%1', EmployeeAbsence2."Line type"::"Deductible of salary");
            IF EmployeeAbsence2.FIND('-') THEN
                REPEAT
                    TotAbs := TotAbs + EmployeeAbsence2.Quantity;
                UNTIL EmployeeAbsence2.NEXT = 0;
            Heuresoccaenregm.RESET;
            Heuresoccaenregm.SETFILTER("N° Salarié", Employee."No.");
            Heuresoccaenregm.SETFILTER("Mois de paiement", '%1', SalaryHeader.Month);
            Heuresoccaenregm.SETFILTER("Année de paiement", '%1', SalaryHeader.Year);
            //<< DSFT AGA 140410
            IF ParamRessHum."Activer régime quinzaine" THEN
                IF regimeofwork."type calcul paie" = regimeofwork."type calcul paie"::Quinzaine THEN
                    Heuresoccaenregm.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);
            //<< DSFT AGA 140410

            //>>DSFT AGA 10/03/10
            Heuresoccaenregm.SETFILTER(Heuresoccaenregm."Paiement No.", '%1', '');
            //DSFT AGA 10/03/10
            IF Heuresoccaenregm.FIND('-') THEN
                REPEAT
                    TotHeuresEnreg := TotHeuresEnreg + Heuresoccaenregm."Nombre d'heures";
                UNTIL Heuresoccaenregm.NEXT = 0;
            IF ((TotHeuresEnreg > 0) AND (TotHeuresEnreg < Regimesofwork."Work Hours per month")) THEN BEGIN
                DiffHours := Regimesofwork."Work Hours per month" -
                              TotHeuresEnreg;

                AbsenceEnreg.RESET;
                AbsenceEnreg.SETFILTER("Posting month", '%1', SalaryHeader.Month);
                AbsenceEnreg.SETFILTER("Posting year", '%1', SalaryHeader.Year);
                AbsenceEnreg.SETFILTER("Employee No.", Employee."No.");
                AbsenceEnreg.SETFILTER("Line type", '%1', AbsenceEnreg."Line type"::"Deductible of salary");
                AbsenceEnreg.SETRANGE(Semaine, 0);
                IF AbsenceEnreg.FIND('-') THEN BEGIN
                    AbsenceEnreg.Quantity := DiffHours;
                    AbsenceEnreg."Quantity (Hours)" := -DiffHours;
                    AbsenceEnreg."Quantity (Days)" := -DiffHours /
                                                  (Regimesofwork."Work Hours per month" / Regimesofwork."Worked Day Per Month");
                    AbsenceEnreg.VALIDATE(Quantity, DiffHours);
                    AbsenceEnreg.MODIFY;
                END
                ELSE BEGIN
                    AbsenceEnreg1.RESET;
                    AbsenceEnreg1.FIND('+');
                    AbsenceEnreg1."Entry No." := AbsenceEnreg1."Entry No." + 1;
                    AbsenceEnreg1."Transaction No." := AbsenceEnreg1."Transaction No." + 1;
                    AbsenceEnreg1."Employee No." := Employee."No.";
                    //MBY 12/02/2010
                    AbsenceEnreg1."Employee Posting Group" := Employee."Employee Posting Group";
                    AbsenceEnreg1."Employee Statistic Group" := Employee."Statistics Group Code";
                    AbsenceEnreg1.service := Employee.Service;
                    AbsenceEnreg1.section := Employee.Section;
                    //MBY 12/02/2010
                    AbsenceEnreg1.VALIDATE("Employee No.", Employee."No.");
                    AbsenceEnreg1."Cause of Absence Code" := 'ABS';
                    AbsenceEnreg1.VALIDATE("Cause of Absence Code", 'ABS');
                    AbsenceEnreg1."Posting month" := SalaryHeader.Month;
                    AbsenceEnreg1."Posting year" := SalaryHeader.Year;
                    AbsenceEnreg1."Line type" := AbsenceEnreg1."Line type"::"Deductible of salary";
                    AbsenceEnreg1.Unit := AbsenceEnreg1.Unit::"Heure de travail";
                    AbsenceEnreg1.Semaine := 0;
                    AbsenceEnreg1.Quantity := DiffHours;
                    AbsenceEnreg1."Quantity (Hours)" := -DiffHours;
                    AbsenceEnreg1."Quantity (Days)" := -DiffHours /
                                                  (Regimesofwork."Work Hours per month" / Regimesofwork."Worked Day Per Month");
                    AbsenceEnreg1.VALIDATE(Quantity, DiffHours);
                    AbsenceEnreg1.INSERT;
                END;
            END;
        END;

        IF SalaryLine.Employee <> '' THEN BEGIN
            IF Sim = 1 THEN BEGIN
                /*
                Carr.ASCENDING;
                Carr.SETCURRENTKEY(employee,date);
                Carr.SETFILTER(employee,SalaryLine.Employee);
                IF ParamRessHum."Date de Calcul de Paie"<>0 THEN BEGIN
                IF DATE2DMY(SalaryHeader."Posting Date",2)=1 THEN
                dateD:=DMY2DATE(ParamRessHum."Date de Calcul de Paie"+1,12,SalaryHeader.Year-1)
                 ELSE
                dateD:=DMY2DATE(ParamRessHum."Date de Calcul de Paie"+1,DATE2DMY(SalaryHeader."Posting Date",2)-1,SalaryHeader.Year);
                DateF:=DMY2DATE(ParamRessHum."Date de Calcul de Paie",DATE2DMY(SalaryHeader."Posting Date",2),SalaryHeader.Year);
                END ELSE
                BEGIN
                dateD:=DMY2DATE(1,DATE2DMY(SalaryHeader."Posting Date",2),SalaryHeader.Year);
                DateF:=CALCDATE('+FM',dateD);
                END;
                */
                // Carr.SETRANGE(date,dateD,DateF);
                //Carr.SETFILTER("Salaire Base",'<>0');
                //NBJ:=(DateF-dateD)+1;
                IF Carr.COUNT <> 0 THEN BEGIN
                    Carr.SETRANGE(date, dateD, DateF);

                    IF Carr.FIND('-') THEN BEGIN  // RAMZI
                        Carr.SETRANGE(date, 0D, DateF);
                        REPEAT
                            IF Carr.date > dateD THEN BEGIN
                                BEGIN
                                    IF Carr."Salaire Base" <> 0 THEN
                                        SB := ROUND(Tchange.ExchangeAmtFCYToLCY(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"), Carr."Currency Code",

                                              Carr."Salaire Base", Tchange.ExchangeRate(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"), Carr."Currency Code")) -
                                              MntInd, ParamCpta."Amount Rounding Precision")
                                    ELSE
                                        SB := ROUND(Tchange.ExchangeAmtFCYToLCY(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"), Carr."Currency Code",
                                              Carr."Salaire Base", Tchange.ExchangeRate(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"), Carr."Currency Code"))
                                              , ParamCpta."Amount Rounding Precision");
                                END;
                            END
                            ELSE BEGIN
                                IF Carr."Currency Code" = '' THEN
                                    SB := Carr."Salaire Base"
                                ELSE BEGIN
                                    IF Carr."Gross Salary" <> 0 THEN
                                        SB := ROUND(Tchange.ExchangeAmtFCYToLCY(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"), Carr."Currency Code",
                                              Carr."Gross Salary", Tchange.ExchangeRate(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"), Carr."Currency Code")) -
                                              MntInd, ParamCpta."Amount Rounding Precision")
                                    ELSE
                                        SB := ROUND(Tchange.ExchangeAmtFCYToLCY(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"), Carr."Currency Code",
                                              Carr."Salaire Base", Tchange.ExchangeRate(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"), Carr."Currency Code"))
                                              , ParamCpta."Amount Rounding Precision");

                                END;

                            END;
                            DateF := CALCDATE('-1J', Carr.date);
                        UNTIL (Carr.NEXT = 0) OR (DateF <= dateD);
                    END;
                END;
            END;

            IF SB <> 0 THEN
                SalaryLine."Basis salary" := SB
            ELSE BEGIN
                IF Employee."Currency Code" = '' THEN
                    SalaryLine."Basis salary" := Employee."Basis salary"
                ELSE BEGIN
                    IF Employee."Indemnité imposable" <> 0 THEN
                        SalaryLine."Basis salary" :=
                           ROUND(Tchange.ExchangeAmtFCYToLCY(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"), Employee."Currency Code",
                              Employee."Indemnité imposable", Tchange.ExchangeRate(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"),
                              Employee."Currency Code")
                  ) -
                              MntInd, ParamCpta."Amount Rounding Precision")
                    ELSE
                        SalaryLine."Basis salary" :=
                             ROUND(Tchange.ExchangeAmtFCYToLCY(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"), Employee."Currency Code",
                              Employee."Basis salary", Tchange.ExchangeRate(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"), Employee."Currency Code")
                  )
                              , ParamCpta."Amount Rounding Precision");

                END;
            END;
        END;

        //>>MBY 14/04/2009
        IF (Sim = 0) THEN
            SalaryLine."Basis salary" := Employee."Basis salary";
        //>>MBY

        SalaryLine."User ID" := USERID;
        SalaryLine."Last Date Modified" := WORKDATE;

        EmploymentContract.RESET;
        Employee.RESET;
        Employee.GET(SalaryLine.Employee);
        EmploymentContract.GET(Employee."Emplymt. Contract Code");
        nbr := 12;
        CASE ParamRessHum."Number of monthes" OF
            0:
                nbr := EmploymentContract."Regular payments";
            1:
                nbr := EmploymentContract."Temporary payments";
            2:
                nbr := EmploymentContract."Regular payments" + EmploymentContract."Temporary payments";
        END;

        IF TRUE THEN BEGIN
            IF Employee."Familly chief" THEN
                SalaryLine."Deduction Family chief" := ROUND(ParamRessHum."Deduction for Familly Chief" / nbr,
                                                        ParamCpta."Amount Rounding Precision")
            ELSE
                SalaryLine."Deduction Family chief" := 0;
            Employee.CALCFIELDS("Deduction Loaded child");
            // SalaryLine."Deduction Loaded child"  := ROUND(Employee."Deduction Loaded child" / nbr,
            //                                         ParamCpta."Amount Rounding Precision");
        END
        ELSE BEGIN
            SalaryLine."Deduction Family chief" := 0;
            SalaryLine."Deduction Loaded child" := 0;
        END;
        SalaryLine."Deduction Prof. expenses" := 0;
        //>>AGA + FONCTIONS DE CALCUL HEURES SUPP PRIME AVANCE PRET
        CalculerFieldsPaie(SalaryLine, Sim);

        IF SalaryLine.INSERT THEN BEGIN
            // >> HJ BF 21-01-2014 Calculer Prime Anciennté
            CalculerPrimeAncienneté(SalaryLine.Employee);
            // >> HJ BF 21-01-2014 Calculer Prime Anciennté
            // Liste des indemnités du salarié en cour
            DefaultIndemnities.SETRANGE("Employment Contract Code", Employee."Emplymt. Contract Code");
            IF (SalaryLine.Month > 12) AND (SalaryLine.Month <> 15) THEN
                DefaultIndemnities.SETRANGE("Type Indemnité", 0);
            // SOLDE TO COMPTE
            IF SalaryLine.Month = SalaryLine.Month::STC THEN DefaultIndemnities.SETFILTER("Type STC", '<>%1', 0);
            // SOLDE TO COMPTE
            IF DefaultIndemnities.FIND('-') THEN
                REPEAT

                    found := FALSE;
                    SH.SETFILTER(Month, DefaultIndemnities."Mois d'application");
                    IF SH.FIND('-') THEN
                        REPEAT
                            IF SH."No." = SH."No." THEN
                                found := TRUE;
                        UNTIL SH.NEXT = 0;
                    IF found THEN BEGIN
                        // PARTIE INITIALISATION INDEMNITE
                        Indemnities.INIT;
                        Indemnities."No." := SalaryLine."No.";

                        Indemnities."Employee No." := SalaryLine.Employee;
                        Indemnities.Indemnity := DefaultIndemnities."Indemnity Code";
                        Indemnities."Employee Posting Group" := SalaryLine."Employee Posting Group";
                        Indemnities."Global Dimension 1" := SalaryLine."Global Dimension 1";
                        Indemnities."Global Dimension 2" := SalaryLine."Global Dimension 2";
                        Indemnities."Employee Statistic Group" := SalaryLine."Statistics Group Code";
                        //MBY 12/02/2010
                        Indemnities.direction := SalaryLine.Departement;
                        Indemnities.service := SalaryLine.Service;
                        Indemnities.section := SalaryLine.Section;
                        Indemnities.Abattement := DefaultIndemnities.Abattement;
                        Indemnities."% Abattement" := DefaultIndemnities."% Abattement";
                        Indemnities.Exonération := DefaultIndemnities.Exonération;
                        Indemnities."% Exonération" := DefaultIndemnities."% Exonération";
                        Indemnities."Plafond Exonération" := DefaultIndemnities."Plafond Exonération";
                        Indemnities."Type STC" := DefaultIndemnities."Type STC";
                        Indemnities."Inclu Calcul Brut STC" := DefaultIndemnities."Inclu Calcul Brut STC";
                        //MBY 12/02/2010
                        Indemnities.Description := DefaultIndemnities.Description;
                        Indemnities.Type := DefaultIndemnities.Type;
                        Indemnities."Evaluation mode" := DefaultIndemnities."Evaluation mode";
                        Indemnities."Type Indemnité" := DefaultIndemnities."Type Indemnité";
                        Indemnities."Non Inclus en Prime" := DefaultIndemnities."Non Inclus en Prime";
                        Indemnities."Precision Arrondi Montant" := DefaultIndemnities."Precision Arrondi Montant";
                        Indemnities."Direction Arrondi" := DefaultIndemnities."Direction Arrondi";
                        // HJ SORO 20-05-2015
                        Indemnities."Non Inclue en Calcul CNSS" := DefaultIndemnities."Non Inclus en Calcul CNSS";
                        // HJ SORO 20-05-2015
                        // DSFT AGA 12/05/2010 -------------------------------------------------------------------------------------
                        Indemnities."base deduction indemnité/jours" := DefaultIndemnities."base deduction indemnité/jours";
                        Indemnities."base deduction indemnité/heure" := DefaultIndemnities."base deduction indemnité/heure";
                        Indemnities."Avantage en nature" := DefaultIndemnities."Avantage en nature";
                        Indemnities."Compte indemnité" := DefaultIndemnities."Compte indemnité";
                        Indemnities."Compte contre partie indemnité" := DefaultIndemnities."Compte contre partie indemnité";
                        Indemnities."Nombre de jours" := DefaultIndemnities."Nombre de jours";
                        Indemnities."Non déductible accident de Tra" := DefaultIndemnities."Non déductible accident de Tra";

                        // DSFT AGA 12/05/2010 -------------------------------------------------------------------------------------
                        // MC : Minimum ganati -------------------------------------------------------------------------------------
                        Indemnities."Minimum value" := DefaultIndemnities."Minimum value";
                        Indemnities.Nom := Employee.FullName();

                        //----------------------------------------------------------------------------------------------------------
                        Indemnities."User ID" := USERID;
                        Indemnities."Last Date Modified" := WORKDATE;
                        Indemnities.Taux := DefaultIndemnities.Taux;
                        IF (SalaryLine.Month > 12) AND (SalaryLine.Month <> 15) AND (DefaultIndemnities."Non Inclus en Prime" = TRUE) THEN
                            Indemnities.Taux := 0;
                        IF EmploymentContract."Adjust indemnity amount" THEN BEGIN
                            CASE DefaultIndemnities."Evaluation mode" OF
                                0, 4, 9:
                                    Indemnities."Base Amount" := DefaultIndemnities."Default amount";
                                1:
                                    Indemnities."Base Amount" := DefaultIndemnities."Default amount"
                                                                 * SalaryHeader."Paid days"
                                                                 / ParamRessHum."Paid days";
                                2:
                                    Indemnities."Base Amount" := (DefaultIndemnities."Default amount"
                                                                 * SalaryHeader."Worked days"
                                                                 / ParamRessHum."Worked days");
                                7:
                                    Indemnities."Base Amount" := (SalaryLine."Basis salary");
                                3, 8:
                                    Indemnities."Base Amount" := (DefaultIndemnities."Default amount");
                            END;
                        END
                        ELSE
                            Indemnities."Base Amount" := (DefaultIndemnities."Default amount");
                        // >> HJ BF 21-01-2014 Appliquer Indemniter De Panier 3*nbrjourpanier* Smig Horaire
                        IF DefaultIndemnities."Evaluation mode" = DefaultIndemnities."Evaluation mode"::"3*Smig Hor. Base" THEN BEGIN
                            IF Employee.GET(SalaryLine.Employee) THEN;
                            Linegrid.RESET;
                            Linegrid.SETRANGE(Catégorie, Employee.Catégorie);
                            Linegrid.SETRANGE(Echelons, Employee.Echelons);
                            IF Linegrid.FINDFIRST THEN
                                Indemnities."Base Amount" := 3 * Linegrid."Taux Horaire" * ParamRessHum."Paid days";
                        END;
                        // >> HJ BF 21-01-2014 Appliquer Indemniter De Panier 3*nbrjourpanier* Smig Horaire

                        // >> HJ BF 21-01-2014 Appliquer Indemniter De Panier Montant Forf* Nbj Jours Travailler
                        IF DefaultIndemnities."Evaluation mode" = DefaultIndemnities."Evaluation mode"::"Base*Nbr Jour" THEN
                            Indemnities."Base Amount" := ParamRessHum."Paid days" * ParamRessHum."Base Prime Panier F";
                        // >> HJ BF 21-01-2014 Appliquer Indemniter De Panier Montant Forf* Nbj Jours Travailler

                        Indemnities."Real Amount" := 0;
                        Indemnities."Non Inclis en AV NAt" := DefaultIndemnities."Non Inclis en AV NAt";
                        Ins := TRUE;
                        IF Indemnities."Type Indemnité" = 1 THEN BEGIN
                            Ins := FALSE;
                            IF CONFIRM(STRSUBSTNO('Indemnité %1 Pour L''Employer %2 Montant de Base est de %3 n''est Pas une Indemnité Régulière',
                               Indemnities.Description, Indemnities."Employee No." + ' ' + Indemnities.Nom, Indemnities."Base Amount"), FALSE, TRUE) THEN
                                Ins := TRUE;
                        END;
                        IF Ins THEN
                            IF Indemnities.INSERT THEN BEGIN
                                // Cotisations à appliquer à des Indmennités particulières
                                DefaultSocContribution.RESET;
                                DefaultSocContribution.SETRANGE("Employment Contract Code", Employee."Emplymt. Contract Code");
                                DefaultSocContribution.SETRANGE("Indemnity Code", DefaultIndemnities."Indemnity Code");
                                ParamRessHum.GET;
                                IF SalaryLine.Month = SalaryLine.Month::Prime THEN
                                    DefaultSocContribution.SETRANGE("Non Inclus en Prime", FALSE);

                                IF NOT ParamRessHum."Activer Type Prime" THEN BEGIN
                                    IF SalaryLine.Month = SalaryLine.Month::Prime THEN
                                        DefaultSocContribution.SETRANGE("Non Inclus en Prime", FALSE);
                                END ELSE BEGIN
                                    CLEAR(PrimeType);
                                    IF PrimeType.GET(SalaryLine."Type Prime") THEN;

                                    IF ((SalaryLine.Month > 12) AND (SalaryLine.Month <> 15)) OR (PrimeType."Type Calcul" <> 2) THEN
                                        DefaultSocContribution.SETRANGE("Non Inclus en Prime", FALSE);
                                END;
                                IF DefaultSocContribution.FIND('-') THEN
                                    REPEAT
                                        // PARTIE INITIALISATION COTISATION SOCIAL
                                        SocialContributions.INIT;
                                        SocialContributions."No." := SalaryLine."No.";
                                        SocialContributions."year of Calculate" := SalaryLine."year of Calculate";
                                        SocialContributions.Employee := SalaryLine.Employee;
                                        SocialContributions.Indemnity := DefaultIndemnities."Indemnity Code";
                                        SocialContributions."Social Contribution" := DefaultSocContribution."Social Contribution Code";
                                        SocialContributions."Basis of calculation" := DefaultSocContribution."Basis of calculation";
                                        SocialContributions."Employee Posting Group" := SalaryLine."Employee Posting Group";
                                        SocialContributions."Employee Statistic Group" := SalaryLine."Statistics Group Code";
                                        SocialContributions."Global Dimension 1" := SalaryLine."Global Dimension 1";
                                        SocialContributions."Global Dimension 2" := SalaryLine."Global Dimension 2";
                                        SocialContributions.direction := SalaryLine.Departement;
                                        SocialContributions.service := SalaryLine.Service;
                                        SocialContributions.section := SalaryLine.Section;
                                        SocialContributions."Plafond SBase*8%" := DefaultSocContribution."Plafond SBase*8%";
                                        IF SocialContribution.GET(DefaultSocContribution."Social Contribution Code") THEN
                                            SocialContributions.Description := SocialContribution.Description;
                                        SocialContributions."Employer's part" := DefaultSocContribution."Employer's part";
                                        SocialContributions."Employee's part" := DefaultSocContribution."Employee's part";
                                        SocialContributions."Base Amount" := 0;
                                        SocialContributions."Real Amount : Employee" := 0;
                                        SocialContributions."Real Amount : Employer" := 0;
                                        SocialContributions."Deductible of taxable basis" := DefaultSocContribution."Deductible of taxable basis";
                                        SocialContributions."Maximum value - Employee" := DefaultSocContribution."Maximum value - Employee";
                                        SocialContributions."Maximum value - Employer" := DefaultSocContribution."Maximum value - Employer";

                                        SocialContributions."Mode dévaluation" := DefaultSocContribution."Mode dévaluation";
                                        SocialContributions."Forfait salarial" := DefaultSocContribution."Forfait salarial";
                                        SocialContributions."Forfait patronal" := DefaultSocContribution."Forfait patronal";

                                        SocialContributions."User ID" := USERID;
                                        SocialContributions."Last Date Modified" := WORKDATE;
                                        // HJ SORO 20-05-2015
                                        SocialContributions.CNSS := DefaultSocContribution.CNSS;
                                        // HJ SORO 20-05-2015
                                        SocialContributions.INSERT;
                                    UNTIL DefaultSocContribution.NEXT = 0;
                            END;
                    END;
                UNTIL DefaultIndemnities.NEXT = 0;

            // Cotisations à appliquer à toutes les indemnités
            DefaultSocContribution.SETRANGE("Employment Contract Code", Employee."Emplymt. Contract Code");
            DefaultSocContribution.SETRANGE("Indemnity Code", '');
            ParamRessHum.GET;
            IF NOT ParamRessHum."Activer Type Prime" THEN BEGIN
                IF SalaryLine.Month = SalaryLine.Month::Prime THEN
                    DefaultSocContribution.SETRANGE("Non Inclus en Prime", FALSE);

            END ELSE BEGIN

                CLEAR(PrimeType);
                IF PrimeType.GET(SalaryLine."Type Prime") THEN;

                IF ((SalaryLine.Month > 12) AND (SalaryLine.Month <> 15)) OR (PrimeType."Type Calcul" <> 2) THEN
                    DefaultSocContribution.SETRANGE("Non Inclus en Prime", FALSE);
            END;
            IF DefaultSocContribution.FIND('-') THEN
                REPEAT
                    // message(format(DefaultSocContribution."Social Contribution Code"));
                    SocialContributions.INIT;
                    SocialContributions."No." := SalaryLine."No.";
                    SocialContributions.Employee := SalaryLine.Employee;
                    SocialContributions."year of Calculate" := SalaryLine."year of Calculate";

                    SocialContributions.Indemnity := '';
                    SocialContributions."Social Contribution" := DefaultSocContribution."Social Contribution Code";
                    SocialContributions."Employee Posting Group" := SalaryLine."Employee Posting Group";
                    SocialContributions."Employee Statistic Group" := SalaryLine."Statistics Group Code";
                    SocialContributions."Global Dimension 1" := SalaryLine."Global Dimension 1";
                    SocialContributions."Global Dimension 2" := SalaryLine."Global Dimension 2";
                    SocialContributions.direction := SalaryLine.Departement;
                    SocialContributions.service := SalaryLine.Service;
                    SocialContributions.section := SalaryLine.Section;
                    SocialContributions."Plafond SBase*8%" := DefaultSocContribution."Plafond SBase*8%";
                    IF SocialContribution.GET(DefaultSocContribution."Social Contribution Code") THEN
                        SocialContributions.Description := SocialContribution.Description;
                    SocialContributions."Basis of calculation" := DefaultSocContribution."Basis of calculation";

                    SocialContributions."Employer's part" := DefaultSocContribution."Employer's part";
                    SocialContributions."Employee's part" := DefaultSocContribution."Employee's part";
                    SocialContributions."Base Amount" := 0;
                    SocialContributions."Real Amount : Employee" := 0;
                    SocialContributions."Real Amount : Employer" := 0;
                    SocialContributions."Deductible of taxable basis" := DefaultSocContribution."Deductible of taxable basis";
                    SocialContributions."Maximum value - Employee" := DefaultSocContribution."Maximum value - Employee";
                    SocialContributions."Maximum value - Employer" := DefaultSocContribution."Maximum value - Employer";

                    SocialContributions."Mode dévaluation" := DefaultSocContribution."Mode dévaluation";
                    SocialContributions."Forfait salarial" := DefaultSocContribution."Forfait salarial";
                    SocialContributions."Forfait patronal" := DefaultSocContribution."Forfait patronal";

                    SocialContributions."User ID" := USERID;
                    SocialContributions."Last Date Modified" := WORKDATE;
                    // HJ SORO 20-05-2015
                    SocialContributions.CNSS := DefaultSocContribution.CNSS;
                    // HJ SORO 20-05-2015

                    SocialContributions.INSERT;
                UNTIL DefaultSocContribution.NEXT = 0;
            OK := TRUE;
        END
        ELSE
            OK := FALSE;

    end;


    procedure "CréerLignesIndemnités"(var SalaryLine: Record "Salary Lines"; Employee: Record 5200) OK: Boolean
    var
        Indemnities: Record "Indemnities";
        EmploymentContract: Record 5211;
        DefaultIndemnities: Record "Default Indemnities";
        DefaultSocContribution: Record "Default Soc. Contribution";
        SocialContributions: Record "Social Contributions";
        ins: Boolean;
    begin
        ParamCpta.GET;
        IF Employee."Emplymt. Contract Code" <> '' THEN BEGIN
            DefaultIndemnities.RESET;
            IF EmploymentContract.GET(EmploymentContract.Code) THEN;
            DefaultIndemnities.SETRANGE("Employment Contract Code", EmploymentContract.Code);
            IF (SalaryLine.Month > 12) AND (SalaryLine.Month <> 15) THEN BEGIN

                //DefaultIndemnities.SETRANGE ("Type Indemnité",0);
                DefaultIndemnities.SETRANGE("Non Inclus en Prime", FALSE);
            END;
            IF DefaultIndemnities.FIND('-') THEN
                REPEAT
                    Indemnities.RESET;
                    Indemnities.INIT;
                    Indemnities."No." := SalaryLine."No.";
                    Indemnities."Employee No." := SalaryLine.Employee;
                    Indemnities.Indemnity := DefaultIndemnities."Indemnity Code";
                    Indemnities."Employee Posting Group" := SalaryLine."Employee Posting Group";
                    Indemnities."Employee Statistic Group" := SalaryLine."Statistics Group Code";
                    Indemnities."Global Dimension 1" := SalaryLine."Global Dimension 1";
                    Indemnities."Global Dimension 2" := SalaryLine."Global Dimension 2";
                    //MBY 12/02/2010
                    Indemnities.direction := SalaryLine.Departement;
                    Indemnities.service := SalaryLine.Service;
                    Indemnities.section := SalaryLine.Section;
                    //MBY 12/02/2010
                    Indemnities.Description := DefaultIndemnities.Description;
                    Indemnities.Type := DefaultIndemnities.Type;
                    Indemnities."Evaluation mode" := DefaultIndemnities."Evaluation mode";
                    Indemnities."Non Inclus en Prime" := DefaultIndemnities."Non Inclus en Prime";
                    Indemnities."Precision Arrondi Montant" := DefaultIndemnities."Precision Arrondi Montant";
                    Indemnities."Direction Arrondi" := DefaultIndemnities."Direction Arrondi";
                    Indemnities."Non Inclue en jours congé" := DefaultIndemnities."Non Inclue en jours congé";
                    IF ((SalaryLine.Month > 12) AND (SalaryLine.Month <> 15)) AND (DefaultIndemnities."Non Inclus en Prime" = TRUE) THEN
                        Indemnities.Taux := 0;

                    IF Indemnities."Evaluation mode" = 7 THEN
                        Indemnities."Base Amount" := (SalaryLine."Basis salary")
                    ELSE
                        Indemnities."Base Amount" := ROUND(DefaultIndemnities."Default amount", ParamCpta."Amount Rounding Precision");
                    Indemnities."Minimum value" := DefaultIndemnities."Minimum value";
                    Indemnities."Real Amount" := 0;
                    Indemnities."Type Indemnité" := DefaultIndemnities."Type Indemnité";
                    Indemnities."User ID" := USERID;
                    Indemnities."Last Date Modified" := WORKDATE;
                    Indemnities."Non Inclis en AV NAt" := DefaultIndemnities."Non Inclis en AV NAt";
                    ins := TRUE;
                    IF Indemnities."Type Indemnité" = 1 THEN BEGIN
                        ins := FALSE;
                        IF CONFIRM(STRSUBSTNO('Indemnité %1 Pour L''Employer %2 Montant de Base est de %3 n''est Pas une Indemnité Régulière',
                           Indemnities.Description, Indemnities."Employee No." + ' ' + Indemnities.Nom, Indemnities."Base Amount"), FALSE, TRUE) THEN
                            ins := TRUE;
                    END;
                    IF ins THEN
                        IF Indemnities.INSERT THEN;
                UNTIL DefaultIndemnities.NEXT = 0;
            OK := TRUE;
        END
        ELSE
            OK := FALSE;
    end;


    procedure "CréerLignesCotSoc"(var SalaryLine: Record "Salary Lines"; Employee: Record 5200) OK: Boolean
    var
        Indemnities: Record "Indemnities";
        EmploymentContract: Record 5211;
        DefaultIndemnities: Record "Default Indemnities";
        DefaultSocContribution: Record "Default Soc. Contribution";
        SocialContributions: Record "Social Contributions";
        SocCont: Record "Social Contribution";
        PrimeType: Record "Prime1";
        ParamRessHum: Record 5218;
    begin
        ParamCpta.GET;
        IF Employee."Emplymt. Contract Code" <> '' THEN BEGIN
            Indemnities.SETRANGE("No.", SalaryLine."No.");
            Indemnities.SETRANGE("Employee No.", SalaryLine.Employee);
            EmploymentContract.GET(Employee."Emplymt. Contract Code");
            IF Indemnities.FIND('-') THEN
                REPEAT
                    DefaultSocContribution.RESET;
                    DefaultSocContribution.SETRANGE("Employment Contract Code", EmploymentContract.Code);
                    DefaultSocContribution.SETRANGE("Indemnity Code", Indemnities.Indemnity);
                    ParamRessHum.GET;
                    IF NOT ParamRessHum."Activer Type Prime" THEN BEGIN
                        IF SalaryLine.Month = SalaryLine.Month::Prime THEN
                            DefaultSocContribution.SETRANGE("Non Inclus en Prime", FALSE);

                    END ELSE BEGIN

                        CLEAR(PrimeType);
                        IF PrimeType.GET(SalaryLine."Type Prime") THEN;

                        IF ((SalaryLine.Month > 12) AND (SalaryLine.Month <> 15)) OR (PrimeType."Type Calcul" <> 2) THEN
                            DefaultSocContribution.SETRANGE("Non Inclus en Prime", FALSE);
                    END;
                    IF DefaultIndemnities.FIND('-') THEN
                        REPEAT

                            SocialContributions.INIT;
                            SocialContributions."No." := SalaryLine."No.";
                            SocialContributions.Employee := SalaryLine.Employee;
                            SocialContributions."year of Calculate" := SalaryLine."year of Calculate";

                            SocialContributions.Indemnity := DefaultSocContribution."Indemnity Code";
                            SocialContributions."Social Contribution" := DefaultSocContribution."Social Contribution Code";
                            SocialContributions."Employee Posting Group" := SalaryLine."Employee Posting Group";
                            SocialContributions."Employee Statistic Group" := SalaryLine."Statistics Group Code";
                            SocialContributions."Global Dimension 1" := SalaryLine."Global Dimension 1";
                            SocialContributions."Global Dimension 2" := SalaryLine."Global Dimension 2";
                            //MBY 12/02/2010
                            SocialContributions.direction := SalaryLine.Departement;
                            SocialContributions.service := SalaryLine.Service;
                            SocialContributions.section := SalaryLine.Section;
                            //MBY 12/02/2010
                            SocialContributions."Basis of calculation" := DefaultSocContribution."Basis of calculation";

                            IF SocCont.GET(DefaultSocContribution."Social Contribution Code") THEN
                                SocialContributions.Description := SocCont.Description;
                            SocialContributions."Employer's part" := DefaultSocContribution."Employer's part";
                            SocialContributions."Employee's part" := DefaultSocContribution."Employee's part";
                            SocialContributions."Base Amount" := 0;
                            SocialContributions."Real Amount : Employee" := 0;
                            SocialContributions."Real Amount : Employer" := 0;
                            SocialContributions."Deductible of taxable basis" := DefaultSocContribution."Deductible of taxable basis";

                            SocialContributions."Maximum value - Employee" := DefaultSocContribution."Maximum value - Employee";
                            SocialContributions."Maximum value - Employer" := DefaultSocContribution."Maximum value - Employer";
                            SocialContributions."Mode dévaluation" := DefaultSocContribution."Mode dévaluation";
                            SocialContributions."Forfait salarial" := DefaultSocContribution."Forfait salarial";
                            SocialContributions."Forfait patronal" := DefaultSocContribution."Forfait patronal";

                            SocialContributions."User ID" := USERID;
                            SocialContributions."Last Date Modified" := WORKDATE;

                            IF SocialContributions.INSERT THEN;
                        UNTIL DefaultIndemnities.NEXT = 0;
                UNTIL Indemnities.NEXT = 0;
        END;
    end;


    procedure CalculerCotSoc(var LigneSalaire: Record "Salary Lines")
    var
        SocialContributions: Record "Social Contributions";
        Ind: Record "Indemnities";
        LigSalEng: Record "Rec. Salary Lines";
        SocialCont: Record "Rec. Social Contributions";
        RecDefaultIndemnities: Record "Default Indemnities";
    begin
        ParamCpta.GET;
        SocialContributions.SETRANGE("No.", LigneSalaire."No.");
        SocialContributions.SETRANGE(Employee, LigneSalaire.Employee);
        IF SocialContributions.FIND('-') THEN BEGIN
            CASE SocialContributions."Basis of calculation" OF
                0:
                    BEGIN
                        IF SocialContributions.Indemnity = '' THEN
                            SocialContributions."Base Amount" := LigneSalaire."Gross Salary"
                        ELSE BEGIN
                            Ind.SETRANGE("No.", LigneSalaire."No.");
                            Ind.SETRANGE("Employee No.", LigneSalaire.Employee);
                            Ind.SETRANGE(Indemnity, SocialContributions.Indemnity);
                            IF Ind.FIND('-') THEN
                                SocialContributions."Base Amount" := Ind."Real Amount";
                            //  SocialContributions."Base Amount" := (Ind."Real Amount");

                        END;
                    END;
                2:
                    BEGIN
                        SocialContributions."Base Amount" := ROUND(LigneSalaire."Basis salary"
                                                                   , ParamCpta."Amount Rounding Precision");
                        //>>MBY 19/02/2010 ENDA
                        RecDefaultIndemnities.RESET;
                        RecDefaultIndemnities.SETRANGE("Employment Contract Code", LigneSalaire."Emplymt. Contract Code");
                        RecDefaultIndemnities.SETRANGE("Inclus dans base assurance", TRUE);
                        IF RecDefaultIndemnities.FIND('-') THEN
                            REPEAT
                                SocialContributions."Base Amount" := ROUND(SocialContributions."Base Amount" + RecDefaultIndemnities."Default amount"
                                                                       , ParamCpta."Amount Rounding Precision");

                            UNTIL RecDefaultIndemnities.NEXT = 0
                        //<<MBY 19/02/2010 ENDA

                    END;

                1:
                    BEGIN
                        SocialCont.RESET;
                        SocialCont.SETCURRENTKEY("Social Contribution", Employee, "year of Calculate");
                        SocialCont.SETFILTER("Social Contribution", SocialContributions."Social Contribution");
                        SocialCont.SETFILTER(Employee, LigneSalaire.Employee);
                        SocialCont.SETRANGE("year of Calculate", LigneSalaire."year of Calculate");
                        SocialCont.CALCSUMS("Base Amount");

                        LigSalEng.RESET;
                        LigSalEng.SETCURRENTKEY(Employee, "year of Calculate", Month, "Type Prime");
                        LigSalEng.SETFILTER(Employee, LigneSalaire.Employee);
                        LigSalEng.SETRANGE("year of Calculate", LigneSalaire."year of Calculate");
                        LigSalEng.CALCSUMS("Gross Salary", "6 * SMIG");
                        IF (LigneSalaire."Gross Salary" + LigSalEng."Gross Salary") <= (LigneSalaire."6 * SMIG" + LigSalEng."6 * SMIG") THEN BEGIN
                            IF SocialCont."Base Amount" <> 0 THEN
                                SocialContributions."Base Amount" := -SocialCont."Base Amount"
                            ELSE
                                SocialContributions."Base Amount" := 0;
                        END
                        ELSE BEGIN
                            SocialContributions."Base Amount" := ROUND(((LigneSalaire."Gross Salary" + LigSalEng."Gross Salary") -
                                                           (LigneSalaire."6 * SMIG" + LigSalEng."6 * SMIG") - SocialCont."Base Amount"),
                                                           ParamCpta."Amount Rounding Precision");
                        END;
                    END;
            END; //end case
            SocialContributions."Real Amount : Employee" := ROUND(SocialContributions."Base Amount"
                                                          * SocialContributions."Employee's part"
                                                          / 100, ParamCpta."Amount Rounding Precision");
            IF SocialContributions."Maximum value - Employee" > 0 THEN BEGIN
                IF SocialContributions."Real Amount : Employee" > SocialContributions."Maximum value - Employee" THEN
                    SocialContributions."Real Amount : Employee" := SocialContributions."Maximum value - Employee";
            END;

            SocialContributions."Real Amount : Employer" := ROUND(SocialContributions."Base Amount"
                                                          * SocialContributions."Employer's part"
                                                          / 100, ParamCpta."Amount Rounding Precision");
            IF SocialContributions."Maximum value - Employer" > 0 THEN BEGIN
                IF SocialContributions."Real Amount : Employer" > SocialContributions."Maximum value - Employer" THEN
                    SocialContributions."Real Amount : Employer" := SocialContributions."Maximum value - Employer";
            END;

            IF SocialContributions."Forfait salarial" > 0 THEN
                SocialContributions."Real Amount : Employee" := SocialContributions."Forfait salarial";
            IF SocialContributions."Forfait patronal" > 0 THEN
                SocialContributions."Real Amount : Employer" := SocialContributions."Forfait patronal";

            SocialContributions."User ID" := USERID;
            SocialContributions."Last Date Modified" := WORKDATE;
            IF SocialContributions."Base Amount" = 0 THEN
                SocialContributions.DELETE
            ELSE
                SocialContributions.MODIFY;

        END;
    end;


    procedure CalculerLigneSalaire(var SalaryLine: Record "Salary Lines"; "SolderDroitCongé": Boolean; Sim: Option Simulation,Real,Prime; nbjsolder: Decimal; Pinverse: Boolean): Decimal
    var
        SalaryHeader: Record "Salary Headers";
        Ind: Record "Indemnities";
        SocialContributions: Record "Social Contributions";
        ParamRessHum: Record 5218;
        EmploymentContract: Record 5211;
        RegimeWork: Record "Regimes of work";
        Employee: Record 5200;
        SliceImposition: Record "Slices of imposition";
        SliceImpositionX: Record "Slices of imposition";
        temp: Decimal;
        tmp: Decimal;
        tmp1: Decimal;
        Cot: Record "Default Soc. Contribution";
        nbr: Integer;
        bonus: Decimal;
        SalLineEng: Record "Rec. Salary Lines";
        EntEng: Record "Rec. Salary Headers";
        LigneTravail: Record "Heures occa. enreg. m";
        LigneTravailEnreg: Record "Heures sup. eregistrées m";
        WorkedD: Decimal;
        "Mgmt.ofLoansandAdvances": Codeunit "Mgmt. of Loans and Advances";
        droitconge: Record "Employee's days off Entry";
        SalLineEngTmp: Record "Rec. Salary Lines";
        MntInd: Decimal;
        DefaultIndemnitiesTmp: Record "Default Indemnities";
        SoldeReport: Decimal;
        SoldeReport1: Decimal;
        EMP1: Record 5200;
        LigneAbsence: Record "Employee's days off Entry";
        AbsEmp: Decimal;
        "RecLJourFérier": Record "Employee's days off Entry";
        "//DSFT AGA 18/03/2010": Integer;
        RecLDefaultindemnities: Record "Default Indemnities";
        RecLIndemnities: Record "Indemnities";
        DecSalaireBrut: Decimal;
        HeureJourTravail: Record "Heures occa. enreg. m";
        LSalaryLine: Record "Salary Lines";
        V1: Decimal;
        V2: Decimal;
    begin
        SalaryHeader.GET(SalaryLine."No.");
        ParamRessHum.GET();
        IF NOT SolderDroitCongé THEN
            nbjsolder := 0;
        ParamCpta.GET;
        Employee.RESET;
        Employee.GET(SalaryLine.Employee);
        CLEAR(EmploymentContract);
        EmploymentContract.GET(Employee."Emplymt. Contract Code");
        RegimeWork.RESET;
        RegimeWork.GET(EmploymentContract."Regimes of work");
        initLigne(SalaryLine, Sim);
        GNbJour := RegimeWork."Worked Day Per Month";//ParamRessHum."Paid days";
        GNbHeure := RegimeWork."Work Hours per month";//ParamRessHum."Paid days"*ParamRessHum."From Work day to Work hour";
                                                      //-->calcul de la bonification

        bonus := 1;
        IF (SalaryLine.Month > 11) AND (SalaryLine.Pourcentage > 0) THEN BEGIN
            bonus := SalaryLine.Pourcentage;

            IF ParamRessHum."Type de Note" = 0 THEN
                bonus := bonus / 100;
            //-->Prise en compte de nbre de mois travaillés
            IF SalaryLine."Mois travaillés" > 0 THEN
                bonus := bonus * (SalaryLine."Mois travaillés" / 12)
            ELSE
                bonus := 0;
        END;
        // RK

        //--> Soder droit congé
        IF Sim = 1 THEN
            CalcAbsence(SalaryLine);
        ParamRessHum.TESTFIELD("Minimum wage guarantee");

        CreerLignetransport(SalaryLine);
        IF SalaryLine.Month < 12 THEN BEGIN
            IF (DATE2DMY(Employee."Employment Date", 3) = SalaryLine.Year) AND ((DATE2DMY(Employee."Employment Date", 2) - 1) = SalaryLine.Month)
            THEN
                SalaryLine."6 * SMIG" := ROUND(ParamRessHum."Minimum wage guarantee" * 6 *
                      (CALCDATE('+FM', Employee."Employment Date") - Employee."Employment Date" + 1), ParamCpta."Amount Rounding Precision")
            ELSE
                SalaryLine."6 * SMIG" := ROUND(ParamRessHum."Minimum wage guarantee" * 6, ParamCpta."Amount Rounding Precision");
        END;

        IF SolderDroitCongé THEN BEGIN
            IF ((SalaryLine."Days off remaining" + SalaryLine."droit de congé du mois") >= nbjsolder) AND (nbjsolder <> 0) THEN
                SalaryLine."Days off balacement" := nbjsolder
            ELSE
                SalaryLine."Days off balacement" := (SalaryLine."Days off remaining" + SalaryLine."droit de congé du mois");
            droitconge.RESET;
            droitconge.SETCURRENTKEY("Line type", "Employee No.", "Posting month", "Posting year");
            droitconge.SETRANGE("Line type", 1);
            droitconge.SETRANGE("Employee No.", SalaryLine.Employee);
            droitconge.SETRANGE("Posting month", SalaryLine.Month);
            droitconge.SETRANGE("Posting year", SalaryLine.Year);

            droitconge.CALCSUMS("Quantity (Days)", "Montant Ligne", "Quantity (Hours)");
            SalaryLine."Amount Days Off balacement" := ROUND(Employee."Basis salary" * SalaryLine."Days off balacement" /
                                                     SalaryHeader."Paid days", ParamCpta."Amount Rounding Precision");
            SalaryLine."Assiduity (days off balacement" := ROUND(SalaryLine."Days off balacement" / SalaryHeader."Paid days", 0.0001) * 100;
            SalaryLine."Hours off Balacement" := droitconge."Quantity (Hours)";
        END
        ELSE
            SalaryLine."Days off balacement" := 0;
        //DSFT AGA 11/03/2010
        // calcul jour férié
        ParamRessHum.GET();
        IF ParamRessHum."Calcul Montant absence" = FALSE THEN BEGIN
            //SalaryLine.CALCFIELDS(SalaryLine."Jours Fériés travaillés");
            //IF SalaryLine."Jours Fériés travaillés"<>0 THEN BEGIN
            RecLJourFérier.RESET;
            RecLJourFérier.SETRANGE("Employee No.", SalaryLine.Employee);
            RecLJourFérier.SETRANGE("Posting month", SalaryLine.Month);
            RecLJourFérier.SETRANGE("Posting year", SalaryLine.Year);
            RecLJourFérier.SETRANGE("Line type", 11);
            //>> DSFT AGA 140410
            IF ParamRessHum."Activer régime quinzaine" THEN
                IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN
                    RecLJourFérier.SETRANGE(Quinzaine, SalaryHeader.Quinzaine);
            //<< DSFT AGA 140410
            IF RecLJourFérier.FIND('-') THEN
                REPEAT

                    CalcMontanJourFérié(RecLJourFérier);
                UNTIL RecLJourFérier.NEXT = 0;
        END;
        //DSFT AGA 11/03/2010
        //>>DSFT AGA 150410
        //SalaryLine.CALCFIELDS(SalaryLine."Jours Fériés travaillés");
        IF SalaryLine."Jours Fériés travaillés" <> 0 THEN BEGIN

            RecLJourFérier.RESET;
            RecLJourFérier.SETCURRENTKEY("Line type", "Employee No.", "Posting month", "Posting year", Quinzaine, "Motif D'absence");
            RecLJourFérier.SETRANGE("Employee No.", SalaryLine.Employee);
            RecLJourFérier.SETRANGE("Posting month", SalaryLine.Month);
            RecLJourFérier.SETRANGE("Posting year", SalaryLine.Year);
            RecLJourFérier.SETRANGE("Line type", 11);
            IF ParamRessHum."Activer régime quinzaine" THEN
                IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN
                    RecLJourFérier.SETRANGE(Quinzaine, SalaryHeader.Quinzaine);
            RecLJourFérier.CALCSUMS(RecLJourFérier."Montant Ligne");
            // message(format(RecLJourFérier."Montant Ligne"));
            SalaryLine."Montant Jours Fériés travaillé" := RecLJourFérier."Montant Ligne";
            RecLJourFérier.RESET;
            RecLJourFérier.SETCURRENTKEY("Line type", "Employee No.", "Posting month", "Posting year", Quinzaine, "Motif D'absence");
            RecLJourFérier.SETRANGE("Employee No.", SalaryLine.Employee);
            RecLJourFérier.SETRANGE("Posting month", SalaryLine.Month);
            RecLJourFérier.SETRANGE("Posting year", SalaryLine.Year);
            RecLJourFérier.SETRANGE("Line type", 10);
            IF ParamRessHum."Activer régime quinzaine" THEN
                IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN
                    RecLJourFérier.SETRANGE(Quinzaine, SalaryHeader.Quinzaine);
            RecLJourFérier.CALCSUMS(RecLJourFérier."Montant Ligne");
            SalaryLine."Montant Jours Fériés" := RecLJourFérier."Montant Ligne";
        END;
        //>>DSFT AGA 150410


        // --> Calcul des 2 param. d'assiduité
        MntInd := 0;
        IF Employee."Currency Code" <> '' THEN BEGIN
            DefaultIndemnitiesTmp.RESET;
            DefaultIndemnitiesTmp.SETFILTER("Employment Contract Code", Employee."Emplymt. Contract Code");
            DefaultIndemnitiesTmp.SETRANGE("Evaluation mode", 1, 2);
            DefaultIndemnitiesTmp.SETRANGE("Type Indemnité", 0);
            IF DefaultIndemnitiesTmp.FIND('-') THEN
                REPEAT
                    MntInd := MntInd + DefaultIndemnitiesTmp."Default amount";
                UNTIL DefaultIndemnitiesTmp.NEXT = 0;
        END;
        nbr := 12;
        EmploymentContract.RESET;
        Employee.RESET;
        Employee.GET(SalaryLine.Employee);
        EmploymentContract.GET(Employee."Emplymt. Contract Code");
        CASE ParamRessHum."Number of monthes" OF
            0:
                nbr := EmploymentContract."Regular payments";
            1:
                nbr := EmploymentContract."Temporary payments";
            2:
                nbr := EmploymentContract."Regular payments" + EmploymentContract."Temporary payments";
        END;

        IF RegimeWork.GET(SalaryLine."Employee Regime of work") THEN;
        IF ((Sim = 1) OR ((SalaryLine."Basis salary" = 0) AND (Sim = 0))) AND NOT ((Pinverse = TRUE) AND (SalaryLine."Basis salary" = 0)) THEN BEGIN
            IF SalaryLine."Posting Date" = 0D THEN
                SalaryLine."Posting Date" := WORKDATE;
            IF Employee."Currency Code" = '' THEN
                SalaryLine."Basis salary" := Employee."Basis salary"
            ELSE BEGIN
                IF Employee."Indemnité imposable" <> 0 THEN
                    SalaryLine."Basis salary" :=
                       ROUND(Tchange.ExchangeAmtFCYToLCY(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"), Employee."Currency Code",
                          Employee."Indemnité imposable", Tchange.ExchangeRate(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"),
                          Employee."Currency Code")
              ) -
                          MntInd, ParamCpta."Amount Rounding Precision")
                ELSE
                    SalaryLine."Basis salary" :=
                         ROUND(Tchange.ExchangeAmtFCYToLCY(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"), Employee."Currency Code",
                          Employee."Basis salary", Tchange.ExchangeRate(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"), Employee."Currency Code")
              )
                          , ParamCpta."Amount Rounding Precision");

            END;
        END;
        //Salaire de base
        CASE SalaryLine."Employee's type" OF
            0:
                BEGIN
                    LigneAbsence.RESET;
                    LigneAbsence.SETCURRENTKEY("Employee No.", "Posting year", "Posting month", "Motif D'absence", Semaine, Quinzaine);
                    LigneAbsence.SETFILTER("Motif D'absence", '<>%1', 7);
                    LigneAbsence.SETFILTER("Employee No.", SalaryLine.Employee);
                    LigneAbsence.SETRANGE("Posting month", SalaryLine.Month);
                    LigneAbsence.SETRANGE("Posting year", SalaryLine.Year);
                    IF ParamRessHum."Activer régime quinzaine" THEN
                        IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN
                            LigneAbsence.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);
                    //<< DSFT AGA 140410
                    LigneAbsence.CALCSUMS(Quantity);
                    // MESSAGE(FORMAT( LigneAbsence.Quantity));
                    AbsEmp := LigneAbsence.Quantity;

                    SalaryLine."Assiduity (Paid days)" := (SalaryHeader."Paid days"
                                                             - SalaryLine.Absences
                                                             - SalaryLine."Adjustment of absences")
                                                             / SalaryHeader."Paid days"
                                                             * 100;
                    SalaryLine."Assiduity (Worked days)" := (SalaryHeader."Worked days"
                                                             - ABS(LigneAbsence.Quantity)
                                                             - ABS(SalaryLine."Days off")
                                                             //-   ABS(SalaryLine."Nbjour ferier")
                                                             - ABS(SalaryLine."Adjustment of absences"))
                                                             / SalaryHeader."Worked days"
                                                             * 100;



                    //CALCUL HEURES NORMALES
                    TotalNbrJourPanier := 0;
                    TotHeuresEnreg := 0;
                    Heuresoccaenregm.RESET;
                    Heuresoccaenregm.SETFILTER("N° Salarié", Employee."No.");
                    Heuresoccaenregm.SETFILTER("Mois de paiement", '%1', SalaryHeader.Month);
                    Heuresoccaenregm.SETFILTER("Année de paiement", '%1', SalaryHeader.Year);
                    //<< DSFT AGA 140410
                    IF ParamRessHum."Activer régime quinzaine" THEN
                        IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN
                            Heuresoccaenregm.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);
                    //<< DSFT AGA 140410
                    IF Heuresoccaenregm.FIND('-') THEN
                        REPEAT
                            TotHeuresEnreg := TotHeuresEnreg + Heuresoccaenregm."Nombre d'heures";
                            // >> HJ BF 21-01-2014 Appliquer Indemniter De Panier 3*nbrjourpanier* Smig Horaire
                            TotalNbrJourPanier += Heuresoccaenregm."Nombre Jours Prime Panier";
                        // >> HJ BF 21-01-2014  Appliquer Indemniter De Panier 3*nbrjourpanier* Smig Horaire
                        UNTIL Heuresoccaenregm.NEXT = 0;
                    //END CALCUL HEURES NORMALE 25/12/2008
                    IF Sim = 0 THEN
                        TotHeuresEnreg := GNbHeure;
                    // >> HJ BF 21-01-2014 Appliquer Indemniter De Panier 3*nbrjourpanier* Smig Horaire
                    SalaryLine."Nbr Jour Panier" := TotalNbrJourPanier;
                    // >> HJ BF 21-01-2014  Appliquer Indemniter De Panier 3*nbrjourpanier* Smig Horaire

                    SalaryLine."Worked hours" := TotHeuresEnreg;
                    //>>MBY 14/04/2009
                    IF (Pinverse = TRUE) THEN
                        SalaryLine."Basis salary" := Employee."Basis salary";
                    //<<MBY

                    IF GNbHeure > TotHeuresEnreg THEN
                        SalaryLine.Absences := GNbHeure - TotHeuresEnreg;

                    SalaryLine."Real basis salary" := ROUND(SalaryLine."Worked hours" * Employee."Basis salary",
                                                      ParamCpta."Amount Rounding Precision");
                    //>>MBY 14/04/2009
                    IF (Pinverse = FALSE) THEN
                        SalaryLine."Real basis salary" := ROUND(SalaryLine."Worked hours" * SalaryLine."Basis salary",
                                                        ParamCpta."Amount Rounding Precision");
                    //<<MBY
                    //>>DSFT AGA 10/03/10
                    SalaryLine."Assiduity (Paid days)" := (SalaryLine."Worked hours" / RegimeWork."Work Hours per month") * 100;
                    IF SalaryLine."Assiduity (Paid days)" > 100 THEN
                        SalaryLine."Assiduity (Paid days)" := 100;
                    //<<DSFT AGA 10/03/10


                END;
            1:
                BEGIN
                    SalaryLine."Basis hours" := LigneTravail."Nombre d'heures";
                    LigneAbsence.RESET;
                    LigneAbsence.SETCURRENTKEY("Employee No.", "Posting year", "Posting month", "Motif D'absence", Semaine, Quinzaine);
                    LigneAbsence.SETFILTER("Motif D'absence", '<>%1', 7);
                    LigneAbsence.SETFILTER("Employee No.", SalaryLine.Employee);
                    LigneAbsence.SETRANGE("Posting month", SalaryLine.Month);
                    LigneAbsence.SETRANGE("Posting year", SalaryLine.Year);
                    IF ParamRessHum."Activer régime quinzaine" THEN
                        IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN
                            LigneAbsence.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);
                    //<< DSFT AGA 140410

                    LigneAbsence.CALCSUMS(Quantity);
                    AbsEmp := LigneAbsence.Quantity;
                    TotJoursEnreg := 0;
                    TotalNbrJourPanier := 0;
                    Heuresoccaenregm.RESET;
                    Heuresoccaenregm.SETFILTER("N° Salarié", Employee."No.");
                    Heuresoccaenregm.SETFILTER("Mois de paiement", '%1', SalaryHeader.Month);
                    Heuresoccaenregm.SETFILTER("Année de paiement", '%1', SalaryHeader.Year);
                    //<< DSFT AGA 140410
                    IF ParamRessHum."Activer régime quinzaine" THEN
                        IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN
                            Heuresoccaenregm.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);
                    //<< DSFT AGA 140410

                    IF Heuresoccaenregm.FIND('-') THEN
                        REPEAT
                            TotJoursEnreg := TotJoursEnreg + Heuresoccaenregm."Nbre Jour";
                            // >> HJ BF 21-01-2014   Appliquer Indemniter De Panier 3*nbrjourpanier* Smig Horaire
                            TotalNbrJourPanier += Heuresoccaenregm."Nombre Jours Prime Panier";
                        // >> HJ BF 21-01-2014  Appliquer Indemniter De Panier 3*nbrjourpanier* Smig Horaire

                        UNTIL Heuresoccaenregm.NEXT = 0;
                    IF SalaryLine.Month = SalaryLine.Month::Prime THEN TotJoursEnreg := 30;
                    IF GNbJour >= TotJoursEnreg THEN
                        AbsEmp := GNbJour - TotJoursEnreg
                    ELSE BEGIN
                        AbsEmp := 0;
                    END;
                    //>>MBY 14/04/2009
                    IF Sim = 0 THEN
                        TotJoursEnreg := GNbJour;
                    //<<MBY
                    SalaryLine.Absences := AbsEmp;
                    // >> HJ BF 21-01-2014   Appliquer Indemniter De Panier 3*nbrjourpanier* Smig Horaire
                    SalaryLine."Nbr Jour Panier" := TotalNbrJourPanier;
                    // >> HJ BF 21-01-2014   Appliquer Indemniter De Panier 3*nbrjourpanier* Smig Horaire

                    SalaryLine."Paied days" := TotJoursEnreg;//-AbsEmp;
                                                             //END MBY
                    SalaryLine."Assiduity (Paid days)" := (SalaryHeader."Paid days"
                                                             - SalaryLine.Absences
                                                             - SalaryLine."Adjustment of absences")
                                                             / SalaryHeader."Paid days"
                                                             * 100;
                    SalaryLine."Assiduity (Worked days)" := (SalaryHeader."Worked days"
                                                             - ABS(LigneAbsence.Quantity)
                                                             - ABS(SalaryLine."Days off")
                                                             //-   ABS(SalaryLine."Nbjour ferier")
                                                             - ABS(SalaryLine."Adjustment of absences"))
                                                             / SalaryHeader."Worked days"
                                                             * 100;



                    //>>MBY 14/04/2009
                    IF (Pinverse = TRUE) THEN
                        SalaryLine."Basis salary" := Employee."Basis salary";
                    // AGA >> assiduité jour payé

                    //>>MBY 14/04/2009
                    IF (Pinverse = FALSE) THEN
                        SalaryLine."Real basis salary" := ROUND((TotJoursEnreg) * SalaryLine."Basis salary" / GNbJour
                                                                 , ParamCpta."Amount Rounding Precision");

                    //<<MBY


                    //>> DSFT AGA 01/05/2010   calcul des heures travaillées pour les salariers de type  mensuel horaire
                    IF EmploymentContract."Régime gardien/Chauffeur" THEN BEGIN
                        Heuresoccaenregm.RESET;
                        Heuresoccaenregm.SETFILTER("N° Salarié", Employee."No.");
                        Heuresoccaenregm.SETFILTER("Mois de paiement", '%1', SalaryHeader.Month);
                        Heuresoccaenregm.SETFILTER("Année de paiement", '%1', SalaryHeader.Year);
                        //<< DSFT AGA 140410
                        IF ParamRessHum."Activer régime quinzaine" THEN
                            IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN
                                Heuresoccaenregm.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);
                        //<< DSFT AGA 140410
                        IF Heuresoccaenregm.FIND('-') THEN
                            REPEAT
                                IF Heuresoccaenregm."Nombre d'heures" <> 0 THEN
                                    SalaryLine."Montant Heures" := SalaryLine."Basis hours" + Heuresoccaenregm."Montant ligne";
                            UNTIL Heuresoccaenregm.NEXT = 0;
                    END;
                    //<< DSFT AGA 01/05/2010

                END;
        END;
        //FIN CALCUL SALAIRE DE BASE

        // DSFT AGA 19/042010 // CALCUL PRIME DE RENDEMENT MENSUEL
        //>> DSFT AGA 19/04/2010
        IF (ParamRessHum."Appl. prime rendement mensuel") THEN BEGIN
            Employee.GET(SalaryLine.Employee);
            Employee.CALCFIELDS("Total Indemnité jour congé");

            // DecSalaireBrut:=Employee."Reel Basis salary"+ Employee."Total Indemnité jour congé";
            DecSalaireBrut := Employee."Basis salary";
            //DELETE SI EXISTE -->
            RecLIndemnities.RESET;
            RecLIndemnities.SETRANGE("No.", SalaryLine."No.");
            RecLIndemnities.SETRANGE("Employee No.", SalaryLine.Employee);
            RecLIndemnities.SETRANGE(Indemnity, ParamRessHum."Code ind.rend. Mensuel");
            IF RecLIndemnities.FIND('-') THEN
                RecLIndemnities.DELETE;

            //MODIFY SI EXISTE <--
            RecLDefaultindemnities.RESET;
            RecLDefaultindemnities.SETRANGE("Employment Contract Code", SalaryLine.Employee);
            RecLDefaultindemnities.SETRANGE("Indemnity Code", ParamRessHum."Code ind.rend. Mensuel");
            IF RecLDefaultindemnities.FIND('-') THEN BEGIN
                RecLDefaultindemnities."Default amount" := 0;

                EmploymentContract.GET(Employee."No.");
                RegimeWork.GET(EmploymentContract."Regimes of work");
                RecLDefaultindemnities."Employment Contract Code" := Employee."No.";
                RecLDefaultindemnities."Indemnity Code" := ParamRessHum."Code ind.rend. Mensuel";
                //RecLDefaultindemnities.VALIDATE("Indemnity Code");
                IF Employee."Employee's type" = 0 THEN
                    RecLDefaultindemnities."Default amount" := DecSalaireBrut * RecLDefaultindemnities.Taux / 100
                ELSE
                    RecLDefaultindemnities."Default amount" := DecSalaireBrut * RecLDefaultindemnities.Taux / 100;
                RecLDefaultindemnities.MODIFY;

                //MESSAGE(FORMAT(SalaryLine."droit de congé du mois"+SALR."Days off ="));
                RecLIndemnities."No." := SalaryLine."No.";
                RecLIndemnities."Employee No." := Employee."No.";
                RecLIndemnities.Indemnity := ParamRessHum."Code ind.rend. Mensuel";
                RecLIndemnities.VALIDATE(Indemnity);
                RecLIndemnities.Type := RecLDefaultindemnities.Type;
                RecLIndemnities."Type Indemnité" := RecLDefaultindemnities."Type Indemnité";
                IF EmploymentContract."Employee's type" = 0 THEN
                    RecLIndemnities."Base Amount" := DecSalaireBrut * RecLDefaultindemnities.Taux / 100
                ELSE
                    RecLIndemnities."Base Amount" := DecSalaireBrut * RecLDefaultindemnities.Taux / 100;

                RecLIndemnities."Real Amount" := RecLIndemnities."Base Amount";
                RecLIndemnities."User ID" := USERID;
                RecLIndemnities."Last Date Modified" := WORKDATE;
                RecLIndemnities."Employee Posting Group" := Employee."Employee Posting Group";
                RecLIndemnities.INSERT;
            END;

        END ELSE BEGIN
            RecLDefaultindemnities.RESET;
            RecLDefaultindemnities.SETRANGE("Employment Contract Code", SalaryLine.Employee);
            RecLDefaultindemnities.SETRANGE("Indemnity Code", ParamRessHum."Code ind.rend. Mensuel");
            IF RecLDefaultindemnities.FIND('-') THEN
                RecLDefaultindemnities."Default amount" := 0;
            RecLIndemnities.RESET;
            RecLIndemnities.SETRANGE("No.", SalaryLine."No.");
            RecLIndemnities.SETRANGE("Employee No.", SalaryLine.Employee);
            RecLIndemnities.SETRANGE(Indemnity, ParamRessHum."Code ind.rend. Mensuel");
            IF RecLIndemnities.FIND('-') THEN
                RecLIndemnities.DELETE;

        END;
        //<< DSFT AGA 19/04/2010
        // Calcul Indemnité
        IF Pinverse AND (SalaryLine.Month = SalaryLine.Month::Prime) THEN
            SalaryLine."Amount Days Off balacement" := 0;
        IF ParamRessHum."type calcul solde congé" = 1 THEN
            SalaryLine."Assiduity (Paid days)" := SalaryLine."Assiduity (Paid days)" + SalaryLine."Assiduity (days off balacement";

        // Calcul Indemnité
        CalcIndemnitéImp(SalaryLine);
        //>>DSFT AGA 18/03/2010

        // calcul droit de congé du mois
        HeureJourTravail.RESET;
        HeureJourTravail.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement", Quinzaine);
        HeureJourTravail.SETFILTER("N° Salarié", SalaryLine.Employee);
        HeureJourTravail.SETFILTER("Mois de paiement", '%1', SalaryLine.Month);
        HeureJourTravail.SETFILTER("Année de paiement", '%1', SalaryLine.Year);
        //>> DSFT AGA 140410
        IF ParamRessHum."Activer régime quinzaine" THEN
            IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN BEGIN
                HeureJourTravail.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);

            END;
        //<< DSFT AGA 140410
        HeureJourTravail.CALCSUMS("Nombre d'heures", "Montant ligne", "Nbre Jour");



        IF Employee."Employee's type" = 0 THEN
            SalaryLine."droit de congé du mois" := ROUND(RegimeWork."Days off per month" * HeureJourTravail."Nombre d'heures" /
                                                      RegimeWork."Work Hours per month", ParamCpta."Amount Rounding Precision")
        ELSE
            SalaryLine."droit de congé du mois" := ROUND(RegimeWork."Days off per month" * SalaryLine."Assiduity (Paid days)" / 100,
                                                            ParamCpta."Amount Rounding Precision");
        //>> DSFT AGA 09/03/2010
        IF SalaryLine."droit de congé du mois" > RegimeWork."Days off per month" THEN
            SalaryLine."droit de congé du mois" := RegimeWork."Days off per month";

        //<< DSFT AGA 09/03/2010
        IF (ParamRessHum."Calculer STC auto") THEN BEGIN
            Employee.GET(SalaryLine.Employee);
            Employee.CALCFIELDS("Days off =", "Total Indemnité jour congé");
            DecSalaireBrut := Employee."Reel Basis salary" + Employee."Total Indemnité jour congé";
            //DELETE SI EXISTE -->
            RecLIndemnities.RESET;
            RecLIndemnities.SETRANGE("No.", SalaryLine."No.");
            RecLIndemnities.SETRANGE("Employee No.", SalaryLine.Employee);
            RecLIndemnities.SETRANGE(Indemnity, ParamRessHum."Code solde congé");
            IF RecLIndemnities.FIND('-') THEN
                RecLIndemnities.DELETE;
            RecLDefaultindemnities.RESET;
            RecLDefaultindemnities.SETRANGE("Employment Contract Code", SalaryLine.Employee);
            RecLDefaultindemnities.SETRANGE("Indemnity Code", ParamRessHum."Code solde congé");
            IF RecLDefaultindemnities.FIND('-') THEN
                RecLDefaultindemnities.DELETE;
            //DELETE SI EXISTE <--
            IF (Employee."Inactive Date" <= SalaryHeader."Posting Date")
            AND (Employee."Inactive Date" > CALCDATE('-1M', SalaryHeader."Posting Date"))
            THEN BEGIN
                EmploymentContract.GET(Employee."No.");
                RegimeWork.GET(EmploymentContract."Regimes of work");
                RecLDefaultindemnities."Employment Contract Code" := Employee."No.";
                RecLDefaultindemnities."Indemnity Code" := ParamRessHum."Code solde congé";
                RecLDefaultindemnities.VALIDATE("Indemnity Code");

                IF EmploymentContract."Employee's type" = 0 THEN
                    RecLDefaultindemnities."Default amount" := (DecSalaireBrut / RegimeWork."Work Hours per month")
                                                                * ParamRessHum."From Work day to Work hour"
                                                                * (SalaryLine."droit de congé du mois" + SalaryLine."Days off remaining")
                ELSE
                    RecLDefaultindemnities."Default amount" := (DecSalaireBrut / RegimeWork."Worked Day Per Month")
                                                                * (SalaryLine."droit de congé du mois" + SalaryLine."Days off remaining");


                RecLDefaultindemnities.INSERT;
                //MESSAGE(FORMAT(SalaryLine."droit de congé du mois"+SALR."Days off ="));
                RecLIndemnities."No." := SalaryLine."No.";
                RecLIndemnities."Employee No." := Employee."No.";
                RecLIndemnities.Indemnity := ParamRessHum."Code solde congé";
                RecLIndemnities.VALIDATE(Indemnity);
                RecLIndemnities.Type := RecLDefaultindemnities.Type;
                RecLIndemnities."Type Indemnité" := RecLDefaultindemnities."Type Indemnité";
                IF EmploymentContract."Employee's type" = 0 THEN
                    RecLIndemnities."Base Amount" := (DecSalaireBrut / RegimeWork."Work Hours per month")
                                                                * ParamRessHum."From Work day to Work hour"
                                                                * (SalaryLine."droit de congé du mois" + SalaryLine."Days off remaining")
                ELSE
                    RecLIndemnities."Base Amount" := (DecSalaireBrut / RegimeWork."Worked Day Per Month")
                                                                * (SalaryLine."droit de congé du mois" + SalaryLine."Days off remaining");

                RecLIndemnities."Real Amount" := RecLIndemnities."Base Amount";
                RecLIndemnities."User ID" := USERID;
                RecLIndemnities."Last Date Modified" := WORKDATE;
                RecLIndemnities."Employee Posting Group" := Employee."Employee Posting Group";
                RecLIndemnities.INSERT;
                SalaryLine."Days off balacement" := -(SalaryLine."Days off remaining" + SalaryLine."droit de congé du mois");
                //  END;
            END;
        END;
        //<<DSFT AGA 18/03/2010

        //--> Calcul du salaire Brut du mois
        //  SalaryLine.CALCFIELDS("Montant Jours Fériés travaillé");
        "CalcInd&HsupNav"(SalaryLine, Sim);
        SalaryLine.CALCFIELDS("Montant Congé de maladie", "Montant accident de travail");

        SalaryLine."6 * SMIG" := ROUND(ParamRessHum."Minimum wage guarantee" * 6, ParamCpta."Amount Rounding Precision");
        IF (SalaryLine.Month = SalaryLine.Month::Prime) THEN
            SalaryLine."Assiduity (Paid days)" := 100;

        CASE SalaryLine."Employee's type" OF
            1:
                BEGIN
                    SalaryLine."Gross Salary (sans Av)" := ROUND((bonus * SalaryLine."Real basis salary")
                                                          + SalaryLine."Taxable indemnities (Not Gross"
                                                          + SalaryLine."Taxable indemnities"
                                                          + SalaryLine."Supp. hours"
                                                        //DSFT AGA 19/11/2010
                                                        + SalaryLine."Montant Jours Fériés travaillé"
                                                        + SalaryLine."Montant Congé de maladie"
                                                        + SalaryLine."Montant accident de travail"

                                                          , ParamCpta."Amount Rounding Precision");
                    IF Sim < 2 THEN
                        SalaryLine."Gross Salary (sans Av) PR" := ROUND((SalaryLine."Basis salary" - SalaryLine."Amount Days Off balacement"
                                                                  ) + SalaryLine."Taxable indemnities PR"
                                                                  , ParamCpta."Amount Rounding Precision") +
                                                                  SalaryLine."Taxable indem. PR (Not Gross)";
                    SalaryLine."Gross Salary" := SalaryLine."Gross Salary (sans Av)";
                    IF Sim < 2 THEN
                        SalaryLine."Gross Salary PR" := SalaryLine."Gross Salary (sans Av) PR";
                END;
            0:
                BEGIN
                    SalaryLine."Gross Salary (sans Av)" := ROUND((bonus * SalaryLine."Real basis salary")
                                                        + SalaryLine."Taxable indemnities (Not Gross"
                                                        + SalaryLine."Taxable indemnities"
                                                        + SalaryLine."Supp. hours"
                                                      //DSFT AGA 19/11/2010
                                                      + SalaryLine."Montant Jours Fériés travaillé"
                                                      + SalaryLine."Montant Congé de maladie"
                                                      + SalaryLine."Montant accident de travail"

                                                        , ParamCpta."Amount Rounding Precision");
                    IF Sim < 2 THEN
                        SalaryLine."Gross Salary (sans Av) PR" := ROUND((SalaryLine."Basis salary" - SalaryLine."Amount Days Off balacement")
                                                        + SalaryLine."Taxable indemnities PR" + SalaryLine."Taxable indem. PR (Not Gross)"
                                                        , ParamCpta."Amount Rounding Precision");
                    SalaryLine."Gross Salary" := SalaryLine."Gross Salary (sans Av)";
                    IF Sim < 2 THEN
                        SalaryLine."Gross Salary (sans Av) PR" := SalaryLine."Gross Salary (sans Av) PR";
                END;
        END;

        CalcIndemnitéAvNat(SalaryLine);
        "CalcInd&Hsup"(SalaryLine, Sim);

        CASE SalaryLine."Employee's type" OF
            1:
                BEGIN
                    LigneTravail.RESET;
                    LigneTravail.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement", Quinzaine, "Paiement No.");
                    LigneTravail.SETFILTER("N° Salarié", SalaryLine.Employee);
                    LigneTravail.SETRANGE("Mois de paiement", SalaryLine.Month);
                    LigneTravail.SETRANGE("Année de paiement", SalaryLine.Year);
                    //>> DSFT AGA 150410
                    //AGA ---------------------------------------------------------------------------------------
                    LigneTravail.SETFILTER("Paiement No.", '%1|%2', SalaryLine."No.", '');

                    IF ParamRessHum."Activer régime quinzaine" THEN
                        IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN BEGIN
                            LigneTravail.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);
                        END;
                    //<< DSFT AGA 150410
                    LigneTravail.CALCSUMS("Nombre d'heures", "Montant ligne", "Nbre Jour");
                    LigneTravail.MODIFYALL("Paiement No.", SalaryLine."No.");
                    SalaryLine."Basis hours" := LigneTravail."Nombre d'heures";
                    LigneTravailEnreg.RESET;
                    LigneTravailEnreg.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement", Quinzaine);
                    LigneTravailEnreg.SETFILTER("N° Salarié", SalaryLine.Employee);
                    LigneTravailEnreg.SETRANGE("Mois de paiement", SalaryLine.Month);
                    LigneTravailEnreg.SETRANGE("Année de paiement", SalaryLine.Year);
                    //>> DSFT AGA 150410
                    IF ParamRessHum."Activer régime quinzaine" THEN
                        IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN BEGIN
                            LigneTravailEnreg.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);
                        END;
                    //<< DSFT AGA 150410

                    LigneTravailEnreg.CALCSUMS("Nombre d'heures", "Montant ligne");
                    LigneAbsence.RESET;

                    SalaryLine."Gross Salary" := ROUND(
                                                           (SalaryLine."Real basis salary" * bonus)
                                                           + SalaryLine."Taxable indemnities"
                                                           + SalaryLine."Supp. hours"
                                                           + SalaryLine."Montant Jours Fériés travaillé"
                                                           //DSFT AGA 19/11/2010
                                                           + SalaryLine."Montant Congé de maladie"
                                                           + SalaryLine."Montant accident de travail"
                                                           //>> Régime mensuel horaires
                                                           + SalaryLine."Montant Heures",
                                                           ParamCpta."Amount Rounding Precision");
                    IF Sim < 2 THEN
                        SalaryLine."Gross Salary PR" := ROUND((bonus * SalaryLine."Real basis salary") + SalaryLine.
                                                               "Taxable indemnities PR", ParamCpta."Amount Rounding Precision");
                END;
            0:
                BEGIN
                    LigneTravail.RESET;
                    LigneTravail.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement", Quinzaine);
                    LigneTravail.SETFILTER("N° Salarié", SalaryLine.Employee);
                    LigneTravail.SETRANGE("Mois de paiement", SalaryLine.Month);
                    LigneTravail.SETRANGE("Année de paiement", SalaryLine.Year);
                    //AGA ---------------------------------------------------------------------------------------
                    LigneTravail.SETFILTER("Paiement No.", '%1|%2', SalaryLine."No.", '');

                    //>> DSFT AGA 150410
                    IF ParamRessHum."Activer régime quinzaine" THEN
                        IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN BEGIN
                            LigneTravail.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);
                        END;
                    //<< DSFT AGA 150410

                    LigneTravail.CALCSUMS("Nombre d'heures", "Montant ligne", "Nbre Jour");
                    LigneTravail.MODIFYALL("Paiement No.", SalaryLine."No.");
                    SalaryLine."Basis hours" := LigneTravail."Nombre d'heures";
                    LigneTravailEnreg.RESET;
                    LigneTravailEnreg.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement", Quinzaine);
                    LigneTravailEnreg.SETFILTER("N° Salarié", SalaryLine.Employee);
                    LigneTravailEnreg.SETRANGE("Mois de paiement", SalaryLine.Month);
                    LigneTravailEnreg.SETRANGE("Année de paiement", SalaryLine.Year);
                    //>> DSFT AGA 150410
                    IF ParamRessHum."Activer régime quinzaine" THEN
                        IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN BEGIN
                            LigneTravailEnreg.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);
                        END;
                    //<< DSFT AGA 150410

                    LigneTravailEnreg.CALCSUMS("Nombre d'heures", "Montant ligne");
                    LigneAbsence.RESET;
                    SalaryLine."Gross Salary" := ROUND(
                                                            (SalaryLine."Real basis salary" * bonus)
                                                           + SalaryLine."Taxable indemnities"
                                                           + SalaryLine."Supp. hours"
                                                           + SalaryLine."Montant Jours Fériés travaillé"
                                                           //DSFT AGA 19/11/2010
                                                           + SalaryLine."Montant Congé de maladie"
                                                           + SalaryLine."Montant accident de travail",
                                                           ParamCpta."Amount Rounding Precision");
                    IF Sim < 2 THEN
                        SalaryLine."Gross Salary PR" := ROUND((SalaryLine."Real basis salary" * bonus)
                                                               + SalaryLine."Taxable indemnities PR"
                                                               , ParamCpta."Amount Rounding Precision");
                END;
        END;
        // --> Calc Cotisation Social
        IF ParamRessHum."type calcul solde congé" = 0 THEN
            SalaryLine."Basis salary" := SalaryLine."Basis salary" - SalaryLine."Amount Days Off balacement";
        SalaryLine."Impot sur salaire" := SalaryLine."Gross Salary";
        SalaryLine."Revenu imposable" := SalaryLine."Gross Salary";
        SalaryLine."Taxable salary" := SalaryLine."Gross Salary";
        //CALCUL COTISATION SOCIAL
        CalcCotisationSocial1(SalaryLine);
        //--> Calcul du salaire imposable
        CalcAllTaxe(SalaryLine);

        // >> HJ BF 21-01-2014 CALCUL ABATTEMENT
        SalaryLine.Abattement := CalculerAbattement(SalaryLine, SalaryLine."No.", SalaryLine.Employee);
        // >> HJ BF 21-01-2014 CALCUL ABATTEMENT

        // >> HJ BF 21-01-2014 CALCUL EXONERATION
        SalaryLine.Exonération := ROUND(CalculerExoneration(SalaryLine."No.", SalaryLine.Employee, SalaryLine."Taxable salary"), 1);
        // >> HJ BF 21-01-2014 CALCUL EXONERATION
        // INFO : Taxable Salary=Salaire Brut
        // INFO : Non Taxable Soc. Contrib.=COTISATION SOCIAL

        // GERER Le 8% Pour La COTISATION
        CotisAvec8Pct := 0;
        CotisAvec8Pct := CalculerSalBasePlusSursalaire(SalaryLine, SalaryLine.Employee);
        // GERER Le 8% Pour La COTISATION

        SalaryLine."Salaire Net Imposable" := ROUND(SalaryLine."Taxable salary" - SalaryLine.Abattement - SalaryLine.Exonération
                                            - SalaryLine.CNSS, 1);
        SalaryLine."Base Imposable" := ROUND(SalaryLine."Taxable salary" - SalaryLine.CNSS, 1);

        // GERER Le 8% Pour La COTISATION
        IF SalaryLine.CNSS > CotisAvec8Pct THEN BEGIN
            SalaryLine."Base Imposable Avec 8%" := ROUND(SalaryLine."Taxable salary" - CotisAvec8Pct, 1);
            SalaryLine."Salaire Net Imposable Avec 8%" := ROUND(SalaryLine."Taxable salary" - SalaryLine.Abattement - SalaryLine.Exonération -
                                                CotisAvec8Pct, 1);
        END
        ELSE BEGIN
            SalaryLine."Base Imposable Avec 8%" := SalaryLine."Base Imposable";
            SalaryLine."Salaire Net Imposable Avec 8%" := ROUND(SalaryLine."Salaire Net Imposable", 1);
        END;
        // GERER Le 8% Pour La COTISATION


        SalaryLine.TPA := ROUND(SalaryLine."Gross Salary" * ParamRessHum."Taux TPA" / 100, 1);

        // CALCUL IUTS
        CalculIUTS(SalaryLine);

        IF EmploymentContract.Taxable = FALSE THEN SalaryLine."Taxable salary" := ROUND(SalaryLine."Gross Salary", 1);




        SalaryLine."Net salary" := ROUND(SalaryLine."Taxable salary" - SalaryLine.CNSS - SalaryLine."IUTS Net", 1);
        //MH Calcul Retenue FS
        SalaryLine."Retenue FSP" := 0;
        SalaryLine."Retenue SNP" := 0;

        RecEmployee2.RESET;
        RecEmployee2.SETRANGE("No.", SalaryLine.Employee);
        IF RecEmployee2.FINDFIRST THEN BEGIN
            IF RecEmployee2."Appliquer Retenue SNP" = TRUE THEN
                SalaryLine."Retenue SNP" := SalaryLine."Basis salary" * 1 / 6;
        END;

        RecHumanResourcesSetup.FINDFIRST;
        IF RecHumanResourcesSetup."Appliquer Retenue FSP" = TRUE THEN
            SalaryLine."Retenue FSP" := (SalaryLine."Net salary" * RecHumanResourcesSetup."Taux Retenue FSP") / 100;
        //MH Calcul Retenue FS
        //DSFT-AGA 16/08/2010 CALCUL INDEMNITE AVENTAGE EN NATURE
        Ind.RESET;
        Ind.SETCURRENTKEY("No.", "Employee No.", Indemnity, Type);
        Ind.SETRANGE("No.", SalaryLine."No.");
        Ind.SETRANGE("Employee No.", SalaryLine.Employee);
        Ind.SETRANGE(Type, Ind.Type::"Non imposable");
        Ind.CALCSUMS("Real Amount");


        IF Sim = 1 THEN
            IF SalaryHeader."Désactiver calcul des prêts" = FALSE THEN
                "Mgmt.ofLoansandAdvances".CréerLigneRembourcement(SalaryLine);
        SalaryLine."Net salary cashed" := ROUND(SalaryLine."Net salary"
                                                       - SalaryLine.Loans
                                                       - SalaryLine.Advances
                                                       + Ind."Real Amount" - SalaryLine."Retenue FSP"
                                                        - SalaryLine."Retenue SNP", 1);    // MH Calucl Retue FSP





        //>>MBY 14/04/2009
        IF SalaryLine."Net salary cashed" < 0 THEN
            MESSAGE('ATTENTION SALAIRE NEGATIF POUR L EMPLOYE : %1', SalaryLine.Employee);
        //<<MBY
        //arrondissement
        IF ParamRessHum."Montant Arrondi" > 0 THEN BEGIN
            EMP1.SETRANGE("No.", SalaryLine.Employee);
            IF SalaryLine."Net salary cashed" >= 0 THEN BEGIN

                SalaryLine."Report en -" := EMP1."Report Employee en -";
                SalaryLine."Net salary cashed" := SalaryLine."Net salary cashed";// - EMP1."Report Employee en -";
                SoldeReport := 0;
                V1 := SalaryLine."Net salary cashed" / 1000;
                V2 := ROUND(V1, 1) * 1000;
                SoldeReport := V2 - SalaryLine."Net salary cashed";
                IF SoldeReport <> 0 THEN BEGIN
                    SalaryLine."Net salary cashed" := V2;
                    IF SoldeReport > 0 THEN
                        SalaryLine."Ajout  en +" := ABS(SoldeReport)
                    ELSE
                        SalaryLine."Report en -" := ABS(SoldeReport);
                END;
            END;
        END;
        //======================= END ARRONDISSEMENT
        SalaryLine."User ID" := USERID;
        SalaryLine."Last Date Modified" := WORKDATE;

        IF (SalaryLine."Taxable salary" = 0) AND (SalaryLine."Net salary" <= 0) AND (Sim = 1) THEN
            DeleteLine(SalaryLine)
        ELSE
            SalaryLine.MODIFY;
        EXIT(SalaryLine."Net salary");
    end;


    procedure CalculerLigneConge(var SalaryLine: Record "Salary Lines"; "SolderDroitCongé": Boolean; Sim: Option Simulation,Real,Prime; nbjsolder: Decimal; Pinverse: Boolean): Decimal
    var
        SalaryHeader: Record "Salary Headers";
        Ind: Record "Indemnities";
        SocialContributions: Record "Social Contributions";
        ParamRessHum: Record 5218;
        EmploymentContract: Record 5211;
        RegimeWork: Record "Regimes of work";
        Employee: Record 5200;
        SliceImposition: Record "Slices of imposition";
        SliceImpositionX: Record "Slices of imposition";
        temp: Decimal;
        tmp: Decimal;
        tmp1: Decimal;
        Cot: Record "Default Soc. Contribution";
        nbr: Integer;
        bonus: Decimal;
        SalLineEng: Record "Rec. Salary Lines";
        EntEng: Record "Rec. Salary Headers";
        LigneTravail: Record "Heures occa. enreg. m";
        LigneTravailEnreg: Record "Heures sup. eregistrées m";
        WorkedD: Decimal;
        "Mgmt.ofLoansandAdvances": Codeunit "Mgmt. of Loans and Advances";
        droitconge: Record "Employee's days off Entry";
        SalLineEngTmp: Record "Rec. Salary Lines";
        MntInd: Decimal;
        DefaultIndemnitiesTmp: Record "Default Indemnities";
        SoldeReport: Decimal;
        SoldeReport1: Decimal;
        EMP1: Record 5200;
        LigneAbsence: Record "Employee's days off Entry";
        AbsEmp: Decimal;
        GNbJourConge: Decimal;
        GNbHeurConge: Decimal;
        V1: Decimal;
        V2: Decimal;
    begin
        SalaryHeader.GET(SalaryLine."No.");
        ParamRessHum.GET();
        IF NOT SolderDroitCongé THEN
            nbjsolder := 0;
        ParamCpta.GET;
        Employee.RESET;
        Employee.GET(SalaryLine.Employee);
        CLEAR(EmploymentContract);
        EmploymentContract.GET(Employee."Emplymt. Contract Code");
        RegimeWork.RESET;
        RegimeWork.GET(EmploymentContract."Regimes of work");
        initLigne(SalaryLine, Sim);
        GNbJour := RegimeWork."Worked Day Per Month";//ParamRessHum."Paid days";
        GNbHeure := RegimeWork."Work Hours per month";//ParamRessHum."Paid days"*ParamRessHum."From Work day to Work hour";
        //--> Soder droit congé
        IF Sim = 1 THEN
            CalcAbsence(SalaryLine);
        // CALCUL JOUR DE CONGE
        RecEmpDayOFF.RESET;
        RecEmpDayOFF.SETCURRENTKEY("Line type", "Employee No.", "Posting month", "Posting year");
        RecEmpDayOFF.SETFILTER("Employee No.", SalaryLine.Employee);
        RecEmpDayOFF.SETFILTER("Line type", '%1|%2', RecEmpDayOFF."Line type"::"Day off Right",
                                RecEmpDayOFF."Line type"::"Day off Consumption");
        //RecEmpDayOFF.SETRANGE("Payment No.",'');
        IF RecEmpDayOFF.FIND('-') THEN BEGIN
            RecEmpDayOFF.CALCSUMS("Quantity (Days)", Quantity, "Quantity (Hours)");
            SalaryLine."Days off remaining" := RecEmpDayOFF."Quantity (Days)";
            SalaryLine."Hours off Balacement" := RecEmpDayOFF."Quantity (Days)";
            GNbJourConge := RecEmpDayOFF."Quantity (Days)";
            GNbHeurConge := RecEmpDayOFF."Quantity (Hours)";

        END
        ELSE BEGIN
            GNbJourConge := 0;
            GNbHeurConge := 0;
        END;
        //>>DSFT AGA 09 03 10
        IF SalaryLine.Month = 16 THEN BEGIN
            GNbJourConge := SalaryLine."Days off remaining";
            GNbHeurConge := SalaryLine."Days off remaining" * RegimeWork."From Work day to Work hour";
            SalaryLine."Days off balacement" := -SalaryLine."Days off remaining";

        END;
        //<<DFT AGA 09 03 10
        /*IF SolderDroitCongé=true THEN BEGIN
            GNbJourConge := nbjsolder;
            GNbHeurConge := nbjsolder*RegimeWork."From Work day to Work hour";
            SalaryLine."Days off balacement":=-SalaryLine."Days off remaining";
        
        END;
        */
        ParamRessHum.TESTFIELD("Minimum wage guarantee");

        IF SalaryLine.Month < 12 THEN BEGIN
            IF (DATE2DMY(Employee."Employment Date", 3) = SalaryLine.Year) AND ((DATE2DMY(Employee."Employment Date", 2) - 1) = SalaryLine.Month)
            THEN
                SalaryLine."6 * SMIG" := ROUND(ParamRessHum."Minimum wage guarantee" * 6 *
                      (CALCDATE('+FM', Employee."Employment Date") - Employee."Employment Date" + 1), ParamCpta."Amount Rounding Precision")
            ELSE
                SalaryLine."6 * SMIG" := ROUND(ParamRessHum."Minimum wage guarantee" * 6, ParamCpta."Amount Rounding Precision");
        END;
        // --> Calcul des 2 param. d'assiduité
        MntInd := 0;
        IF Employee."Currency Code" <> '' THEN BEGIN
            DefaultIndemnitiesTmp.RESET;
            DefaultIndemnitiesTmp.SETFILTER("Employment Contract Code", Employee."Emplymt. Contract Code");
            DefaultIndemnitiesTmp.SETRANGE("Evaluation mode", 1, 2);
            DefaultIndemnitiesTmp.SETRANGE("Type Indemnité", 0);
            IF DefaultIndemnitiesTmp.FIND('-') THEN
                REPEAT
                    MntInd := MntInd + DefaultIndemnitiesTmp."Default amount";
                UNTIL DefaultIndemnitiesTmp.NEXT = 0;
        END;
        nbr := 12;
        EmploymentContract.RESET;
        Employee.RESET;
        Employee.GET(SalaryLine.Employee);
        EmploymentContract.GET(Employee."Emplymt. Contract Code");
        CASE ParamRessHum."Number of monthes" OF
            0:
                nbr := EmploymentContract."Regular payments";
            1:
                nbr := EmploymentContract."Temporary payments";
            2:
                nbr := EmploymentContract."Regular payments" + EmploymentContract."Temporary payments";
        END;
        IF RegimeWork.GET(SalaryLine."Employee Regime of work") THEN;
        IF ((Sim = 1) OR ((SalaryLine."Basis salary" = 0) AND (Sim = 0))) AND NOT ((Pinverse = TRUE) AND (SalaryLine."Basis salary" = 0)) THEN BEGIN
            IF SalaryLine."Posting Date" = 0D THEN
                SalaryLine."Posting Date" := WORKDATE;
            IF Employee."Currency Code" = '' THEN
                SalaryLine."Basis salary" := Employee."Basis salary"
            ELSE BEGIN
                IF Employee."Indemnité imposable" <> 0 THEN
                    SalaryLine."Basis salary" :=
                       ROUND(Tchange.ExchangeAmtFCYToLCY(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"), Employee."Currency Code",
                          Employee."Indemnité imposable", Tchange.ExchangeRate(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"),
                          Employee."Currency Code")
              ) -
                          MntInd, ParamCpta."Amount Rounding Precision")
                ELSE
                    SalaryLine."Basis salary" :=
                         ROUND(Tchange.ExchangeAmtFCYToLCY(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"), Employee."Currency Code",
                          Employee."Basis salary", Tchange.ExchangeRate(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"), Employee."Currency Code")
              )
                          , ParamCpta."Amount Rounding Precision");
            END;
        END;
        //Salaire de base
        CASE SalaryLine."Employee's type" OF
            0:
                BEGIN
                    IF ParamRessHum."Type calcul congé" = 0 THEN BEGIN
                        SalaryLine."Assiduity (Paid days)" := (GNbHeurConge / GNbHeure) * 100;
                        TotHeuresEnreg := GNbHeurConge;
                        SalaryLine."Worked hours" := TotHeuresEnreg;
                        SalaryLine."Basis salary" := Employee."Basis salary";
                        IF GNbHeure > TotHeuresEnreg THEN
                            SalaryLine.Absences := GNbHeure - TotHeuresEnreg;
                        SalaryLine."Real basis salary" := ROUND(SalaryLine."Worked hours" * Employee."Basis salary",
                                                          ParamCpta."Amount Rounding Precision");
                    END;
                    IF ParamRessHum."Type calcul congé" = 1 THEN BEGIN
                        TotHeuresEnreg := 0;
                        SalLineEng.RESET;
                        SalLineEng.SETCURRENTKEY(Year, Month, Employee, "No.", Imposable);
                        SalLineEng.SETFILTER(Employee, SalaryLine.Employee);
                        SalLineEng.SETFILTER(Year, '%1', SalaryLine.Year);
                        SalLineEng.CALCSUMS("Gross Salary");
                        SalaryLine."Real basis salary" := ROUND((SalLineEng."Gross Salary" / 13.71),
                                                             ParamCpta."Amount Rounding Precision");

                    END;
                END;
            1:
                BEGIN
                    IF ParamRessHum."Type calcul congé" = 0 THEN BEGIN

                        SalaryLine."Assiduity (Paid days)" := (GNbJourConge / GNbJour) * 100;
                        TotJoursEnreg := GNbJourConge;
                        SalaryLine."Paied days" := GNbJourConge;
                        SalaryLine."Basis salary" := Employee."Basis salary";
                        IF GNbJour > GNbJourConge THEN
                            SalaryLine.Absences := GNbJour - GNbJourConge;
                        SalaryLine."Real basis salary" := ROUND((GNbJourConge) * Employee."Basis salary" / GNbJour
                                                                 , ParamCpta."Amount Rounding Precision");
                    END;
                    IF ParamRessHum."Type calcul congé" = 1 THEN BEGIN
                        TotJoursEnreg := 0;
                        SalLineEng.RESET;
                        SalLineEng.SETCURRENTKEY(Year, Month, Employee, "No.", Imposable);
                        SalLineEng.SETFILTER(Employee, SalaryLine.Employee);
                        SalLineEng.SETFILTER(Year, '%1', SalaryLine.Year);
                        SalLineEng.CALCSUMS("Gross Salary");
                        SalaryLine."Real basis salary" := ROUND((SalLineEng."Gross Salary" / 13.71),
                                                             ParamCpta."Amount Rounding Precision");

                    END;

                END;

        END;
        //FIN CALCUL SALAIRE DE BASE
        IF ParamRessHum."Type calcul congé" = 0 THEN BEGIN
            // Calcul Indemnité
            IF Pinverse AND (SalaryLine.Month = SalaryLine.Month::Prime) THEN
                SalaryLine."Amount Days Off balacement" := 0;
            IF ParamRessHum."type calcul solde congé" = 1 THEN
                SalaryLine."Assiduity (Paid days)" := SalaryLine."Assiduity (Paid days)" + SalaryLine."Assiduity (days off balacement";
            CalcIndemnitéImp(SalaryLine);
            //--> Calcul du salaire Brut du mois

            "CalcInd&HsupNav"(SalaryLine, Sim);
            SalaryLine."6 * SMIG" := ROUND(ParamRessHum."Minimum wage guarantee" * 6, ParamCpta."Amount Rounding Precision");
            IF (SalaryLine.Month = SalaryLine.Month::Prime) THEN
                SalaryLine."Assiduity (Paid days)" := 100;
            CASE SalaryLine."Employee's type" OF
                1:
                    BEGIN
                        SalaryLine."Gross Salary (sans Av)" := ROUND((bonus * SalaryLine."Real basis salary")
                                                              + SalaryLine."Taxable indemnities (Not Gross"
                                                              + SalaryLine."Taxable indemnities"
                                                              + SalaryLine."Supp. hours", ParamCpta."Amount Rounding Precision");
                        IF Sim < 2 THEN
                            SalaryLine."Gross Salary (sans Av) PR" := ROUND((SalaryLine."Basis salary" - SalaryLine."Amount Days Off balacement"
                                                                      ) + SalaryLine."Taxable indemnities PR"
                                                                      , ParamCpta."Amount Rounding Precision") +
                                                                      SalaryLine."Taxable indem. PR (Not Gross)";
                        SalaryLine."Gross Salary" := SalaryLine."Gross Salary (sans Av)";
                        IF Sim < 2 THEN
                            SalaryLine."Gross Salary PR" := SalaryLine."Gross Salary (sans Av) PR";
                    END;
                0:
                    BEGIN
                        SalaryLine."Gross Salary (sans Av)" := ROUND((bonus * SalaryLine."Real basis salary")
                                                            + SalaryLine."Taxable indemnities (Not Gross"
                                                            + SalaryLine."Taxable indemnities"
                                                            + SalaryLine."Supp. hours", ParamCpta."Amount Rounding Precision");
                        IF Sim < 2 THEN
                            SalaryLine."Gross Salary (sans Av) PR" := ROUND((SalaryLine."Basis salary" - SalaryLine."Amount Days Off balacement")
                                                            + SalaryLine."Taxable indemnities PR" + SalaryLine."Taxable indem. PR (Not Gross)"
                                                            , ParamCpta."Amount Rounding Precision");
                        SalaryLine."Gross Salary" := SalaryLine."Gross Salary (sans Av)";
                        IF Sim < 2 THEN
                            SalaryLine."Gross Salary (sans Av) PR" := SalaryLine."Gross Salary (sans Av) PR";
                    END;
            END;
            // Calc Indemnité AV Nat

            CalcIndemnitéAvNat(SalaryLine);
            "CalcInd&Hsup"(SalaryLine, Sim);
        END;
        CASE SalaryLine."Employee's type" OF
            1:
                BEGIN
                    SalaryLine."Basis hours" := GNbHeurConge;
                    SalaryLine."Gross Salary" := ROUND(ROUND(SalaryLine."Real basis salary", ParamCpta."Amount Rounding Precision")
                                                           + ROUND(SalaryLine."Taxable indemnities", ParamCpta."Amount Rounding Precision")
                                                           , ParamCpta."Amount Rounding Precision");
                    IF Sim < 2 THEN
                        SalaryLine."Gross Salary PR" := ROUND((SalaryLine."Real basis salary") + SalaryLine.
                                                               "Taxable indemnities PR", ParamCpta."Amount Rounding Precision");
                END;
            0:
                BEGIN
                    SalaryLine."Basis hours" := GNbHeurConge;
                    SalaryLine."Gross Salary" := ROUND(ROUND(SalaryLine."Real basis salary", ParamCpta."Amount Rounding Precision")
                                                           + ROUND(SalaryLine."Taxable indemnities", ParamCpta."Amount Rounding Precision")
                                                           , ParamCpta."Amount Rounding Precision");
                    IF Sim < 2 THEN
                        SalaryLine."Gross Salary PR" := ROUND((SalaryLine."Real basis salary")
                                                               + SalaryLine."Taxable indemnities PR"
                                                               , ParamCpta."Amount Rounding Precision");
                END;
        END;
        // --> Calc Cotisation Social
        CalcCotisationSocial1(SalaryLine);
        //--> Calcul du salaire imposable
        CalcAllTaxe(SalaryLine);
        //A AJOUTER CONTROLE NON IMPOSABLE
        IF EmploymentContract.Taxable THEN
            SalaryLine."Taxable salary" := ROUND(SalaryLine."Gross Salary" - SalaryLine.CNSS +
                                               SalaryLine."Taxable indemnities (Not Gross"
                                                           , ParamCpta."Amount Rounding Precision");
        IF Sim < 2 THEN
            IF EmploymentContract.Taxable THEN
                SalaryLine."Taxable salary PR" := ROUND(SalaryLine."Gross Salary PR" - SalaryLine."Non Taxable Soc. Contrib. PR" +
                                                   SalaryLine."Taxable indem. PR (Not Gross)"
                                                             , ParamCpta."Amount Rounding Precision");
        // Calc Cotisation Social
        CalcCotisationSocial2(SalaryLine);
        //--> Calcul de l'imposable réel
        IF EmploymentContract.Taxable THEN BEGIN
            IF NOT Employee."Familly chief" THEN BEGIN
                SalaryLine."Deduction Family chief" := 0;
                SalaryLine."Deduction Loaded child" := 0;
            END;
            SalaryLine."Deduction Prof. expenses" := ROUND(ParamRessHum."% professional expenses"
                                                       * SalaryLine."Taxable salary");
            IF SalaryLine.Month < 13 THEN
                SalaryLine."Real taxable" := ROUND(SalaryLine."Taxable salary"
                                                         - SalaryLine."Deduction Family chief"
                                                         - SalaryLine."Deduction Loaded child"
                                                         - SalaryLine."Deduction Prof. expenses", ParamCpta."Amount Rounding Precision")
            ELSE
                SalaryLine."Real taxable" := ROUND(SalaryLine."Taxable salary"
                                                         - SalaryLine."Deduction Prof. expenses", ParamCpta."Amount Rounding Precision");

            IF (SalaryLine.Month < 13) OR (Sim = 2) THEN
                SalaryLine."Real taxable PR" := ROUND(SalaryLine."Taxable salary PR"
                                                         - SalaryLine."Deduction Family chief"
                                                         - SalaryLine."Deduction Loaded child"
                                                         - ROUND(SalaryLine."Taxable salary PR" * ParamRessHum."% professional expenses" / 100
                                                         , ParamCpta."Amount Rounding Precision"), ParamCpta."Amount Rounding Precision")
            ELSE
                SalaryLine."Real taxable PR" := ROUND(SalaryLine."Taxable salary PR"
                                                         - ROUND(SalaryLine."Taxable salary PR" * ParamRessHum."% professional expenses" / 100
                                                         , ParamCpta."Amount Rounding Precision"), ParamCpta."Amount Rounding Precision");
        END;

        //IMPOSABLE CONGE************************************
        SalaryLine."Salaire Impos. Ann. Conge" := 0;
        SalaryLine."Taux Tranche Impos. Conge" := 0;
        CASE SalaryLine."Employee's type" OF
            0:
                BEGIN
                    IF GNbHeurConge > 0 THEN
                        SalaryLine."Salaire Impos. Ann. Conge" := ROUND(
                        (SalaryLine."Taxable salary" / GNbHeurConge) * GNbHeure * 13, ParamCpta."Amount Rounding Precision")
                END;
            1:
                BEGIN
                    IF GNbJourConge > 0 THEN
                        SalaryLine."Salaire Impos. Ann. Conge" := ROUND(
                        (SalaryLine."Taxable salary" / GNbJourConge) * GNbJour * 13, ParamCpta."Amount Rounding Precision")
                END;
        END;
        IF SalaryLine."Deduction Family chief" > 0 THEN
            SalaryLine."Salaire Impos. Ann. Conge" := SalaryLine."Salaire Impos. Ann. Conge" - (SalaryLine."Deduction Family chief" * 12);
        IF SalaryLine."Deduction Loaded child" > 0 THEN
            SalaryLine."Salaire Impos. Ann. Conge" := SalaryLine."Salaire Impos. Ann. Conge" - (SalaryLine."Deduction Loaded child" * 12);
        SalaryLine."Salaire Impos. Ann. Conge" := SalaryLine."Salaire Impos. Ann. Conge" * 0.9;
        /*
        // Calcul Impôt Annuel
        //MBY SAMI ARRONDI AU DINAR SUP 18/01/2010
          DecVar := ROUND(SalaryLine."Salaire Impos. Ann. Conge",1)-SalaryLine."Salaire Impos. Ann. Conge";
          IF DecVar>0 THEN
            SalaryLine."Salaire Impos. Ann. Conge" := ROUND(SalaryLine."Salaire Impos. Ann. Conge",1)
          ELSE
            SalaryLine."Salaire Impos. Ann. Conge" := ROUND(SalaryLine."Salaire Impos. Ann. Conge"+1,1);
        //END MBY
        */
        IF EmploymentContract.Taxable THEN
            IF EmploymentContract."Calculation mode of the taxes" = 0 THEN BEGIN
                SliceImposition.RESET;
                SliceImposition.SETRANGE(Code, EmploymentContract."Slice of imposition");
                IF SliceImposition.FIND('-') THEN
                    REPEAT
                        IF ((SalaryLine."Salaire Impos. Ann. Conge" > SliceImposition."Lower limit")
                          AND (SalaryLine."Salaire Impos. Ann. Conge" < SliceImposition."Superior limit")) THEN
                            SalaryLine."Taux Tranche Impos. Conge" := SliceImposition.Rate;
                    UNTIL SliceImposition.NEXT = 0;
            END;
        //FIN IMPOSABLE CONGE***************************************************
        //--> Calcul de l'imposable réel par an
        SalLineEng.RESET;
        SalLineEng.SETCURRENTKEY(Year, Month, Employee, "No.", Imposable);
        SalLineEng.SETFILTER(Employee, SalaryLine.Employee);
        SalLineEng.SETFILTER(Year, '%1', SalaryLine.Year);
        //SalLineEng.SETFILTER("Non Taxable Soc. Contrib.",'>%1',0);
        SalLineEng.SETFILTER(Imposable, '%1', TRUE);
        SalLineEng.CALCSUMS("Real taxable", "Taxe (Month)");
        SalaryLine."Total taxable rec." := SalLineEng."Real taxable";
        SalaryLine."Total taxes rec." := SalLineEng."Taxe (Month)";
        SalaryLine."Rec. payments" := 0;
        SalLineEngTmp.RESET;
        SalLineEngTmp.SETCURRENTKEY(Year, Month, Employee, "No.", Imposable);
        SalLineEngTmp.SETFILTER(Employee, SalaryLine.Employee);
        SalLineEngTmp.SETFILTER(Year, '%1', SalaryLine.Year);
        // SalLineEngTmp.SETFILTER("Non Taxable Soc. Contrib.",'>%1',0);
        SalLineEngTmp.SETFILTER(Imposable, '%1', TRUE);
        SalLineEngTmp.SETFILTER(Month, '<%1', 12);
        SalLineEngTmp.CALCSUMS("Real taxable", "Taxe (Month)");
        //MBY 20/01/2009

        SalaryLine."Rec. payments" := SalLineEngTmp.COUNT;
        //--> Calcul de l'Imposable Réel
        // Calcul Impôt Annuel
        SalaryLine."Salaire Impos. Ann. Conge" := SalaryLine."Real taxable" * nbr;
        //MBY SAMI ARRONDI AU DINAR SUP 13/01/2009
        SalaryLine."Real taxable (Year)" := SalaryLine."Salaire Impos. Ann. Conge";
        DecVar := ROUND(SalaryLine."Real taxable (Year)", 1) - SalaryLine."Real taxable (Year)";
        IF DecVar > 0 THEN
            SalaryLine."Real taxable (Year)" := ROUND(SalaryLine."Real taxable (Year)", 1)
        ELSE
            SalaryLine."Real taxable (Year)" := ROUND(SalaryLine."Real taxable (Year)" + 1, 1);
        //END MBY

        CalcImpotAn(SalaryLine);
        // ERROR(FORMAT(NBR));

        IF (SalaryLine.Month > 12) AND (Sim <> 2) THEN BEGIN
            SalaryLine."Deduction Family chief" := 0;
            SalaryLine."Deduction Loaded child" := 0;
        END;
        // Calcul Impôt mensuel

        //>>SAMI
        //MBY SAMI ARRONDI AU DINAR SUP 13/01/2009
        DecIMPARRONDI := 0;
        DecIMPARRONDI := ROUND(SalaryLine."Taxable salary" * 0.9
                         , ParamCpta."Amount Rounding Precision");
        DecVar := ROUND(DecIMPARRONDI, 1) - DecIMPARRONDI;
        IF DecVar > 0 THEN
            DecIMPARRONDI := ROUND(DecIMPARRONDI, 1)
        ELSE
            DecIMPARRONDI := ROUND(DecIMPARRONDI + 1, 1);
        //END MBY

        // ANNULE CALCUL IMOT CONGE ANNUEL
        //SalaryLine."Taxe (Month)" := ROUND(DecIMPARRONDI*SalaryLine."Taux Tranche Impos. Conge"/100
        //                              ,ParamCpta."Amount Rounding Precision");
        SalaryLine."Taxe (Month)" := ROUND((SalaryLine."Taxe (Year)" / nbr)
                                      , ParamCpta."Amount Rounding Precision");

        SalaryLine."Net salary" := ROUND(SalaryLine."Gross Salary" - SalaryLine.CNSS +
                                   SalaryLine."Taxable indemnities (Not Gross"
                                 + SalaryLine."Non Taxable indemnities"
                                 + SalaryLine."Mission expenses"
                                 - SalaryLine."Taxe (Month)"
                                  , ParamCpta."Amount Rounding Precision");
        //MH Calcul Retenue FSP
        SalaryLine."Retenue FSP" := 0;
        SalaryLine."Retenue SNP" := 0;

        RecEmployee2.RESET;
        RecEmployee2.SETRANGE("No.", SalaryLine.Employee);
        IF RecEmployee2.FINDFIRST THEN BEGIN
            IF RecEmployee2."Appliquer Retenue SNP" = TRUE THEN
                SalaryLine."Retenue SNP" := SalaryLine."Basis salary" * 1 / 6;
        END;

        RecHumanResourcesSetup.FINDFIRST;
        IF RecHumanResourcesSetup."Appliquer Retenue FSP" = TRUE THEN
            SalaryLine."Retenue FSP" := (SalaryLine."Net salary" * RecHumanResourcesSetup."Taux Retenue FSP") / 100;

        //MH Calcul Retenue FSP
        IF Sim = 1 THEN
            "Mgmt.ofLoansandAdvances".CréerLigneRembourcement(SalaryLine);
        //SalaryLine.CALCFIELDS (Loans,Advances);
        SalaryLine."Net salary cashed" := ROUND(SalaryLine."Net salary"
                                                      - SalaryLine.Loans
                                                      - SalaryLine.Advances - SalaryLine."Retenue FSP"
                                                      - SalaryLine."Retenue SNP",    // MH Calucl Retue FSP
                                                      ParamCpta."Amount Rounding Precision");
        //arrondissement
        IF ParamRessHum."Montant Arrondi" > 0 THEN BEGIN
            EMP1.SETRANGE("No.", SalaryLine.Employee);
            IF EMP1.FIND('-') THEN BEGIN
                V1 := SalaryLine."Net salary cashed" / 1000;
                V2 := ROUND(V1, 1) * 1000;
                IF V2 >= SalaryLine."Net salary cashed" THEN
                    SalaryLine."Ajout  en +" := V2 - SalaryLine."Net salary cashed"
                ELSE
                    SalaryLine."Report en -" := ABS(V2 - SalaryLine."Net salary cashed");
                SalaryLine."Net salary cashed" := V2;
                /* SalaryLine."Report en -" := EMP1."Report Employee en -";
                 SalaryLine."Net salary cashed" :=V2;
                 SalaryLine."Net salary cashed" := SalaryLine."Net salary cashed" - EMP1."Report Employee en -";
                 SoldeReport := 0;
                 SoldeReport := ABS(SalaryLine."Net salary cashed" - ROUND(SalaryLine."Net salary cashed",1,'>'));
                 IF SoldeReport > ParamRessHum."Montant Arrondi" THEN
                   BEGIN
                     SoldeReport := SoldeReport - ParamRessHum."Montant Arrondi" ;
                     SalaryLine."Ajout  en +" := ABS(SoldeReport);
                     SalaryLine."Net salary cashed" := ABS(SalaryLine."Net salary cashed") + (ABS(SoldeReport)) ;
                 END
                 ELSE
                  BEGIN
                    SalaryLine."Ajout  en +" :=   ABS(SoldeReport);
                    SalaryLine."Net salary cashed" := ABS(SalaryLine."Net salary cashed") + (ABS(SoldeReport)) ;
                  END;*/
            END;
        END;
        //======================= END ARRONDISSEMENT
        SalaryLine."User ID" := USERID;
        SalaryLine."Last Date Modified" := WORKDATE;
        IF (SalaryLine."Taxable salary" = 0) AND (SalaryLine."Net salary" <= 0) THEN
            DeleteLine(SalaryLine)
        ELSE
            SalaryLine.MODIFY;
        EXIT(SalaryLine."Net salary");

    end;


    procedure EnregPaie(var SalaryHeader: Record "Salary Headers")
    var
        SalaryLines: Record "Salary Lines";
        Indemnities: Record "Indemnities";
        SocialContribution: Record "Social Contributions";
        RecSalaryHeader: Record "Rec. Salary Headers";
        RecSalaryLine: Record "Rec. Salary Lines";
        RecIndemnitie: Record "Rec. Indemnities";
        RecSocialContribution: Record "Rec. Social Contributions";
        EmployeeDaysOffEntry: Record "Employee's days off Entry";
        RecSuppHour: Record "Heures sup. eregistrées m";
        LoanAdvanceLine: Record "Loan & Advance Lines";
        LoanAdvanceHeader: Record "Loan & Advance Header";
        ExpenseRepayHeader: Record "Expenses to repay Header";
        MgmtLoansAdvances: Codeunit "Mgmt. of Loans and Advances";
        temp: Integer;
        ManagementAbsences: Codeunit "Management of absences";
        LoanAdvanceEntry: Record "Loan & Advance Entry";
        nbr: Integer;
        Wind: Dialog;
        h: Integer;
        cpt: Integer;
        Defind: Record "Default Indemnities";
        EmployeeDaysOffEntryTmp: Record "Employee's days off Entry";
        "Jourcongé": Decimal;
        LoanAdvanceHeaderTmp: Record "Loan & Advance Header";
    begin
        RecSalaryHeader.RESET;
        Wind.OPEN('Enregistrement de Paie  :  #1############### \' +
                    'Salarié  #2################################# \' +
                    'Avancement :                                 \' +
                    ' @3@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  ');
        //--> Création de l'en-tête
        Wind.UPDATE(1, SalaryHeader."No.");
        RecSalaryHeader.TRANSFERFIELDS(SalaryHeader);
        RecSalaryHeader."No." := SalaryHeader."No.";
        RecSalaryHeader.Description := SalaryHeader.Description;
        RecSalaryHeader.Month := SalaryHeader.Month;
        RecSalaryHeader.Year := SalaryHeader.Year;
        RecSalaryHeader."Paid days" := SalaryHeader."Paid days";
        RecSalaryHeader."Worked days" := SalaryHeader."Worked days";
        RecSalaryHeader."No. Series" := SalaryHeader."No. Series";
        RecSalaryHeader."Taxes regulation" := SalaryHeader."Taxes regulation";
        //>>DSFT AGA 26/04/2010
        RecSalaryHeader."Regime quinzaine" := SalaryHeader."Regime quinzaine";
        SalaryHeader.Quinzaine := SalaryHeader.Quinzaine;
        //<<DSFT AGA 26/04/2010
        RecSalaryHeader."User ID" := USERID;
        RecSalaryHeader."Last Date Modified" := WORKDATE;
        RecSalaryHeader.INSERT;
        //--> Création des lignes de salaire + Attribution des droits congé + Solder droit congé
        EmployeeDaysOffEntry.RESET;
        EmployeeDaysOffEntry.SETCURRENTKEY("Entry No.");
        IF EmployeeDaysOffEntry.FIND('+') THEN BEGIN
            temp := EmployeeDaysOffEntry."Transaction No." + 1;
            Temp1 := EmployeeDaysOffEntry."Entry No." + 1;
        END
        ELSE BEGIN
            temp := 1;
            Temp1 := 1;
        END;
        h := 0;
        RecSalaryLine.RESET;
        SalaryLines.SETRANGE("No.", SalaryHeader."No.");
        IF SalaryLines.FIND('-') THEN
            REPEAT
                h := h + 1;
                RecSalaryLine.RESET;
                Wind.UPDATE(2, SalaryLines.Employee + ' ' + SalaryLines.Name);
                cpt := ROUND(h / SalaryLines.COUNT, 0.01) * 10000;
                Wind.UPDATE(3, cpt);
                RecSalaryLine.TRANSFERFIELDS(SalaryLines);
                RecSalaryLine.Quarter := SalaryLines.Month DIV 3;
                IF SalaryLines.Month > 11 THEN
                    RecSalaryLine.Quarter := DATE2DMY(SalaryHeader."Posting Date", 2) DIV 3;
                RecSalaryLine."Montant Heures" := SalaryLines."Montant Heures";
                RecSalaryLine."Montant retenu caisse FS" := SalaryLines."Montant retenu caisse FS";
                RecSalaryLine."User ID" := USERID;
                RecSalaryLine."Last Date Modified" := WORKDATE;
                RecSalaryLine.Imposable := SalaryLines.Imposable;
                RecSalaryLine."Posting Date" := SalaryHeader."Posting Date";
                //REPORT
                EMP.RESET;
                EMP.GET(RecSalaryLine.Employee);
                //    EMP."Report Employee en -" := SalaryLines."Report en -";
                EMP."Report Employee en -" := SalaryLines."Ajout  en +";
                EMP.MODIFY;

                //>>MBY 12/02/2009
                //SPECIFIC SAMI **NE PAS INSERER ET SOLDER DROIT DE CONGE
                RecEmpDayOFF.RESET;
                RecEmpDayOFF.SETCURRENTKEY("Line type", "Employee No.", "Posting month", "Posting year");
                RecEmpDayOFF.SETFILTER("Employee No.", SalaryLines.Employee);
                RecEmpDayOFF.SETFILTER("Line type", '%1|%2', RecEmpDayOFF."Line type"::"Day off Right",
                RecEmpDayOFF."Line type"::"Day off Consumption");
                RecEmpDayOFF.SETRANGE("Payment No.", '');
                IF RecEmpDayOFF.FIND('-') THEN
                    REPEAT
                        RecEmpDayOFF."Payment No." := SalaryHeader."No.";
                        RecEmpDayOFF."Montant Ligne" := SalaryLines."Net salary cashed";
                        RecEmpDayOFF.Comptabiliser := TRUE;
                        RecEmpDayOFF."User ID" := USERID;
                        RecEmpDayOFF."Last Date Modified" := WORKDATE;
                        RecEmpDayOFF.MODIFY;
                    UNTIL RecEmpDayOFF.NEXT = 0;

                Jourcongé := 0;
                IF SalaryLines.Month < 12 THEN BEGIN// RK les paies add. n'attribue pas de congés
                    ManagementAbsences.AttribuerDroitCongé(temp, SalaryLines, Temp1, Jourcongé);

                    temp := temp + 1;
                    Temp1 := Temp1 + 1;
                    //>> DSFT AGA 29/03/2010 enregistrement  droit de congé ancienneté
                    ManagementAbsences.AttribuerDroitCongéAncienneté(temp, SalaryLines, Temp1, Jourcongé);
                    temp := temp + 1;
                    Temp1 := Temp1 + 1;
                    //<< DSFT AGA 29/03/2010
                    RecSalaryLine."Days off remaining" := SalaryLines."Days off remaining" + Jourcongé;
                    RecSalaryLine."Droit de congé ancienneté" := SalaryLines."Droit de congé ancienneté";
                END;
                IF (SalaryLines."Days off balacement" <> 0) THEN BEGIN
                    ManagementAbsences.SoderDroitCongé(temp, SalaryLines);
                    temp := temp + 1;
                    Temp1 := Temp1 + 1;
                END;
                //<<MBY 12/02/2009
                IF RecSalaryLine.INSERT THEN
                    SalaryLines.DELETE;
            UNTIL SalaryLines.NEXT = 0;
        //MBY 12-06-07 -MSF
        EMP.SETRANGE("No.", SalaryLines.Employee);
        EMP."Indemnité imposable" := SalaryLines."Gross Salary";
        EMP.MODIFY;
        //end MBY
        T2.RESET;
        T2.SETCURRENTKEY(Status, "Not include", "No.");
        T2.SETRANGE(Status, 0);
        T2.SETRANGE("Not include", TRUE);
        T2.MODIFYALL("Not include", FALSE);
        Wind.CLOSE;
        Wind.OPEN('Enregistrement des Indemnités :                \' +
                    'Salarié  #2################################# \' +
                    'Indemnité  #4############################### \' +
                    'Avancement :                                 \' +
                    ' @3@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  ');
        h := 0;
        //
        LoanAdvanceHeaderTmp.RESET;
        LoanAdvanceHeaderTmp.SETCURRENTKEY(Status, "Not include", "No.");
        LoanAdvanceHeaderTmp.SETRANGE(Status, 0);
        LoanAdvanceHeaderTmp.SETRANGE("Not include", TRUE);
        LoanAdvanceHeaderTmp.MODIFYALL("Not include", FALSE);
        //>>DSFT AGA 11/03/2010
        LoanAdvanceHeaderTmp.RESET;
        LoanAdvanceHeaderTmp.SETCURRENTKEY(Status, "Not include", "No.");
        LoanAdvanceHeaderTmp.SETRANGE(Status, 0);
        LoanAdvanceHeaderTmp.SETRANGE("Double tranche", TRUE);
        LoanAdvanceHeaderTmp.MODIFYALL("Double tranche", FALSE);
        //<<DSFT AGA 11/03/2010
        //--> Création des lignes d'indemnité  Status,Not include,No.

        Indemnities.SETRANGE("No.", SalaryHeader."No.");
        IF Indemnities.FIND('-') THEN
            REPEAT
                RecIndemnitie.INIT;
                Wind.UPDATE(2, Indemnities."Employee No.");
                h := h + 1;
                cpt := ROUND(h / Indemnities.COUNT, 0.01) * 10000;
                Wind.UPDATE(4, Indemnities.Indemnity + ' ' + Indemnities.Description);
                Wind.UPDATE(3, cpt);

                RecIndemnitie."No." := Indemnities."No.";
                RecIndemnitie."Employee No." := Indemnities."Employee No.";
                RecIndemnitie.Indemnity := Indemnities.Indemnity;
                RecIndemnitie."Employee Posting Group" := Indemnities."Employee Posting Group";
                //MBY 12/02/2010
                RecIndemnitie.direction := Indemnities.direction;
                RecIndemnitie.service := Indemnities.service;
                RecIndemnitie.section := Indemnities.section;
                //MBY 12/02/2010
                RecIndemnitie."Employee Statistic Group" := Indemnities."Employee Statistic Group";
                RecIndemnitie.Description := Indemnities.Description;
                RecIndemnitie.Type := Indemnities.Type;
                RecIndemnitie."Evaluation mode" := Indemnities."Evaluation mode";
                RecIndemnitie."Base Amount" := Indemnities."Base Amount";
                RecIndemnitie."Real Amount" := Indemnities."Real Amount";
                RecIndemnitie.Rate := Indemnities.Rate;
                RecIndemnitie."Minimum value" := Indemnities."Minimum value";
                RecIndemnitie.Taux := Indemnities.Taux;
                RecIndemnitie.Année := SalaryHeader.Year;
                //RK
                RecIndemnitie."Global dimension 1" := Indemnities."Global Dimension 1";
                RecIndemnitie."Global dimension 2" := Indemnities."Global Dimension 2";
                //RK
                RecIndemnitie."Type Indemnité" := Indemnities."Type Indemnité";
                RecIndemnitie."User ID" := USERID;
                RecIndemnitie."Last Date Modified" := WORKDATE;
                RecIndemnitie."Precision Arrondi Montant" := Indemnities."Precision Arrondi Montant";
                RecIndemnitie."Direction Arrondi" := Indemnities."Direction Arrondi";
                RecIndemnitie."Non Inclus en Prime" := Indemnities."Non Inclus en Prime";
                RecIndemnitie."Non Inclue en jours congé" := Indemnities."Non Inclue en jours congé";
                RecIndemnitie."Real Amount PR" := Indemnities."Real Amount PR";
                RecIndemnitie."Avantage en nature" := Indemnities."Avantage en nature";
                RecIndemnitie."Compte indemnité" := Indemnities."Compte indemnité";
                RecIndemnitie."Compte contre partie indemnité" := Indemnities."Compte contre partie indemnité";
                // MESSAGE('RecIndemnitie.Indemnity %1',RecIndemnitie.Indemnity);
                RecIndemnitie."Nombre de jours" := Indemnities."Nombre de jours";
                RecIndemnitie."Non déductible accident de Tra" := Indemnities."Non déductible accident de Tra";

                IF RecIndemnitie.INSERT THEN
                    Indemnities.DELETE;

            UNTIL Indemnities.NEXT = 0;
        //MBY INIT IND PANIER SAMI 12/01/2009==============================================
        IF RecGhumainressource.GET THEN
            IF RecGIndemnity.GET(RecGhumainressource."Default Panier") THEN BEGIN
                DecGDefaultPanier := RecGIndemnity."Default amount";
                Defind.RESET;
                Defind.SETRANGE("Indemnity Code", RecGhumainressource."Default Panier");
                IF Defind.FIND('-') THEN
                    REPEAT
                        //Defind."Default amount" := DecGDefaultPanier;
                        Defind.Taux := 0;
                        Defind.MODIFY;
                    UNTIL Defind.NEXT = 0
            END;
        //END MBY INIT IND PANIER SAMI=====================================================
        //--> Création des lignes de cotisations sociales
        Wind.CLOSE;

        Wind.OPEN('Enregistrement des cotisations sociales :      \' +
                    'Salarié  #2################################# \' +
                    'cotisations  #4############################### \' +
                    'Avancement :                                 \' +
                    ' @3@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  ');
        h := 0;
        SocialContribution.SETRANGE("No.", SalaryHeader."No.");

        IF SocialContribution.FIND('-') THEN
            REPEAT
                Wind.UPDATE(2, SocialContribution.Employee);
                h := h + 1;
                cpt := ROUND(h / SocialContribution.COUNT, 0.01) * 10000;
                Wind.UPDATE(4, SocialContribution."Social Contribution" + ' ' + SocialContribution.Description);
                Wind.UPDATE(3, cpt);

                RecSocialContribution.RESET;
                RecSocialContribution.INIT;
                RecSocialContribution."No." := SocialContribution."No.";
                RecSocialContribution.Employee := SocialContribution.Employee;
                RecSocialContribution.Indemnity := SocialContribution.Indemnity;
                RecSocialContribution."Basis of calculation" := SocialContribution."Basis of calculation";
                RecSocialContribution."year of Calculate" := SocialContribution."year of Calculate";
                RecSocialContribution."Social Contribution" := SocialContribution."Social Contribution";
                RecSocialContribution."Employee Posting Group" := SocialContribution."Employee Posting Group";
                RecSocialContribution."Employee Statistic Group" := SocialContribution."Employee Statistic Group";
                //MBY 12/02/2010
                RecSocialContribution.direction := SocialContribution.direction;
                RecSocialContribution.service := SocialContribution.service;
                RecSocialContribution.section := SocialContribution.section;
                RecSocialContribution."Posting date" := RecSalaryHeader."Posting Date";
                //MBY 12/02/2010
                RecSocialContribution.Description := SocialContribution.Description;
                RecSocialContribution."Employer's part" := SocialContribution."Employer's part";
                RecSocialContribution."Employee's part" := SocialContribution."Employee's part";
                RecSocialContribution."Base Amount" := SocialContribution."Base Amount";
                RecSocialContribution."Real Amount : Employee" := SocialContribution."Real Amount : Employee";
                RecSocialContribution."Real Amount : Employer" := SocialContribution."Real Amount : Employer";
                RecSocialContribution."Deductible of taxable basis" := SocialContribution."Deductible of taxable basis";
                //RK
                RecSocialContribution."Globla dimension 1" := SocialContribution."Global Dimension 1";
                RecSocialContribution."Global dimension 2" := SocialContribution."Global Dimension 2";
                //RK
                RecSocialContribution."Maximum value - Employee" := SocialContribution."Maximum value - Employee";
                RecSocialContribution."Maximum value - Employer" := SocialContribution."Maximum value - Employer";
                RecSocialContribution."6 * Smig" := SocialContribution."6 * Smig";
                RecSocialContribution.Année := SalaryHeader.Year;
                RecSocialContribution."User ID" := USERID;
                RecSocialContribution."Last Date Modified" := WORKDATE;
                RecSocialContribution."year of Calculate" := SalaryHeader."year of Calculate";
                RecSocialContribution."inclus en compta" := SocialContribution."inclus en compta";
                IF RecSocialContribution.INSERT THEN
                    SocialContribution.DELETE;

            UNTIL SocialContribution.NEXT = 0;

        RecSalaryLine.RESET;
        SalaryLines.SETRANGE("No.", SalaryHeader."No.");
        Indemnities.RESET;
        Indemnities.SETRANGE("No.", SalaryHeader."No.");
        SocialContribution.RESET;
        SocialContribution.SETRANGE("No.", SalaryHeader."No.");

        // Modification des lignes connexes : Absences, Heures de travail, P&A, Frais

        EmployeeDaysOffEntry.SETRANGE("Posting month", SalaryHeader.Month);
        EmployeeDaysOffEntry.SETRANGE("Posting year", SalaryHeader.Year);
        IF EmployeeDaysOffEntry.FIND('-') THEN
            REPEAT
                EmployeeDaysOffEntry."Payment No." := SalaryHeader."No.";
                EmployeeDaysOffEntry.MODIFY;
            UNTIL EmployeeDaysOffEntry.NEXT = 0;

        RecSuppHour.SETRANGE("Mois de paiement", SalaryHeader.Month);
        RecSuppHour.SETRANGE("Année de paiement", SalaryHeader.Year);
        IF RecSuppHour.FIND('-') THEN
            REPEAT
                //AGA 18/08/2010

                // AGA------------------------------------------------------------------------------------------
                IF (RecSuppHour."Paiement No." = SalaryHeader."No.") OR (RecSuppHour."Paiement No." = '') THEN BEGIN
                    RecSuppHour."Paiement No." := SalaryHeader."No.";
                    RecSuppHour.MODIFY;
                END

            UNTIL RecSuppHour.NEXT = 0;

        LoanAdvanceLine.SETRANGE(Status, 0);
        LoanAdvanceLine.SETRANGE("Payment No.", SalaryHeader."No.");
        IF LoanAdvanceLine.FIND('-') THEN
            REPEAT
                LoanAdvanceLine.Paid := TRUE;
                LoanAdvanceLine.MODIFY;

                LoanAdvanceEntry.SETRANGE("No.", LoanAdvanceLine."No.");
                LoanAdvanceEntry.ASCENDING(TRUE);
                IF LoanAdvanceEntry.FIND('+') THEN
                    nbr := LoanAdvanceEntry."Entry No." + 1
                ELSE
                    nbr := 1;

                LoanAdvanceEntry.RESET;
                LoanAdvanceEntry."No." := LoanAdvanceLine."No.";
                LoanAdvanceEntry."Entry No." := nbr;
                LoanAdvanceEntry.Employee := LoanAdvanceLine.Employee;
                IF LoanAdvanceHeader.GET(LoanAdvanceLine."No.") THEN
                    LoanAdvanceEntry.Name := LoanAdvanceHeader.Name;
                LoanAdvanceEntry."Employee Posting Group" := LoanAdvanceLine."Employee Posting Group";
                //MBY 12/02/2010
                LoanAdvanceEntry.direction := LoanAdvanceLine.direction;
                LoanAdvanceEntry.service := LoanAdvanceLine.service;
                LoanAdvanceEntry.section := LoanAdvanceLine.section;
                //MBY 12/02/2010
                // RK
                LoanAdvanceEntry."Global dimension 1" := LoanAdvanceLine."Global dimension 1";
                LoanAdvanceEntry."Global dimension 2" := LoanAdvanceLine."Global dimension 2";
                // RK
                LoanAdvanceEntry.Month := LoanAdvanceLine.Month;
                LoanAdvanceEntry.Year := LoanAdvanceLine.Year;
                LoanAdvanceEntry."Date Paie" := LoanAdvanceLine."Date Paie";
                LoanAdvanceEntry."Payment No." := LoanAdvanceLine."Payment No.";
                LoanAdvanceEntry.Type := LoanAdvanceLine.Type;
                LoanAdvanceEntry."Document type" := LoanAdvanceLine."Document type";
                LoanAdvanceEntry."Entry type" := 1;
                LoanAdvanceEntry.Amount := -LoanAdvanceLine."Line Amount";
                LoanAdvanceEntry.Status := LoanAdvanceLine.Status;
                LoanAdvanceEntry."User ID" := USERID;
                LoanAdvanceEntry."Last Date Modified" := WORKDATE;
                LoanAdvanceEntry.INSERT;

                IF LoanAdvanceHeader.GET(LoanAdvanceLine."No.") THEN
                    MgmtLoansAdvances.CloturerDocument(LoanAdvanceHeader);

            UNTIL LoanAdvanceLine.NEXT = 0;

        ExpenseRepayHeader.SETRANGE("Payment month", SalaryHeader.Month);
        ExpenseRepayHeader.SETRANGE("Payment year", SalaryHeader.Year);
        ExpenseRepayHeader.SETRANGE(Status, 1);
        ExpenseRepayHeader.SETRANGE(Repaied, FALSE);

        IF ExpenseRepayHeader.FIND('-') THEN
            REPEAT
                ExpenseRepayHeader.Repaied := TRUE;
                ExpenseRepayHeader."Payment No." := SalaryHeader."No.";
                ExpenseRepayHeader.MODIFY;
            UNTIL ExpenseRepayHeader.NEXT = 0;
        Wind.CLOSE;

        UpdateEmpContrat();
    end;


    procedure DeleteLine(var SalaryLine: Record "Salary Lines")
    var
        Indemnities: Record "Indemnities";
        SocialContribution: Record "Social Contributions";
        LoanAdvanceLines: Record "Loan & Advance Lines";
    begin
        Indemnities.SETRANGE("No.", SalaryLine."No.");
        Indemnities.SETRANGE("Employee No.", SalaryLine.Employee);
        IF Indemnities.FIND('-') THEN
            Indemnities.DELETEALL;

        SocialContribution.SETRANGE("No.", SalaryLine."No.");
        SocialContribution.SETRANGE(Employee, SalaryLine.Employee);
        IF SocialContribution.FIND('-') THEN
            SocialContribution.DELETEALL;

        LoanAdvanceLines.SETRANGE("Payment No.", SalaryLine."No.");
        LoanAdvanceLines.SETRANGE(Employee, SalaryLine.Employee);
        LoanAdvanceLines.SETRANGE(Paid, FALSE);
        IF LoanAdvanceLines.FIND('-') THEN
            LoanAdvanceLines.DELETEALL;

        SalaryLine.DELETE;
    end;


    procedure PaieInverseFeuilleCalcul(var LigneSalaire: Record "Salary Lines"; SBDepart: Decimal; NetVoulu: Decimal; Sim: Option Simulation,Real)
    var
        Empl: Record 5200;
        Line: Record "Salary Lines";
        Coef: Decimal;
        Ecart: Decimal;
        w: Dialog;
        temp: Decimal;
        applyNewBS: Label 'Apply new Basis salary value';
        Indm: Record "Indemnities";
        paramRSH: Record 5218;
        Def: Record "Indemnity";
        Defaultindem: Record "Default Indemnities";
        EmpContract: Record 5211;
        RegWork: Record "Regimes of work";
        FunctIndemAmount: Decimal;
        TEXT002: Label 'Le nouveau salaire de base est inférieur au Salaire de Base(Grille de Salaire) renseigner au niveau de la fiche signalitique.';
        Indemnites: Record "Indemnities";
        LePas: Integer;
    begin
        ParamCpta.GET;
        paramRSH.GET();
        w.OPEN('Procédure de calcul inverse en cours :\' +
                '####################################1#\' +
                'Sursalaire : ##################2#\' +
                'Salaire net     : ##################3#');
        //Line.SETRANGE ("No.",LigneSalaire."No.");
        //Line.SETRANGE (Employee,LigneSalaire.Employee);
        Line.RESET;
        Line.SETRANGE("No.", 'SIMULATION');
        Line.SETRANGE(Employee, LigneSalaire.Employee);
        IF Line.FIND('-') THEN;
        BonnePlage := FALSE;
        Plage1 := 0;
        LePas := 100;
        NetVoulu := Line."Net salary";
        Defaultindem.RESET;
        Defaultindem.SETRANGE("Employment Contract Code", Line.Employee);
        Defaultindem.SETRANGE("Indemnity Code", paramRSH."Indem Sursalaire");
        IF Defaultindem.FIND('-') THEN SBDepart := Defaultindem."Default amount";
        WHILE NOT BonnePlage DO BEGIN
            Plage1 += 100;
            Indemnites.RESET;
            Indemnites.SETRANGE("No.", Line."No.");
            Indemnites.SETRANGE("Employee No.", Line.Employee);
            Indemnites.SETRANGE(Indemnity, paramRSH."Indem Sursalaire");
            IF Indemnites.FIND('-') THEN BEGIN
                Indemnites."Base Amount" := Plage1;
                Indemnites.MODIFY;
            END;
            temp := ROUND(CalculerLigneSalaire(Line, FALSE, 0, 0, FALSE), 1);
            Ecart := temp - NetVoulu;
            IF (Ecart >= 0) AND (Ecart < 100) THEN BonnePlage := TRUE;
            IF Ecart > 0 THEN LePas := -100 ELSE LePas := 100;
            w.UPDATE(1, Line."No." + ' - ' + Line.Employee + ' : ' + Line.Name);
            w.UPDATE(2, ROUND(Ecart, 1));
            w.UPDATE(3, ROUND(temp, 1));

        END;
        Defaultindem.RESET;
        Defaultindem.SETRANGE("Employment Contract Code", Line.Employee);
        Defaultindem.SETRANGE("Indemnity Code", paramRSH."Indem Sursalaire");
        IF Defaultindem.FIND('-') THEN BEGIN
            IF Line.Prime THEN Defaultindem."Ancien Sursalaire" := Defaultindem."Default amount";
            Defaultindem."Default amount" := Plage1;
            Defaultindem.MODIFY;
        END;

        MESSAGE('traitement terminée');


        w.CLOSE;
        CalculerLigneSalaire(Line, FALSE, 0, 0, FALSE);
    end;


    procedure "CréerSimulationPaie"(Employee: Record 5200)
    var
        SalaryHeader: Record "Salary Headers";
        EmploymentContract: Record 5211;
        RegimesWork: Record "Regimes of work";
        SalaryLine: Record "Salary Lines";
        HumanResourceSetup: Record 5218;
        Defaultindem: Record "Default Indemnities";
        EMPL: Record 5200;
    begin
        HumanResourceSetup.GET();

        IF NOT SalaryHeader.GET('SIMULATION') THEN BEGIN
            SalaryHeader."No." := 'SIMULATION';

            SalaryHeader.Description := 'SIMULATION';
            SalaryHeader.Month := 0;
            SalaryHeader.Year := DATE2DMY(TODAY, 3);
            SalaryHeader."Paid days" := HumanResourceSetup."Paid days";
            SalaryHeader."Worked days" := HumanResourceSetup."Worked days";
            SalaryHeader."Posting Date" := TODAY;

            SalaryHeader.INSERT;
        END;

        SalaryLine.SETRANGE("No.", 'SIMULATION');
        SalaryLine.SETRANGE(Employee, Employee."No.");
        IF NOT SalaryLine.FIND('-') THEN
            CréerLigneSalaire(SalaryHeader, Employee, 0);   /// ANCIEN 0

        SalaryLine.RESET;
        SalaryLine.SETRANGE("No.", 'SIMULATION');
        SalaryLine.SETRANGE(Employee, Employee."No.");
        IF SalaryLine.FIND('-') THEN
            CalculerLigneSalaire(SalaryLine, FALSE, 0, 0, FALSE);// ANCIEN 0
    end;


    procedure CalculerFieldsPaie(var SalaryLineTmp: Record "Salary Lines"; Sim: Option Simulation,Real)
    var
        SuppHourLine: Record "Heures sup. eregistrées m";
        Indem: Record "Indemnities";
    begin
        // NE

        IF Sim = 1 THEN
            CalcAbsence(SalaryLineTmp);
        "CalcInd&Hsup"(SalaryLineTmp, Sim);
        //end;
        CalcAllTaxe(SalaryLineTmp);

        IF (SalaryLineTmp.Month < 12) AND (Sim = 1) THEN
            CalcLoanadv(SalaryLineTmp);
    end;


    procedure CalcAbsence(var SalaryLineTmp: Record "Salary Lines")
    var
        EmployeDayOff: Record "Employee's days off Entry";
        SuppHourLine: Record "Heures sup. eregistrées m";
        T1: Record 5211;
        T2: Record "Regimes of work";
        T3: Record 5200;
        EntSal: Record "Salary Headers";
        SalaryLineeng: Record "Rec. Salary Lines";
        DateJ: Date;
        CalendarMgmt: Codeunit 7600;
        Nonworking: Boolean;
        Contrat: Record 5211;
        JF: Boolean;
        Regim: Record "Regimes of work";
        X: Integer;
        //   HeureTravail: Record 50001;
        EntSalEng: Record "Rec. Salary Headers";
        ParamRessHum: Record 5218;
        SalaryLineengTmp: Record "Rec. Salary Lines";
    begin
        SalaryLineTmp."Days off remaining" := 0;
        ParamRessHum.GET;
        SalaryLineTmp.Absences := 0;
        SalaryLineTmp."Days off" := 0;
        SalaryLineTmp."Worked hours" := 0;
        SalaryLineTmp."Basis hours" := 0;
        SalaryLineTmp.congé := 0;
        SalaryLineTmp."Heure Jours Free" := 0;
        CLEAR(T3);
        IF T3.GET(SalaryLineTmp.Employee) THEN;
        CLEAR(T1);
        IF T1.GET(T3."Emplymt. Contract Code") THEN;
        CLEAR(T2);
        IF T2.GET(T1."Regimes of work") THEN;
        ParamCpta.GET;
        CLEAR(EntSal);
        IF EntSal.GET(SalaryLineTmp."No.") THEN;
        //>> DSFT AGA 140410
        IF Regim.GET(T1."Regimes of work") THEN;
        //<< DSFT AGA 140410

        EmployeDayOff.RESET;
        EmployeDayOff.SETCURRENTKEY("Line type", "Employee No.", "Posting month", "Posting year", Quinzaine, "Motif D'absence");
        EmployeDayOff.SETFILTER("Employee No.", SalaryLineTmp.Employee);
        EmployeDayOff.SETFILTER("Line type", '%1|%2', EmployeDayOff."Line type"::"Day off Right",
        EmployeDayOff."Line type"::"Day off Consumption");
        EmployeDayOff.CALCSUMS("Quantity (Days)", Quantity, "Quantity (Hours)");
        SalaryLineTmp."Days off remaining" := EmployeDayOff."Quantity (Days)";
        //>> DSFT AGA 140410
        IF ParamRessHum."Activer régime quinzaine" THEN
            IF Regim."type calcul paie" = Regim."type calcul paie"::Quinzaine THEN BEGIN
                EmployeDayOff.SETFILTER(Quinzaine, '%1', EntSal.Quinzaine);
                EmployeDayOff.CALCSUMS("Quantity (Days)", Quantity, "Quantity (Hours)");
                SalaryLineTmp."Days off remaining" := EmployeDayOff."Quantity (Days)";
            END;
        //<< DSFT AGA 140410

        IF SalaryLineTmp.Month < 12 THEN BEGIN
            EmployeDayOff.RESET;
            EmployeDayOff.SETCURRENTKEY("Line type", "Employee No.", "Posting month", "Posting year", Quinzaine, "Motif D'absence");
            EmployeDayOff.SETFILTER("Employee No.", SalaryLineTmp.Employee);
            EmployeDayOff.SETFILTER("Line type", '%1|%2', EmployeDayOff."Line type"::"Deductible of salary",
            EmployeDayOff."Line type"::"1/2 paied");
            EmployeDayOff.SETFILTER("Posting month", '%1', SalaryLineTmp.Month);
            EmployeDayOff.SETFILTER("Posting year", '%1', SalaryLineTmp.Year);
            EmployeDayOff.CALCSUMS("Quantity (Days)", Quantity, "Quantity (Hours)");
            IF SalaryLineTmp."Employee's type" = 0 THEN
                SalaryLineTmp.Absences := -EmployeDayOff."Quantity (Hours)"
            ELSE
                SalaryLineTmp.Absences := -EmployeDayOff."Quantity (Days)";
            //>> DSFT AGA 140410
            IF ParamRessHum."Activer régime quinzaine" THEN
                IF Regim."type calcul paie" = Regim."type calcul paie"::Quinzaine THEN BEGIN
                    EmployeDayOff.SETFILTER(Quinzaine, '%1', EntSal.Quinzaine);
                    EmployeDayOff.CALCSUMS("Quantity (Days)", Quantity, "Quantity (Hours)");
                    IF SalaryLineTmp."Employee's type" = 0 THEN
                        SalaryLineTmp.Absences := -EmployeDayOff."Quantity (Hours)"
                    ELSE
                        SalaryLineTmp.Absences := -EmployeDayOff."Quantity (Days)";
                END;
            //<< DSFT AGA 140410


            EmployeDayOff.RESET;
            EmployeDayOff.SETCURRENTKEY("Line type", "Employee No.", "Posting month", "Posting year", Quinzaine, "Motif D'absence");
            EmployeDayOff.SETFILTER("Employee No.", SalaryLineTmp.Employee);
            EmployeDayOff.SETFILTER("Line type", '%1', EmployeDayOff."Line type"::"Day off Consumption");
            EmployeDayOff.SETFILTER("Posting month", '%1', SalaryLineTmp.Month);
            EmployeDayOff.SETFILTER("Posting year", '%1', SalaryLineTmp.Year);
            EmployeDayOff.CALCSUMS("Quantity (Days)", "Quantity (Hours)");
            IF SalaryLineTmp."Employee's type" = 0 THEN
                SalaryLineTmp.congé := -EmployeDayOff."Quantity (Hours)"
            ELSE
                SalaryLineTmp.congé := -EmployeDayOff."Quantity (Days)";
            //>> DSFT AGA 140410
            IF ParamRessHum."Activer régime quinzaine" THEN
                IF Regim."type calcul paie" = Regim."type calcul paie"::Quinzaine THEN BEGIN
                    EmployeDayOff.SETFILTER(Quinzaine, '%1', EntSal.Quinzaine);
                    EmployeDayOff.CALCSUMS("Quantity (Days)", Quantity, "Quantity (Hours)");
                    IF SalaryLineTmp."Employee's type" = 0 THEN
                        SalaryLineTmp.congé := -EmployeDayOff."Quantity (Hours)"
                    ELSE
                        SalaryLineTmp.congé := -EmployeDayOff."Quantity (Days)";

                END;
            //<< DSFT AGA 140410


            SalaryLineTmp."Heure Jours Free" := 0;
            T1.RESET;
            CLEAR(Contrat);
            X := -1;
            CLEAR(Regim);

            IF SalaryLineTmp.Month < 12 THEN BEGIN
                DateJ := DMY2DATE(1, SalaryLineTmp.Month + 1, SalaryLineTmp.Year);
                IF Contrat.GET(SalaryLineTmp."Emplymt. Contract Code") THEN;
                Regim.GET(Contrat."Regimes of work");
                /*   REPEAT
                    X:=X+1;
                //    Nonworking := CalendarMgmt.CheckDateStatusJF(Contrat."Code Calendar",CALCDATE(STRSUBSTNO('+%1J',X),DateJ),JF);
                   IF   (JF) THEN BEGIN
                       SalaryLineTmp."Heure Jours Free":=SalaryLineTmp."Heure Jours Free"+
                       ROUND(Regim."Work Hours per month"/Regim."Worked Day Per Month",0.01);;
                       END;
                   UNTIL CALCDATE(STRSUBSTNO('+%1J',X),DateJ)>= CALCDATE('+FM',DateJ);
                  */
                SuppHourLine.RESET;
                SuppHourLine.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement");
                SuppHourLine.SETFILTER("N° Salarié", SalaryLineTmp.Employee);
                SuppHourLine.SETFILTER("Mois de paiement", '%1', SalaryLineTmp.Month);
                SuppHourLine.SETFILTER("Année de paiement", '%1', SalaryLineTmp.Year);
                SuppHourLine.CALCSUMS("Nombre d'heures");
                //>> DSFT AGA 11/03/2010
                // SalaryLineTmp."Worked hours":=SuppHourLine."Nombre d'heures";
                //<< AGA 11/03/2010
                SuppHourLine.RESET;
                SuppHourLine.SETCURRENTKEY("N° Salarié", "Taux de majoration", "Mois de paiement", "Année de paiement", Quinzaine);
                SuppHourLine.SETFILTER("N° Salarié", SalaryLineTmp.Employee);
                SuppHourLine.SETFILTER("Mois de paiement", '%1', SalaryLineTmp.Month);
                SuppHourLine.SETFILTER("Année de paiement", '%1', SalaryLineTmp.Year);
                // SuppHourLine.SETFILTER("Employee Posting Group",SalaryLineTmp."Employee Posting Group");
                //SuppHourLine.SETFILTER("N° Salarié",'=0');
                SuppHourLine.CALCSUMS("Nombre d'heures");
                SalaryLineTmp."Basis hours" := SuppHourLine."Nombre d'heures";
                //>> DSFT AGA 140410
                IF ParamRessHum."Activer régime quinzaine" THEN
                    IF Regim."type calcul paie" = Regim."type calcul paie"::Quinzaine THEN BEGIN
                        SuppHourLine.SETFILTER(Quinzaine, '%1', EntSal.Quinzaine);
                        SuppHourLine.CALCSUMS("Nombre d'heures");
                        SalaryLineTmp."Basis hours" := SuppHourLine."Nombre d'heures";
                    END;
                //<< DSFT AGA 140410


            END;
        END;
        IF (SalaryLineTmp.Month = 12) OR (SalaryLineTmp.Month = 13) OR (SalaryLineTmp.Month = SalaryLineTmp.Month::Prime) THEN BEGIN
            SalaryLineeng.RESET;
            SalaryLineeng.SETCURRENTKEY(Year, Month, Employee, "No.");
            SalaryLineeng.SETFILTER(Employee, SalaryLineTmp.Employee);
            SalaryLineeng.SETFILTER(Month, '0..11');
            IF SalaryLineTmp."Posting Date" = DMY2DATE(26, 3, 2005) THEN
                SalaryLineeng.SETFILTER(Month, '0..2');
            IF (SalaryLineTmp.Month = SalaryLineTmp.Month::Prime) THEN
                SalaryLineeng.SETRANGE(Year, SalaryLineTmp."year of Calculate")
            ELSE
                SalaryLineeng.SETRANGE(Year, SalaryLineTmp.Year);
            SalaryLineeng.CALCSUMS("Days off remaining", "Days off balacement", Absences, "Days off");
            SalaryLineengTmp.RESET;
            SalaryLineengTmp.SETCURRENTKEY(Year, Month, Employee, "No.");
            SalaryLineengTmp.SETFILTER(Employee, SalaryLineTmp.Employee);
            SalaryLineengTmp.SETFILTER(Month, '0..11');
            IF SalaryLineTmp."Posting Date" = DMY2DATE(26, 3, 2005) THEN
                SalaryLineengTmp.SETFILTER(Month, '0..2');
            IF (SalaryLineTmp.Month = SalaryLineTmp.Month::Prime) THEN
                SalaryLineengTmp.SETRANGE(Year, SalaryLineTmp."year of Calculate")
            ELSE
                SalaryLineengTmp.SETRANGE(Year, SalaryLineTmp.Year);
            IF SalaryLineengTmp.FIND('-') THEN
                EntSalEng.RESET;
            EntSalEng.SETFILTER(Month, '0..11');
            IF SalaryLineTmp."Posting Date" = DMY2DATE(26, 3, 2005) THEN
                EntSalEng.SETFILTER(Month, '0..2');

            IF (SalaryLineTmp.Month = SalaryLineTmp.Month::Prime) THEN
                EntSalEng.SETRANGE(Year, SalaryLineTmp."year of Calculate")
            ELSE
                EntSalEng.SETRANGE(Year, SalaryLineTmp.Year);
            IF EntSalEng.FIND('+') THEN;
            IF EntSalEng.COUNT <> 0 THEN BEGIN
                SalaryLineTmp.Absences := ROUND((SalaryLineeng.Absences + ((EntSalEng.COUNT - SalaryLineengTmp.COUNT)
                * ParamRessHum."Paid days")) / EntSalEng.COUNT, 0.01);
                SalaryLineTmp."Days off" := ROUND(SalaryLineeng."Days off" / EntSalEng.COUNT, 0.01);
            END;
        END;

    end;


    procedure "CalcInd&HsupNav"(var SalaryLineTmp: Record "Salary Lines"; Sim: Option Simulation,Real)
    var
        SuppHourLine: Record "Heures sup. eregistrées m";
        Indem: Record "Indemnities";
        Contrat: Record 5211;
        Regim: Record "Regimes of work";
        HeureTravail: Record "Heures occa. enreg. m";
        RecLPramRessHum: Record 5218;
        "DECNbannéesAnciennité": Decimal;
        RecLEmployee: Record 5200;
        J: Integer;
        "DecDroitCongéAncienneté": Decimal;
        "NbAttrubitionJourAncienneté": Decimal;
        k: Integer;
    begin
        SalaryLineTmp."Taxable indemnities" := 0;
        SalaryLineTmp."Supp. hours" := 0;
        SalaryLineTmp."Taxable indemnities (Not Gross" := 0;
        CLEAR(Contrat);
        CLEAR(Regim);
        RecLPramRessHum.GET();
        IF (SalaryLineTmp.Month < 12) AND (Sim = 1) THEN BEGIN
            DateJ := DMY2DATE(1, SalaryLineTmp.Month + 1, SalaryLineTmp.Year);
            IF Contrat.GET(SalaryLineTmp."Emplymt. Contract Code") THEN;
            Regim.GET(Contrat."Regimes of work");

            HeureTravail.RESET;
            HeureTravail.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement", Quinzaine);
            HeureTravail.SETFILTER("N° Salarié", SalaryLineTmp.Employee);
            HeureTravail.SETRANGE("Mois de paiement", SalaryLineTmp.Month);
            HeureTravail.SETRANGE("Année de paiement", SalaryLineTmp.Year);

            //>> DSFT AGA 150410
            IF RecLPramRessHum."Activer régime quinzaine" THEN
                IF Regim."type calcul paie" = Regim."type calcul paie"::Quinzaine THEN
                    HeureTravail.SETFILTER(Quinzaine, '%1', SalaryLineTmp.Quinzaine);
            //<< DSFT AGA 150410

            HeureTravail.CALCSUMS("Nombre d'heures", "Montant ligne", "Nbre Jour");
            IF Contrat."Employee's type" = 0 THEN
                SalaryLineTmp."droit de congé du mois" := ROUND(Regim."Days off per month" * HeureTravail."Nombre d'heures" /
                                                          Regim."Work Hours per month", ParamCpta."Amount Rounding Precision")
            ELSE
                SalaryLineTmp."droit de congé du mois" := ROUND(Regim."Days off per month" * SalaryLineTmp."Assiduity (Paid days)" / 100,
                                                                ParamCpta."Amount Rounding Precision");
        END;

        //>> DSFT AGA 09/03/2010
        IF SalaryLineTmp."droit de congé du mois" > Regim."Days off per month" THEN
            SalaryLineTmp."droit de congé du mois" := Regim."Days off per month";
        //<< DSFT AGA 09/03/2010

        //>> DSFT AGA 29/03/2010
        // calcul nombre de jour de congé d'ancieneté plafoné selon le mode de rétribution
        RecLPramRessHum.GET();
        RecLEmployee.GET(SalaryLineTmp.Employee);
        DecDroitCongéAncienneté := 0;
        IF RecLPramRessHum."App.retribution jour ancien." = TRUE THEN
            IF SalaryLineTmp.Month = 11 THEN BEGIN
                DECNbannéesAnciennité := SalaryLineTmp.Year - DATE2DMY(RecLEmployee."Employment Date", 3);
                IF DECNbannéesAnciennité >= Regim."Limite ancienneté" THEN BEGIN
                    FOR J := 0 TO DECNbannéesAnciennité - Regim."Limite ancienneté" DO BEGIN
                        J := J + Regim."Limite ancienneté";
                        IF J = DECNbannéesAnciennité THEN BEGIN
                            NbAttrubitionJourAncienneté := DECNbannéesAnciennité / Regim."Limite ancienneté";
                            FOR k := 0 TO NbAttrubitionJourAncienneté - 1 DO BEGIN
                                DecDroitCongéAncienneté := DecDroitCongéAncienneté + Regim."Rétributions Ancienneté/An";
                                SalaryLineTmp."Droit de congé ancienneté" := DecDroitCongéAncienneté;
                            END;
                        END ELSE BEGIN
                            SalaryLineTmp."Droit de congé ancienneté" := 0;
                        END;
                        J := J - 1;
                    END;
                    IF DecDroitCongéAncienneté > Regim."Limite ancienneté" THEN
                        SalaryLineTmp."Droit de congé ancienneté" := Regim."Plafond Ancienneté/An";
                END;
            END;
        //<< DSFT AGA 29/03/2010
        ParamCpta.GET;
        Indem.RESET;
        Indem.SETCURRENTKEY("No.", "Employee No.", Type, "Non Inclis en AV NAt");
        Indem.SETFILTER("No.", SalaryLineTmp."No.");
        Indem.SETFILTER("Employee No.", SalaryLineTmp.Employee);
        Indem.SETFILTER(Type, '%1', Indem.Type::Imposable);
        Indem.SETFILTER("Non Inclis en AV NAt", '%1', FALSE);
        Indem.CALCSUMS("Real Amount", "Real Amount PR");
        IF Indem.FIND('-') THEN
            REPEAT
                SalaryLineTmp."Taxable indemnities" := SalaryLineTmp."Taxable indemnities" +
                                                       ROUND(Indem."Real Amount", ParamCpta."Amount Rounding Precision");
            UNTIL Indem.NEXT = 0;
        //SalaryLineTmp."Taxable indemnities":= ROUND(Indem."Real Amount",ParamCpta."Amount Rounding Precision");
        // SalaryLineTmp."Taxable indemnities":= Indem."Real Amount";

        SalaryLineTmp."Taxable indemnities PR" := ROUND(Indem."Real Amount PR", ParamCpta."Amount Rounding Precision");

        Indem.RESET;
        Indem.SETCURRENTKEY("No.", "Employee No.", Type);
        Indem.SETFILTER("No.", SalaryLineTmp."No.");
        Indem.SETFILTER("Employee No.", SalaryLineTmp.Employee);
        Indem.SETFILTER(Type, '%1', 2);
        Indem.CALCSUMS("Real Amount");
        SalaryLineTmp."Taxable indemnities (Not Gross" := ROUND(Indem."Real Amount", ParamCpta."Amount Rounding Precision");
        IF Sim = 1 THEN BEGIN //<< AGA DSFT 27-04-2011
            SuppHourLine.RESET;
            SuppHourLine.SETCURRENTKEY("N° Salarié", "Taux de majoration", "Mois de paiement", "Année de paiement", Quinzaine);
            SuppHourLine.SETFILTER("N° Salarié", SalaryLineTmp.Employee);
            SuppHourLine.SETFILTER("Mois de paiement", '%1', SalaryLineTmp.Month);
            SuppHourLine.SETFILTER("Année de paiement", '%1', SalaryLineTmp.Year);
            //>> DSFT AGA 150410
            IF RecLPramRessHum."Activer régime quinzaine" THEN
                IF Regim."type calcul paie" = Regim."type calcul paie"::Quinzaine THEN
                    SuppHourLine.SETFILTER(Quinzaine, '%1', SalaryLineTmp.Quinzaine);
            //<< DSFT AGA 150410
            // SuppHourLine.SETFILTER("Employee Posting Group",SalaryLineTmp."Employee Posting Group");
            //SuppHourLine.SETFILTER("Taux de majoration",'<>0');
            //>>MBY 09/04/2009
            /*SuppHourLine.CALCSUMS("Montant ligne");
            SalaryLineTmp."Supp. hours":=ROUND(SuppHourLine."Montant ligne",ParamCpta."Amount Rounding Precision");
            SuppHourLine.MODIFYALL("Paiement No.",SalaryLineTmp."No.");*/
            IF SuppHourLine.FIND('-') THEN
                REPEAT

                    SalaryLineTmp."Supp. hours" := SalaryLineTmp."Supp. hours" + ROUND(SuppHourLine."Montant ligne"
                                                , ParamCpta."Amount Rounding Precision");

                    SuppHourLine.MODIFYALL("Paiement No.", SalaryLineTmp."No.");
                UNTIL SuppHourLine.NEXT = 0;
            //<<MBY
        END;//>> AGA DSFT 27-04-2011

    end;


    procedure "CalcInd&Hsup"(var SalaryLineTmp: Record "Salary Lines"; Sim: Option Simulation,Real)
    var
        SuppHourLine: Record "Heures sup. eregistrées m";
        Indem: Record "Indemnities";
    begin
        //AGA 0803 10
        /*   SalaryLineTmp."Taxable indemnities":=0;
          SalaryLineTmp."Supp. hours":=0;
          SalaryLineTmp."Taxable indemnities (Not Gross":=0;

          ParamCpta.GET;
          Indem.RESET;
          Indem.SETCURRENTKEY("No.","Employee No.",Type);
          Indem.SETFILTER("No.",SalaryLineTmp."No.");
          Indem.SETFILTER("Employee No.",SalaryLineTmp.Employee);
          Indem.SETFILTER(Type,'%1',Indem.Type::Imposable);
          Indem.CALCSUMS("Real Amount","Real Amount PR");

         IF Indem.FIND('-') THEN
           REPEAT
           SalaryLineTmp."Taxable indemnities" := SalaryLineTmp."Taxable indemnities" +
                                                  ROUND(Indem."Real Amount",ParamCpta."Amount Rounding Precision");
           UNTIL Indem.NEXT=0;

      //    SalaryLineTmp."Taxable indemnities":= ROUND(Indem."Real Amount",ParamCpta."Amount Rounding Precision");
          SalaryLineTmp."Taxable indemnities PR":= ROUND(Indem."Real Amount PR",ParamCpta."Amount Rounding Precision");

          Indem.RESET;
          Indem.SETCURRENTKEY("No.","Employee No.",Type);
          Indem.SETFILTER("No.",SalaryLineTmp."No.");
          Indem.SETFILTER("Employee No.",SalaryLineTmp.Employee);
          Indem.SETFILTER(Type,'%1',2);
          Indem.CALCSUMS("Real Amount");
          SalaryLineTmp."Taxable indemnities (Not Gross":= ROUND(Indem."Real Amount",ParamCpta."Amount Rounding Precision");

          SuppHourLine.RESET;
          SuppHourLine.SETCURRENTKEY("N° Salarié","Taux de majoration","Mois de paiement","Année de paiement");
          SuppHourLine.SETFILTER("N° Salarié",SalaryLineTmp.Employee);
          SuppHourLine.SETFILTER("Mois de paiement",'%1',SalaryLineTmp.Month);
          SuppHourLine.SETFILTER("Année de paiement",'%1',SalaryLineTmp.Year);
         // SuppHourLine.SETFILTER("Employee Posting Group",SalaryLineTmp."Employee Posting Group");
          //SuppHourLine.SETFILTER("Taux de majoration",'<>0');
         //>>MBY 09/04/2009
         {SuppHourLine.CALCSUMS("Montant ligne");
         SalaryLineTmp."Supp. hours":=ROUND(SuppHourLine."Montant ligne",ParamCpta."Amount Rounding Precision");
         SuppHourLine.MODIFYALL("Paiement No.",SalaryLineTmp."No.");}
         IF SuppHourLine.FIND('-') THEN
           REPEAT
             SalaryLineTmp."Supp. hours":=SalaryLineTmp."Supp. hours"+ROUND(SuppHourLine."Montant ligne"
                                          ,ParamCpta."Amount Rounding Precision");
             SuppHourLine.MODIFYALL("Paiement No.",SalaryLineTmp."No.");
           UNTIL SuppHourLine.NEXT = 0 ;
          //<<MBY
        */

    end;


    procedure CalcAllTaxe(var SalaryLineTmp: Record "Salary Lines")
    var
        SocialContr: Record "Social Contributions";
        SalLine: Record "Rec. Salary Lines";
        ExpRepHead: Record "Expenses to repay Header";
        Indem: Record "Indemnities";
    begin
        SalaryLineTmp.CNSS := 0;
        SalaryLineTmp."Total taxable rec." := 0;
        SalaryLineTmp."Total taxes rec." := 0;
        SalaryLineTmp."Non Taxable indemnities" := 0;
        SalaryLineTmp."Taxable Soc. Contrib." := 0;
        SalaryLineTmp."Mission expenses" := 0;
        ParamCpta.GET;
        SocialContr.RESET;
        SocialContr.SETCURRENTKEY("No.", Employee, "Deductible of taxable basis");
        SocialContr.SETFILTER("No.", SalaryLineTmp."No.");
        SocialContr.SETFILTER(Employee, SalaryLineTmp.Employee);
        SocialContr.SETFILTER("Deductible of taxable basis", '%1', TRUE);
        SocialContr.CALCSUMS("Real Amount : Employee", "Real Amount : Employee PR");
        SalaryLineTmp.CNSS := ROUND(SocialContr."Real Amount : Employee", ParamCpta."Amount Rounding Precision");
        SalaryLineTmp."Non Taxable Soc. Contrib. PR" := ROUND(SocialContr."Real Amount : Employee PR",
                                                        ParamCpta."Amount Rounding Precision");

        SalLine.RESET;
        SalLine.SETCURRENTKEY(Year, Employee, "Global dimension 1", "Global dimension 2");
        SalLine.SETFILTER(Year, '%1', SalaryLineTmp.Year);
        SalLine.SETFILTER(Employee, SalaryLineTmp.Employee);
        SalLine.CALCSUMS("Real taxable", "Taxe (Month)");
        SalaryLineTmp."Total taxable rec." := SalLine."Real taxable";
        SalaryLineTmp."Total taxes rec." := SalLine."Taxe (Month)";

        Indem.RESET;
        Indem.SETCURRENTKEY("No.", "Employee No.", Type);
        Indem.SETFILTER("No.", SalaryLineTmp."No.");
        Indem.SETFILTER("Employee No.", SalaryLineTmp.Employee);
        Indem.SETFILTER(Type, '%1', Indem.Type::"Non imposable");
        Indem.CALCSUMS("Real Amount");
        SalaryLineTmp."Non Taxable indemnities" := Indem."Real Amount";

        SocialContr.RESET;
        SocialContr.SETCURRENTKEY("No.", Employee, "Deductible of taxable basis");
        SocialContr.SETFILTER("No.", SalaryLineTmp."No.");
        SocialContr.SETFILTER(Employee, SalaryLineTmp.Employee);
        SocialContr.SETFILTER("Deductible of taxable basis", '%1', FALSE);
        SocialContr.CALCSUMS("Real Amount : Employee");
        SalaryLineTmp."Taxable Soc. Contrib." := SocialContr."Real Amount : Employee";

        ExpRepHead.RESET;
        ExpRepHead.SETCURRENTKEY(Repaied, Status, "Payment year", "Payment month", "Employee No.", "Global dimension 1",
    "Global dimension 2")
        ;
        ExpRepHead.SETFILTER("Employee No.", SalaryLineTmp.Employee);
        ExpRepHead.SETFILTER(Status, '%1', ExpRepHead.Status::Validated);
        ExpRepHead.SETFILTER("Payment month", '%1', SalaryLineTmp.Month);
        ExpRepHead.SETFILTER("Payment year", '%1', SalaryLineTmp.Year);
        ExpRepHead.SETFILTER(Repaied, '%1', FALSE);
        ExpRepHead.CALCSUMS("Document amount");
        SalaryLineTmp."Mission expenses" := ExpRepHead."Document amount";
    end;


    procedure CalcLoanadv(var SalaryLineTmp: Record "Salary Lines")
    var
        LoanAdvan: Record "Loan & Advance Lines";
        LoanAD: Record "Loan & Advance Header";
        DateD: Date;
        DateF: Date;
    begin
        IF SalaryLineTmp.Year = 0 THEN
            SalaryLineTmp.Year := DATE2DMY(TODAY, 3);
        IF SalaryLineTmp.Month < 12 THEN
            DateD := DMY2DATE(1, SalaryLineTmp.Month + 1, SalaryLineTmp.Year)
        ELSE
            DateD := DMY2DATE(1, DATE2DMY(SalaryLineTmp."Posting Date", 2), SalaryLineTmp.Year);

        DateF := CALCDATE('+FM', DateD);
        SalaryLineTmp.Loans := 0;
        LoanAD.RESET;
        LoanAD.SETCURRENTKEY(Employee, Type, Status, "No.", "Avance Sur Prime");
        LoanAD.SETFILTER(Employee, SalaryLineTmp.Employee);
        LoanAD.SETRANGE(Type, LoanAD.Type::Loan);
        LoanAD.SETRANGE(Status, LoanAD.Status::"In progress");
        LoanAD.SETRANGE("Avance Sur Prime", FALSE);

        //>>DSFT-AGA 12/03/2010
        LoanAD.SETRANGE("Not include", FALSE);
        //<<DSFT-AGA 12/03/2010

        IF LoanAD.FIND('-') THEN
            REPEAT
                SalaryLineTmp.Loans := SalaryLineTmp.Loans + ROUND(LoanAD.CalcMnPrinciPeriode(DateD, DateF),
                                     ParamCpta."Amount Rounding Precision") +
                                     ROUND(LoanAD.CalcMntInetret(DateD, DateF), ParamCpta."Amount Rounding Precision");
            UNTIL LoanAD.NEXT = 0;
        //>> DSFT AGA 12/03/2010
        IF LoanAD."Double tranche" = TRUE THEN
            SalaryLineTmp.Loans := SalaryLineTmp.Loans * 2;
        //>> DSFT AGA 12/03/2010
        // Advance
        SalaryLineTmp.Advances := 0;
        LoanAD.RESET;
        LoanAD.SETCURRENTKEY(Employee, Type, Status, "No.", "Avance Sur Prime");

        LoanAD.SETFILTER(Employee, SalaryLineTmp.Employee);
        LoanAD.SETRANGE(Type, LoanAD.Type::Advance);
        LoanAD.SETRANGE(Status, LoanAD.Status::"In progress");
        LoanAD.SETRANGE("Avance Sur Prime", FALSE);
        IF LoanAD.FIND('-') THEN
            REPEAT
                SalaryLineTmp.Advances := SalaryLineTmp.Advances + ROUND(LoanAD.CalcMnPrinciPeriode(DateD, DateF),
                ParamCpta."Amount Rounding Precision");
            UNTIL LoanAD.NEXT = 0;
        // Advance Sur Prime
    end;


    procedure "CalcIndemnitéImp"(var SalaryLine: Record "Salary Lines")
    var
        SalaryHeader: Record "Salary Headers";
        Ind: Record "Indemnities";
        ParamRessHum: Record 5218;
        EmploymentContract: Record 5211;
        RegimeWork: Record "Regimes of work";
        bonus: Decimal;
        tmp: Decimal;
        tmp1: Decimal;
        LigneTravail: Record "Heures occa. enreg. m";
        LigneAbsence: Record "Employee's days off Entry";
        LigneTravailEnreg: Record "Heures sup. eregistrées m";
        Defaultind: Record "Default Indemnities";
        "//DSFT AGA 160410": Integer;
        RecIndemnity: Record "Indemnity";
        "RecAbsenceCongé": Record "Employee's days off Entry";
        TotalJoursAbs: Decimal;
        SalaryLinesEnregistrer: Record "Rec. Salary Lines";
        "Ancienneté": Integer;
        TrancheSTC: Record "Tranche STC";
        TauxStc1: Decimal;
        TauxStc2: Decimal;
        TauxStc3: Decimal;
        Compteur: Integer;
        FinComptage: Integer;
        SommePaieEnregistre: Integer;
        "JourDroitCongé": Decimal;
        SalaireBrut: Decimal;
        "MontantCongé": Decimal;
        LSalaryLine: Record "Salary Lines";
        SalaireBrutSurFiche: Decimal;
        EmployeDaysOffEntry: Record "Employee's days off Entry";
        Moyenne6SalaireBrut: Decimal;
        SequenceStc: Integer;
        MontantIndeLicen: Decimal;
        MontantIndeLicen1: Decimal;
        MontantIndeLicen2: Decimal;
        MontantIndeLicen3: Decimal;
    begin
        //--> Calcul des montants réels des Ind. selon le mode d'évaluation
        SalaryHeader.GET(SalaryLine."No.");
        ParamRessHum.GET();

        //<<MBY 18/01/2010
        IF SalaryLine."Employee Regime of work" = '' THEN
            ERROR('Régime de travail non défini pour le salarié : %1 ', SalaryLine.Employee);
        RegimeWork.RESET;
        RegimeWork.SETRANGE(Code, SalaryLine."Employee Regime of work");
        IF RegimeWork.FIND('-') THEN
            IF RegimeWork."Work Hours per month" = 0 THEN
                ERROR('Vérifier le nombre d heure travaillées par mois pour le régime : %1', RegimeWork.Code);

        //>>MBY 18/01/2010
        Ind.SETRANGE("No.", SalaryLine."No.");
        Ind.SETRANGE("Employee No.", SalaryLine.Employee);
        IF Ind.FIND('-') THEN
            REPEAT
                TotalJoursAbs := 0;
                CASE Ind."Evaluation mode" OF
                    0:
                        BEGIN
                            Ind.Rate := 100;
                            Ind."Real Amount" := Ind."Base Amount" * Ind.Rate / 100;
                            Ind."Real Amount PR" := Ind."Base Amount";
                            Ind."User ID" := USERID;
                            Ind."Last Date Modified" := WORKDATE;
                        END;
                    1:
                        BEGIN
                            LigneTravail.RESET;
                            LigneTravail.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement", Quinzaine);
                            LigneTravail.SETFILTER("N° Salarié", SalaryLine.Employee);
                            LigneTravail.SETRANGE("Mois de paiement", SalaryLine.Month);
                            LigneTravail.SETRANGE("Année de paiement", SalaryLine.Year);
                            //>> DSFT AGA 140410
                            IF ParamRessHum."Activer régime quinzaine" THEN
                                IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN
                                    LigneTravail.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);
                            //<< DSFT AGA 140410
                            LigneTravail.CALCSUMS("Nombre d'heures", "Montant ligne", "Nbre Jour");
                            LigneTravailEnreg.RESET;
                            LigneTravailEnreg.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement", Quinzaine);
                            LigneTravailEnreg.SETFILTER("N° Salarié", SalaryLine.Employee);
                            LigneTravailEnreg.SETRANGE("Mois de paiement", SalaryLine.Month);
                            LigneTravailEnreg.SETRANGE("Année de paiement", SalaryLine.Year);
                            //>> DSFT AGA 140410
                            IF ParamRessHum."Activer régime quinzaine" THEN
                                IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN
                                    LigneTravailEnreg.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);
                            //<< DSFT AGA 140410
                            LigneTravailEnreg.CALCSUMS("Nombre d'heures", "Montant ligne");
                            //>> DSFT AGA 160410  DEDUCTION DE L'INDEMNITE QU'APARTIRE DU DEPASSEMENT DU NOMBRE DE JOUR ABSENCE
                            CASE SalaryLine."Employee's type" OF
                                0:
                                    BEGIN

                                        Ind.Rate := ((SalaryLine."Worked hours") * 100) / GNbHeure;//-SalaryLine.Absences
                                        Ind.Rate := ((LigneTravail."Nbre Jour" * 100) / GNbJour);
                                        //  message(format(GNbHeure));
                                        IF SalaryLine.Month = 16 THEN
                                            Ind.Rate := ((SalaryLine."Days off remaining" * 100) / GNbJour);
                                        IF RecIndemnity.GET(Ind.Indemnity) THEN
                                            //IF (RecIndemnity."base deduction indemnité/heure") > (GNbHeure-SalaryLine."Worked hours") THEN
                                            IF RecIndemnity."base deduction indemnité/jours" > (GNbJour - LigneTravail."Nbre Jour") THEN
                                                Ind.Rate := 100;
                                        //aga 19/10/2010
                                        IF Ind.Rate > 100 THEN
                                            Ind.Rate := 100;
                                        // DEV GMS 18/11/2010 PRIME A BASE DE NOMBRE DE JOURS
                                        IF Ind."Nombre de jours" <> 0 THEN BEGIN
                                            RecAbsenceCongé.RESET;
                                            RecAbsenceCongé.SETCURRENTKEY("Line type", "Employee No.", "Posting month", "Posting year", Quinzaine, "Motif D'absence");
                                            RecAbsenceCongé.SETFILTER("Employee No.", SalaryLine.Employee);

                                            RecAbsenceCongé.SETFILTER("Line type", '%1', 3);

                                            RecAbsenceCongé.SETFILTER("Posting month", '%1', SalaryLine.Month);
                                            RecAbsenceCongé.SETFILTER("Posting year", '%1', SalaryLine.Year);
                                            IF (Ind."Non déductible accident de Tra" = FALSE) THEN BEGIN
                                                RecAbsenceCongé.SETFILTER("Motif D'absence", '<>%1', 7);
                                                RecAbsenceCongé.CALCSUMS("Quantity (Days)");
                                                TotalJoursAbs := ABS(RecAbsenceCongé."Quantity (Days)");
                                            END ELSE BEGIN
                                                RecAbsenceCongé.SETFILTER("Motif D'absence", '<>%1', 5);
                                                RecAbsenceCongé.CALCSUMS("Quantity (Days)");
                                                TotalJoursAbs := ABS(RecAbsenceCongé."Quantity (Days)");
                                                //  message(format(TotalJoursAbs));
                                            END;

                                            RecAbsenceCongé.SETFILTER("Line type", '%1', 2);
                                            RecAbsenceCongé.CALCSUMS("Quantity (Days)");

                                            TotalJoursAbs := TotalJoursAbs + ABS(RecAbsenceCongé."Quantity (Days)");
                                            Ind.Rate := ((Ind."Nombre de jours" - TotalJoursAbs) / Ind."Nombre de jours") * 100;
                                            // MESSAGE(FORMAT(TotalJoursAbs)+'---');
                                        END;
                                        // FIN CALCUL INDEMNITE PAR NOMBRE DE JOURS

                                    END;
                                1:
                                    BEGIN
                                        Ind.Rate := ((TotJoursEnreg) * 100) / GNbJour;//-SalaryLine.Absences
                                                                                      // IF RecIndemnity.GET(Ind.Indemnity)THEN
                                                                                      //IF RecIndemnity."base deduction indemnité/jours">(GNbJour-TotJoursEnreg) THEN
                                                                                      // Ind.Rate:=100;
                                                                                      // IF   Ind.Rate>100 THEN                Ind.Rate:=100;
                                    END;
                            END;
                            // DEV GMS 18/11/2010 PRIME A BASE DE NOMBRE DE JOURS
                            IF Ind."Nombre de jours" <> 0 THEN BEGIN
                                RecAbsenceCongé.RESET;
                                RecAbsenceCongé.SETCURRENTKEY("Line type", "Employee No.", "Posting month", "Posting year", Quinzaine, "Motif D'absence");
                                RecAbsenceCongé.SETFILTER("Employee No.", SalaryLine.Employee);

                                RecAbsenceCongé.SETFILTER("Line type", '%1', 3);
                                RecAbsenceCongé.SETFILTER("Posting month", '%1', SalaryLine.Month);
                                RecAbsenceCongé.SETFILTER("Posting year", '%1', SalaryLine.Year);
                                /* IF Ind."Non déductible accident de Tra"= FALSE THEN BEGIN
                                 RecAbsenceCongé.CALCSUMS("Quantity (Days)");
                                 TotalJoursAbs:=ABS(RecAbsenceCongé."Quantity (Days)");
                                 END;*/
                                IF (Ind."Non déductible accident de Tra" = FALSE) THEN BEGIN
                                    RecAbsenceCongé.SETFILTER("Motif D'absence", '<>%1', 7);
                                    RecAbsenceCongé.CALCSUMS("Quantity (Days)");
                                    TotalJoursAbs := ABS(RecAbsenceCongé."Quantity (Days)");
                                END ELSE BEGIN
                                    RecAbsenceCongé.SETFILTER("Motif D'absence", '<>%1', 5);
                                    RecAbsenceCongé.CALCSUMS("Quantity (Days)");
                                    TotalJoursAbs := ABS(RecAbsenceCongé."Quantity (Days)");

                                END;


                                RecAbsenceCongé.SETFILTER("Line type", '%1', 2);
                                RecAbsenceCongé.CALCSUMS("Quantity (Days)");
                                TotalJoursAbs := TotalJoursAbs + ABS(RecAbsenceCongé."Quantity (Days)");

                                Ind.Rate := ((Ind."Nombre de jours" - TotalJoursAbs) / Ind."Nombre de jours") * 100;
                            END;
                            // FIN CALCUL INDEMNITE PAR NOMBRE DE JOURS

                            //<< DSFT AGA 160410
                            Ind."Real Amount" := Ind."Base Amount" * Ind.Rate / 100;
                            Ind."Real Amount PR" := Ind."Base Amount";
                            // MC -------------------------------------------------------------------------------------------------
                            Ind."User ID" := USERID;
                            Ind."Last Date Modified" := WORKDATE;

                            IF Ind."Real Amount" < 0 THEN
                                Ind."Real Amount" := 0;
                        END;
                    2:
                        BEGIN

                            //>> DSFT-AGA 04/07/2010   ABSENCE

                            Ind.Rate := SalaryLine."Assiduity (Worked days)";
                            //>> DSFT AGA 160410  DEDUCTION DE L'INDEMNITE QU'APARTIRE DU DEPASSEMENT DU NOMBRE DE JOUR ABSENCE
                            CASE SalaryLine."Employee's type" OF
                                0:
                                    BEGIN
                                        Ind.Rate := ((SalaryLine."Worked hours") * 100) / GNbHeure;//-SalaryLine.Absences
                                        IF (RecIndemnity."base deduction indemnité/heure") > (GNbHeure - SalaryLine."Worked hours") THEN
                                            Ind.Rate := 100;
                                    END;
                                1:
                                    BEGIN
                                        // Ind.Rate := ((TotJoursEnreg) *100)/GNbJour;//-SalaryLine.Absences
                                        Ind.Rate := SalaryLine."Assiduity (Worked days)";
                                        IF RecIndemnity.GET(Ind.Indemnity) THEN
                                            IF RecIndemnity."base deduction indemnité/jours" > (GNbJour - TotJoursEnreg) THEN
                                                Ind.Rate := 100;
                                    END;
                            END;

                            //<< DSFT AGA 160410
                            Ind.Rate := SalaryLine."Assiduity (Worked days)";
                            // MC : Prise en compte du Min. garanti ---------------------------------------------------------------
                            tmp := 0;
                            IF Ind."Minimum value" > 0 THEN BEGIN
                                tmp := ROUND(Ind."Base Amount" * Ind.Rate / 100, Ind."Precision Arrondi Montant",
                                                                 FORMAT(Ind."Direction Arrondi"));
                                IF tmp < Ind."Minimum value" THEN
                                    Ind."Real Amount" := Ind."Minimum value"
                                ELSE
                                    Ind."Real Amount" := tmp;
                            END
                            ELSE
                                Ind."Real Amount" := Ind."Base Amount" * Ind.Rate / 100;
                            Ind."Real Amount PR" := Ind."Base Amount";
                            // MC -------------------------------------------------------------------------------------------------
                            Ind."User ID" := USERID;
                            Ind."Last Date Modified" := WORKDATE;

                            IF Ind."Real Amount" < 0 THEN
                                Ind."Real Amount" := 0;

                        END;
                    3:
                        BEGIN
                            //MBY 13/01/2009
                            //>>DSFT AGA 25/03/2010
                            //     DecNBHeureEncouragement := SalaryLine."Basis hours" + SalaryLine."Worked hours";//MBY SAMI
                            //DecMntHoraire := Ind."Base Amount"/GNbHeure;
                            DecMntHoraire := Ind."Base Amount";


                            DecNBHeureEncouragement := SalaryLine."Worked hours";
                            IF ((RecIndemnity."base deduction indemnité/heure") > (GNbHeure - SalaryLine."Worked hours"))
                            AND ((GNbHeure - SalaryLine."Worked hours") > 0) THEN
                                DecNBHeureEncouragement := RegimeWork."Work Hours per month";

                            Ind.Rate := SalaryLine."Worked hours" + SalaryLine."Hours off Balacement" +
                                                          SalaryLine."Heures consomation congé";//+SalaryLine."Heure Jours Free";
                                                                                                // MC : Prise en compte du Min. garanti ---------------------------------------------------------------

                            tmp := 0;
                            IF Ind."Minimum value" > 0 THEN BEGIN
                                tmp := Ind."Base Amount" * Ind.Rate;

                                IF tmp < Ind."Minimum value" THEN
                                    Ind."Real Amount" := Ind."Minimum value"
                                ELSE
                                    Ind."Real Amount" := tmp;
                            END
                            ELSE BEGIN
                                IF SalaryLine."Employee's type" = 0 THEN
                                    Ind."Real Amount" := DecMntHoraire * DecNBHeureEncouragement //* Ind.Rate;
                                ELSE
                                    IF SalaryLine.Month <> 13 THEN BEGIN //pour simulation janvier fevrier mars 2009

                                        // DecMntHoraire := Ind."Base Amount"/RegimeWork."Work Hours per month";
                                        //DecMntHoraire := Ind."Base Amount"/173.33;
                                        Ind."Real Amount" := (Ind."Base Amount" * (SalaryLine."Paied days") / GNbJour)  //-SalaryLine.Absences
                                                                           + (DecMntHoraire * DecNBHeureEncouragement);

                                    END//
                                    ELSE
                                        Ind."Real Amount" := (Ind."Base Amount" * (SalaryLine."Paied days") / GNbJour)
                                                                           + (DecMntHoraire * DecNBHeureEncouragement)

                            END;
                            Ind."Real Amount PR" := Ind."Base Amount" * RegimeWork."Work Hours per month";

                            IF Ind."Real Amount" < 0 THEN
                                Ind."Real Amount" := 0;
                            // MC -------------------------------------------------------------------------------------------------
                            Ind."User ID" := USERID;
                            Ind."Last Date Modified" := WORKDATE;
                        END;
                    7:
                        BEGIN
                            //Ind.Rate                          := SalaryLine."Worked hours"+ SalaryLine."Hours off Balacement";
                            IF SalaryLine."Employee's type" = 1 THEN
                                Ind.Rate := SalaryLine."Worked hours" + SalaryLine."Hours off Balacement"
                            ELSE
                                Ind.Rate := SalaryLine."Worked hours" + SalaryLine."Hours off Balacement" +
                                SalaryLine."Heures consomation congé";//+ SalaryLine."Heure Jours Free" ;
                                                                      // MC : Prise en compte du Min. garanti ---------------------------------------------------------------
                            tmp := 0;
                            IF Ind."Minimum value" > 0 THEN BEGIN
                                tmp := ROUND((Ind."Base Amount" * Ind.Taux) / 100
                                                                 , Ind."Precision Arrondi Montant", FORMAT(Ind."Direction Arrondi"));
                                IF tmp < Ind."Minimum value" THEN
                                    Ind."Real Amount" := Ind."Minimum value"
                                ELSE
                                    Ind."Real Amount" := tmp;
                            END
                            ELSE
                                Ind."Real Amount" := (Ind."Base Amount" * Ind.Taux) / 100;
                            Ind."Real Amount PR" := ROUND(Ind."Real Amount", Ind."Precision Arrondi Montant",
                                                                FORMAT(Ind."Direction Arrondi"));

                            // MC -------------------------------------------------------------------------------------------------
                            Ind."User ID" := USERID;
                            Ind."Last Date Modified" := WORKDATE;
                        END;

                    5:
                        BEGIN
                            Ind.Rate := SalaryHeader."Worked days" - SalaryLine.Absences - SalaryLine.congé;
                            //>> DSFT AGA 12/05/2010 CALCUL INDEMNITE PAR JOURS DE TRAVAIL

                            LigneTravail.RESET;
                            LigneTravail.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement", Quinzaine);
                            LigneTravail.SETFILTER("N° Salarié", SalaryLine.Employee);
                            LigneTravail.SETRANGE("Mois de paiement", SalaryLine.Month);
                            LigneTravail.SETRANGE("Année de paiement", SalaryLine.Year);
                            IF ParamRessHum."Activer régime quinzaine" THEN
                                IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN
                                    LigneTravail.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);
                            LigneTravail.CALCSUMS("Nombre d'heures", "Montant ligne", "Nbre Jour");
                            IF Ind."base deduction indemnité/jours" < (SalaryHeader."Worked days" - LigneTravail."Nbre Jour") THEN
                                Ind.Rate := LigneTravail."Nbre Jour"
                            ELSE BEGIN
                                Ind.Rate := SalaryHeader."Worked days";
                                LigneTravail.CALCSUMS("Nombre d'heures", "Montant ligne", "Nbre Jour");
                                Ind.Rate := LigneTravail."Nbre Jour"
                            END;
                            //<< DSFT AGA 12/05/2010
                            IF Ind.Rate < 0 THEN
                                Ind.Rate := 0;
                            // MC : Prise en compte du Min. garanti ---------------------------------------------------------------
                            tmp := 0;
                            IF Ind."Minimum value" > 0 THEN BEGIN
                                tmp := ROUND(Ind."Base Amount" * Ind.Rate, Ind."Precision Arrondi Montant",
                                                                 FORMAT(Ind."Direction Arrondi"));
                                IF tmp < Ind."Minimum value" THEN
                                    Ind."Real Amount" := Ind."Minimum value"
                                ELSE
                                    Ind."Real Amount" := tmp;
                            END
                            ELSE
                                Ind."Real Amount" := ROUND(Ind."Base Amount" * Ind.Rate, Ind."Precision Arrondi Montant", '>');
                            //  Ind."Real Amount"            := Ind."Base Amount"*Ind.Rate;
                            Ind."Real Amount PR" := ROUND(Ind."Base Amount" * SalaryHeader."Worked days"
                                 , Ind."Precision Arrondi Montant");
                            // AGA23/12/2010         // Ind."Real Amount" := ROUND(Ind."Real Amount",0.01,'>') ;
                            //  message(format(Ind."Real Amount"));
                            // MC -------------------------------------------------------------------------------------------------
                            Ind."User ID" := USERID;
                            Ind."Last Date Modified" := WORKDATE;
                        END;
                    // Athanor

                    8:
                        BEGIN
                            // >> HJ BF 21-01-2014  Appliquer Indemniter De Panier 3*nbrjourpanier* Smig Horaire
                            IF EMP.GET(SalaryLine.Employee) THEN;
                            Linegrid.RESET;
                            Linegrid.SETRANGE(Catégorie, EMP.Catégorie);
                            Linegrid.SETRANGE(Echelons, EMP.Echelons);
                            IF SalaryLine.Month = SalaryLine.Month::Prime THEN SalaryLine."Nbr Jour Panier" := 30;
                            IF Linegrid.FINDFIRST THEN
                                Ind."Real Amount" := ROUND(3 * Linegrid."Taux Horaire" * SalaryLine."Nbr Jour Panier", 1);
                            Ind."Real Amount PR" := Ind."Real Amount";
                            Ind."User ID" := USERID;
                            Ind."Last Date Modified" := WORKDATE;
                        END;
                    // >> HJ BF 21-01-2014 Appliquer Indemniter De Panier 3*nbrjourpanier* Smig Horaire


                    10:
                        BEGIN
                            // >> HJ BF 21-01-2014  Appliquer Indemniter De Panier 3*nbrjourpanier* Smig Horaire
                            IF ParamRessHum.GET THEN;
                            Ind."Real Amount" := ROUND(ParamRessHum."Base Prime Panier F" * SalaryLine."Paied days", 1);
                            Ind."Real Amount PR" := Ind."Real Amount";
                            Ind."User ID" := USERID;
                            Ind."Last Date Modified" := WORKDATE;
                        END;
                    // >> HJ BF 21-01-2014 Appliquer Indemniter De Panier 3*nbrjourpanier* Smig Horaire

                    9:
                        BEGIN
                            // >> HJ BF 27-01-2014  STC
                            IF SalaryLine.Month = SalaryLine.Month::STC THEN BEGIN
                                IF (Ind."Type STC" = Ind."Type STC"::Licenciement) OR (Ind."Type STC" = Ind."Type STC"::Decés) OR
                                  (Ind."Type STC" = Ind."Type STC"::"Depart Retraite") THEN BEGIN
                                    IF EMP.GET(SalaryLine.Employee) THEN;
                                    SequenceStc := 0;
                                    TauxStc1 := 0;
                                    TauxStc2 := 0;
                                    TauxStc3 := 0;
                                    Compteur := 0;
                                    FinComptage := 6;
                                    SommePaieEnregistre := 0;
                                    Ancienneté := CalculerAnneeAncienneté(SalaryLine.Employee);
                                    //SalaryLinesEnregistrer.SETRANGE(Month,SalaryLine.Month-6,SalaryLine.Month-1);
                                    SalaryLinesEnregistrer.SETRANGE(Employee, SalaryLine.Employee);
                                    IF SalaryLinesEnregistrer.COUNT >= 6 THEN BEGIN
                                        IF SalaryLinesEnregistrer.FINDLAST THEN
                                            REPEAT
                                                //IF SalaryLinesEnregistrer.COUNT<6 THEN FinComptage:=SalaryLinesEnregistrer.COUNT;
                                                Compteur += 1;
                                                IF Compteur = 1 THEN JourDroitCongé := SalaryLinesEnregistrer."Days off remaining";
                                                SommePaieEnregistre += SalaryLinesEnregistrer."Gross Salary";
                                            UNTIL (SalaryLinesEnregistrer.NEXT(-1) = 6) OR (Compteur >= FinComptage);
                                    END
                                    ELSE BEGIN
                                    END;
                                    IF EMP."Moyenne 6 Dernier Salaire Brut" <> 0 THEN BEGIN
                                        Ind."Real Amount" := EMP."Moyenne 6 Dernier Salaire Brut";
                                        Moyenne6SalaireBrut := EMP."Moyenne 6 Dernier Salaire Brut";

                                    END
                                    ELSE
                                        Moyenne6SalaireBrut := ROUND(SommePaieEnregistre / 6, 1);

                                    IF TrancheSTC.FINDFIRST THEN
                                        REPEAT
                                            SequenceStc += 1;
                                            IF SequenceStc = 1 THEN TauxStc1 := TrancheSTC."Taux STC";
                                            IF SequenceStc = 2 THEN TauxStc2 := TrancheSTC."Taux STC";
                                            IF SequenceStc = 3 THEN TauxStc3 := TrancheSTC."Taux STC";
                                        UNTIL TrancheSTC.NEXT = 0;
                                    MontantIndeLicen := 0;
                                    MontantIndeLicen1 := 0;
                                    MontantIndeLicen2 := 0;
                                    MontantIndeLicen3 := 0;
                                    IF (Ancienneté > 120) THEN BEGIN
                                        MontantIndeLicen1 := (5 * TauxStc1 * Moyenne6SalaireBrut) / 100;
                                        MontantIndeLicen2 := (10 * TauxStc2 * Moyenne6SalaireBrut) / 100;
                                        MontantIndeLicen3 := (((Ancienneté - 120) / 12) * TauxStc3 * Moyenne6SalaireBrut) / 100;
                                    END;
                                    IF (Ancienneté > 60) AND (Ancienneté <= 120) THEN BEGIN
                                        MontantIndeLicen1 := (5 * TauxStc1 * Moyenne6SalaireBrut) / 100;
                                        MontantIndeLicen2 := (((Ancienneté - 60) / 12) * TauxStc2 * Moyenne6SalaireBrut) / 100;
                                    END;
                                    IF (Ancienneté > 12) AND (Ancienneté <= 60) THEN BEGIN
                                        MontantIndeLicen1 := ((Ancienneté / 12) * TauxStc1 * Moyenne6SalaireBrut) / 100;
                                    END;
                                    Ind."Real Amount" := ROUND(MontantIndeLicen1 + MontantIndeLicen2 + MontantIndeLicen3, 1);
                                    IF Ind."Real Amount" = 0 THEN Ind."Real Amount" := Ind."Base Amount";
                                    Ind."Real Amount PR" := Ind."Real Amount";
                                    Ind."User ID" := USERID;
                                    Ind."Last Date Modified" := WORKDATE;

                                END;

                                IF (Ind."Type STC" = Ind."Type STC"::"Congé Payé") THEN BEGIN
                                    SalaireBrut := 0;
                                    IF EMP.GET(SalaryLine.Employee) THEN BEGIN
                                        EMP.CALCFIELDS(EMP."Days off =");
                                        JourDroitCongé := EMP."Days off =";
                                    END;
                                    SalaireBrut := CalculerSalaireBrutSTC(SalaryLine.Employee);

                                    MontantCongé := ROUND((JourDroitCongé * SalaireBrut) / 30, 1);
                                    Ind."Real Amount" := MontantCongé;
                                    IF Ind."Real Amount" = 0 THEN Ind."Real Amount" := Ind."Base Amount";
                                    Ind."Real Amount PR" := Ind."Real Amount";
                                    Ind."User ID" := USERID;
                                    Ind."Last Date Modified" := WORKDATE;

                                END;
                                IF (Ind."Type STC" = Ind."Type STC"::Forfaitaire) THEN BEGIN
                                    Ind."Real Amount" := Ind."Base Amount";
                                    Ind."Real Amount PR" := Ind."Real Amount";
                                    Ind."User ID" := USERID;
                                    Ind."Last Date Modified" := WORKDATE;

                                END;

                                IF (Ind."Type STC" = Ind."Type STC"::Preavis) THEN BEGIN
                                    IF EMP.GET(SalaryLine.Employee) THEN EMP.CALCFIELDS("Somme Indemnités");
                                    SalaireBrutSurFiche := 0;
                                    SalaireBrutSurFiche := EMP."Somme Indemnités" + EMP."Basis salary";
                                    Ind."Real Amount" := SalaireBrutSurFiche * EMP."Nombre Salaire Preavis";
                                    Ind."Real Amount PR" := Ind."Real Amount";
                                    Ind."User ID" := USERID;
                                    Ind."Last Date Modified" := WORKDATE;
                                END;

                            END;
                        END;
                    // >> HJ BF 27-01-2014 STC

                    4:
                        BEGIN
                            // MC : Prise en compte du Nombre et Min. garanti -------------------------------------------------------
                            tmp := 0;
                            //MBY 20/01/2009
                            Ind.Rate := Ind.Taux;
                            //END MBY
                            IF Ind."Minimum value" > 0 THEN BEGIN
                                tmp := ROUND(Ind."Base Amount" * Ind.Rate, Ind."Precision Arrondi Montant",
                                                                FORMAT(Ind."Direction Arrondi"));
                                IF tmp < Ind."Minimum value" THEN
                                    Ind."Real Amount" := Ind."Minimum value"
                                ELSE
                                    Ind."Real Amount" := tmp;
                            END
                            ELSE
                                Ind."Real Amount" := Ind."Base Amount" * Ind.Rate;

                            Ind."Real Amount PR" := Ind."Base Amount";


                            // MC -------------------------------------------------------------------------------------------------
                            Ind."User ID" := USERID;
                            Ind."Last Date Modified" := WORKDATE;
                        END;

                END;

                //NE
                IF (SalaryLine.Month > 12) AND (SalaryLine.Month <> 13) AND (SalaryLine.Month <> 15) AND (Ind."Non Inclus en Prime") THEN BEGIN
                    Ind.Rate := 0;
                    Ind."Real Amount" := 0;
                END;

                Defaultind.RESET;
                Defaultind.SETRANGE("Employment Contract Code", SalaryLine."Emplymt. Contract Code");
                Defaultind.SETRANGE("Indemnity Code", Ind.Indemnity);
                Defaultind.FIND('-');
                IF (SalaryLine.Month = 13) AND (Defaultind."Non Inclis en Jours Fer" = TRUE) THEN BEGIN
                    Ind.Rate := 0;
                    Ind."Real Amount" := 0;
                END;

                Ind.MODIFY;
            UNTIL Ind.NEXT = 0;

    end;


    procedure "CalcIndemnitéAvNat"(var SalaryLine: Record "Salary Lines")
    var
        SalaryHeader: Record "Salary Headers";
        Ind: Record "Indemnities";
        ParamRessHum: Record 5218;
        EmploymentContract: Record 5211;
        RegimeWork: Record "Regimes of work";
        bonus: Decimal;
        tmp: Decimal;
        tmp1: Decimal;
    begin
        // calc Indemnité avec Taux
        Ind.SETRANGE("No.", SalaryLine."No.");
        Ind.SETRANGE("Employee No.", SalaryLine.Employee);
        Ind.SETRANGE("Evaluation mode", 6);
        IF Ind.FIND('-') THEN
            REPEAT
                Ind."Base Amount" := SalaryLine."Gross Salary (sans Av)";

                Ind.Rate := SalaryLine."Assiduity (Paid days)";
                // MC : Prise en compte du Min. garanti ---------------------------------------------------------------
                tmp := 0;
                IF Ind."Minimum value" > 0 THEN BEGIN
                    tmp := ROUND(Ind."Base Amount" * Ind.Taux / 100, Ind."Precision Arrondi Montant",
                                                       FORMAT(Ind."Direction Arrondi"));
                    IF tmp < Ind."Minimum value" THEN
                        Ind."Real Amount" := Ind."Minimum value"
                    ELSE
                        Ind."Real Amount" := tmp;
                END
                ELSE
                    Ind."Real Amount" := Ind."Base Amount" * Ind.Taux / 100;

                Ind."Real Amount PR" := ROUND(SalaryLine."Gross Salary (sans Av) PR" * Ind.Taux / 100
                                                         , Ind."Precision Arrondi Montant", FORMAT(Ind."Direction Arrondi"));

                // MC -------------------------------------------------------------------------------------------------
                Ind."User ID" := USERID;
                Ind."Last Date Modified" := WORKDATE;
                IF (SalaryLine.Month > 12) AND (SalaryLine.Month <> 15) AND (Ind."Non Inclus en Prime") THEN BEGIN
                    Ind.Rate := 0;
                    Ind."Real Amount" := 0;
                END;

                Ind.MODIFY;
            UNTIL Ind.NEXT = 0;
    end;


    procedure CalcCotisationSocial1(var SalaryLine: Record "Salary Lines")
    var
        Ind: Record "Indemnities";
        SocialContributions: Record "Social Contributions";
        ParamRessHum: Record 5218;
        temp: Decimal;
        tmp: Decimal;
        tmp1: Decimal;
        bonus: Decimal;
        Cot: Record "Default Soc. Contribution";
        nbr: Integer;
        LigSalEng: Record "Rec. Salary Lines";
        SocialCont: Record "Rec. Social Contributions";
        RecDefaultIndemnities: Record "Default Indemnities";
        LigSalEng1: Record "Rec. Salary Lines";
        RecLIndemnities: Record "Indemnities";
        RetenuCNNS: Decimal;
    begin
        //--> Calcul des cotisations sociales
        SocialContributions.SETRANGE("No.", SalaryLine."No.");
        SocialContributions.SETRANGE(Employee, SalaryLine.Employee);
        IF ParamRessHum.GET THEN;
        PlafondBrutPourCotisSocial := ParamRessHum."Plafond Cotisation Social";
        IF SocialContributions.FIND('-') THEN
            REPEAT
                RetenuCNNS := 0;
                CASE SocialContributions."Mode dévaluation" OF
                    0:
                        BEGIN // Montant = Base * Taux
                            IF SocialContributions.Indemnity = ''
                             THEN BEGIN
                                Cot.RESET;
                                Cot.SETRANGE("Employment Contract Code", SalaryLine."Emplymt. Contract Code");
                                Cot.SETRANGE("Social Contribution Code", SocialContributions."Social Contribution");
                                IF NOT Cot.FIND('-') THEN
                                    ERROR('Cotisation sociale %1 introuvable sur contrat de travail : %2.',
                                           Cot."Social Contribution Code", Cot."Employment Contract Code");

                                CASE Cot."Basis of calculation" OF
                                    0:
                                        IF SalaryLine."Gross Salary" < PlafondBrutPourCotisSocial THEN BEGIN
                                            IF 1 = 1 THEN BEGIN
                                                RecLIndemnities.SETRANGE("No.", SalaryLine."No.");
                                                RecLIndemnities.SETRANGE("Employee No.", SalaryLine.Employee);
                                                RecLIndemnities.SETRANGE("Non Inclue en Calcul CNSS", TRUE);
                                                IF RecLIndemnities.FINDFIRST THEN
                                                    REPEAT
                                                        RetenuCNNS += RecLIndemnities."Real Amount";
                                                    UNTIL RecLIndemnities.NEXT = 0;
                                            END;
                                            SocialContributions."Base Amount" := ROUND(SalaryLine."Gross Salary", ParamCpta."Amount Rounding Precision") -
                                                                                   RetenuCNNS
                                        END
                                        ELSE
                                            SocialContributions."Base Amount" := PlafondBrutPourCotisSocial;
                                    3:
                                        IF SalaryLine."Gross Salary" < PlafondBrutPourCotisSocial THEN
                                            SocialContributions."Base Amount" := ROUND(SalaryLine."Taxable salary", ParamCpta."Amount Rounding Precision")
                                        ELSE
                                            SocialContributions."Base Amount" := PlafondBrutPourCotisSocial;

                                    2:
                                        BEGIN
                                            IF SalaryLine."Gross Salary" < PlafondBrutPourCotisSocial THEN
                                                SocialContributions."Base Amount" := ROUND(SalaryLine."Basis salary", ParamCpta."Amount Rounding Precision")
                                            ELSE
                                                SocialContributions."Base Amount" := PlafondBrutPourCotisSocial;


                                            //>>MBY 19/02/2010 ENDA

                                            RecDefaultIndemnities.RESET;
                                            RecDefaultIndemnities.SETRANGE("Employment Contract Code", SalaryLine."Emplymt. Contract Code");
                                            RecDefaultIndemnities.SETRANGE("Inclus dans base assurance", TRUE);
                                            IF RecDefaultIndemnities.FIND('-') THEN
                                                REPEAT
                                                    SocialContributions."Base Amount" := ROUND(SocialContributions."Base Amount" + RecDefaultIndemnities."Default amount"
                                                                                           , ParamCpta."Amount Rounding Precision");

                                                UNTIL RecDefaultIndemnities.NEXT = 0
                                            //<<MBY 19/02/2010 ENDA
                                        END;

                                    1:
                                        BEGIN
                                            // NE cotisation
                                            SocialCont.RESET;
                                            SocialCont.SETCURRENTKEY("Social Contribution", Employee, "year of Calculate");
                                            SocialCont.SETFILTER("Social Contribution", SocialContributions."Social Contribution");
                                            SocialCont.SETFILTER(Employee, SalaryLine.Employee);
                                            SocialCont.SETRANGE("year of Calculate", SalaryLine."year of Calculate");
                                            SocialCont.CALCSUMS("Base Amount");

                                            LigSalEng.RESET;
                                            LigSalEng.SETCURRENTKEY(Employee, "year of Calculate", Month, "Type Prime");
                                            LigSalEng.SETFILTER(Employee, SalaryLine.Employee);
                                            LigSalEng.SETFILTER("year of Calculate", '%1', SalaryLine."year of Calculate");
                                            LigSalEng.CALCSUMS("Gross Salary", "6 * SMIG");
                                            // MESSAGE(FORMAT(LigSalEng."Gross Salary"));
                                            // AGA CALCUL CAVIS PAR ANS 27/12/2011
                                            LigSalEng1.RESET;
                                            LigSalEng1.SETCURRENTKEY(Employee, "year of Calculate", Month, "Type Prime");
                                            LigSalEng1.SETFILTER(Employee, SalaryLine.Employee);
                                            LigSalEng1.SETFILTER(Month, '<%1', 12);
                                            LigSalEng1.SETRANGE("year of Calculate", SalaryLine."year of Calculate");
                                            LigSalEng1.CALCSUMS("Gross Salary", "6 * SMIG");
                                            IF LigSalEng1.COUNT > 11 THEN
                                                LigSalEng1."6 * SMIG" := (LigSalEng1."6 * SMIG" / LigSalEng1.COUNT) * 11;


                                            IF (SalaryLine."Gross Salary" + LigSalEng."Gross Salary") <= (SalaryLine."6 * SMIG" + LigSalEng1."6 * SMIG") THEN BEGIN
                                                IF SocialCont."Base Amount" <> 0 THEN
                                                    SocialContributions."Base Amount" := -SocialCont."Base Amount"
                                                ELSE
                                                    SocialContributions."Base Amount" := 0;
                                            END
                                            ELSE BEGIN
                                                SocialContributions."Base Amount" := ROUND(((SalaryLine."Gross Salary" + LigSalEng."Gross Salary") -
                                                                              (SalaryLine."6 * SMIG" + LigSalEng1."6 * SMIG") - SocialCont."Base Amount"),
                                                                              ParamCpta."Amount Rounding Precision");
                                            END;




                                            IF SocialContributions."Forfait salarial" > 0
                                              THEN
                                                SocialContributions."Real Amount : Employee" := ROUND(SocialContributions."Forfait salarial",
                                                                                                ParamCpta."Amount Rounding Precision");
                                            IF SocialContributions."Forfait patronal" > 0
                                              THEN
                                                SocialContributions."Real Amount : Employer" := ROUND(SocialContributions."Forfait patronal",
                                                                                                ParamCpta."Amount Rounding Precision");
                                            SocialContributions."Real Amount : Employee PR" := ROUND(SocialContributions."Forfait salarial",
                                                                                                    ParamCpta."Amount Rounding Precision");
                                        END;
                                END;
                            END
                            ELSE BEGIN
                                Ind.RESET;
                                Ind.SETRANGE("No.", SalaryLine."No.");
                                Ind.SETRANGE("Employee No.", SalaryLine.Employee);
                                Ind.SETRANGE(Indemnity, SocialContributions.Indemnity);
                                IF Ind.FIND('-') THEN
                                    SocialContributions."Base Amount" := ROUND(Ind."Real Amount", ParamCpta."Amount Rounding Precision");
                            END;
                            SocialContributions."Real Amount : Employee" := ROUND(SocialContributions."Base Amount"
                                                                          * SocialContributions."Employee's part"
                                                                          / 100, ParamCpta."Amount Rounding Precision");
                            IF Cot."Basis of calculation" = 0 THEN
                                SocialContributions."Real Amount : Employee PR" := ROUND(SalaryLine."Gross Salary PR"
                                                                              * SocialContributions."Employee's part"
                                                                              / 100, ParamCpta."Amount Rounding Precision");

                            IF SocialContributions."Maximum value - Employee" > 0 THEN BEGIN
                                IF SocialContributions."Real Amount : Employee" > SocialContributions."Maximum value - Employee" THEN
                                    SocialContributions."Real Amount : Employee" := SocialContributions."Maximum value - Employee";
                            END;

                            SocialContributions."Real Amount : Employer" := ROUND(SocialContributions."Base Amount"
                                                                          * SocialContributions."Employer's part"
                                                                          / 100, ParamCpta."Amount Rounding Precision");
                            IF SocialContributions."Maximum value - Employer" > 0 THEN BEGIN
                                IF SocialContributions."Real Amount : Employer" > SocialContributions."Maximum value - Employer" THEN
                                    SocialContributions."Real Amount : Employer" := SocialContributions."Maximum value - Employer";
                            END;
                        END;

                    3:
                        BEGIN// Montant = Brut (sans Av) * Taux
                            IF SocialContributions.Indemnity = ''
                             THEN BEGIN
                                //MESSAGE('%1  %2',SalaryLine.Employee,SalaryLine."Gross Salary (sans Av)");
                                Cot.RESET;
                                Cot.SETRANGE("Employment Contract Code", SalaryLine."Emplymt. Contract Code");
                                Cot.SETRANGE("Social Contribution Code", SocialContributions."Social Contribution");
                                IF NOT Cot.FIND('-') THEN
                                    ERROR('Cotisation sociale %1 introuvable sur contrat de travail : %2.',
                                           Cot."Social Contribution Code", Cot."Employment Contract Code");
                                CASE Cot."Basis of calculation" OF
                                    0:
                                        SocialContributions."Base Amount" := ROUND(SalaryLine."Gross Salary (sans Av)"
                                                                                 , ParamCpta."Amount Rounding Precision");
                                    2:
                                        BEGIN
                                            SocialContributions."Base Amount" := SalaryLine."Basis salary";
                                            // RAMZI 17/02/06

                                        END;

                                    1:
                                        BEGIN
                                            tmp1 := 0;
                                            tmp1 := 6 * ParamRessHum."Minimum wage guarantee";
                                            IF (tmp1 < SalaryLine."Gross Salary (sans Av)") THEN
                                                SocialContributions."Base Amount" := ROUND(SalaryLine."Gross Salary (sans Av)" - tmp1,
                                                                                     ParamCpta."Amount Rounding Precision")
                                            ELSE
                                                SocialContributions."Base Amount" := 0;
                                            IF SocialContributions."Forfait salarial" > 0
                                              THEN
                                                SocialContributions."Real Amount : Employee" := ROUND(SocialContributions."Forfait salarial",
                                                                                                ParamCpta."Amount Rounding Precision");
                                            IF SocialContributions."Forfait patronal" > 0
                                              THEN
                                                SocialContributions."Real Amount : Employer" := ROUND(SocialContributions."Forfait patronal",
                                                                                                ParamCpta."Amount Rounding Precision");
                                            SocialContributions."Real Amount : Employee PR" := ROUND(SocialContributions."Forfait salarial",
                                                                                                    ParamCpta."Amount Rounding Precision");
                                        END;
                                END;
                                // MESSAGE('%1  %2  %3',SalaryLine.Employee,SalaryLine."Gross Salary (sans Av)",SocialContributions."Base Amount");

                            END

                            ELSE BEGIN
                                Ind.RESET;
                                Ind.SETRANGE("No.", SalaryLine."No.");
                                Ind.SETRANGE("Employee No.", SalaryLine.Employee);
                                Ind.SETRANGE(Indemnity, SocialContributions.Indemnity);
                                IF Ind.FIND('-') THEN
                                    SocialContributions."Base Amount" := ROUND(Ind."Real Amount", ParamCpta."Amount Rounding Precision");
                            END;
                            SocialContributions."Real Amount : Employee" := ROUND(SocialContributions."Base Amount"
                                                                          * SocialContributions."Employee's part"
                                                                          / 100, ParamCpta."Amount Rounding Precision");
                            IF Cot."Basis of calculation" = 0 THEN
                                SocialContributions."Real Amount : Employee PR" := ROUND(SalaryLine."Gross Salary (sans Av) PR"
                                                                              * SocialContributions."Employee's part"
                                                                              / 100, ParamCpta."Amount Rounding Precision");

                            IF SocialContributions."Maximum value - Employee" > 0 THEN BEGIN
                                IF SocialContributions."Real Amount : Employee" > SocialContributions."Maximum value - Employee" THEN
                                    SocialContributions."Real Amount : Employee" := SocialContributions."Maximum value - Employee";
                            END;

                            SocialContributions."Real Amount : Employer" := ROUND(SocialContributions."Base Amount"
                                                                          * SocialContributions."Employer's part"
                                                                          / 100, ParamCpta."Amount Rounding Precision");
                            IF SocialContributions."Maximum value - Employer" > 0 THEN BEGIN
                                IF SocialContributions."Real Amount : Employer" > SocialContributions."Maximum value - Employer" THEN
                                    SocialContributions."Real Amount : Employer" := SocialContributions."Maximum value - Employer";
                            END;
                        END;
                    2:
                        SocialContributions."Base Amount" := ROUND(SalaryLine."Basis salary", ParamCpta."Amount Rounding Precision");

                    1:
                        BEGIN // Montant forfaitaire
                            SocialContributions."Real Amount : Employee" := SocialContributions."Forfait salarial";
                            SocialContributions."Real Amount : Employee PR" := SocialContributions."Forfait salarial";
                            SocialContributions."Real Amount : Employer" := SocialContributions."Forfait patronal";
                        END;
                END;

                SocialContributions."User ID" := USERID;
                SocialContributions."Last Date Modified" := WORKDATE;
                // >> HJ BF 21-01-2014 Apmliquer Regele (SBASE+Sursalaire)*8%
                IF SocialContributions."Plafond SBase*8%" THEN BEGIN
                    PlafonfSBase8Pct := CalculerSalBasePlusSursalaire(SalaryLine, SalaryLine.Employee);
                    IF (SocialContributions."Real Amount : Employee" > PlafonfSBase8Pct) AND (PlafonfSBase8Pct > 0) THEN BEGIN
                        SocialContributions."Real Amount : Employee" := PlafonfSBase8Pct;
                        SocialContributions."Real Amount : Employee PR" := PlafonfSBase8Pct;
                    END;
                END;
                // >> HJ BF 21-01-2014 Apmliquer Regele (SBASE+Sursalaire)*8%
                SocialContributions."Real Amount : Employee PR" := SocialContributions."Real Amount : Employee";
                IF SocialContributions."Base Amount" = 0 THEN
                    SocialContributions.DELETE
                ELSE
                    SocialContributions.MODIFY;

            UNTIL SocialContributions.NEXT = 0;
    end;


    procedure CalcCotisationSocial2(var SalaryLine: Record "Salary Lines")
    var
        Ind: Record "Indemnities";
        SocialContributions: Record "Social Contributions";
        ParamRessHum: Record 5218;
        temp: Decimal;
        tmp: Decimal;
        tmp1: Decimal;
        bonus: Decimal;
        Cot: Record "Default Soc. Contribution";
        nbr: Integer;
        RecDefaultIndemnities: Record "Default Indemnities";
    begin
        // calc cotisation Social
        SocialContributions.SETRANGE("No.", SalaryLine."No.");
        SocialContributions.SETRANGE(Employee, SalaryLine.Employee);
        SocialContributions.SETFILTER("Mode dévaluation", '%1', 2);
        IF SocialContributions.FIND('-') THEN
            REPEAT
                IF SocialContributions.Indemnity = ''
                 THEN BEGIN
                    Cot.RESET;
                    Cot.SETRANGE("Employment Contract Code", SalaryLine."Emplymt. Contract Code");
                    Cot.SETRANGE("Social Contribution Code", SocialContributions."Social Contribution");
                    IF NOT Cot.FIND('-') THEN
                        ERROR('Cotisation sociale %1 introuvable sur contrat de travail : %2.',
                               Cot."Social Contribution Code", Cot."Employment Contract Code");
                    CASE Cot."Basis of calculation" OF
                        0:
                            SocialContributions."Base Amount" := ROUND(SalaryLine."Taxable salary"
                                                                    , ParamCpta."Amount Rounding Precision");
                        2:
                            BEGIN
                                SocialContributions."Base Amount" := SalaryLine."Basis salary";
                                //>>MBY 19/02/2010 ENDA
                                RecDefaultIndemnities.RESET;
                                RecDefaultIndemnities.SETRANGE("Employment Contract Code", SalaryLine."Emplymt. Contract Code");
                                RecDefaultIndemnities.SETRANGE("Inclus dans base assurance", TRUE);
                                IF RecDefaultIndemnities.FIND('-') THEN
                                    REPEAT
                                        SocialContributions."Base Amount" := ROUND(SocialContributions."Base Amount" + RecDefaultIndemnities."Default amount"
                                       , ParamCpta."Amount Rounding Precision");
                                    UNTIL RecDefaultIndemnities.NEXT = 0
                                //<<MBY 19/02/2010 ENDA

                            END;
                        1:
                            BEGIN
                                tmp1 := 0;
                                tmp1 := 6 * ParamRessHum."Minimum wage guarantee";
                                IF (tmp1 < SalaryLine."Gross Salary") THEN
                                    SocialContributions."Base Amount" := ROUND(SalaryLine."Taxable salary" - tmp1,
                                                                         ParamCpta."Amount Rounding Precision")
                                ELSE
                                    SocialContributions."Base Amount" := 0;
                                IF SocialContributions."Forfait salarial" > 0
                                  THEN
                                    SocialContributions."Real Amount : Employee" := ROUND(SocialContributions."Forfait salarial",
                                                                                    ParamCpta."Amount Rounding Precision");
                                IF SocialContributions."Forfait patronal" > 0
                                  THEN
                                    SocialContributions."Real Amount : Employer" := ROUND(SocialContributions."Forfait patronal",
                                                                                    ParamCpta."Amount Rounding Precision");
                            END;
                    END;
                END
                ELSE BEGIN
                    Ind.RESET;
                    Ind.SETRANGE("No.", SalaryLine."No.");
                    Ind.SETRANGE("Employee No.", SalaryLine.Employee);
                    Ind.SETRANGE(Indemnity, SocialContributions.Indemnity);
                    IF Ind.FIND('-') THEN
                        SocialContributions."Base Amount" := ROUND(Ind."Real Amount", ParamCpta."Amount Rounding Precision");
                END;
                SocialContributions."Real Amount : Employee" := ROUND(SocialContributions."Base Amount"
                                                              * SocialContributions."Employee's part"
                                                              / 100, ParamCpta."Amount Rounding Precision");
                IF SocialContributions."Maximum value - Employee" > 0 THEN BEGIN
                    IF SocialContributions."Real Amount : Employee" > SocialContributions."Maximum value - Employee" THEN
                        SocialContributions."Real Amount : Employee" := SocialContributions."Maximum value - Employee";
                END;

                SocialContributions."Real Amount : Employer" := ROUND(SocialContributions."Base Amount"
                                                              * SocialContributions."Employer's part"
                                                              / 100, ParamCpta."Amount Rounding Precision");
                IF SocialContributions."Maximum value - Employer" > 0 THEN BEGIN
                    IF SocialContributions."Real Amount : Employer" > SocialContributions."Maximum value - Employer" THEN
                        SocialContributions."Real Amount : Employer" := SocialContributions."Maximum value - Employer";
                END;
                //END;
                SocialContributions."User ID" := USERID;
                SocialContributions."Last Date Modified" := WORKDATE;
                SocialContributions.MODIFY;

            UNTIL SocialContributions.NEXT = 0;
        CalcAllTaxe(SalaryLine);
    end;


    procedure CalcImpotAn(var SalaryLine: Record "Salary Lines")
    var
        ParamRessHum: Record 5218;
        temp: Decimal;
        EmploymentContract: Record 5211;
        RegimeWork: Record "Regimes of work";
        Employee: Record 5200;
        SliceImposition: Record "Slices of imposition";
        SliceImpositionX: Record "Slices of imposition";
    begin
        //--> Calcul de l'impôt
        Employee.GET(SalaryLine.Employee);
        IF EmploymentContract.GET(Employee."Emplymt. Contract Code") THEN BEGIN
            IF EmploymentContract.Taxable THEN BEGIN
                CASE EmploymentContract."Calculation mode of the taxes" OF
                    0:
                        BEGIN
                            //--> Barème standard
                            temp := 0;
                            //MBY 20/01/2009
                            SliceImposition.RESET;
                            SliceImposition.SETRANGE(Code, EmploymentContract."Slice of imposition");
                            //END MBY
                            IF SliceImposition.FIND('-') THEN
                                REPEAT
                                    //--> Cumul des tranches inf.
                                    IF ((SalaryLine."Real taxable (Year)" > SliceImposition."Lower limit")
                                        AND
                                        (SalaryLine."Real taxable (Year)" > SliceImposition."Superior limit")
                                       ) THEN
                                        temp := temp + SliceImposition."Slice amount";

                                    //--> Recherche de la tranche d'imposition
                                    IF ((SliceImposition."Lower limit" < SalaryLine."Real taxable (Year)")
                                        AND
                                        (SalaryLine."Real taxable (Year)" <= SliceImposition."Superior limit")
                                       )
                                       OR
                                       ((SalaryLine."Real taxable (Year)" > SliceImposition."Superior limit")
                                        AND
                                        (SalaryLine."Real taxable (Year)" > SliceImposition."Lower limit")
                                        AND
                                        (SliceImposition."Lower limit" > SliceImposition."Superior limit")
                                       ) THEN
                                        SliceImpositionX.COPY(SliceImposition);

                                UNTIL SliceImposition.NEXT = 0;

                            SalaryLine."Taxe (Year)" := ROUND(((SalaryLine."Real taxable (Year)" - SliceImpositionX."Lower limit")
                                                        * SliceImpositionX.Rate / 100) + temp, ParamCpta."Amount Rounding Precision");

                            //MESSAGE('SalaryLine."Taxe (Year)" %1',SalaryLine."Taxe (Year)");
                        END;
                    1:
                        BEGIN
                            //--> Forfait
                            SalaryLine."Taxe (Year)" := ROUND(SalaryLine."Real taxable (Year)"
                                                            * EmploymentContract."Inclusive ratio" / 100, ParamCpta."Amount Rounding Precision")
             ;
                        END;
                END;
            END
            ELSE
                SalaryLine."Taxe (Year)" := 0;

        END;
        //--> Calcul de l'impôt
        Employee.GET(SalaryLine.Employee);
        IF EmploymentContract.GET(Employee."Emplymt. Contract Code") THEN BEGIN
            IF EmploymentContract.Taxable THEN BEGIN
                CASE EmploymentContract."Calculation mode of the taxes" OF
                    0:
                        BEGIN
                            //--> Barème standard
                            temp := 0;
                            //MBY 20/01/2009
                            SliceImposition.RESET;
                            SliceImposition.SETRANGE(Code, EmploymentContract."Slice of imposition");
                            //END MBY

                            IF SliceImposition.FIND('-') THEN
                                REPEAT
                                    //--> Cumul des tranches inf.
                                    IF ((SalaryLine."Real taxable (Year)" > SliceImposition."Lower limit")
                                        AND
                                        (SalaryLine."Real taxable (Year)" > SliceImposition."Superior limit")
                                       ) THEN
                                        temp := temp + SliceImposition."Slice amount";

                                    //--> Recherche de la tranche d'imposition
                                    IF ((SliceImposition."Lower limit" < SalaryLine."Real taxable (Year)")
                                        AND
                                        (SalaryLine."Real taxable (Year)" < SliceImposition."Superior limit")
                                       )
                                       OR
                                       ((SalaryLine."Real taxable (Year)" > SliceImposition."Superior limit")
                                        AND
                                        (SalaryLine."Real taxable (Year)" > SliceImposition."Lower limit")
                                        AND
                                        (SliceImposition."Lower limit" > SliceImposition."Superior limit")
                                       ) THEN
                                        SliceImpositionX.COPY(SliceImposition);

                                UNTIL SliceImposition.NEXT = 0;

                            SalaryLine."Taxe (Year)" := ROUND(((SalaryLine."Real taxable (Year)" - SliceImpositionX."Lower limit")
                                                        * SliceImpositionX.Rate / 100) + temp, ParamCpta."Amount Rounding Precision");

                        END;
                    1:
                        BEGIN
                            //--> Forfait
                            SalaryLine."Taxe (Year)" := ROUND(SalaryLine."Real taxable (Year)"
                                                            * EmploymentContract."Inclusive ratio" / 100, ParamCpta."Amount Rounding Precision")
             ;
                        END;
                END;
            END
            ELSE
                SalaryLine."Taxe (Year)" := 0;

        END;
        //--> Calcul de l'impôt PR
        Employee.GET(SalaryLine.Employee);
        IF EmploymentContract.GET(Employee."Emplymt. Contract Code") THEN BEGIN
            IF EmploymentContract.Taxable THEN BEGIN
                CASE EmploymentContract."Calculation mode of the taxes" OF
                    0:
                        BEGIN
                            //--> Barème standard
                            temp := 0;
                            //MBY 20/01/2009
                            SliceImposition.RESET;
                            SliceImposition.SETRANGE(Code, EmploymentContract."Slice of imposition");
                            //END MBY

                            IF SliceImposition.FIND('-') THEN
                                REPEAT
                                    //--> Cumul des tranches inf.
                                    IF ((SalaryLine."Real Taxable PR (Year)" > SliceImposition."Lower limit")
                                        AND
                                        (SalaryLine."Real Taxable PR (Year)" > SliceImposition."Superior limit")
                                       ) THEN
                                        temp := temp + SliceImposition."Slice amount";

                                    //--> Recherche de la tranche d'imposition
                                    IF ((SliceImposition."Lower limit" < SalaryLine."Real taxable (Year)")
                                        AND
                                        (SalaryLine."Real Taxable PR (Year)" < SliceImposition."Superior limit")
                                       )
                                       OR
                                       ((SalaryLine."Real Taxable PR (Year)" > SliceImposition."Superior limit")
                                        AND
                                        (SalaryLine."Real Taxable PR (Year)" > SliceImposition."Lower limit")
                                        AND
                                        (SliceImposition."Lower limit" > SliceImposition."Superior limit")
                                       ) THEN
                                        SliceImpositionX.COPY(SliceImposition);

                                UNTIL SliceImposition.NEXT = 0;

                            SalaryLine."Taxe PR (Year)" := ROUND(((SalaryLine."Real Taxable PR (Year)" - SliceImpositionX."Lower limit")
                                                        * SliceImpositionX.Rate / 100) + temp, ParamCpta."Amount Rounding Precision");

                        END;
                    1:
                        BEGIN
                            //--> Forfait
                            SalaryLine."Taxe PR (Year)" := ROUND(SalaryLine."Real Taxable PR (Year)"
                                                            * EmploymentContract."Inclusive ratio" / 100, ParamCpta."Amount Rounding Precision")
             ;
                        END;
                END;
            END
            ELSE
                SalaryLine."Taxe PR (Year)" := 0;

        END;
        // Calcul Impôt mensuel
        Employee.GET(SalaryLine.Employee);
        IF EmploymentContract.GET(Employee."Emplymt. Contract Code") THEN BEGIN
            IF EmploymentContract.Taxable THEN BEGIN
                CASE EmploymentContract."Calculation mode of the taxes" OF
                    0:
                        BEGIN
                            //--> Barème standard
                            temp := 0;
                            //MBY 20/01/2009
                            SliceImposition.RESET;
                            SliceImposition.SETRANGE(Code, EmploymentContract."Slice of imposition");
                            //END MBY

                            IF SliceImposition.FIND('-') THEN
                                REPEAT
                                    //--> Cumul des tranches inf.
                                    IF ((SalaryLine."Real Taxable PR (Year)" > SliceImposition."Lower limit")
                                        AND
                                        (SalaryLine."Real Taxable PR (Year)" > SliceImposition."Superior limit")
                                       ) THEN
                                        temp := temp + SliceImposition."Slice amount";

                                    //--> Recherche de la tranche d'imposition
                                    IF ((SliceImposition."Lower limit" < SalaryLine."Real Taxable PR (Year)")
                                        AND
                                        (SalaryLine."Real Taxable PR (Year)" < SliceImposition."Superior limit")
                                       )
                                       OR
                                       ((SalaryLine."Real Taxable PR (Year)" > SliceImposition."Superior limit")
                                        AND
                                        (SalaryLine."Real Taxable PR (Year)" > SliceImposition."Lower limit")
                                        AND
                                        (SliceImposition."Lower limit" > SliceImposition."Superior limit")
                                       ) THEN
                                        SliceImpositionX.COPY(SliceImposition);

                                UNTIL SliceImposition.NEXT = 0;

                            SalaryLine."Taxe PR (Year)" := ROUND(((SalaryLine."Real Taxable PR (Year)" - SliceImpositionX."Lower limit")
                                                        * SliceImpositionX.Rate / 100) + temp, ParamCpta."Amount Rounding Precision");

                        END;
                    1:
                        BEGIN
                            //--> Forfait
                            SalaryLine."Taxe PR (Year)" := ROUND(SalaryLine."Real Taxable PR (Year)"
                                                            * EmploymentContract."Inclusive ratio" / 100, ParamCpta."Amount Rounding Precision")
             ;
                        END;
                END;
            END
            ELSE
                SalaryLine."Taxe PR (Year)" := 0;

        END;
    end;


    procedure initLigne(var SalaryLineTmp: Record "Salary Lines"; Sim: Option Simulation,Real,Prime)
    var
        SuppHourLine: Record "Heures sup. eregistrées m";
        LigneTravail: Record "Heures occa. enreg. m";
        Salheader: Record "Salary Headers";
        LignePaie: Record "Salary Lines";
    begin
        LignePaie.RESET;
        LignePaie.SETFILTER("No.", '<>%1', SalaryLineTmp."No.");
        LignePaie.SETFILTER(Employee, SalaryLineTmp.Employee);
        IF LignePaie.FIND('-') AND (Sim = 1) THEN
            ERROR('Vous devez Valider La Paie %1 Avant  !!!!', LignePaie."No.");
        LigneTravail.RESET;
        LigneTravail.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement");
        LigneTravail.SETFILTER("N° Salarié", SalaryLineTmp.Employee);
        LigneTravail.SETRANGE("Mois de paiement", SalaryLineTmp.Month);
        LigneTravail.SETRANGE("Année de paiement", SalaryLineTmp.Year);
        //AGA ---------------------------------------------------------------------------------------
        LigneTravail.SETFILTER("Paiement No.", '%1|%2', SalaryLineTmp."No.", '');

        LigneTravail.MODIFYALL("Paiement No.", '');

        SuppHourLine.RESET;
        SuppHourLine.SETCURRENTKEY("N° Salarié", "Taux de majoration", "Mois de paiement", "Année de paiement");
        SuppHourLine.SETFILTER("N° Salarié", SalaryLineTmp.Employee);
        SuppHourLine.SETFILTER("Mois de paiement", '%1', SalaryLineTmp.Month);
        SuppHourLine.SETFILTER("Année de paiement", '%1', SalaryLineTmp.Year);
        //AGA ---------------------------------------------------------------------------------------
        SuppHourLine.SETFILTER("Paiement No.", '%1|%2', SalaryLineTmp."No.", '');

        SuppHourLine.MODIFYALL("Paiement No.", '');

        CLEAR(Salheader);
        Salheader.GET(SalaryLineTmp."No.");
        SalaryLineTmp."year of Calculate" := Salheader."year of Calculate";
        SalaryLineTmp."Posting Date" := Salheader."Posting Date";
        SalaryLineTmp."Taxable indemnities" := 0;
        SalaryLineTmp."Amount Days Off balacement" := 0;
        SalaryLineTmp."Assiduity (days off balacement" := 0;
        SalaryLineTmp."Hours off Balacement" := 0;
        SalaryLineTmp."Supp. hours" := 0;
        SalaryLineTmp."Type Prime" := Salheader."Type Prime";
        SalaryLineTmp."Gross Salary" := 0;
        SalaryLineTmp.CNSS := 0;
        SalaryLineTmp."Gross Salary (sans Av)" := 0;
        SalaryLineTmp."Taxable indemnities (Not Gross" := 0;
        IF Sim < 2 THEN
            SalaryLineTmp."Gross Salary (sans Av) PR" := 0;
        SalaryLineTmp."Taxable salary" := 0;
        SalaryLineTmp."Deduction Prof. expenses" := 0;
        SalaryLineTmp."Real taxable" := 0;
        SalaryLineTmp."Total taxable rec." := 0;
        SalaryLineTmp."Real taxable (Year)" := 0;
        SalaryLineTmp."Taxe (Year)" := 0;
        SalaryLineTmp."Total taxes rec." := 0;
        SalaryLineTmp."Taxe (Month)" := 0;
        SalaryLineTmp."Non Taxable indemnities" := 0;
        SalaryLineTmp."Taxable Soc. Contrib." := 0;
        SalaryLineTmp."Mission expenses" := 0;
        IF SalaryLineTmp.Month <> SalaryLineTmp.Month::Prime THEN
            SalaryLineTmp."Net salary" := 0;
        SalaryLineTmp.Loans := 0;
        SalaryLineTmp.Advances := 0;
        SalaryLineTmp."Net salary cashed" := 0;
        IF Sim < 2 THEN
            SalaryLineTmp."Taxable indemnities PR" := 0;
        IF Sim < 2 THEN
            SalaryLineTmp."Gross Salary PR" := 0;
        IF Sim < 2 THEN
            SalaryLineTmp."Non Taxable Soc. Contrib. PR" := 0;
        SalaryLineTmp."Taxable indem. PR (Not Gross)" := 0;
        IF Sim < 2 THEN
            SalaryLineTmp."Taxable salary PR" := 0;
        IF Sim < 2 THEN
            SalaryLineTmp."Real taxable PR" := 0;
        SalaryLineTmp."Real Taxable PR (Year)" := 0;
        SalaryLineTmp."Taxe PR (Month)" := 0;
        SalaryLineTmp."Taxe PR (Year)" := 0;
        SalaryLineTmp."6 * SMIG" := 0;
        SalaryLineTmp.Month := SalaryLineTmp.Month;
        LignePaie.Year := SalaryLineTmp.Year;

        CASE DATE2DMY(Salheader."Posting Date", 2) OF
            1, 2, 3:
                SalaryLineTmp.Trimestre := 1;
            4, 5, 6:
                SalaryLineTmp.Trimestre := 2;
            7, 8, 9:
                SalaryLineTmp.Trimestre := 3;
            10, 11, 12:
                SalaryLineTmp.Trimestre := 4;
        END;
    end;


    procedure "CréerLignePrime"(var SalaryHeader: Record "Salary Headers"; Employee: Record 5200) OK: Boolean
    var
        SalaryLine: Record "Salary Lines";
        EmploymentContract: Record 5211;
        err1: Label 'Regime of work empty on Employment contract : %1';
        err2: Label 'Employment contract empty for the employee : %1';
        DefaultSocContribution: Record "Default Soc. Contribution";
        SocialContributions: Record "Social Contributions";
        SocialContribution: Record "Social Contribution";
        DefaultIndemnities: Record "Default Indemnities";
        Indemnities: Record "Indemnities";
        confMess: Label 'Replace the existing line ?';
        creator: Label 'Line created by :';
        nbr: Integer;
        ParamRessHum: Record 5218;
        EntPaie2: Record "Rec. Salary Headers";
        PrimeType: Record "Prime1";
        LoanAD: Record "Loan & Advance Header";
    begin
        SalaryLine.RESET;
        Employee.MAJDeductions;
        ParamCpta.GET;
        SalaryLine.SETRANGE("No.", SalaryHeader."No.");
        SalaryLine.SETRANGE(Employee, Employee."No.");
        IF SalaryLine.FIND('-') THEN BEGIN
            IF CONFIRM(confMess + '\%1\' + creator + ' %2 %3', FALSE
                                                              , Employee."No." + ' : ' + Employee.FullName()
                                                              , SalaryLine."User ID"
                                                              , SalaryLine."Last Date Modified")
              THEN
                DeleteLine(SalaryLine)
            ELSE
                EXIT(FALSE);
        END;


        SalaryLine.RESET;

        ParamRessHum.GET();

        SalaryLine."No." := SalaryHeader."No.";
        SalaryLine.Employee := Employee."No.";
        SalaryLine."Salaire Net Contrat" := Employee."Salaire Net Contrat";
        SalaryLine."Num Mobile Money" := Employee."Num Mobile Money";
        SalaryLine.Name := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
        SalaryLine."Employee Posting Group" := Employee."Employee Posting Group";
        SalaryLine."Statistics Group Code" := Employee."Statistics Group Code";
        SalaryLine."Global Dimension 1" := Employee."Global Dimension 1 Code";
        SalaryLine."Global Dimension 2" := Employee."Global Dimension 2 Code";
        SalaryLine."Code Mode Réglement" := Employee."Mode de règlement";
        SalaryLine."Posting Date" := SalaryHeader."Posting Date";
        SalaryLine."Type Prime" := SalaryHeader."Type Prime";
        IF Employee."Emplymt. Contract Code" <> '' THEN BEGIN
            EmploymentContract.GET(Employee."Emplymt. Contract Code");
            SalaryLine."Emplymt. Contract Code" := Employee."Emplymt. Contract Code";
            IF EmploymentContract."Regimes of work" <> '' THEN
                SalaryLine."Employee Regime of work" := EmploymentContract."Regimes of work"
            ELSE
                ERROR(err1, EmploymentContract.Code + ' - ' + EmploymentContract.Description);
        END
        ELSE
            ERROR(err2, Employee."No." + ' - ' + Employee."First Name" + ' ' + Employee."Last Name");
        CLEAR(Bnk);
        Bnk.RESET;
        IF Employee."Default Bank Account Code" <> '' THEN
            Bnk.GET(Employee."No.", Employee."Default Bank Account Code");
        SalaryLine."Num Compte" := Bnk."Bank Account No.";

        EntPaie2.RESET;
        EntPaie2.SETRANGE("year of Calculate", SalaryHeader."year of Calculate");
        EntPaie2.SETRANGE(Month, 0, 11);
        IF SalaryHeader."Posting Date" = DMY2DATE(26, 3, 2005) THEN
            EntPaie2.SETRANGE(Month, 0, 2);

        IF EntPaie2.FIND('+') THEN
            CASE DATE2DMY(EntPaie2."Posting Date", 2) OF
                3:
                    SalaryLine.Trimestre := 1;
                6:
                    SalaryLine.Trimestre := 2;
                9:
                    SalaryLine.Trimestre := 3;
                12:
                    SalaryLine.Trimestre := 4;
            END;

        SalaryLine.Description := SalaryHeader.Description;
        SalaryLine.Month := SalaryHeader.Month;
        SalaryLine.Year := SalaryHeader.Year;
        SalaryLine."Bank Account Code" := Employee."Default Bank Account Code";
        SalaryLine."Employee's type" := Employee."Employee's type";
        SalaryLine."Adjustment of absences" := 0;
        SalaryLine."Assiduity (Paid days)" := 0;
        SalaryLine."Assiduity (Worked days)" := 0;
        SalaryLine.Note := 0;
        SalaryLine.Pourcentage := 0;
        SalaryLine."Amount Days Off balacement" := 0;
        SalaryLine."Assiduity (days off balacement" := 0;
        SalaryLine."Mois travaillés" := EmploymentContract."Regular payments";
        SalaryLine."Basis salary" := Employee."Basis salary";
        //>>DSFT-AGA 15/08/2010
        LoanAD.RESET;
        LoanAD.SETFILTER(Employee, SalaryLine.Employee);
        LoanAD.SETRANGE(Type, LoanAD.Type::Loan);
        LoanAD.SETRANGE(Status, LoanAD.Status::"In progress");
        LoanAD.SETRANGE("Not include", TRUE);
        LoanAD.SETRANGE("Avance Sur Prime", FALSE);
        LoanAD.SETRANGE("Avance Repas", FALSE);
        IF LoanAD.FIND('-') THEN
            IF CONFIRM('Voulez Vous inclure  Le prêt du salarier'
               + ' ' + FORMAT(SalaryLine.Employee) + ' '
               + SalaryLine.Name + ' pour le mois de ' + FORMAT(SalaryLine.Month), TRUE, FALSE) THEN BEGIN
                LoanAD."Not include" := FALSE;
                LoanAD.MODIFY;
            END;
        //>>DSFT-AGA 15/08/2010




        SalaryLine."User ID" := USERID;
        SalaryLine."Last Date Modified" := WORKDATE;

        nbr := 12;
        EmploymentContract.RESET;
        Employee.RESET;
        Employee.GET(SalaryLine.Employee);
        EmploymentContract.GET(Employee."Emplymt. Contract Code");
        CASE ParamRessHum."Number of monthes" OF
            0:
                nbr := EmploymentContract."Regular payments";
            1:
                nbr := EmploymentContract."Temporary payments";
            2:
                nbr := EmploymentContract."Regular payments" + EmploymentContract."Temporary payments";
        END;
        IF Employee."Familly chief" THEN
            SalaryLine."Deduction Family chief" := ROUND(ParamRessHum."Deduction for Familly Chief" / nbr,
                                                    ParamCpta."Amount Rounding Precision")
        ELSE
            SalaryLine."Deduction Family chief" := 0;
        Employee.CALCFIELDS("Deduction Loaded child");
        SalaryLine."Deduction Loaded child" := ROUND(Employee."Deduction Loaded child" / nbr,
                                                ParamCpta."Amount Rounding Precision");

        /*IF TRUE AND (SalaryLine.Month>(EmploymentContract."Regular payments"-1)) THEN
          BEGIN
            SalaryLine."Deduction Family chief"  := 0;
            SalaryLine."Deduction Loaded child"  := 0;
          END;*/
        SalaryLine."Deduction Prof. expenses" := 0;
        CalculerFieldsPaie(SalaryLine, 1);
        IF SalaryLine.INSERT THEN BEGIN
            // Liste des indemnités du salarié en cour
            DefaultIndemnities.RESET;
            DefaultIndemnities.SETRANGE("Employment Contract Code", Employee."Emplymt. Contract Code");
            IF (SalaryLine.Month > 12) AND (SalaryLine.Month <> 15) THEN BEGIN
                //DefaultIndemnities.SETRANGE ("Type Indemnité",0);
                DefaultIndemnities.SETRANGE("Non Inclus en Prime", FALSE);
            END;
            IF DefaultIndemnities.FIND('-') THEN
                REPEAT

                BEGIN
                    Indemnities.INIT;
                    Indemnities."No." := SalaryLine."No.";
                    Indemnities."Employee No." := SalaryLine.Employee;
                    Indemnities.Indemnity := DefaultIndemnities."Indemnity Code";
                    Indemnities."Employee Posting Group" := SalaryLine."Employee Posting Group";
                    Indemnities."Employee Statistic Group" := SalaryLine."Statistics Group Code";
                    Indemnities."Global Dimension 1" := SalaryLine."Global Dimension 1";
                    Indemnities."Global Dimension 2" := SalaryLine."Global Dimension 2";
                    Indemnities.Description := DefaultIndemnities.Description;
                    Indemnities.Type := DefaultIndemnities.Type;
                    Indemnities."Evaluation mode" := DefaultIndemnities."Evaluation mode";
                    Indemnities."Type Indemnité" := DefaultIndemnities."Type Indemnité";
                    Indemnities."Minimum value" := DefaultIndemnities."Minimum value";
                    Indemnities.Nom := Employee.FullName();
                    Indemnities."Precision Arrondi Montant" := DefaultIndemnities."Precision Arrondi Montant";
                    Indemnities."Direction Arrondi" := DefaultIndemnities."Direction Arrondi";

                    Indemnities."User ID" := USERID;
                    Indemnities."Last Date Modified" := WORKDATE;
                    Indemnities.Taux := DefaultIndemnities.Taux;
                    Indemnities."Base Amount" := (DefaultIndemnities."Default amount");

                    Indemnities."Real Amount" := 0;
                    Indemnities."Non Inclis en AV NAt" := DefaultIndemnities."Non Inclis en AV NAt";
                    Indemnities."Non Inclus en Prime" := DefaultIndemnities."Non Inclus en Prime";
                    Indemnities."Non Inclue en jours congé" := DefaultIndemnities."Non Inclue en jours congé";

                    Ins := TRUE;
                    IF Indemnities."Type Indemnité" = 1 THEN BEGIN
                        Ins := FALSE;
                        IF CONFIRM(STRSUBSTNO('Indemnité %1 Pour L''Employer %2 Montant de Base est de %3 n''est Pas une Indemnité Régulière',
                           Indemnities.Description, Indemnities."Employee No." + ' ' + Indemnities.Nom, Indemnities."Base Amount"), FALSE, TRUE) THEN
                            Ins := TRUE;
                    END;
                    IF Ins THEN
                        IF Indemnities.INSERT THEN BEGIN
                            // Cotisations à appliquer à des Indmennités particulières
                            DefaultSocContribution.RESET;
                            DefaultSocContribution.SETRANGE("Employment Contract Code", Employee."Emplymt. Contract Code");
                            DefaultSocContribution.SETRANGE("Indemnity Code", DefaultIndemnities."Indemnity Code");
                            ParamRessHum.GET;
                            IF NOT ParamRessHum."Activer Type Prime" THEN BEGIN
                                IF SalaryLine.Month = SalaryLine.Month::Prime THEN
                                    DefaultSocContribution.SETRANGE("Non Inclus en Prime", FALSE);

                            END ELSE BEGIN

                                CLEAR(PrimeType);
                                IF PrimeType.GET(SalaryLine."Type Prime") THEN;

                                IF ((SalaryLine.Month > 12) AND (SalaryLine.Month <> 15)) OR (PrimeType."Type Calcul" <> 2) THEN
                                    DefaultSocContribution.SETRANGE("Non Inclus en Prime", FALSE);
                            END;
                            IF DefaultSocContribution.FIND('-') THEN
                                REPEAT
                                    SocialContributions.RESET;
                                    SocialContributions."No." := SalaryLine."No.";
                                    SocialContributions.Employee := SalaryLine.Employee;
                                    SocialContributions.Indemnity := DefaultIndemnities."Indemnity Code";
                                    SocialContributions."Social Contribution" := DefaultSocContribution."Social Contribution Code";
                                    SocialContributions."Employee Posting Group" := SalaryLine."Employee Posting Group";
                                    SocialContributions."Employee Statistic Group" := SalaryLine."Statistics Group Code";
                                    SocialContributions."Global Dimension 1" := SalaryLine."Global Dimension 1";
                                    SocialContributions."Global Dimension 2" := SalaryLine."Global Dimension 2";
                                    IF SocialContribution.GET(DefaultSocContribution."Social Contribution Code") THEN
                                        SocialContributions.Description := SocialContribution.Description;
                                    SocialContributions."Employer's part" := DefaultSocContribution."Employer's part";
                                    SocialContributions."Employee's part" := DefaultSocContribution."Employee's part";
                                    SocialContributions."Base Amount" := 0;
                                    SocialContributions."Real Amount : Employee" := 0;
                                    SocialContributions."Real Amount : Employer" := 0;
                                    SocialContributions."Deductible of taxable basis" := DefaultSocContribution."Deductible of taxable basis";
                                    SocialContributions."Maximum value - Employee" := DefaultSocContribution."Maximum value - Employee";
                                    SocialContributions."Maximum value - Employer" := DefaultSocContribution."Maximum value - Employer";

                                    SocialContributions."Mode dévaluation" := DefaultSocContribution."Mode dévaluation";
                                    SocialContributions."Forfait salarial" := DefaultSocContribution."Forfait salarial";
                                    SocialContributions."Forfait patronal" := DefaultSocContribution."Forfait patronal";

                                    SocialContributions."User ID" := USERID;
                                    SocialContributions."Last Date Modified" := WORKDATE;

                                    SocialContributions.INSERT;
                                UNTIL DefaultSocContribution.NEXT = 0;
                        END;
                END;
                UNTIL DefaultIndemnities.NEXT = 0;

            // Cotisations à appliquer à toutes les indemnités
            DefaultSocContribution.RESET;
            DefaultSocContribution.SETRANGE("Employment Contract Code", Employee."Emplymt. Contract Code");
            DefaultSocContribution.SETRANGE("Indemnity Code", '');
            //DefaultSocContribution.SETRANGE ("Non Inclus en Prime",TRUE);
            ParamRessHum.GET;
            IF NOT ParamRessHum."Activer Type Prime" THEN BEGIN
                IF SalaryLine.Month = SalaryLine.Month::Prime THEN
                    DefaultSocContribution.SETRANGE("Non Inclus en Prime", FALSE);

            END ELSE BEGIN

                CLEAR(PrimeType);
                IF PrimeType.GET(SalaryLine."Type Prime") THEN;

                IF ((SalaryLine.Month > 12) AND (SalaryLine.Month <> 15)) OR (PrimeType."Type Calcul" <> 2) THEN
                    DefaultSocContribution.SETRANGE("Non Inclus en Prime", FALSE);
            END;
            IF DefaultSocContribution.FIND('-') THEN
                REPEAT
                    SocialContributions.RESET;
                    SocialContributions."No." := SalaryLine."No.";
                    SocialContributions.Employee := SalaryLine.Employee;
                    SocialContributions.Indemnity := '';
                    SocialContributions."Social Contribution" := DefaultSocContribution."Social Contribution Code";
                    SocialContributions."Employee Posting Group" := SalaryLine."Employee Posting Group";
                    SocialContributions."Employee Statistic Group" := SalaryLine."Statistics Group Code";
                    SocialContributions."Global Dimension 1" := SalaryLine."Global Dimension 1";
                    SocialContributions."Global Dimension 2" := SalaryLine."Global Dimension 2";
                    IF SocialContribution.GET(DefaultSocContribution."Social Contribution Code") THEN
                        SocialContributions.Description := SocialContribution.Description;
                    SocialContributions."Employer's part" := DefaultSocContribution."Employer's part";
                    SocialContributions."Employee's part" := DefaultSocContribution."Employee's part";
                    SocialContributions."Base Amount" := 0;
                    SocialContributions."Real Amount : Employee" := 0;
                    SocialContributions."Real Amount : Employer" := 0;
                    SocialContributions."Deductible of taxable basis" := DefaultSocContribution."Deductible of taxable basis";
                    SocialContributions."Maximum value - Employee" := DefaultSocContribution."Maximum value - Employee";
                    SocialContributions."Maximum value - Employer" := DefaultSocContribution."Maximum value - Employer";

                    SocialContributions."Mode dévaluation" := DefaultSocContribution."Mode dévaluation";
                    SocialContributions."Forfait salarial" := DefaultSocContribution."Forfait salarial";
                    SocialContributions."Forfait patronal" := DefaultSocContribution."Forfait patronal";

                    SocialContributions."User ID" := USERID;
                    SocialContributions."Last Date Modified" := WORKDATE;

                    SocialContributions.INSERT;
                UNTIL DefaultSocContribution.NEXT = 0;
            OK := TRUE;
        END
        ELSE
            OK := FALSE;

    end;


    procedure CalculerLignePrime(SalaryLine: Record "Salary Lines"; "SolderDroitCongé": Boolean; Sim: Option Simulation,Real; nbjsolder: Decimal): Decimal
    var
        SalaryHeader: Record "Salary Headers";
        Ind: Record "Indemnities";
        SocialContributions: Record "Social Contributions";
        ParamRessHum: Record 5218;
        EmploymentContract: Record 5211;
        RegimeWork: Record "Regimes of work";
        Employee: Record 5200;
        SliceImposition: Record "Slices of imposition";
        SliceImpositionX: Record "Slices of imposition";
        temp: Decimal;
        tmp: Decimal;
        tmp1: Decimal;
        Cot: Record "Default Soc. Contribution";
        nbr: Integer;
        bonus: Decimal;
        SalLineEng: Record "Rec. Salary Lines";
        EntEng: Record "Rec. Salary Headers";
        LigneTravail: Record "Heures occa. enreg. m";
        WorkedD: Decimal;
        "Mgmt.ofLoansandAdvances": Codeunit "Mgmt. of Loans and Advances";
        droitconge: Record "Employee's days off Entry";
        SalLineEngTmp: Record "Rec. Salary Lines";
        SalLineEngTmp2: Record "Rec. Salary Lines";
        typemnt: Option SalaireNet,SalaireBrut;
        NbreMT: Decimal;
        PrimeType: Record "Prime1";
    begin
        SalaryHeader.GET(SalaryLine."No.");
        ParamRessHum.GET();
        ParamCpta.GET;
        IF NOT SolderDroitCongé THEN
            nbjsolder := 0;

        Employee.RESET;
        Employee.GET(SalaryLine.Employee);
        CLEAR(EmploymentContract);
        EmploymentContract.GET(Employee."Emplymt. Contract Code");
        RegimeWork.RESET;
        RegimeWork.GET(EmploymentContract."Regimes of work");
        initLigne(SalaryLine, Sim);
        //-->calcul de la bonification
        bonus := 1;

        CalcAbsence(SalaryLine);
        SalaryLine.MODIFY;
        SalaryLine."Days off balacement" := 0;

        // --> Calcul des 2 param. d'assiduité

        nbr := 12;
        EmploymentContract.RESET;
        Employee.RESET;
        Employee.GET(SalaryLine.Employee);
        EmploymentContract.GET(Employee."Emplymt. Contract Code");
        CASE ParamRessHum."Number of monthes" OF
            0:
                nbr := EmploymentContract."Regular payments";
            1:
                nbr := EmploymentContract."Temporary payments";
            2:
                nbr := EmploymentContract."Regular payments" + EmploymentContract."Temporary payments";
        END;

        IF RegimeWork.GET(SalaryLine."Employee Regime of work") THEN;
        SalLineEngTmp2.RESET;
        SalLineEngTmp2.SETCURRENTKEY(Year, Month, Employee, "No.");
        SalLineEngTmp2.SETFILTER(Employee, SalaryLine.Employee);
        SalLineEngTmp2.SETFILTER(Year, '%1', SalaryLine."year of Calculate");
        SalLineEngTmp2.SETFILTER(Month, '<%1', 12);
        IF NOT SalLineEngTmp2.FIND('+') THEN
            ERROR('Vous Devez Verifier L''année !!!!');

        CASE SalaryLine."Employee's type" OF
            0:
                BEGIN
                    //SalaryLine.CALCFIELDS ("Worked hours","Basis hours");
                    LigneTravail.RESET;
                    LigneTravail.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement");
                    LigneTravail.SETFILTER("N° Salarié", SalaryLine.Employee);
                    LigneTravail.SETRANGE("Mois de paiement", SalaryLine.Month);
                    LigneTravail.SETRANGE("Année de paiement", SalaryLine.Year);
                    LigneTravail.CALCSUMS("Nombre d'heures", "Montant ligne", "Nbre Jour");
                    LigneTravail.MODIFYALL("Paiement No.", SalaryLine."No.");
                    SalaryLine."Basis hours" := LigneTravail."Nombre d'heures";
                    IF LigneTravail."Nbre Jour" > RegimeWork."Worked Day Per Month" THEN
                        WorkedD := RegimeWork."Worked Day Per Month"
                    ELSE
                        WorkedD := LigneTravail."Nbre Jour";
                    SalaryLine."Days off" := (RegimeWork."Worked Day Per Month" - WorkedD);
                    SalaryLine."Worked hours" := LigneTravail."Nombre d'heures";
                    IF SalaryLine."Basis hours" > 0 THEN
                        SalaryLine."Basis salary" := LigneTravail."Montant ligne"//SalaryLine."Basis hours"
                    ELSE BEGIN
                        Employee.GET(SalaryLine.Employee);
                        SalaryLine."Basis salary" := ROUND(LigneTravail."Montant ligne",
                                                            ParamCpta."Amount Rounding Precision");
                    END;
                    IF EmploymentContract."Type Assiduité" = 0 THEN BEGIN
                        SalaryLine."Assiduity (Paid days)" := (SalaryLine."Basis hours" / RegimeWork."Work Hours per month")
                                                                 * 100;
                        SalaryLine."Assiduity (Worked days)" := (SalaryLine."Basis hours" / RegimeWork."Work Hours per month") * 100;
                    END ELSE BEGIN
                        SalaryLine."Assiduity (Paid days)" := (SalaryHeader."Paid days" - SalaryLine."Days off" - SalaryLine.Absences)
                                                                 / SalaryHeader."Paid days"
                                                                 * 100;
                        SalaryLine."Assiduity (Worked days)" := (SalaryHeader."Paid days"
                                                                 - SalaryLine."Days off"//-SalaryLine.congé
                                                                 - SalaryLine.Absences)
                                                                 / RegimeWork."Worked Day Per Month"
                                                                 * 100;

                    END;
                END;
            1:
                BEGIN
                    SalaryLine."Assiduity (Paid days)" := (SalaryHeader."Paid days"
                                                             - SalaryLine.Absences
                                                             - SalaryLine."Adjustment of absences")
                                                             / SalaryHeader."Paid days"
                                                             * 100;
                    SalaryLine."Assiduity (Worked days)" := (SalaryHeader."Worked days"
                                                             - SalaryLine.Absences
                                                             - SalaryLine."Days off"
                                                             - SalaryLine."Adjustment of absences")
                                                             / SalaryHeader."Worked days"
                                                             * 100;
                END;
        END;
        SalaryLine."Days off" := 0;
        EntEng.RESET;
        EntEng.SETCURRENTKEY(Year, Month, "No.");
        EntEng.SETRANGE(Year, SalaryLine."year of Calculate");
        EntEng.SETFILTER(Month, '%1..%2', 0, 11);
        IF EntEng.FIND('+') THEN;
        NbreMT := 0;
        NbreMT := (CALCDATE('+FM', SalaryLine."Posting Date") - DMY2DATE(1, 1, SalaryLine."year of Calculate"));///365;
        IF NbreMT MOD 31 > 15 THEN
            NbreMT := (NbreMT DIV 31) + 1
        ELSE
            NbreMT := NbreMT DIV 31;
        NbreMT := NbreMT / 12;
        ParamRessHum.GET;
        IF NOT ParamRessHum."Activer Type Prime" THEN BEGIN
            IF SalaryLine.Month = SalaryLine.Month::Prime THEN
                NbreMT := 1;

        END ELSE BEGIN

            CLEAR(PrimeType);
            IF PrimeType.GET(SalaryLine."Type Prime") THEN;
            IF PrimeType."Type Calcul" = 4 THEN
                NbreMT := 1;
        END;
        IF DATE2DWY(SalaryLine."Posting Date", 3) > SalaryLine."year of Calculate" THEN
            SalaryLine."Basis salary" := Employee."Basis salary"
        ELSE
            IF EntEng.Month = 11 THEN
                SalaryLine."Basis salary" := Employee."Basis salary"
            ELSE
                SalaryLine."Basis salary" := ROUND(Employee."Basis salary" * NbreMT, ParamCpta."Amount Rounding Precision");

        IF SalaryLine.Month = SalaryLine.Month::STC THEN
            SalaryLine."Basis salary" := ROUND(Employee."Basis salary", ParamCpta."Amount Rounding Precision");
        SalaryLine."Net salary" := CalcSBPrime(SalaryLine, typemnt, SolderDroitCongé);
        SalaryLine.MODIFY;
        IF SolderDroitCongé THEN BEGIN
            IF ((SalaryLine."Days off remaining" + SalaryLine."droit de congé du mois") >= nbjsolder) AND (nbjsolder <> 0) THEN
                SalaryLine."Days off balacement" := nbjsolder
            ELSE
                SalaryLine."Days off balacement" := (SalaryLine."Days off remaining" + SalaryLine."droit de congé du mois");
            droitconge.RESET;
            droitconge.SETCURRENTKEY("Line type", "Employee No.", "Posting month", "Posting year");
            droitconge.SETRANGE("Line type", 1);
            droitconge.SETRANGE("Employee No.", SalaryLine.Employee);
            droitconge.SETRANGE("Posting month", SalaryLine.Month);
            droitconge.SETRANGE("Posting year", SalaryLine.Year);
            droitconge.CALCSUMS("Quantity (Days)", "Montant Ligne", "Quantity (Hours)");
            // NE
            SalaryLine."Amount Days Off balacement" := ROUND(Employee."Basis salary" * SalaryLine."Days off balacement" /
                                                     SalaryHeader."Paid days", ParamCpta."Amount Rounding Precision");
            SalaryLine."Assiduity (days off balacement" := ROUND(SalaryLine."Days off balacement" / SalaryHeader."Paid days",
                                                          ParamCpta."Amount Rounding Precision") * 100;
            SalaryLine."Hours off Balacement" := droitconge."Quantity (Hours)";
        END
        ELSE
            SalaryLine."Days off balacement" := 0;

        // --> Calcul des 2 param. d'assiduité


        IF typemnt = 1 THEN BEGIN

            SalaryLine."Gross Salary" := SalaryLine."Net salary";
            SalaryLine."Net salary" := 0;
            ParamRessHum.GET;
            IF ParamRessHum."Activer Type Prime" THEN BEGIN


                CLEAR(PrimeType);
                IF PrimeType.GET(SalaryLine."Type Prime") THEN;
                IF (PrimeType."Type Calcul" = 2) OR (PrimeType."Type Calcul" = 3) THEN
                    SalaryLine."Basis salary" := SalaryLine."Gross Salary";
            END;
        END;
        IF (SalaryLine.Month = SalaryLine.Month::Prime) AND (Employee."Catégorie soc." = 0) THEN BEGIN
            SalaryLine."Assiduity (Paid days)" := 100;
            SalaryLine."Assiduity (Worked days)" := 100;
        END;
        // Calcul Indemnité
        SalaryLine."Basis salary" := SalaryLine."Basis salary";
        SalaryLine."Assiduity (Paid days)" := SalaryLine."Assiduity (Paid days)" + SalaryLine."Assiduity (days off balacement";
        CalcIndemnitéImp(SalaryLine);
        ;
        SalaryLine.MODIFY;
        //--> Calcul du salaire Brut du mois

        "CalcInd&HsupNav"(SalaryLine, Sim);
        SalaryLine.MODIFY;
        //SalaryLine.CALCFIELDS ("Taxable indemnities","Supp. hours");
        SalaryLine."6 * SMIG" := 0;// ROUND(ParamRessHum."Minimum wage guarantee"*6,ParamCpta."Amount Rounding Precision");
        SalaryLine."Assiduity (Paid days)" := SalaryLine."Assiduity (Paid days)" - SalaryLine."Assiduity (days off balacement";

        CASE SalaryLine."Employee's type" OF
            1:
                BEGIN

                    SalaryLine."Real basis salary" := ROUND(((SalaryLine."Basis salary" * SalaryLine."Assiduity (Paid days)" / 100)
                                                            + SalaryLine."Amount Days Off balacement"
                                                             ), ParamCpta."Amount Rounding Precision");//RK
                    SalaryLine."Gross Salary (sans Av)" := ROUND((bonus * SalaryLine."Basis salary" * (SalaryLine."Assiduity (Paid days)"
                                                            / 100)) + SalaryLine."Taxable indemnities (Not Gross"//RK
                                                            + SalaryLine."Taxable indemnities"
                                                            + SalaryLine."Supp. hours", ParamCpta."Amount Rounding Precision");
                    SalaryLine."Gross Salary (sans Av) PR" := SalLineEngTmp2."Gross Salary (sans Av) PR";
                    SalaryLine."Gross Salary" := SalaryLine."Gross Salary (sans Av)";
                    SalaryLine."Gross Salary PR" := SalaryLine."Gross Salary (sans Av) PR";
                END;
            0:
                BEGIN
                    SalaryLine."Real basis salary" := ROUND(SalaryLine."Basis salary" * bonus, ParamCpta."Amount Rounding Precision");
                    SalaryLine."Gross Salary (sans Av)" := ROUND((SalaryLine."Basis salary" * bonus)
                                                           + SalaryLine."Taxable indemnities" + SalaryLine."Taxable indemnities (Not Gross"
                                                           + SalaryLine."Supp. hours", ParamCpta."Amount Rounding Precision");
                    SalaryLine."Gross Salary (sans Av) PR" := SalLineEngTmp2."Gross Salary (sans Av) PR";
                    SalaryLine."Gross Salary" := SalaryLine."Gross Salary (sans Av)";
                    SalaryLine."Gross Salary (sans Av) PR" := SalaryLine."Gross Salary (sans Av) PR";


                END;
        END;
        SalaryLine."Assiduity (Paid days)" := SalaryLine."Assiduity (Paid days)" + SalaryLine."Assiduity (days off balacement";

        SalaryLine."Non Taxable Soc. Contrib. PR" := SalLineEngTmp2."Non Taxable Soc. Contrib. PR";
        SalaryLine."Taxable indem. PR (Not Gross)" := SalLineEngTmp2."Taxable indem. PR (Not Gross)";
        SalaryLine."Taxable salary PR" := SalLineEngTmp2."Taxable salary PR";

        // Calc Indemnité AV Nat
        CalcIndemnitéAvNat(SalaryLine);
        SalaryLine.MODIFY;

        "CalcInd&Hsup"(SalaryLine, Sim);
        SalaryLine.MODIFY;
        SalaryLine."Assiduity (Paid days)" := SalaryLine."Assiduity (Paid days)" - SalaryLine."Assiduity (days off balacement";

        CASE SalaryLine."Employee's type" OF
            1:
                BEGIN

                    SalaryLine."Real basis salary" := ROUND(((SalaryLine."Basis salary" * SalaryLine."Assiduity (Paid days)"
                                                             / 100) + SalaryLine."Amount Days Off balacement")
                                                              * bonus, ParamCpta."Amount Rounding Precision");//RK
                    SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary"
                                                             + SalaryLine."Taxable indemnities"
                                                             + SalaryLine."Supp. hours", ParamCpta."Amount Rounding Precision");
                    SalaryLine."Gross Salary PR" := SalLineEngTmp2."Gross Salary PR";

                END;
            0:
                BEGIN
                    SalaryLine."Real basis salary" := ROUND(SalaryLine."Basis salary" * bonus, ParamCpta."Amount Rounding Precision");
                    SalaryLine."Gross Salary" := ROUND((SalaryLine."Basis salary" * bonus)
                                                           + SalaryLine."Taxable indemnities"
                                                           + SalaryLine."Supp. hours", ParamCpta."Amount Rounding Precision");
                    SalaryLine."Gross Salary PR" := SalLineEngTmp2."Gross Salary PR";

                END;
        END;
        SalaryLine."Assiduity (Paid days)" := SalaryLine."Assiduity (Paid days)" + SalaryLine."Assiduity (days off balacement";

        // --> Calc Cotisation Social


        CalcCotisationSocial1(SalaryLine);
        SalaryLine.MODIFY;
        //--> Calcul du salaire imposable
        CalcAllTaxe(SalaryLine);
        SalaryLine."Taxable salary" := ROUND(SalaryLine."Gross Salary" - SalaryLine.CNSS +
                                             SalaryLine."Taxable indemnities (Not Gross"
                                             , ParamCpta."Amount Rounding Precision");

        SalaryLine."Taxable salary PR" := SalLineEngTmp2."Taxable salary PR";
        // Calc Cotisation Social
        CalcCotisationSocial2(SalaryLine);
        SalaryLine.MODIFY;
        //--> Calcul de l'imposable réel

        SalaryLine."Deduction Prof. expenses" := ROUND(ParamRessHum."% professional expenses"
                                                      * SalaryLine."Taxable salary"
                                                      / 100, ParamCpta."Amount Rounding Precision");
        // MAJ RAMZI 17/02/06
        IF SalaryLine.Month < 13 THEN
            SalaryLine."Real taxable" := ROUND(SalaryLine."Taxable salary"
                                                           - SalaryLine."Deduction Family chief"
                                                           - SalaryLine."Deduction Loaded child"
                                                           - SalaryLine."Deduction Prof. expenses", ParamCpta."Amount Rounding Precision")
        ELSE
            SalaryLine."Real taxable" := ROUND(SalaryLine."Taxable salary"
                                                           - SalaryLine."Deduction Prof. expenses", ParamCpta."Amount Rounding Precision");

        SalaryLine."Real taxable PR" := ROUND(SalaryLine."Taxable salary PR"
                                                       - SalaryLine."Deduction Family chief"
                                                       - SalaryLine."Deduction Loaded child"
                                                       - ROUND(SalaryLine."Taxable salary PR" * ParamRessHum."% professional expenses" / 100
                                                       , ParamCpta."Amount Rounding Precision"), ParamCpta."Amount Rounding Precision");
        //--> Calcul de l'imposable réel par an
        //SalaryLine.CALCFIELDS ("Total taxable rec.","Rec. payments");
        SalLineEng.RESET;
        SalLineEng.SETCURRENTKEY(Year, Month, Employee, "No.", Imposable);
        SalLineEng.SETFILTER(Employee, SalaryLine.Employee);
        SalLineEng.SETFILTER(Year, '%1', SalaryLine.Year);
        // SalLineEng.SETFILTER("Non Taxable Soc. Contrib.",'>%1',0);
        SalLineEng.SETFILTER(Imposable, '%1', TRUE);
        SalLineEng.CALCSUMS("Real taxable", "Taxe (Month)");
        SalaryLine."Total taxable rec." := SalLineEng."Real taxable";
        SalaryLine."Total taxes rec." := SalLineEng."Taxe (Month)";
        SalaryLine."Rec. payments" := 0;

        SalLineEngTmp.RESET;
        SalLineEngTmp.SETCURRENTKEY(Year, Month, Employee, "No.", Imposable);
        SalLineEngTmp.SETFILTER(Employee, SalaryLine.Employee);
        SalLineEngTmp.SETFILTER(Year, '%1', SalaryLine.Year);
        // SalLineEngTmp.SETFILTER("Non Taxable Soc. Contrib.",'>%1',0);
        SalLineEngTmp.SETFILTER(Imposable, '%1', TRUE);
        SalLineEngTmp.SETFILTER(Month, '<%1', 13);
        SalLineEngTmp.CALCSUMS("Real taxable", "Taxe (Month)");

        SalaryLine."Rec. payments" := SalLineEngTmp.COUNT;

        CASE Sim OF
            0:
                BEGIN
                    SalaryLine."Real taxable (Year)" := ROUND(SalaryLine."Real taxable" * nbr,
                                                                           ParamCpta."Amount Rounding Precision");
                END;
            1:
                BEGIN
                    nbr := 12;
                    EmploymentContract.RESET;
                    Employee.GET(SalaryLine.Employee);
                    EmploymentContract.GET(Employee."Emplymt. Contract Code");
                    CASE ParamRessHum."Number of monthes" OF
                        0:
                            nbr := EmploymentContract."Regular payments";
                        1:
                            nbr := EmploymentContract."Temporary payments";
                        2:
                            nbr := EmploymentContract."Regular payments" + EmploymentContract."Temporary payments";
                    END;

                    CASE ParamRessHum."Taxes regulation" OF
                        0:
                            BEGIN
                                IF SalaryLine.Month > (nbr - 1) THEN BEGIN
                                    SalaryLine."Real taxable (Year)" := ROUND((SalaryLine."Real taxable" +
                                                                        ((SalaryLine."Real taxable PR")
                                                                         * (nbr - SalaryLine."Rec. payments")))
                                                                        + SalaryLine."Total taxable rec.", ParamCpta."Amount Rounding Precision");
                                    SalaryLine."Real Taxable PR (Year)" := ROUND((
                                                                        ((SalaryLine."Real taxable PR")//- SalaryLine."Deduction Family chief"
                                                                         * (nbr - SalaryLine."Rec. payments")))
                                                                        + SalaryLine."Total taxable rec.", ParamCpta."Amount Rounding Precision");
                                END ELSE BEGIN
                                    SalaryLine."Real taxable (Year)" := ROUND((SalaryLine."Real taxable" +
                                                                        (SalaryLine."Real taxable PR" * (nbr - SalaryLine."Rec. payments" - 1)))
                                                                        + SalaryLine."Total taxable rec.", ParamCpta."Amount Rounding Precision");
                                    SalaryLine."Real Taxable PR (Year)" := ROUND((SalaryLine."Real taxable PR" +
                                                                        (SalaryLine."Real taxable PR" * (nbr - SalaryLine."Rec. payments" - 1)))
                                                                        + SalaryLine."Total taxable rec.", ParamCpta."Amount Rounding Precision");
                                END;
                            END;
                        1:
                            BEGIN
                                IF SalaryLine."Rec. payments" < 12 THEN
                                    SalaryLine."Real taxable (Year)" := ROUND(SalaryLine."Real taxable" * nbr,
                                                                                   ParamCpta."Amount Rounding Precision")
                                ELSE
                                    SalaryLine."Real taxable (Year)" := ROUND(SalaryLine."Real taxable" + SalaryLine."Total taxable rec.",
                                                                                   ParamCpta."Amount Rounding Precision");
                                IF SalaryLine."Rec. payments" < 12 THEN
                                    SalaryLine."Real Taxable PR (Year)" := ROUND(SalaryLine."Real taxable PR" * nbr,
                                                                                   ParamCpta."Amount Rounding Precision")
                                ELSE
                                    SalaryLine."Real Taxable PR (Year)" := ROUND(SalaryLine."Real taxable PR" + SalaryLine."Total taxable rec.",
                                                                                   ParamCpta."Amount Rounding Precision");

                            END;
                    END;
                END;
        END;
        // Calcul Impôt Annuel
        //MBY SAMI ARRONDI AU DINAR SUP 18/01/2009
        DecVar := ROUND(SalaryLine."Real taxable (Year)", 1) - SalaryLine."Real taxable (Year)";
        IF DecVar > 0 THEN
            SalaryLine."Real taxable (Year)" := ROUND(SalaryLine."Real taxable (Year)", 1)
        ELSE
            SalaryLine."Real taxable (Year)" := ROUND(SalaryLine."Real taxable (Year)" + 1, 1);
        //END MBY

        CalcImpotAn(SalaryLine);
        IF SalaryLine.Month > (nbr - 1) THEN BEGIN
            SalaryLine."Deduction Family chief" := 0;
            SalaryLine."Deduction Loaded child" := 0;
        END;
        // Calcul Impôt mensuel

        CASE ParamRessHum."Taxes regulation" OF
            0:
                BEGIN
                    IF SalaryLine.Month < nbr THEN BEGIN
                        IF (nbr - SalaryLine."Rec. payments" + 1) <> 0 THEN
                            SalaryLine."Taxe PR (Month)" := ROUND((SalaryLine."Taxe PR (Year)" - SalaryLine."Total taxes rec.")
                                                         / (nbr - SalaryLine."Rec. payments" + 1), ParamCpta."Amount Rounding Precision")
                        ELSE
                            SalaryLine."Taxe PR (Month)" := ROUND((SalaryLine."Taxe PR (Year)" - SalaryLine."Total taxes rec.")
                                                            , ParamCpta."Amount Rounding Precision");

                        IF SalaryLine."Rec. payments" < 12 THEN
                            SalaryLine."Taxe (Month)" := ROUND((SalaryLine."Taxe (Year)" - SalaryLine."Taxe PR (Year)") +
                                                         SalaryLine."Taxe PR (Month)", ParamCpta."Amount Rounding Precision")
                        ELSE
                            SalaryLine."Taxe (Month)" := ROUND((SalaryLine."Taxe (Year)" - SalaryLine."Total taxes rec.")
                                                         , ParamCpta."Amount Rounding Precision");
                        IF SalaryLine."Taxe (Month)" < 0 THEN
                            SalaryLine."Taxe (Month)" := 0;

                    END ELSE BEGIN
                        IF (nbr - SalaryLine."Rec. payments") <> 0 THEN
                            SalaryLine."Taxe PR (Month)" := ROUND((SalaryLine."Taxe PR (Year)" - SalaryLine."Total taxes rec.")
                                                         / (nbr - SalaryLine."Rec. payments"), ParamCpta."Amount Rounding Precision")
                        ELSE
                            SalaryLine."Taxe PR (Month)" := ROUND(SalaryLine."Taxe PR (Year)" - SalaryLine."Total taxes rec.",
                                                             ParamCpta."Amount Rounding Precision");

                        IF SalaryLine."Rec. payments" < 12 THEN
                            SalaryLine."Taxe (Month)" := ROUND((SalaryLine."Taxe (Year)" - SalaryLine."Taxe PR (Year)")
                                                         , ParamCpta."Amount Rounding Precision")
                        ELSE
                            SalaryLine."Taxe (Month)" := ROUND((SalaryLine."Taxe (Year)" - SalaryLine."Total taxes rec.")
                                                         , ParamCpta."Amount Rounding Precision");

                        IF SalaryLine."Taxe (Month)" < 0 THEN
                            SalaryLine."Taxe (Month)" := 0;

                    END;

                END;
            1:
                BEGIN
                    IF SalaryLine."Rec. payments" < 12 THEN
                        SalaryLine."Taxe PR (Month)" := ROUND(SalaryLine."Taxe PR (Year)" / nbr, ParamCpta.
                "Amount Rounding Precision")
                    ELSE
                        SalaryLine."Taxe PR (Month)" := 0;

                    IF SalaryLine."Rec. payments" < 12 THEN
                        SalaryLine."Taxe (Month)" := ROUND((SalaryLine."Taxe (Year)" - SalaryLine."Taxe PR (Year)") +
                                                                       SalaryLine."Taxe PR (Month)", ParamCpta."Amount Rounding Precision")
                    ELSE
                        SalaryLine."Taxe (Month)" := ROUND(SalaryLine."Taxe (Year)" - SalaryLine."Total taxes rec."
                                                                       , ParamCpta."Amount Rounding Precision");


                    IF SalaryLine."Taxe (Month)" < 0 THEN
                        SalaryLine."Taxe (Month)" := 0;

                END;
        END;


        SalaryLine."Net salary" := ROUND(SalaryLine."Taxable salary"
                                 + SalaryLine."Non Taxable indemnities"
                                 + SalaryLine."Mission expenses"
                                 - SalaryLine."Taxe (Month)", ParamCpta."Amount Rounding Precision");


        IF Sim = 1 THEN
            "Mgmt.ofLoansandAdvances".CréerLigneRembourcement(SalaryLine);
        SalaryLine."Net salary cashed" := ROUND(SalaryLine."Net salary"
                                                       - SalaryLine.Loans
                                                       - SalaryLine.Advances - SalaryLine."Retenue FSP"
                                                       - SalaryLine."Retenue SNP",  // MH Calucl Retue FSP
                                                       ParamCpta."Amount Rounding Precision");
        //- SalaryLine."Non Taxable Soc. Contrib."; //RAMZI :ALTEK
        // Advance Sur Prime
        // MH Calucl Retue FSP
        SalaryLine."Retenue FSP" := 0;
        SalaryLine."Retenue SNP" := 0;

        RecEmployee2.RESET;
        RecEmployee2.SETRANGE("No.", SalaryLine.Employee);
        IF RecEmployee2.FINDFIRST THEN BEGIN
            IF RecEmployee2."Appliquer Retenue SNP" = TRUE THEN
                SalaryLine."Retenue SNP" := SalaryLine."Basis salary" * 1 / 6;
        END;

        RecHumanResourcesSetup.FINDFIRST;
        IF RecHumanResourcesSetup."Appliquer Retenue FSP" = TRUE THEN
            SalaryLine."Retenue FSP" := (SalaryLine."Net salary" * RecHumanResourcesSetup."Taux Retenue FSP") / 100;

        // MH Calucl Retue FSP

        SalaryLine."User ID" := USERID;
        SalaryLine."Last Date Modified" := WORKDATE;

        SalaryLine.MODIFY;

        EXIT(SalaryLine."Net salary");
    end;


    procedure CalcSBPrime(var SalaryLine: Record "Salary Lines"; var typemnt: Option SalaireNet,SalaireBrut; var "SolderDroitCongé": Boolean) SBbase: Decimal
    var
        SalaryHeader: Record "Salary Headers";
        ParamRessHum: Record 5218;
        SalLineEngTmp: Record "Rec. Salary Lines";
        LigneNoteTmp: Record "Ligne Pointage Salarié Chanti";
        Abs: Record "Employee's days off Entry";
        i: Integer;
        Val: array[4] of Decimal;
        NbTrim: Integer;
        Empl: Record 5200;
        EntSal: Record "Rec. Salary Headers";
        absdec03: Decimal;
        "cause of absence": Record 5206;
        CoefGratifT: Record "Coef Gratification";
        Indm: Record "Indemnities";
        Def: Record "Indemnity";
        RecInd: Record "Rec. Indemnities";
        IndmTmp: Record "Indemnities";
        SalLineEngTmp2: Record "Rec. Salary Lines";
        NbreMT: Decimal;
        PrimeType: Record "Prime1";
        DateMax: Date;
        MntRappel: Decimal;
        Carr: Record "Carière Enreg";
    begin
        CASE SalaryLine.Month OF
            SalaryLine.Month::Prime:
                BEGIN
                    ParamRessHum.GET;
                    CLEAR(PrimeType);
                    IF NOT ParamRessHum."Activer Type Prime" THEN BEGIN
                        SBbase := SalaryLine."Net salary";
                        typemnt := 0;

                    END ELSE BEGIN
                        IF PrimeType.GET(SalaryLine."Type Prime") THEN;
                        CASE PrimeType."Type Calcul" OF
                            0, 1:
                                BEGIN
                                    NbTrim := 0;
                                    Empl.RESET;
                                    IF Empl.GET(SalaryLine.Employee) THEN;
                                    FOR i := 1 TO 4 DO
                                        Val[i] := 0;
                                    SalaireBrut := 0;


                                    CASE ParamRessHum."Type Calcul Note" OF
                                        0:
                                            FOR i := 1 TO 4 DO BEGIN
                                                Empl.SETFILTER(Trimestre, '%1', i);
                                                Empl.SETRANGE("Type Note", 0, 5);
                                                Empl.SETRANGE("Type Calcul", 1);
                                                Empl.SETFILTER("Filtre Année", '%1', SalaryLine."year of Calculate");
                                                Empl.CALCFIELDS("Note enreg.", "Montant Note enreg.");
                                                IF Empl."Note enreg." <> 0 THEN
                                                    NbTrim := NbTrim + 1;
                                                SalaireBrut := SalaireBrut + Empl."Montant Note enreg.";
                                                Val[i] := Empl."Note enreg.";
                                            END;
                                        1:
                                            BEGIN
                                                Empl.SETFILTER(Trimestre, '%1', SalaryLine.Trimestre);
                                                Empl.SETRANGE("Type Note", 0, 5);
                                                Empl.SETRANGE("Type Calcul", 1);
                                                Empl.SETFILTER("Filtre Année", '%1', SalaryLine."year of Calculate");
                                                Empl.CALCFIELDS("Note enreg.", "Montant Note enreg.");
                                                SalaireBrut := SalaireBrut + Empl."Montant Note enreg.";
                                                Val[1] := Empl."Note enreg.";
                                            END;
                                    END;
                                    IF NbTrim = 0 THEN
                                        NbTrim := 1;
                                    NoteNet := 0;
                                    SalLineEngTmp.RESET;
                                    SalLineEngTmp.SETCURRENTKEY(Year, Month, "Type Prime", Employee, "No.");
                                    SalLineEngTmp.SETRANGE(Year, SalaryLine."year of Calculate");
                                    SalLineEngTmp.SETRANGE("Type Prime", SalaryLine."Type Prime");
                                    SalLineEngTmp.SETRANGE(Month, 0, 11);
                                    IF SalaryLine."Posting Date" = DMY2DATE(26, 3, 2005) THEN
                                        SalLineEngTmp.SETRANGE(Month, 0, 2);
                                    SalLineEngTmp.SETFILTER(Employee, SalaryLine.Employee);
                                    IF NOT SalLineEngTmp.FIND('+') THEN BEGIN
                                        SalLineEngTmp.SETRANGE(Year, SalaryLine.Year);
                                        IF SalLineEngTmp.FIND('+') THEN;
                                    END;
                                    SalLineEngTmp2.RESET;
                                    SalLineEngTmp2.SETCURRENTKEY(Employee, "year of Calculate", Month, "Type Prime");
                                    SalLineEngTmp2.SETRANGE("year of Calculate", SalaryLine."year of Calculate");
                                    SalLineEngTmp2.SETRANGE("Type Prime", SalaryLine."Type Prime");

                                    SalLineEngTmp2.SETRANGE(Month, SalaryLine.Month);
                                    SalLineEngTmp2.SETFILTER(Employee, SalaryLine.Employee);
                                    SalLineEngTmp2.CALCSUMS("Gross Salary", "Net salary");
                                    IF SalaireBrut <> 0 THEN BEGIN
                                        typemnt := 1;
                                        SalaireBrut := SalaireBrut - SalaryLine."Basis salary" - SalLineEngTmp2."Gross Salary";
                                        IndmTmp.RESET;
                                        IndmTmp.SETFILTER("No.", SalaryLine."No.");
                                        IndmTmp.SETFILTER("Employee No.", SalaryLine.Employee);
                                        IndmTmp.SETFILTER(Type, '%1', 0);
                                        IF IndmTmp.FIND('-') THEN
                                            REPEAT
                                                SalaireBrut := (SalaireBrut - IndmTmp."Base Amount");
                                            UNTIL IndmTmp.NEXT = 0;
                                        // Creation Indemnité
                                        IF SalaireBrut <> 0 THEN BEGIN  //(SalLineEngTmp."Gross Salary PR"-RecInd."Real Amount PR") THEN BEGIN
                                            ParamRessHum.GET;
                                            ParamRessHum.TESTFIELD("Indem diff Prime");
                                            Indm.RESET;
                                            Indm.SETFILTER("No.", SalaryLine."No.");
                                            Indm.SETFILTER("Employee No.", SalaryLine.Employee);
                                            Indm.SETFILTER(Indemnity, ParamRessHum."Indem diff Prime");
                                            IF Indm.FIND('-') THEN BEGIN
                                                Indm."Base Amount" := Indm."Base Amount" - (SalaireBrut - (SalLineEngTmp."Gross Salary PR" - RecInd."Real Amount PR"));
                                                Indm."Real Amount" := Indm."Real Amount" - (SalaireBrut - (SalLineEngTmp."Gross Salary PR" - RecInd."Real Amount PR"));
                                                Indm."Evaluation mode" := 0;
                                                Indm.MODIFY;
                                            END ELSE BEGIN
                                                CLEAR(Def);
                                                IF Def.GET(ParamRessHum."Indem diff Prime") THEN;
                                                Def.TESTFIELD("Non Inclus en Prime", FALSE);
                                                Indm.INIT;
                                                Indm."No." := SalaryLine."No.";
                                                Indm."Employee No." := SalaryLine.Employee;
                                                Indm.Indemnity := ParamRessHum."Indem diff Prime";
                                                Indm."Employee Posting Group" := SalaryLine."Employee Posting Group";
                                                Indm."Employee Statistic Group" := SalaryLine."Statistics Group Code";
                                                Indm.Description := Def.Description;
                                                Indm.Type := Def.Type;
                                                Indm."Evaluation mode" := 0;
                                                Indm."Base Amount" := (SalaireBrut);//-(SalLineEngTmp."Gross Salary PR"-RecInd."Real Amount PR"));
                                                Indm."Real Amount" := (SalaireBrut);//-(SalLineEngTmp."Gross Salary PR"-RecInd."Real Amount PR"));
                                                Indm.Rate := 100;
                                                Indm."Global Dimension 1" := SalaryLine."Global Dimension 1";
                                                Indm."Global Dimension 2" := SalaryLine."Global Dimension 2";
                                                Indm."Real Amount PR" := 0;
                                                Indm."Minimum value" := Def."Minimum value";
                                                //Indm.Nom:=
                                                Indm."Non Inclis en AV NAt" := Def."Non Inclis en AV NAt";
                                                Indm."User ID" := USERID;
                                                Indm."Last Date Modified" := WORKDATE;
                                                Indm.Taux := 100;
                                                Indm."Type Indemnité" := Def."Type Indemnité";
                                                Indm."inclus en compta" := Def."non inclus en compta";
                                                Indm."Precision Arrondi Montant" := Def."Precision Arrondi Montant";
                                                Indm."Direction Arrondi" := Def."Direction Arrondi";
                                                Indm."Evaluation mode" := 0;
                                                Indm.INSERT;
                                            END;
                                        END;

                                        SBbase := SalaireBrut;
                                    END;


                                    EntSal.RESET;
                                    EntSal.SETCURRENTKEY(Year, Month, "No.");
                                    EntSal.SETRANGE(Year, SalaryLine."year of Calculate");
                                    EntSal.SETFILTER(Month, '%1..%2', 0, 11);
                                    IF EntSal.FIND('-') THEN;
                                    NoteM := (Val[1] + Val[2] + Val[3] + Val[4]) / NbTrim;
                                    CLEAR(CoefGratif);
                                    IF CoefGratif.GET(SalaryLine."Type Prime", Empl.Catégorie, NoteM) THEN
                                        NoteNet := CoefGratif."Coef Gratif"
                                    ELSE BEGIN
                                        CoefGratif.RESET;
                                        CoefGratif.SETFILTER(Prime, SalaryLine."Type Prime");
                                        CoefGratif.SETFILTER(Collège, Empl.Catégorie);
                                        CoefGratif.SETFILTER(Note, '..%1', NoteM);
                                        IF CoefGratif.FIND('+') THEN;
                                        CoefGratifT.RESET;
                                        CoefGratifT.SETFILTER(Prime, SalaryLine."Type Prime");
                                        CoefGratifT.SETFILTER(Collège, Empl.Catégorie);
                                        CoefGratifT.SETFILTER(Note, '%1..', NoteM);
                                        IF CoefGratifT.FIND('-') THEN;
                                        IF (CoefGratifT.Note - CoefGratif.Note) <> 0 THEN
                                            NoteNet := CoefGratif."Coef Gratif" + ((CoefGratifT."Coef Gratif" - CoefGratif."Coef Gratif") / (CoefGratifT.Note - CoefGratif.Note));
                                    END;
                                    Abs.RESET;
                                    Abs.SETCURRENTKEY("Employee No.", "Posting year", "Posting month", "Line type", "Impute on days off");
                                    Abs.SETFILTER("Employee No.", SalaryLine.Employee);
                                    Abs.SETRANGE("Posting year", SalaryLine."year of Calculate");
                                    EntSal.FIND('+');
                                    Abs.SETFILTER("Posting month", '..%1', EntSal.Month);
                                    Abs.SETFILTER("Line type", '0|3|4|8');
                                    Abs.SETRANGE("Impute on days off", FALSE);
                                    Abs.CALCSUMS("Quantity (Days)");
                                    absdec03 := Abs."Quantity (Days)";

                                    //
                                    IF (NoteNet = 0) AND (typemnt = 0) THEN BEGIN
                                        typemnt := 1;
                                        SalaryLine."Basis salary" := 0;
                                        SalaryLine."Net salary" := 0;
                                        SalaryLine."Assiduity (Paid days)" := 0;
                                        SalaryLine."Assiduity (Worked days)" := 0;
                                    END;
                                    RecInd.RESET;
                                    RecInd.SETCURRENTKEY("No.", "Employee No.", "Non Inclus en Prime", "Type Indemnité", Type);
                                    RecInd.SETFILTER("No.", SalLineEngTmp."No.");
                                    RecInd.SETFILTER("Employee No.", SalLineEngTmp.Employee);
                                    RecInd.SETFILTER("Non Inclus en Prime", '%1', TRUE);
                                    RecInd.SETFILTER("Type Indemnité", '%1', 0);
                                    RecInd.SETFILTER(Type, '%1', 0);
                                    RecInd.CALCSUMS("Real Amount PR");
                                    NbreMT := 0;
                                    NbreMT := (CALCDATE('+FM', SalaryLine."Posting Date") - DMY2DATE(1, 1, DATE2DWY(SalaryLine."Posting Date", 3)));///365;
                                    IF NbreMT MOD 31 > 15 THEN
                                        NbreMT := (NbreMT DIV 31) + 1
                                    ELSE
                                        NbreMT := NbreMT DIV 31;
                                    NbreMT := NbreMT / 12;
                                    IF DATE2DWY(SalaryLine."Posting Date", 3) > SalaryLine."year of Calculate" THEN
                                        SBbase := ROUND(((SalLineEngTmp."Gross Salary PR" - RecInd."Real Amount PR") * NoteNet),
                                                  ParamCpta."Amount Rounding Precision") - SalLineEngTmp2."Net salary"
                                    ELSE
                                        IF EntSal.Month = 11 THEN
                                            SBbase := ROUND(((SalLineEngTmp."Gross Salary PR" - RecInd."Real Amount PR") * NoteNet)
                                               // * SalaryLine."Assiduity (Paid days)"/100,ParamCpta."Amount Rounding Precision")-SalLineEngTmp2."Net salary"
                                               , ParamCpta."Amount Rounding Precision") - SalLineEngTmp2."Net salary"
                                        ELSE
                                            SBbase := ROUND(((SalLineEngTmp."Gross Salary PR" - RecInd."Real Amount PR") * NoteNet) * (NbreMT),
                                                           ParamCpta."Amount Rounding Precision") - SalLineEngTmp2."Net salary";

                                END;
                            3:
                                BEGIN

                                    SBbase := calcPrimeRepas(SalaryLine);
                                    typemnt := 1;
                                END;
                            5:
                                BEGIN
                                    CalcsoldeFinservice(SalaryLine);
                                    typemnt := 1;
                                    SolderDroitCongé := TRUE;
                                END;
                            6:
                                BEGIN

                                    SBbase := SalaryLine."Net salary";
                                    typemnt := 0;
                                END;

                            4:
                                BEGIN
                                    NbTrim := 0;
                                    Empl.RESET;
                                    IF Empl.GET(SalaryLine.Employee) THEN;
                                    FOR i := 1 TO 4 DO
                                        Val[i] := 0;
                                    SalaireBrut := 0;

                                    ParamRessHum.GET;
                                    CASE ParamRessHum."Type Calcul Note" OF
                                        0:
                                            FOR i := 1 TO 4 DO BEGIN
                                                Empl.SETFILTER(Trimestre, '%1', i);
                                                Empl.SETRANGE("Type Note", 0, 5);
                                                Empl.SETRANGE("Type Calcul", 1);
                                                Empl.SETFILTER("Filtre Année", '%1', SalaryLine."year of Calculate");
                                                Empl.CALCFIELDS("Note enreg.", "Montant Note enreg.");
                                                IF Empl."Note enreg." <> 0 THEN
                                                    NbTrim := NbTrim + 1;
                                                SalaireBrut := SalaireBrut + Empl."Montant Note enreg.";
                                                Val[i] := Empl."Note enreg.";
                                            END;
                                        1:
                                            BEGIN
                                                Empl.SETFILTER(Trimestre, '%1', SalaryLine.Trimestre);
                                                Empl.SETRANGE("Type Note", 0, 5);
                                                Empl.SETRANGE("Type Calcul", 1);
                                                Empl.SETFILTER("Filtre Année", '%1', SalaryLine."year of Calculate");
                                                Empl.CALCFIELDS("Note enreg.", "Montant Note enreg.");
                                                SalaireBrut := SalaireBrut + Empl."Montant Note enreg.";
                                                Val[1] := Empl."Note enreg.";
                                            END;
                                    END;
                                    IF NbTrim = 0 THEN
                                        NbTrim := 1;
                                    NoteNet := 0;
                                    SalLineEngTmp.RESET;
                                    SalLineEngTmp.SETCURRENTKEY(Year, Month, "Type Prime", Employee, "No.");
                                    SalLineEngTmp.SETRANGE(Year, SalaryLine."year of Calculate");
                                    SalLineEngTmp.SETRANGE(Month, 0, 11);
                                    SalLineEngTmp.SETRANGE("Type Prime", SalaryLine."Type Prime");

                                    IF SalaryLine."Posting Date" = DMY2DATE(26, 3, 2005) THEN
                                        SalLineEngTmp.SETRANGE(Month, 0, 2);
                                    SalLineEngTmp.SETFILTER(Employee, SalaryLine.Employee);
                                    IF NOT SalLineEngTmp.FIND('+') THEN BEGIN
                                        SalLineEngTmp.SETRANGE(Year, SalaryLine.Year);
                                        IF SalLineEngTmp.FIND('+') THEN;
                                    END;
                                    SalLineEngTmp2.RESET;
                                    SalLineEngTmp2.SETCURRENTKEY(Employee, "year of Calculate", Month, "Type Prime");
                                    SalLineEngTmp2.SETRANGE("year of Calculate", SalaryLine."year of Calculate");
                                    SalLineEngTmp2.SETRANGE("Type Prime", SalaryLine."Type Prime");

                                    SalLineEngTmp2.SETRANGE(Month, SalaryLine.Month);
                                    SalLineEngTmp2.SETFILTER(Employee, SalaryLine.Employee);
                                    SalLineEngTmp2.CALCSUMS("Gross Salary", "Net salary");
                                    IF SalaireBrut <> 0 THEN BEGIN
                                        typemnt := 1;
                                        SalaireBrut := SalaireBrut - SalaryLine."Basis salary" - SalLineEngTmp2."Gross Salary";
                                        IndmTmp.RESET;
                                        IndmTmp.SETFILTER("No.", SalaryLine."No.");
                                        IndmTmp.SETFILTER("Employee No.", SalaryLine.Employee);
                                        IndmTmp.SETFILTER(Type, '%1', 0);
                                        IF IndmTmp.FIND('-') THEN
                                            REPEAT
                                                SalaireBrut := (SalaireBrut - IndmTmp."Base Amount");
                                            UNTIL IndmTmp.NEXT = 0;
                                        // Creation Indemnité
                                        IF SalaireBrut <> 0 THEN BEGIN  //(SalLineEngTmp."Gross Salary PR"-RecInd."Real Amount PR") THEN BEGIN
                                            ParamRessHum.GET;
                                            ParamRessHum.TESTFIELD("Indem diff Prime");
                                            Indm.RESET;
                                            Indm.SETFILTER("No.", SalaryLine."No.");
                                            Indm.SETFILTER("Employee No.", SalaryLine.Employee);
                                            Indm.SETFILTER(Indemnity, ParamRessHum."Indem diff Prime");
                                            IF Indm.FIND('-') THEN BEGIN
                                                Indm."Base Amount" := Indm."Base Amount" - (SalaireBrut - (SalLineEngTmp."Gross Salary PR" - RecInd."Real Amount PR"));
                                                Indm."Real Amount" := Indm."Real Amount" - (SalaireBrut - (SalLineEngTmp."Gross Salary PR" - RecInd."Real Amount PR"));
                                                Indm."Evaluation mode" := 0;
                                                Indm.MODIFY;
                                            END ELSE BEGIN
                                                CLEAR(Def);
                                                IF Def.GET(ParamRessHum."Indem diff Prime") THEN;
                                                Def.TESTFIELD("Non Inclus en Prime", FALSE);
                                                Indm.INIT;
                                                Indm."No." := SalaryLine."No.";
                                                Indm."Employee No." := SalaryLine.Employee;
                                                Indm.Indemnity := ParamRessHum."Indem diff Prime";
                                                Indm."Employee Posting Group" := SalaryLine."Employee Posting Group";
                                                Indm."Employee Statistic Group" := SalaryLine."Statistics Group Code";
                                                Indm.Description := Def.Description;
                                                Indm.Type := Def.Type;
                                                Indm."Evaluation mode" := 0;
                                                Indm."Base Amount" := (SalaireBrut);//-(SalLineEngTmp."Gross Salary PR"-RecInd."Real Amount PR"));
                                                Indm."Real Amount" := (SalaireBrut);//-(SalLineEngTmp."Gross Salary PR"-RecInd."Real Amount PR"));
                                                Indm.Rate := 100;
                                                Indm."Global Dimension 1" := SalaryLine."Global Dimension 1";
                                                Indm."Global Dimension 2" := SalaryLine."Global Dimension 2";
                                                Indm."Real Amount PR" := 0;
                                                Indm."Minimum value" := Def."Minimum value";
                                                //Indm.Nom:=
                                                Indm."Non Inclis en AV NAt" := Def."Non Inclis en AV NAt";
                                                Indm."User ID" := USERID;
                                                Indm."Last Date Modified" := WORKDATE;
                                                Indm.Taux := 100;
                                                Indm."Type Indemnité" := Def."Type Indemnité";
                                                Indm."inclus en compta" := Def."non inclus en compta";
                                                Indm."Precision Arrondi Montant" := Def."Precision Arrondi Montant";
                                                Indm."Direction Arrondi" := Def."Direction Arrondi";
                                                Indm."Evaluation mode" := 0;
                                                Indm.INSERT;
                                            END;
                                        END;

                                        SBbase := SalaireBrut;
                                    END;


                                    EntSal.RESET;
                                    EntSal.SETCURRENTKEY(Year, Month, "No.");
                                    EntSal.SETRANGE(Year, SalaryLine."year of Calculate");
                                    EntSal.SETFILTER(Month, '%1..%2', 0, 11);
                                    IF EntSal.FIND('-') THEN;
                                    NoteM := (Val[1] + Val[2] + Val[3] + Val[4]) / NbTrim;
                                    CLEAR(CoefGratif);
                                    IF CoefGratif.GET(SalaryLine."Type Prime", Empl.Catégorie, NoteM) THEN
                                        NoteNet := CoefGratif."Coef Gratif"
                                    ELSE BEGIN
                                        CoefGratif.RESET;
                                        CoefGratif.SETFILTER(Prime, SalaryLine."Type Prime");
                                        CoefGratif.SETFILTER(Collège, Empl.Catégorie);
                                        CoefGratif.SETFILTER(Note, '..%1', NoteM);
                                        IF CoefGratif.FIND('+') THEN;
                                        CoefGratifT.RESET;
                                        CoefGratifT.SETFILTER(Prime, SalaryLine."Type Prime");
                                        CoefGratifT.SETFILTER(Collège, Empl.Catégorie);
                                        CoefGratifT.SETFILTER(Note, '%1..', NoteM);
                                        IF CoefGratifT.FIND('-') THEN;
                                        IF (CoefGratifT.Note - CoefGratif.Note) <> 0 THEN
                                            NoteNet := CoefGratif."Coef Gratif" + ((CoefGratifT."Coef Gratif" - CoefGratif."Coef Gratif") / (CoefGratifT.Note - CoefGratif.Note));
                                    END;
                                    Abs.RESET;
                                    Abs.SETCURRENTKEY("Employee No.", "Posting year", "Posting month", "Line type", "Impute on days off");
                                    Abs.SETFILTER("Employee No.", SalaryLine.Employee);
                                    Abs.SETRANGE("Posting year", SalaryLine."year of Calculate");
                                    EntSal.FIND('+');
                                    Abs.SETFILTER("Posting month", '..%1', EntSal.Month);
                                    Abs.SETFILTER("Line type", '0|3|4|8');
                                    Abs.SETRANGE("Impute on days off", FALSE);
                                    Abs.CALCSUMS("Quantity (Days)");
                                    absdec03 := Abs."Quantity (Days)";

                                    //
                                    IF (NoteNet = 0) AND (typemnt = 0) THEN BEGIN
                                        typemnt := 1;
                                        SalaryLine."Basis salary" := 0;
                                        SalaryLine."Net salary" := 0;
                                        SalaryLine."Assiduity (Paid days)" := 0;
                                        SalaryLine."Assiduity (Worked days)" := 0;
                                    END;
                                    RecInd.RESET;
                                    RecInd.SETCURRENTKEY("No.", "Employee No.", "Non Inclus en Prime", "Type Indemnité", Type);
                                    RecInd.SETFILTER("No.", SalLineEngTmp."No.");
                                    RecInd.SETFILTER("Employee No.", SalLineEngTmp.Employee);
                                    RecInd.SETFILTER("Non Inclus en Prime", '%1', TRUE);
                                    RecInd.SETFILTER("Type Indemnité", '%1', 0);
                                    RecInd.SETFILTER(Type, '%1', 0);
                                    RecInd.CALCSUMS("Real Amount PR");
                                    NbreMT := 0;
                                    NbreMT := (CALCDATE('+FM', SalaryLine."Posting Date") - DMY2DATE(1, 1, DATE2DWY(SalaryLine."Posting Date", 3)));///365;
                                    IF NbreMT MOD 31 > 15 THEN
                                        NbreMT := (NbreMT DIV 31) + 1
                                    ELSE
                                        NbreMT := NbreMT DIV 31;
                                    NbreMT := NbreMT / 12;
                                    IF DATE2DWY(SalaryLine."Posting Date", 3) > SalaryLine."year of Calculate" THEN
                                        SBbase := ROUND(((SalLineEngTmp."Gross Salary PR" - RecInd."Real Amount PR") * NoteNet),
                                                ParamCpta."Amount Rounding Precision") - SalLineEngTmp2."Net salary"
                                    ELSE
                                        IF EntSal.Month = 11 THEN
                                            SBbase := ROUND(((SalLineEngTmp."Gross Salary PR" - RecInd."Real Amount PR") * NoteNet)
                                               , ParamCpta."Amount Rounding Precision") - SalLineEngTmp2."Net salary"
                                        ELSE
                                            SBbase := ROUND(((SalLineEngTmp."Gross Salary PR" - RecInd."Real Amount PR") * NoteNet) * (NbreMT),
                                                    ParamCpta."Amount Rounding Precision") - SalLineEngTmp2."Net salary";
                                END;

                            2:
                                BEGIN
                                    // Calcul Rappel sur Salaire Net
                                    EntSal.RESET;
                                    EntSal.SETCURRENTKEY(Year, Month, "No.");
                                    EntSal.SETRANGE(Year, SalaryLine."year of Calculate");
                                    EntSal.SETFILTER(Month, '%1..%2', 0, 11);
                                    IF EntSal.FIND('+') THEN;
                                    DateMax := EntSal."Posting Date";
                                    MntRappel := 0;
                                    Carr.RESET;
                                    Carr.SETCURRENTKEY(employee, date);
                                    Carr.SETFILTER(employee, SalaryLine.Employee);
                                    Carr.SETFILTER("Date Décesion", '%1..', CALCDATE('-1A+FA+1J', EntSal."Posting Date"));
                                    IF Carr.FIND('-') THEN
                                        REPEAT
                                            IF CALCDATE('+FM', Carr."Date Décesion") <> CALCDATE('+FM', Carr.date) THEN BEGIN
                                                IF EntSal."Posting Date" > Carr."Date Décesion" THEN
                                                    DateMax := Carr."Date Décesion"
                                                ELSE
                                                    DateMax := EntSal."Posting Date";
                                                SalLineEngTmp.RESET;
                                                SalLineEngTmp.SETFILTER(Employee, SalaryLine.Employee);
                                                SalLineEngTmp.SETRANGE("Posting Date", Carr.date, CALCDATE('+FM', DateMax));
                                                SalLineEngTmp.SETFILTER(Month, '..11');
                                                IF SalLineEngTmp.FIND('-') THEN BEGIN
                                                    REPEAT
                                                        MntRappel := MntRappel + ROUND((Carr."Salaire Base" - SalLineEngTmp."Basis salary") * SalLineEngTmp."Assiduity (Paid days)" /
                                                                   100, ParamCpta."Amount Rounding Precision");
                                                    UNTIL SalLineEngTmp.NEXT = 0;
                                                END;
                                            END;
                                        UNTIL Carr.NEXT = 0;
                                    SalLineEngTmp.RESET;
                                    SalLineEngTmp.SETCURRENTKEY(Employee, "Posting Date", Month, "Type Prime");
                                    SalLineEngTmp.SETFILTER(Employee, SalaryLine.Employee);
                                    SalLineEngTmp.SETFILTER("Posting Date", '%1..', CALCDATE('-1A+FA+1J', EntSal."Posting Date"));
                                    SalLineEngTmp.SETRANGE(Month, SalaryLine.Month);
                                    SalLineEngTmp.SETFILTER("Type Prime", SalaryLine."Type Prime");
                                    SalLineEngTmp.CALCSUMS("Gross Salary");
                                    MntRappel := MntRappel - SalLineEngTmp."Gross Salary";
                                    IF MntRappel < 0 THEN
                                        MntRappel := 0;
                                    SBbase := MntRappel;
                                    typemnt := 1;
                                END;
                        END;
                    END;
                END;
            SalaryLine.Month::STC:
                BEGIN
                    // SBbase:=0;
                    typemnt := 1;
                END;
        END;
    end;


    procedure "CréerLigneSalaireSimulationPre"("N°Paie": Code[10]; "Salarié": Record 5200)
    var
        LigneSalaire: Record "MLigne salaire Prév.";
        RetenueSocialeLnSalaire: Record "Social Contributions Prév";
        ContratTravail: Record 5211;
        ParamGRH: Record 5218;
        errorGrpComptaSlrEmpty: Label 'Erreur :\La mention du Groupe compta. salarié est obligatoire.\Pour le remplir veuiller vous rendre sur la fiche salarié en question.\N° salarié  : ################1\Nom salarié : ################2';
        errorContratEmpty: Label 'Erreur:\La mention du Code contrat de travail du salarié est obligatoire.\Pour le remplir veuiller vous rendre sur la fiche salarié en question.\N° salarié  : ################1\Nom salarié : ################2';
        errorNulValue: Label 'Erreur :\Le Salaire mensuel de base et le Nombre de mois payés ne peuvent pas être nuls.';
        "RetenueSocialeSalarié": Record "Default Soc. Contribution";
        "IndemniteSalariéPrév": Record "Indemnities Prev";
        entesalaire: Record "En-tête salaire Prév.";
        IndemniteImposable: Record "Default Indemnities";
        IndemniteNonImposable: Record "Default Indemnities";
    begin
        IF ParamGRH.GET THEN;
        IF Salarié.Blocked THEN EXIT;//ERROR('Salarié Bloquer !!!! ');
        IF Salarié.Status > 1 THEN EXIT;//ERROR('Salarié Fin du Contrat !!!!');
        ContratTravail.RESET;
        IF ContratTravail.GET(Salarié."Emplymt. Contract Code") AND (ContratTravail."Employee's type" = 0) THEN
            EXIT;
        // ERROR('Salarié Occasionnel !!!!!! ');
        LigneSalaire."N° Paie" := "N°Paie";
        entesalaire.RESET;
        IF entesalaire.GET("N°Paie") THEN;
        LigneSalaire.Année := entesalaire.Année;

        IF ParamGRH."Paid days" <> 0 THEN
            LigneSalaire."Nombre de jours" := ParamGRH."Paid days"
        ELSE
            LigneSalaire."Nombre de jours" := 26;

        LigneSalaire."N° salarié" := Salarié."No.";
        LigneSalaire."Nom salarié" := Salarié."First Name" + ' ' + Salarié."Last Name";
        LigneSalaire."Code département" := Salarié."Global Dimension 1 Code";
        LigneSalaire."Code dossier" := Salarié."Global Dimension 2 Code";
        IF Salarié."Employee Posting Group" = '' THEN
            ERROR(errorGrpComptaSlrEmpty, Salarié."No.", Salarié."First Name" + ' ' + Salarié."Last Name");
        LigneSalaire."Groupe compta. salarié" := Salarié."Employee Posting Group";
        IF Salarié."Emplymt. Contract Code" = '' THEN
            ERROR(errorContratEmpty, Salarié."No.", Salarié."First Name" + ' ' + Salarié."Last Name");
        IF entesalaire."% Augmentatin Brut" <> 0 THEN
            LigneSalaire."Salaire de base" := ((Salarié."Basis salary" * (1 + entesalaire."% Augmentatin Brut" / 100))
            * entesalaire."Nbre Mois")
        ELSE
            LigneSalaire."Salaire de base" := (Salarié."Basis salary" * entesalaire."Nbre Mois");
        LigneSalaire.Etat := Salarié.Status;
        LigneSalaire."Nombre de mois payés" := ContratTravail."Regular payments";
        LigneSalaire."Salaire de Base Mensuiel" := Salarié."Basis salary";

        LigneSalaire."Nombre de mois payés" := ContratTravail."Regular payments";
        LigneSalaire."Nbre Mois" := entesalaire."Nbre Mois";
        LigneSalaire."% Augmentatin Brut" := entesalaire."% Augmentatin Brut";
        IF ((Salarié."Basis salary" = 0) OR (ContratTravail."Regular payments" = 0)) THEN
            ERROR(errorNulValue);
        IndemniteSalariéPrév.RESET;
        IndemniteSalariéPrév.SETFILTER("No.", "N°Paie");
        IndemniteSalariéPrév.SETFILTER("Employee No.", LigneSalaire."N° salarié");
        IndemniteSalariéPrév.DELETEALL;
        IndemniteImposable.RESET;
        IndemniteImposable.SETRANGE("Employment Contract Code", ContratTravail.Code);
        IndemniteImposable.SETFILTER("Indemnity Code", '<>''''');
        IndemniteImposable.SETRANGE(Type, 0);
        IF IndemniteImposable.FIND('-') THEN BEGIN
            REPEAT
                IndemniteSalariéPrév.INIT;
                IndemniteSalariéPrév."No." := "N°Paie";
                IndemniteSalariéPrév."Employee No." := LigneSalaire."N° salarié";
                IndemniteSalariéPrév.Indemnity := IndemniteImposable."Indemnity Code";
                IndemniteSalariéPrév.Description := IndemniteImposable.Description + ' SIMULATION';
                IndemniteSalariéPrév."Base Amount" := IndemniteImposable."Default amount" * entesalaire."Nbre Mois";
                IndemniteSalariéPrév.Type := IndemniteImposable.Type::Imposable;
                // MC : Dev. spécifique P.T.E. -> Datasoft 01/02/2002 ------------------------------------------------------------------------
                IndemniteSalariéPrév."Evaluation mode" := IndemniteImposable."Evaluation mode";
                CASE IndemniteImposable."Evaluation mode" OF
                    0:
                        BEGIN
                            IndemniteSalariéPrév.Taux := 100;
                            IndemniteSalariéPrév."Real Amount" := IndemniteImposable."Default amount" * entesalaire."Nbre Mois";
                        END;
                    1:
                        BEGIN
                            IndemniteSalariéPrév.Taux := 100;
                            IndemniteSalariéPrév."Real Amount" := IndemniteImposable."Default amount" * entesalaire."Nbre Mois";
                        END;
                    2:
                        BEGIN
                            IndemniteSalariéPrév.Taux := 100;
                            IndemniteSalariéPrév."Real Amount" := (IndemniteImposable."Default amount" * entesalaire."Nbre Mois")
                            ;
                        END;
                END;
                // ---------------------------------------------------------------------------------------------------------------------------
                IndemniteSalariéPrév.INSERT;
            UNTIL IndemniteImposable.NEXT = 0;
        END;

        IndemniteNonImposable.RESET;
        IndemniteNonImposable.SETRANGE("Employment Contract Code", ContratTravail.Code);
        IndemniteNonImposable.SETRANGE(Type, 1);
        IndemniteNonImposable.SETFILTER("Indemnity Code", '<>''''');

        IF IndemniteNonImposable.FIND('-') THEN BEGIN
            REPEAT
                IndemniteSalariéPrév.INIT;
                IndemniteSalariéPrév."No." := "N°Paie";
                IndemniteSalariéPrév."Employee No." := LigneSalaire."N° salarié";
                IndemniteSalariéPrév.Indemnity := IndemniteNonImposable."Indemnity Code";
                IndemniteSalariéPrév.Description := IndemniteNonImposable.Description + ' SIMULATION';
                IndemniteSalariéPrév."Base Amount" := IndemniteImposable."Default amount" * entesalaire."Nbre Mois";
                IndemniteSalariéPrév.Type := IndemniteImposable.Type;
                IndemniteImposable."Evaluation mode" := IndemniteNonImposable."Evaluation mode";
                CASE IndemniteNonImposable."Evaluation mode" OF
                    0:
                        IndemniteSalariéPrév.Taux := 100;
                    1:
                        IndemniteNonImposable.Taux := 100;
                    2:
                        IndemniteSalariéPrév.Taux := 100;
                END;
                IndemniteSalariéPrév."Real Amount" := IndemniteNonImposable."Default amount" * entesalaire."Nbre Mois";
                // ---------------------------------------------------------------------------------------------------------------------------
                IndemniteSalariéPrév.INSERT;
            UNTIL IndemniteNonImposable.NEXT = 0;
        END;

        ContratTravail.GET(Salarié."Emplymt. Contract Code");

        //IF ContratTravail."Cotisations sociales salarié" THEN
        BEGIN
            RetenueSocialeSalarié.RESET;
            RetenueSocialeSalarié.SETRANGE("Employment Contract Code", Salarié."Emplymt. Contract Code");
            //RetenueSocialeSalarié.SETfilter ("Employee's part",'>0');
            IF RetenueSocialeSalarié.FIND('-') THEN
                REPEAT
                    RetenueSocialeLnSalaire.INIT;
                    RetenueSocialeLnSalaire."No." := "N°Paie";
                    RetenueSocialeLnSalaire.Employee := Salarié."No.";
                    RetenueSocialeLnSalaire."Social Contribution" := RetenueSocialeSalarié."Social Contribution Code";
                    RetenueSocialeLnSalaire.Indemnity := RetenueSocialeSalarié."Indemnity Code";
                    RetenueSocialeLnSalaire.Description := '';//RetenueSocialeSalarié."Désignation retenue";
                    RetenueSocialeLnSalaire."Employer's part" := RetenueSocialeSalarié."Employer's part";
                    RetenueSocialeLnSalaire."Employee's part" := RetenueSocialeSalarié."Employee's part";
                    RetenueSocialeLnSalaire."Deductible of taxable basis" := RetenueSocialeSalarié."Deductible of taxable basis";
                    RetenueSocialeLnSalaire."Real Amount : Employee" := 0;
                    RetenueSocialeLnSalaire."Real Amount : Employer" := 0;
                    RetenueSocialeLnSalaire."Base Amount" := 0;
                    RetenueSocialeLnSalaire."Global Dimension 1" := Salarié."Global Dimension 1 Code";
                    RetenueSocialeLnSalaire."Global Dimension 2" := Salarié."Global Dimension 2 Code";
                    RetenueSocialeLnSalaire."Mode dévaluation" := RetenueSocialeSalarié."Mode dévaluation";
                    RetenueSocialeLnSalaire.INSERT;
                UNTIL RetenueSocialeSalarié.NEXT = 0;

        END;


        IF ContratTravail."Take in account deductions" THEN BEGIN
            //MAJTabLienParentéSalarié (Salarié."N°");
            Salarié.CALCFIELDS("Deduction Loaded child");
        END;

        LigneSalaire."Salaire imposable" := 0;

        LigneSalaire.INSERT;
    end;


    procedure "CalculerLigneSalaireSimulprév"(var LignePaie: Record "MLigne salaire Prév.") "SalaireNetSimulé": Decimal
    var
        TotalImposable: Decimal;
        tempo: Decimal;
        TrancheTemp: Record "Slices of imposition";
        TrancheInf: Record "Slices of imposition";
        Tranche: Record "Slices of imposition";
        RetenueSociale: Record "Social Contributions Prév";
        ContratTravail: Record 5211;
        errorTrancheImpEmpty: Label 'Erreur :\Table Tranches d''''imposition vide.\Echec de la procédure de calcul des salaires.';
        errorParamRessHumEmpty: Label 'Erreur :\La table Paramètres Ressources Humaines vide.\Impossible de poursuivre.';
        CodeRetenueSociale: Record "Social Contribution";
        Brut1: Decimal;
        Brut2: Decimal;
        Brut3: Decimal;
        Brut4: Decimal;
        errorSlrNotFound: Label 'Erreur :\Salarié introuvable.\Impossible de poursuivre.';
        intermed: Decimal;
        inter: Decimal;
        ParamGRH: Record 5218;
        "Salarié": Record 5200;
    begin
        //---------------------------------------------------------------------------------------------------------------------------

        IF NOT Tranche.FIND('-') THEN
            ERROR(errorTrancheImpEmpty);

        IF NOT ParamGRH.FIND('-') THEN
            ERROR(errorParamRessHumEmpty);

        //---------------------------------------------------------------------------------------------------------------------------

        Salarié.RESET;
        Salarié.GET(LignePaie."N° salarié");
        IF Salarié.Blocked THEN ERROR('Salarié Bloquer !!!! ');
        ContratTravail.RESET;
        ContratTravail.GET(Salarié."Emplymt. Contract Code");

        //---------------------------------------------------------------------------------------------------------------------------
        // MC : CALCFIELDS


        //indemnitéSimulation(LignePaie);

        LignePaie.CALCFIELDS(LignePaie."Indemnités imposables",
                              LignePaie."Indemnités No imposables",
                              LignePaie."Cotisations sociales employeur");

        //LignePaie."Assiduité Jours ouvrés"  := 100;
        LignePaie."Groupe compta. salarié" := Salarié."Employee Posting Group";
        LignePaie."Code département" := Salarié."Global Dimension 1 Code";
        LignePaie."Code dossier" := Salarié."Global Dimension 2 Code";
        LignePaie."Salaire de base" := (Salarié."Basis salary" * (1 + LignePaie."% Augmentatin Brut" / 100)) *
        LignePaie."Nbre Mois";
        IF (LignePaie."Retri. Provi. en Mois" = 0) AND (LignePaie."Montant de Retri. Provi." <> 0) THEN
            LignePaie."Retri. Provi. en Mois" := LignePaie."Montant de Retri. Provi." /
            (Salarié."Basis salary" * (1 + LignePaie."% Augmentatin Brut" / 100))
        ELSE
            LignePaie."Montant de Retri. Provi." := (Salarié."Basis salary" * (1 + LignePaie."% Augmentatin Brut" / 100)) *
            (LignePaie."Retri. Provi. en Mois");
        //---------------------------------------------------------------------------------------------------------------------------
        // MC : Total imposable + Brut [1,2,3,4]

        TotalImposable := 0;

        LignePaie."Brut du Période" := LignePaie."Salaire de base" + LignePaie."Indemnités imposables" +
                                       LignePaie."Montant de Retri. Provi.";

        TotalImposable := LignePaie."Salaire de base" + LignePaie."Indemnités imposables" +
                          LignePaie."Montant de Retri. Provi.";

        Brut1 := TotalImposable;                       //--> Base de calcul = Brut du mois
        Brut2 := TotalImposable - (6 * ParamGRH."Minimum wage guarantee"); //--> Base de calcul = Brut du mois - (6 * SMIG)
        Brut3 := TotalImposable;                       //--> Base de calcul = Brut du mois
        Brut4 := TotalImposable;                       //--> Base de calcul = Brut du mois

        //---------------------------------------------------------------------------------------------------------------------------

        RetenueSociale.RESET;
        RetenueSociale.SETRANGE("No.", LignePaie."N° Paie");
        RetenueSociale.SETRANGE(Employee, LignePaie."N° salarié");
        RetenueSociale.SETFILTER("Social Contribution", '<>''''');
        IF RetenueSociale.FIND('-') THEN
            REPEAT
                IF CodeRetenueSociale.GET(RetenueSociale."Social Contribution") THEN BEGIN
                    CASE RetenueSociale."Mode dévaluation" OF
                        0:
                            BEGIN
                                RetenueSociale."Base Amount" := Brut1;
                                RetenueSociale."Real Amount : Employer" := RetenueSociale."Employer's part" * Brut1 / 100;
                            END;
                        1:
                            BEGIN
                                RetenueSociale."Base Amount" := Brut2;
                                IF Brut2 > 0 THEN
                                    RetenueSociale."Real Amount : Employer" := RetenueSociale."Employer's part" * Brut2 / 100
                                ELSE
                                    RetenueSociale."Real Amount : Employer" := 0;
                            END;
                        2:
                            BEGIN
                                RetenueSociale."Base Amount" := Brut3;
                                RetenueSociale."Real Amount : Employer" := RetenueSociale."Employer's part" * Brut3 / 100;
                            END;
                        3:
                            BEGIN
                                RetenueSociale."Base Amount" := Brut4;
                                RetenueSociale."Real Amount : Employer" := RetenueSociale."Employer's part" * Brut4 / 100;
                            END;
                    END;
                END
                ELSE
                    RetenueSociale."Real Amount : Employer" := 0;
                RetenueSociale.MODIFY;
            UNTIL RetenueSociale.NEXT = 0;

        RetenueSociale.RESET;
        RetenueSociale.SETRANGE("No.", LignePaie."N° Paie");
        RetenueSociale.SETRANGE(Employee, LignePaie."N° salarié");
        RetenueSociale.SETRANGE("Real Amount : Employer", 0);
        IF RetenueSociale.FIND('-') THEN
            RetenueSociale.DELETEALL;

        LignePaie.CALCFIELDS(LignePaie."Cotisations sociales employeur");

        intermed := 0;

        RetenueSociale.RESET;
        RetenueSociale.SETRANGE("No.", LignePaie."N° Paie");
        RetenueSociale.SETRANGE(Employee, LignePaie."N° salarié");
        RetenueSociale.SETFILTER("Real Amount : Employer", '>0');
        RetenueSociale.SETRANGE("Deductible of taxable basis", FALSE);
        IF RetenueSociale.FIND('-') THEN
            REPEAT
                intermed := intermed + RetenueSociale."Real Amount : Employer";
            UNTIL RetenueSociale.NEXT = 0;

        LignePaie."Salaire imposable" := LignePaie."Brut du Période";

        TotalImposable := TotalImposable;


        // MC : Calcul de l'imposable Mensuel + Annuel




        //---------------------------------------------------------------------------------------------------------------------------
        // MC : Tranche d'imposition

        IF ContratTravail.Taxable THEN BEGIN
            IF ContratTravail."Calculation mode of the taxes" = ContratTravail."Calculation mode of the taxes"::"Barème standard" THEN BEGIN

                /* --------------------------------------------- Code standard -----------------------------------------------------
                      Tranche.RESET;
                      TrancheInf.RESET;
                      TrancheTemp.RESET;
                      TrancheTemp.FIND('-');
                      REPEAT
                        IF (((TrancheTemp."Tranche : Limite inférieure"<LignePaie."Total imposable annuel")
                          AND
                          (LignePaie."Total imposable annuel"<TrancheTemp."Tranche : Limite supérieure")
                          )OR
                          ((TrancheTemp."Tranche : Limite inférieure"<LignePaie."Total imposable annuel")
                          AND
                          (LignePaie."Total imposable annuel">TrancheTemp."Tranche : Limite supérieure")))
                         THEN Tranche.COPY(TrancheTemp);

                        IF ((TrancheTemp."Tranche : Limite inférieure"<LignePaie."Total imposable annuel")
                          AND
                          (LignePaie."Total imposable annuel">TrancheTemp."Tranche : Limite supérieure"))
                         THEN TrancheInf.COPY(Tranche);
                      UNTIL TrancheTemp.NEXT =0;

                      TrancheTemp.FIND('-');
                      IF Tranche."N°" = TrancheTemp."N°" THEN
                        TrancheInf.COPY(TrancheTemp);

                      LignePaie."Tranche d'imposition" := Tranche."N°";
                      LignePaie."Retenue sur tranche (An)" := (Tranche."Taux tranche" / 100)
                                                            * (LignePaie."Total imposable annuel" - TrancheInf."Tranche : Limite supérieure");

                      LignePaie."Retenue sur tranche (Mois)" := LignePaie."Retenue sur tranche (An)" / LignePaie."Nombre de mois payés";

                      LignePaie."Tranche d'imposition inf." := TrancheInf."N°";
                      LignePaie."Retenue sur tranche inf.(An)" := TrancheInf."Tranche : Limite supérieure"
                                                                * TrancheInf."Taux limite sup. tranche" /100;
                      LignePaie."Retenue sur tranche inf.(Mois)" := LignePaie."Retenue sur tranche inf.(An)"
                                                                  / LignePaie."Nombre de mois payés";
                  ------------------------------------------------- Code standard ----------------------------------------------------------*/

                // MC : Dev. Spec. pour Philips 30/02/2002 -----------------------------------------------------------------------------------------

                inter := 0;
                Tranche.RESET;

                IF NOT Tranche.FIND('-') THEN
                    ERROR('Erreur :\La table des tranches d''imposition est vide.\Impossible de poursuivre.');



                // MC : Dev. Spec. pour Philips 30/02/2002 -----------------------------------------------------------------------------------------

            END;
        END;

        //---------------------------------------------------------------------------------------------------------------------------

        IF NOT Salarié.GET(LignePaie."N° salarié") THEN
            ERROR(errorSlrNotFound, LignePaie."N° salarié");



        LignePaie.MODIFY;

        // MC : Fonction --> Retour Salaire net simulé (sans considération des paies prec.)

    end;


    procedure PaieInverseFeuilleCalculprime(var SalaryLine: Record "Salary Lines"; SBDepart: Decimal; NetVoulu: Decimal; Sim: Option Simulation,Real)
    var
        Empl: Record 5200;
        Line: Record "Salary Lines";
        Coef: Decimal;
        Ecart: Decimal;
        w: Dialog;
        temp: Decimal;
        applyNewBS: Label 'Apply new Basis salary value';
        Indm: Record "Indemnities";
        paramRSH: Record 5218;
        Def: Record "Indemnity";
        ParamRessHum: Record 5218;
        SalLineEngTmp2: Record "Rec. Salary Lines";
        NbreMT: Decimal;
    begin
        ParamCpta.GET;
        ParamRessHum.GET;
        w.OPEN('Procédure de calcul inverse en cours :\' +
                '####################################1#\' +
                'Salaire de base : ##################2#\' +
                'Salaire net     : ##################3#');

        Line.SETRANGE("No.", SalaryLine."No.");
        Line.SETRANGE(Employee, SalaryLine.Employee);
        IF Line.FIND('-') THEN;
        Line."Gross Salary (sans Av) PR" := SalaryLine."Gross Salary (sans Av) PR";
        Line."Gross Salary PR" := SalaryLine."Gross Salary PR";
        Line."Taxable indemnities PR" := SalaryLine."Taxable indemnities PR";
        Line."Non Taxable Soc. Contrib. PR" := SalaryLine."Non Taxable Soc. Contrib. PR";
        Line."Taxable indem. PR (Not Gross)" := SalaryLine."Taxable indem. PR (Not Gross)";
        Line."Taxable salary PR" := SalaryLine."Taxable salary PR";
        Line."Real taxable PR" := SalaryLine."Real taxable PR";
        Line."year of Calculate" := SalaryLine."year of Calculate";
        Line."Posting Date" := SalaryLine."Posting Date";
        NbreMT := 0;
        NbreMT := (CALCDATE('+FM', Line."Posting Date") - CALCDATE('-1A+FA+1J', Line."Posting Date"));///365;
        IF NbreMT MOD 31 > 15 THEN
            NbreMT := (NbreMT DIV 31) + 1
        ELSE
            NbreMT := NbreMT DIV 31;
        NbreMT := NbreMT / 12;
        IF DATE2DMY(Line."Posting Date", 3) > Line."year of Calculate" THEN
            SBDepart := Line."Basis salary"
        ELSE
            SBDepart := ROUND(Line."Basis salary" * (NbreMT), ParamCpta."Amount Rounding Precision");
        IF NetVoulu > Line."Basis salary" THEN
            Line."Basis salary" := NetVoulu;
        CalculerLigneSalaire(Line, FALSE, 2, 0, FALSE);
        Ecart := CalculerLigneSalaire(Line, FALSE, 2, 0, FALSE) - NetVoulu;
        //Line.MODIFY;

        IF (Ecart < 0) THEN BEGIN
            //--> Cas 1 : Augmenter le Salaire de Base

            WHILE ((ABS(Ecart) > 0.001) AND (Ecart <= 0)) DO BEGIN
                temp := CalculerLigneSalaire(Line, FALSE, 2, 0, FALSE);
                Ecart := temp - NetVoulu;
                IF (ABS(Ecart) > 50) THEN
                    Line."Basis salary" := Line."Basis salary" + 20
                ELSE BEGIN
                    IF (ABS(Ecart) > 10) THEN
                        Line."Basis salary" := Line."Basis salary" + 10
                    ELSE BEGIN
                        IF (ABS(Ecart) > 2) THEN
                            Line."Basis salary" := Line."Basis salary" + 2
                        ELSE BEGIN
                            IF (ABS(Ecart) > 0.01) THEN
                                Line."Basis salary" := Line."Basis salary" + 0.01
                            ELSE
                                Line."Basis salary" := Line."Basis salary" + 0.001;
                        END;
                    END;
                END;
                // Line.MODIFY;

                w.UPDATE(1, Line."No." + ' - ' + Line.Employee + ' : ' + Line.Name);
                w.UPDATE(2, ROUND(Line."Basis salary", ParamCpta."Amount Rounding Precision"));
                w.UPDATE(3, ROUND(temp, ParamCpta."Amount Rounding Precision"));

            END;
        END;
        IF (Ecart > 0) THEN BEGIN
            //--> Cas 2 : Diminuer le Salaire de Base

            WHILE ((ABS(Ecart) > 0.001) AND (Ecart >= 0)) DO BEGIN
                temp := CalculerLigneSalaire(Line, FALSE, 2, 0, FALSE);
                Ecart := temp - NetVoulu;
                IF (ABS(Ecart) > 50) THEN
                    Line."Basis salary" := Line."Basis salary" - 20
                ELSE BEGIN
                    IF (ABS(Ecart) > 10) THEN
                        Line."Basis salary" := Line."Basis salary" - 10
                    ELSE BEGIN
                        IF (ABS(Ecart) > 2) THEN
                            Line."Basis salary" := Line."Basis salary" - 2
                        ELSE BEGIN
                            IF (ABS(Ecart) > 0.01) THEN
                                Line."Basis salary" := Line."Basis salary" - 0.01
                            ELSE
                                Line."Basis salary" := Line."Basis salary" - 0.001;
                        END;
                    END;
                END;
                //Line.MODIFY;

                w.UPDATE(1, Line."No." + ' - ' + Line.Employee + ' : ' + Line.Name);
                w.UPDATE(2, ROUND(Line."Basis salary", ParamCpta."Amount Rounding Precision"));
                w.UPDATE(3, ROUND(temp, ParamCpta."Amount Rounding Precision"));

            END;
        END;
        mm := TRUE;
        CalculerLigneSalaire(Line, FALSE, 2, 0, FALSE);

        IF Sim = 1 THEN BEGIN
            IF Line.Month = Line.Month::Prime THEN BEGIN
                IF Line."Basis salary" <> SBDepart THEN BEGIN
                    paramRSH.GET;
                    paramRSH.TESTFIELD("Indem diff Prime");
                    // NE

                    Indm.RESET;
                    Indm.SETFILTER("No.", Line."No.");
                    Indm.SETFILTER("Employee No.", Line.Employee);
                    Indm.SETFILTER(Indemnity, paramRSH."Indem diff Prime");
                    IF Indm.FIND('-') THEN BEGIN

                        Indm."Base Amount" := Indm."Base Amount" - (Line."Basis salary" - SBDepart);
                        Indm."Real Amount" := Indm."Real Amount" - (Line."Basis salary" - SBDepart);
                        Indm.MODIFY;
                    END ELSE BEGIN
                        CLEAR(Def);
                        IF Def.GET(paramRSH."Indem diff Prime") THEN;
                        Def.TESTFIELD("Non Inclus en Prime", FALSE);
                        Indm.INIT;
                        Indm."No." := Line."No.";
                        Indm."Employee No." := Line.Employee;
                        Indm.Indemnity := paramRSH."Indem diff Prime";
                        Indm."Employee Posting Group" := Line."Employee Posting Group";
                        Indm.Description := Def.Description;
                        Indm.Type := Def.Type;
                        Indm."Evaluation mode" := Def."Evaluation mode";

                        Indm."Base Amount" := (Line."Basis salary" - SBDepart);//+0.002;
                        Indm."Real Amount" := (Line."Basis salary" - SBDepart);//+0.002;
                        Indm.Rate := 100;
                        Indm."Global Dimension 1" := Line."Global Dimension 1";
                        Indm."Global Dimension 2" := Line."Global Dimension 2";
                        Indm."Real Amount PR" := 0;
                        Indm."Minimum value" := Def."Minimum value";
                        //Indm.Nom:=
                        Indm."Non Inclis en AV NAt" := Def."Non Inclis en AV NAt";
                        Indm."User ID" := USERID;
                        Indm."Last Date Modified" := WORKDATE;
                        Indm.Taux := 100;
                        Indm."Type Indemnité" := Def."Type Indemnité";
                        Indm."inclus en compta" := Def."non inclus en compta";

                        Indm."Precision Arrondi Montant" := Def."Precision Arrondi Montant";
                        Indm."Direction Arrondi" := Def."Direction Arrondi";
                        Indm.INSERT;
                    END;
                    Line."Basis salary" := SBDepart;
                    //Line.MODIFY;
                END;
            END;

        END;
        SalaryLine."Basis salary" := Line."Basis salary";
        w.CLOSE;
        SalLineEngTmp2.RESET;
        SalLineEngTmp2.SETCURRENTKEY(Year, Month, Employee, "No.");
        SalLineEngTmp2.SETFILTER(Employee, SalaryLine.Employee);
        SalLineEngTmp2.SETFILTER(Year, '%1', SalaryLine.Year);
        SalLineEngTmp2.SETFILTER(Month, '<%1', 12);
        IF NOT SalLineEngTmp2.FIND('+') THEN BEGIN
            SalLineEngTmp2.SETFILTER(Year, '%1', (SalaryLine.Year - 1));
            IF NOT SalLineEngTmp2.FIND('+') THEN
                ERROR('Vous Devez Verifier L''année !!!!');
        END;
        CalcIndemnitéImp(SalaryLine);
        ;
        //--> Calcul du salaire Brut du mois
        "CalcInd&HsupNav"(SalaryLine, 1);
        //SalaryLine.CALCFIELDS ("Taxable indemnities","Supp. hours");
        SalaryLine."6 * SMIG" := 0;// ROUND(ParamRessHum."Minimum wage guarantee"*6,ParamCpta."Amount Rounding Precision");
        CASE SalaryLine."Employee's type" OF
            1:
                BEGIN

                    SalaryLine."Real basis salary" := ROUND((SalaryLine."Basis salary" * SalaryLine."Assiduity (Paid days)"
                                                             / 100), ParamCpta."Amount Rounding Precision");//RK
                                                                                                            // MESSAGE('5555  %1',SalaryLine."Real basis salary");
                    SalaryLine."Gross Salary (sans Av)" := ROUND((SalaryLine."Basis salary" * (SalaryLine."Assiduity (Paid days)"
                                                             / 100)) + SalaryLine."Taxable indemnities (Not Gross"//RK
                                                             + SalaryLine."Taxable indemnities"
                                                             + SalaryLine."Supp. hours", ParamCpta."Amount Rounding Precision");
                    SalaryLine."Gross Salary (sans Av) PR" := SalLineEngTmp2."Gross Salary (sans Av) PR";
                    SalaryLine."Gross Salary" := SalaryLine."Gross Salary (sans Av)";
                    SalaryLine."Gross Salary PR" := SalaryLine."Gross Salary (sans Av) PR";
                END;
            0:
                BEGIN
                    SalaryLine."Real basis salary" := ROUND(SalaryLine."Basis salary", ParamCpta."Amount Rounding Precision");
                    SalaryLine."Gross Salary (sans Av)" := ROUND((SalaryLine."Basis salary")
                                                           + SalaryLine."Taxable indemnities" + SalaryLine."Taxable indemnities (Not Gross"
                                                           + SalaryLine."Supp. hours", ParamCpta."Amount Rounding Precision");
                    SalaryLine."Gross Salary (sans Av) PR" := SalLineEngTmp2."Gross Salary (sans Av) PR";
                    SalaryLine."Gross Salary" := SalaryLine."Gross Salary (sans Av)";
                    SalaryLine."Gross Salary (sans Av) PR" := SalaryLine."Gross Salary (sans Av) PR";


                END;
        END;
        // Calc Indemnité AV Nat
        CalcIndemnitéAvNat(SalaryLine);
        //

        //SalaryLine.CALCFIELDS ("Taxable indemnities","Supp. hours");
        "CalcInd&Hsup"(SalaryLine, 1);
        CASE SalaryLine."Employee's type" OF
            1:
                BEGIN

                    SalaryLine."Real basis salary" := ROUND((SalaryLine."Basis salary" * SalaryLine."Assiduity (Paid days)"
                                                             / 100), ParamCpta."Amount Rounding Precision");//RK
                                                                                                            //MESSAGE('1111  %1',SalaryLine."Real basis salary");
                    SalaryLine."Gross Salary" := ROUND((SalaryLine."Basis salary" * (SalaryLine."Assiduity (Paid days)"
                                                            / 100))//RK
                                                            + SalaryLine."Taxable indemnities"
                                                            + SalaryLine."Supp. hours", ParamCpta."Amount Rounding Precision");
                    // NENE
                    SalaryLine."Gross Salary PR" := SalLineEngTmp2."Gross Salary PR";

                END;
            0:
                BEGIN
                    SalaryLine."Real basis salary" := ROUND(SalaryLine."Basis salary", ParamCpta."Amount Rounding Precision");
                    SalaryLine."Gross Salary" := ROUND((SalaryLine."Basis salary")
                                                           + SalaryLine."Taxable indemnities"
                                                           + SalaryLine."Supp. hours", ParamCpta."Amount Rounding Precision");
                    SalaryLine."Gross Salary PR" := SalLineEngTmp2."Gross Salary PR";

                END;
        END;
        // --> Calc Cotisation Social
        IF ParamRessHum."type calcul solde congé" = 0 THEN
            SalaryLine."Basis salary" := SalaryLine."Basis salary" - SalaryLine."Amount Days Off balacement";

        CalcCotisationSocial1(SalaryLine);
    end;


    procedure CalcsoldeFinservice(var SalaryLine: Record "Salary Lines")
    var
        SalaryHeader: Record "Salary Headers";
        ParamRessHum: Record 5218;
        SalLineEngTmp: Record "Rec. Salary Lines";
        LigneNoteTmp: Record "Ligne Pointage Salarié Chanti";
        Abs: Record "Employee's days off Entry";
        i: Integer;
        Val: array[4] of Decimal;
        NbTrim: Integer;
        Empl: Record 5200;
        EntSal: Record "Rec. Salary Headers";
        absdec03: Decimal;
        "cause of absence": Record 5206;
        CoefGratifT: Record "Coef Gratification";
        Indm: Record "Indemnities";
        Def: Record "Indemnity";
        RecInd: Record "Rec. Indemnities";
        IndmTmp: Record "Indemnities";
        SalLineEngTmp2: Record "Rec. Salary Lines";
        NbreMT: Decimal;
        PrimeType: Record "Prime1";
        DateMax: Date;
        MntRappel: Decimal;
        Carr: Record 50006;
        IndLic: Decimal;
        RegimW: Record "Regimes of work";
    begin
        //CalcsoldeFinservice
        NbTrim := 0;
        Empl.RESET;
        IF Empl.GET(SalaryLine.Employee) THEN;
        FOR i := 1 TO 4 DO
            Val[i] := 0;
        SalaireBrut := 0;

        ParamRessHum.GET;
        IF NbTrim = 0 THEN
            NbTrim := 1;
        NoteNet := 0;
        SalLineEngTmp.RESET;
        SalLineEngTmp.SETCURRENTKEY(Year, Month, "Type Prime", Employee, "No.");
        SalLineEngTmp.SETRANGE(Year, SalaryLine."year of Calculate");
        SalLineEngTmp.SETRANGE(Month, 0, 11);
        //SalLineEngTmp.SETRANGE("Type Prime",SalaryLine."Type Prime");
        SalLineEngTmp.SETFILTER(Employee, SalaryLine.Employee);
        IF NOT SalLineEngTmp.FIND('+') THEN BEGIN
            SalLineEngTmp.SETRANGE(Year, SalaryLine.Year);
            IF SalLineEngTmp.FIND('+') THEN;
        END;
        IF ParamRessHum."nbre J par Mois travail" <> 0 THEN BEGIN
            CLEAR(RegimW);
            RegimW.GET(SalaryLine."Employee Regime of work");
            ParamRessHum.TESTFIELD("ind. Gratif. Fin Serv.");
            NbreM := 0;
            IF DATE2DMY(Empl."Employment Date", 1) = 1 THEN
                NbreM := (CALCDATE('+FM', SalaryLine."Posting Date") - Empl."Employment Date") DIV 30
            ELSE BEGIN
                NbreM := (CALCDATE('+FM', SalaryLine."Posting Date") - CALCDATE('+FM+1J', Empl."Employment Date")) DIV 30;
                NbreM := NbreM + ROUND((CALCDATE('+FM', Empl."Employment Date") - Empl."Employment Date") / RegimW."Nbre Jour Payé Per Month", 0.01);

            END;
            IndLic := 0;
            IndLic := ROUND(ParamRessHum."nbre J par Mois travail" * ROUND(SalLineEngTmp."Gross Salary (sans Av) PR" / RegimW.
           "Worked Day Per Month", ParamCpta."Amount Rounding Precision") * NbreM, ParamCpta."Amount Rounding Precision");
            IF ParamRessHum."Max en Mois" <> 0 THEN
                IF IndLic > ROUND(SalLineEngTmp."Gross Salary (sans Av) PR" * ParamRessHum."Max en Mois", ParamCpta."Amount Rounding Precision") THEN
                    IndLic := ROUND(SalLineEngTmp."Gross Salary (sans Av) PR" * ParamRessHum."Max en Mois", ParamCpta."Amount Rounding Precision");
            IF IndLic <> 0 THEN BEGIN
                Indm.RESET;
                Indm.SETFILTER("No.", SalaryLine."No.");
                Indm.SETFILTER("Employee No.", SalaryLine.Employee);
                Indm.SETFILTER(Indemnity, ParamRessHum."ind. Gratif. Fin Serv.");
                IF Indm.FIND('-') THEN BEGIN
                    Indm."Base Amount" := Indm."Base Amount" + IndLic;
                    Indm."Real Amount" := Indm."Real Amount" + IndLic;
                    Indm."Evaluation mode" := 0;
                    Indm.MODIFY;
                END ELSE BEGIN
                    CLEAR(Def);
                    IF Def.GET(ParamRessHum."ind. Gratif. Fin Serv.") THEN;
                    Def.TESTFIELD("Non Inclus en Prime", FALSE);
                    Indm.INIT;
                    Indm."No." := SalaryLine."No.";
                    Indm."Employee No." := SalaryLine.Employee;
                    Indm.Indemnity := ParamRessHum."ind. Gratif. Fin Serv.";
                    Indm."Employee Posting Group" := SalaryLine."Employee Posting Group";
                    Indm."Employee Statistic Group" := SalaryLine."Statistics Group Code";
                    Indm.Description := Def.Description;
                    Indm.Type := Def.Type;
                    Indm."Evaluation mode" := 0;
                    Indm."Base Amount" := (IndLic);//-(SalLineEngTmp."Gross Salary PR"-RecInd."Real Amount PR"));
                    Indm."Real Amount" := (IndLic);//-(SalLineEngTmp."Gross Salary PR"-RecInd."Real Amount PR"));
                    Indm.Rate := 100;
                    Indm."Global Dimension 1" := SalaryLine."Global Dimension 1";
                    Indm."Global Dimension 2" := SalaryLine."Global Dimension 2";
                    Indm."Real Amount PR" := 0;
                    Indm."Minimum value" := Def."Minimum value";
                    //Indm.Nom:=
                    Indm."Non Inclis en AV NAt" := Def."Non Inclis en AV NAt";
                    Indm."User ID" := USERID;
                    Indm."Last Date Modified" := WORKDATE;
                    Indm.Taux := 100;
                    Indm."Type Indemnité" := Def."Type Indemnité";
                    Indm."inclus en compta" := Def."non inclus en compta";
                    Indm."Precision Arrondi Montant" := Def."Precision Arrondi Montant";
                    Indm."Direction Arrondi" := Def."Direction Arrondi";
                    Indm."Evaluation mode" := 0;
                    Indm.INSERT;
                END;
            END;

        END;

        IF ParamRessHum."Nbre Mois (Licensement)" <> 0 THEN BEGIN
            CLEAR(RegimW);
            RegimW.GET(SalaryLine."Employee Regime of work");
            ParamRessHum.TESTFIELD("Ind. Licensement");
            NbreM := 0;
            IF DATE2DMY(Empl."Employment Date", 1) = 1 THEN
                NbreM := (CALCDATE('+FM', SalaryLine."Posting Date") - Empl."Employment Date") DIV 30
            ELSE BEGIN
                NbreM := (CALCDATE('+FM', SalaryLine."Posting Date") - CALCDATE('+FM+1J', Empl."Employment Date")) DIV 30;
                NbreM := NbreM + ROUND((CALCDATE('+FM', Empl."Employment Date") - Empl."Employment Date") / RegimW."Nbre Jour Payé Per Month", 0.01);
                NbreM := ROUND(NbreM / 12, 0.01);
            END;
            IndLic := 0;
            IndLic := ROUND(ParamRessHum."Nbre Mois (Licensement)" * SalLineEngTmp."Gross Salary (sans Av) PR"
                      * NbreM, ParamCpta."Amount Rounding Precision");
            IF ParamRessHum."Max en Mois (Lic.)" <> 0 THEN
                IF IndLic > ROUND(SalLineEngTmp."Gross Salary (sans Av) PR" * ParamRessHum."Max en Mois (Lic.)", 0.001) THEN
                    IndLic := ROUND(SalLineEngTmp."Gross Salary (sans Av) PR" * ParamRessHum."Max en Mois (Lic.)", 0.001);
            IF IndLic <> 0 THEN BEGIN
                Indm.RESET;
                Indm.SETFILTER("No.", SalaryLine."No.");
                Indm.SETFILTER("Employee No.", SalaryLine.Employee);
                Indm.SETFILTER(Indemnity, ParamRessHum."Ind. Licensement");
                IF Indm.FIND('-') THEN BEGIN
                    Indm."Base Amount" := Indm."Base Amount" + IndLic;
                    Indm."Real Amount" := Indm."Real Amount" + IndLic;
                    Indm."Evaluation mode" := 0;
                    Indm.MODIFY;
                END ELSE BEGIN
                    CLEAR(Def);
                    IF Def.GET(ParamRessHum."Ind. Licensement") THEN;
                    Def.TESTFIELD("Non Inclus en Prime", FALSE);
                    Indm.INIT;
                    Indm."No." := SalaryLine."No.";
                    Indm."Employee No." := SalaryLine.Employee;
                    Indm.Indemnity := ParamRessHum."Ind. Licensement";
                    Indm."Employee Posting Group" := SalaryLine."Employee Posting Group";
                    Indm."Employee Statistic Group" := SalaryLine."Statistics Group Code";
                    Indm.Description := Def.Description;
                    Indm.Type := Def.Type;
                    Indm."Evaluation mode" := 0;
                    Indm."Base Amount" := (IndLic);//-(SalLineEngTmp."Gross Salary PR"-RecInd."Real Amount PR"));
                    Indm."Real Amount" := (IndLic);//-(SalLineEngTmp."Gross Salary PR"-RecInd."Real Amount PR"));
                    Indm.Rate := 100;
                    Indm."Global Dimension 1" := SalaryLine."Global Dimension 1";
                    Indm."Global Dimension 2" := SalaryLine."Global Dimension 2";
                    Indm."Real Amount PR" := 0;
                    Indm."Minimum value" := Def."Minimum value";
                    //Indm.Nom:=
                    Indm."Non Inclis en AV NAt" := Def."Non Inclis en AV NAt";
                    Indm."User ID" := USERID;
                    Indm."Last Date Modified" := WORKDATE;
                    Indm.Taux := 100;
                    Indm."Type Indemnité" := Def."Type Indemnité";
                    Indm."inclus en compta" := Def."non inclus en compta";
                    Indm."Precision Arrondi Montant" := Def."Precision Arrondi Montant";
                    Indm."Direction Arrondi" := Def."Direction Arrondi";
                    Indm."Evaluation mode" := 0;
                    Indm.INSERT;
                END;
            END;

        END;
    end;


    procedure calcPrimeRepas(var SalaryLine: Record "Salary Lines") SalaireBrut: Decimal
    var
        EcrtPoint: Record "Chantier Enreg.";
    begin
        //calcPrimeRepas
        /*SalaireBrut:=0;
      EcrtPoint.RESET;
      EcrtPoint.SETCURRENTKEY(Employee,year,"Paie No.",Sequence);
      EcrtPoint.SETFILTER(Employee,SalaryLine.Employee);
      EcrtPoint.SETFILTER("Paie No.",'=''''');
      EcrtPoint.SETRANGE(year,SalaryLine.Year);
      EcrtPoint.CALCSUMS("Montant Repas");
      SalaireBrut:= EcrtPoint."Montant Repas";
      EcrtPoint.MODIFYALL("Paie No.",SalaryLine."No.");
      EcrtPoint.MODIFYALL("Date Paie",SalaryLine."Posting Date");
      */

    end;


    procedure CreerLignetransport(var salaryLineTmp: Record "Salary Lines")
    var
        LinePointage: Record "Chantier Enreg.";
        Indm: Record "Indemnities";
        Ind: Record "Indemnity";
        Paramrsh: Record 5218;
        regim: Record "Regimes of work";
        Empl: Record 5200;
    begin
        //CreerLignetransport
        Paramrsh.GET;
        LinePointage.RESET;
        LinePointage.SETCURRENTKEY(Employee, year, month, "Jours du transport", Sequence);
        LinePointage.SETFILTER(Employee, salaryLineTmp.Employee);
        LinePointage.SETRANGE(year, salaryLineTmp.Year);
        LinePointage.SETRANGE(month, salaryLineTmp.Month);
        LinePointage.SETRANGE("Jours du transport", TRUE);
        IF LinePointage.FIND('-') THEN BEGIN
            CLEAR(Ind);
            Ind.GET(Paramrsh."Ind transport Chantier");
            Indm.INIT;
            Indm."No." := salaryLineTmp."No.";
            Indm."Employee No." := salaryLineTmp.Employee;
            Indm.Indemnity := Ind.Code;
            Indm."Employee Posting Group" := salaryLineTmp."Employee Posting Group";
            Indm.Description := Ind.Description;
            Indm.Type := Ind.Type;
            Indm."Evaluation mode" := Ind."Evaluation mode";
            CLEAR(regim);
            regim.GET(salaryLineTmp."Employee Regime of work");
            CLEAR(Empl);
            Empl.GET(salaryLineTmp.Employee);
            Indm."Base Amount" := ROUND(((Empl."Basis salary" / regim."Nbre Jour Payé Per Month") * LinePointage.COUNT),
                                  Ind."Precision Arrondi Montant", FORMAT(Ind."Direction Arrondi"));
            Indm."Real Amount" := Indm."Base Amount";
            Indm.Rate := 100;
            Indm.Nom := salaryLineTmp.Name;
            Indm."Global Dimension 1" := Empl."Global Dimension 1 Code";
            Indm."Global Dimension 2" := Empl."Global Dimension 2 Code";
            Indm."Real Amount PR" := 0;
            Indm."Non Inclis en AV NAt" := Ind."Non Inclis en AV NAt";
            Indm."User ID" := USERID;
            Indm.Taux := Ind.Taux;
            Indm."Type Indemnité" := Ind."Type Indemnité";
            Indm."inclus en compta" := Ind."non inclus en compta";
            Indm."Non Inclus en Prime" := Ind."Non Inclus en Prime";
            Indm."Precision Arrondi Montant" := Ind."Precision Arrondi Montant";
            Indm."Direction Arrondi" := Ind."Direction Arrondi";
            Indm.INSERT;


        END;
        Paramrsh.GET;
        LinePointage.RESET;
        LinePointage.SETCURRENTKEY(Employee, year, month, "a Payé", Sequence);
        LinePointage.SETFILTER(Employee, salaryLineTmp.Employee);
        LinePointage.SETRANGE(year, salaryLineTmp.Year);
        LinePointage.SETRANGE(month, salaryLineTmp.Month);
        LinePointage.SETRANGE("a Payé", TRUE);
        IF LinePointage.FIND('-') THEN BEGIN
            CLEAR(Ind);
            Ind.GET(Paramrsh."Ind supp Chantier");
            Indm.INIT;
            Indm."No." := salaryLineTmp."No.";
            Indm."Employee No." := salaryLineTmp.Employee;
            Indm.Indemnity := Ind.Code;
            Indm."Employee Posting Group" := salaryLineTmp."Employee Posting Group";
            Indm.Description := Ind.Description;
            Indm.Type := Ind.Type;
            Indm."Evaluation mode" := Ind."Evaluation mode";
            CLEAR(regim);
            regim.GET(salaryLineTmp."Employee Regime of work");
            CLEAR(Empl);
            Empl.GET(salaryLineTmp.Employee);
            Indm."Base Amount" := ROUND(((Empl."Basis salary" / regim."Nbre Jour Payé Per Month") * LinePointage.COUNT),
                                  Ind."Precision Arrondi Montant", FORMAT(Ind."Direction Arrondi"));
            Indm."Real Amount" := Indm."Base Amount";
            Indm.Nom := salaryLineTmp.Name;
            Indm.Rate := 100;
            Indm."Global Dimension 1" := Empl."Global Dimension 1 Code";
            Indm."Global Dimension 2" := Empl."Global Dimension 2 Code";
            Indm."Real Amount PR" := 0;
            Indm."Non Inclis en AV NAt" := Ind."Non Inclis en AV NAt";
            Indm."User ID" := USERID;
            Indm.Taux := Ind.Taux;
            Indm."Type Indemnité" := Ind."Type Indemnité";
            Indm."inclus en compta" := Ind."non inclus en compta";
            Indm."Non Inclus en Prime" := Ind."Non Inclus en Prime";
            Indm."Precision Arrondi Montant" := Ind."Precision Arrondi Montant";
            Indm."Direction Arrondi" := Ind."Direction Arrondi";
            Indm.INSERT;


        END;
    end;


    procedure UpdateEmpContrat()
    var
        HumanResSetup: Record 5218;
        RecSalaryLines: Record "Rec. Salary Lines";
        EmploymentContract: Record 5211;
    begin
        /*ParamCpta.GET();
        HumanResSetup.FIND('-');
        EMP.RESET;
        EMP.SETFILTER(Status,'%1',EMP.Status::Active);
        EMP.SETFILTER("Employee's Type Contrat",'%1','A');
        IF EMP.FIND('-') THEN
        BEGIN
        REPEAT
         i :=0;
         RecSalaryLines.RESET;
         RecSalaryLines.SETFILTER(Employee,'%1',EMP."No.");
         IF RecSalaryLines.FIND('-') THEN
         i := RecSalaryLines.COUNT();
         EmploymentContract.GET(EMP."No.");
         Linegrid.RESET;
         Linegrid.SETFILTER(Collège,'%1','1A');
         Linegrid.SETRANGE(Echelon,1);
         IF Linegrid.FIND('-') THEN
          BEGIN
           IF EMP."Employee's type" = EMP."Employee's type"::"Month based"   THEN
              BEGIN
                IF EMP."Employee's Type Contrat" = 'A' THEN
                 BEGIN
                     IF ((i >= 3) AND (i <6)) THEN
                      EMP."Basis salary" := (Linegrid."Salaire de base"*40)/100
                     ELSE
                     IF ((i >= 6) AND (i <9)) THEN
                      EMP."Basis salary" := (Linegrid."Salaire de base"*50)/100
                     ELSE
                     IF ((i >= 9) AND (i <12)) THEN
                      EMP."Basis salary" := (Linegrid."Salaire de base"*60)/100
                     ELSE
                     IF i >= 12 THEN BEGIN
                       EMP."Employee's Type Contrat" :='J';
                       EMP."Basis salary" :=(Linegrid."Salaire de base"*85)/100;
                        END;
                 END;
               END
               ELSE
              IF EMP."Employee's type" = EMP."Employee's type"::"Hour based"   THEN
              BEGIN
                IF EMP."Employee's Type Contrat"  = 'A' THEN
                 BEGIN
                     IF ((i >= 3) AND (i <6)) THEN
                      EMP."Basis salary" := ROUND(((Linegrid."Salaire de base"*40)/100)/
                                        (HumanResSetup."Worked days"*HumanResSetup."From Work day to Work hour"),
                                        ParamCpta."Amount Rounding Precision")
                     ELSE
                     IF ((i >= 6) AND (i <9)) THEN
                      EMP."Basis salary" := ROUND(((Linegrid."Salaire de base"*50)/100)/
                                        (HumanResSetup."Worked days"*HumanResSetup."From Work day to Work hour"),
                                        ParamCpta."Amount Rounding Precision")
                     ELSE
                     IF ((i >= 9) AND (i <12)) THEN
                      EMP."Basis salary" := ROUND(((Linegrid."Salaire de base"*60)/100)/
                                        (HumanResSetup."Worked days"*HumanResSetup."From Work day to Work hour"),
                                        ParamCpta."Amount Rounding Precision");
                     IF i >= 12 THEN BEGIN
                       EMP."Employee's Type Contrat" :='J';
                       EMP."Basis salary" := (Linegrid."Salaire de base"*85)/100/
                       (HumanResSetup."Worked days"*HumanResSetup."From Work day to Work hour");
                        EMP.Collège := '1';
                          END
                          ELSE
                    IF i >= 24 THEN
                      MESSAGE('Salarié N° %1  %2 a atteind 2 ans de travail',EMP."No.",EMP."First Name");
           END;
           END;
           END;
        EMP.MODIFY;
        UNTIL EMP.NEXT = 0;
        END;
        */

    end;


    procedure CalculerLignePrimeRend(SalaryLine: Record "Salary Lines"; "SolderDroitCongé": Boolean; Sim: Option Simulation,Real; nbjsolder: Decimal; var DatGDateDebut: Date; var DatGDateFin: Date): Decimal
    var
        SalaryHeader: Record "Salary Headers";
        Ind: Record "Indemnities";
        SocialContributions: Record "Social Contributions";
        ParamRessHum: Record 5218;
        EmploymentContract: Record 5211;
        RegimeWork: Record "Regimes of work";
        Employee: Record 5200;
        SliceImposition: Record "Slices of imposition";
        SliceImpositionX: Record "Slices of imposition";
        temp: Decimal;
        tmp: Decimal;
        tmp1: Decimal;
        Cot: Record "Default Soc. Contribution";
        nbr: Integer;
        bonus: Decimal;
        SalLineEng: Record "Rec. Salary Lines";
        EntEng: Record "Rec. Salary Headers";
        LigneTravail: Record "Heures occa. enreg. m";
        WorkedD: Decimal;
        "Mgmt.ofLoansandAdvances": Codeunit "Mgmt. of Loans and Advances";
        droitconge: Record "Employee's days off Entry";
        SalLineEngTmp: Record "Rec. Salary Lines";
        SalLineEngTmp2: Record "Rec. Salary Lines";
        typemnt: Option SalaireNet,SalaireBrut;
        NbreMT: Decimal;
        PrimeType: Record "Prime1";
        RecHSuppEnreg: Record "Heures sup. eregistrées m";
        DecGJourNormal: Decimal;
        DecGJourSupp: Decimal;
        DecGJourConge: Decimal;
        DecGHeureNormal: Decimal;
        DecGHeureConge: Decimal;
        DecGHeureSupp: Decimal;
        DecGNBJourAN: Decimal;
        DecGNBHeureAN: Decimal;
        SoldeReport: Decimal;
        RecGIndemnites: Record "Indemnities";
        DecMontantIdem: Decimal;
        DecGJournuit: Decimal;
        DecGheurenuit: Decimal;
        NBmoisTravaille: Decimal;
        NBMOIS: Integer;
        "RecIndemnité": Record "Default Indemnities";
        "recindemnitéEnreg": Record "Rec. Indemnities";
        DecSommeSalBase: Decimal;
    begin

        bonus := 1;
        nbr := 12;
        SalaryHeader.GET(SalaryLine."No.");
        ParamRessHum.GET();
        ParamCpta.GET;
        EmploymentContract.RESET;
        Employee.RESET;
        Employee.GET(SalaryLine.Employee);
        EmploymentContract.GET(Employee."Emplymt. Contract Code");
        RegimeWork.RESET;
        RegimeWork.GET(SalaryLine."Employee Regime of work");
        initLigne(SalaryLine, Sim);

        CASE ParamRessHum."Number of monthes" OF
            0:
                nbr := EmploymentContract."Regular payments";
            1:
                nbr := EmploymentContract."Temporary payments";
            2:
                nbr := EmploymentContract."Regular payments" + EmploymentContract."Temporary payments";
        END;
        //<<MBY 16/02/2009

        DecGNBJourAN := ParamRessHum."NB Jours annuel";
        DecGNBHeureAN := ParamRessHum."NB Heures annuel";
        CASE SalaryLine."Employee's type" OF
            0:
                BEGIN
                    //DSFT-AGA 15/03/2010
                    //Jours normal
                    IF ParamRessHum."Type Calcul prime" <> 2 THEN BEGIN
                        LigneTravail.RESET;
                        LigneTravail.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement", "Paiement No.");
                        LigneTravail.SETRANGE("Année de paiement", SalaryHeader.Year);
                        LigneTravail.SETFILTER("Paiement No.", '<>%1', '');
                        LigneTravail.SETRANGE("N° Salarié", SalaryLine.Employee);
                        LigneTravail.CALCSUMS("Nombre d'heures");
                        DecGHeureNormal := LigneTravail."Nombre d'heures";
                        //jour Conge
                        IF ParamRessHum."Inclure jours droit de congé" THEN BEGIN
                            droitconge.RESET;
                            droitconge.SETCURRENTKEY("Employee No.", "Posting month", "Posting year", "Line type", "Payment No.");
                            droitconge.SETRANGE("Posting year", SalaryHeader.Year);
                            droitconge.SETFILTER("Payment No.", '<>%1', '');
                            droitconge.SETRANGE("Employee No.", SalaryLine.Employee);
                            droitconge.SETRANGE("Line type", 1);
                            droitconge.CALCSUMS("Quantity (Hours)");
                            DecGHeureConge := droitconge."Quantity (Hours)";
                        END;
                        //jours supp
                        IF ParamRessHum."Inclure heures supplémentaire" THEN BEGIN
                            RecHSuppEnreg.RESET;
                            RecHSuppEnreg.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement", Date, "Paiement No.", "Type Jours");
                            RecHSuppEnreg.SETRANGE("Année de paiement", SalaryHeader.Year);
                            RecHSuppEnreg.SETFILTER("Paiement No.", '<>%1', '');
                            RecHSuppEnreg.SETRANGE("N° Salarié", SalaryLine.Employee);
                            RecHSuppEnreg.SETRANGE("Type Jours", 0);
                            RecHSuppEnreg.CALCSUMS("Nombre d'heures");
                            DecGHeureSupp := RecHSuppEnreg."Nombre d'heures";
                            GNbHeure := DecGHeureNormal + DecGHeureConge + DecGHeureSupp;
                        END;
                        IF ParamRessHum."Inclure heures de nuits" THEN BEGIN
                            RecHSuppEnreg.RESET;
                            RecHSuppEnreg.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement", Date, "Paiement No.", "Type Jours");
                            RecHSuppEnreg.SETRANGE("Année de paiement", SalaryHeader.Year);
                            RecHSuppEnreg.SETFILTER("Paiement No.", '<>%1', '');
                            RecHSuppEnreg.SETRANGE("N° Salarié", SalaryLine.Employee);
                            RecHSuppEnreg.SETRANGE("Type Jours", 3);
                            RecHSuppEnreg.CALCSUMS("Nombre d'heures");
                            DecGheurenuit := RecHSuppEnreg."Nombre d'heures";

                        END;
                        GNbHeure := DecGHeureNormal + DecGHeureConge + DecGHeureSupp + DecGheurenuit;

                    END;

                    IF (ParamRessHum."Type Calcul prime" = 2)
                    OR (ParamRessHum."Type Calcul prime" = 6)
                    OR (ParamRessHum."Type Calcul prime" = 8) THEN BEGIN
                        "RecGRec. Salary Lines".SETCURRENTKEY(Employee, Year, Month);
                        "RecGRec. Salary Lines".SETFILTER(Year, '%1', SalaryLine.Year);
                        "RecGRec. Salary Lines".SETFILTER(Month, '<%1', 12);
                        "RecGRec. Salary Lines".SETFILTER(Employee, SalaryLine.Employee);
                        "RecGRec. Salary Lines".CALCSUMS("Gross Salary", "Supp. hours", "Real basis salary");
                        DecGTotSalaireBrut := "RecGRec. Salary Lines"."Gross Salary";

                        IF (ParamRessHum."Type Calcul prime" = 2) THEN
                            DecGTotSalaireBrut := "RecGRec. Salary Lines"."Gross Salary" - "RecGRec. Salary Lines"."Supp. hours";
                        IF (ParamRessHum."Type Calcul prime" = 8) THEN
                            DecSommeSalBase := "RecGRec. Salary Lines"."Real basis salary"
                    END;
                END;
            //MENSUEL********************************************************************
            1:
                BEGIN
                    //jours normal
                    IF ParamRessHum."Type Calcul prime" <> 2 THEN BEGIN


                        LigneTravail.RESET;
                        LigneTravail.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement", "Paiement No.");
                        LigneTravail.SETRANGE("Année de paiement", SalaryHeader.Year);
                        LigneTravail.SETFILTER("Paiement No.", '<>%1', '');
                        LigneTravail.SETRANGE("N° Salarié", SalaryLine.Employee);
                        LigneTravail.CALCSUMS("Nbre Jour");
                        DecGJourNormal := LigneTravail."Nbre Jour";
                        //jour Conge
                        IF ParamRessHum."Inclure jours droit de congé" THEN BEGIN
                            droitconge.RESET;
                            droitconge.SETCURRENTKEY("Employee No.", "Posting month", "Posting year", "Line type", "Payment No.");
                            droitconge.SETRANGE("Posting year", SalaryHeader.Year);
                            droitconge.SETFILTER("Payment No.", '<>%1', '');
                            droitconge.SETRANGE("Employee No.", SalaryLine.Employee);
                            droitconge.SETRANGE("Line type", 1);
                            droitconge.CALCSUMS("Quantity (Days)");
                            DecGJourConge := droitconge."Quantity (Days)";
                        END;
                        //jours supp
                        IF ParamRessHum."Inclure heures supplémentaire" THEN BEGIN
                            RecHSuppEnreg.RESET;
                            RecHSuppEnreg.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement", Date, "Paiement No.", "Type Jours");
                            RecHSuppEnreg.SETRANGE("Année de paiement", SalaryHeader.Year);
                            RecHSuppEnreg.SETFILTER("Paiement No.", '<>%1', '');
                            RecHSuppEnreg.SETRANGE("N° Salarié", SalaryLine.Employee);
                            RecHSuppEnreg.SETRANGE("Type Jours", 0);
                            RecHSuppEnreg.CALCSUMS("Nombre d'heures");
                            DecGJourSupp := RecHSuppEnreg."Nombre d'heures";
                            DecGJourSupp := ROUND(DecGJourSupp * RegimeWork."Worked Day Per Month" / RegimeWork."Work Hours per month",
                                            ParamCpta."Amount Rounding Precision");

                        END;
                        // heures de nuit
                        IF ParamRessHum."Inclure heures de nuits" THEN BEGIN
                            RecHSuppEnreg.RESET;
                            RecHSuppEnreg.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement", Date, "Paiement No.", "Type Jours");
                            RecHSuppEnreg.SETRANGE("Année de paiement", SalaryHeader.Year);
                            RecHSuppEnreg.SETFILTER("Paiement No.", '<>%1', '');
                            RecHSuppEnreg.SETRANGE("N° Salarié", SalaryLine.Employee);
                            RecHSuppEnreg.SETRANGE("Type Jours", 3);
                            RecHSuppEnreg.CALCSUMS("Nombre d'heures");
                            DecGJournuit := RecHSuppEnreg."Nombre d'heures";
                            DecGJournuit := ROUND(DecGJournuit * RegimeWork."Worked Day Per Month" / RegimeWork."Work Hours per month",
                                        ParamCpta."Amount Rounding Precision");

                        END;
                        GNbJour := DecGJourNormal + DecGJourConge + DecGJourSupp + DecGJournuit;
                    END;
                    IF (ParamRessHum."Type Calcul prime" = 2)
                     OR (ParamRessHum."Type Calcul prime" = 6)
                     OR (ParamRessHum."Type Calcul prime" = 8) THEN BEGIN
                        "RecGRec. Salary Lines".SETCURRENTKEY(Employee, Year, Month);
                        "RecGRec. Salary Lines".SETFILTER(Year, '%1', SalaryLine.Year);
                        "RecGRec. Salary Lines".SETFILTER(Month, '<%1', 17);
                        "RecGRec. Salary Lines".SETFILTER(Employee, SalaryLine.Employee);
                        "RecGRec. Salary Lines".CALCSUMS("Gross Salary", "Supp. hours", "Real basis salary");
                        DecGTotSalaireBrut := "RecGRec. Salary Lines"."Gross Salary";

                        IF (ParamRessHum."Type Calcul prime" = 2) THEN
                            DecGTotSalaireBrut := "RecGRec. Salary Lines"."Gross Salary" - "RecGRec. Salary Lines"."Supp. hours";
                        IF (ParamRessHum."Type Calcul prime" = 8) THEN
                            DecSommeSalBase := "RecGRec. Salary Lines"."Real basis salary"



                    END;

                END;
        END;

        //>>MBY 16/02/2009
        GRecNote.RESET;
        //GRecNote.SETFILTER(GRecNote.Matricule,'%1',SalaryHeader."year of Calculate");
        //GRecNote.SETRANGE(GRecNote.Nom,4);
        //GRecNote.SETRANGE(GRecNote."D.Hr sup",4);
        //GRecNote.SETFILTER(GRecNote."Nom 1",SalaryLine.Employee);
        IF GRecNote.FINDFIRST THEN BEGIN
        END;
        SalaryLine.Note := GRecNote.Panier;
        SalaryLine.Pourcentage := 100;

        //>>DSFT AGA 17/03/2010
        IF (ParamRessHum."Type Calcul prime" = 0)
        OR (ParamRessHum."Type Calcul prime" = 3)
        OR (ParamRessHum."Type Calcul prime" = 4)
        OR (ParamRessHum."Type Calcul prime" = 10)
                                                THEN BEGIN

            RecGIndemnites.RESET;
            RecGIndemnites.SETCURRENTKEY("No.", "Employee No.", "Non Inclus en Prime");
            RecGIndemnites.SETFILTER("Employee No.", SalaryLine.Employee);
            RecGIndemnites.SETFILTER("No.", SalaryLine."No.");
            RecGIndemnites.SETFILTER("Non Inclus en Prime", '%1', FALSE);
            IF RecGIndemnites.FIND('-') THEN
                REPEAT
                    CASE RecGIndemnites."Evaluation mode" OF
                        0:
                            BEGIN
                                RecGIndemnites.Rate := 100;
                                RecGIndemnites."Real Amount" := RecGIndemnites."Base Amount";
                                RecGIndemnites."User ID" := USERID;
                                RecGIndemnites."Last Date Modified" := WORKDATE;
                            END;
                        1:
                            BEGIN
                                IF SalaryLine."Employee's type" = 0 THEN BEGIN
                                    RecGIndemnites.Rate := (GNbHeure / 173.33) * (100 / 100);
                                    IF ParamRessHum."Type Calcul prime" = 4 THEN
                                        RecGIndemnites.Rate := (22 / RegimeWork."Worked Day Per Month") * (GRecNote.Panier / 20);
                                    IF ParamRessHum."Type Calcul prime" = 7 THEN
                                        RecGIndemnites.Rate := 0;

                                    RecGIndemnites."Real Amount" := RecGIndemnites."Base Amount" * RecGIndemnites.Rate;
                                    RecGIndemnites."User ID" := USERID;
                                    RecGIndemnites."Last Date Modified" := WORKDATE;
                                END ELSE BEGIN
                                    RecGIndemnites.Rate := (GNbJour / 30) * (100 / 100);
                                    IF ParamRessHum."Type Calcul prime" = 7 THEN
                                        RecGIndemnites.Rate := 0;

                                    RecGIndemnites."Real Amount" := RecGIndemnites."Base Amount" * RecGIndemnites.Rate;
                                    RecGIndemnites."User ID" := USERID;
                                    RecGIndemnites."Last Date Modified" := WORKDATE;
                                END;
                            END;
                        2:
                            BEGIN
                                IF SalaryLine."Employee's type" = 0 THEN BEGIN
                                    RecGIndemnites.Rate := (GNbHeure / 173.33) * (100 / 100);
                                    IF ParamRessHum."Type Calcul prime" = 4 THEN
                                        RecGIndemnites.Rate := (22 / RegimeWork."Worked Day Per Month") * (GRecNote.Panier / 20);
                                    IF ParamRessHum."Type Calcul prime" = 7 THEN
                                        RecGIndemnites.Rate := 0;


                                    RecGIndemnites."Real Amount" := RecGIndemnites."Base Amount" * RecGIndemnites.Rate;
                                    RecGIndemnites."User ID" := USERID;
                                    RecGIndemnites."Last Date Modified" := WORKDATE;
                                END ELSE BEGIN
                                    RecGIndemnites.Rate := (GNbJour / 30) * (100 / 100);
                                    IF ParamRessHum."Type Calcul prime" = 4 THEN
                                        RecGIndemnites.Rate := (22 / RegimeWork."Worked Day Per Month") * (GRecNote.Panier / 20);
                                    IF ParamRessHum."Type Calcul prime" = 7 THEN
                                        RecGIndemnites.Rate := 0;

                                    RecGIndemnites."Real Amount" := RecGIndemnites."Base Amount" * RecGIndemnites.Rate;
                                    RecGIndemnites."User ID" := USERID;
                                    RecGIndemnites."Last Date Modified" := WORKDATE;
                                END;
                            END;
                        3:
                            BEGIN
                                RecGIndemnites.Rate := 1;
                                IF ParamRessHum."Type Calcul prime" = 4 THEN
                                    RecGIndemnites.Rate := (22 / RegimeWork."Worked Day Per Month") * (GRecNote.Panier / 20);
                                IF ParamRessHum."Type Calcul prime" = 7 THEN
                                    RecGIndemnites.Rate := 0;

                                RecGIndemnites."Real Amount" := RecGIndemnites."Base Amount" * RegimeWork."Work Hours per month"
                                                                       * RecGIndemnites.Rate;
                                RecGIndemnites."User ID" := USERID;
                                RecGIndemnites."Last Date Modified" := WORKDATE;
                            END;
                        4:
                            BEGIN
                                RecGIndemnites."Base Amount" := RecGIndemnites."Base Amount" * RecGIndemnites.Rate;
                                RecGIndemnites.Rate := 1;
                                IF ParamRessHum."Type Calcul prime" = 4 THEN
                                    RecGIndemnites.Rate := (22 / RegimeWork."Worked Day Per Month") * (GRecNote.Panier / 20);

                                IF ParamRessHum."Type Calcul prime" = 7 THEN
                                    RecGIndemnites.Rate := 0;

                                RecGIndemnites."Real Amount" := RecGIndemnites."Base Amount"
                                                                       * RecGIndemnites.Rate;
                                RecGIndemnites."User ID" := USERID;
                                RecGIndemnites."Last Date Modified" := WORKDATE;
                            END;

                        5:
                            BEGIN
                                RecGIndemnites.Rate := 100;
                                IF ParamRessHum."Type Calcul prime" = 4 THEN
                                    RecGIndemnites.Rate := (22 / RegimeWork."Worked Day Per Month") * (GRecNote.Panier / 20);
                                IF ParamRessHum."Type Calcul prime" = 7 THEN
                                    RecGIndemnites.Rate := 0;


                                RecGIndemnites."Real Amount" := RecGIndemnites."Base Amount" * RegimeWork."Worked Day Per Month"
                                                                       * RecGIndemnites.Rate;
                                RecGIndemnites."User ID" := USERID;
                                RecGIndemnites."Last Date Modified" := WORKDATE;
                            END;

                    END;
                    RecGIndemnites.MODIFY;
                UNTIL RecGIndemnites.NEXT = 0;
            RecGIndemnites.CALCSUMS("Real Amount");
            RecGIndemnites.CALCSUMS("Base Amount");

            DecMontantIdem := RecGIndemnites."Real Amount";

        END;

        FOR NBMOIS := 0 TO 11 DO BEGIN
            RecSalaireEnregistre.SETFILTER(Year, '%1', SalaryLine.Year);
            RecSalaireEnregistre.SETFILTER(Employee, SalaryLine.Employee);
            RecSalaireEnregistre.SETFILTER(Month, '%1', NBMOIS);
            IF RecSalaireEnregistre.COUNT >= 1 THEN
                NBmoisTravaille := NBmoisTravaille + 1;
        END;


        // calcul montant des primes
        IF (ParamRessHum."Type Calcul prime" = 5)
        OR (ParamRessHum."Type Calcul prime" = 7) OR (ParamRessHum."Type Calcul prime" = 9)
        OR (ParamRessHum."Type Calcul prime" = 10) THEN BEGIN
            RecIndemnité.SETFILTER("Employment Contract Code", SalaryLine.Employee);
            RecIndemnité.SETFILTER("Non Inclus en Prime", '%1', FALSE);
            IF RecIndemnité.FIND('-') THEN
                REPEAT
                    DecMontantIdem := DecMontantIdem + RecIndemnité."Basis amount";

                UNTIL RecIndemnité.NEXT = 0;
        END;
        //message(format(decmontantidem));
        // calcul des indemitées enregistré
        IF (ParamRessHum."Type Calcul prime" = 8) THEN BEGIN

            recindemnitéEnreg.SETFILTER("Employee No.", SalaryLine.Employee);
            recindemnitéEnreg.SETFILTER("Non Inclus en Prime", '%1', FALSE);
            recindemnitéEnreg.SETFILTER(Année, '%1', SalaryLine.Year);
            IF recindemnitéEnreg.FIND('-') THEN
                REPEAT
                    DecMontantIdem := DecMontantIdem + recindemnitéEnreg."Real Amount";
                UNTIL recindemnitéEnreg.NEXT = 0;

        END;
        //<<DSFT AGA 17/03/2010
        CASE SalaryLine."Employee's type" OF
            0:
                BEGIN
                    IF ParamRessHum."Type Calcul prime" = 0 THEN BEGIN
                        SalaryLine."Real basis salary" := ROUND((SalaryLine."Basis salary" *
                                                          (GNbHeure * RegimeWork."Work Hours per month") / (DecGNBHeureAN)) * (100 / 100)
                                                          , ParamCpta."Amount Rounding Precision");

                        SalaryLine."Taxable indemnities" := ROUND(DecMontantIdem, ParamCpta."Amount Rounding Precision");
                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary" + SalaryLine."Taxable indemnities"
                                                          , ParamCpta."Amount Rounding Precision");
                    END;
                    IF ParamRessHum."Type Calcul prime" = 1 THEN BEGIN
                        SalaryLine.Pourcentage := ROUND((GNbHeure * GRecNote.Panier) / (20 * DecGNBHeureAN), ParamCpta."Amount Rounding Precision"
                );
                        SalaryLine."Real basis salary" := ROUND(SalaryLine."Basis salary" *
                                                          (GNbJour / DecGNBJourAN) * (100 / 100)
                                                          , ParamCpta."Amount Rounding Precision");
                        SalaryLine."Taxable indemnities" := ROUND(DecMontantIdem, ParamCpta."Amount Rounding Precision");
                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary" + SalaryLine."Taxable indemnities"
                                                          , ParamCpta."Amount Rounding Precision");
                    END;
                    IF ParamRessHum."Type Calcul prime" = 2 THEN BEGIN

                        SalaryLine."Real basis salary" := ROUND((DecGTotSalaireBrut
                                                          ) * (100 / 100)
                                                          , ParamCpta."Amount Rounding Precision");

                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary", ParamCpta."Amount Rounding Precision");
                    END;
                    IF ParamRessHum."Type Calcul prime" = 3 THEN BEGIN
                        SalaryLine."Real basis salary" := ROUND((SalaryLine."Basis salary" *
                                                          (GNbHeure * RegimeWork."Work Hours per month") / (DecGNBHeureAN)) * (100 / 100)
                                                          , ParamCpta."Amount Rounding Precision");
                        SalaryLine."Taxable indemnities" := ROUND(DecMontantIdem, ParamCpta."Amount Rounding Precision");
                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary" + SalaryLine."Taxable indemnities"
                                                          , ParamCpta."Amount Rounding Precision");
                    END;
                    IF ParamRessHum."Type Calcul prime" = 4 THEN BEGIN
                        SalaryLine."Real basis salary" := ROUND(SalaryLine."Basis salary" * RegimeWork."From Work day to Work hour" * 22
                                                          * (GRecNote.Panier / 20)
                                                          , ParamCpta."Amount Rounding Precision");
                        SalaryLine."Taxable indemnities" := ROUND(DecMontantIdem, ParamCpta."Amount Rounding Precision");
                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary" + SalaryLine."Taxable indemnities"
                                                          , ParamCpta."Amount Rounding Precision");
                    END;
                    IF ParamRessHum."Type Calcul prime" = 5 THEN BEGIN

                        SalaryLine."Real basis salary" := ROUND(((((SalaryLine."Basis salary") +
                                                                (DecMontantIdem / RegimeWork."Work Hours per month"))
                                                                ) * 2 * ParamRessHum."From Work day to Work hour"
                                                          * GRecNote.Panier * NBmoisTravaille / 12)
                                                          , ParamCpta."Amount Rounding Precision");

                        SalaryLine."Taxable indemnities" := 0;
                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary" + SalaryLine."Taxable indemnities"
                                                          , ParamCpta."Amount Rounding Precision");
                    END;
                    // AGA 14/12/22011
                    IF ParamRessHum."Type Calcul prime" = 6 THEN BEGIN

                        SalaryLine."Real basis salary" := ROUND((DecGTotSalaireBrut
                                                          ) * (10 / 100)
                                                          , ParamCpta."Amount Rounding Precision");

                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary", ParamCpta."Amount Rounding Precision");
                    END;
                    IF ParamRessHum."Type Calcul prime" = 7 THEN BEGIN

                        SalaryLine.Pourcentage := 100;

                        SalaryLine."Real basis salary" := ROUND((((SalaryLine."Basis salary")
                                                              * (RegimeWork."Work Hours per month"
                                                              * 100 / 100)
                                                          * NBmoisTravaille) / 12), ParamCpta."Amount Rounding Precision");
                        SalaryLine."Taxable indemnities" := ROUND(((DecMontantIdem / RegimeWork."Work Hours per month") *
                                                            (RegimeWork."Work Hours per month" * 100 / 100)
                                                            * NBmoisTravaille / 12),
                                                           ParamCpta."Amount Rounding Precision");
                        SalaryLine."Real basis salary" := ROUND(SalaryLine."Real basis salary" + SalaryLine."Taxable indemnities"
                                                         , ParamCpta."Amount Rounding Precision");

                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary"
                                                          , ParamCpta."Amount Rounding Precision");



                    END;

                    IF ParamRessHum."Type Calcul prime" = 8 THEN BEGIN

                        SalaryLine."Real basis salary" := ROUND(((DecSommeSalBase + DecMontantIdem)
                                                          * 100 / 100)
                                                          , ParamCpta."Amount Rounding Precision");

                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary", ParamCpta."Amount Rounding Precision");
                    END;
                    IF ParamRessHum."Type Calcul prime" = 9 THEN BEGIN

                        SalaryLine."Real basis salary" := ROUND(
                                                         ((8 * SalaryLine."Basis salary" * 22) +
                                                           ((DecMontantIdem / 26) * 22))
                                                          * (GRecNote.Panier / 20)
                                                          , ParamCpta."Amount Rounding Precision");
                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary", ParamCpta."Amount Rounding Precision");
                    END;
                    IF ParamRessHum."Type Calcul prime" = 10 THEN BEGIN

                        SalaryLine."Real basis salary" := ROUND(
                                                          ((SalaryLine."Basis salary" * 8) +
                                                           (DecMontantIdem / RegimeWork."Worked Day Per Month"))
                                                          * (GRecNote.Panier
                                                          )
                                                          , ParamCpta."Amount Rounding Precision");

                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary", ParamCpta."Amount Rounding Precision");
                    END;



                END;
            1:
                BEGIN
                    IF ParamRessHum."Type Calcul prime" = 0 THEN BEGIN
                        // SalaryLine."Real basis salary"   :=ROUND(SalaryLine."Basis salary"*
                        //                                   (GNbJour/DecGNBJourAN)*(GRecNote."Type Heure"/100)
                        //                                   ,ParamCpta."Amount Rounding Precision");
                        SalaryLine."Taxable indemnities" := ROUND(DecMontantIdem, ParamCpta."Amount Rounding Precision");
                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary" + SalaryLine."Taxable indemnities"
                                                          , ParamCpta."Amount Rounding Precision");
                    END;
                    IF ParamRessHum."Type Calcul prime" = 1 THEN BEGIN
                        SalaryLine.Pourcentage := ROUND((GNbJour * GRecNote.Panier) / (20 * DecGNBJourAN), ParamCpta."Amount Rounding Precision");
                        // SalaryLine."Real basis salary"   :=ROUND(SalaryLine."Basis salary"*
                        //                                   (GNbJour/DecGNBJourAN)*(GRecNote."Type Heure"/100)
                        //                                   ,ParamCpta."Amount Rounding Precision");
                        SalaryLine."Taxable indemnities" := ROUND(DecMontantIdem, ParamCpta."Amount Rounding Precision");
                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary" + SalaryLine."Taxable indemnities"
                                                          , ParamCpta."Amount Rounding Precision");
                    END;
                    IF ParamRessHum."Type Calcul prime" = 2 THEN BEGIN

                        // SalaryLine."Real basis salary"   :=ROUND((DecGTotSalaireBrut)*(GRecNote."Type Heure"/100)
                        //                                   ,ParamCpta."Amount Rounding Precision");
                        //   message(format(DecGTotSalaireBrut));
                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary", ParamCpta."Amount Rounding Precision");
                    END;
                    IF ParamRessHum."Type Calcul prime" = 3 THEN BEGIN
                        // SalaryLine."Real basis salary"   :=ROUND(SalaryLine."Basis salary"*
                        //                                  (GNbJour/DecGNBJourAN)*(GRecNote."Type Heure"/100)
                        //                                 ,ParamCpta."Amount Rounding Precision");
                        SalaryLine."Taxable indemnities" := ROUND(DecMontantIdem, ParamCpta."Amount Rounding Precision");
                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary" + SalaryLine."Taxable indemnities"
                                                          , ParamCpta."Amount Rounding Precision");
                    END;
                    IF ParamRessHum."Type Calcul prime" = 4 THEN BEGIN
                        SalaryLine."Real basis salary" := ROUND(SalaryLine."Basis salary" *
                                                          (22 / RegimeWork."Worked Day Per Month") * (GRecNote.Panier / 20)
                                                          , ParamCpta."Amount Rounding Precision");
                        SalaryLine."Taxable indemnities" := ROUND(DecMontantIdem, ParamCpta."Amount Rounding Precision");
                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary" + SalaryLine."Taxable indemnities"
                                                          , ParamCpta."Amount Rounding Precision");
                    END;
                    IF ParamRessHum."Type Calcul prime" = 5 THEN BEGIN

                        SalaryLine."Real basis salary" := ROUND((
                                                          ((SalaryLine."Basis salary" + DecMontantIdem) / RegimeWork."Work Hours per month")
                                                          * 2 * ParamRessHum."From Work day to Work hour" *
                                                          GRecNote.Panier * (NBmoisTravaille / 12))
                                                          , ParamCpta."Amount Rounding Precision");
                        SalaryLine."Taxable indemnities" := 0;

                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary" + SalaryLine."Taxable indemnities"
                                                          , ParamCpta."Amount Rounding Precision");
                    END;
                    // AGA 14/12/22011
                    IF ParamRessHum."Type Calcul prime" = 6 THEN BEGIN

                        SalaryLine."Real basis salary" := ROUND((DecGTotSalaireBrut
                                                          ) * (10 / 100)
                                                          , ParamCpta."Amount Rounding Precision");

                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary", ParamCpta."Amount Rounding Precision");

                    END;
                    IF ParamRessHum."Type Calcul prime" = 7 THEN BEGIN

                        // SalaryLine.Pourcentage           :=GRecNote."Type Heure";
                        //  SalaryLine."Real basis salary"   :=ROUND((((SalaryLine."Basis salary"/RegimeWork."Worked Day Per Month")
                        //                                        *(RegimeWork."Worked Day Per Month"
                        //                                        *GRecNote."Type Heure"/100)
                        //                                  * NBmoisTravaille)/12),ParamCpta."Amount Rounding Precision");
                        //  SalaryLine."Taxable indemnities" :=ROUND(((DecMontantIdem/RegimeWork."Worked Day Per Month")*
                        //                                      (RegimeWork."Worked Day Per Month"*GRecNote."Type Heure"/100)
                        //                                     *NBmoisTravaille/12),
                        //                                  ParamCpta."Amount Rounding Precision");
                        SalaryLine."Real basis salary" := ROUND(SalaryLine."Real basis salary" + SalaryLine."Taxable indemnities"
                                                         , ParamCpta."Amount Rounding Precision");

                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary"
                                                          , ParamCpta."Amount Rounding Precision");
                    END;
                    IF ParamRessHum."Type Calcul prime" = 8 THEN BEGIN

                        // SalaryLine."Real basis salary"   :=ROUND(((DecSommeSalBase+DecMontantIdem)
                        //                                  *GRecNote."Type Heure"/100)
                        //                                 ,ParamCpta."Amount Rounding Precision");

                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary", ParamCpta."Amount Rounding Precision");
                    END;
                    IF ParamRessHum."Type Calcul prime" = 9 THEN BEGIN

                        SalaryLine."Real basis salary" := ROUND(((
                                                           (SalaryLine."Basis salary" +
                                                           DecMontantIdem) / RegimeWork."Worked Day Per Month") * 22)
                                                          * (GRecNote.Panier / 20)
                                                          , ParamCpta."Amount Rounding Precision");

                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary", ParamCpta."Amount Rounding Precision");
                    END;
                    IF ParamRessHum."Type Calcul prime" = 10 THEN BEGIN

                        SalaryLine."Real basis salary" := ROUND((
                                                           (SalaryLine."Basis salary" +
                                                           DecMontantIdem) / RegimeWork."Worked Day Per Month")
                                                          * (GRecNote.Panier)
                                                          , ParamCpta."Amount Rounding Precision");

                        SalaryLine."Gross Salary" := ROUND(SalaryLine."Real basis salary", ParamCpta."Amount Rounding Precision");
                    END;





                END;
        END;

        /*MBY 11/01/10
        
        CalcIndemnitéImp(SalaryLine);
        "CalcInd&HsupNav"(SalaryLine,Sim);
        SalaryLine."Gross Salary" := ROUND(SalaryLine."Gross Salary" +
                                     SalaryLine."Taxable indemnities",ParamCpta."Amount Rounding Precision");
        
        MBY 11/01/10*/

        // --> Calc Cotisation Social
        CalcCotisationSocial1(SalaryLine);
        SalaryLine.MODIFY;
        CalcAllTaxe(SalaryLine);
        // Calc Cotisation Social
        CalcCotisationSocial2(SalaryLine);
        SalaryLine.MODIFY;
        //**********************************************************************************************************************************
        IF (Employee."Relation de travail" = 2) OR (Employee."Relation de travail" = 3) THEN
        // IF (Employee."Relation de travail"=2) THEN
        BEGIN
            //--> Calcul de l'imposable réel
            IF EmploymentContract.Taxable THEN BEGIN
                SalaryLine."Taxable salary" := ROUND(SalaryLine."Gross Salary" - SalaryLine.CNSS
                                                     , ParamCpta."Amount Rounding Precision");

                SalLineEng.RESET;
                SalLineEng.SETCURRENTKEY(Year, Employee, "No.");
                SalLineEng.SETFILTER(Year, '%1', SalaryLine.Year);
                SalLineEng.SETFILTER(Employee, SalaryLine.Employee);
                IF SalLineEng.FIND('+') THEN
                    SalaryLine."Taxable salary PR" := SalLineEng."Taxable salary"
                ELSE
                    SalaryLine."Taxable salary PR" := SalLineEngTmp2."Taxable salary PR";

                IF Employee."Familly chief" THEN BEGIN
                    SalaryLine."Deduction Family chief" := ROUND(ParamRessHum."Deduction for Familly Chief" / 12,
                                                            ParamCpta."Amount Rounding Precision");
                    Employee.CALCFIELDS("Deduction Loaded child");
                    SalaryLine."Deduction Loaded child" := ROUND(Employee."Deduction Loaded child" / 12,
                                                            ParamCpta."Amount Rounding Precision")
                END
                ELSE BEGIN
                    SalaryLine."Deduction Family chief" := 0;
                    SalaryLine."Deduction Loaded child" := 0;
                END;

                SalaryLine."Deduction Prof. expenses" := ROUND(ParamRessHum."% professional expenses"
                                                       * SalaryLine."Taxable salary"
                                                       , ParamCpta."Amount Rounding Precision");

                SalaryLine."Real taxable" := ROUND(SalaryLine."Taxable salary"
                                                       - SalaryLine."Deduction Prof. expenses", ParamCpta."Amount Rounding Precision");

                SalaryLine."Real taxable PR" := ROUND(SalaryLine."Taxable salary PR"
                                                      - SalaryLine."Deduction Family chief"
                                                      - SalaryLine."Deduction Loaded child"
                                                      - ROUND(SalaryLine."Taxable salary PR" * ParamRessHum."% professional expenses"
                                                      , ParamCpta."Amount Rounding Precision"), ParamCpta."Amount Rounding Precision");
            END;
            //--> Calcul de l'imposable réel par an
            SalLineEng.RESET;
            SalLineEng.SETCURRENTKEY(Year, Month, Employee, "No.", Imposable);
            SalLineEng.SETFILTER(Year, '%1', SalaryLine.Year);
            SalLineEng.SETFILTER(Employee, SalaryLine.Employee);
            //  SalLineEng.SETFILTER("Non Taxable Soc. Contrib.",'>%1',0);
            SalLineEng.SETFILTER(Imposable, '%1', TRUE);
            SalLineEng.CALCSUMS("Real taxable", "Taxe (Month)");
            SalaryLine."Total taxable rec." := SalLineEng."Real taxable";
            SalaryLine."Total taxes rec." := SalLineEng."Taxe (Month)";
            SalaryLine."Rec. payments" := 0;

            SalLineEngTmp.RESET;
            SalLineEngTmp.SETCURRENTKEY(Year, Month, Employee, "No.", Imposable);
            SalLineEngTmp.SETFILTER(Employee, SalaryLine.Employee);
            SalLineEngTmp.SETFILTER(Year, '%1', SalaryLine.Year);
            //  SalLineEngTmp.SETFILTER("Non Taxable Soc. Contrib.",'>%1',0);
            SalLineEngTmp.SETFILTER(Imposable, '%1', TRUE);
            SalLineEngTmp.SETFILTER(Month, '<%1', 16);
            SalLineEngTmp.CALCSUMS("Real taxable", "Taxe (Month)");
            SalaryLine."Rec. payments" := SalLineEngTmp.COUNT;

            CASE Sim OF
                0:
                    BEGIN
                        SalaryLine."Real taxable (Year)" := ROUND(SalaryLine."Real taxable" * nbr,
                                                                             ParamCpta."Amount Rounding Precision");
                    END;
                1:
                    BEGIN
                        CASE ParamRessHum."Taxes regulation" OF
                            0:
                                BEGIN //DYNAMIQUE

                                    IF SalaryLine.Month > (nbr - 1) THEN BEGIN
                                        IF (nbr - SalaryLine."Rec. payments") > 0 THEN
                                            SalaryLine."Real taxable (Year)" := ROUND((SalaryLine."Real taxable" +
                                                                                ((SalaryLine."Real taxable")
                                                                                 * (nbr - SalaryLine."Rec. payments" - 1)))
                                                                                + SalaryLine."Total taxable rec.", ParamCpta."Amount Rounding Precision")
                                        ELSE
                                            SalaryLine."Real taxable (Year)" := ROUND(SalaryLine."Real taxable" +
                                                                                +SalaryLine."Total taxable rec.", ParamCpta."Amount Rounding Precision");

                                        SalaryLine."Real Taxable PR (Year)" := ROUND((
                                                                            ((SalaryLine."Real taxable")
                                                                           * (nbr - SalaryLine."Rec. payments" - 1)))
                                                                          + SalaryLine."Total taxable rec.", ParamCpta."Amount Rounding Precision");
                                    END ELSE BEGIN
                                        SalaryLine."Real taxable (Year)" := ROUND((SalaryLine."Real taxable" +
                                                                            (SalaryLine."Real taxable" * (nbr - SalaryLine."Rec. payments" - 1)))
                                                                            + SalaryLine."Total taxable rec.", ParamCpta."Amount Rounding Precision");
                                        SalaryLine."Real Taxable PR (Year)" := ROUND((SalaryLine."Real taxable" +
                                                                            (SalaryLine."Real taxable" * (nbr - SalaryLine."Rec. payments" - 1)))
                                                                            + SalaryLine."Total taxable rec.", ParamCpta."Amount Rounding Precision");
                                    END;
                                END;
                            1:
                                BEGIN  //12 IEMME ET PLUS
                                    IF SalaryLine."Rec. payments" < 12 THEN
                                        SalaryLine."Real taxable (Year)" := ROUND(SalaryLine."Real taxable" * nbr,
                                                                                       ParamCpta."Amount Rounding Precision")
                                    ELSE
                                        SalaryLine."Real taxable (Year)" := ROUND(SalaryLine."Real taxable" + SalaryLine."Total taxable rec.",
                                                                                       ParamCpta."Amount Rounding Precision");
                                    IF SalaryLine."Rec. payments" < 12 THEN
                                        SalaryLine."Real Taxable PR (Year)" := ROUND(SalaryLine."Real taxable PR" * nbr,
                                                                                       ParamCpta."Amount Rounding Precision")
                                    ELSE
                                        SalaryLine."Real Taxable PR (Year)" := ROUND(SalaryLine."Real taxable PR" +
                                                                                        SalaryLine."Total taxable rec.",
                                                                                        ParamCpta."Amount Rounding Precision");
                                END;

                            // AGA IMPOT STTAIQUE
                            2:
                                BEGIN

                                    SalaryLine."Real taxable (Year)" := ROUND(SalaryLine."Real taxable" * nbr,
                                                                                   ParamCpta."Amount Rounding Precision");

                                    SalaryLine."Real Taxable PR (Year)" := ROUND(SalaryLine."Real taxable PR" * nbr,
                                                                                   ParamCpta."Amount Rounding Precision")

                                END;


                        END;//FIN CASE TYPE REGUL
                    END;
            END;//FIN CASE SIM
            // Calcul Impôt Annuel
            //MBY SAMI ARRONDI AU DINAR SUP
            DecVar := ROUND(SalaryLine."Real taxable (Year)", 1) - SalaryLine."Real taxable (Year)";
            IF DecVar > 0 THEN
                SalaryLine."Real taxable (Year)" := ROUND(SalaryLine."Real taxable (Year)", 1)
            ELSE
                SalaryLine."Real taxable (Year)" := ROUND(SalaryLine."Real taxable (Year)" + 1, 1);

            DecVar := ROUND(SalaryLine."Real Taxable PR (Year)", 1) - SalaryLine."Real Taxable PR (Year)";
            IF DecVar > 0 THEN
                SalaryLine."Real Taxable PR (Year)" := ROUND(SalaryLine."Real Taxable PR (Year)", 1)
            ELSE
                SalaryLine."Real Taxable PR (Year)" := ROUND(SalaryLine."Real Taxable PR (Year)" + 1, 1);

            //END MBY

            CalcImpotAn(SalaryLine);
            //IF SalaryLine.Month>(nbr-1) THEN BEGIN
            SalaryLine."Deduction Family chief" := 0;
            SalaryLine."Deduction Loaded child" := 0;
            // END;
            // Calcul Impôt mensuel
            CASE ParamRessHum."Taxes regulation" OF
                0:
                    BEGIN//DYNAMIQUE
                        IF SalaryLine.Month < nbr THEN BEGIN
                            IF (nbr - SalaryLine."Rec. payments" + 1) <> 0 THEN
                                SalaryLine."Taxe PR (Month)" := ROUND((SalaryLine."Taxe PR (Year)" - SalaryLine."Total taxes rec.")
                                                               / (nbr - SalaryLine."Rec. payments" + 1), ParamCpta."Amount Rounding Precision")
                            ELSE
                                SalaryLine."Taxe PR (Month)" := ROUND((SalaryLine."Taxe PR (Year)" - SalaryLine."Total taxes rec.")
                                                               , ParamCpta."Amount Rounding Precision");

                            IF SalaryLine."Rec. payments" < 12 THEN
                                SalaryLine."Taxe (Month)" := ROUND((SalaryLine."Taxe (Year)" - SalaryLine."Taxe PR (Year)") +
                                                             SalaryLine."Taxe PR (Month)", ParamCpta."Amount Rounding Precision")
                            ELSE
                                SalaryLine."Taxe (Month)" := ROUND((SalaryLine."Taxe (Year)" - SalaryLine."Total taxes rec.")
                                                            , ParamCpta."Amount Rounding Precision");
                            IF SalaryLine."Taxe (Month)" < 0 THEN
                                SalaryLine."Taxe (Month)" := 0;

                        END ELSE BEGIN
                            IF (nbr - SalaryLine."Rec. payments") <> 0 THEN
                                SalaryLine."Taxe PR (Month)" := ROUND((SalaryLine."Taxe PR (Year)" - SalaryLine."Total taxes rec.")
                                                               / (nbr - SalaryLine."Rec. payments"), ParamCpta."Amount Rounding Precision")
                            ELSE
                                SalaryLine."Taxe PR (Month)" := ROUND(SalaryLine."Taxe PR (Year)" - SalaryLine."Total taxes rec.",
                                                               ParamCpta."Amount Rounding Precision");

                            IF SalaryLine."Rec. payments" < 12 THEN
                                IF (nbr - SalaryLine."Rec. payments") > 1 THEN
                                    SalaryLine."Taxe (Month)" := ROUND((SalaryLine."Taxe (Year)" - SalaryLine."Total taxes rec.")
                                    / (nbr - SalaryLine."Rec. payments")
                                                                , ParamCpta."Amount Rounding Precision")

                                ELSE
                                    SalaryLine."Taxe (Month)" := ROUND((SalaryLine."Taxe (Year)" - SalaryLine."Total taxes rec.")
                                                                , ParamCpta."Amount Rounding Precision")
                            ELSE
                                SalaryLine."Taxe (Month)" := ROUND((SalaryLine."Taxe (Year)" - SalaryLine."Total taxes rec.")
                                                            , ParamCpta."Amount Rounding Precision");

                            IF SalaryLine."Taxe (Month)" < 0 THEN
                                SalaryLine."Taxe (Month)" := 0;
                        END;
                    END;
                1:
                    BEGIN   //12 IEMME ET PLUS
                        IF SalaryLine."Rec. payments" < 12 THEN
                            SalaryLine."Taxe (Month)" := ROUND((SalaryLine."Taxe (Year)" - SalaryLine."Taxe PR (Year)") +
                                                                           SalaryLine."Taxe PR (Month)", ParamCpta."Amount Rounding Precision")
                        ELSE
                            SalaryLine."Taxe (Month)" := ROUND(SalaryLine."Taxe (Year)" - SalaryLine."Total taxes rec."
                                                                           , ParamCpta."Amount Rounding Precision");
                        IF SalaryLine."Taxe (Month)" < 0 THEN
                            SalaryLine."Taxe (Month)" := 0;

                    END;
                // aga impot statique
                2:
                    BEGIN
                        SalaryLine."Taxe PR (Month)" := ROUND(SalaryLine."Taxe PR (Year)" / nbr, ParamCpta.
                                                                       "Amount Rounding Precision");
                        SalaryLine."Taxe (Month)" := ROUND(SalaryLine."Taxe (Year)" / nbr, ParamCpta.
                                                                       "Amount Rounding Precision");
                        IF SalaryLine."Taxe (Month)" < 0 THEN
                            SalaryLine."Taxe (Month)" := 0;
                    END;
            END;
        END
        ELSE //IMPOSABLE CONTRACTUEL************************************  A VERIFIER **********
            IF (Employee."Relation de travail" <> 1) THEN BEGIN
                SalaryLine."Salaire Impos. Ann. Conge" := 0;
                SalaryLine."Taux Tranche Impos. Conge" := 0;
                SalaryLine."Taxable salary" := ROUND(SalaryLine."Gross Salary" - SalaryLine.CNSS
                                               , ParamCpta."Amount Rounding Precision");

                CASE SalaryLine."Employee's type" OF
                    1:
                        BEGIN
                            SalLineEngTmp.RESET;
                            SalLineEngTmp.SETRANGE(Year, SalaryLine.Year);
                            SalLineEngTmp.SETFILTER(Month, '<%1', 12);
                            SalLineEngTmp.SETRANGE(Employee, SalaryLine.Employee);
                            IF SalLineEngTmp.FIND('+') THEN
                                SalaryLine."Salaire Impos. Ann. Conge" := ROUND(SalLineEngTmp."Taxable salary" * (RegimeWork."Worked Day Per Month") /
                                                                         ((RegimeWork."Worked Day Per Month") - SalLineEngTmp.Absences)
                                                                         * 13, ParamCpta."Amount Rounding Precision")
                        END;
                    0:
                        BEGIN
                            SalLineEngTmp.RESET;
                            SalLineEngTmp.SETRANGE(Year, SalaryLine.Year);
                            //mby 26/08/2009 SalLineEngTmp.SETFILTER(Month,'<%1',12);
                            SalLineEngTmp.SETFILTER(Month, '=%1', 13);
                            SalLineEngTmp.SETRANGE(Employee, SalaryLine.Employee);
                            IF SalLineEngTmp.FIND('+') THEN
                                SalaryLine."Salaire Impos. Ann. Conge" := ROUND(SalLineEngTmp."Salaire Impos. Ann. Conge"
                                                                          , ParamCpta."Amount Rounding Precision")

                            /*mby 26/08/2009 IF SalLineEngTmp.FIND('+') THEN
                                       SalaryLine."Salaire Impos. Ann. Conge" := ROUND(SalLineEngTmp."Taxable salary"*(RegimeWork."Work Hours per month")/
                                                                         ((SalLineEngTmp."Worked hours"+SalLineEngTmp."Supp. hours"))
                                                                          *13,ParamCpta."Amount Rounding Precision")mby 26/08/2009*/
                        END;
                END;//END CASE EMPLOYEE S TYPE
                SalaryLine."Salaire Impos. Ann. Conge" := SalaryLine."Total taxable rec." + SalaryLine."Taxable salary";
                IF SalaryLine."Deduction Family chief" > 0 THEN
                    SalaryLine."Salaire Impos. Ann. Conge" := SalaryLine."Salaire Impos. Ann. Conge" - (SalaryLine."Deduction Family chief" * 12);

                IF SalaryLine."Deduction Loaded child" > 0 THEN
                    SalaryLine."Salaire Impos. Ann. Conge" := SalaryLine."Salaire Impos. Ann. Conge" - (SalaryLine."Deduction Loaded child" * 12);

                SalaryLine."Salaire Impos. Ann. Conge" := SalaryLine."Salaire Impos. Ann. Conge" * 0.9;

                IF EmploymentContract.Taxable THEN
                    IF EmploymentContract."Calculation mode of the taxes" = 0 THEN BEGIN
                        SliceImposition.RESET;
                        SliceImposition.SETRANGE(Code, EmploymentContract."Slice of imposition");
                        IF SliceImposition.FIND('-') THEN
                            REPEAT
                                IF ((SalaryLine."Salaire Impos. Ann. Conge" > SliceImposition."Lower limit")
                                AND (SalaryLine."Salaire Impos. Ann. Conge" < SliceImposition."Superior limit")) THEN
                                    SalaryLine."Taux Tranche Impos. Conge" := SliceImposition.Rate;
                            UNTIL SliceImposition.NEXT = 0;
                    END;

                //FIN IMPOSABLE CONTRACTUELS***************************************************

                //MBY SAMI ARRONDI AU DINAR SUP 13/01/2009
                DecIMPARRONDI := 0;
                DecIMPARRONDI := ROUND(SalaryLine."Taxable salary" * 0.9
                                 , ParamCpta."Amount Rounding Precision");

                DecVar := ROUND(DecIMPARRONDI, 1) - DecIMPARRONDI;
                IF DecVar > 0 THEN
                    DecIMPARRONDI := ROUND(DecIMPARRONDI, 1)
                ELSE
                    DecIMPARRONDI := ROUND(DecIMPARRONDI + 1, 1);
                //END MBY

                SalaryLine."Taxe (Month)" := ROUND(DecIMPARRONDI * SalaryLine."Taux Tranche Impos. Conge" / 100
                                            , ParamCpta."Amount Rounding Precision");

                //  SalaryLine."Taxe (Month)" := ROUND(SalaryLine."Taxable salary"*SalaryLine."Taux Tranche Impos. Conge"*0.9/100
                //                              ,ParamCpta."Amount Rounding Precision");
            END;
        //**********************************************************************************************************************************
        SalaryLine."Net salary" := ROUND(SalaryLine."Gross Salary" - SalaryLine.CNSS
                                 + SalaryLine."Non Taxable indemnities"
                                 + SalaryLine."Mission expenses"
                                 - SalaryLine."Taxe (Month)", ParamCpta."Amount Rounding Precision");

        // MH Calucl Retue FSP

        SalaryLine."Retenue FSP" := 0;
        SalaryLine."Retenue SNP" := 0;

        RecEmployee2.RESET;
        RecEmployee2.SETRANGE("No.", SalaryLine.Employee);
        IF RecEmployee2.FINDFIRST THEN BEGIN
            IF RecEmployee2."Appliquer Retenue SNP" = TRUE THEN
                SalaryLine."Retenue SNP" := SalaryLine."Basis salary" * 1 / 6;
        END;

        RecHumanResourcesSetup.FINDFIRST;
        IF RecHumanResourcesSetup."Appliquer Retenue FSP" = TRUE THEN
            SalaryLine."Retenue FSP" := (SalaryLine."Net salary" * RecHumanResourcesSetup."Taux Retenue FSP") / 100;

        // MH Calucl Retue FSP



        IF Sim = 1 THEN
            "Mgmt.ofLoansandAdvances".CréerLigneRembourcement(SalaryLine);

        //SalaryLine.CALCFIELDS (Loans,Advances);

        SalaryLine."Net salary cashed" := ROUND(SalaryLine."Net salary"
                                                       - SalaryLine.Loans
                                                       - SalaryLine.Advances - SalaryLine."Retenue FSP"
                                                       - SalaryLine."Retenue SNP",   // MH Calucl Retue FSP
                                                       ParamCpta."Amount Rounding Precision");
        //arrondissement
        IF ParamRessHum."Montant Arrondi" > 0 THEN BEGIN
            Employee.SETRANGE("No.", SalaryLine.Employee);
            IF Employee.FIND('-') THEN BEGIN
                SalaryLine."Report en -" := Employee."Report Employee en -";
                SalaryLine."Net salary cashed" := SalaryLine."Net salary cashed" - Employee."Report Employee en -";
                SoldeReport := 0;
                SoldeReport := ABS(SalaryLine."Net salary cashed" - ROUND(SalaryLine."Net salary cashed", 1, '>'));
                IF SoldeReport > ParamRessHum."Montant Arrondi" THEN BEGIN
                    SoldeReport := SoldeReport - ParamRessHum."Montant Arrondi";
                    SalaryLine."Ajout  en +" := ABS(SoldeReport);
                    SalaryLine."Net salary cashed" := ABS(SalaryLine."Net salary cashed") + (ABS(SoldeReport));
                END
                ELSE BEGIN
                    SalaryLine."Ajout  en +" := ABS(SoldeReport);
                    SalaryLine."Net salary cashed" := ABS(SalaryLine."Net salary cashed") + (ABS(SoldeReport));
                END;
            END;
        END;
        //======================= END ARRONDISSEMENT


        // Advance Sur Prime

        SalaryLine."User ID" := USERID;
        SalaryLine."Last Date Modified" := WORKDATE;

        SalaryLine.MODIFY;
        IF (SalaryLine."Taxable salary" = 0) AND (SalaryLine."Net salary" <= 0) THEN
            DeleteLine(SalaryLine)
        ELSE
            SalaryLine.MODIFY;

        EXIT(SalaryLine."Net salary");

    end;


    procedure "CalcMontanJourFérié"(var "RecGabsenceEnregistré": Record "Employee's days off Entry")
    var
        ParamRessHum: Record 5218;
        EmploymentContract: Record 5211;
        RegimeWork: Record "Regimes of work";
        Defaultind: Record "Default Indemnities";
        "//DSFT AGA 110310": Text[30];
        DecLMontantindem: Decimal;
        RecLEmployee: Record 5200;
        "DecLMontjourFérier": Decimal;
        "DecLMontHeureFérier": Decimal;
    begin
        EmploymentContract.GET(RecGabsenceEnregistré."Employee No.");
        IF EmploymentContract."Regimes of work" = '' THEN
            ERROR('Régime de travail non défini pour le salarié : %1 ', EmploymentContract.Code);
        RegimeWork.RESET;
        RegimeWork.SETRANGE(Code, EmploymentContract."Regimes of work");
        IF RegimeWork.FIND('-') THEN
            IF RegimeWork."Work Hours per month" = 0 THEN
                ERROR('Vérifier le nombre d heure travaillées par mois pour le régime : %1', RegimeWork.Code);

        Defaultind.SETRANGE("Employment Contract Code", RecGabsenceEnregistré."Employee No.");
        Defaultind.SETRANGE(Defaultind."Non Inclis en Jours Fer", FALSE);
        IF Defaultind.FIND('-') THEN
            REPEAT
                CASE Defaultind."Evaluation mode" OF
                    0:
                        BEGIN
                            DecLMontantindem := DecLMontantindem + Defaultind."Default amount";
                        END;
                    1:
                        BEGIN
                            DecLMontantindem := DecLMontantindem + Defaultind."Default amount";
                        END;
                    2:
                        BEGIN
                            DecLMontantindem := DecLMontantindem + Defaultind."Default amount";
                        END;
                    3:
                        BEGIN
                            DecLMontantindem := DecLMontantindem + (Defaultind."Default amount" * RegimeWork."Work Hours per month");
                        END;
                    // Nombre X montant
                    4:
                        BEGIN
                            IF Defaultind."Indemnity Code" = 'F05' THEN
                                DecLMontantindem := DecLMontantindem + (Defaultind."Default amount" * RegimeWork."Work Hours per month");
                            // indemnité non inclus jour fériet
                        END;
                    5:
                        BEGIN

                            DecLMontantindem := DecLMontantindem + ROUND(Defaultind."Default amount" * RegimeWork."Worked Day Per Month"
                                                         , Defaultind."Precision Arrondi Montant", FORMAT(Defaultind."Direction Arrondi"));
                        END;
                END;
            UNTIL Defaultind.NEXT = 0;

        IF RecLEmployee.GET(RecGabsenceEnregistré."Employee No.") THEN BEGIN
            IF RecLEmployee."Employee's type" = 0 THEN BEGIN
                DecLMontHeureFérier := ((RecLEmployee."Basis salary" + (DecLMontantindem / RegimeWork."Work Hours per month")) *
                                      RegimeWork."Taux Jours Férié") / 100;
                DecLMontjourFérier := (((RecLEmployee."Basis salary" + (DecLMontantindem / RegimeWork."Work Hours per month"))
                                     * RegimeWork."From Work day to Work hour") * RegimeWork."Taux Jours Férié") / 100;

                IF RecGabsenceEnregistré.Unit = 1 THEN
                    RecGabsenceEnregistré."Montant Ligne" := RecGabsenceEnregistré.Quantity * DecLMontHeureFérier
                ELSE
                    RecGabsenceEnregistré."Montant Ligne" := RecGabsenceEnregistré.Quantity * DecLMontjourFérier
            END;
            IF RecLEmployee."Employee's type" = 1 THEN BEGIN
                DecLMontHeureFérier := (((RecLEmployee."Basis salary" + DecLMontantindem) / RegimeWork."Work Hours per month")
                                     * RegimeWork."Taux Jours Férié") / 100;
                DecLMontjourFérier := (((RecLEmployee."Basis salary" + DecLMontantindem) / RegimeWork."Worked Day Per Month")
                                     * RegimeWork."Taux Jours Férié") / 100;
                IF RecGabsenceEnregistré.Unit = 1 THEN
                    RecGabsenceEnregistré."Montant Ligne" := RecGabsenceEnregistré.Quantity * DecLMontHeureFérier
                ELSE
                    RecGabsenceEnregistré."Montant Ligne" := RecGabsenceEnregistré.Quantity * DecLMontjourFérier
            END;

        END;
        RecGabsenceEnregistré.MODIFY
    end;


    procedure CalculerLigneSalaireRetraite(var SalaryLine: Record "Salary Lines"; "SolderDroitCongé": Boolean; Sim: Option Simulation,Real,Prime; nbjsolder: Decimal; Pinverse: Boolean): Decimal
    var
        SalaryHeader: Record "Salary Headers";
        Ind: Record "Indemnities";
        SocialContributions: Record "Social Contributions";
        ParamRessHum: Record 5218;
        EmploymentContract: Record 5211;
        RegimeWork: Record "Regimes of work";
        Employee: Record 5200;
        SliceImposition: Record "Slices of imposition";
        SliceImpositionX: Record "Slices of imposition";
        temp: Decimal;
        tmp: Decimal;
        tmp1: Decimal;
        Cot: Record "Default Soc. Contribution";
        nbr: Integer;
        bonus: Decimal;
        SalLineEng: Record "Rec. Salary Lines";
        EntEng: Record "Rec. Salary Headers";
        LigneTravail: Record "Heures occa. enreg. m";
        LigneTravailEnreg: Record "Heures sup. eregistrées m";
        WorkedD: Decimal;
        "Mgmt.ofLoansandAdvances": Codeunit "Mgmt. of Loans and Advances";
        droitconge: Record "Employee's days off Entry";
        SalLineEngTmp: Record "Rec. Salary Lines";
        MntInd: Decimal;
        DefaultIndemnitiesTmp: Record "Default Indemnities";
        SoldeReport: Decimal;
        SoldeReport1: Decimal;
        EMP1: Record 5200;
        LigneAbsence: Record "Employee's days off Entry";
        AbsEmp: Decimal;
        "RecLJourFérier": Record "Employee's days off Entry";
        "//DSFT AGA 18/03/2010": Integer;
        RecLDefaultindemnities: Record "Default Indemnities";
        RecLIndemnities: Record "Indemnities";
        DecSalaireBrut: Decimal;
        HeureJourTravail: Record "Heures occa. enreg. m";
    begin
        SalaryHeader.GET(SalaryLine."No.");
        ParamRessHum.GET();
        IF NOT SolderDroitCongé THEN
            nbjsolder := 0;
        ParamCpta.GET;
        Employee.RESET;
        Employee.GET(SalaryLine.Employee);
        CLEAR(EmploymentContract);
        EmploymentContract.GET(Employee."Emplymt. Contract Code");
        RegimeWork.RESET;
        RegimeWork.GET(EmploymentContract."Regimes of work");
        initLigne(SalaryLine, Sim);
        GNbJour := RegimeWork."Worked Day Per Month";//ParamRessHum."Paid days";
        GNbHeure := RegimeWork."Work Hours per month";//ParamRessHum."Paid days"*ParamRessHum."From Work day to Work hour";
                                                      //-->calcul de la bonification
        bonus := 1;
        IF (SalaryLine.Month > 11) AND (SalaryLine.Pourcentage > 0) THEN BEGIN
            bonus := SalaryLine.Pourcentage;

            IF ParamRessHum."Type de Note" = 0 THEN
                bonus := bonus / 100;
            //-->Prise en compte de nbre de mois travaillés
            IF SalaryLine."Mois travaillés" > 0 THEN
                bonus := bonus * (SalaryLine."Mois travaillés" / 12)
            ELSE
                bonus := 0;
        END;
        // RK

        //--> Soder droit congé
        IF Sim = 1 THEN
            CalcAbsence(SalaryLine);
        ParamRessHum.TESTFIELD("Minimum wage guarantee");

        CreerLignetransport(SalaryLine);
        IF SalaryLine.Month < 12 THEN BEGIN
            IF (DATE2DMY(Employee."Employment Date", 3) = SalaryLine.Year) AND ((DATE2DMY(Employee."Employment Date", 2) - 1) = SalaryLine.Month)
            THEN
                SalaryLine."6 * SMIG" := ROUND(ParamRessHum."Minimum wage guarantee" * 6 *
                      (CALCDATE('+FM', Employee."Employment Date") - Employee."Employment Date" + 1), ParamCpta."Amount Rounding Precision")
            ELSE
                SalaryLine."6 * SMIG" := ROUND(ParamRessHum."Minimum wage guarantee" * 6, ParamCpta."Amount Rounding Precision");
        END;

        IF SolderDroitCongé THEN BEGIN
            IF ((SalaryLine."Days off remaining" + SalaryLine."droit de congé du mois") >= nbjsolder) AND (nbjsolder <> 0) THEN
                SalaryLine."Days off balacement" := nbjsolder
            ELSE
                SalaryLine."Days off balacement" := (SalaryLine."Days off remaining" + SalaryLine."droit de congé du mois");
            droitconge.RESET;
            droitconge.SETCURRENTKEY("Line type", "Employee No.", "Posting month", "Posting year");
            droitconge.SETRANGE("Line type", 1);
            droitconge.SETRANGE("Employee No.", SalaryLine.Employee);
            droitconge.SETRANGE("Posting month", SalaryLine.Month);
            droitconge.SETRANGE("Posting year", SalaryLine.Year);

            droitconge.CALCSUMS("Quantity (Days)", "Montant Ligne", "Quantity (Hours)");
            SalaryLine."Amount Days Off balacement" := ROUND(Employee."Basis salary" * SalaryLine."Days off balacement" /
                                                     SalaryHeader."Paid days", ParamCpta."Amount Rounding Precision");
            SalaryLine."Assiduity (days off balacement" := ROUND(SalaryLine."Days off balacement" / SalaryHeader."Paid days", 0.0001) * 100;
            SalaryLine."Hours off Balacement" := droitconge."Quantity (Hours)";
        END
        ELSE
            SalaryLine."Days off balacement" := 0;
        /*//DSFT AGA 11/03/2010
        // calcul jour férié
        //SalaryLine.CALCFIELDS(SalaryLine."Jours Fériés travaillés");
        IF SalaryLine."Jours Fériés travaillés"<>0 THEN BEGIN
          RecLJourFérier.RESET;
          RecLJourFérier.SETRANGE("Employee No.",SalaryLine.Employee);
          RecLJourFérier.SETRANGE("Posting month",SalaryLine.Month);
          RecLJourFérier.SETRANGE("Posting year",SalaryLine.Year);
          RecLJourFérier.SETRANGE("Line type",11);
          //>> DSFT AGA 140410
          IF ParamRessHum."Activer régime quinzaine"THEN
          IF RegimeWork."type calcul paie"=RegimeWork."type calcul paie"::Quinzaine THEN
             RecLJourFérier.SETRANGE(Quinzaine,SalaryHeader.Quinzaine);
          //<< DSFT AGA 140410
          IF  RecLJourFérier.FIND('-')THEN
            REPEAT
               CalcMontanJourFérié(RecLJourFérier);
            UNTIL RecLJourFérier.NEXT=0;
        END;
        //DSFT AGA 11/03/2010
        //>>DSFT AGA 150410
          RecLJourFérier.RESET;
          RecLJourFérier.SETCURRENTKEY("Line type","Employee No.","Posting month","Posting year",Quinzaine,"Motif D'absence");
          RecLJourFérier.SETRANGE("Employee No.",SalaryLine.Employee);
          RecLJourFérier.SETRANGE("Posting month",SalaryLine.Month);
          RecLJourFérier.SETRANGE("Posting year",SalaryLine.Year);
          RecLJourFérier.SETRANGE("Line type",11);
          IF ParamRessHum."Activer régime quinzaine"THEN
          IF RegimeWork."type calcul paie"=RegimeWork."type calcul paie"::Quinzaine THEN
             RecLJourFérier.SETRANGE(Quinzaine,SalaryHeader.Quinzaine);
          RecLJourFérier.CALCSUMS(RecLJourFérier."Montant Ligne");
          SalaryLine."Montant Jours Fériés travaillé":=RecLJourFérier."Montant Ligne";
          RecLJourFérier.RESET;
          RecLJourFérier.SETCURRENTKEY("Line type","Employee No.","Posting month","Posting year",Quinzaine"Motif D'absence");
          RecLJourFérier.SETRANGE("Employee No.",SalaryLine.Employee);
          RecLJourFérier.SETRANGE("Posting month",SalaryLine.Month);
          RecLJourFérier.SETRANGE("Posting year",SalaryLine.Year);
          RecLJourFérier.SETRANGE("Line type",10);
          IF ParamRessHum."Activer régime quinzaine"THEN
          IF RegimeWork."type calcul paie"=RegimeWork."type calcul paie"::Quinzaine THEN
             RecLJourFérier.SETRANGE(Quinzaine,SalaryHeader.Quinzaine);
          RecLJourFérier.CALCSUMS(RecLJourFérier."Montant Ligne");
          SalaryLine."Montant Jours Fériés":=RecLJourFérier."Montant Ligne";
        
        //>>DSFT AGA 150410
        
        */
        // --> Calcul des 2 param. d'assiduité
        MntInd := 0;
        IF Employee."Currency Code" <> '' THEN BEGIN
            DefaultIndemnitiesTmp.RESET;
            DefaultIndemnitiesTmp.SETFILTER("Employment Contract Code", Employee."Emplymt. Contract Code");
            DefaultIndemnitiesTmp.SETRANGE("Evaluation mode", 1, 2);
            DefaultIndemnitiesTmp.SETRANGE("Type Indemnité", 0);
            IF DefaultIndemnitiesTmp.FIND('-') THEN
                REPEAT
                    MntInd := MntInd + DefaultIndemnitiesTmp."Default amount";
                UNTIL DefaultIndemnitiesTmp.NEXT = 0;
        END;


        IF ParamRessHum."Activer régime quinzaine" THEN
            IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN
                nbr := 26
            ELSE
                nbr := 12;
        EmploymentContract.RESET;
        Employee.RESET;
        Employee.GET(SalaryLine.Employee);
        EmploymentContract.GET(Employee."Emplymt. Contract Code");
        CASE ParamRessHum."Number of monthes" OF
            0:
                nbr := EmploymentContract."Regular payments";
            1:
                nbr := EmploymentContract."Temporary payments";
            2:
                nbr := EmploymentContract."Regular payments" + EmploymentContract."Temporary payments";
        END;

        IF RegimeWork.GET(SalaryLine."Employee Regime of work") THEN;
        IF ((Sim = 1) OR ((SalaryLine."Basis salary" = 0) AND (Sim = 0))) AND NOT ((Pinverse = TRUE) AND (SalaryLine."Basis salary" = 0)) THEN BEGIN
            IF SalaryLine."Posting Date" = 0D THEN
                SalaryLine."Posting Date" := WORKDATE;
            IF Employee."Currency Code" = '' THEN
                SalaryLine."Basis salary" := Employee."Basis salary"
            ELSE BEGIN
                IF Employee."Indemnité imposable" <> 0 THEN
                    SalaryLine."Basis salary" :=
                       ROUND(Tchange.ExchangeAmtFCYToLCY(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"), Employee."Currency Code",
                          Employee."Indemnité imposable", Tchange.ExchangeRate(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"),
                          Employee."Currency Code")
              ) -
                          MntInd, ParamCpta."Amount Rounding Precision")
                ELSE
                    SalaryLine."Basis salary" :=
                         ROUND(Tchange.ExchangeAmtFCYToLCY(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"), Employee."Currency Code",
                          Employee."Basis salary", Tchange.ExchangeRate(CALCDATE('-1M+FM+1J', SalaryLine."Posting Date"), Employee."Currency Code")
              )
                          , ParamCpta."Amount Rounding Precision");

            END;
        END;
        //Salaire de base
        CASE SalaryLine."Employee's type" OF
            0:
                BEGIN
                    /*
                            SalaryLine."Assiduity (Paid days)"    := (   SalaryHeader."Paid days"
                                                                     -   SalaryLine.Absences
                                                                     -   SalaryLine."Adjustment of absences")
                                                                     /   SalaryHeader."Paid days"
                                                                    *   100;
                    */
                    //CALCUL HEURES NORMALES
                    /* Heuresoccaenregm.RESET;
                     Heuresoccaenregm.SETFILTER("N° Salarié",Employee."No.");
                     Heuresoccaenregm.SETFILTER("Mois de paiement",'%1',SalaryHeader.Month);
                     Heuresoccaenregm.SETFILTER("Année de paiement",'%1',SalaryHeader.Year);
                      //<< DSFT AGA 140410
                      IF ParamRessHum."Activer régime quinzaine"THEN
                      IF RegimeWork."type calcul paie"=RegimeWork."type calcul paie"::Quinzaine THEN
                          Heuresoccaenregm.SETFILTER(Quinzaine,'%1',SalaryHeader.Quinzaine);
                       //<< DSFT AGA 140410
                       IF Heuresoccaenregm.FIND('-') THEN
                         REPEAT
                           TotHeuresEnreg := TotHeuresEnreg + Heuresoccaenregm."Nombre d'heures";
                         UNTIL Heuresoccaenregm.NEXT = 0;
              //END CALCUL HEURES NORMALE 25/12/2008
                     */

                    //<< AGA DSFT 02-05-2011
                    IF SalaryLine."Nombre de jours" = 0 THEN
                        TotHeuresEnreg := GNbHeure
                    ELSE
                        TotHeuresEnreg := SalaryLine."Nombre de jours" * RegimeWork."From Work day to Work hour";
                    //>> AGA DSFT 02-05-2011

                    SalaryLine."Worked hours" := TotHeuresEnreg;
                    //>>MBY 14/04/2009
                    //IF (Pinverse=TRUE) THEN
                    SalaryLine."Basis salary" := Employee."Basis salary";
                    //<<MBY
                    /*
                       IF GNbHeure>TotHeuresEnreg THEN
                         SalaryLine.Absences := GNbHeure-TotHeuresEnreg;
                     */
                    SalaryLine."Real basis salary" := ROUND(SalaryLine."Worked hours" * Employee."Basis salary",
                                                      ParamCpta."Amount Rounding Precision");
                    //>>MBY 14/04/2009
                    IF (Pinverse = FALSE) THEN
                        SalaryLine."Real basis salary" := ROUND(SalaryLine."Worked hours" * SalaryLine."Basis salary",
                                                        ParamCpta."Amount Rounding Precision");
                    //<<MBY
                    //>>DSFT AGA 10/03/10
                    SalaryLine."Assiduity (Paid days)" := (SalaryLine."Worked hours" / RegimeWork."Work Hours per month") * 100;
                    IF SalaryLine."Assiduity (Paid days)" > 100 THEN
                        SalaryLine."Assiduity (Paid days)" := 100;
                    //<<DSFT AGA 10/03/10


                END;
            1:
                BEGIN
                    SalaryLine."Basis hours" := LigneTravail."Nombre d'heures";
                    /*        LigneAbsence.RESET;
                            LigneAbsence.SETCURRENTKEY("Employee No.","Posting year","Posting month","Motif D'absence",Semaine,Quinzaine);
                            LigneAbsence.SETFILTER("Motif D'absence",'<>%1|%2',6,7);
                            LigneAbsence.SETFILTER("Employee No.",SalaryLine.Employee);
                            LigneAbsence.SETRANGE("Posting month",SalaryLine.Month);
                            LigneAbsence.SETRANGE("Posting year",SalaryLine.Year);
                            IF ParamRessHum."Activer régime quinzaine"THEN
                            IF RegimeWork."type calcul paie"=RegimeWork."type calcul paie"::Quinzaine THEN
                                LigneAbsence.SETFILTER(Quinzaine,'%1',SalaryHeader.Quinzaine);
                             //<< DSFT AGA 140410

                            LigneAbsence.CALCSUMS(Quantity);

                            AbsEmp := LigneAbsence.Quantity;
                            */
                    //CALCUL JOUR NORMALES MBY 12/01/2009 SAMI
                    /*       TotJoursEnreg := 0;
                           Heuresoccaenregm.RESET;
                           Heuresoccaenregm.SETFILTER("N° Salarié",Employee."No.");
                           Heuresoccaenregm.SETFILTER("Mois de paiement",'%1',SalaryHeader.Month);
                           Heuresoccaenregm.SETFILTER("Année de paiement",'%1',SalaryHeader.Year);
                            //<< DSFT AGA 140410
                            IF ParamRessHum."Activer régime quinzaine"THEN
                            IF RegimeWork."type calcul paie"=RegimeWork."type calcul paie"::Quinzaine THEN
                                Heuresoccaenregm.SETFILTER(Quinzaine,'%1',SalaryHeader.Quinzaine);
                             //<< DSFT AGA 140410

                             IF Heuresoccaenregm.FIND('-') THEN
                               REPEAT
                                 TotJoursEnreg := TotJoursEnreg + Heuresoccaenregm."Nbre Jour";
                               UNTIL Heuresoccaenregm.NEXT = 0;
                           IF GNbJour >= TotJoursEnreg THEN
                             AbsEmp := GNbJour-TotJoursEnreg
                           ELSE
                             BEGIN
                               AbsEmp := 0;
                             END;
                           //>>MBY 14/04/2009
                           */
                    //IF Sim = 0 THEN

                    //<< AGA DSFT 02-05-2011
                    IF SalaryLine."Nombre de jours" = 0 THEN
                        TotJoursEnreg := GNbJour
                    ELSE
                        TotJoursEnreg := SalaryLine."Nombre de jours";
                    //>> AGA DSFT 02-05-2011

                    //<<MBY
                    SalaryLine.Absences := AbsEmp;

                    SalaryLine."Paied days" := TotJoursEnreg;//-AbsEmp;
                                                             //END MBY
                    SalaryLine."Assiduity (Paid days)" := 100;

                    SalaryLine."Assiduity (Worked days)" := 100;


                    //>>MBY 14/04/2009
                    IF (Pinverse = TRUE) THEN
                        SalaryLine."Basis salary" := Employee."Basis salary";
                    // AGA >> assiduité jour payé

                    //>>MBY 14/04/2009
                    IF (Pinverse = FALSE) THEN
                        SalaryLine."Real basis salary" := ROUND((TotJoursEnreg) * SalaryLine."Basis salary" / GNbJour
                                                                 , ParamCpta."Amount Rounding Precision");

                    //<<MBY

                    /*
                   //>> DSFT AGA 01/05/2010   calcul des heures travaillées pour les salariers de type  mensuel horaire
                         IF EmploymentContract."Régime gardien/Chauffeur" THEN BEGIN
                          Heuresoccaenregm.RESET;
                          Heuresoccaenregm.SETFILTER("N° Salarié",Employee."No.");
                          Heuresoccaenregm.SETFILTER("Mois de paiement",'%1',SalaryHeader.Month);
                          Heuresoccaenregm.SETFILTER("Année de paiement",'%1',SalaryHeader.Year);
                           //<< DSFT AGA 140410
                           IF ParamRessHum."Activer régime quinzaine"THEN
                           IF RegimeWork."type calcul paie"=RegimeWork."type calcul paie"::Quinzaine THEN
                               Heuresoccaenregm.SETFILTER(Quinzaine,'%1',SalaryHeader.Quinzaine);
                            //<< DSFT AGA 140410
                            IF Heuresoccaenregm.FIND('-') THEN
                              REPEAT
                              IF Heuresoccaenregm."Nombre d'heures"<>0 THEN
                               SalaryLine."Montant Heures"     :=SalaryLine."Basis hours" * Heuresoccaenregm."Montant ligne";
                              UNTIL Heuresoccaenregm.NEXT = 0;
                           END;
                     //<< DSFT AGA 01/05/2010
                     */

                END;
        END;
        //FIN CALCUL SALAIRE DE BASE

        // DSFT AGA 19/042010 // CALCUL PRIME DE RENDEMENT MENSUEL
        //>> DSFT AGA 19/04/2010
        IF (ParamRessHum."Appl. prime rendement mensuel") THEN BEGIN
            Employee.GET(SalaryLine.Employee);
            Employee.CALCFIELDS("Total Indemnité jour congé");

            // DecSalaireBrut:=Employee."Reel Basis salary"+ Employee."Total Indemnité jour congé";
            DecSalaireBrut := Employee."Reel Basis salary";
            //DELETE SI EXISTE -->
            RecLIndemnities.RESET;
            RecLIndemnities.SETRANGE("No.", SalaryLine."No.");
            RecLIndemnities.SETRANGE("Employee No.", SalaryLine.Employee);
            RecLIndemnities.SETRANGE(Indemnity, ParamRessHum."Code ind.rend. Mensuel");
            IF RecLIndemnities.FIND('-') THEN
                RecLIndemnities.DELETE;

            //MODIFY SI EXISTE <--
            RecLDefaultindemnities.RESET;
            RecLDefaultindemnities.SETRANGE("Employment Contract Code", SalaryLine.Employee);
            RecLDefaultindemnities.SETRANGE("Indemnity Code", ParamRessHum."Code ind.rend. Mensuel");
            IF RecLDefaultindemnities.FIND('-') THEN BEGIN
                RecLDefaultindemnities."Default amount" := 0;

                EmploymentContract.GET(Employee."No.");
                RegimeWork.GET(EmploymentContract."Regimes of work");
                RecLDefaultindemnities."Employment Contract Code" := Employee."No.";
                RecLDefaultindemnities."Indemnity Code" := ParamRessHum."Code ind.rend. Mensuel";
                //RecLDefaultindemnities.VALIDATE("Indemnity Code");
                IF EmploymentContract."Employee's type" = 0 THEN
                    RecLDefaultindemnities."Default amount" := DecSalaireBrut * RecLDefaultindemnities.Taux / 100
                ELSE
                    RecLDefaultindemnities."Default amount" := DecSalaireBrut * RecLDefaultindemnities.Taux / 100;
                RecLDefaultindemnities.MODIFY;

                //MESSAGE(FORMAT(SalaryLine."droit de congé du mois"+SALR."Days off ="));
                RecLIndemnities."No." := SalaryLine."No.";
                RecLIndemnities."Employee No." := Employee."No.";
                RecLIndemnities.Indemnity := ParamRessHum."Code ind.rend. Mensuel";
                RecLIndemnities.VALIDATE(Indemnity);
                RecLIndemnities.Type := RecLDefaultindemnities.Type;
                RecLIndemnities."Type Indemnité" := RecLDefaultindemnities."Type Indemnité";
                IF EmploymentContract."Employee's type" = 0 THEN
                    RecLIndemnities."Base Amount" := DecSalaireBrut * RecLDefaultindemnities.Taux / 100
                ELSE
                    RecLIndemnities."Base Amount" := DecSalaireBrut * RecLDefaultindemnities.Taux / 100;

                RecLIndemnities."Real Amount" := RecLIndemnities."Base Amount";
                RecLIndemnities."User ID" := USERID;
                RecLIndemnities."Last Date Modified" := WORKDATE;
                RecLIndemnities."Employee Posting Group" := Employee."Employee Posting Group";
                RecLIndemnities.INSERT;
            END;

        END ELSE BEGIN
            RecLDefaultindemnities.RESET;
            RecLDefaultindemnities.SETRANGE("Employment Contract Code", SalaryLine.Employee);
            RecLDefaultindemnities.SETRANGE("Indemnity Code", ParamRessHum."Code ind.rend. Mensuel");
            IF RecLDefaultindemnities.FIND('-') THEN
                RecLDefaultindemnities."Default amount" := 0;
            RecLIndemnities.RESET;
            RecLIndemnities.SETRANGE("No.", SalaryLine."No.");
            RecLIndemnities.SETRANGE("Employee No.", SalaryLine.Employee);
            RecLIndemnities.SETRANGE(Indemnity, ParamRessHum."Code ind.rend. Mensuel");
            IF RecLIndemnities.FIND('-') THEN
                RecLIndemnities.DELETE;

        END;
        //<< DSFT AGA 19/04/2010



        // Calcul Indemnité
        IF Pinverse AND (SalaryLine.Month = SalaryLine.Month::Prime) THEN
            SalaryLine."Amount Days Off balacement" := 0;
        IF ParamRessHum."type calcul solde congé" = 1 THEN
            SalaryLine."Assiduity (Paid days)" := SalaryLine."Assiduity (Paid days)" + SalaryLine."Assiduity (days off balacement";

        // Calcul Indemnité
        CalcIndemnitéImp(SalaryLine);
        //>>DSFT AGA 18/03/2010

        // calcul droit de congé du mois
        HeureJourTravail.RESET;
        HeureJourTravail.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement", Quinzaine);
        HeureJourTravail.SETFILTER("N° Salarié", SalaryLine.Employee);
        HeureJourTravail.SETFILTER("Mois de paiement", '%1', SalaryLine.Month);
        HeureJourTravail.SETFILTER("Année de paiement", '%1', SalaryLine.Year);
        //>> DSFT AGA 140410
        IF ParamRessHum."Activer régime quinzaine" THEN
            IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN BEGIN
                HeureJourTravail.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);

            END;
        //<< DSFT AGA 140410
        HeureJourTravail.CALCSUMS("Nombre d'heures", "Montant ligne", "Nbre Jour");



        IF Employee."Employee's type" = 0 THEN
            SalaryLine."droit de congé du mois" := ROUND(RegimeWork."Days off per month" * HeureJourTravail."Nombre d'heures" /
                                                      RegimeWork."Work Hours per month", ParamCpta."Amount Rounding Precision")
        ELSE
            SalaryLine."droit de congé du mois" := ROUND(RegimeWork."Days off per month" * SalaryLine."Assiduity (Paid days)" / 100,
                                                            ParamCpta."Amount Rounding Precision");
        //>> DSFT AGA 09/03/2010
        IF SalaryLine."droit de congé du mois" > RegimeWork."Days off per month" THEN
            SalaryLine."droit de congé du mois" := RegimeWork."Days off per month";

        //<< DSFT AGA 09/03/2010
        IF (ParamRessHum."Calculer STC auto") THEN BEGIN
            Employee.GET(SalaryLine.Employee);
            Employee.CALCFIELDS("Days off =", "Total Indemnité jour congé");
            DecSalaireBrut := Employee."Reel Basis salary" + Employee."Total Indemnité jour congé";
            //DELETE SI EXISTE -->
            RecLIndemnities.RESET;
            RecLIndemnities.SETRANGE("No.", SalaryLine."No.");
            RecLIndemnities.SETRANGE("Employee No.", SalaryLine.Employee);
            RecLIndemnities.SETRANGE(Indemnity, ParamRessHum."Code solde congé");
            IF RecLIndemnities.FIND('-') THEN
                RecLIndemnities.DELETE;
            RecLDefaultindemnities.RESET;
            RecLDefaultindemnities.SETRANGE("Employment Contract Code", SalaryLine.Employee);
            RecLDefaultindemnities.SETRANGE("Indemnity Code", ParamRessHum."Code solde congé");
            IF RecLDefaultindemnities.FIND('-') THEN
                RecLDefaultindemnities.DELETE;
            //DELETE SI EXISTE <--
            IF (Employee."Inactive Date" <= SalaryHeader."Posting Date")
            AND (Employee."Inactive Date" > CALCDATE('-1M', SalaryHeader."Posting Date"))
            THEN BEGIN
                EmploymentContract.GET(Employee."No.");
                RegimeWork.GET(EmploymentContract."Regimes of work");
                RecLDefaultindemnities."Employment Contract Code" := Employee."No.";
                RecLDefaultindemnities."Indemnity Code" := ParamRessHum."Code solde congé";
                RecLDefaultindemnities.VALIDATE("Indemnity Code");

                IF EmploymentContract."Employee's type" = 0 THEN
                    RecLDefaultindemnities."Default amount" := (DecSalaireBrut / RegimeWork."Work Hours per month")
                                                                * ParamRessHum."From Work day to Work hour"
                                                                * (SalaryLine."droit de congé du mois" + SalaryLine."Days off remaining")
                ELSE
                    RecLDefaultindemnities."Default amount" := (DecSalaireBrut / RegimeWork."Worked Day Per Month")
                                                                * (SalaryLine."droit de congé du mois" + SalaryLine."Days off remaining");


                RecLDefaultindemnities.INSERT;
                //MESSAGE(FORMAT(SalaryLine."droit de congé du mois"+SALR."Days off ="));
                RecLIndemnities."No." := SalaryLine."No.";
                RecLIndemnities."Employee No." := Employee."No.";
                RecLIndemnities.Indemnity := ParamRessHum."Code solde congé";
                RecLIndemnities.VALIDATE(Indemnity);
                RecLIndemnities.Type := RecLDefaultindemnities.Type;
                RecLIndemnities."Type Indemnité" := RecLDefaultindemnities."Type Indemnité";
                IF EmploymentContract."Employee's type" = 0 THEN
                    RecLIndemnities."Base Amount" := (DecSalaireBrut / RegimeWork."Work Hours per month")
                                                                * ParamRessHum."From Work day to Work hour"
                                                                * (SalaryLine."droit de congé du mois" + SalaryLine."Days off remaining")
                ELSE
                    RecLIndemnities."Base Amount" := (DecSalaireBrut / RegimeWork."Worked Day Per Month")
                                                                * (SalaryLine."droit de congé du mois" + SalaryLine."Days off remaining");

                RecLIndemnities."Real Amount" := RecLIndemnities."Base Amount";
                RecLIndemnities."User ID" := USERID;
                RecLIndemnities."Last Date Modified" := WORKDATE;
                RecLIndemnities."Employee Posting Group" := Employee."Employee Posting Group";
                RecLIndemnities.INSERT;
                SalaryLine."Days off balacement" := -(SalaryLine."Days off remaining" + SalaryLine."droit de congé du mois");
                //  END;
            END;
        END;
        //<<DSFT AGA 18/03/2010

        //--> Calcul du salaire Brut du mois
        //  SalaryLine.CALCFIELDS("Montant Jours Fériés travaillé");
        "CalcInd&HsupNav"(SalaryLine, Sim);

        SalaryLine."6 * SMIG" := ROUND(ParamRessHum."Minimum wage guarantee" * 6, ParamCpta."Amount Rounding Precision");
        IF (SalaryLine.Month = SalaryLine.Month::Prime) THEN
            SalaryLine."Assiduity (Paid days)" := 100;

        CASE SalaryLine."Employee's type" OF
            1:
                BEGIN
                    SalaryLine."Gross Salary (sans Av)" := ROUND((bonus * SalaryLine."Real basis salary")
                                                          + SalaryLine."Taxable indemnities (Not Gross"
                                                          + SalaryLine."Taxable indemnities"
                                                          + SalaryLine."Supp. hours"
                                                          , ParamCpta."Amount Rounding Precision");
                    IF Sim < 2 THEN
                        SalaryLine."Gross Salary (sans Av) PR" := ROUND((SalaryLine."Basis salary" - SalaryLine."Amount Days Off balacement"
                                                                  ) + SalaryLine."Taxable indemnities PR"
                                                                  , ParamCpta."Amount Rounding Precision") +
                                                                  SalaryLine."Taxable indem. PR (Not Gross)";
                    SalaryLine."Gross Salary" := SalaryLine."Gross Salary (sans Av)";
                    IF Sim < 2 THEN
                        SalaryLine."Gross Salary PR" := SalaryLine."Gross Salary (sans Av) PR";
                END;
            0:
                BEGIN
                    SalaryLine."Gross Salary (sans Av)" := ROUND((bonus * SalaryLine."Real basis salary")
                                                        + SalaryLine."Taxable indemnities (Not Gross"
                                                        + SalaryLine."Taxable indemnities"
                                                        + SalaryLine."Supp. hours"
                                                        , ParamCpta."Amount Rounding Precision");
                    IF Sim < 2 THEN
                        SalaryLine."Gross Salary (sans Av) PR" := ROUND((SalaryLine."Basis salary" - SalaryLine."Amount Days Off balacement")
                                                        + SalaryLine."Taxable indemnities PR" + SalaryLine."Taxable indem. PR (Not Gross)"
                                                        , ParamCpta."Amount Rounding Precision");
                    SalaryLine."Gross Salary" := SalaryLine."Gross Salary (sans Av)";
                    IF Sim < 2 THEN
                        SalaryLine."Gross Salary (sans Av) PR" := SalaryLine."Gross Salary (sans Av) PR";
                END;
        END;

        CalcIndemnitéAvNat(SalaryLine);
        "CalcInd&Hsup"(SalaryLine, Sim);

        CASE SalaryLine."Employee's type" OF
            1:
                BEGIN
                    LigneTravail.RESET;
                    LigneTravail.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement", Quinzaine);
                    LigneTravail.SETFILTER("N° Salarié", SalaryLine.Employee);
                    LigneTravail.SETRANGE("Mois de paiement", SalaryLine.Month);
                    LigneTravail.SETRANGE("Année de paiement", SalaryLine.Year);
                    //>> DSFT AGA 150410
                    IF ParamRessHum."Activer régime quinzaine" THEN
                        IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN BEGIN
                            LigneTravail.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);
                        END;
                    //<< DSFT AGA 150410
                    LigneTravail.CALCSUMS("Nombre d'heures", "Montant ligne", "Nbre Jour");
                    LigneTravail.MODIFYALL("Paiement No.", SalaryLine."No.");
                    SalaryLine."Basis hours" := LigneTravail."Nombre d'heures";
                    LigneTravailEnreg.RESET;
                    LigneTravailEnreg.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement", Quinzaine);
                    LigneTravailEnreg.SETFILTER("N° Salarié", SalaryLine.Employee);
                    LigneTravailEnreg.SETRANGE("Mois de paiement", SalaryLine.Month);
                    LigneTravailEnreg.SETRANGE("Année de paiement", SalaryLine.Year);
                    //>> DSFT AGA 150410
                    IF ParamRessHum."Activer régime quinzaine" THEN
                        IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN BEGIN
                            LigneTravailEnreg.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);
                        END;
                    //<< DSFT AGA 150410

                    LigneTravailEnreg.CALCSUMS("Nombre d'heures", "Montant ligne");
                    LigneAbsence.RESET;

                    SalaryLine."Gross Salary" := ROUND(
                                                             ROUND(SalaryLine."Real basis salary" * bonus, ParamCpta."Amount Rounding Precision")
                                                           + ROUND(SalaryLine."Taxable indemnities", ParamCpta."Amount Rounding Precision")
                                                           + ROUND(SalaryLine."Supp. hours", ParamCpta."Amount Rounding Precision")
                                                           + ROUND(SalaryLine."Montant Jours Fériés travaillé")
                                                           //>> Régime mensuel horaires
                                                           + ROUND(SalaryLine."Montant Heures"),
                                                           ParamCpta."Amount Rounding Precision");
                    IF Sim < 2 THEN
                        SalaryLine."Gross Salary PR" := ROUND((bonus * SalaryLine."Real basis salary") + SalaryLine.
                                                               "Taxable indemnities PR", ParamCpta."Amount Rounding Precision");
                END;
            0:
                BEGIN
                    LigneTravail.RESET;
                    LigneTravail.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement", Quinzaine);
                    LigneTravail.SETFILTER("N° Salarié", SalaryLine.Employee);
                    LigneTravail.SETRANGE("Mois de paiement", SalaryLine.Month);
                    LigneTravail.SETRANGE("Année de paiement", SalaryLine.Year);
                    //>> DSFT AGA 150410
                    IF ParamRessHum."Activer régime quinzaine" THEN
                        IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN BEGIN
                            LigneTravail.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);
                        END;
                    //<< DSFT AGA 150410

                    LigneTravail.CALCSUMS("Nombre d'heures", "Montant ligne", "Nbre Jour");
                    LigneTravail.MODIFYALL("Paiement No.", SalaryLine."No.");
                    SalaryLine."Basis hours" := LigneTravail."Nombre d'heures";
                    LigneTravailEnreg.RESET;
                    LigneTravailEnreg.SETCURRENTKEY("N° Salarié", "Mois de paiement", "Année de paiement", Quinzaine);
                    LigneTravailEnreg.SETFILTER("N° Salarié", SalaryLine.Employee);
                    LigneTravailEnreg.SETRANGE("Mois de paiement", SalaryLine.Month);
                    LigneTravailEnreg.SETRANGE("Année de paiement", SalaryLine.Year);
                    //>> DSFT AGA 150410
                    IF ParamRessHum."Activer régime quinzaine" THEN
                        IF RegimeWork."type calcul paie" = RegimeWork."type calcul paie"::Quinzaine THEN BEGIN
                            LigneTravailEnreg.SETFILTER(Quinzaine, '%1', SalaryHeader.Quinzaine);
                        END;
                    //<< DSFT AGA 150410

                    LigneTravailEnreg.CALCSUMS("Nombre d'heures", "Montant ligne");
                    LigneAbsence.RESET;
                    SalaryLine."Gross Salary" := ROUND(
                                                             ROUND(SalaryLine."Real basis salary" * bonus, ParamCpta."Amount Rounding Precision")
                                                           + ROUND(SalaryLine."Taxable indemnities", ParamCpta."Amount Rounding Precision")
                                                           + ROUND(SalaryLine."Supp. hours", ParamCpta."Amount Rounding Precision")
                                                           + ROUND(SalaryLine."Montant Jours Fériés travaillé"),
                                                           ParamCpta."Amount Rounding Precision");
                    IF Sim < 2 THEN
                        SalaryLine."Gross Salary PR" := ROUND((SalaryLine."Real basis salary" * bonus)
                                                               + SalaryLine."Taxable indemnities PR"
                                                               , ParamCpta."Amount Rounding Precision");
                END;
        END;
        // --> Calc Cotisation Social
        IF ParamRessHum."type calcul solde congé" = 0 THEN
            SalaryLine."Basis salary" := SalaryLine."Basis salary" - SalaryLine."Amount Days Off balacement";
        CalcCotisationSocial1(SalaryLine);
        //--> Calcul du salaire imposable
        CalcAllTaxe(SalaryLine);
        //A AJOUTER CONTROLE NON IMPOSABLE
        IF EmploymentContract.Taxable THEN
            SalaryLine."Taxable salary" := ROUND(SalaryLine."Gross Salary" - SalaryLine.CNSS +
                                               SalaryLine."Taxable indemnities (Not Gross"
                                                           , ParamCpta."Amount Rounding Precision");


        IF Sim < 2 THEN
            IF EmploymentContract.Taxable THEN
                SalaryLine."Taxable salary PR" := ROUND(SalaryLine."Gross Salary PR" - SalaryLine."Non Taxable Soc. Contrib. PR" +
                                                       SalaryLine."Taxable indem. PR (Not Gross)"
                                                                 , ParamCpta."Amount Rounding Precision");

        //>> DSFT AGA 15/04/10
        /*
        IF ParamRessHum."Activer régime quinzaine"THEN
        IF RegimeWork."type calcul paie"=RegimeWork."type calcul paie"::Quinzaine THEN BEGIN
           SalaryLine."Taxable salary"   :=SalaryLine."Taxable salary" *2;
           SalaryLine."Taxable salary PR":=SalaryLine."Taxable salary PR"*2;
        
        END;
        
        */
        //<< DSFT AGA 15/04/10

        // Calc Cotisation Social
        CalcCotisationSocial2(SalaryLine);
        //--> Calcul de l'imposable réel
        IF EmploymentContract.Taxable THEN BEGIN
            IF NOT Employee."Familly chief" THEN BEGIN
                SalaryLine."Deduction Family chief" := 0;
                SalaryLine."Deduction Loaded child" := 0;
            END;
            SalaryLine."Deduction Prof. expenses" := ROUND(ParamRessHum."% professional expenses"
                                                          * SalaryLine."Taxable salary");
            IF SalaryLine.Month < 13 THEN
                SalaryLine."Real taxable" := ROUND(SalaryLine."Taxable salary"
                                                               - SalaryLine."Deduction Family chief"
                                                               - SalaryLine."Deduction Loaded child"
                                                               - SalaryLine."Deduction Prof. expenses", ParamCpta."Amount Rounding Precision")
            ELSE
                SalaryLine."Real taxable" := ROUND(SalaryLine."Taxable salary"
                                                               - SalaryLine."Deduction Family chief"
                                                               - SalaryLine."Deduction Loaded child"
                                                               - SalaryLine."Deduction Prof. expenses", ParamCpta."Amount Rounding Precision");

            IF (SalaryLine.Month < 13) OR (Sim = 2) THEN
                SalaryLine."Real taxable PR" := ROUND(SalaryLine."Taxable salary PR"
                                                               - SalaryLine."Deduction Family chief"
                                                               - SalaryLine."Deduction Loaded child"
                                                               - ROUND(SalaryLine."Taxable salary PR" * ParamRessHum."% professional expenses" / 100
                                                               , ParamCpta."Amount Rounding Precision"), ParamCpta."Amount Rounding Precision")
            ELSE
                SalaryLine."Real taxable PR" := ROUND(SalaryLine."Taxable salary PR"
                                                               - ROUND(SalaryLine."Taxable salary PR" * ParamRessHum."% professional expenses" / 100
                                                               , ParamCpta."Amount Rounding Precision"), ParamCpta."Amount Rounding Precision");


            //--> Calcul de l'imposable réel par an
            SalLineEng.RESET;
            SalLineEng.SETCURRENTKEY(Year, Month, Employee, "No.", Imposable);
            SalLineEng.SETFILTER(Employee, SalaryLine.Employee);
            SalLineEng.SETFILTER(Year, '%1', SalaryLine.Year);
            // SalLineEng.SETFILTER("Non Taxable Soc. Contrib.",'>%1',0);
            SalLineEng.SETFILTER(Imposable, '%1', TRUE);
            SalLineEng.CALCSUMS("Real taxable", "Taxe (Month)");
            SalaryLine."Total taxable rec." := SalLineEng."Real taxable";
            SalaryLine."Total taxes rec." := SalLineEng."Taxe (Month)";
            SalaryLine."Rec. payments" := 0;
            SalLineEngTmp.RESET;
            SalLineEngTmp.SETCURRENTKEY(Year, Month, Employee, "No.", Imposable);
            SalLineEngTmp.SETFILTER(Employee, SalaryLine.Employee);
            SalLineEngTmp.SETFILTER(Year, '%1', SalaryLine.Year);
            // SalLineEngTmp.SETFILTER("Non Taxable Soc. Contrib.",'>%1',0);
            SalLineEngTmp.SETFILTER(Imposable, '%1', TRUE);
            SalLineEngTmp.SETFILTER(Month, '<%1', 12);
            SalLineEngTmp.CALCSUMS("Real taxable", "Taxe (Month)");
            //MBY 20/01/2009

            SalaryLine."Rec. payments" := SalLineEngTmp.COUNT;
            /*
          // >> DSFT AGA 23/04/10
          IF ParamRessHum."Activer régime quinzaine"THEN
          IF RegimeWork."type calcul paie"=RegimeWork."type calcul paie"::Quinzaine THEN BEGIN
             IntNBMoisEnregistré:=SalaryLine."Rec. payments";

             SalaryLine."Rec. payments":=Round(SalaryLine."Rec. payments"/2,1)-1;
          END;
          */
            // << DSFT AGA 23/04/10
            //END MBY
            //MBY 10/03/09
            ////mby 26/08/2009 ----------------
            SalLineEngTmp.RESET;
            SalLineEngTmp.SETCURRENTKEY(Year, Month, Employee, "No.");
            SalLineEngTmp.SETFILTER(Employee, SalaryLine.Employee);
            SalLineEngTmp.SETFILTER(Year, '%1', SalaryLine.Year);
            //SalLineEngTmp.SETFILTER(Month,'<%1',12);
            ////mby 26/08/2009 ----------------
            DEDUCIMPOT := 0;
            IF SalLineEngTmp.FIND('-') THEN
                REPEAT
                    DEDUCIMPOT := DEDUCIMPOT + SalLineEngTmp."Deduction Family chief" +
                                  SalLineEngTmp."Deduction Loaded child" + SalLineEngTmp."Deduction Prof. expenses"
                UNTIL SalLineEngTmp.NEXT = 0;
            //END MBY 10/03/2009
            //--> Calcul de l'Imposable Réel
            EmploymentContract.RESET;
            Employee.GET(SalaryLine.Employee);
            EmploymentContract.GET(Employee."Emplymt. Contract Code");
            //05/02/2010MBY ASSVIE
            MntAssVie := 0;
            RecAssVie.RESET;
            RecAssVie.SETRANGE("Num Table", SalaryLine.Year);
            RecAssVie.SETRANGE("Dernier Document", SalaryLine.Employee);
            IF RecAssVie.FIND('-') THEN
                REPEAT
                    MntAssVie := MntAssVie + RecAssVie."Derniere Sequence";
                UNTIL RecAssVie.NEXT = 0;
            //05/02/2010
            CASE Sim OF
                0:
                    BEGIN
                        CASE ParamRessHum."Number of monthes" OF
                            0:
                                nbr := EmploymentContract."Regular payments";
                            1:
                                nbr := EmploymentContract."Temporary payments";
                            2:
                                nbr := EmploymentContract."Regular payments" + EmploymentContract."Temporary payments";
                        END;
                        SalaryLine."Real taxable (Year)" := ROUND(SalaryLine."Real taxable" * nbr,
                                                                               ParamCpta."Amount Rounding Precision");
                    END;



                1, 2:
                    BEGIN
                        //  IF ParamRessHum."Activer régime quinzaine"THEN
                        //  IF RegimeWork."type calcul paie"=RegimeWork."type calcul paie"::Quinzaine THEN
                        //   nbr:=26
                        //   else
                        nbr := 12;
                        EmploymentContract.RESET;
                        Employee.GET(SalaryLine.Employee);
                        EmploymentContract.GET(Employee."Emplymt. Contract Code");
                        CASE ParamRessHum."Number of monthes" OF
                            0:
                                nbr := EmploymentContract."Regular payments";
                            1:
                                nbr := EmploymentContract."Temporary payments";
                            2:
                                nbr := EmploymentContract."Regular payments" + EmploymentContract."Temporary payments";
                        END;


                        ParamRessHum."Taxes regulation" := 1;

                        CASE ParamRessHum."Taxes regulation" OF
                            0:
                                BEGIN
                                    IF SalaryLine.Month < 13 THEN BEGIN
                                        IF (Employee."Relation de travail" = 2) OR (Employee."Relation de travail" = 3) THEN
                                            // IF (Employee."Relation de travail"=2) THEN
                                            SalaryLine."Real taxable (Year)" := ROUND((SalaryLine."Real taxable" +
                                                        (SalaryLine."Real taxable" * (nbr - SalaryLine."Rec. payments" - 1)))
                                                        + SalaryLine."Total taxable rec."
                                                        , ParamCpta."Amount Rounding Precision")
                                        ELSE
                                            SalaryLine."Real taxable (Year)" := ROUND(((SalaryLine."Real taxable" * (nbr)))
                                                                               , ParamCpta."Amount Rounding Precision");
                                    END
                                    ELSE
                                        SalaryLine."Real taxable (Year)" := ROUND((SalaryLine."Real taxable" +
                                                                            ((SalaryLine."Real taxable PR")//- SalaryLine."Deduction Family chief"
                                                                             * (nbr - SalaryLine."Rec. payments")))
                                                                            + SalaryLine."Total taxable rec.", ParamCpta."Amount Rounding Precision");
                                    IF SalaryLine.Month < 13 THEN
                                        SalaryLine."Real Taxable PR (Year)" := ROUND((SalaryLine."Real taxable PR" +
                                                                            (SalaryLine."Real taxable PR" * (nbr - SalaryLine."Rec. payments" - 1)))
                                                                            + SalaryLine."Total taxable rec.", ParamCpta."Amount Rounding Precision")
                                    ELSE
                                        SalaryLine."Real Taxable PR (Year)" := ROUND((
                                                                            ((SalaryLine."Real taxable PR")//-SalaryLine."Deduction Family chief"
                                                                             * (nbr - SalaryLine."Rec. payments")))
                                                                            + SalaryLine."Total taxable rec.", ParamCpta."Amount Rounding Precision");
                                END;
                            1:
                                BEGIN
                                    //      IF SalaryLine."Rec. payments" < nbr THEN
                                    //tttttttttttttttttttttttttttttttt
                                    SalaryLine."Real taxable (Year)" := ROUND(SalaryLine."Real taxable" * nbr,
                                                                                   ParamCpta."Amount Rounding Precision");
                                    //         ELSE
                                    //          SalaryLine."Real taxable (Year)"            := ROUND(SalaryLine."Real taxable" + SalaryLine."Total taxable rec.",
                                    //                                                         ParamCpta."Amount Rounding Precision");

                                    //       IF SalaryLine."Rec. payments" <nbr THEN
                                    SalaryLine."Real Taxable PR (Year)" := ROUND(SalaryLine."Real taxable PR" * nbr,
                                                                                    ParamCpta."Amount Rounding Precision");
                                    //        ELSE
                                    //         SalaryLine."Real Taxable PR (Year)"          := ROUND(SalaryLine."Real taxable PR" +SalaryLine."Total taxable rec.",
                                    //                                                        ParamCpta."Amount Rounding Precision");
                                END;
                        END;
                    END;
            END;

            //RECALCUL REAL TAXABLE*****************************************10/03/2009
            IF Employee."Relation de travail" = 2 THEN BEGIN
                SalaryLine."Real taxable (Year)" := ROUND(SalaryLine."Taxable salary" * (nbr - SalaryLine."Rec. payments") +
                                                            SalaryLine."Total taxable rec." + DEDUCIMPOT, ParamCpta."Amount Rounding Precision");
                SalaryLine."Real taxable (Year)" := SalaryLine."Real taxable (Year)" - ROUND(ParamRessHum."% professional expenses"
                                                           * SalaryLine."Real taxable (Year)");
                SalaryLine."Real taxable (Year)" := SalaryLine."Real taxable (Year)" - (SalaryLine."Deduction Family chief" * nbr)
                                                                 - (SalaryLine."Deduction Loaded child" * nbr)
                                                            //MBY ASSVIE
                                                            - MntAssVie
                                                                 //05/02/2010
                                                                 ;
            END;


            //*****************************************END 10/03/2009
            // Calcul Impôt Annuel
            //MBY SAMI ARRONDI AU DINAR SUP 13/01/2009
            DecVar := ROUND(SalaryLine."Real taxable (Year)", 1) - SalaryLine."Real taxable (Year)";
            IF DecVar > 0 THEN
                SalaryLine."Real taxable (Year)" := ROUND(SalaryLine."Real taxable (Year)", 1)
            ELSE
                SalaryLine."Real taxable (Year)" := ROUND(SalaryLine."Real taxable (Year)" + 1, 1);
            //END MBY

            CalcImpotAn(SalaryLine);
            IF (SalaryLine.Month > 12) AND (Sim <> 2) THEN BEGIN
                // SalaryLine."Deduction Family chief":=0;
                // SalaryLine."Deduction Loaded child":=0;
            END;


            // Calcul Impôt mensuel
            CASE ParamRessHum."Taxes regulation" OF
                0:
                    BEGIN
                        IF SalaryLine.Month < nbr THEN BEGIN
                            //*******************************************************
                            IF Employee."Relation de travail" = 2 THEN BEGIN
                                IF (nbr - SalaryLine."Rec. payments") <> 0 THEN
                                    SalaryLine."Taxe PR (Month)" := ROUND((SalaryLine."Taxe PR (Year)" - SalaryLine."Total taxes rec.")
                                                                  / (nbr - SalaryLine."Rec. payments"), ParamCpta."Amount Rounding Precision");
                                IF SalaryLine.Month < 13 THEN
                                    SalaryLine."Taxe (Month)" := ROUND(((SalaryLine."Taxe (Year)" - SalaryLine."Total taxes rec.")
                                                                 / (nbr - SalaryLine."Rec. payments")), ParamCpta."Amount Rounding Precision")
                                ELSE
                                    SalaryLine."Taxe (Month)" := (SalaryLine."Taxe (Year)" - SalaryLine."Taxe PR (Year)");
                                IF (-SalaryLine."Taxe (Month)" >= SalaryLine."Total taxes rec.") AND (SalaryLine."Taxe (Month)" < 0) THEN
                                    SalaryLine."Taxe (Month)" := -SalaryLine."Total taxes rec.";
                            END
                            ELSE BEGIN   //04/03/2009
                                SalaryLine."Taxe PR (Month)" := ROUND((SalaryLine."Taxe PR (Year)" / nbr)
                                                              , ParamCpta."Amount Rounding Precision");
                                SalaryLine."Taxe (Month)" := ROUND((SalaryLine."Taxe (Year)" / nbr), ParamCpta."Amount Rounding Precision");
                            END;
                            IF SalaryLine."Taxe (Month)" < 0 THEN
                                SalaryLine."Taxe (Month)" := 0;
                            //*******************************************************
                        END ELSE BEGIN
                            IF (nbr - SalaryLine."Rec. payments" + 1) <> 0 THEN
                                SalaryLine."Taxe PR (Month)" := ROUND((SalaryLine."Taxe PR (Year)" - SalaryLine."Total taxes rec.")
                                                               / (nbr - SalaryLine."Rec. payments" + 1), ParamCpta."Amount Rounding Precision");
                            IF SalaryLine.Month < 13 THEN
                                SalaryLine."Taxe (Month)" := ROUND((SalaryLine."Taxe (Year)" - SalaryLine."Taxe PR (Year)") +
                                                             SalaryLine."Taxe PR (Month)", ParamCpta."Amount Rounding Precision")
                            ELSE
                                SalaryLine."Taxe (Month)" := ROUND((SalaryLine."Taxe (Year)" - SalaryLine."Taxe PR (Year)")
                                                             , ParamCpta."Amount Rounding Precision");
                            IF (-SalaryLine."Taxe (Month)" >= SalaryLine."Total taxes rec.") AND (SalaryLine."Taxe (Month)" < 0) THEN
                                SalaryLine."Taxe (Month)" := -SalaryLine."Total taxes rec.";
                            IF SalaryLine."Taxe (Month)" < 0 THEN
                                SalaryLine."Taxe (Month)" := 0;
                        END;
                    END;
                1:
                    BEGIN

                        IF SalaryLine."Rec. payments" < nbr THEN
                            SalaryLine."Taxe PR (Month)" := ROUND(SalaryLine."Taxe PR (Year)" / nbr, ParamCpta.
                                                                           "Amount Rounding Precision")
                        ELSE
                            SalaryLine."Taxe PR (Month)" := 0;

                        /*      IF SalaryLine."Rec. payments" < 12 THEN
                                SalaryLine."Taxe (Month)"                   := ROUND((SalaryLine."Taxe (Year)" -SalaryLine."Taxe PR (Year)")+
                                                                               SalaryLine."Taxe PR (Month)",ParamCpta."Amount Rounding Precision")
                               ELSE
                                SalaryLine."Taxe (Month)"                   := ROUND((SalaryLine."Taxe (Year)" -SalaryLine."Taxe PR (Year)")+
                                                                               SalaryLine."Taxe PR (Month)",ParamCpta."Amount Rounding Precision");
                         */
                        //  IF SalaryLine."Rec. payments" < nbr THEN
                        SalaryLine."Taxe (Month)" := ROUND((SalaryLine."Taxe (Year)"
                                                                       / nbr), ParamCpta."Amount Rounding Precision");
                        //  ELSE
                        //   SalaryLine."Taxe (Month)"                   := ROUND((SalaryLine."Taxe (Year)" -SalaryLine."Taxe PR (Year)")+
                        //                                                  SalaryLine."Taxe PR (Month)",ParamCpta."Amount Rounding Precision");



                        IF SalaryLine."Taxe (Month)" < 0 THEN
                            SalaryLine."Taxe (Month)" := 0;
                    END;
            END;

            IF Sim = 0 THEN BEGIN
                SalaryLine."Taxe (Month)" := ROUND((SalaryLine."Taxe (Year)" / nbr), ParamCpta."Amount Rounding Precision");
            END;
        END;
        //>> DSFT AGA 15/04/10
        /*
        IF ParamRessHum."Activer régime quinzaine"THEN
        IF RegimeWork."type calcul paie"=RegimeWork."type calcul paie"::Quinzaine THEN BEGIN
           SalaryLine."Taxable salary"   :=SalaryLine."Taxable salary" /2;
           SalaryLine."Taxable salary PR":=SalaryLine."Taxable salary PR"/2;
           SalaryLine."Taxe (Month)"     :=SalaryLine."Taxe (Month)"/2;
           SalaryLine."Rec. payments" :=IntNBMoisEnregistré;
        
        END;
        */
        //<< DSFT AGA 15/04/10



        SalaryLine."Net salary" := ROUND(SalaryLine."Gross Salary"
                                 - SalaryLine.CNSS
                                 + SalaryLine."Taxable indemnities (Not Gross"
                                 + SalaryLine."Non Taxable indemnities"
                                 + SalaryLine."Mission expenses"
                                 - SalaryLine."Taxable Soc. Contrib."
                                 - SalaryLine."Taxe (Month)"
                                  , ParamCpta."Amount Rounding Precision");

        // MH Calucl Retue FSP
        SalaryLine."Retenue FSP" := 0;
        SalaryLine."Retenue SNP" := 0;

        RecEmployee2.RESET;
        RecEmployee2.SETRANGE("No.", SalaryLine.Employee);
        IF RecEmployee2.FINDFIRST THEN BEGIN
            IF RecEmployee2."Appliquer Retenue SNP" = TRUE THEN
                SalaryLine."Retenue SNP" := SalaryLine."Basis salary" * 1 / 6;
        END;

        RecHumanResourcesSetup.FINDFIRST;
        IF RecHumanResourcesSetup."Appliquer Retenue FSP" = TRUE THEN
            SalaryLine."Retenue FSP" := (SalaryLine."Net salary" * RecHumanResourcesSetup."Taux Retenue FSP") / 100;
        // MH Calucl Retue FSP

        IF Sim = 1 THEN
            "Mgmt.ofLoansandAdvances".CréerLigneRembourcement(SalaryLine);
        SalaryLine."Net salary cashed" := ROUND(SalaryLine."Net salary"
                                                       - SalaryLine.Loans
                                                       - SalaryLine.Advances - SalaryLine."Retenue FSP"
                                                       - SalaryLine."Retenue SNP",   // MH Calucl Retue FSP
                                                       ParamCpta."Amount Rounding Precision");


        //>>MBY 14/04/2009
        IF SalaryLine."Net salary cashed" < 0 THEN
            MESSAGE('ATTENTION SALAIRE NEGATIF POUR L EMPLOYE : %1', SalaryLine.Employee);
        //<<MBY
        //arrondissement
        IF ParamRessHum."Montant Arrondi" > 0 THEN BEGIN
            EMP1.SETRANGE("No.", SalaryLine.Employee);
            IF SalaryLine."Net salary cashed" >= 0 THEN
                IF EMP1.FIND('-') THEN BEGIN
                    SalaryLine."Report en -" := EMP1."Report Employee en -";
                    SalaryLine."Net salary cashed" := SalaryLine."Net salary cashed" - EMP1."Report Employee en -";
                    SoldeReport := 0;
                    SoldeReport := ABS(SalaryLine."Net salary cashed" - ROUND(SalaryLine."Net salary cashed", 1, '>'));
                    IF SoldeReport > ParamRessHum."Montant Arrondi" THEN BEGIN
                        SoldeReport := SoldeReport - ParamRessHum."Montant Arrondi";
                        SalaryLine."Ajout  en +" := ABS(SoldeReport);
                        SalaryLine."Net salary cashed" := ABS(SalaryLine."Net salary cashed") + (ABS(SoldeReport));
                    END
                    ELSE BEGIN
                        SalaryLine."Ajout  en +" := ABS(SoldeReport);
                        SalaryLine."Net salary cashed" := ABS(SalaryLine."Net salary cashed") + (ABS(SoldeReport));
                    END;
                END;
        END;
        //======================= END ARRONDISSEMENT
        SalaryLine."User ID" := USERID;
        SalaryLine."Last Date Modified" := WORKDATE;

        IF (SalaryLine."Taxable salary" = 0) AND (SalaryLine."Net salary" <= 0) AND (Sim = 1) THEN
            DeleteLine(SalaryLine)
        ELSE
            SalaryLine.MODIFY;
        EXIT(SalaryLine."Net salary");

    end;


    procedure CalculIUTS(var SalaryLine: Record "Salary Lines")
    var
        TrancheImposition: Record "Slices of imposition";
        Impot: Decimal;
        MontantTranche: Decimal;
        NombreDeCharge: Integer;
        "BarémeDeCharge": Record "Baréme De Charge";
    begin
        Impot := 0;
        MontantTranche := SalaryLine."Salaire Net Imposable Avec 8%";
        IF TrancheImposition.FIND('-') THEN BEGIN
            REPEAT
                IF MontantTranche >= TrancheImposition."Superior limit" THEN
                    Impot += (TrancheImposition."Superior limit" - TrancheImposition."Lower limit") * TrancheImposition.Taux / 100;

                IF (MontantTranche < TrancheImposition."Superior limit") AND
                (MontantTranche >= TrancheImposition."Lower limit") THEN
                    Impot += (MontantTranche - TrancheImposition."Lower limit") * TrancheImposition.Taux / 100;
            UNTIL TrancheImposition.NEXT = 0;
        END;
        SalaryLine."Taxe (Month)" := ROUND(Impot, 1);
        SalaryLine."IUTS Brut" := ROUND(Impot, 1);
        IF EMP.GET(SalaryLine.Employee) THEN;
        BarémeDeCharge.SETRANGE("Nombre De Charge", EMP."Nombre de Charge");
        IF BarémeDeCharge.FINDFIRST THEN
            SalaryLine."IUTS Net" := SalaryLine."IUTS Brut" -
SalaryLine."IUTS Brut" * BarémeDeCharge."% Abattement" / 100
        ELSE
            SalaryLine."IUTS Net" := SalaryLine."IUTS Brut";
        SalaryLine."IUTS Brut" := ROUND(SalaryLine."IUTS Brut", 1);
        SalaryLine."IUTS Net" := ROUND(SalaryLine."IUTS Net", 1)
    end;


    procedure "CalculerPrimeAncienneté"("ParaNumsalarié": Code[20])
    var
        RecLEmployee: Record 5200;
        RecLPrimeAnciennete: Record "Prime Ancienneté";
        RecLHumanResourcesSetup: Record 5218;
        RecLDefaultIndemnities: Record "Default Indemnities";
        RecLDefaultIndemnities2: Record "Default Indemnities";
        DteDateRecrutement: Date;
        DteNewDate: Date;
        IntCompteur: Integer;
        BlnTrouver: Boolean;
        TxtMois: Text[30];
        DecLMontantSursalaire: Decimal;
    begin
        // >> HJ DSFT 14-07-2013
        BlnTrouver := FALSE;
        IntCompteur := 0;
        IF RecLHumanResourcesSetup.GET THEN;
        IF RecLEmployee.GET(ParaNumsalarié) THEN BEGIN
            IF RecLEmployee."Employment Date" <> 0D THEN BEGIN
                IF TODAY > RecLEmployee."Employment Date" THEN BEGIN
                    WHILE NOT BlnTrouver DO BEGIN
                        IntCompteur += 1;
                        TxtMois := FORMAT(IntCompteur) + 'M';
                        DteNewDate := CALCDATE(TxtMois, RecLEmployee."Employment Date");
                        IF DteNewDate > TODAY THEN BEGIN
                            BlnTrouver := TRUE;
                            IF RecLPrimeAnciennete.FINDFIRST THEN
                                REPEAT
                                    IF (IntCompteur >= RecLPrimeAnciennete."Plage Min") AND (IntCompteur <= RecLPrimeAnciennete."Plage Max") THEN BEGIN
                                        RecLDefaultIndemnities.SETRANGE("Employment Contract Code", ParaNumsalarié);
                                        RecLDefaultIndemnities.SETRANGE("Indemnity Code", RecLHumanResourcesSetup."Indem Ancienneté");
                                        IF RecLDefaultIndemnities.FINDFIRST THEN BEGIN

                                            // SUrsalaire
                                            DecLMontantSursalaire := 0;
                                            RecLDefaultIndemnities2.SETRANGE("Employment Contract Code", ParaNumsalarié);
                                            RecLDefaultIndemnities2.SETRANGE("Indemnity Code", RecLHumanResourcesSetup."Indem Sursalaire");
                                            IF RecLDefaultIndemnities2.FINDFIRST THEN BEGIN
                                                DecLMontantSursalaire := 0;//RecLDefaultIndemnities2."Default amount";
                                            END;
                                            RecLDefaultIndemnities."Default amount" := ROUND((RecLEmployee."Basis salary" + DecLMontantSursalaire)
                                                                                     * RecLPrimeAnciennete.Taux / 100, 1);
                                            RecLDefaultIndemnities.MODIFY;
                                        END;
                                    END;
                                UNTIL RecLPrimeAnciennete.NEXT = 0;

                        END;
                    END;
                END;

            END;
        END;
        // >> HJ DSFT 14-07-2013
    end;


    procedure "CalculerAnneeAncienneté"("ParaNumsalarié": Code[20]) AnneeAnciennete: Integer
    var
        RecLEmployee: Record 5200;
        RecLPrimeAnciennete: Record "Prime Ancienneté";
        RecLHumanResourcesSetup: Record 5218;
        RecLDefaultIndemnities: Record "Default Indemnities";
        RecLDefaultIndemnities2: Record "Default Indemnities";
        DteDateRecrutement: Date;
        DteNewDate: Date;
        IntCompteur: Integer;
        BlnTrouver: Boolean;
        TxtMois: Text[30];
        DecLMontantSursalaire: Decimal;
    begin
        // >> HJ DSFT 14-07-2013
        BlnTrouver := FALSE;
        IntCompteur := 0;
        IF RecLHumanResourcesSetup.GET THEN;
        IF RecLEmployee.GET(ParaNumsalarié) THEN BEGIN
            IF RecLEmployee."Employment Date" <> 0D THEN BEGIN
                IF TODAY > RecLEmployee."Employment Date" THEN BEGIN
                    WHILE NOT BlnTrouver DO BEGIN
                        IntCompteur += 1;
                        TxtMois := FORMAT(IntCompteur) + 'M';
                        DteNewDate := CALCDATE(TxtMois, RecLEmployee."Employment Date");
                        IF DteNewDate > TODAY THEN BEGIN
                            BlnTrouver := TRUE;
                            EXIT(IntCompteur);
                        END;
                    END;
                END;

            END;
        END;
        // >> HJ DSFT 14-07-2013
    end;


    procedure CalculerSalBasePlusSursalaire(var SalaryLine: Record "Salary Lines"; "ParaNumSalarié": Code[20]) Montant: Decimal
    var
        Valeur: Decimal;
        LDefaultIndemnities: Record "Default Indemnities";
    begin
        IF EMP.GET(ParaNumSalarié) THEN;
        IF HumanResourcesSetup.GET THEN;
        LDefaultIndemnities.RESET;
        LDefaultIndemnities.SETRANGE("Employment Contract Code", ParaNumSalarié);
        LDefaultIndemnities.SETRANGE("Indemnity Code", HumanResourcesSetup."Indem Sursalaire");
        IF LDefaultIndemnities.FINDFIRST THEN
            Valeur := (LDefaultIndemnities."Default amount" + SalaryLine."Real basis salary") * (HumanResourcesSetup."Taux Plafond Cotisation" / 100);
        EXIT(Valeur);
    end;


    procedure CalculerSalaireBrut("ParaNumSalarié": Code[20]) Montant: Decimal
    var
        "SommeIndemnité": Decimal;
    begin
        IF EMP.GET(ParaNumSalarié) THEN;
        SommeIndemnité := 0;
        DefaultIndemnities.SETRANGE("Employment Contract Code", ParaNumSalarié);
        DefaultIndemnities.SETRANGE("Inclu Calcul Brut STC", TRUE);
        IF DefaultIndemnities.FINDFIRST THEN
            REPEAT
                SommeIndemnité += DefaultIndemnities."Default amount";
            UNTIL DefaultIndemnities.NEXT = 0;

        EXIT(SommeIndemnité + EMP."Basis salary");
    end;


    procedure CalculerSalaireBrutSTC("ParaNumSalarié": Code[20]) Montant: Decimal
    var
        "SommeIndemnité": Decimal;
        LSalaryLinesEnregistrer: Record "Rec. Salary Lines";
        LFinComptage: Integer;
        LSommePaieEnregistre: Decimal;
        LCompteur: Integer;
    begin
        LCompteur := 0;
        IF EMP.GET(ParaNumSalarié) THEN;
        IF EMP."Montant Congé Payé" = 0 THEN BEGIN
            SommeIndemnité := 0;
            LSommePaieEnregistre := 0;
            LFinComptage := 12;
            LSalaryLinesEnregistrer.RESET;
            LSalaryLinesEnregistrer.SETRANGE(Employee, ParaNumSalarié);
            IF LSalaryLinesEnregistrer.COUNT >= 6 THEN BEGIN
                IF LSalaryLinesEnregistrer.FINDLAST THEN
                    REPEAT
                        LCompteur += 1;
                        IF LSalaryLinesEnregistrer.COUNT < 12 THEN LFinComptage := LSalaryLinesEnregistrer.COUNT;
                        LSommePaieEnregistre += LSalaryLinesEnregistrer."Gross Salary";
                    UNTIL (LSalaryLinesEnregistrer.NEXT(-1) = 12) OR (LCompteur >= LFinComptage);
            END;
            EXIT(ROUND(LSommePaieEnregistre / LFinComptage, 1));
        END
        ELSE
            EXIT(ROUND(EMP."Montant Congé Payé" / EMP."Nombre Mois Congé Payé", 1))
    end;


    procedure CalculerAbattement(var SalaryLine: Record "Salary Lines"; ParaNumPaie: Code[20]; "ParaNumSalarié": Code[20]) Montant: Decimal
    var
        Abattement: Decimal;
        Exoneration: Decimal;
        TauxAbattement: Decimal;
        TauxExoneration: Decimal;
    begin
        IF EMP.GET(ParaNumSalarié) THEN;
        Abattement := 0;
        Indemnities.RESET;
        Indemnities.SETRANGE("Employee No.", ParaNumSalarié);
        Indemnities.SETRANGE("No.", ParaNumPaie);
        Indemnities.SETRANGE(Abattement, TRUE);
        Linegrid.RESET;
        Linegrid.SETRANGE(Catégorie, EMP.Catégorie);
        Linegrid.SETRANGE(Echelons, EMP.Echelons);
        IF Linegrid.FINDFIRST THEN TauxAbattement := Linegrid."Bareme Abattement";
        IF Indemnities.FINDFIRST THEN
            REPEAT
                Abattement += ROUND(Indemnities."Real Amount" * TauxAbattement / 100, 1);
            // TauxAbattement:=Indemnities."% Abattement";
            UNTIL Indemnities.NEXT = 0;
        Abattement += ROUND(SalaryLine."Real basis salary" * TauxAbattement / 100, 1);
        EXIT(Abattement);
    end;


    procedure CalculerExoneration(ParaNumPaie: Code[20]; "ParaNumSalarié": Code[20]; ParaBaseImposable: Decimal) Montant: Decimal
    var
        Exoneration: Decimal;
        TauxExoneration: Decimal;
        MontantBaseFoisTauxExoneration: Decimal;
        PlafondExoneration: Decimal;
        MontantIndemnite: Decimal;
    begin
        IF EMP.GET(ParaNumSalarié) THEN;
        Exoneration := 0;
        Indemnities.RESET;
        Indemnities.SETRANGE("Employee No.", ParaNumSalarié);
        Indemnities.SETRANGE("No.", ParaNumPaie);
        Indemnities.SETRANGE(Exonération, TRUE);
        IF Indemnities.FINDFIRST THEN
            REPEAT
                MontantBaseFoisTauxExoneration := ROUND(ParaBaseImposable * Indemnities."% Exonération" / 100, 1);
                PlafondExoneration := Indemnities."Plafond Exonération";
                MontantIndemnite := Indemnities."Real Amount";

                IF (PlafondExoneration <= MontantBaseFoisTauxExoneration) AND (PlafondExoneration <= MontantIndemnite) THEN
                    Exoneration += PlafondExoneration
                ELSE
                    IF (MontantBaseFoisTauxExoneration <= MontantIndemnite) THEN
                        Exoneration += MontantBaseFoisTauxExoneration
                    ELSE
                        Exoneration += MontantIndemnite;
                TauxExoneration := Indemnities."% Exonération";
            UNTIL Indemnities.NEXT = 0;
        EXIT(Exoneration);
    end;
}

