
Table 52049034 "Heures sup. m"
{//GL2024  ID dans Nav 2009 : "39001416"
    //DYS page non migrer
    // DrillDownPageID = 8099050;

    fields
    {
        field(1; "N° Salarié"; Code[20])
        {
            Caption = 'N° Salarié';
            NotBlank = true;
            TableRelation = Employee."No." where(Status = const(Active),
                                                  Blocked = const(false));

            trigger OnValidate()
            begin
                Salarié.Get("N° Salarié");
                "Nom usuel" := Salarié."Last Name";
                Prénom := Salarié."First Name";

                "Code departement" := Salarié."Global Dimension 1 Code";
                "Code dossier" := Salarié."Global Dimension 2 Code";
                "Employee Statistic Group" := Salarié."Statistics Group Code";
                /*HeuresSup.FIND('-');
                //HeuresSup.SETFILTER("N° Salarié",Salarié."No.");
                IF HeuresSup.FIND('+') THEN
                  "N° Ligne" := HeuresSup."N° Ligne" + 1000
                 ELSE
                  "N° Ligne" := 1000;*/

            end;
        }
        field(2; "N° Ligne"; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(3; "Nom usuel"; Text[30])
        {
            Caption = 'Last Name';
            Editable = false;
        }
        field(4; "Prénom"; Text[60])
        {
            Caption = 'First Name';
            Editable = false;
        }
        field(7; Date; Date)
        {
            Caption = 'Date';
            NotBlank = true;

            trigger OnValidate()
            begin
                "Mois de paiement" := Date2dmy(Date, 2) - 1;
                "Année de paiement" := Date2dmy(Date, 3);
            end;
        }
        field(10; "Code departement"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(11; "Code dossier"; Code[20])
        {
            Caption = 'Project Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(15; "Heure debut"; Time)
        {

            trigger OnValidate()
            begin
                "Heure Fin" := 0T;
                "Nombre d'heures" := 0;
            end;
        }
        field(16; "Heure Fin"; Time)
        {

            trigger OnValidate()
            begin
                VALIDATE("Nombre d'heures", (("Heure Fin" - "Heure debut") / 3600000));
            end;
        }
        field(20; "Nombre d'heures"; Decimal)
        {
            Caption = 'Hours number';
            DecimalPlaces = 3 : 3;
            InitValue = 0;

            trigger OnValidate()
            begin
                IF EMP.GET("N° Salarié") THEN BEGIN
                    IF NOT EMP."Heure Supp Sbase+Sursalaire" THEN BEGIN
                        LineGrid.SETRANGE(Catégorie, EMP.Catégorie);
                        LineGrid.SETRANGE(Echelons, EMP.Echelons);
                        IF LineGrid.FINDFIRST THEN BEGIN
                            IF "Taux de majoration" = 1.15 THEN "Montant ligne" := "Nombre d'heures" * LineGrid."Taux Horaire 15%";
                            IF "Taux de majoration" = 1.35 THEN "Montant ligne" := "Nombre d'heures" * LineGrid."Taux Horaire 35%";
                            IF "Taux de majoration" = 1.5 THEN "Montant ligne" := "Nombre d'heures" * LineGrid."Taux Horaire 50%";
                            IF "Taux de majoration" = 1.6 THEN "Montant ligne" := "Nombre d'heures" * LineGrid."Taux Horaire 60%";
                            IF "Taux de majoration" = 2.2 THEN "Montant ligne" := "Nombre d'heures" * LineGrid."Taux Horaire 120%";
                        END;
                    END
                    ELSE BEGIN
                        SalaireBase := 0;
                        Sursalaire := 0;
                        TauxHoraire := 0;
                        IF HumanResourcesSetup.GET THEN;
                        SalaireBase := EMP."Basis salary";
                        DefaultIndemnities.SETRANGE("Employment Contract Code", EMP."No.");
                        DefaultIndemnities.SETRANGE("Indemnity Code", HumanResourcesSetup."Indem Sursalaire");
                        IF DefaultIndemnities.FINDFIRST THEN Sursalaire := DefaultIndemnities."Default amount";
                        TauxHoraire := ROUND((SalaireBase + Sursalaire) / HumanResourcesSetup."Nombre Heure Travail Par Mois", 1);
                        IF "Taux de majoration" = 1.15 THEN "Montant ligne" := "Nombre d'heures" * ROUND(TauxHoraire * 115 / 100, 1);
                        IF "Taux de majoration" = 1.35 THEN "Montant ligne" := "Nombre d'heures" * ROUND(TauxHoraire * 135 / 100, 1);
                        IF "Taux de majoration" = 1.5 THEN "Montant ligne" := "Nombre d'heures" * ROUND(TauxHoraire * 150 / 100, 1);
                        IF "Taux de majoration" = 1.6 THEN "Montant ligne" := "Nombre d'heures" * ROUND(TauxHoraire * 160 / 100, 1);
                        IF "Taux de majoration" = 2.2 THEN "Montant ligne" := "Nombre d'heures" * ROUND(TauxHoraire * 220 / 100, 1);

                    END;
                END;
                Dectarif := 0;
                RecIndemnity.RESET;
                RecIndemnity.SETRANGE("Employment Contract Code", "N° Salarié");
                RecIndemnity.SETRANGE("Inclus dans heures supp", TRUE);
                IF RecIndemnity.FIND('-') THEN
                    REPEAT
                        Dectarif := Dectarif + RecIndemnity."Default amount";
                    UNTIL RecIndemnity.NEXT = 0;

            end;
        }
        field(21; "Tarif unitaire"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit tariff';
            Editable = false;
        }
        field(22; "Montant Ligne"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Montant Ligne';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(70; "Type Jours"; Option)
        {
            OptionMembers = Normal,"Chômé Payé","Chômé Non Payé",Nuit,"jour Repos","Jours Supp Maj 75%","Heure Supp Normal","Prime Astreinte","Heure Maj 25%","Heure Maj 50%","Heure Maj 75%","Heure Maj 100%","Jour(s) Ferie(s)","Congé Annuelle","Congé Exceptionnel","Heures Retenues";
            trigger OnValidate()
            BEGIN
                IF "Type Jours" <> 0 THEN
                    "Type heure" := 0;
            END;
        }
        field(200; "Système"; Boolean)
        {
        }
        field(300; "Paiement No."; Code[20])
        {
        }
        field(50001; "Heures sup. enreg."; Decimal)
        {
            CalcFormula = Sum("Heures sup. eregistrées m"."Nombre d'heures" WHERE("N° Salarié" = FIELD("N° Salarié"), Date = FIELD("Filtre date"), "Type Jours" = CONST(Normal), "Type heure" = FILTER("Heure Sup.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Filtre date"; Date)
        {
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(50003; "Taux de majoration"; Decimal)
        {
            Editable = true;
        }
        field(50004; "Nombre Jours Supp Maj 75%"; Decimal)
        {

            // trigger OnValidate()
            // begin
            //     HumanResourcesSetup.Find('-');
            //     EMP.Reset;
            //     Regimesofwork.Reset;
            //     Regimesofwork.Find('-');
            //     if EmploymentContract.Get("N° Salarié") then;
            //     Regimesofwork.Get(EmploymentContract."Regimes of work");
            //     //EMP.SETRANGE("No.","N° Salarié");
            //     Dectarif := 0;
            //     RecIndemnity.Reset;
            //     RecIndemnity.SetRange("Employment Contract Code", "N° Salarié");
            //     RecIndemnity.SetRange("Inclus dans heures supp", true);
            //     if RecIndemnity.Find('-') then
            //         repeat
            //             Dectarif := Dectarif + RecIndemnity."Default amount";
            //         until RecIndemnity.Next = 0;
            //     if EMP.Get("N° Salarié") then begin
            //         if EMP."Employee's type" = EMP."employee's type"::"Month based" then
            //             DecMntBase := EMP."Basis salary" + Dectarif
            //         else
            //             DecMntBase := EMP."Salaire De Base Horaire" + Dectarif;
            //     end;
            //     "Montant Ligne" := (DecMntBase / Regimesofwork."Worked Day Per Month") * "Nombre Jours Supp Maj 75%" * "Taux de majoration";
            // end;
        }
        field(50005; "Montant Jours Supp"; Decimal)
        {
        }
        field(50006; Affectation; Code[20])
        {
        }
        field(50007; Qualification; Code[20])
        {
        }
        field(50008; "Heure Normal"; Decimal)
        {
        }
        field(50009; Prime; Decimal)
        {
        }
        field(50010; "Mois de paiement"; Option)
        {
            Caption = 'Mois de paiement';
            OptionCaption = 'January,February,March,April,May,June,July,August,September,October,November,December,13rd,14th,Other';
            OptionMembers = Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","14ème",Autre;
        }
        field(50011; "Année de paiement"; Integer)
        {
            Caption = 'Année de paiement';
        }
        field(50012; Semaine; Integer)
        {
        }
        field(50013; "Nombre Jours Congé"; Decimal)
        {

            // trigger OnValidate()
            // begin
            //     if HumanResourcesSetup.Get then;
            //     EMP.Reset;
            //     Regimesofwork.Reset;
            //     Regimesofwork.Find('-');
            //     if EmploymentContract.Get("N° Salarié") then;
            //     Regimesofwork.Get(EmploymentContract."Regimes of work");
            //     //EMP.SETRANGE("No.","N° Salarié");
            //     Dectarif := 0;
            //     RecIndemnity.Reset;
            //     RecIndemnity.SetRange("Employment Contract Code", "N° Salarié");
            //     RecIndemnity.SetRange("Inclus Base Calcul Ferié-Congé", true);

            //     if RecIndemnity.Find('-') then
            //         repeat
            //             Dectarif := Dectarif + RecIndemnity."Default amount";
            //         until RecIndemnity.Next = 0;
            //     if HumanResourcesSetup."Conge Base Salaire De Base" then Dectarif := 0;
            //     if EMP.Get("N° Salarié") then begin
            //         if EMP."Employee's type" = EMP."employee's type"::"Month based" then
            //             DecMntBase := EMP."Basis salary" + Dectarif
            //         else
            //             DecMntBase := EMP."Salaire De Base Horaire" + Dectarif;
            //     end;
            //     "Montant Ligne" := (DecMntBase / Regimesofwork."Worked Day Per Month") * "Nombre Jours Congé" * "Taux de majoration";
            // end;
        }
        field(50014; "Nombre Jours Conge Excep"; Decimal)
        {

            // trigger OnValidate()
            // begin
            //     if HumanResourcesSetup.Get then;
            //     EMP.Reset;
            //     Regimesofwork.Reset;
            //     Regimesofwork.Find('-');
            //     if EmploymentContract.Get("N° Salarié") then;
            //     Regimesofwork.Get(EmploymentContract."Regimes of work");
            //     //EMP.SETRANGE("No.","N° Salarié");
            //     Dectarif := 0;
            //     RecIndemnity.Reset;
            //     RecIndemnity.SetRange("Employment Contract Code", "N° Salarié");
            //     RecIndemnity.SetRange("Inclus Base Calcul Ferié-Congé", true);
            //     //RecIndemnity.SETRANGE("Inclus dans heures supp",TRUE);
            //     if RecIndemnity.Find('-') then
            //         repeat
            //             Dectarif := Dectarif + RecIndemnity."Default amount";
            //         until RecIndemnity.Next = 0;
            //     if HumanResourcesSetup."Conge Base Salaire De Base" then Dectarif := 0;

            //     if EMP.Get("N° Salarié") then begin
            //         if EMP."Employee's type" = EMP."employee's type"::"Month based" then
            //             DecMntBase := EMP."Basis salary" + Dectarif
            //         else
            //             DecMntBase := EMP."Salaire De Base Horaire" + Dectarif;
            //     end;
            //     "Montant Ligne" := (DecMntBase / Regimesofwork."Worked Day Per Month") * "Nombre Jours Conge Excep" * "Taux de majoration";
            // end;
        }
        field(50015; "Nombre Jours Ferié"; Decimal)
        {

            // trigger OnValidate()
            // begin
            //     if HumanResourcesSetup.Get then;
            //     EMP.Reset;
            //     Regimesofwork.Reset;
            //     Regimesofwork.Find('-');
            //     if EmploymentContract.Get("N° Salarié") then;
            //     Regimesofwork.Get(EmploymentContract."Regimes of work");
            //     //EMP.SETRANGE("No.","N° Salarié");
            //     Dectarif := 0;
            //     RecIndemnity.Reset;
            //     RecIndemnity.SetRange("Employment Contract Code", "N° Salarié");
            //     //RecIndemnity.SETRANGE("Non Inclis en Jours Fer",FALSE);
            //     RecIndemnity.SetRange("Inclus Base Calcul Ferié-Congé", true);
            //     if RecIndemnity.Find('-') then
            //         repeat
            //             Dectarif := Dectarif + RecIndemnity."Default amount";
            //         until RecIndemnity.Next = 0;
            //     if HumanResourcesSetup."Conge Base Salaire De Base" then Dectarif := 0;
            //     if EMP.Get("N° Salarié") then begin
            //         if EMP."Employee's type" = EMP."employee's type"::"Month based" then
            //             DecMntBase := EMP."Basis salary" + Dectarif
            //         else
            //             DecMntBase := EMP."Salaire De Base Horaire" + Dectarif;
            //     end;
            //     "Montant Ligne" := (DecMntBase / Regimesofwork."Worked Day Per Month") * "Nombre Jours Ferié" * "Taux de majoration";
            // end;
        }
        field(50016; "Heure Sup Avec S.Brut"; Boolean)
        {
        }
        field(50017; "Nombre Jours Supp Normal"; Decimal)
        {

            // trigger OnValidate()
            // begin
            //     HumanResourcesSetup.Find('-');
            //     EMP.Reset;
            //     Regimesofwork.Reset;
            //     Regimesofwork.Find('-');
            //     if EmploymentContract.Get("N° Salarié") then;
            //     Regimesofwork.Get(EmploymentContract."Regimes of work");
            //     //EMP.SETRANGE("No.","N° Salarié");
            //     Dectarif := 0;
            //     RecIndemnity.Reset;
            //     RecIndemnity.SetRange("Employment Contract Code", "N° Salarié");
            //     RecIndemnity.SetRange("Inclus dans heures supp", true);
            //     if RecIndemnity.Find('-') then
            //         repeat
            //             Dectarif := Dectarif + RecIndemnity."Default amount";
            //         until RecIndemnity.Next = 0;
            //     if EMP.Get("N° Salarié") then begin
            //         if EMP."Employee's type" = EMP."employee's type"::"Month based" then
            //             DecMntBase := EMP."Basis salary" + Dectarif
            //         else
            //             DecMntBase := EMP."Salaire De Base Horaire" + Dectarif;
            //     end;
            //     "Montant Ligne" := (DecMntBase / Regimesofwork."Worked Day Per Month") * "Nombre Jours Supp Normal" * "Taux de majoration";
            // end;
        }
        field(39001450; "Type heure"; Option)
        {
            OptionMembers = "Heure Sup.",Roulement;

            trigger OnValidate()
            begin
                if "Type heure" = 1 then
                    "Type Jours" := 0;
            end;
        }
        field(39001451; "Employee Statistic Group"; Code[30])
        {
            Caption = 'Employee Posting Group';//
            Editable = true;
            TableRelation = "Employee Statistics Group";
        }
        field(39001490; Quinzaine; Option)
        {
            OptionCaption = '1er,2ème,Autre';
            OptionMembers = "1er","2ème",Autre;
        }
    }

    keys
    {
        key(Key1; "N° Ligne")
        {
            Clustered = true;
        }
        key(Key2; "N° Salarié", "N° Ligne", "Code departement", "Code dossier")
        {
            SumIndexFields = "Montant ligne", "Nombre d'heures";
        }
        key(Key3; "Type heure", "N° Salarié", "N° Ligne", "Code departement", "Code dossier")
        {
            SumIndexFields = "Montant ligne", "Nombre d'heures";
        }
    }

    fieldgroups
    {
    }

    var
        "Salarié": Record Employee;
        "PériodeCompta": Record "Accounting Period";
        HeuresSup: Record "Heures sup. m";
        EMP: Record Employee;
        Regimesofwork: Record "Regimes of work";
        EmploymentContract: Record "Employment Contract";
        HumanResourcesSetup: Record "Human Resources Setup";
        DefaultIndemnities: Record "Default Indemnities";
        MNT: Decimal;
        Dectarif: Decimal;
        RecIndemnity: Record "Default Indemnities";
        DecMntBase: Decimal;
        LineGrid: Record "Line grid";
        SalaireBase: Decimal;
        Sursalaire: Decimal;
        TauxHoraire: Decimal;
}

