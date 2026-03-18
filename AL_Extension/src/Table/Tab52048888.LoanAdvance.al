Table 52048888 "Loan & Advance"
{//GL2024  ID dans Nav 2009 : "39001412"
    Caption = 'Loan & Advance';
    DataCaptionFields = Employee;
    // DrillDownPageID = "Loan & Advance List";
    // LookupPageID = "Loan & Advance List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'N°';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HumanResSetup.Get;
                    NoSeriesMgt.TestManual(HumanResSetup."Loan & Advance Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Employee; Code[10])
        {
            Caption = 'Salarié';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                recLoanadvance.Reset;
                recLoanadvance.SetRange(Employee, Employee);
                Slr.Get(Employee);
                Name := Slr."First Name" + ' ' + Slr."Last Name";
                if RecQualification.Get(Slr."Qualification Code") then
                    "Job Title" := RecQualification.Description;
                "Employee Posting Group" := Slr."Employee Posting Group";
                "Employee Statistic Group" := Slr."Statistics Group Code";
                "Type Salarié" := Slr."Employee's type";
                //direction  :=Slr.Direction;
                service := Slr."Service";
                section := Slr.Section;
                "Global dimension 1" := Slr."Global Dimension 1 Code";
                "Global dimension 2" := Slr."Global Dimension 2 Code";
                LoanAdvanceType.Reset;
                LoanAdvanceType.SetRange(Type, Type);
                LoanAdvanceType.SetRange("Type par déf", true);
                if LoanAdvanceType.Find('-') then
                    Validate("Document type", LoanAdvanceType.Code);
            end;
        }
        field(3; Name; Text[60])
        {
            Caption = 'Nom';
            Editable = false;
        }
        field(4; "Job Title"; Text[50])
        {
            Caption = 'Fonction';
            Editable = false;
        }
        field(5; "Employee Posting Group"; Code[10])
        {
            Caption = 'Groupe compta. salarié';
            Editable = false;
            TableRelation = "Employee Posting Group2";
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Avance,Prêt';
            OptionMembers = Advance,Loan;
        }
        field(7; "Document type"; Code[10])
        {
            Caption = 'Type document ';
            TableRelation = "Loan & Advance Type" where(Type = field(Type));

            trigger OnValidate()
            begin
                if LoanAdvanceType.Get("Document type") then begin
                    "Repayment slices" := LoanAdvanceType."Repayment slices";
                    if "Repayment slices" = 0 then
                        Validate("Repayment slices", 1);
                    "Bal. Account Type" := LoanAdvanceType."Bal. Account Type";
                    "Bal. Account No." := LoanAdvanceType."Bal. Account No.";
                    "type amortissement" := LoanAdvanceType."type amortissement";
                    "Avance Sur Prime" := LoanAdvanceType."Avance sur Prime";
                    "Interest %" := LoanAdvanceType."Interest %";
                    "Avance Aid" := LoanAdvanceType."Avance Aid";
                    "Precision Arrondi Principale" := LoanAdvanceType."Precision Arrondi Principale";
                    "affectation Diff Arrondi" := LoanAdvanceType."affectation Diff Arrondi";
                    "Avance Repas" := LoanAdvanceType."Avance Repas";
                    "Type reglement" := LoanAdvanceType."Type reglement";
                    "Avance sur congé" := LoanAdvanceType."Avance sur congé";
                end;
            end;
        }
        field(10; Amount; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Montant';

            trigger OnValidate()
            var
                PramRessHum: Record "Human Resources Setup";
                empl: Record Employee;
                TEXT01: label 'Vous avez dépassé la limite de prêt avance autorisé ';
                TypePretAvance: Record "Loan & Advance Type";
                EntetAvancePret: Record "Loan & Advance Header";
                MontantTranche: Decimal;
            begin
                "Total to repay" := Amount;
                "Interest %" := 0;

                //>> DSFT AGA 07 03 10
                PramRessHum.Get();
                empl.Get(Employee);
                empl.CalcFields("Indemnité imposable");
                TypePretAvance.Get("Document type");
                EntetAvancePret.Reset;
                EntetAvancePret.SetRange(Employee, Employee);
                EntetAvancePret.SetRange(Status, 0);
                if EntetAvancePret.Find('-') then
                    repeat
                        MontantTranche := MontantTranche + EntetAvancePret."Montant tranche";
                    until EntetAvancePret.Next = 0;

                if TypePretAvance.Type = 0 then begin
                    if PramRessHum."Mode limite avance prêt" = 0 then begin
                        if (Amount + MontantTranche) > ((PramRessHum.Valeur * (empl."Indemnité imposable" + empl."Reel Basis salary")) / 100) then
                            Error(TEXT01);
                    end else begin
                        if (Amount + MontantTranche) > PramRessHum.Valeur then
                            Error(TEXT01);
                    end;
                end;
                //<<DSFT AGA 07 03 10
                "Montant tranche" := "Total to repay";
                Validate("Interest %");
            end;
        }
        field(11; "Interest %"; Decimal)
        {
            Caption = '% d''Interêt';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                "Total to repay" := Amount + CalcMntInetret("Date d'effet", "Date fin Prêt");

                if "Repayment slices" > 0 then
                    "Montant tranche" := ROUND("Total to repay" / "Repayment slices", 1)
                else
                    "Montant tranche" := "Total to repay";
            end;
        }
        field(12; "Total to repay"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Total à rembourser';
            Editable = false;
            InitValue = 0;
        }
        field(15; "Repayment slices"; Integer)
        {
            Caption = 'Tranches de remboursement';

            trigger OnValidate()
            var
                DateT: Date;
                PramRessHum: Record "Human Resources Setup";
                empl: Record Employee;
                TypePretAvance: Record "Loan & Advance Type";
                TEXT01: label 'Vous avez dépassé la limite de prêt avance autorisé ';
            begin
                HumanResSetup.Get();
                if HumanResSetup."Type Calcul prêt" = 0 then begin
                    if "Repayment slices" <= 0 then
                        Error('Tranches de Remboursement doivent être > 0 ');
                    if "Date d'effet" <> 0D then begin
                        DateT := "Date d'effet";
                        "Date fin Prêt" := CalcDate(StrSubstNo('+%1M', "Repayment slices" - 1), DateT);
                        "Total to repay" := Amount + CalcMntInetret("Date d'effet", "Date fin Prêt");

                        if "Repayment slices" > 0 then
                            "Montant tranche" := "Total to repay" / "Repayment slices"
                        else
                            "Montant tranche" := "Total to repay";
                    end;
                end;
                // AGA 07 03 10

                PramRessHum.Get();
                empl.Get(Employee);
                empl.CalcFields("Indemnité imposable");
                TypePretAvance.Get("Document type");
                if TypePretAvance.Type = 0 then begin
                    if PramRessHum."Mode limite avance prêt" = 0 then begin
                        if "Montant tranche" > ((PramRessHum.Valeur * (empl."Indemnité imposable" + empl."Reel Basis salary")) / 100) then
                            Error(TEXT01);
                    end else begin
                        if "Montant tranche" > PramRessHum.Valeur then
                            Error(TEXT01);
                    end;
                end;
                //<<AGA
            end;
        }
        field(20; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(30; "Global dimension 1"; Code[20])
        {
            Caption = 'Code département';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(31; "Global dimension 2"; Code[20])
        {
            Caption = 'Code dossier';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(110; "Avance Sur Prime"; Boolean)
        {
        }
        field(50000; "Avance sur congé"; Boolean)
        {
        }
        /*  field(50001; "Type Pret"; Option)
          {
              OptionMembers = " ",Logement,Voiture,Cession;
          }
          field(50002; "Generer Par Caisse"; Boolean)
          {
              Description = 'HJ SORO 12-04-2017';
          }*/
        field(50200; "Montant tranche"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            caption = 'Montant tranche';

            trigger OnValidate()
            begin
                HumanResSetup.Get();
                if HumanResSetup."Type Calcul prêt" = 0 then begin
                    if ("Total to repay" MOD "Montant tranche") > 0
                     then
                        Validate("Repayment slices", ("Total to repay" DIV "Montant tranche") + 1)
                    else
                        Validate("Repayment slices", "Total to repay" / "Montant tranche");
                end;
            end;
        }
        field(50300; "Date Deblocage"; Date)
        {
        }
        field(50400; "Date Comptabilisation"; Date)
        {
        }
        field(50500; "Date d'effet"; Date)
        {

            trigger OnValidate()
            begin
                if ("Date fin Prêt" < "Date d'effet") or ("Date fin Prêt" = 0D) then
                    "Date fin Prêt" := CalcDate('+FM', "Date d'effet");
                if ("Date Deblocage" = 0D) or (Type = Type::Advance) then
                    "Date Deblocage" := "Date d'effet";

                Validate("Interest %");
                "Repayment slices" := CalcNbreMois;
            end;
        }
        field(50501; "Date fin Prêt"; Date)
        {

            trigger OnValidate()
            begin
                if "Date fin Prêt" < "Date d'effet" then
                    Error('Date Fin Prêt Doit être > Date Effet');
                "Repayment slices" := CalcNbreMois;
                Validate("Interest %");
            end;
        }
        field(50505; "N° document Extr."; Code[20])
        {
            caption = 'N° document Extr.';
        }
        field(8099198; "User ID"; Code[20])
        {
            Editable = false;
            TableRelation = User;
        }
        field(8099199; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(39001420; "Montant H Travail"; Decimal)
        {
            AutoFormatType = 2;
            Editable = false;
        }
        field(39001432; "Bal. Account Type"; Option)
        {
            Caption = 'Type compte contrepartie';
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(39001433; "Bal. Account No."; Text[20])
        {
            Caption = 'N° compte contrepartie';
            TableRelation = if ("Bal. Account Type" = filter("G/L Account")) "G/L Account"
            else
            if ("Bal. Account Type" = filter("Bank Account")) "Bank Account" where("Currency Code" = filter(''));
        }
        field(39001450; "type amortissement"; Option)
        {
            OptionCaption = 'Dégressif,Lineaire,Constant';
            OptionMembers = "Dégressif",Lineaire,Constant;

            trigger OnValidate()
            begin
                "Total to repay" := Amount + CalcMntInetret("Date d'effet", "Date fin Prêt");

                if "Repayment slices" > 0 then
                    "Montant tranche" := "Total to repay" / "Repayment slices"
                else
                    "Montant tranche" := "Total to repay";
            end;
        }
        field(39001451; "Heure Travailé"; Decimal)
        {
            Editable = false;
            caption = 'Heure Travailé';
        }
        field(39001452; "Montant H sup"; Decimal)
        {
            AutoFormatType = 2;
            Editable = false;
        }
        field(39001453; "Salaire de Base"; Decimal)
        {
            AutoFormatType = 2;
            Editable = false;
        }
        field(39001454; "jour Absence"; Decimal)
        {
            Editable = false;
        }
        field(39001455; "Type Salarié"; Option)
        {
            OptionMembers = "Base Horaire","Base mensuel";
        }
        field(39001460; "Total Avance Mois"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Loan & Advance Header".Amount where(Employee = field(Employee),
                                                                    "Date Comptabilisation" = field("Filtre Date"),
                                                                    Type = field(Type)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(39001461; "Filtre Date"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(39001470; "Avance Aid"; Boolean)
        {
        }
        field(39001490; "Precision Arrondi Principale"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(39001491; "affectation Diff Arrondi"; Option)
        {
            OptionCaption = 'debut,Fin';
            OptionMembers = debut,Fin;
        }
        field(39001495; "Avance Repas"; Boolean)
        {
        }
        field(39001496; "Type reglement"; Text[30])
        {
            caption = 'N° Bon Caisse';
            TableRelation = "Payment Class"/*GL2024 WHERE(Suggestions = CONST(3))*/;
        }
        field(39001497; "Employee Statistic Group"; Code[10])
        {
            Caption = 'Employee Posting Group';
            Editable = false;
            TableRelation = "Employee Statistics Group";
        }
        field(39001498; direction; Code[10])
        {
        }
        field(39001499; service; Code[10])
        {
        }
        field(39001500; section; Code[10])
        {
        }
    }

    keys
    {
        key(STG_Key1; "No.")
        {
            Clustered = true;
        }
        key(STG_Key2; Employee)
        {
        }
        key(STG_Key3; Type)
        {
        }
        key(STG_Key4; "Document type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            HumanResSetup.Get;
            HumanResSetup.TestField("Loan & Advance Nos.");
            NoSeriesMgt.InitSeries(HumanResSetup."Loan & Advance Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        //"Repayment slices"   := 1;
        "type amortissement" := 2;
        "Last Date Modified" := WorkDate;
        "User ID" := UserId;
        //"Date d'effet":=WORKDATE;
        //"Date fin Prêt":=CALCDATE('+FM',WORKDATE);
        "Date Comptabilisation" := WorkDate;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := WorkDate;
        "User ID" := UserId;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := WorkDate;
        "User ID" := UserId;
    end;

    var
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit 396;
        LoanAdvance: Record "Loan & Advance";
        LoanAdvanceType: Record "Loan & Advance Type";
        Slr: Record Employee;
        err1: label 'Error\Document type dosen''t much with the Employee Posting Group.';
        err2: label 'Error\Unknown document type';
        recLoanadvance: Record "Loan & Advance";
        mess1: label 'Attention l''employé %1 a un saisie non validé';
        MntRetenue: Decimal;
        RecQualification: Record Qualification;


    procedure AssistEdit(Old: Record "Loan & Advance"): Boolean
    begin
        with LoanAdvance do begin
            LoanAdvance := Rec;
            HumanResSetup.Get;
            HumanResSetup.TestField("Loan & Advance Nos.");
            if NoSeriesMgt.SelectSeries(HumanResSetup."Loan & Advance Nos.", Old."No. Series", "No. Series") then begin
                HumanResSetup.Get;
                HumanResSetup.TestField("Loan & Advance Nos.");
                NoSeriesMgt.SetSeries("No.");
                Rec := LoanAdvance;
                exit(true);
            end;
        end;
    end;


    procedure "CalcPrêtLongetCourtTerme"(var CourtT: Decimal; var LongT: Decimal)
    var
        Datedeb: Date;
        DateFin: Date;
        NbrMois: Decimal;
        NBcrt: Decimal;
        Datecpta: Date;
        MntRest: Decimal;
        Mnt: Decimal;
        Mnt1: Decimal;
    begin
        Datedeb := "Date d'effet";
        DateFin := "Date fin Prêt";

        if Date2dmy("Date d'effet", 3) = Date2dmy("Date Comptabilisation", 3) then
            Datecpta := "Date d'effet"
        else
            Datecpta := "Date Comptabilisation";
        CourtT := 0;
        MntRest := Amount;
        case Type of
            0:
                begin
                    CourtT := Amount;
                    LongT := 0;
                end;
            1:
                begin
                    if Datedeb > CalcDate('FA', Datecpta) then begin
                        LongT := Amount;
                        CourtT := 0;
                    end else
                        if DateFin <= CalcDate('FA', Datecpta) then begin
                            CourtT := Amount;
                            LongT := 0;
                        end
                        else begin
                            NbrMois := 0;

                            repeat
                                NbrMois := NbrMois + 1;
                            //  UNTIL CALCDATE(STRSUBSTNO('+%1M+FM',NbrMois),Datedeb)> DateFin ;
                            until CalcDate(StrSubstNo('+%1M', NbrMois), Datedeb) > DateFin;

                            // Amortissement Dégrissif
                            case "type amortissement" of
                                //IF "type amortissement"=0 THEN BEGIN
                                0:
                                    begin
                                        NBcrt := 0;
                                        repeat
                                            if NbrMois <> 0 then begin
                                                CourtT := CourtT + ROUND(MntRest / (NbrMois - NBcrt), 1);
                                                MntRest := MntRest - ROUND(MntRest / (NbrMois - NBcrt), 1);
                                            end;
                                            NBcrt := NBcrt + 1;
                                        until CalcDate(StrSubstNo('+%1M', NBcrt), Datedeb) > CalcDate('FA', Datecpta);

                                        if NbrMois <> 0 then begin
                                            //CourtT:=ROUND((NBcrt/NbrMois)*Amount,0.001);
                                            LongT := Amount - CourtT;
                                        end;
                                    end;
                                // ELSE
                                1:
                                    // Amortissement Linéaire
                                    begin
                                        NBcrt := 0;
                                        repeat
                                            if NbrMois <> 0 then
                                                NBcrt := NBcrt + 1;
                                        // UNTIL CALCDATE(STRSUBSTNO('+%1M+FM',NBcrt),Datedeb)> CALCDATE('FA',Datecpta) ;
                                        until CalcDate(StrSubstNo('+%1M', NBcrt), Datedeb) > CalcDate('FA', Datecpta);

                                        Mnt := 0;
                                        Mnt1 := 0;
                                        if NbrMois <> 0 then
                                            Mnt := ROUND(Amount / NbrMois, 1);
                                        if NbrMois - 1 <> 0 then Mnt1 := Amount - (Mnt * (NbrMois - 1));
                                        if "affectation Diff Arrondi" = 0 then
                                            CourtT := ROUND(Mnt1 + ((NBcrt - 1) * Mnt), 1)
                                        else
                                            CourtT := ROUND((NBcrt * Mnt), 1);

                                        LongT := Amount - CourtT;
                                    end;
                                // Amortissement Constant
                                2:
                                    begin
                                        NBcrt := 0;
                                        repeat
                                            if NbrMois <> 0 then
                                                NBcrt := NBcrt + 1;
                                        //  UNTIL CALCDATE(STRSUBSTNO('+%1M+FM',NBcrt),Datedeb)> CALCDATE('FA',Datecpta) ;
                                        until CalcDate(StrSubstNo('+%1M', NBcrt), Datedeb) > CalcDate('FA', Datecpta);

                                        Mnt := 0;
                                        Mnt1 := 0;
                                        if NbrMois <> 0 then
                                            Mnt := ROUND(Amount / NbrMois, 1);
                                        Mnt1 := Amount - (Mnt * (NbrMois - 1));
                                        CourtT := ROUND(Mnt1 + ((NBcrt - 1) * Mnt), 1);
                                        LongT := Amount - CourtT;
                                    end;
                            // Fin Amortissement
                            end;
                        end;
                end;
        end;
    end;


    procedure CalcMntInetret(DateDebT: Date; DateFinT: Date) MntRet: Decimal
    var
        MontiniT: Decimal;
        DateDeb: Date;
        DateFin: Date;
        NbrMois: Decimal;
        j: Integer;
        DateJ: Date;
        Mnt: Decimal;
        Mnt1: Decimal;
    begin
        if LoanAdvanceType.Get("Document type") then
            "Precision Arrondi Principale" := LoanAdvanceType."Precision Arrondi Principale";

        MontiniT := Amount;
        DateDeb := "Date d'effet";
        DateFin := "Date fin Prêt";
        NbrMois := 0;
        repeat
            NbrMois := NbrMois + 1;
        until CalcDate(StrSubstNo('+%1M', NbrMois), DateDeb) > DateFin;

        MntRet := 0;
        if (DateDebT = 0D) or (DateFinT = 0D) or (DateFinT < "Date d'effet") or (DateDebT > "Date fin Prêt")
           or ("Date d'effet" = "Date fin Prêt") then
            exit;
        DateDebT := DateDebT;
        DateFinT := DateFinT;
        DateJ := DateDeb;
        // Amortissement Dégrissif
        case "type amortissement" of
            0:
                begin
                    j := -1;
                    repeat
                        j := j + 1;
                        if DateDebT <= CalcDate(StrSubstNo('+%1M', j), DateDeb) then
                            if CalcDate('+1J', "Date d'effet") >= CalcDate(StrSubstNo('+%1M', j), DateDeb) then
                                MntRet := MntRet + ROUND(((MontiniT * "Interest %" * (CalcDate(StrSubstNo('+%1M', j), DateDeb) -
                                          "Date Deblocage" + 1)) / 36000), 1)
                            else
                                MntRet := MntRet + ROUND(((MontiniT * "Interest %" * (CalcDate(StrSubstNo('+%1M', j), DateDeb) -
                                          CalcDate(StrSubstNo('+%1M', j - 1), DateDeb))) / 36000), 1);

                        if (NbrMois - j) <> 0 then
                            MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), "Precision Arrondi Principale");

                    until (DateFinT <= CalcDate(StrSubstNo('+%1M', j), DateDeb)) or
                          (DateFin <= CalcDate(StrSubstNo('+%1M', j), DateDeb));
                end;
            // Amortissement Linéaire
            1:
                begin
                    j := -1;
                    repeat
                        j := j + 1;
                        MntRet := MntRet + ROUND(((MontiniT * "Interest %") / 36000), "Precision Arrondi Principale");
                        if (NbrMois - j) <> 0 then
                            MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), 1);
                        if ("affectation Diff Arrondi" = 0) and (j = 0) and (NbrMois - 1 <> 0) then
                            MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - 1)), 1)
                        else
                            if (DateFin <= CalcDate(StrSubstNo('+%1M', j + 1), DateDeb)) then begin
                                if (NbrMois - j) <> 0 then
                                    MontiniT := MontiniT - MontiniT - ROUND((MontiniT / (NbrMois - j)), "Precision Arrondi Principale");
                            end
                            else
                                if (NbrMois - j) <> 0 then
                                    MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), "Precision Arrondi Principale");
                    until (DateFin <= CalcDate(StrSubstNo('+%1M', j), DateDeb));

                    if NbrMois <> 0 then Mnt := ROUND(MntRet / NbrMois, 1);
                    Mnt1 := MntRet - (Mnt * (NbrMois - 1));
                    j := -1;
                    MntRet := 0;
                    repeat
                        j := j + 1;
                        if (DateDebT <= CalcDate(StrSubstNo('+%1M', j), DateDeb)) then
                            if (CalcDate('+FM', DateDebT) = CalcDate(StrSubstNo('+%1M', j), DateDeb)) and (j = 0) then
                                MntRet := MntRet + Mnt1
                            else
                                MntRet := MntRet + Mnt;
                    until (DateFinT <= CalcDate(StrSubstNo('+%1M', j), DateDeb)) or
                          (DateFin <= CalcDate(StrSubstNo('+%1M', j), DateDeb));
                end;
            // Amortissement Constant
            2:
                begin
                    // Calc Global
                    //spéciphique ENDA 25/02/2010
                    MntRet := ROUND(MontiniT * "Interest %" * NbrMois / 1200, "Precision Arrondi Principale");

                end;
        end;
    end;


    procedure CalcNbreMois() NbrMois: Integer
    var
        DateDeb: Date;
        DateFin: Date;
    begin
        DateDeb := "Date d'effet";
        DateFin := "Date fin Prêt";
        NbrMois := 0;
        repeat
            NbrMois := NbrMois + 1;
        until CalcDate(StrSubstNo('+%1M', NbrMois), DateDeb) > DateFin;
    end;


    procedure CalcMntInetretReport(DateDebT: Date; DateFinT: Date) MntRet: Decimal
    var
        MontiniT: Decimal;
        DateDeb: Date;
        DateFin: Date;
        NbrMois: Decimal;
        j: Integer;
        DateJ: Date;
        Mnt: Decimal;
        Mnt1: Decimal;
    begin

        MontiniT := Amount;
        DateDeb := "Date d'effet";
        DateFin := "Date fin Prêt";
        NbrMois := 0;
        REPEAT
            NbrMois := NbrMois + 1;
        UNTIL CALCDATE(STRSUBSTNO('+%1M', NbrMois), DateDeb) > DateFin;

        MntRet := 0;
        IF (DateDebT = 0D) OR (DateFinT = 0D) OR (DateFinT < "Date d'effet") OR (DateDebT > "Date fin Prêt")
           OR ("Date d'effet" = "Date fin Prêt") THEN
            EXIT;
        DateDebT := DateDebT;
        DateFinT := DateFinT;
        DateJ := DateDeb;
        // Amortissement Dégrissif
        CASE "type amortissement" OF
            0:
                BEGIN
                    j := -1;
                    REPEAT
                        j := j + 1;
                        IF DateDebT <= CALCDATE(STRSUBSTNO('+%1M', j), DateDeb) THEN
                            IF CALCDATE('+1J', "Date d'effet") >= CALCDATE(STRSUBSTNO('+%1M', j), DateDeb) THEN
                                MntRet := MntRet + ROUND(((MontiniT * "Interest %" * (CALCDATE(STRSUBSTNO('+%1M', j), DateDeb) -
                                          "Date Deblocage" + 1)) / 36000), 0.001)
                            ELSE
                                MntRet := MntRet + ROUND(((MontiniT * "Interest %" * (CALCDATE(STRSUBSTNO('+%1M', j), DateDeb) -
                                          CALCDATE(STRSUBSTNO('+%1M', j - 1), DateDeb))) / 36000), 0.001);

                        IF (NbrMois - j) <> 0 THEN
                            MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), 0.001);

                    UNTIL (DateFinT <= CALCDATE(STRSUBSTNO('+%1M', j), DateDeb)) OR
                          (DateFin <= CALCDATE(STRSUBSTNO('+%1M', j), DateDeb));
                END;
            // Amortissement Linéaire
            1:
                BEGIN
                    j := -1;
                    REPEAT
                        j := j + 1;
                        MntRet := MntRet + ROUND(((MontiniT * "Interest %") / 36000), 0.001);
                        IF (NbrMois - j) <> 0 THEN
                            MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), 0.001);
                        IF ("affectation Diff Arrondi" = 0) AND (j = 0) AND (NbrMois - 1 <> 0) THEN
                            MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - 1)), 1)
                        ELSE
                            IF (DateFin <= CALCDATE(STRSUBSTNO('+%1M', j + 1), DateDeb)) THEN BEGIN
                                IF (NbrMois - j) <> 0 THEN
                                    MontiniT := MontiniT - MontiniT - ROUND((MontiniT / (NbrMois - j)), 1);
                            END
                            ELSE
                                IF (NbrMois - j) <> 0 THEN
                                    MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), "Precision Arrondi Principale");
                    UNTIL (DateFin <= CALCDATE(STRSUBSTNO('+%1M', j), DateDeb));

                    IF NbrMois <> 0 THEN Mnt := ROUND(MntRet / NbrMois, 1);
                    Mnt1 := MntRet - (Mnt * (NbrMois - 1));
                    j := -1;
                    MntRet := 0;
                    REPEAT
                        j := j + 1;
                        IF (DateDebT <= CALCDATE(STRSUBSTNO('+%1M', j), DateDeb)) THEN
                            IF (CALCDATE('+FM', DateDebT) = CALCDATE(STRSUBSTNO('+%1M', j), DateDeb)) AND (j = 0) THEN
                                MntRet := MntRet + Mnt1
                            ELSE
                                MntRet := MntRet + Mnt;
                    UNTIL (DateFinT <= CALCDATE(STRSUBSTNO('+%1M', j), DateDeb)) OR
                          (DateFin <= CALCDATE(STRSUBSTNO('+%1M', j), DateDeb));
                END;
            // Amortissement Constant
            2:
                BEGIN
                    // Calc Global
                    MntRet := MontiniT * "Interest %" * NbrMois / 1200;
                    /*   j := -1;
                                        REPEAT
                                            j := j + 1;
                                            IF CALCDATE('+1J', "Date d'effet") >= CALCDATE(STRSUBSTNO('+%1M', j), DateDeb) THEN
                                                MntRet := MntRet + ROUND(((MontiniT * "Interest %" * (CALCDATE(STRSUBSTNO('+%1M', j), DateDeb) -
                                                          "Date Deblocage" + 1)) / 36000), 0.001)
                                            ELSE
                                                MntRet := MntRet + ROUND(((MontiniT * "Interest %" * (CALCDATE(STRSUBSTNO('+%1M', j), DateDeb) -
                                                          CALCDATE(STRSUBSTNO('+%1M', j - 1), DateDeb))) / 36000), 0.001);
                                            IF (NbrMois - j) <> 0 THEN
                                                MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), 0.001);
                                        UNTIL (DateFin <= CALCDATE(STRSUBSTNO('+%1M', j), DateDeb));
                      // Fin Global
                    //  Mnt:=ROUND(MntRet/NbrMois,0.001);
                    */
                    MntRetenue := MntRet;
                    Mnt := MntRet / NbrMois;
                    Mnt1 := ROUND(MntRet - (Mnt * (NbrMois - 1)), 0.001);

                    //MESSAGE(FORMAT(MntRet));
                    j := -1;
                    MntRet := 0;
                    REPEAT
                        j := j + 1;
                        IF (DateDebT <= CALCDATE(STRSUBSTNO('+%1M', j), DateDeb)) THEN
                            IF (CALCDATE('+FM', DateDebT) = CALCDATE(STRSUBSTNO('+%1M+FM', j), DateDeb)) AND (j = 0) THEN
                                MntRet := MntRet + Mnt1
                            ELSE
                                MntRet := MntRet + Mnt1;
                    UNTIL (DateDebT <= CALCDATE(STRSUBSTNO('+%1M', j), DateDeb));
                    //OR
                    //    (DateFin<=CALCDATE(STRSUBSTNO('+%1M',j),DateDeb));
                    IF CALCDATE(STRSUBSTNO('+%1M+FM', 0), DateFin) = CALCDATE(STRSUBSTNO('+%1M+FM', 0), DateFinT) THEN
                        MntRet := MntRetenue - (Mnt1 * (NbrMois - 1));


                END;
        END;


    end;
}

