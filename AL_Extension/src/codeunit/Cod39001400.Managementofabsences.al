Codeunit 39001400 "Management of absences"
{
    //GL2024  ID dans Nav 2009 : "39001400"


    //  IF ("Employee No."='') OR ("From Date"=0D) OR ("To Date"=0D) OR ("Heure Debut"=0T) OR ("Heure Fin"=0T) THEN


    trigger OnRun()
    begin
    end;

    var
        R5218: Record "Human Resources Setup";
        employee: Record Employee;
        txt: Text[100];
        Hdeb: Time;
        Hfin: Time;
        Tim: Time;
        Typecal: Option " ",Administratif,Roulement;
        CodeCal: Code[20];
        Nligne: Integer;
        JoursEnAjout: Decimal;
        HeuresSupEnregistrer: Record "Heures sup. eregistrées m";


    procedure ValidateEmployeeAbsence(Transaction: Integer; EmployeeAbsence: Record "Employee Absence"; var seq: Integer)
    var
        HumanResSetup: Record "Human Resources Setup";
        LastEmployeeAbsence: Record "Employee Absence";
        Saved: Record "Employee's days off Entry";
        err: label 'Impossible to proceed to conversion Work day / Work hour.\From Work day to Work hour nul in Human Resources Setup.';
        HumanResourceCommentLine: Record "Human Resource Comment Line";
        SavedHumResCommentLine: Record "Human Resource Comment Line";
        ContEmp: Record "Employment Contract";
        Sal: Record Employee;
        Regim: record "Regimes of work";
        ParamCpt: Record "General Ledger Setup";
        SavedTmp: Record "Employee's days off Entry";
    begin
        //ValidateEmployeeAbsence
        R5218.Get();
        Saved.Reset;
        Saved.Init;
        Saved."Transaction No." := Transaction;
        Saved."Entry No." := seq;
        Saved."Employee No." := EmployeeAbsence."Employee No.";
        Saved.Nom := EmployeeAbsence.Nom;
        Saved.prenom := EmployeeAbsence.prenom;
        Saved."From Date" := EmployeeAbsence."From Date";
        Saved."To Date" := EmployeeAbsence."To Date";
        Saved."Cause of Absence Code" := EmployeeAbsence."Cause of Absence Code";
        Saved.Description := EmployeeAbsence.Description;
        Saved.Quantity := EmployeeAbsence.Quantity;
        Saved."Heure Debut" := EmployeeAbsence."Heure Debut";
        Saved."Heure Fin" := EmployeeAbsence."Heure Fin";
        Saved.Unit := EmployeeAbsence.Unit;
        Saved."Impute on days off" := EmployeeAbsence."To impute on fays off";
        Saved."Posting month" := EmployeeAbsence."Posting month";
        Saved."Posting year" := EmployeeAbsence."Posting year";
        Saved."Line type" := EmployeeAbsence."Line type";
        Saved."Date Validité" := EmployeeAbsence."Date Validité";
        Saved."Motif D'absence" := EmployeeAbsence."Motif D'absence";
        //mby 11/02/2010
        // Saved.direction := EmployeeAbsence.Direction;
        Saved.service := EmployeeAbsence.service;
        Saved.section := EmployeeAbsence.section;
        //mby 11/02/2010
        Saved.Semaine := EmployeeAbsence.Semaine;
        if EmployeeAbsence."Line type" = 6 then
            Saved."Recuperation Entry No." := Saved."Entry No.";
        if EmployeeAbsence."Line type" = 7 then begin
            //EmployeeAbsence.TESTFIELD("Recuperation Entry No.");
            Saved."Recuperation Entry No." := EmployeeAbsence."Recuperation Entry No.";
            Clear(SavedTmp);
            //IF SavedTmp.GET(EmployeeAbsence."Recuperation Entry No.") THEN
            Saved."Date Validité" := WorkDate;
        end;
        if EmployeeAbsence."Line type" = 1 then

            // RK
            if employee.Get(EmployeeAbsence."Employee No.") then begin
                Saved."Employee Posting Group" := employee."Employee Posting Group";
                Saved."Global dimension 1" := employee."Global Dimension 1 Code";
                Saved."Global dimension 2" := employee."Global Dimension 2 Code";
                Saved."Employee Statistic Group" := employee."Statistics Group Code";
            end;
        // RK

        Saved."User ID" := UserId;
        Saved."Last Date Modified" := WorkDate;
        Sal.Get(EmployeeAbsence."Employee No.");
        ContEmp.Get(Sal."Emplymt. Contract Code");
        Regim.Get(ContEmp."Regimes of work");

        case EmployeeAbsence.Unit of
            0:
                begin
                    case EmployeeAbsence."Line type" of
                        0:
                            Saved."Quantity (Days)" := +EmployeeAbsence.Quantity;
                        1, 6, 10, 11:
                            Saved."Quantity (Days)" := +EmployeeAbsence.Quantity;
                        2, 5, 7, 8:
                            Saved."Quantity (Days)" := -EmployeeAbsence.Quantity;
                        3:
                            Saved."Quantity (Days)" := -EmployeeAbsence.Quantity;
                        4, 9:
                            begin
                                if (EmployeeAbsence.Quantity - R5218."1/2 solde à partir de") > 0
                                  then
                                    Saved."Quantity (Days)" := -(EmployeeAbsence.Quantity - R5218."1/2 solde à partir de") / 2
                                else
                                    Saved."Quantity (Days)" := 0;
                            end;
                    end;

                    case EmployeeAbsence."Line type" of
                        0:
                            Saved."Quantity (Hours)" := EmployeeAbsence."Quantity en Hours";
                        //  0: Saved."Quantity (Hours)" := + EmployeeAbsence.Quantity * (Regim."Work Hours per month"/Regim."Worked Day Per Month");
                        1, 6, 10, 11:
                            Saved."Quantity (Hours)" := +EmployeeAbsence.Quantity * (Regim."Work Hours per month" / Regim."Worked Day Per Month");
                        2, 5, 7, 8:
                            Saved."Quantity (Hours)" := -EmployeeAbsence.Quantity * (Regim."Work Hours per month" / Regim."Worked Day Per Month");
                        3:
                            Saved."Quantity (Hours)" := -EmployeeAbsence.Quantity * (Regim."Work Hours per month" / Regim."Worked Day Per Month");
                        4, 9:
                            begin
                                if (EmployeeAbsence.Quantity - R5218."1/2 solde à partir de") > 0
                                  then
                                    Saved."Quantity (Hours)" := -(EmployeeAbsence.Quantity *
                                                                 (Regim."Work Hours per month" / Regim."Worked Day Per Month"))
                                                               - (R5218."1/2 solde à partir de" *
                                                                (Regim."Work Hours per month" / Regim."Worked Day Per Month")) / 2
                                else
                                    Saved."Quantity (Hours)" := 0
                            end;
                    end;

                end;
            1:
                begin
                    //HumanResSetup.GET();
                    if (Regim."Work Hours per month" <= 0) or (Regim."Worked Day Per Month" <= 0) then
                        Error(err);
                    case EmployeeAbsence."Line type" of
                        0:
                            Saved."Quantity (Hours)" := EmployeeAbsence."Quantity en Hours";//+ EmployeeAbsence.Quantity;
                        1, 6, 10, 11:
                            Saved."Quantity (Hours)" := +EmployeeAbsence.Quantity;
                        2, 5, 7, 8:
                            Saved."Quantity (Hours)" := -EmployeeAbsence.Quantity;
                        3:
                            Saved."Quantity (Hours)" := -EmployeeAbsence.Quantity;
                        4, 9:
                            begin
                                if (EmployeeAbsence.Quantity - R5218."1/2 solde à partir de") > 0
                                  then
                                    Saved."Quantity (Hours)" := -(EmployeeAbsence.Quantity - R5218."1/2 solde à partir de") / 2
                                else
                                    Saved."Quantity (Hours)" := 0;
                            end;
                    end;
                    case EmployeeAbsence."Line type" of
                        0:
                            Saved."Quantity (Days)" := +EmployeeAbsence.Quantity / (Regim."Work Hours per month" / Regim."Worked Day Per Month");
                        1, 6, 10, 11:
                            Saved."Quantity (Days)" := +EmployeeAbsence.Quantity / (Regim."Work Hours per month" / Regim."Worked Day Per Month");
                        2, 5, 7, 8:
                            Saved."Quantity (Days)" := -EmployeeAbsence.Quantity / (Regim."Work Hours per month" / Regim."Worked Day Per Month");
                        3:
                            Saved."Quantity (Days)" := -EmployeeAbsence.Quantity / (Regim."Work Hours per month" / Regim."Worked Day Per Month");
                        4, 9:
                            begin

                                if (EmployeeAbsence.Quantity - R5218."1/2 solde à partir de") > 0
                                  then
                                    Saved."Quantity (Days)" := -(EmployeeAbsence.Quantity /
                                                                 (Regim."Work Hours per month" / Regim."Worked Day Per Month"))
                                                               - (R5218."1/2 solde à partir de" /
                                                                (Regim."Work Hours per month" / Regim."Worked Day Per Month")) / 2
                                else
                                    Saved."Quantity (Days)" := 0;
                            end;
                    end;

                end;
        end;
        //NE

        Saved."Quantity (Days)" := ROUND(Saved."Quantity (Days)", 0.01);
        //>>AGA 10/03/2010
        //     Saved."Quantity (Hours)"   :=  ROUND(Saved."Quantity (Hours)",0.01);
        Saved."Quantity (Hours)" := ROUND(Saved."Quantity (Hours)", 0.01);
        //<<AGA 10/03/2010

        // Verif autoris
        with EmployeeAbsence do begin
            if (Unit = 0) and ("From Date" <> "To Date") then begin
                Hdeb := 000000T;
                Hfin := 235959T;
            end else begin
                Hdeb := "Heure Debut";
                Hfin := "Heure Fin";
            end;
        end;
        //
        //END;
        HumanResourceCommentLine.SetRange("Table Name", 4);
        HumanResourceCommentLine.SetRange("Table Line No.", EmployeeAbsence."Entry No.");

        if HumanResourceCommentLine.Find('-') then
            repeat
                SavedHumResCommentLine.Reset;
                SavedHumResCommentLine.Copy(HumanResourceCommentLine);
                SavedHumResCommentLine.Code := EmployeeAbsence."Employee No.";
                SavedHumResCommentLine."Table Name" := 7;
                SavedHumResCommentLine.Insert;
                HumanResourceCommentLine.Delete;
            until HumanResourceCommentLine.Next = 0;
        ParamCpt.Get;
        //DSFT AGA 18/11/2010 CALCUL CONGE DE MALADIE
        //*******************************************************************************************************
        HumanResSetup.Get;
        if EmployeeAbsence.Unit = 0 then begin
            if EmployeeAbsence."Line type" = 1 then
                Saved."Montant Ligne" := ROUND((Sal."Basis salary" / Regim."Worked Day Per Month") * Saved."Quantity (Days)"
                                       , ParamCpt."Amount Rounding Precision")
            else
                if HumanResSetup."Calcul Montant absence" then
                    if Sal."Employee's type" = 1 then
                        Saved."Montant Ligne" := ROUND((Sal."Basis salary" / Regim."Worked Day Per Month") * Saved.Quantity
                                               , ParamCpt."Amount Rounding Precision")
                    else
                        Saved."Montant Ligne" := ROUND((Sal."Basis salary" / Regim."Work Hours per month") * Saved."Quantity (Hours)"
                                               , ParamCpt."Amount Rounding Precision")


        end else begin
            if HumanResSetup."Calcul Montant absence" then
                if Sal."Employee's type" = 1 then
                    Saved."Montant Ligne" := ROUND((Sal."Basis salary" / Regim."Work Hours per month") * Saved.Quantity
                                           , ParamCpt."Amount Rounding Precision")
                else
                    Saved."Montant Ligne" := ROUND((Sal."Basis salary") * Saved.Quantity
                                           , ParamCpt."Amount Rounding Precision")

        end;

        //*********************************************************************************************************
        //fin DSFT AGA 18/11/2010
        if EmployeeAbsence."Line type" = 3 then
            if EmployeeAbsence."To impute on fays off" then begin
                SavedTmp.Init;
                SavedTmp := Saved;
                SavedTmp."Entry No." := Saved."Entry No." + 1;
                SavedTmp."Transaction No." := Saved."Transaction No." + 1;
                SavedTmp."Impute on days off" := true;
                SavedTmp."Line type" := 2;
                if SavedTmp.Insert then begin
                    Saved."Impute on days off" := false;
                    Transaction := Transaction + 1;
                    seq := seq + 1;
                end;
            end;

        if EmployeeAbsence."Line type" = 9 then begin
            SavedTmp.Init;
            SavedTmp := Saved;
            SavedTmp."Entry No." := Saved."Entry No." + 1;
            SavedTmp."Transaction No." := Saved."Transaction No." + 1;
            SavedTmp."Line type" := 8;
            case EmployeeAbsence.Unit of
                0:
                    begin
                        SavedTmp."Quantity (Hours)" := -EmployeeAbsence.Quantity * (Regim."Work Hours per month" / Regim."Worked Day Per Month");
                        SavedTmp."Quantity (Days)" := -EmployeeAbsence.Quantity;
                    end;
                1:
                    begin
                        SavedTmp."Quantity (Days)" := -EmployeeAbsence.Quantity / (Regim."Work Hours per month" / Regim."Worked Day Per Month");
                        SavedTmp."Quantity (Hours)" := -EmployeeAbsence.Quantity;
                    end;
            end;
            if SavedTmp.Insert then begin
                Saved."Line type" := 4;
                Saved."Impute on days off" := false;
                Transaction := Transaction + 1;
                seq := seq + 1;
            end;
        end;

        if Saved.Insert then begin
            if Saved."Line type" = 2 then
                InsertDetailConge(Saved);

            if (EmployeeAbsence."From Date" = Dmy2date(1, EmployeeAbsence."Posting month" + 1, EmployeeAbsence."Posting year")) and
                 (EmployeeAbsence."To Date" = CalcDate('+FM', EmployeeAbsence."From Date")) and
                 (EmployeeAbsence."Line type" = 3) and
                  (WorkDate <= EmployeeAbsence."To Date") then begin
                Sal.Reset;
                Sal.Get(EmployeeAbsence."Employee No.");
                Sal.Status := 1;
                Sal.Modify;
            end;
        end;

        if EmployeeAbsence.Delete then;
    end;


    procedure UnValidateEmployeeAbsence(Saved: Record "Employee's days off Entry")
    var
        HumanResSetup: Record "Human Resources Setup";
        LastEmployeeAbsence: Record "Employee Absence";
        err: label 'Impossible to proceed to conversion Work day / Work hour.\From Work day to Work hour nul in Human Resources Setup.';
        ln: Integer;
        EmployeeAbsence: Record "Employee Absence";
        HumanResourceCommentLine: Record "Human Resource Comment Line";
        SavedHumanResCommentLine: Record "Human Resource Comment Line";
    begin
        EmployeeAbsence.Reset;
        if EmployeeAbsence.Find('+')
         then
            ln := EmployeeAbsence."Entry No." + 1
        else
            ln := 1;
        EmployeeAbsence.Reset;
        EmployeeAbsence."Entry No." := ln;
        EmployeeAbsence."Employee No." := Saved."Employee No.";
        EmployeeAbsence.Nom := Saved.Nom;
        EmployeeAbsence.prenom := Saved.prenom;
        EmployeeAbsence."From Date" := Saved."From Date";
        EmployeeAbsence."To Date" := Saved."To Date";
        EmployeeAbsence."Cause of Absence Code" := Saved."Cause of Absence Code";
        EmployeeAbsence.Description := Saved.Description;
        EmployeeAbsence.Quantity := Saved.Quantity;
        EmployeeAbsence."Quantity (Base)" := Saved."Quantity (Days)";
        EmployeeAbsence."Quantity en Hours" := Saved."Quantity (Hours)";
        EmployeeAbsence.Unit := Saved.Unit;
        EmployeeAbsence."To impute on fays off" := Saved."Impute on days off";
        EmployeeAbsence."Posting month" := Saved."Posting month";
        EmployeeAbsence."Posting year" := Saved."Posting year";
        EmployeeAbsence."Line type" := Saved."Line type";
        EmployeeAbsence."Motif D'absence" := Saved."Motif D'absence";
        EmployeeAbsence.Semaine := Saved.Semaine;
        //mby 11/02/2010
        // EmployeeAbsence.Direction := Saved.direction;
        EmployeeAbsence.service := Saved.service;
        EmployeeAbsence.section := Saved.section;
        //mby 11/02/2010

        EmployeeAbsence."User ID" := UserId;
        EmployeeAbsence."Last Date Modified" := WorkDate;

        SavedHumanResCommentLine.SetRange("Table Name", 7);
        SavedHumanResCommentLine.SetRange("Table Line No.", Saved."Entry No.");
        if SavedHumanResCommentLine.Find('-') then
            repeat
                HumanResourceCommentLine.Reset;
                HumanResourceCommentLine.Copy(SavedHumanResCommentLine);
                HumanResourceCommentLine."Table Name" := 4;
                HumanResourceCommentLine."Table Line No." := ln;
                HumanResourceCommentLine.Insert;
                SavedHumanResCommentLine.Delete;
            until SavedHumanResCommentLine.Next = 0;
        EmployeeAbsence.Insert;
        Saved.Delete(true);
    end;


    procedure "AttribuerDroitCongé"(Transaction: Integer; SalaryLine: Record "Salary Lines"; Sequence: Integer; var "Jourcongé": Decimal)
    var
        DaysOffEntry: Record "Employee's days off Entry";
        Temp: Decimal;
        SalaryHeader: Record "Salary Headers";
        EmploymentContract: Record "Employment Contract";
        RegimeWork: record "Regimes of work";
        txtStd: label 'Day off attributed :';
        Slr: Record Employee;
        HeureTravail: Record "Heures occa. enreg. m";
    begin
        Temp := 0;
        Jourcongé := 0;
        HeureTravail.Reset;
        HeureTravail.SetCurrentkey("N° Salarié", "Mois de paiement", "Année de paiement");
        HeureTravail.SetFilter("N° Salarié", SalaryLine.Employee);
        HeureTravail.SetRange("Mois de paiement", SalaryLine.Month);
        HeureTravail.SetRange("Année de paiement", SalaryLine.Year);
        HeureTravail.CalcSums("Nombre d'heures", "Montant ligne", "Nbre Jour");

        if SalaryHeader.Get(SalaryLine."No.") then begin
            if EmploymentContract.Get(SalaryLine."Emplymt. Contract Code") then begin
                /*  JoursEnAjout := 0;
                  HeuresSupEnregistrer.Reset;
                  HeuresSupEnregistrer.SetFilter("N° Salarié", SalaryLine.Employee);
                  HeuresSupEnregistrer.SetRange("Mois de paiement", SalaryLine.Month);
                  HeuresSupEnregistrer.SetRange("Année de paiement", SalaryLine.Year);
                  if HeuresSupEnregistrer.FindFirst then
                      repeat
                          if (HeuresSupEnregistrer."Type Jours" = HeuresSupEnregistrer."type jours"::"Jour(s) Ferie(s)")
                          or (HeuresSupEnregistrer."Type Jours" = HeuresSupEnregistrer."type jours"::"Congé Annuelle")
                          or (HeuresSupEnregistrer."Type Jours" = HeuresSupEnregistrer."type jours"::"Congé Exceptionnel") then
                              JoursEnAjout += HeuresSupEnregistrer."Nombre Heures Supp";
                      until HeuresSupEnregistrer.Next = 0;*/

                if RegimeWork.Get(SalaryLine."Employee Regime of work") then begin
                    if SalaryLine."Employee's type" = 0 then
                        Temp := ROUND(HeureTravail."Nombre d'heures" / RegimeWork."Work Hours per month" * RegimeWork."Days off per month", 0.001)
                    else
                        Temp := (SalaryHeader."Paid days"
                                + SalaryLine."Days off remaining"
                                - SalaryLine.Absences
                                - SalaryLine."Adjustment of absences")
                                / SalaryHeader."Paid days"
                                * 100;

                    Slr.Reset;
                    Slr.Get(SalaryLine.Employee);
                    IF RegimeWork."Days off per month" > 0 THEN BEGIN
                        DaysOffEntry.Reset;
                        DaysOffEntry.Init;
                        DaysOffEntry."Transaction No." := Transaction;
                        DaysOffEntry."Entry No." := Sequence;
                        DaysOffEntry."Employee No." := SalaryLine.Employee;
                        DaysOffEntry."From Date" := 0D;
                        DaysOffEntry."To Date" := 0D;
                        DaysOffEntry."Cause of Absence Code" := '';
                        DaysOffEntry.Description := 'AUTO --> ' + txtStd + ' ' + Format(WorkDate);
                        DaysOffEntry.Unit := 0;
                        DaysOffEntry."Impute on days off" := false;
                        DaysOffEntry."Posting month" := SalaryLine.Month;
                        DaysOffEntry."Posting year" := SalaryLine.Year;
                        DaysOffEntry."Line type" := 1;
                        //MBY 20/01/2009
                        if RegimeWork."Assignement mode" = 1 then begin
                            DaysOffEntry.Quantity := RegimeWork."Days off per month";
                            DaysOffEntry."Quantity (Days)" := RegimeWork."Days off per month";
                        end
                        else begin
                            DaysOffEntry.Quantity := ROUND(RegimeWork."Days off per month" * SalaryLine."Assiduity (Paid days)" /
                           100, 0.001);
                            DaysOffEntry."Quantity (Days)" := ROUND(RegimeWork."Days off per month" * SalaryLine."Assiduity (Paid days)" /
                            100, 0.001);
                        end;
                        //END MBY 20/01/2009
                        DaysOffEntry."Quantity (Hours)" := ROUND(DaysOffEntry."Quantity (Days)" * (RegimeWork."Work Hours per month" /
                                                                RegimeWork."Worked Day Per Month"), 0.001);
                        DaysOffEntry."Employee Posting Group" := SalaryLine."Employee Posting Group";
                        DaysOffEntry."Global dimension 1" := SalaryLine."Global Dimension 1";
                        DaysOffEntry."Global dimension 2" := SalaryLine."Global Dimension 2";
                        //mby 11/02/2010
                        //DaysOffEntry.direction               := Slr.Direction;
                        DaysOffEntry.service := Slr.Service;
                        DaysOffEntry.section := Slr.Section;
                        //mby 11/02/2010

                        DaysOffEntry."Payment No." := SalaryLine."No.";
                        DaysOffEntry."User ID" := UserId;
                        DaysOffEntry."Last Date Modified" := WorkDate;
                        if
                        DaysOffEntry.Insert then
                            Jourcongé := DaysOffEntry."Quantity (Days)";
                    end;
                end;
            end;
        end;
    end;


    procedure "SoderDroitCongé"(Transaction: Integer; var SalaryLine: Record "Salary Lines")
    var
        DaysOffEntry: Record "Employee's days off Entry";
        Temp: Decimal;
        SalaryHeader: Record "Salary Headers";
        EmploymentContract: Record "Employment Contract";
        RegimeWork: record "Regimes of work";
        txtStd: label 'Balance Day off :';
        DaysOffEntryTmp: Record "Employee's days off Entry";
        ij: Integer;
        QtyEnCours: Integer;
    begin
        //exit;
        ij := 0;
        DaysOffEntryTmp.Reset;
        if DaysOffEntryTmp.Find('+') then
            ij := DaysOffEntryTmp."Entry No.";
        ij := ij + 1;
        if (SalaryLine."Days off balacement" <> 0) then begin
            DaysOffEntry.Reset;
            DaysOffEntry."Transaction No." := Transaction;
            DaysOffEntry."Entry No." := ij;
            DaysOffEntry."Employee No." := SalaryLine.Employee;
            DaysOffEntry."From Date" := 0D;
            DaysOffEntry."To Date" := 0D;
            DaysOffEntry."Cause of Absence Code" := '';
            DaysOffEntry.Description := 'AUTO --> ' + txtStd + ' ' + Format(WorkDate);
            DaysOffEntry.Quantity := -Abs(SalaryLine."Days off balacement");
            DaysOffEntry.Unit := 0;
            DaysOffEntry."Impute on days off" := false;
            DaysOffEntry."Posting month" := SalaryLine.Month;
            DaysOffEntry."Posting year" := SalaryLine.Year;
            DaysOffEntry."Line type" := 1;
            //MBY 20/01/2009
            if SalaryHeader.Get(SalaryLine."No.") then
                if EmploymentContract.Get(SalaryLine."Emplymt. Contract Code") then
                    if RegimeWork.Get(SalaryLine."Employee Regime of work") then
                        if RegimeWork."Assignement mode" = 1 then begin
                            QtyEnCours := RegimeWork."Days off per month";
                        end
                        else begin
                            QtyEnCours := ROUND(RegimeWork."Days off per month" * SalaryLine."Assiduity (Paid days)" /
                            100, 0.001);
                        end;
            //END MBY 20/01/2009
            DaysOffEntry."Quantity (Days)" := -Abs(SalaryLine."Days off balacement" + QtyEnCours);
            DaysOffEntry."Payment No." := SalaryLine."No.";
            DaysOffEntry."Motif D'absence" := 6;
            DaysOffEntry."User ID" := UserId;
            DaysOffEntry."Last Date Modified" := WorkDate;
            //mby 11/02/2010
            DaysOffEntry.direction := SalaryLine.Departement;
            DaysOffEntry.service := SalaryLine.Service;
            DaysOffEntry.section := SalaryLine.Section;
            //mby 11/02/2010
            DaysOffEntry.Insert;
        end
    end;


    procedure ValiderAutorisation()
    var
        SavedAbs: Record "Employee's days off Entry";
        Num: Integer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Abs: Record "Employee's days off Entry";
        Sal: Record Employee;
        Cnt: Record "Employment Contract";
        Regim: record "Regimes of work";
        ParamRess: Record "Human Resources Setup";
    begin
    end;


    procedure EnregAutorisation()
    begin
    end;


    procedure ValidAbsence(var EmployeeAbsence: Record "Employee Absence")
    var
        SavedTmp: Record "Employee's days off Entry";
        i: Integer;
        J: Integer;
        Window: Dialog;
        K: Integer;
    begin
        SavedTmp.Reset;
        i := 0;
        J := 0;
        K := 0;
        if SavedTmp.Find('+') then begin
            i := SavedTmp."Entry No.";
            J := SavedTmp."Transaction No.";
        end;
        if EmployeeAbsence.Find('-') then begin
            Window.Open('Validatation Absence :           \' +
                        '                                 \' +
                        'N° Salariée  #1##################\' +
                        '@2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ');
            with EmployeeAbsence do begin
                repeat
                    i := i + 1;
                    K := K + 1;
                    J := J + 1;
                    Window.Update(1, "Employee No.");
                    Window.Update(2, ROUND(K / EmployeeAbsence.Count, 0.01) * 100000);
                    // NE NE
                    if VerifAbsNonComptabiliser(EmployeeAbsence, J, i) then begin
                        ValidateEmployeeAbsence((J), EmployeeAbsence, i);
                        // InsertDetailConge(EmployeeAbsence."Employee No.",i);
                    end;
                until EmployeeAbsence.Next = 0;
            end;
        end;
        Message('Validation Avec Succes');
    end;


    procedure ValidRemplacemet()
    var
        J: Integer;
        Sal: Record Employee;
        Cnt: Record "Employment Contract";
    begin
    end;


    procedure "CalculerHorraire Travail"(var "Salarié": Record Employee; var Datej: Date)
    var
        Contrat: Record "Employment Contract";
        CalendarAd: Record "Base Calendar Change";
        CalendarMgt: Codeunit "Calendar Management";
        i: Integer;
    begin
    end;


    procedure "ArchivéePointage"(Nseq: Integer)
    begin
    end;


    procedure SearchAutorisat(var NSalariee: Code[20]; DateT: Date; Heuredeb: Time; HeureFin: Time; var Heuredeab: Time; var HeureFinab: Time): Boolean
    begin
    end;


    procedure SearchRempl(var NSalariee: Code[20]; Date: Date; Heuredeb: Time; HeureFin: Time): Boolean
    begin
    end;


    procedure "CréerEcrtAbs"(var "N°sal": Code[20]; DateT: Date; HeureDeb: Time; HeureFin: Time)
    var
        Ligabs: Record "Employee Absence";
        PaieEnreg: Record "Rec. Salary Headers";
        "Qte/jour": Decimal;
    begin
        Ligabs.Reset;
        Ligabs."Entry No." := 1;
        Ligabs."Employee No." := "N°sal";
        Ligabs."From Date" := DateT;
        Ligabs."To Date" := DateT;
        Ligabs."Heure Debut" := HeureDeb;
        Ligabs."Heure Fin" := HeureFin;
        Ligabs.Unit := 0;
        calcqte(DateT, Ligabs);
        Clear(PaieEnreg);
        PaieEnreg.SetCurrentkey(Year, Month, "No.");
        PaieEnreg.SetFilter(Year, '%1', Date2dmy(WorkDate, 3));
        PaieEnreg.SetFilter(Month, '<12');

        if PaieEnreg.Find('+') then begin
            if PaieEnreg.Month > 11 then begin
                Ligabs."Posting month" := 0;
                Ligabs."Posting year" := Date2dmy(WorkDate, 3) + 1;
            end else begin
                Ligabs."Posting month" := PaieEnreg.Month + 1;
                Ligabs."Posting year" := Date2dmy(WorkDate, 3);
            end
        end else begin
            Ligabs."Posting month" := 0;
            Ligabs."Posting year" := Date2dmy(WorkDate, 3);
        end;
        Ligabs."Cause of Absence Code" := '';
        Ligabs."To impute on fays off" := false;
        Ligabs."Line type" := Ligabs."line type"::"Non paid";
    end;


    procedure calcqte(var DateT: Date; var Rec: Record "Employee Absence")
    var
        j: Integer;
        datdeb1: Time;
        dateDeb2: Time;
        datefin1: Time;
        dateFin2: Time;
        nowork: Boolean;
        CalendarMgmt: Codeunit "Calendar Management";
        contratT: Record "Employment Contract";
        Jour: Decimal;
        JourFree: Boolean;
    begin
        with Rec do begin
            Jour := 0;
            employee.Get("Employee No.");
            Clear(contratT);
            contratT.Get(employee."Emplymt. Contract Code");
            contratT.TestField("Code Calendar");
            begin
                ////  CalendarMgmt.CheckDateTime(contratT."Code Calendar",DateT,datdeb1,datefin1,dateDeb2,dateFin2,nowork,JourFree);
                if not nowork then begin
                    Jour := ((datefin1 - datdeb1) + (dateFin2 - dateDeb2)) / 3600000;
                    if "Heure Debut" > datefin1 then begin
                        Quantity := (("Heure Fin" - "Heure Debut") / 3600000) / Jour;
                        "Quantity en Hours" := ("Heure Fin" - "Heure Debut") / 3600000;
                    end else
                        if ("Heure Fin" > datefin1) then
                            Quantity := ((("Heure Fin" - dateDeb2) + (datefin1 - "Heure Debut")) / 3600000) / Jour;
                    "Quantity en Hours" := (("Heure Fin" - dateDeb2) + (datefin1 - "Heure Debut")) / 3600000;
                end else begin
                    Quantity := (("Heure Fin" - "Heure Debut") / 3600000) / Jour;
                    "Quantity en Hours" := ("Heure Fin" - "Heure Debut") / 3600000;
                end;
            end
        end;
    end;


    procedure Searchabs(var "N°sal": Code[20]; DateT: Date; HeureDeb: Time; HeureFin: Time) Ftrue: Boolean
    var
        absec: Record "Employee's days off Entry";
    begin
        Ftrue := false;
        absec.Reset;
        absec.SetCurrentkey("Line type", "Employee No.", "From Date", "To Date", "Heure Debut", "Heure Fin");
        absec.SetFilter("Employee No.", "N°sal");
        absec.SetFilter("Line type", '<>%1', absec."line type"::"Day off Right");
        absec.SetFilter("Employee No.", "N°sal");
        absec.SetFilter("From Date", '<=%1', DateT);
        absec.SetFilter("To Date", '>=%1', DateT);
        if absec.Find('-') then begin
            absec.SetFilter("From Date", '%1', DateT);
            absec.SetFilter("Heure Debut", '<%1', HeureDeb);
            if absec.Find('-') then
                Ftrue := true;
            absec.SetFilter("From Date", '<%1', DateT);
            absec.SetFilter("To Date", '%1', DateT);
            absec.SetFilter("Heure Debut", '<>%1', 0T);
            absec.SetFilter("Heure Fin", '>%1', HeureFin);
            if absec.Find('-') then
                Ftrue := true;
        end else
            Ftrue := false;
    end;


    procedure calcheureMiss(var NSal: Code[20]; DateDeb: Date; HeureDeb: Time; DateFin: Date; HeureFin: Time) NbreH: Decimal
    var
        j: Integer;
        Jour: Decimal;
        DateTmp: Date;
        Temps: Time;
    begin
        Jour := 0;
        j := 1;
        NbreH := 0;
        Jour := DateFin - DateDeb + 1;

        if Jour <= 0 then
            Error('Vérifier Heure Fin !!!');
        Temps := 000000T;
        if Jour = 1 then
            NbreH := calcheureMissjour(NSal, DateDeb, HeureDeb, HeureFin)
        else begin
            repeat
                DateTmp := CalcDate(StrSubstNo('%1J', j - 1), DateDeb);

                case j of
                    1:
                        NbreH := calcheureMissjour(NSal, DateTmp, HeureDeb, Temps);
                    Jour:
                        NbreH := NbreH + calcheureMissjour(NSal, DateTmp, Temps, HeureFin);
                    else
                        NbreH := NbreH + calcheureMissjour(NSal, DateTmp, Temps, Temps);
                end;
                j := j + 1;
            until j > Jour;
        end;
    end;


    procedure calcheureMissjour(var NSal: Code[20]; DateT: Date; HeureDeb: Time; HeureFin: Time) HeurT: Decimal
    var
        j: Integer;
        datdeb1: Time;
        dateDeb2: Time;
        datefin1: Time;
        dateFin2: Time;
        nowork: Boolean;
        CalendarMgmt: Codeunit "Calendar Management";
        contratT: Record "Employment Contract";
        Jour: Decimal;
        Nbre: Integer;
        HeureDeb1: Time;
        heureFin1: Time;
        DatedebR: Date;
        Jourfree: Boolean;
        Roul: Boolean;
    begin
        Jour := 0;
        HeurT := 0;
        employee.Get(NSal);
        datdeb1 := 000000T;
        datefin1 := 000000T;
        dateDeb2 := 000000T;
        dateFin2 := 000000T;
        Tim := 000000T;
        DatedebR := 0D;
        Clear(contratT);
        contratT.Get(employee."Emplymt. Contract Code");
        contratT.TestField("Code Calendar");
        /*Rempl.RESET;
        Rempl.SETCURRENTKEY(Type,"N° SAlariée","Date remplacement");
        Rempl.ASCENDING(FALSE);
        Rempl.SETRANGE(Type,1);
        Rempl.SETFILTER("N° SAlariée",NSal);
        Rempl.SETFILTER("Date remplacement",'..%1',DateT);
        CLEAR(Typecal);
        CLEAR(CodeCal);
        IF Rempl.FIND('-') THEN BEGIN
           Typecal:=Rempl."Type Calendar";
           CodeCal:=Rempl."Code Calendar";
           DatedebR:=Rempl."Date Debut Roulement";
           Nligne:= Rempl."N° Ligne Roulement";
           END ELSE BEGIN
           Typecal:=contratT."Type Calendar";
           CodeCal:=contratT."Code Calendar";
            IF Typecal=Typecal::Roulement THEN
           employee.TESTFIELD("Date Debut Roulement");
           DatedebR:=employee."Date Debut Roulement";
           Nligne:=0;
           END;
        IF Typecal=Typecal::Roulement THEN BEGIN
          CalcHJour(NSal,DateT,datdeb1,datefin1,dateDeb2,datefin1,nowork,Roul,Jourfree);
            HeurT:=0;
            IF CalendRoul.Type<>CalendRoul.Type::Repos THEN BEGIN
              IF (HeureDeb=000000T) OR ((HeureDeb<datdeb1) AND (HeureDeb<>000000T)) THEN
                 HeureDeb1:=datdeb1
               ELSE
                 HeureDeb1:=HeureDeb;
              IF (HeureFin=000000T) OR ((HeureFin>datefin1) AND (HeureFin<>0T) AND
               (datefin1>datdeb1)) THEN
                 heureFin1:=datefin1
              ELSE
                 heureFin1:=HeureFin;
                 IF heureFin1< HeureDeb1 THEN
             HeurT:=(((235959T-HeureDeb1)+(heureFin1-Tim)+1)/3600000)
                  ELSE
             HeurT:=((heureFin1-HeureDeb1)/3600000);
           END;
       { CLEAR(CalendRoul);
        CalendRoul.RESET;
        CalendRoul.SETFILTER(Code,CodeCal);
        CalendRoul.SETRANGE("Type Abonnement",0);
          j:=0;
          CalendRoul.FIND('-');
          IF DateT<DatedebR THEN ERROR('Verifiez Date De Mission  !!!');
          j:=(DateT-DatedebR) MOD CalendRoul.COUNT ;
                 HeureDeb1:=HeureDeb;
                 heureFin1:=HeureFin;
                 j:=j+Nligne;
          REPEAT
            j:=j-1;
            Jour:=0;
            HeurT:=0;
            IF CalendRoul.Type<>CalendRoul.Type::Repos THEN BEGIN
              IF (HeureDeb=000000T) OR ((HeureDeb<CalendRoul."Heure Debut") AND (HeureDeb<>000000T)) THEN
                 HeureDeb1:=CalendRoul."Heure Debut"
               ELSE
                 HeureDeb1:=HeureDeb;
              IF (HeureFin=000000T) OR ((HeureFin>CalendRoul."Heure Fin") AND (HeureFin<>0T) AND
               (CalendRoul."Heure Fin">CalendRoul."Heure Debut")) THEN
                 heureFin1:=CalendRoul."Heure Fin"
              ELSE
                 heureFin1:=HeureFin;

                 IF heureFin1< HeureDeb1 THEN
             HeurT:=(((235959T-HeureDeb1)+(heureFin1-Tim)+1)/3600000)
                  ELSE
             HeurT:=((heureFin1-HeureDeb1)/3600000);
            END;
           UNTIL (CalendRoul.NEXT=0) OR (j<0); } */
        //END ELSE
        begin
            HeurT := 0;
            // CalendarMgmt.CheckDateTime(CodeCal,DateT,datdeb1,datefin1,dateDeb2,dateFin2,nowork,Jourfree);
            //GL2024   nowork := CalendarMgmt.CheckDateStatus(CodeCal, DateT, txt);
            if nowork = false then begin

                if (dateFin2 = 0T) and (dateDeb2 = 0T) then
                    Jour := ((datefin1 - datdeb1)) / 3600000;
                if (datefin1 = 0T) and (datdeb1 = 0T) then
                    Jour := ((dateFin2 - dateDeb2)) / 3600000;

                if (datefin1 <> 0T) and (datdeb1 <> 0T) and (dateFin2 <> 0T) and (dateDeb2 <> 0T) then
                    Jour := ((datefin1 - datdeb1) + (dateFin2 - dateDeb2)) / 3600000;

                if ((HeureDeb <= datdeb1) and (HeureDeb <> 0T)) or (HeureDeb = 0T) and (datdeb1 <> 0T) then
                    HeureDeb := datdeb1;
                if ((HeureDeb <= dateDeb2) and (HeureDeb >= datefin1)) and (HeureDeb <> 0T) and (dateDeb2 <> 0T) then
                    HeureDeb := dateDeb2;
                if ((HeureFin >= datefin1) and (dateFin2 = 0T)) then
                    HeureFin := datefin1;

                if (HeureFin <= dateDeb2) and (HeureFin <> 0T) then
                    HeurT := (datefin1 - HeureDeb) / 3600000;
                if (HeureFin <= datefin1) then
                    HeurT := (HeureFin - HeureDeb) / 3600000;

                if (HeureFin >= dateDeb2) and (dateDeb2 <> 0T) then begin
                    if HeureDeb <= datefin1 then
                        HeurT := ((datefin1 - HeureDeb) + (HeureFin - dateDeb2)) / 3600000
                    else
                        HeurT := (HeureFin - HeureDeb) / 3600000;
                end;
            end
        end;

    end;


    procedure VerifAbsNonComptabiliser(EmployeeAbsence: Record "Employee Absence"; Transaction: Integer; seq: Integer) NFalse: Boolean
    var
        CauseAbs: Record "Cause of Absence";
        AbsEnreg: Record "Employee's days off Entry";
        ContEmp: Record "Employment Contract";
        Regim: record "Regimes of work";
        Sal: Record Employee;
        QteJ: Decimal;
        HumanResSetup: Record "Human Resources Setup";
        EmployeeAbsenceTmp: Record "Employee Absence";
        CauseAbsTmp: Record "Cause of Absence";
        EmployeeAbsenceTmp1: Record "Employee Absence";
        QteX: Decimal;
        Seq1: Integer;
        Trans1: Integer;
        EmployeeAbsenceTmp2: Record "Employee Absence";
        EmployeeAbsenceTmp3: Record "Employee Absence";
        EmployeeAbs: Record "Employee Absence";
    begin
        Clear(CauseAbs);
        EmployeeAbs := EmployeeAbsence;
        HumanResSetup.Get;
        NFalse := true;
        QteJ := 0;
        if CauseAbs.Get(EmployeeAbsence."Cause of Absence Code") then;
        if (CauseAbs.Type in [5, 8, 9]) and (CauseAbs."Nbre de J (autorisée)" <> 0) then begin
            Clear(AbsEnreg);
            AbsEnreg.Reset;
            AbsEnreg.SetCurrentkey("Posting year", "Line type", "Cause of Absence Code", "Employee No.");
            AbsEnreg.SetRange("Posting year", EmployeeAbsence."Posting year");
            AbsEnreg.SetRange("Line type", 5);
            AbsEnreg.SetRange("Cause of Absence Code", EmployeeAbsence."Cause of Absence Code");
            AbsEnreg.SetRange("Employee No.", EmployeeAbsence."Employee No.");
            AbsEnreg.CalcSums("Quantity (Days)");

            Clear(Sal);
            Sal.Get(EmployeeAbsence."Employee No.");
            Clear(ContEmp);
            ContEmp.Get(Sal."Emplymt. Contract Code");
            Clear(Regim);
            Regim.Get(ContEmp."Regimes of work");
            if EmployeeAbsence.Unit = 0 then
                QteJ := EmployeeAbsence.Quantity
            else
                QteJ := ROUND((EmployeeAbsence.Quantity / (Regim."Work Hours per month" / Regim."Worked Day Per Month")), 0.01);
            if Abs(AbsEnreg."Quantity (Days)") + QteJ <= CauseAbs."Nbre de J (autorisée)" then begin
                NFalse := false;
                ValidateEmployeeAbsence(Transaction, EmployeeAbsence, seq);

            end else begin
                // abs 1
                if (Abs(AbsEnreg."Quantity (Days)") + QteJ) <=
                    (CauseAbs."Nbre de J (auto. 1 Période)" + CauseAbs."Nbre de J (autorisée)") then begin
                    EmployeeAbsenceTmp := EmployeeAbs;
                    NFalse := false;
                    QteX := CauseAbs."Nbre de J (autorisée)" - Abs(AbsEnreg."Quantity (Days)");
                    if QteX < 0 then
                        QteX := 0;
                    if EmployeeAbsence.Unit = 0 then
                        EmployeeAbsence.Validate(Quantity, QteX)
                    else
                        EmployeeAbsence.Validate(Quantity, QteX *
                            (Regim."Work Hours per month" / Regim."Worked Day Per Month"));
                    if QteX <> 0 then
                        ValidateEmployeeAbsence(Transaction, EmployeeAbsence, seq);
                    EmployeeAbsenceTmp."From Date" := EmployeeAbsence."To Date" + 1;
                    EmployeeAbsenceTmp.Validate(Quantity, (EmployeeAbsenceTmp.Quantity - EmployeeAbsence.Quantity));
                    CauseAbs.TestField("Code Cause 1 Période");
                    EmployeeAbsenceTmp.Validate("Cause of Absence Code", CauseAbs."Code Cause 1 Période");
                    if QteX <> 0 then begin
                        Transaction := Transaction + 1;
                        seq := seq + 1;
                        ValidateEmployeeAbsence(Transaction, EmployeeAbsenceTmp, seq);
                    end
                    else
                        ValidateEmployeeAbsence(Transaction, EmployeeAbsenceTmp, seq);
                    // fin Abs 1
                end else begin
                    if (Abs(AbsEnreg."Quantity (Days)") + QteJ) <=
                        (CauseAbs."Nbre de J (auto. 1 Période)" + CauseAbs."Nbre de J (autorisée)"
                         + CauseAbs."Nbre de J (auto. 2 Période)") then begin
                        EmployeeAbsenceTmp := EmployeeAbs;
                        EmployeeAbsenceTmp1 := EmployeeAbs;
                        QteX := CauseAbs."Nbre de J (autorisée)" - Abs(AbsEnreg."Quantity (Days)");
                        if QteX < 0 then
                            QteX := 0;
                        NFalse := false;
                        if EmployeeAbsence.Unit = 0 then
                            EmployeeAbsence.Validate(Quantity, QteX)
                        else
                            EmployeeAbsence.Validate(Quantity, (QteX) *
                             (Regim."Work Hours per month" / Regim."Worked Day Per Month"));
                        if QteX <> 0 then
                            ValidateEmployeeAbsence(Transaction, EmployeeAbsence, seq);
                        Seq1 := seq;
                        Trans1 := Transaction;
                        if QteX <> 0 then begin
                            Seq1 := seq + 1;
                            Trans1 := Transaction + 1;
                        end;
                        QteX := CauseAbs."Nbre de J (auto. 1 Période)" - Abs(AbsEnreg."Quantity (Days)") - QteX;
                        if QteX < 0 then
                            QteX := 0;
                        if EmployeeAbsenceTmp.Unit = 0 then
                            EmployeeAbsenceTmp.Validate(Quantity, (QteX))
                        else
                            EmployeeAbsenceTmp.Validate(Quantity, (QteX) *
                                       (Regim."Work Hours per month" / Regim."Worked Day Per Month"));
                        CauseAbs.TestField("Code Cause 1 Période");
                        EmployeeAbsenceTmp.Validate("Cause of Absence Code", CauseAbs."Code Cause 1 Période");
                        if QteX <> 0 then begin
                            ValidateEmployeeAbsence(Trans1, EmployeeAbsenceTmp, Seq1);
                            Seq1 := Seq1 + 1;
                            Trans1 := Trans1 + 1;
                        end;
                        CauseAbs.TestField("Code Cause 2 Période");
                        EmployeeAbsenceTmp1.Validate("Cause of Absence Code", CauseAbs."Code Cause 2 Période");
                        EmployeeAbsenceTmp1.Validate(Quantity, (EmployeeAbsenceTmp1.Quantity -
                            EmployeeAbsence.Quantity - EmployeeAbsenceTmp.Quantity));
                        ValidateEmployeeAbsence(Trans1, EmployeeAbsenceTmp1, Seq1);
                    end
                    else begin
                        if (Abs(AbsEnreg."Quantity (Days)") + QteJ) <=
                            (CauseAbs."Nbre de J (auto. 1 Période)" + CauseAbs."Nbre de J (autorisée)"
                             + CauseAbs."Nbre de J (auto. 2 Période)" + CauseAbs."Nbre de J (auto. 3 Période)") then begin
                            EmployeeAbsenceTmp := EmployeeAbs;
                            EmployeeAbsenceTmp1 := EmployeeAbs;
                            EmployeeAbsenceTmp2 := EmployeeAbs;

                            QteX := CauseAbs."Nbre de J (autorisée)" - Abs(AbsEnreg."Quantity (Days)");
                            if QteX < 0 then
                                QteX := 0;
                            NFalse := false;
                            if EmployeeAbsence.Unit = 0 then
                                EmployeeAbsence.Validate(Quantity, QteX)
                            else
                                EmployeeAbsence.Validate(Quantity, (QteX) *
                                 (Regim."Work Hours per month" / Regim."Worked Day Per Month"));
                            if QteX <> 0 then
                                ValidateEmployeeAbsence(Transaction, EmployeeAbsence, seq);
                            Seq1 := seq;
                            Trans1 := Transaction;
                            if QteX <> 0 then begin
                                Seq1 := seq + 1;
                                Trans1 := Transaction + 1;
                            end;
                            QteX := CauseAbs."Nbre de J (auto. 1 Période)" - Abs(AbsEnreg."Quantity (Days)") - QteX;
                            if QteX < 0 then
                                QteX := 0;
                            if EmployeeAbsenceTmp.Unit = 0 then
                                EmployeeAbsenceTmp.Validate(Quantity, (QteX))
                            else
                                EmployeeAbsenceTmp.Validate(Quantity, (QteX) *
                                           (Regim."Work Hours per month" / Regim."Worked Day Per Month"));
                            CauseAbs.TestField("Code Cause 1 Période");
                            EmployeeAbsenceTmp.Validate("Cause of Absence Code", CauseAbs."Code Cause 1 Période");
                            if QteX <> 0 then begin
                                ValidateEmployeeAbsence(Trans1, EmployeeAbsenceTmp, Seq1);
                                Seq1 := Seq1 + 1;
                                Trans1 := Trans1 + 1;
                            end;
                            CauseAbs.TestField("Code Cause 2 Période");
                            EmployeeAbsenceTmp1.Validate("Cause of Absence Code", CauseAbs."Code Cause 2 Période");
                            QteX := CauseAbs."Nbre de J (auto. 2 Période)" - Abs(AbsEnreg."Quantity (Days)") - QteX;
                            if EmployeeAbsenceTmp1.Unit = 0 then
                                EmployeeAbsenceTmp1.Validate(Quantity, (QteX))
                            else
                                EmployeeAbsenceTmp1.Validate(Quantity, (QteX) *
                                (Regim."Work Hours per month" / Regim."Worked Day Per Month"));
                            if QteX <> 0 then begin
                                ValidateEmployeeAbsence(Trans1, EmployeeAbsenceTmp1, Seq1);
                                Seq1 := Seq1 + 1;
                                Trans1 := Trans1 + 1;
                            end;
                            CauseAbs.TestField("Code Cause 3 Période");
                            EmployeeAbsenceTmp2.Validate("Cause of Absence Code", CauseAbs."Code Cause 3 Période");
                            EmployeeAbsenceTmp2.Validate(Quantity, (EmployeeAbsenceTmp2.Quantity -
                                EmployeeAbsence.Quantity - EmployeeAbsenceTmp.Quantity - EmployeeAbsenceTmp1.Quantity));
                            ValidateEmployeeAbsence(Trans1, EmployeeAbsenceTmp2, Seq1);

                        end
                        else begin

                            QteX := CauseAbs."Nbre de J (autorisée)" - Abs(AbsEnreg."Quantity (Days)");
                            if QteX < 0 then
                                QteX := 0;
                            NFalse := false;
                            if EmployeeAbsence.Unit = 0 then
                                EmployeeAbsence.Validate(Quantity, QteX)
                            else
                                EmployeeAbsence.Validate(Quantity, (QteX) *
                                 (Regim."Work Hours per month" / Regim."Worked Day Per Month"));
                            if QteX <> 0 then
                                ValidateEmployeeAbsence(Transaction, EmployeeAbsence, seq)
                            else begin
                                EmployeeAbsence.Quantity := 0;
                                EmployeeAbsence.Delete;
                            end;
                            Seq1 := seq;
                            Trans1 := Transaction;
                            if QteX <> 0 then begin
                                Seq1 := seq + 1;
                                Trans1 := Transaction + 1;
                            end;
                            QteX := CauseAbs."Nbre de J (auto. 1 Période)" - Abs(AbsEnreg."Quantity (Days)") - QteX;
                            if QteX < 0 then
                                QteX := 0;
                            if CauseAbs."Nbre de J (auto. 1 Période)" <> 0 then begin
                                EmployeeAbsenceTmp := EmployeeAbs;

                                if EmployeeAbsenceTmp.Unit = 0 then
                                    EmployeeAbsenceTmp.Validate(Quantity, (QteX))
                                else
                                    EmployeeAbsenceTmp.Validate(Quantity, (QteX) *
                                               (Regim."Work Hours per month" / Regim."Worked Day Per Month"));

                                CauseAbs.TestField("Code Cause 1 Période");
                                EmployeeAbsenceTmp.Validate("Cause of Absence Code", CauseAbs."Code Cause 1 Période");

                                if QteX <> 0 then begin
                                    ValidateEmployeeAbsence(Trans1, EmployeeAbsenceTmp, Seq1);
                                    Seq1 := Seq1 + 1;
                                    Trans1 := Trans1 + 1;
                                end;
                            end;
                            if CauseAbs."Nbre de J (auto. 2 Période)" <> 0 then begin
                                EmployeeAbsenceTmp1 := EmployeeAbs;

                                CauseAbs.TestField("Code Cause 2 Période");
                                EmployeeAbsenceTmp1.Validate("Cause of Absence Code", CauseAbs."Code Cause 2 Période");

                                QteX := CauseAbs."Nbre de J (auto. 2 Période)" - Abs(AbsEnreg."Quantity (Days)") - QteX;
                                if QteX < 0 then
                                    QteX := 0;

                                if EmployeeAbsenceTmp1.Unit = 0 then
                                    EmployeeAbsenceTmp1.Validate(Quantity, (QteX))
                                else
                                    EmployeeAbsenceTmp1.Validate(Quantity, (QteX) *
                                    (Regim."Work Hours per month" / Regim."Worked Day Per Month"));
                                if QteX <> 0 then begin
                                    ValidateEmployeeAbsence(Trans1, EmployeeAbsenceTmp1, Seq1);
                                    Seq1 := Seq1 + 1;
                                    Trans1 := Trans1 + 1;
                                end;
                            end;
                            if CauseAbs."Nbre de J (auto. 3 Période)" <> 0 then begin
                                EmployeeAbsenceTmp2 := EmployeeAbs;

                                CauseAbs.TestField("Code Cause 3 Période");
                                EmployeeAbsenceTmp2.Validate("Cause of Absence Code", CauseAbs."Code Cause 3 Période");

                                if EmployeeAbsenceTmp2.Unit = 0 then
                                    QteX := EmployeeAbsenceTmp2.Quantity - Abs(AbsEnreg."Quantity (Days)") - QteX
                                else
                                    QteX := EmployeeAbsenceTmp2.Quantity - ((Abs(AbsEnreg."Quantity (Days)") - QteX) *
                                          (Regim."Work Hours per month" / Regim."Worked Day Per Month"));
                                if QteX < 0 then QteX := 0;

                                EmployeeAbsenceTmp2.Validate(Quantity, QteX);
                                if QteX <> 0 then begin
                                    ValidateEmployeeAbsence(Trans1, EmployeeAbsenceTmp2, Seq1);
                                    Seq1 := Seq1 + 1;
                                    Trans1 := Trans1 + 1;
                                end;
                            end;
                            EmployeeAbsenceTmp3 := EmployeeAbs;

                            NFalse := false;

                            HumanResSetup.TestField("Motif Abscence pour Dép.");
                            EmployeeAbsenceTmp3.Validate("Cause of Absence Code", HumanResSetup."Motif Abscence pour Dép.");
                            EmployeeAbsenceTmp3.Validate(Quantity, (EmployeeAbsenceTmp3.Quantity -
                                EmployeeAbsence.Quantity - EmployeeAbsenceTmp.Quantity - EmployeeAbsenceTmp1.Quantity -
                                EmployeeAbsenceTmp2.Quantity));
                            if EmployeeAbsenceTmp3.Quantity > 0 then
                                ValidateEmployeeAbsence(Trans1, EmployeeAbsenceTmp3, Seq1);
                        end;
                    end;
                end;
            end;
        end;
    end;


    procedure DevaliderAuto()
    var
        Abseng: Record "Employee's days off Entry";
    begin
    end;


    procedure CalcJourHeureAbs(Rec: Record "Employee Absence"; var Journ: Integer) Nbj: Decimal
    var
        T1: Record Date;
        CalendarMgmt: Codeunit "Calendar Management";
        NbreHJ: Decimal;
        NbH: Decimal;
        Hfin: Time;
        Hdeb: Time;
        Temps: Decimal;
        HeureDM: Time;
        HeureFM: Time;
        HeureDA: Time;
        HeureFA: Time;
        Nonworking: Boolean;
        NbreHJTmp: Decimal;
        Roul: Boolean;
        Tm: Decimal;
        TA: Decimal;
        JourFree: Boolean;
        Free: Boolean;
    begin
        with Rec do begin
            Journ := Unit;
            if (("From Date" <> "To Date") and (Unit = 1)) then
                Error('Unité Doit être Journée  ');
            Nbj := 0;
            NbH := 0;
            Free := false;
            if "From Date" <> "To Date" then begin
                T1.Reset;
                T1.SetFilter("Period Type", '%1', T1."period type"::Date);
                T1.SetFilter("Period Start", '%1..%2', "From Date", "To Date");
                if T1.Find('-') then
                    repeat
                        NbreHJ := 0;
                        NbreHJTmp := 0;
                        CalcHJour("Employee No.", T1."Period Start", HeureDM, HeureFM, HeureDA, HeureFA, Nonworking, Roul, JourFree);

                        if not Nonworking then
                            Free := false;

                        if JourFree then
                            Free := true;
                        NbreHJ := CalcTemp(HeureDM, HeureFM, HeureDA, HeureFA, JourFree);
                        if HeureDA = 0T then
                            Hdeb := HeureDM
                        else
                            Hdeb := HeureDA;
                        Hfin := CalcHfin(HeureFM, HeureFA);
                        Temps := 0;
                        // Date = Date Début
                        if "From Date" = T1."Period Start" then begin
                            if NbreHJ <> 0 then begin
                                if "Heure Debut" = 0T then
                                    Temps := NbreHJ
                                else
                                    Temps := calcheureMissjour("Employee No.", T1."Period Start", "Heure Debut", Hfin);
                                if NbreHJ <> 0 then
                                    Nbj := Nbj + ROUND(Temps / NbreHJ, 0.001);
                                NbH := NbH + Temps;
                            end;
                        end
                        else begin
                            // Date = Date Fin
                            if "To Date" = T1."Period Start" then begin
                                if "Heure Fin" = 0T then
                                    Temps := NbreHJ
                                else
                                    Temps := calcheureMissjour("Employee No.", T1."Period Start", Hdeb, "Heure Fin");
                                if NbreHJ <> 0 then
                                    Nbj := Nbj + ROUND(Temps / NbreHJ, 0.001);
                                NbH := NbH + Temps;
                                if NbreHJ = 0 then begin
                                    CalcHJour("Employee No.", (T1."Period Start" - 1), HeureDM, HeureFM, HeureDA, HeureFA, Nonworking, Roul, JourFree);

                                    NbreHJTmp := CalcTemp(HeureDM, HeureFM, HeureDA, HeureFA, JourFree);

                                    if NbreHJTmp = 0 then
                                        Nbj := Nbj - 1;
                                end;
                            end
                            // Date diff de Datedeb and Date Fin
                            else begin
                                if (JourFree = false) and (not Free) then
                                    Nbj := Nbj + 1;
                                if NbreHJ = 0 then begin
                                    CalcHJour("Employee No.", (T1."Period Start" - 1), HeureDM, HeureFM, HeureDA, HeureFA, Nonworking, Roul, JourFree);
                                    NbreHJTmp := CalcTemp(HeureDM, HeureFM, HeureDA, HeureFA, JourFree);
                                    if ((NbreHJTmp = 0) and (JourFree = false)) and (not Free) then
                                        Nbj := Nbj - 1;
                                end;
                            end;
                        end;
                    until T1.Next = 0;
            end
            // Même Jour
            else begin
                Temps := 0;
                NbreHJ := 0;
                CalcHJour("Employee No.", "From Date", HeureDM, HeureFM, HeureDA, HeureFA, Nonworking, Roul, JourFree);

                NbreHJ := CalcTemp(HeureDM, HeureFM, HeureDA, HeureFA, JourFree);

                Temps := calcheureMissjour("Employee No.", "From Date", "Heure Debut", "Heure Fin");
                if NbreHJ <> 0 then
                    Nbj := Nbj + ROUND(Temps / NbreHJ, 0.001);
                NbH := NbH + Temps;
            end;
            // Calcul Jour D'après

            Hfin := CalcHfin(HeureFM, HeureFA);
            NbreHJ := 0;
            CalcHJour("Employee No.", ("To Date" + 1), HeureDM, HeureFM, HeureDA, HeureFA, Nonworking, Roul, JourFree);

            NbreHJ := CalcTemp(HeureDM, HeureFM, HeureDA, HeureFA, JourFree);

            Temps := 0;
            if (NbreHJ = 0) and ((Hfin = "Heure Fin") or (("Heure Fin" = 0T) and (Unit = 0))) and (Roul = false) then begin
                if (not JourFree) and (not Free) then
                    Nbj := Nbj + 1;
                if (Journ = 1) and (("From Date" <> "To Date") or (Nbj > 1)) then
                    Journ := 0;
            end;
            if (Journ = 1) then
                Nbj := NbH;
        end;
    end;


    procedure CalcHJour(Nsal: Code[20]; DateM: Date; var HeureDM: Time; var HeureFM: Time; var HeureDA: Time; var HeureFA: Time; var Nonworking: Boolean; var Roul: Boolean; var JourFree: Boolean)
    var
        Sal: Record Employee;
        Cnt: Record "Employment Contract";
        Desc: Text[80];
        CalendarMgmt: Codeunit "Calendar Management";
    begin
        Clear(Cnt);
        Sal.Get(Nsal);
        Cnt.Get(Sal."Emplymt. Contract Code");

        HeureDM := 000000T;
        HeureFM := 000000T;
        HeureDA := 000000T;
        HeureFA := 000000T;
        Roul := false;
        begin
            // CalendarMgmt.CheckDateTime(Cnt."Code Calendar",DateM,HeureDM,HeureFM,HeureDA,HeureFA,Nonworking,JourFree);
        end;
        if Format(HeureDM) = '' then
            HeureDM := 000000T;
        if Format(HeureFM) = '' then
            HeureFM := 000000T;
        if Format(HeureDA) = '' then
            HeureDA := 000000T;
        if Format(HeureFA) = '' then
            HeureFA := 000000T;
    end;


    procedure CalcTemp(var HeureDM: Time; var HeureFM: Time; var HeureDA: Time; var HeureFA: Time; Jourfree: Boolean) TimeT: Decimal
    var
        Tm: Decimal;
        TA: Decimal;
    begin
        TimeT := 0;
        if not Jourfree then begin
            Tm := 0;
            TA := 0;
            if HeureFM < HeureDM then
                Tm := (((235959T - HeureDM) + (HeureFM - 000000T) + 1) / 3600000)
            else
                Tm := (HeureFM - HeureDM) / 3600000;
            if HeureFA < HeureDA then
                TA := (((235959T - HeureDA) + (HeureFA - 000000T) + 1) / 3600000)
            else
                TA := (HeureFA - HeureDA) / 3600000;
            TimeT := Tm + TA;
        end;
    end;


    procedure CalcHfin(HeureFM: Time; HeureFA: Time) Hfin: Time
    begin
        if HeureFA = 0T then
            Hfin := HeureFM
        else
            Hfin := HeureFA;
    end;


    procedure calctemptravailler(Employee: Code[20]; DateM: Date) HTravil: Decimal
    var
        HeureDM: Time;
        HeureFM: Time;
        HeureDA: Time;
        HeureFA: Time;
        Nonworking: Boolean;
        Roul: Boolean;
        JourFree: Boolean;
    begin
        HeureDM := 000000T;
        HeureFM := 000000T;
        HeureDA := 000000T;
        HeureFA := 000000T;
        HTravil := 0;
        Roul := false;
        CalcHJour(Employee, DateM, HeureDM, HeureFM, HeureDA, HeureFA, Nonworking, Roul, JourFree);
        HTravil := CalcTemp(HeureDM, HeureFM, HeureDA, HeureFA, JourFree);
    end;
    //GL3900
    /*
        procedure ValiderChantier(var Rec: Record "Saisie Chantier")
        var
            ChantEng: Record "Chantier Enreg.";
            ChantTmp: Record "Saisie Chantier";
            Ns: Integer;
            Ntrans: Integer;
            Wind: Dialog;
            i: Integer;
            abs: Record "Employee's days off Entry";
            Nab: Integer;
            NabTr: Integer;
        begin
            ChantEng.Reset;
            Ns := 0;
            Ntrans := 1;
            NabTr := 1;

            Nab := 0;
            abs.Reset;
            if abs.Find('+') then begin
                Nab := abs."Entry No.";
                NabTr := abs."Transaction No." + 1;
            end;
            if ChantEng.Find('+') then begin
                Ntrans := ChantEng."Transaction No." + 1;
                Ns := ChantEng.Sequence;
            end;
            ChantTmp.Reset;
            i := 0;
            ChantTmp.CopyFilters(Rec);
            if ChantTmp.Find('-') then begin
                Wind.Open('Valider Pointage Chantier                 \' +
                          ' Salarié #1############################## \' +
                          ' Chantier #2##########  Date #3########## \' +
                          ' Avancement :                             \' +
                          ' @4@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  ');
                repeat
                    i := i + 1;
                    Wind.Update(1, ChantTmp.Employee + ' ' + Rec.Name);
                    Wind.Update(2, ChantTmp.Chantier);
                    Wind.Update(3, ChantTmp.Date);
                    if ChantTmp.Count <> 0 then
                        Wind.Update(4, (ROUND(i / ChantTmp.Count, 0.01) * 10000));
                    EnregChantier(ChantTmp, Ns, Ntrans, Nab, NabTr);
                until ChantTmp.Next = 0;
                Wind.Close;
            end;
        end;


        procedure EnregChantier(Rec: Record "Saisie Chantier"; var Nseq: Integer; Trans: Integer; var Nabs: Integer; NabsTr: Integer)
        var
            ChantEng: Record "Chantier Enreg.";
            Chant: Record "Affectation Opération Bancaire";
            abs: Record "Employee's days off Entry";
            empl: Record Employee;
            Cnt: Record "Employment Contract";
            Regim: record "Regimes of work";
            ChantEngTmp: Record "Chantier Enreg.";
        begin
            with Rec do begin
                TestField(Chantier);
                TestField(Employee);
                TestField(Date);
                Clear(Chant);
                ChantEngTmp.Reset;
                ChantEngTmp.SetCurrentkey(Employee, year, month, "Jours du transport", Sequence);
                ChantEngTmp.SetFilter(Employee, Employee);
                ChantEngTmp.SetRange(month, month);
                ChantEngTmp.SetRange(year, year);
                if ChantEngTmp.Find('-') then;
                if not Chant.Get(Chantier) then
                    Error('Chantier N''existe Pas  !!! ');
                ;
                Chant.TestField(Blocked, false);
                R5218.Get;
                ChantEng.Init;
                Nseq := Nseq + 1;
                ChantEng.Sequence := Nseq;
                ChantEng.Date := Date;
                ChantEng.Chantier := Chantier;
                Clear(empl);
                if empl.Get(Employee) then;
                Clear(Cnt);
                Cnt.Get(empl."Emplymt. Contract Code");
                Clear(Regim);
                Regim.Get(Cnt."Regimes of work");

                ChantEng."Montant Repas" := Chant."Montnant Repas/ Jours";
                ChantEng.Employee := Employee;
                ChantEng."Transaction No." := Trans;
                ChantEng.month := month;
                ChantEng.year := year;
                ChantEng.Shift := Shift;
                ChantEng.Name := Name;
                ChantEng."Code Utilisateur" := UserId;
                ChantEng."Date Création" := Today;
                ChantEng."Jours du transport" := "Jours du transport";
                if not "Jours du transport" then begin
                    if R5218."Ind supp Chantier auto." then begin
                        if (ChantEngTmp.Count + 1) > Regim."Worked Day Per Month" then
                            ChantEng."a Payé" := true;
                    end else
                        ChantEng."a Payé" := Rec."Ind. Supp Chantier";
                end;
                if ChantEng.Insert then begin
                    if not Rec."Jours du transport" then begin
                        abs.Init;
                        Nabs := Nabs + 1;
                        abs."Entry No." := Nabs;
                        abs."Transaction No." := NabsTr;
                        abs."Employee No." := Rec.Employee;
                        abs."From Date" := Rec.Date;
                        abs."To Date" := Rec.Date;
                        abs.Description := Rec.Name;
                        abs.Quantity := 1;
                        abs."Posting month" := Rec.month;
                        abs."Posting year" := Rec.year;
                        abs."Line type" := 6;
                        abs."Quantity (Days)" := 1;
                        Clear(empl);
                        if empl.Get(Rec.Employee) then;
                        abs."Employee Posting Group" := empl."Employee Posting Group";
                        abs."Global dimension 1" := empl."Global Dimension 1 Code";
                        abs."Global dimension 2" := empl."Global Dimension 2 Code";
                        abs."Date Validité" := CalcDate(R5218."Validité Recuperation", Rec.Date);
                        abs."N° seq Chantier" := Nseq;
                        abs."Jours trans" := Rec."Jours du transport";
                        abs.Insert;
                    end;
                    Delete;
                end;
            end;
        end;


        procedure DevValiderChantier(var Rec: Record "Chantier Enreg.")
        var
            ChantEng: Record "Saisie Chantier";
            ChantTmp: Record "Chantier Enreg.";
            Ns: Integer;
            Ntrans: Integer;
            Wind: Dialog;
            i: Integer;
        begin
            ChantEng.Reset;
            Ns := 0;

            if ChantEng.Find('+') then begin

                Ns := ChantEng.Sequence;
            end;
            ChantTmp.Reset;
            i := 0;
            ChantTmp.CopyFilters(Rec);
            ChantTmp.SetFilter("Paie No.", '=''''');
            if ChantTmp.Find('-') then begin
                Wind.Open('Valider Pointage Chantier                 \' +
                          ' Salarié #1############################## \' +
                          ' Chantier #2##########  Date #3########## \' +
                          ' Avancement :                             \' +
                          ' @4@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  ');
                repeat
                    i := i + 1;
                    Wind.Update(1, ChantTmp.Employee + ' ' + Rec.Name);
                    Wind.Update(2, ChantTmp.Chantier);
                    Wind.Update(3, ChantTmp.Date);
                    if ChantTmp.Count <> 0 then
                        Wind.Update(4, (ROUND(i / ChantTmp.Count, 0.01) * 10000));
                    annlChantier(ChantTmp, Ns);
                until ChantTmp.Next = 0;
                Wind.Close;
            end;
        end;


        procedure annlChantier(Rec: Record "Chantier Enreg."; var Nseq: Integer)
        var
            ChantEng: Record "Saisie Chantier";
            Chant: Record "Affectation Opération Bancaire";
            abs: Record "Employee's days off Entry";
        begin
            with Rec do begin

                TestField(Chantier);
                TestField(Employee);
                TestField(Date);
                Clear(Chant);
                if not Chant.Get(Chantier) then
                    Error('Chantier N''existe Pas  !!! ');
                ;
                Chant.TestField(Blocked, false);
                ChantEng.Init;
                Nseq := Nseq + 1;
                ChantEng.Sequence := Nseq;
                ChantEng.Date := Date;
                ChantEng.Chantier := Chantier;
                ChantEng.Employee := Employee;
                ChantEng.month := month;
                ChantEng.year := year;
                ChantEng.Shift := Shift;
                ChantEng.Name := Name;
                if ChantEng.Insert then begin
                    abs.Reset;
                    abs.SetCurrentkey("N° seq Chantier", "Entry No.");
                    abs.SetRange("N° seq Chantier", Rec.Sequence);
                    abs.DeleteAll;
                    Delete;
                end;
            end;
        end;

    */
    //GL3900
    procedure "AttribuerDroitCongéAncienneté"(Transaction: Integer; SalaryLine: Record "Salary Lines"; Sequence: Integer; var "Jourcongé": Decimal)
    var
        DaysOffEntry: Record "Employee's days off Entry";
        Temp: Decimal;
        SalaryHeader: Record "Salary Headers";
        EmploymentContract: Record "Employment Contract";
        RegimeWork: record "Regimes of work";
        txtStd: label 'Day off attributed :';
        Slr: Record Employee;
        HeureTravail: Record "Heures occa. enreg. m";
    begin
        Temp := 0;
        Jourcongé := 0;
        if SalaryHeader.Get(SalaryLine."No.") then begin
            if EmploymentContract.Get(SalaryLine."Emplymt. Contract Code") then begin
                if RegimeWork.Get(SalaryLine."Employee Regime of work") then begin
                    Slr.Reset;
                    Slr.Get(SalaryLine.Employee);
                    if SalaryLine."Droit de congé ancienneté" > 0 then begin

                        DaysOffEntry.Reset;
                        DaysOffEntry.Init;
                        DaysOffEntry."Transaction No." := Transaction;
                        // IF DaysOffEntry.FIND('+')then
                        DaysOffEntry."Entry No." := Sequence;
                        DaysOffEntry."Employee No." := SalaryLine.Employee;
                        DaysOffEntry."From Date" := 0D;
                        DaysOffEntry."To Date" := 0D;
                        DaysOffEntry."Cause of Absence Code" := '';
                        DaysOffEntry.Description := 'AUTO --> ' + txtStd + ' ' + Format(WorkDate);
                        DaysOffEntry.Unit := 0;
                        DaysOffEntry."Impute on days off" := false;
                        DaysOffEntry."Posting month" := SalaryLine.Month;
                        DaysOffEntry."Posting year" := SalaryLine.Year;
                        DaysOffEntry."Line type" := 1;
                        //MBY 20/01/2009
                        DaysOffEntry.Quantity := ROUND(SalaryLine."Droit de congé ancienneté", 0.001);
                        DaysOffEntry."Quantity (Days)" := ROUND(SalaryLine."Droit de congé ancienneté", 0.001);
                        //END MBY 20/01/2009
                        DaysOffEntry."Quantity (Hours)" := ROUND(SalaryLine."Droit de congé ancienneté" *
                                                               RegimeWork."From Work day to Work hour", 0.001);
                        DaysOffEntry."Employee Posting Group" := SalaryLine."Employee Posting Group";
                        DaysOffEntry."Global dimension 1" := SalaryLine."Global Dimension 1";
                        DaysOffEntry."Global dimension 2" := SalaryLine."Global Dimension 2";
                        //mby 11/02/2010
                        DaysOffEntry.direction := Slr.Direction;
                        DaysOffEntry.service := Slr.Service;
                        DaysOffEntry.section := Slr.Section;
                        //mby 11/02/2010
                        DaysOffEntry."Payment No." := SalaryLine."No.";
                        DaysOffEntry."User ID" := UserId;
                        DaysOffEntry."Last Date Modified" := WorkDate;

                        if DaysOffEntry.Insert then
                            Jourcongé := DaysOffEntry."Quantity (Days)";
                    end;
                end;
            end;
        end;
    end;


    procedure InsertDetailConge(var RecAbsence: Record "Employee's days off Entry")
    var
        Empl: Record Employee;
        NonPayed1: array[3] of Decimal;
        DroitCong1: array[3] of Decimal;
        ConSCong1: array[3] of Decimal;
        SoldeCong1: array[3] of Decimal;
        RecDetailConge: Record "Detail de congé consommé";
        DecResteCons: Decimal;
        i: Integer;
        DroitA1: Decimal;
        DroitA2: Decimal;
        DroitA3: Decimal;
        ConsValide: Decimal;
    begin
        // exit;
        //Insertion detail  consommation conge
        //
        if Empl.Get(RecAbsence."Employee No.") then begin

            Empl.SetFilter("Filtre Année", '%1', Date2dmy(WorkDate, 3) - 2);
            Empl.CalcFields("Non paid days", "Days off -", "Days off +", "Days off =");
            for i := 1 to 3 do begin
                NonPayed1[i] := 0;
                DroitCong1[i] := 0;
                ConSCong1[i] := 0;
                SoldeCong1[i] := 0;
            end;

            DroitCong1[1] := Empl."Days off =";
            Empl.SetFilter("Filtre Année", '%1', Date2dmy(WorkDate, 3) - 2);
            Empl.CalcFields("Non paid days", "Days off -", "Days off +", "Days off =");

            RecDetailConge.Reset;
            RecDetailConge.SetRange(Salarié, RecAbsence."Employee No.");
            RecDetailConge.SetRange(RecDetailConge."Annee de Consommation", Date2dmy(WorkDate, 3) - 2);
            RecDetailConge.CalcSums(RecDetailConge."Nbre consommé");

            NonPayed1[1] := Empl."Non paid days";
            DroitCong1[1] := Empl."Days off +";
            ConSCong1[1] := RecDetailConge."Nbre consommé";
            SoldeCong1[1] := Empl."Days off =";
            DroitA1 := DroitCong1[1] - ConSCong1[1];

            DroitCong1[2] := Empl."Days off =";
            Empl.SetFilter("Filtre Année", '%1', Date2dmy(WorkDate, 3) - 1);
            Empl.CalcFields("Non paid days", "Days off -", "Days off +", "Days off =");
            RecDetailConge.Reset;
            RecDetailConge.SetRange(Salarié, RecAbsence."Employee No.");
            RecDetailConge.SetRange(RecDetailConge."Annee de Consommation", Date2dmy(WorkDate, 3) - 1);
            RecDetailConge.CalcSums(RecDetailConge."Nbre consommé");

            NonPayed1[2] := Empl."Non paid days";
            DroitCong1[2] := Empl."Days off +";
            ConSCong1[2] := RecDetailConge."Nbre consommé";
            SoldeCong1[2] := Empl."Days off =";
            DroitA2 := DroitCong1[2] - ConSCong1[2];

            DroitCong1[3] := Empl."Days off =";
            Empl.SetFilter("Filtre Année", '%1', Date2dmy(WorkDate, 3));
            Empl.CalcFields("Non paid days", "Days off -", "Days off +", "Days off =");

            RecDetailConge.Reset;
            RecDetailConge.SetRange(Salarié, RecAbsence."Employee No.");
            RecDetailConge.SetRange(RecDetailConge."Annee de Consommation", Date2dmy(WorkDate, 3));
            RecDetailConge.CalcSums(RecDetailConge."Nbre consommé");

            NonPayed1[3] := Empl."Non paid days";
            DroitCong1[3] := Empl."Days off +";
            ConSCong1[3] := RecDetailConge."Nbre consommé";
            SoldeCong1[3] := Empl."Days off =";
            DroitA3 := DroitCong1[3] - ConSCong1[3];

            RecDetailConge.Reset;
            RecDetailConge.SetRange(Salarié, RecAbsence."Employee No.");
            //RecDetailConge.DELETEALL;
            ConsValide := 0;

            //deb Solde annee-2
            if DroitA1 > 0 then
                if DroitA1 >= RecAbsence.Quantity then begin
                    RecDetailConge."N°Sequence" := RecAbsence."Entry No.";
                    RecDetailConge.Salarié := Empl."No.";
                    RecDetailConge."Annee de Consommation" := Date2dmy(WorkDate, 3) - 2;
                    RecDetailConge."Nbre consommé" := Abs(RecAbsence.Quantity);
                    ConsValide := RecDetailConge."Nbre consommé";
                    RecDetailConge.INSERT;
                end
                else begin
                    RecDetailConge."N°Sequence" := RecAbsence."Entry No.";
                    RecDetailConge.Salarié := Empl."No.";
                    RecDetailConge."Annee de Consommation" := Date2dmy(WorkDate, 3) - 2;
                    RecDetailConge."Nbre consommé" := Abs(RecAbsence.Quantity - DroitA1);
                    ConsValide := RecDetailConge."Nbre consommé";
                    RecDetailConge.INSERT;
                end;
            //fin Solde annee-2

            //deb Solde annee-1
            if (DroitA2 > 0) and (ConsValide <> RecAbsence.Quantity) then
                if DroitA2 >= (RecAbsence.Quantity - ConsValide) then begin
                    RecDetailConge."N°Sequence" := RecAbsence."Entry No.";
                    RecDetailConge.Salarié := Empl."No.";
                    RecDetailConge."Annee de Consommation" := Date2dmy(WorkDate, 3) - 1;
                    RecDetailConge."Nbre consommé" := Abs(RecAbsence.Quantity - ConsValide);
                    ConsValide := ConsValide + RecDetailConge."Nbre consommé";
                    RecDetailConge.INSERT;
                end
                else begin
                    RecDetailConge."N°Sequence" := RecAbsence."Entry No.";
                    RecDetailConge.Salarié := Empl."No.";
                    RecDetailConge."Annee de Consommation" := Date2dmy(WorkDate, 3) - 1;
                    RecDetailConge."Nbre consommé" := Abs(RecAbsence.Quantity - ConsValide - DroitA2);
                    ConsValide := ConsValide + RecDetailConge."Nbre consommé";
                    RecDetailConge.INSERT;
                end;
            //fin Solde annee-2

            //deb Solde annee en cours
            if (DroitA3 > 0) and (ConsValide <> RecAbsence.Quantity) then
                if DroitA3 >= (RecAbsence.Quantity - ConsValide) then begin
                    RecDetailConge."N°Sequence" := RecAbsence."Entry No.";
                    RecDetailConge.Salarié := Empl."No.";
                    RecDetailConge."Annee de Consommation" := Date2dmy(WorkDate, 3);
                    RecDetailConge."Nbre consommé" := Abs(RecAbsence.Quantity - ConsValide);
                    ConsValide := ConsValide + RecDetailConge."Nbre consommé";
                    RecDetailConge.INSERT;
                end;
        end;
        /*  Else
          begin
              RecDetailConge."N°Sequence":=RecAbsence."Entry No.";
              RecDetailConge.Salarié:=Empl."No.";
              RecDetailConge."Annee de Consommation":=DATE2DMY(WORKDATE,3);
              RecDetailConge."Nbre consommé":=RecAbsence.Quantity-ConsValide-droitA2;
              ConsValide := ConsValide+RecDetailConge."Nbre consommé";
              RecDetailConge.INSERT;
          end;*/
        //fin Solde annee en cours
        //---------------------------------------------------------------
        //fin

    end;
}

