TableExtension 50143 "Employee AbsenceEXT" extends "Employee Absence"
{
    fields
    {
        modify(Description)
        {
            //GL2024   Editable = false;

            Caption = 'Description';


        }
        modify("Unit of Measure Code")
        {
            TableRelation = "Unit of Measure";
        }
        modify(Comment)
        {
            Description = 'Modification (CalcFormula)';
        }


        modify("Employee No.")
        {
            trigger OnAfterValidate()
            begin
                CLEAR(contratT);
                //GL2024
                Employee.GET("Employee No.");
                //GL2024 FIN
                contratT.GET(Employee."Emplymt. Contract Code");
                Nom := Employee."Last Name";
                prenom := Employee."First Name";
                //Direction := Employee."Service";
                service := Employee."Service";
                section := Employee.Section;
                //contratT.TESTFIELD("Code Calendar");

                IF contratT."Type Calendar" = contratT."Type Calendar"::Roulement THEN
                    Employee.TESTFIELD("Date Debut Roulement");
                // RB SORO 28/04/2016
                /*  IF RecEmployeeCg.GET("Employee No.") THEN BEGIN
                      RecEmployeeCg.CALCFIELDS("Days off =");
                      "Droit Conge" := RecEmployeeCg."Days off =";
                  END;*/
                // RB SORO 28/04/2016
            end;
        }
        modify("From Date")
        {
            trigger OnBeforeValidate()
            begin
                "Heure Debut" := 0T;
                "Heure Fin" := 0T;
                CLEAR(Quantity);
                IF (Quantity > 0) THEN BEGIN
                    Employee.GET("Employee No.");
                    CLEAR(contratT);
                    contratT.GET(Employee."Emplymt. Contract Code");
                    CLEAR(Regim);
                    Regim.GET(contratT."Regimes of work");
                    IF (Quantity > 1) THEN BEGIN
                        IF Unit = 0 THEN BEGIN
                            IF (Quantity <> ROUND(Quantity, 1)) THEN
                                "To Date" := "From Date" + (Quantity DIV 1)
                            ELSE
                                "To Date" := "From Date" + (Quantity DIV 1) - 1;
                        END
                        ELSE BEGIN
                            IF (Quantity DIV (Regim."Work Hours per month" / Regim."Worked Day Per Month")) <>
                             ROUND((Quantity DIV (Regim."Work Hours per month" / Regim."Worked Day Per Month")), 1) THEN
                                "To Date" := "From Date" + (Quantity DIV (Regim."Work Hours per month" / Regim."Worked Day Per Month"))
                            ELSE
                                "To Date" := "From Date" + (Quantity DIV (Regim."Work Hours per month" / Regim."Worked Day Per Month")) - 1;
                        END;
                    END
                    ELSE
                        "To Date" := "From Date";
                    IF "Line type" IN [1, 6] THEN
                        "To Date" := "From Date";

                END;
                IF Quantity = 0 THEN
                    "To Date" := "From Date";
                ParamRess.GET;
                IF "Line type" = 6 THEN
                    "Date Validité" := CALCDATE(STRSUBSTNO('+%1', ParamRess."Validité Recuperation"), "From Date");

                IF DATE2DMY("To Date", 1) > ParamRess."Date de Calcul de Paie" THEN BEGIN
                    IF DATE2DMY("To Date", 2) = 12 THEN BEGIN
                        "Posting month" := 0;
                        "Posting year" := DATE2DMY("To Date", 3) + 1;
                    END
                    ELSE BEGIN
                        "Posting month" := DATE2DMY("To Date", 2);
                        "Posting year" := DATE2DMY("To Date", 3);
                    END;
                END ELSE BEGIN
                    "Posting month" := DATE2DMY("To Date", 2) - 1;
                    "Posting year" := DATE2DMY("To Date", 3);
                END;
            end;
        }


        modify("To Date")
        {
            trigger OnAfterValidate()
            begin
                IF "Line type" <> 1 THEN BEGIN
                    Quantity := Abscode.CalcJourHeureAbs(Rec, JN);
                    IF Unit <> JN THEN
                        Unit := JN;
                END;
            end;
        }

        modify("Cause of Absence Code")
        {
            trigger OnAfterValidate()
            begin
                CauseOfAbsence.Get("Cause of Absence Code");
                CASE CauseOfAbsence.Type OF
                    0:
                        "Line type" := 0;
                    1:
                        "Line type" := 1;
                    2:
                        "Line type" := 2;
                    3:
                        "Line type" := 3;
                    4:
                        "Line type" := 4;
                    5:
                        "Line type" := 5;
                    6:
                        "Line type" := 6;
                    7:
                        "Line type" := 7;
                    8:
                        "Line type" := 8;
                    9:
                        "Line type" := 9;
                    10:
                        "Line type" := 10;
                    11:
                        "Line type" := 11;
                END;
                ParamRess.GET;
                IF "Line type" = 6 THEN
                    "Date Validité" := CALCDATE(STRSUBSTNO('+%1', ParamRess."Validité Recuperation"), "From Date");
                "To impute on fays off" := CauseOfAbsence."Imputable Sur Congé";
                "Motif D'absence" := CauseOfAbsence."Motif D'absence";

            end;
        }

        modify(Quantity)
        {

            trigger OnAfterValidate()
            begin
                Employee.GET("Employee No.");
                CLEAR(contratT);
                contratT.GET(Employee."Emplymt. Contract Code");
                CLEAR(Regim);
                Regim.GET(contratT."Regimes of work");
                IF (Quantity > 1) THEN BEGIN
                    IF Unit = 0 THEN BEGIN
                        IF (Quantity <> ROUND(Quantity, 1)) THEN
                            "To Date" := "From Date" + (Quantity DIV 1)
                        ELSE
                            "To Date" := "From Date" + (Quantity DIV 1) - 1;
                    END
                    ELSE BEGIN
                        IF (Quantity DIV (Regim."Work Hours per month" / Regim."Worked Day Per Month")) <>
                         ROUND((Quantity DIV (Regim."Work Hours per month" / Regim."Worked Day Per Month")), 1) THEN
                            "To Date" := "From Date" + (Quantity DIV (Regim."Work Hours per month" / Regim."Worked Day Per Month"))
                        ELSE
                            "To Date" := "From Date" + (Quantity DIV (Regim."Work Hours per month" / Regim."Worked Day Per Month")) - 1;
                    END;
                END

                ELSE
                    "To Date" := "From Date";
                ParamRess.GET;
                IF "Line type" IN [1, 6] THEN
                    "To Date" := "From Date";

                IF DATE2DMY("To Date", 1) > ParamRess."Date de Calcul de Paie" THEN BEGIN
                    IF DATE2DMY("To Date", 2) = 12 THEN BEGIN
                        "Posting month" := 0;
                        "Posting year" := DATE2DMY("To Date", 3) + 1;
                    END
                    ELSE BEGIN
                        "Posting month" := DATE2DMY("To Date", 2);
                        "Posting year" := DATE2DMY("To Date", 3);
                    END;
                END ELSE BEGIN
                    "Posting month" := DATE2DMY("To Date", 2) - 1;
                    "Posting year" := DATE2DMY("To Date", 3);
                END;

                AbsEng.RESET;
                AbsEng.SETCURRENTKEY("Employee No.", "Line type", "From Date");
                AbsEng.SETRANGE("Employee No.", "Employee No.");
                AbsEng.SETRANGE("Line type", 6, 7);
                AbsEng.SETRANGE("From Date", CALCDATE('-29J', "From Date"), "From Date");
                AbsEng.CALCSUMS("Quantity (Hours)");

            end;
        }

        field(50020; Direction; Code[10])
        {
        }
        field(50021; service; Code[10])
        {
        }
        field(50022; section; Code[10])
        {
        }
        field(50050; "Heure Debut"; Time)
        {

            trigger OnValidate()
            begin
                Clear("Heure Fin");
            end;
        }
        field(50051; "Heure Fin"; Time)
        {

            trigger OnValidate()
            begin
                if "Line type" <> 1 then begin
                    Quantity := Abscode.CalcJourHeureAbs(Rec, JN);
                    if Unit <> JN then
                        Unit := JN;
                end;
            end;
        }
        field(50100; "Quantity en Hours"; Decimal)
        {
        }
        field(50101; Semaine; Integer)
        {
        }
        field(50102; "Droit Conge"; Decimal)
        {
            Description = 'RB SORO 30/04/2016';
        }
        field(39001410; "Motif D'absence"; Option)
        {
            OptionMembers = " ","Absence Irrég.","Congé sans Solde",Retard,"Congé de Maladie","Accident de travail","Congé","Congé Spécial";
        }
        field(39001460; "Date Validité"; Date)
        {
        }
        field(39001470; "Recuperation Entry No."; Integer)
        {

            trigger OnLookup()
            begin
                //MBY 19/01/2012 IF  "Line type"="Line type"::"Consomation Recup" THEN BEGIN
                if "Line type" = 2 then begin
                    Absengtmp.Reset;
                    Absengtmp.SetCurrentkey("Employee No.", "Line type", "Date Validité");
                    Absengtmp.SetFilter("Date Validité", '..%1', "To Date");
                    Absengtmp.SetFilter("Employee No.", "Employee No.");
                    Absengtmp.SetRange("Line type", 1);
                    Clear(FrmAbs);
                    FrmAbs.SetTableview(Absengtmp);
                    FrmAbs.LookupMode := true;
                    //FrmAbs.Setrecup(TRUE);
                    if FrmAbs.RunModal = Action::LookupOK then begin
                        FrmAbs.GetRecord(Absengtmp);
                        "Recuperation Entry No." := Absengtmp."Entry No.";
                    end;
                end;
            end;

            trigger OnValidate()
            begin
                Error('vous devez selectionner de la liste !!!!');
            end;
        }
        field(39001480; "Filter Date"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(39001481; "To impute on fays off"; Boolean)
        {
            Caption = 'To impute on fays off';
            Editable = false;
        }
        field(39001482; Unit; Option)
        {
            Caption = 'Unit';
            OptionCaption = 'Work day,Work hour';
            OptionMembers = "Journée de travail","Heure de travail";
        }
        field(39001483; "Posting month"; Option)
        {
            Caption = 'Posting month';
            OptionCaption = 'January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = January," February"," March"," April"," May"," June"," July"," August"," September"," October"," November"," December";
        }
        field(39001484; "Posting year"; Integer)
        {
            Caption = 'Posting year';
        }
        field(39001485; "Line type"; Option)
        {
            Caption = 'Line type';
            OptionCaption = ' ,Day off Right,Day off Consumption,Non paid,1/2 paid,Non Comptabiliser,Droit Recuperayion,Consomation Recup';
            OptionMembers = " ","Day off Right","Day off Consumption","Non paid","1/2 paid","Non Comptabiliser","Droit Recuperation","Consomation Recup","Deductible of Prime","1/2 Paid deductible of prime","Jour  férié","Jour  férié payé ";
        }
        field(39001486; "User ID"; Code[50])
        {
            Editable = false;
            TableRelation = User;
        }
        field(39001487; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(39001488; Nom; Text[30])
        {
            Editable = false;
        }
        field(39001489; prenom; Text[60])
        {
            Editable = false;
        }
        field(39001490; Quinzainea; Option)
        {
            OptionCaption = '1er,2ème';
            OptionMembers = "1er","2ème";
        }
    }
    keys
    {

        /* GL2024 key(STG_Key1; "Entry No.", "Employee No.")
          {
              // Clustered = true;
          }*/

        key(STG_Key6; "Employee No.", "Cause of Absence Code", "To Date")
        {
            SumIndexFields = Quantity;
        }
        key(STG_Key7; "Cause of Absence Code", "From Date")
        {
            SumIndexFields = Quantity;
        }

        /*GL2024     key(STG_Key8; "Unit of Measure Code", Unit)
             {
                 SumIndexFields = Quantity;
             }*/





    }


    trigger OnAfterInsert()
    begin
        IF "From Date" = 0D THEN
            "From Date" := WORKDATE;
        "User ID" := USERID;
    end;

    trigger OnModify()
    begin
        "User ID" := USERID;
    end;

    trigger OnRename()
    begin
        "User ID" := USERID;
    end;

    procedure calcqte(var DateT: Date)
    var
        j: Integer;
        datdeb1: Time;
        dateDeb2: Time;
        datefin1: Time;
        dateFin2: Time;
        nowork: Boolean;
        JourFree: Boolean;
    begin
    end;

    procedure actualiserdate(var Type: Integer)
    begin
    end;

    var
        CalendarMgmt: Codeunit "Calendar Management";
        contratT: Record "Employment Contract";
        jour: Decimal;
        HeureDeb: Time;
        HeureFin: Time;
        HeureDeb2: Time;
        HeureFin2: Time;
        Regim: record "Regimes of work";
        AbsEng: Record "Employee's days off Entry";
        Abscode: Codeunit "Management of absences";
        JN: Integer;
        ParamRess: Record "Human Resources Setup";
        Absengtmp: Record "Employee's days off Entry";
        FrmAbs: page "Recorded Employee's Absences";
        "// RB SORO": Integer;
        RecEmployeeCg: Record Employee;
        Employee: Record Employee;
        CauseOfAbsence: Record "Cause of Absence";
}

