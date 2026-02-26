Table 52048889 "Loan & Advance Header"
{//GL2024  ID dans Nav 2009 : "39001413"
    Caption = 'Loan & Advance Header';
    DrillDownPageID = "Loan & Advance Hdr";
    LookupPageID = "Loan & Advance Hdr";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2; Employee; Code[10])
        {
            Caption = 'Salarié';
            TableRelation = Employee;
        }
        field(3; Name; Text[60])
        {
            Caption = 'Nom';
        }
        field(4; "Job Title"; Text[50])
        {
            Caption = 'Job Title';
        }
        field(5; "Employee Posting Group"; Code[30])
        {
            Caption = 'Employee Posting Group';
            Editable = true;
            TableRelation = "Employee Posting Group2";
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            Editable = false;
            OptionCaption = 'Advance,Loan';
            OptionMembers = Advance,Loan;
        }
        field(7; "Document type"; Code[10])
        {
            Caption = 'Document type';
            TableRelation = "Loan & Advance Type" where(Type = field(Type));
        }
        field(10; Amount; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Montant';
        }
        field(11; "Interest %"; Decimal)
        {
            Caption = 'Interest %';
            DecimalPlaces = 0 : 5;
            Editable = true;
        }
        field(12; "Total to repay"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Total to repay';
            InitValue = 0;
        }
        field(15; "Repayment slices"; Integer)
        {
            Caption = 'Repayment slices';
            Editable = true;
        }
        field(20; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(25; "Validation date"; Date)
        {
            Caption = 'Validation date';
            Editable = false;
        }
        field(30; "Repaiment lines"; Integer)
        {
            CalcFormula = count("Loan & Advance Lines" where("No." = field("No."),
                                                              Paid = filter(true)));
            Caption = 'Repaiment lines';
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "Repaid amount"; Decimal)
        {
            CalcFormula = sum("Loan & Advance Lines"."Line Amount" where("No." = field("No.")));
            Caption = 'Repaid amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; "Repaid %"; Decimal)
        {
            CalcFormula = sum("Loan & Advance Lines"."Line %" where("No." = field("No.")));
            Caption = 'Repaid %';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'In progress,Enclosed';
            OptionMembers = "In progress",Enclosed;
        }
        field(40; "Global dimension 1"; Code[20])
        {
            Caption = 'Code département';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(41; "Global dimension 2"; Code[20])
        {
            Caption = 'Code dossier';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50; "Principal Amount"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Loan & Advance Lines"."Principal Amount" where("No." = field("No."),
                                                                               Employee = field(Employee),
                                                                               Type = field(Type),
                                                                               Status = field(Status)));
            Caption = 'Montant Principale';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51; "Interest Amount"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Loan & Advance Lines"."Interest Amount" where("No." = field("No."),
                                                                              Employee = field(Employee),
                                                                              Type = field(Type),
                                                                              Status = field(Status)));
            Caption = 'Montant Interest';
            Editable = false;
            FieldClass = FlowField;
        }
        field(110; "Avance Sur Prime"; Boolean)
        {
        }
        field(50000; "Avance sur congé"; Boolean)
        {
        }
        /*  field(50001; "Pret CNSS"; Option)
          {
              OptionMembers = " ",Logement,Voiture,Cession;
          }
          field(50003; "Intégrer Comptabilité"; Boolean)
          {
              Description = 'RB SORO 10/05/2017';
          }
          field(50004; "Num Bordereaux Paiement"; Code[20])
          {
              Description = 'RB SORO 10/05/2017';
          }*/
        field(50200; "Montant tranche"; Decimal)
        {
            DecimalPlaces = 3 : 3;

            trigger OnValidate()
            begin
                PramRessHum.Get();
                if PramRessHum."Type Calcul prêt" = 0 then begin
                    if "Montant tranche" > ("Total to repay" - "Repaid amount") then begin
                        "Montant tranche" := 0;
                        Error(ERR1);
                    end;
                end;
            end;
        }
        field(50400; "Date Comptabilisation"; Date)
        {
        }
        field(50500; "Date d'effet"; Date)
        {
        }
        field(50501; "Date fin Prêt"; Date)
        {
        }
        field(50505; "N° document Extr."; Code[20])
        {
        }
        field(50600; "Not include"; Boolean)
        {
            Caption = 'Non Inclus';

            trigger OnValidate()
            begin
                //>>DSFT AGA 12/03/2010
                if "Not include" = true then
                    "Double tranche" := false;
                //<<DSFT AGA 12/03/2010
            end;
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
        field(39001432; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(39001433; "Bal. Account No."; Code[10])
        {
            Caption = 'Bal. Account No.';
            TableRelation = if ("Bal. Account Type" = filter("G/L Account")) "G/L Account"
            else
            if ("Bal. Account Type" = filter("Bank Account")) "Bank Account" where("Currency Code" = filter(''));
        }
        field(39001450; "type amortissement"; Option)
        {
            OptionCaption = 'Dégressif,Lineaire,Constant';
            OptionMembers = "Dégressif",Lineaire,Constant;
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
        field(39001492; "Type Arrondi"; Option)
        {
            OptionCaption = '=,>,<';
            OptionMembers = "=",">","<";
        }
        field(39001495; "Avance Repas"; Boolean)
        {
        }
        field(39001496; "Type reglement"; text[30])
        {
            TableRelation = "Payment Class" /*GL2024 WHERE(Suggestions = CONST(3))*/;
        }
        field(39001497; "Employee Statistic Group"; Code[30])
        {
            Caption = 'Employee Posting Group';
            Editable = true;
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
        field(39001501; "Double tranche"; Boolean)
        {

            trigger OnValidate()
            begin
                //>>DSFT AGA 12/03/2010
                if "Double tranche" = true then
                    "Not include" := false;
                //<<DSFT AGA 12/03/2010
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; Employee, Type, "Document type", Status, "No.", "Avance Sur Prime")
        {
        }
        key(Key3; Employee)
        {
        }
        key(Key4; Type)
        {
        }
        key(Key5; "Document type")
        {
        }
        key(Key6; Status)
        {
        }
        key(Key7; Employee, Type, Status, "No.", "Avance Sur Prime")
        {
            SumIndexFields = Amount;
        }
        key(Key8; Status, "Not include", "No.")
        {
        }
        key(Key9; Employee, Type, "Date Comptabilisation")
        {
            SumIndexFields = Amount;
        }
        key(Key10; Employee, Type, "Date d'effet", Status)
        {
            SumIndexFields = Amount;
        }
        /*  key(Key11; "Pret CNSS")
          {
          }*/
        key(Key11; "Date d'effet")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Last Date Modified" := WorkDate;
        "User ID" := UserId;
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
        MntLn: Decimal;
        MntLn1: Decimal;
        ERR1: label 'Vérifiez montant tranche';
        MntRetenue: Decimal;
        PramRessHum: Record "Human Resources Setup";
        LoanAdvanceType: Record "Loan & Advance Type";


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
        Datedeb := CalcDate('-27J+FM+1J', "Date d'effet");
        DateFin := CalcDate('-27J+FM', "Date fin Prêt");
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
                            until CalcDate(StrSubstNo('+%1M+FM', NbrMois), Datedeb) > DateFin;
                            // Amortissement Dégrissif
                            case "type amortissement" of
                                0:
                                    begin
                                        // IF "type amortissement"=0 THEN BEGIN
                                        NBcrt := 0;
                                        repeat
                                            if NbrMois <> 0 then begin
                                                CourtT := CourtT + ROUND(MntRest / (NbrMois - NBcrt), 0.001);
                                                MntRest := MntRest - ROUND(MntRest / (NbrMois - NBcrt), 0.001);
                                            end;
                                            NBcrt := NBcrt + 1;
                                        until CalcDate(StrSubstNo('+%1M+FM', NBcrt), Datedeb) > CalcDate('FA', Datecpta);

                                        if NbrMois <> 0 then begin
                                            //CourtT:=ROUND((NBcrt/NbrMois)*Amount,0.001);
                                            LongT := Amount - CourtT;
                                        end;
                                    end;
                                1:
                                    begin
                                        // ELSE BEGIN
                                        NBcrt := 0;
                                        repeat
                                            if NbrMois <> 0 then
                                                NBcrt := NBcrt + 1;
                                        until CalcDate(StrSubstNo('+%1M+FM', NBcrt), Datedeb) > CalcDate('FA', Datecpta);
                                        Mnt := 0;
                                        Mnt1 := 0;
                                        if NbrMois <> 0 then
                                            Mnt := ROUND(Amount / NbrMois, 0.5);
                                        Mnt1 := Amount - (Mnt * (NbrMois - 1));
                                        CourtT := ROUND(Mnt1 + ((NBcrt - 1) * Mnt), 0.001);
                                        LongT := Amount - CourtT;
                                    end;
                                2:
                                    begin
                                        NBcrt := 0;
                                        repeat
                                            if NbrMois <> 0 then
                                                NBcrt := NBcrt + 1;
                                        until CalcDate(StrSubstNo('+%1M+FM', NBcrt), Datedeb) > CalcDate('FA', Datecpta);
                                        Mnt := 0;
                                        Mnt1 := 0;
                                        if NbrMois <> 0 then
                                            Mnt := ROUND(Amount / NbrMois, 0.001);
                                        Mnt1 := Amount - (Mnt * (NbrMois - 1));
                                        CourtT := ROUND(Mnt1 + ((NBcrt - 1) * Mnt), 0.001);
                                        LongT := Amount - CourtT;

                                    end;
                            end;
                        end;
                end;
        end;
    end;


    procedure "CalcMntInetretaPayé"(DateDebT: Date; DateFinT: Date) MntRet: Decimal
    var
        MontiniT: Decimal;
        DateDeb: Date;
        DateFin: Date;
        NbrMois: Decimal;
        j: Integer;
        DateJ: Date;
    begin

        MontiniT := Amount;
        DateDeb := CalcDate('-27J+FM+1J', "Date d'effet");
        DateFin := CalcDate('-27J+FM', "Date fin Prêt");
        NbrMois := 0;
        repeat
            NbrMois := NbrMois + 1;
        until CalcDate(StrSubstNo('+%1M+FM', NbrMois - 1), DateDeb) > DateFin;
        MntRet := 0;
        if (DateDebT = 0D) or (DateFinT = 0D) or (DateFinT < "Date d'effet") or (DateDebT > "Date fin Prêt")
             or ("Date d'effet" = "Date fin Prêt") then
            exit;
        DateDebT := CalcDate('-27J+FM+1J', DateDebT);
        DateFinT := CalcDate('-27J+FM', DateFinT);
        DateJ := DateDeb;
        j := -1;
        repeat
            j := j + 1;

            if DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb) then
                MntRet := MntRet + ROUND(((MontiniT * "Interest %") / 1200), 0.001);
            if (NbrMois - j) <> 0 then
                MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), 0.001);
        until (DateFinT <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb)) or
           (DateFin <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb));
    end;


    procedure CalcMnPrinciPeriode(DateDebT: Date; DateFinT: Date) MntPrin: Decimal
    var
        MontiniT: Decimal;
        DateDeb: Date;
        DateFin: Date;
        NbrMois: Decimal;
        j: Integer;
        DateJ: Date;
        Mnt1: Decimal;
        Mnt: Decimal;
    begin

        MontiniT := Amount;
        DateDeb := CalcDate('-27J+FM', "Date d'effet");
        DateFin := CalcDate('-27J+FM+1J', "Date fin Prêt");
        NbrMois := 0;
        repeat
            NbrMois := NbrMois + 1;
        until CalcDate(StrSubstNo('+%1M+FM', NbrMois), DateDeb) > DateFin;

        MntPrin := 0;
        if (DateDebT = 0D) or (DateFinT = 0D) or (DateFinT < "Date d'effet") or (DateDebT > "Date fin Prêt")
           or ("Date d'effet" = "Date fin Prêt") then;

        DateDebT := CalcDate('-27J+FM+1J', DateDebT);
        DateFinT := CalcDate('-27J+FM', DateFinT);
        DateJ := DateDeb;
        // Amortissement Dégressif
        case "type amortissement" of
            0:
                begin
                    //IF "type amortissement"=0 THEN BEGIN
                    j := -1;
                    repeat
                        j := j + 1;
                        if DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb) then
                            IF (NbrMois - j) <> 0 THEN MntPrin := MntPrin + ROUND((MontiniT / (NbrMois - j)), 0.001);

                        if (NbrMois - j) <> 0 then
                            IF (NbrMois - j) <> 0 THEN MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), 0.001);
                    until (DateFinT <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb)) or
                          (DateFin <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb));
                end;
            1:
                begin
                    //ELSE BEGIN
                    MntPrin := 0;
                    Mnt := 0;
                    Mnt1 := 0;

                    j := -1;
                    IF (NbrMois - 1) <> 0 THEN BEGIN
                        IF (NbrMois - j) <> 0 THEN Mnt := ROUND(Amount / "Repayment slices", 1);
                        Mnt1 := Mnt;
                    END
                    ELSE BEGIN
                        CALCFIELDS("Repaid amount");
                        Mnt1 := Amount - "Repaid amount";
                        Mnt := Mnt1;
                    END;
                    repeat
                        j := j + 1;

                        if (DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb)) then
                            if (CalcDate('+FM', DateDebT) = CalcDate(StrSubstNo('+%1M+FM', j), DateDeb)) and (j = 0) then
                                MntPrin := MntPrin + Mnt1
                            else
                                MntPrin := MntPrin + Mnt;
                    until (DateFinT <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb)) or
                          (DateFin <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb));
                end;
            2:
                begin
                    MntPrin := 0;
                    Mnt := 0;
                    Mnt1 := 0;
                    j := -1;
                    IF (NbrMois - 1) <> 0 THEN BEGIN
                        IF (NbrMois - j) <> 0 THEN Mnt := ROUND(Amount / "Repayment slices", 1);
                        Mnt1 := Mnt;
                    END
                    ELSE BEGIN
                        CALCFIELDS("Repaid amount");
                        Mnt1 := Amount - "Repaid amount";
                        Mnt := Mnt1;
                    END;

                    REPEAT
                        j := j + 1;

                        IF (DateDebT <= CALCDATE(STRSUBSTNO('+%1M+FM', j), DateDeb)) THEN
                            IF (CALCDATE('+FM', DateDebT) = CALCDATE(STRSUBSTNO('+%1M+FM', j), DateDeb)) AND (j = 0) THEN
                                MntPrin := MntPrin + Mnt1
                            ELSE
                                MntPrin := MntPrin + Mnt;
                    UNTIL (DateFinT <= CALCDATE(STRSUBSTNO('+%1M+FM', j), DateDeb)) OR
                          (DateFin <= CALCDATE(STRSUBSTNO('+%1M+FM', j), DateDeb));
                END;
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
        EXIT; ///***
        MontiniT := Amount;
        DateDeb := CalcDate('-27J+FM', "Date d'effet");
        DateFin := CalcDate('-27J+FM+1J', "Date fin Prêt");
        NbrMois := 0;
        repeat
            NbrMois := NbrMois + 1;
        until CalcDate(StrSubstNo('+%1M+FM', NbrMois), DateDeb) > DateFin;
        MntRet := 0;
        if (DateDebT = 0D) or (DateFinT = 0D) or (DateFinT < "Date d'effet") or (DateDebT > "Date fin Prêt")
             or ("Date d'effet" = "Date fin Prêt") then
            exit;
        DateDebT := CalcDate('-27J+FM+1J', DateDebT);
        DateFinT := CalcDate('-27J+FM', DateFinT);
        DateJ := DateDeb;
        // Amortissement Dégressif
        case "type amortissement" of
            0:
                begin
                    // IF "type amortissement"=0 THEN BEGIN
                    j := -1;
                    repeat
                        j := j + 1;
                        if DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb) then
                            MntRet := MntRet + ROUND(((MontiniT * "Interest %") / 1200), 0.001);
                        if (NbrMois - j) <> 0 then
                            MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), 0.001);
                    until (DateFinT <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb)) or
                       (DateFin <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb));
                end;
            1:
                begin
                    // ELSE BEGIN
                    j := -1;
                    repeat
                        j := j + 1;

                        //IF DateDebT<=CALCDATE(STRSUBSTNO('+%1M+FM',j),DateDeb) THEN
                        MntRet := MntRet + ROUND(((MontiniT * "Interest %") / 1200), 0.001);
                        if (NbrMois - j) <> 0 then
                            MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), 0.001);
                    until (DateFin <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb));

                    Mnt := ROUND(MntRet / NbrMois, 0.5, '<');
                    Mnt1 := MntRet - (Mnt * (NbrMois - 1));
                    j := -1;
                    MntRet := 0;
                    repeat
                        j := j + 1;
                        if (DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb)) then
                            if (CalcDate('+FM', DateDebT) = CalcDate(StrSubstNo('+%1M+FM', j), DateDeb)) and (j = 0) then
                                MntRet := MntRet + Mnt1
                            else
                                MntRet := MntRet + Mnt;
                    until (DateFinT <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb)) or
                       (DateFin <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb));

                end;
            2:
                begin
                    // Calc Global
                    //spéciphique ENDA 25/02/201
                    MntRet := MontiniT * "Interest %" / 1200;
                    //    MntRet := MontiniT*"Interest %"*NbrMois/1200;  attention refaire le flux
                    /*
                    j:=-1;

                    REPEAT
                      j:=j+1;
                      IF CALCDATE('+1J',"Date d'effet")>=CALCDATE(STRSUBSTNO('+%1M',j),DateDeb) THEN
                        MntRet := MntRet+ROUND(((MontiniT*"Interest %"* (CALCDATE(STRSUBSTNO('+%1M',j),DateDeb)-
                                  "Date Deblocage"+1))/36000),0.001)
                      ELSE
                        MntRet := MntRet+ROUND(((MontiniT*"Interest %"*(CALCDATE(STRSUBSTNO('+%1M',j),DateDeb)-
                                  CALCDATE(STRSUBSTNO('+%1M',j-1),DateDeb)))/36000),0.001);
                      IF (NbrMois-j)<>0 THEN
                         MontiniT:=MontiniT-ROUND((MontiniT/(NbrMois-j)),0.001);
                  UNTIL   (DateFin<=CALCDATE(STRSUBSTNO('+%1M',j),DateDeb));
                  // Fin Global*/

                    /*  Mnt:=ROUND(MntRet/NbrMois,0.001);
                      Mnt1:=MntRet-(Mnt*(NbrMois-1));

                      //MESSAGE(FORMAT(MntRet));
                      j:=-1;
                      MntRet:=0;
                      REPEAT
                        j:=j+1;
                        IF (DateDebT<=CALCDATE(STRSUBSTNO('+%1M',j),DateDeb))  THEN
                          IF (CALCDATE('+FM',DateDebT)=CALCDATE(STRSUBSTNO('+%1M+FM',j),DateDeb)) AND (j=0) THEN
                            MntRet:=MntRet+Mnt1
                          ELSE
                            MntRet:=MntRet+Mnt;
                        UNTIL (DateDebT<=CALCDATE(STRSUBSTNO('+%1M',j),DateDeb)) ;*/
                    //OR
                    //    (DateFin<=CALCDATE(STRSUBSTNO('+%1M',j),DateDeb));
                end;
        end;

        /*MBY 25/02/2010
          j:=-1;
          REPEAT
              j:=j+1;
        
           //IF DateDebT<=CALCDATE(STRSUBSTNO('+%1M+FM',j),DateDeb) THEN
              MntRet:=MntRet+ROUND(((MontiniT*"Interest %")/1200),0.001);
              IF (NbrMois-j)<>0 THEN
            MontiniT:=MontiniT-ROUND((MontiniT/(NbrMois-j)),0.001);
          UNTIL (DateFin<=CALCDATE(STRSUBSTNO('+%1M+FM',j),DateDeb));
        
          Mnt:=ROUND(MntRet/NbrMois,0.001);
          Mnt1:=MntRet-(Mnt*(NbrMois-1));
          j:=-1;
          MntRet:=0;
          REPEAT
              j:=j+1;
           IF (DateDebT<=CALCDATE(STRSUBSTNO('+%1M+FM',j),DateDeb))  THEN
              IF (CALCDATE('+FM',DateDebT)=CALCDATE(STRSUBSTNO('+%1M+FM',j),DateDeb)) AND (j=0) THEN
                 MntRet:=MntRet+Mnt1
              ELSE
                 MntRet:=MntRet+Mnt;
          UNTIL (DateFinT<=CALCDATE(STRSUBSTNO('+%1M+FM',j),DateDeb)) OR
             (DateFin<=CALCDATE(STRSUBSTNO('+%1M+FM',j),DateDeb));
        
           END;
        
             END;
        MBY 25/02/2010*/

    end;


    procedure CalcNbreMois() NbrMois: Integer
    var
        DateDeb: Date;
        DateFin: Date;
    begin
        DateDeb := CalcDate('-27J+FM+1J', "Date d'effet");
        DateFin := CalcDate('-27J+FM', "Date fin Prêt");
        NbrMois := 0;
        repeat
            NbrMois := NbrMois + 1;
        until CalcDate(StrSubstNo('+%1M+FM', NbrMois), DateDeb) > DateFin;
    end;


    procedure CalcMntInetretAvPrime(DateFinT: Date) MntRet: Decimal
    var
        MontiniT: Decimal;
        DateDeb: Date;
        DateFin: Date;
        NbrMois: Decimal;
        j: Integer;
        DateJ: Date;
        Mnt: Decimal;
        Mnt1: Decimal;
        LignePret: Record "Loan & Advance Lines";
        LignePretTmp: Record "Loan & Advance Lines";
    begin
        LignePret.Reset;
        LignePret.SetCurrentkey("No.", Status, Type, Employee, Paid);
        LignePret.SetFilter("No.", "No.");
        LignePret.SetRange(Status, Status);
        LignePret.SetRange(Type, Type);
        LignePret.SetFilter(Employee, Employee);
        LignePret.SetRange(Paid, true);
        LignePret.CalcSums("Principal Amount");
        MntRet := 0;
        if (DateFinT = 0D) then
            Error('Verifier Date Effet ou date du Calcul Interrêt !!!');
        MontiniT := Amount - LignePret."Principal Amount";

        LignePretTmp.Reset;
        LignePretTmp.SetCurrentkey("No.", Status, Type, Employee, Paid);
        LignePretTmp.SetFilter("No.", "No.");
        LignePretTmp.SetRange(Status, Status);
        LignePretTmp.SetRange(Type, Type);
        LignePretTmp.SetFilter(Employee, Employee);
        LignePretTmp.SetRange(Paid, true);
        if LignePretTmp.Find('+') then
            DateDeb := LignePretTmp."Date Paie"
        else
            DateDeb := "Date d'effet";

        MntRet := (MontiniT * ("Interest %" / 100) * (DateFinT - DateDeb)) / 365;
    end;


    procedure CalcMnPRincipaleRemb() MntRest: Decimal
    var
        MontiniT: Decimal;
        DateDeb: Date;
        DateFin: Date;
        NbrMois: Decimal;
        j: Integer;
        DateJ: Date;
        Mnt: Decimal;
        Mnt1: Decimal;
        LignePret: Record "Loan & Advance Lines";
    begin
        LignePret.Reset;
        LignePret.SetCurrentkey("No.", Status, Type, Employee, Paid);
        LignePret.SetFilter("No.", "No.");
        LignePret.SetRange(Status, Status);
        LignePret.SetRange(Type, Type);
        LignePret.SetFilter(Employee, Employee);
        LignePret.SetRange(Paid, true);
        LignePret.CalcSums("Principal Amount");
        MntRest := 0;
        MntRest := Amount - LignePret."Principal Amount";
    end;


    procedure CalcMntInetretEng(DateFinT: Date) MntRet: Decimal
    var
        MontiniT: Decimal;
        DateDeb: Date;
        DateFin: Date;
        NbrMois: Decimal;
        j: Integer;
        DateJ: Date;
        Mnt: Decimal;
        Mnt1: Decimal;
        LignePret: Record "Loan & Advance Lines";
        LignePretTmp: Record "Loan & Advance Lines";
    begin
        LignePret.Reset;
        LignePret.SetCurrentkey("No.", Status, Type, Employee, Paid);
        LignePret.SetFilter("No.", "No.");
        LignePret.SetRange(Status, Status);
        LignePret.SetRange(Type, Type);
        LignePret.SetFilter(Employee, Employee);
        LignePret.SetRange(Paid, true);
        LignePret.CalcSums("Principal Amount");
        MntRet := 0;
        if (DateFinT = 0D) then
            Error('Verifier Date Effet ou date du Calcul Interrêt !!!');
        MontiniT := Amount - LignePret."Principal Amount";

        LignePretTmp.Reset;
        LignePretTmp.SetCurrentkey("No.", Status, Type, Employee, Paid);
        LignePretTmp.SetFilter("No.", "No.");
        LignePretTmp.SetRange(Status, Status);
        LignePretTmp.SetRange(Type, Type);
        LignePretTmp.SetFilter(Employee, Employee);
        LignePretTmp.SetRange(Paid, true);
        if LignePretTmp.Find('+') then
            DateDeb := LignePretTmp."Date Paie"
        else
            DateDeb := "Date d'effet";

        MntRet := (MontiniT * ("Interest %" / 100) * (DateFinT - DateDeb)) / 365;
    end;


    procedure CalcMnPrinciPeriodeeng(DateDebT: Date; DateFinT: Date) MntPrin: Decimal
    var
        MontiniT: Decimal;
        DateDeb: Date;
        DateFin: Date;
        NbrMois: Decimal;
        j: Integer;
        DateJ: Date;
        Mnt1: Decimal;
        Mnt: Decimal;
        LignePret: Record "Loan & Advance Lines";
    begin









        //hj*** "Precision Arrondi Principale"
        IF LoanAdvanceType.GET("Document type") THEN
            "Precision Arrondi Principale" := LoanAdvanceType."Precision Arrondi Principale";

        LignePret.RESET;
        LignePret.SETCURRENTKEY("No.", Status, Type, Employee, Paid);
        LignePret.SETFILTER("No.", "No.");
        LignePret.SETRANGE(Status, Status);
        LignePret.SETRANGE(Type, Type);
        LignePret.SETFILTER(Employee, Employee);
        LignePret.SETRANGE(Paid, TRUE);
        LignePret.CALCSUMS("Principal Amount");
        MontiniT := ROUND(Amount - LignePret."Principal Amount", 1);

        DateDeb := CALCDATE('-27J+FM+1J', "Date d'effet");
        DateFin := CALCDATE('-27J+FM', "Date fin Prêt");
        NbrMois := "Repayment slices" - LignePret.COUNT;
        MntPrin := 0;

        IF (DateDebT = 0D) OR (DateFinT = 0D) OR (NbrMois = 0) OR (MontiniT = 0) OR (DateDebT >= DateFinT)
          OR (DateDeb >= DateFinT) THEN
            EXIT;
        DateDebT := CALCDATE('-27J+FM+1J', DateDebT);
        DateFinT := CALCDATE('-27J+FM', DateFinT);
        DateJ := DateDeb;
        // Amortissement Dégressif

        CASE "type amortissement" OF
            0:
                BEGIN
                    //IF "type amortissement"=0 THEN BEGIN
                    j := -1;
                    IF ("Repayment slices") <> 0 THEN
                        //MntLn:= ROUND(Amount/("Repayment slices"),"Precision Arrondi Principale",FORMAT("Type Arrondi"));
                        MntLn := Amount / ("Repayment slices");
                    MntLn1 := MontiniT - (MntLn * ("Repayment slices" - 1));
                    REPEAT
                        j := j + 1;

                        IF (NbrMois - j) <> 0 THEN
                            MntPrin := MntPrin + ROUND((MontiniT / (NbrMois - j)), "Precision Arrondi Principale");

                        IF (NbrMois - j) <> 0 THEN
                            MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), "Precision Arrondi Principale");

                    UNTIL (DateFinT <= CALCDATE(STRSUBSTNO('+%1M+FM', j), DateDebT));
                END;
            1:
                BEGIN
                    MntPrin := 0;
                    Mnt := 0;
                    Mnt1 := 0;
                    IF NbrMois <> 0 THEN
                        Mnt := ROUND(Amount / "Repayment slices", 1);
                    CALCFIELDS("Repaid amount");
                    Mnt1 := Amount - "Repaid amount";
                    j := -1;
                    REPEAT
                        j := j + 1;
                        IF (NbrMois - 1) = 0 THEN
                            MntPrin := Mnt1
                        ELSE
                            MntPrin := Mnt;
                    UNTIL (DateFinT <= CALCDATE(STRSUBSTNO('+%1M+FM', j), DateDebT));
                END;
            2:
                BEGIN
                    MntPrin := 0;
                    Mnt := 0;
                    Mnt1 := 0;
                    IF NbrMois <> 0 THEN
                        Mnt := ROUND(Amount / "Repayment slices", 1);
                    CALCFIELDS("Repaid amount");
                    Mnt1 := Amount - "Repaid amount";
                    j := -1;
                    REPEAT
                        j := j + 1;
                        IF (NbrMois - 1) = 0 THEN
                            MntPrin := Mnt1
                        ELSE
                            MntPrin := Mnt;
                    UNTIL (DateFinT <= CALCDATE(STRSUBSTNO('+%1M+FM', j), DateDebT));


                END;
        END;///









    end;


    procedure CalcMntInetretEng1(DateDebT: Date; DateFinT: Date) MntRet: Decimal
    var
        MontiniT: Decimal;
        DateDeb: Date;
        DateFin: Date;
        NbrMois: Decimal;
        j: Integer;
        DateJ: Date;
        Mnt: Decimal;
        Mnt1: Decimal;
        LignePret: Record "Loan & Advance Lines";
    begin
        EXIT;
        LignePret.Reset;
        LignePret.SetCurrentkey("No.", Status, Type, Employee, Paid);
        LignePret.SetFilter("No.", "No.");
        LignePret.SetRange(Status, Status);
        LignePret.SetRange(Type, Type);
        LignePret.SetFilter(Employee, Employee);
        LignePret.SetRange(Paid, true);
        LignePret.CalcSums("Principal Amount");
        MontiniT := ROUND(Amount - LignePret."Principal Amount", 0.001);

        DateDeb := CalcDate('-27J+FM+1J', "Date d'effet");
        DateFin := CalcDate('-27J+FM', "Date fin Prêt");
        NbrMois := 0;
        NbrMois := "Repayment slices" - LignePret.Count;

        MntRet := 0;
        if (DateDebT = 0D) or (DateFinT = 0D) or (NbrMois = 0) or (MontiniT = 0) or (DateDebT >= DateFinT)
        or (DateDeb >= DateFinT) then
            exit;

        DateDebT := CalcDate('-27J+FM+1J', DateDebT);
        DateFinT := CalcDate('-27J+FM', DateFinT);
        DateJ := DateDeb;
        // Amortissement Dégressif
        case "type amortissement" of
            0:
                begin
                    j := -1;
                    repeat
                        j := j + 1;
                        MntRet := MntRet + ROUND(((MontiniT * "Interest %") / 1200), 0.001);
                        if (NbrMois - j) <> 0 then
                            MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), 0.001);
                    until (DateFinT <= CalcDate(StrSubstNo('+%1M+FM', j), DateDebT));
                end;
            1:
                begin
                    j := -1;
                    repeat
                        j := j + 1;
                        MntRet := MntRet + ROUND(((MontiniT * "Interest %") / 1200), 0.001);
                        if (NbrMois - j) <> 0 then
                            MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), 0.001);
                    until (DateFin <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb));

                    Mnt := ROUND(MntRet / NbrMois, 0.5, '<');
                    Mnt1 := MntRet - (Mnt * (NbrMois - 1));
                    j := -1;
                    MntRet := 0;
                    repeat
                        j := j + 1;
                        if (DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb)) then
                            if (CalcDate('+FM', DateDebT) = CalcDate(StrSubstNo('+%1M+FM', j), DateDeb)) and (j = 0) then
                                MntRet := MntRet + Mnt1
                            else
                                MntRet := MntRet + Mnt;
                    until (DateFinT <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb)) or
                          (DateFin <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb));
                end;
            2:
                begin
                    //MBY 25/02/2010
                    MntRet := MntRet + ROUND(((Amount * "Interest %") / 1200), 0.001);
                    //    IF "Repayment slices">0 THEN
                    //      MntRet := MntRet/"Repayment slices";
                    //MBY 25/10/2010
                    /*
                    j:=-1;
                    REPEAT
                      j:=j+1;
                      MntRet:=MntRet+ROUND(((MontiniT*"Interest %")/1200),0.001);
                      IF (NbrMois-j)<>0 THEN
                        MontiniT:=MontiniT-ROUND((MontiniT/(NbrMois-j)),0.001);
                    UNTIL (DateFin<=CALCDATE(STRSUBSTNO('+%1M+FM',j),DateDeb));
                    Mnt:=ROUND(MntRet/NbrMois,0.001);
                    Mnt1:=MntRet-(Mnt*(NbrMois-1));
                    j:=-1;
                    MntRet:=0;
                    REPEAT
                      j:=j+1;
                      IF (DateDebT<=CALCDATE(STRSUBSTNO('+%1M+FM',j),DateDeb))  THEN
                        IF (CALCDATE('+FM',DateDebT)=CALCDATE(STRSUBSTNO('+%1M+FM',j),DateDeb)) AND (j=0) THEN
                          MntRet:=MntRet+Mnt1
                        ELSE
                          MntRet:=MntRet+Mnt;
                    UNTIL (DateFinT<=CALCDATE(STRSUBSTNO('+%1M+FM',j),DateDeb)) OR
                          (DateFin<=CALCDATE(STRSUBSTNO('+%1M+FM',j),DateDeb));
                  */
                end;
        end;

    end;


    procedure CalcMnPrinciPeriodeengtmp(DateDebT: Date; DateFinT: Date) MntPrin: Decimal
    var
        MontiniT: Decimal;
        DateDeb: Date;
        DateFin: Date;
        NbrMois: Decimal;
        j: Integer;
        DateJ: Date;
        Mnt1: Decimal;
        Mnt: Decimal;
        LignePret: Record "Loan & Advance Lines";
        T1: Record "Rec. Salary Headers";
        DateP: Date;
    begin
        LignePret.Reset;
        LignePret.SetCurrentkey("No.", Status, Type, Employee, Paid);
        LignePret.SetFilter("No.", "No.");
        LignePret.SetRange(Status, Status);
        LignePret.SetRange(Type, Type);
        LignePret.SetFilter(Employee, Employee);
        LignePret.SetRange(Paid, true);
        LignePret.CalcSums("Principal Amount");
        MontiniT := ROUND(Amount - LignePret."Principal Amount", 0.001);
        DateDeb := CalcDate('-27J+FM+1J', "Date d'effet");
        DateFin := CalcDate('-27J+FM', "Date fin Prêt");
        NbrMois := "Repayment slices" - LignePret.Count;
        MntPrin := 0;
        if (DateDebT = 0D) or (DateFinT = 0D) or (NbrMois = 0) or (MontiniT = 0) or (DateDebT >= DateFinT)
          or (DateDeb >= DateFinT) then
            exit;
        DateDebT := CalcDate('-27J+FM+1J', DateDebT);
        DateFinT := CalcDate('-27J+FM', DateFinT);
        DateJ := DateDeb;
        T1.Reset;
        T1.Find('+');
        DateP := CalcDate('-24J+FM+1J', T1."Posting Date");
        // Amortissement Dégressif
        case "type amortissement" of
            0:
                begin
                    //IF "type amortissement"=0 THEN BEGIN
                    j := -1;

                    repeat
                        j := j + 1;

                        if (DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) then
                            MntPrin := MntPrin + ROUND((MontiniT / (NbrMois - j)), 0.001);

                        MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), 0.001);

                    until (DateFinT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) or
                      (CalcDate(StrSubstNo('+%1M+FM', NbrMois - 1), DateP) <= CalcDate(StrSubstNo('+%1M+FM', j), DateP));
                    ;


                end;
            1:
                begin
                    //ELSE BEGIN
                    MntPrin := 0;
                    Mnt := 0;
                    Mnt1 := 0;
                    if NbrMois <> 0 then
                        Mnt := ROUND(MontiniT / NbrMois, 0.5);
                    Mnt1 := MontiniT - (Mnt * (NbrMois - 1));
                    j := -1;
                    repeat
                        j := j + 1;

                        if (DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) then
                            if (LignePret.Count = 0) and (j = 0) then
                                MntPrin := MntPrin + Mnt1
                            else
                                MntPrin := MntPrin + Mnt;
                    until (DateFinT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) or
                      (CalcDate(StrSubstNo('+%1M+FM', NbrMois - 1), DateP) <= CalcDate(StrSubstNo('+%1M+FM', j), DateP));
                    ;

                end;
            2:
                begin
                    MntPrin := 0;
                    Mnt := 0;
                    Mnt1 := 0;
                    if NbrMois <> 0 then
                        Mnt := ROUND(MontiniT / NbrMois, 0.001);
                    Mnt1 := MontiniT - (Mnt * (NbrMois - 1));
                    j := -1;
                    repeat
                        j := j + 1;

                        if (DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) then
                            if (LignePret.Count = 0) and (j = 0) then
                                MntPrin := MntPrin + Mnt1
                            else
                                MntPrin := MntPrin + Mnt;
                    until (DateFinT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) or
                      (CalcDate(StrSubstNo('+%1M+FM', NbrMois - 1), DateP) <= CalcDate(StrSubstNo('+%1M+FM', j), DateP));
                    ;
                end;
        end;
    end;


    procedure CalcMntInetretEngtmp(DateDebT: Date; DateFinT: Date) MntRet: Decimal
    var
        MontiniT: Decimal;
        DateDeb: Date;
        DateFin: Date;
        NbrMois: Decimal;
        j: Integer;
        DateJ: Date;
        Mnt: Decimal;
        Mnt1: Decimal;
        LignePret: Record "Loan & Advance Lines";
        T1: Record "Rec. Salary Headers";
        DateP: Date;
    begin
        LignePret.Reset;
        LignePret.SetCurrentkey("No.", Status, Type, Employee, Paid);
        LignePret.SetFilter("No.", "No.");
        LignePret.SetRange(Status, Status);
        LignePret.SetRange(Type, Type);
        LignePret.SetFilter(Employee, Employee);
        LignePret.SetRange(Paid, true);
        LignePret.CalcSums("Principal Amount");
        MontiniT := ROUND(Amount - LignePret."Principal Amount", 0.001);

        DateDeb := CalcDate('-27J+FM+1J', "Date d'effet");
        DateFin := CalcDate('-27J+FM', "Date fin Prêt");
        NbrMois := 0;
        NbrMois := "Repayment slices" - LignePret.Count;
        T1.Reset;
        T1.Find('+');
        DateP := CalcDate('+FM+1J', T1."Posting Date");

        MntRet := 0;
        if (DateDebT = 0D) or (DateFinT = 0D) or (NbrMois = 0) or (MontiniT = 0) or (DateDebT >= DateFinT)
        or (DateDeb >= DateFinT) then
            exit;

        DateDebT := CalcDate('-27J+FM+1J', DateDebT);
        DateFinT := CalcDate('-27J+FM', DateFinT);
        DateJ := DateDeb;
        // Amortissement Dégressif
        case "type amortissement" of
            0:
                begin
                    // IF "type amortissement"=0 THEN BEGIN
                    j := -1;
                    repeat
                        j := j + 1;
                        if DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP) then
                            MntRet := MntRet + ROUND(((MontiniT * "Interest %") / 1200), 0.001);

                        MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), 0.001);

                    until (DateFinT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) or
                      (CalcDate(StrSubstNo('+%1M+FM', NbrMois - 1), DateP) <= CalcDate(StrSubstNo('+%1M+FM', j), DateP));
                    ;

                end;
            1:
                begin
                    // ELSE BEGIN
                    j := -1;
                    repeat
                        j := j + 1;

                        if DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP) then
                            MntRet := MntRet + ROUND(((MontiniT * "Interest %") / 1200), 0.001);
                        if (NbrMois - j) <> 0 then
                            MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), 0.001);
                    until (DateFin <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb));

                    Mnt := ROUND(MntRet / NbrMois, 0.5, '<');
                    Mnt1 := MntRet - (Mnt * (NbrMois - 1));
                    j := -1;
                    MntRet := 0;
                    repeat
                        j := j + 1;
                        if (DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) then
                            if (CalcDate('+FM', DateDebT) = CalcDate(StrSubstNo('+%1M+FM', j), DateP)) and (j = 0) then
                                MntRet := MntRet + Mnt1
                            else
                                MntRet := MntRet + Mnt;
                    until (DateFinT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) or
                      (CalcDate(StrSubstNo('+%1M+FM', NbrMois - 1), DateP) <= CalcDate(StrSubstNo('+%1M+FM', j), DateP));
                    ;


                end;
            2:
                begin
                    j := -1;
                    repeat
                        j := j + 1;

                        if DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP) then
                            MntRet := MntRet + ROUND(((MontiniT * "Interest %") / 1200), 0.001);
                        if (NbrMois - j) <> 0 then
                            MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), 0.001);
                    until (DateFin <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb));


                    Mnt := ROUND(MntRet / NbrMois, 0.001);
                    Mnt1 := MntRet - (Mnt * (NbrMois - 1));
                    j := -1;
                    MntRet := 0;
                    repeat
                        j := j + 1;
                        if (DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) then
                            if (CalcDate('+FM', DateDebT) = CalcDate(StrSubstNo('+%1M+FM', j), DateP)) and (j = 0) then
                                MntRet := MntRet + Mnt1
                            else
                                MntRet := MntRet + Mnt;
                    until (DateFinT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) or
                      (CalcDate(StrSubstNo('+%1M+FM', NbrMois - 1), DateP) <= CalcDate(StrSubstNo('+%1M+FM', j), DateP));
                    ;

                end;

        end;
    end;


    procedure CalcMnPrinciPeriodeenglp(DateDebT: Date; DateFinT: Date) MntPrin: Decimal
    var
        MontiniT: Decimal;
        DateDeb: Date;
        DateFin: Date;
        NbrMois: Decimal;
        j: Integer;
        DateJ: Date;
        Mnt1: Decimal;
        Mnt: Decimal;
        LignePret: Record "Loan & Advance Lines";
        T1: Record "Rec. Salary Headers";
        DateP: Date;
    begin
        LignePret.Reset;
        LignePret.SetCurrentkey("No.", Employee, Status, Type, Paid, "Entry No.");
        LignePret.SetFilter("No.", "No.");
        LignePret.SetRange(Status, Status);
        LignePret.SetRange(Type, Type);
        LignePret.SetFilter(Employee, Employee);
        LignePret.SetRange(Paid, true);
        LignePret.CalcSums("Principal Amount");
        MontiniT := ROUND(Amount - LignePret."Principal Amount", 0.001);
        DateDeb := CalcDate('-27J+FM+1J', "Date d'effet");
        DateFin := CalcDate('-27J+FM', "Date fin Prêt");
        NbrMois := "Repayment slices" - LignePret.Count;
        MntPrin := 0;
        if (DateDebT = 0D) or (DateFinT = 0D) or (NbrMois = 0) or (MontiniT = 0) or (DateDebT >= DateFinT)
          or (DateDeb >= DateFinT) then
            exit;
        if LignePret.Find('+') then;
        DateDebT := CalcDate('-27J+FM+1J', DateDebT);
        DateFinT := CalcDate('-27J+FM', DateFinT);
        DateJ := DateDeb;
        T1.Reset;
        T1.Find('+');
        DateP := CalcDate('-24J+FM+1J', LignePret."Date Paie");
        // Amortissement Dégressif
        case "type amortissement" of
            0:
                begin
                    //IF "type amortissement"=0 THEN BEGIN
                    j := -1;

                    repeat
                        j := j + 1;

                        if (DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) then
                            MntPrin := MntPrin + ROUND((MontiniT / (NbrMois - j)), 0.001);

                        MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), 0.001);

                    until (DateFinT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) or
                      (CalcDate(StrSubstNo('+%1M+FM', NbrMois - 1), DateP) <= CalcDate(StrSubstNo('+%1M+FM', j), DateP));
                    ;


                end;
            1:
                begin
                    //ELSE BEGIN
                    MntPrin := 0;
                    Mnt := 0;
                    Mnt1 := 0;
                    if NbrMois <> 0 then
                        Mnt := ROUND(MontiniT / NbrMois, 0.5);
                    Mnt1 := MontiniT - (Mnt * (NbrMois - 1));
                    j := -1;
                    repeat
                        j := j + 1;

                        if (DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) then
                            if (LignePret.Count = 0) and (j = 0) then
                                MntPrin := MntPrin + Mnt1
                            else
                                MntPrin := MntPrin + Mnt;
                    until (DateFinT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) or
                      (CalcDate(StrSubstNo('+%1M+FM', NbrMois - 1), DateP) <= CalcDate(StrSubstNo('+%1M+FM', j), DateP));
                    ;

                end;
            2:
                begin
                    MntPrin := 0;
                    Mnt := 0;
                    Mnt1 := 0;
                    if NbrMois <> 0 then
                        Mnt := ROUND(MontiniT / NbrMois, 0.001);
                    Mnt1 := MontiniT - (Mnt * (NbrMois - 1));
                    j := -1;
                    repeat
                        j := j + 1;

                        if (DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) then
                            if (LignePret.Count = 0) and (j = 0) then
                                MntPrin := MntPrin + Mnt1
                            else
                                MntPrin := MntPrin + Mnt;
                    until (DateFinT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) or
                      (CalcDate(StrSubstNo('+%1M+FM', NbrMois - 1), DateP) <= CalcDate(StrSubstNo('+%1M+FM', j), DateP));
                    ;
                end;
        end;
    end;


    procedure CalcMntInetretEnglp(DateDebT: Date; DateFinT: Date) MntRet: Decimal
    var
        MontiniT: Decimal;
        DateDeb: Date;
        DateFin: Date;
        NbrMois: Decimal;
        j: Integer;
        DateJ: Date;
        Mnt: Decimal;
        Mnt1: Decimal;
        LignePret: Record "Loan & Advance Lines";
        T1: Record "Rec. Salary Headers";
        DateP: Date;
    begin
        LignePret.Reset;
        LignePret.SetCurrentkey("No.", Employee, Status, Type, Paid, "Entry No.");
        LignePret.SetFilter("No.", "No.");
        LignePret.SetRange(Status, Status);
        LignePret.SetRange(Type, Type);
        LignePret.SetFilter(Employee, Employee);
        LignePret.SetRange(Paid, true);
        LignePret.CalcSums("Principal Amount");
        MontiniT := ROUND(Amount - LignePret."Principal Amount", 0.001);

        DateDeb := CalcDate('-27J+FM+1J', "Date d'effet");
        DateFin := CalcDate('-27J+FM', "Date fin Prêt");
        NbrMois := 0;
        NbrMois := "Repayment slices" - LignePret.Count;
        T1.Reset;
        T1.Find('+');
        if LignePret.Find('+') then;
        DateP := CalcDate('+FM+1J', LignePret."Date Paie");

        MntRet := 0;
        if (DateDebT = 0D) or (DateFinT = 0D) or (NbrMois = 0) or (MontiniT = 0) or (DateDebT >= DateFinT)
        or (DateDeb >= DateFinT) then
            exit;

        DateDebT := CalcDate('-27J+FM+1J', DateDebT);
        DateFinT := CalcDate('-27J+FM', DateFinT);
        DateJ := DateDeb;
        // Amortissement Dégressif
        case "type amortissement" of
            0:
                begin
                    // IF "type amortissement"=0 THEN BEGIN
                    j := -1;
                    repeat
                        j := j + 1;
                        if DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP) then
                            MntRet := MntRet + ROUND(((MontiniT * "Interest %") / 1200), 0.001);

                        MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), 0.001);

                    until (DateFinT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) or
                      (CalcDate(StrSubstNo('+%1M+FM', NbrMois - 1), DateP) <= CalcDate(StrSubstNo('+%1M+FM', j), DateP));
                    ;

                end;
            1:
                begin
                    // ELSE BEGIN
                    j := -1;
                    repeat
                        j := j + 1;

                        if DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP) then
                            MntRet := MntRet + ROUND(((MontiniT * "Interest %") / 1200), 0.001);
                        if (NbrMois - j) <> 0 then
                            MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), 0.001);
                    until (DateFin <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb));

                    Mnt := ROUND(MntRet / NbrMois, 0.5, '<');
                    Mnt1 := MntRet - (Mnt * (NbrMois - 1));
                    j := -1;
                    MntRet := 0;
                    repeat
                        j := j + 1;
                        if (DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) then
                            if (CalcDate('+FM', DateDebT) = CalcDate(StrSubstNo('+%1M+FM', j), DateP)) and (j = 0) then
                                MntRet := MntRet + Mnt1
                            else
                                MntRet := MntRet + Mnt;
                    until (DateFinT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) or
                      (CalcDate(StrSubstNo('+%1M+FM', NbrMois - 1), DateP) <= CalcDate(StrSubstNo('+%1M+FM', j), DateP));
                    ;


                end;
            2:
                begin
                    j := -1;
                    repeat
                        j := j + 1;

                        if DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP) then
                            MntRet := MntRet + ROUND(((MontiniT * "Interest %") / 1200), 0.001);
                        if (NbrMois - j) <> 0 then
                            MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), 0.001);
                    until (DateFin <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb));


                    Mnt := ROUND(MntRet / NbrMois, 0.001);
                    Mnt1 := MntRet - (Mnt * (NbrMois - 1));
                    j := -1;
                    MntRet := 0;
                    repeat
                        j := j + 1;
                        if (DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) then
                            if (CalcDate('+FM', DateDebT) = CalcDate(StrSubstNo('+%1M+FM', j), DateP)) and (j = 0) then
                                MntRet := MntRet + Mnt1
                            else
                                MntRet := MntRet + Mnt;
                    until (DateFinT <= CalcDate(StrSubstNo('+%1M+FM', j), DateP)) or
                      (CalcDate(StrSubstNo('+%1M+FM', NbrMois - 1), DateP) <= CalcDate(StrSubstNo('+%1M+FM', j), DateP));
                    ;

                end;

        end;
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
        DateDeb := CalcDate('-27J+FM+1J', "Date d'effet");
        DateFin := CalcDate('-27J+FM', "Date fin Prêt");
        NbrMois := 0;
        repeat
            NbrMois := NbrMois + 1;
        until CalcDate(StrSubstNo('+%1M+FM', NbrMois), DateDeb) > DateFin;
        MntRet := 0;
        if (DateDebT = 0D) or (DateFinT = 0D) or (DateFinT < "Date d'effet") or (DateDebT > "Date fin Prêt")
             or ("Date d'effet" = "Date fin Prêt") then
            exit;
        DateDebT := CalcDate('-27J+FM+1J', DateDebT);
        DateFinT := CalcDate('-27J+FM', DateFinT);
        DateJ := DateDeb;
        // Amortissement Dégressif
        case "type amortissement" of
            0:
                begin
                    // IF "type amortissement"=0 THEN BEGIN
                    j := -1;
                    repeat
                        j := j + 1;
                        if DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb) then
                            MntRet := MntRet + ROUND(((MontiniT * "Interest %") / 1200), 0.001);
                        if (NbrMois - j) <> 0 then
                            MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), 0.001);
                    until (DateFinT <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb)) or
                       (DateFin <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb));
                end;
            1:
                begin
                    // ELSE BEGIN
                    j := -1;
                    repeat
                        j := j + 1;

                        //IF DateDebT<=CALCDATE(STRSUBSTNO('+%1M+FM',j),DateDeb) THEN
                        MntRet := MntRet + ROUND(((MontiniT * "Interest %") / 1200), 0.001);
                        if (NbrMois - j) <> 0 then
                            MontiniT := MontiniT - ROUND((MontiniT / (NbrMois - j)), 0.001);
                    until (DateFin <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb));

                    Mnt := ROUND(MntRet / NbrMois, 0.5, '<');
                    Mnt1 := MntRet - (Mnt * (NbrMois - 1));
                    j := -1;
                    MntRet := 0;
                    repeat
                        j := j + 1;
                        if (DateDebT <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb)) then
                            if (CalcDate('+FM', DateDebT) = CalcDate(StrSubstNo('+%1M+FM', j), DateDeb)) and (j = 0) then
                                MntRet := MntRet + Mnt1
                            else
                                MntRet := MntRet + Mnt;
                    until (DateFinT <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb)) or
                       (DateFin <= CalcDate(StrSubstNo('+%1M+FM', j), DateDeb));

                end;
            2:
                begin
                    // Calc Global
                    // Calc Global
                    MntRet := MontiniT * "Interest %" * NbrMois / 1200;
                    /*    j:=-1;
                        REPEAT
                          j:=j+1;
                          IF CALCDATE('+1J',"Date d'effet")>=CALCDATE(STRSUBSTNO('+%1M',j),DateDeb) THEN
                            MntRet := MntRet+ROUND(((MontiniT*"Interest %"* (CALCDATE(STRSUBSTNO('+%1M',j),DateDeb)-
                                      "Date Deblocage"+1))/36000),0.001)
                          ELSE
                            MntRet := MntRet+ROUND(((MontiniT*"Interest %"*(CALCDATE(STRSUBSTNO('+%1M',j),DateDeb)-
                                      CALCDATE(STRSUBSTNO('+%1M',j-1),DateDeb)))/36000),0.001);
                          IF (NbrMois-j)<>0 THEN
                             MontiniT:=MontiniT-ROUND((MontiniT/(NbrMois-j)),0.001);
                      UNTIL   (DateFin<=CALCDATE(STRSUBSTNO('+%1M',j),DateDeb));
                      // Fin Global
                    //  Mnt:=ROUND(MntRet/NbrMois,0.001);
                    */
                    MntRetenue := MntRet;
                    Mnt := MntRet / NbrMois;
                    Mnt1 := ROUND(MntRet - (Mnt * (NbrMois - 1)), 0.001);

                    //MESSAGE(FORMAT(MntRet));
                    j := -1;
                    MntRet := 0;
                    repeat
                        j := j + 1;
                        if (DateDebT <= CalcDate(StrSubstNo('+%1M', j), DateDeb)) then
                            if (CalcDate('+FM', DateDebT) = CalcDate(StrSubstNo('+%1M+FM', j), DateDeb)) and (j = 0) then
                                MntRet := MntRet + Mnt1
                            else
                                MntRet := MntRet + Mnt1;
                    until (DateDebT <= CalcDate(StrSubstNo('+%1M', j), DateDeb));
                    //OR
                    //    (DateFin<=CALCDATE(STRSUBSTNO('+%1M',j),DateDeb));
                    if CalcDate(StrSubstNo('+%1M+FM', 0), DateFin) = CalcDate(StrSubstNo('+%1M+FM', 0), DateFinT) then
                        MntRet := MntRetenue - (Mnt1 * (NbrMois - 1));


                end;
        end;
        //spéciphique ENDA 25/02/2010

    end;
}

