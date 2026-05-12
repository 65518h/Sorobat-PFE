Report 52048893 "Defalcatiuon Paie"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Etat Mensuelle Paie"; "Etat Mensuelle Paie")
        {
            RequestFilterFields = "type calcul paie", Matricule;

            trigger OnAfterGetRecord()
            var
                TXT01: Label 'Consomation congé attribué le : ';
                TXT02: Label 'Jours férier attribué le : ';
                TXT03: Label 'Congé de maladie attribué le :';
                TXT04: Label 'Accident de travail attribué le :';
            begin
                IF Emp.GET(Matricule) THEN BEGIN
                    //Heures Normales
                    IF Heure <> 0 THEN BEGIN
                        Heuresoccasionne1."N° Ligne" := Heuresoccasionne1."N° Ligne" + 10000;
                        Heuresoccasionne1."N° Salarié" := Matricule;
                        Heuresoccasionne1.VALIDATE("N° Salarié", Matricule);
                        Heuresoccasionne1.Date := DatePaie;
                        Heuresoccasionne1."Type Jours" := Heuresoccasionne1."Type Jours"::Normal;
                        Heuresoccasionne1.VALIDATE("Type Jours", Heuresoccasionne1."Type Jours"::Normal);
                        Heuresoccasionne1.Semaine := IntGsemaine;
                        IF Emp."Employee's type" = 0 THEN BEGIN
                            Heuresoccasionne1."Nombre d'heures" := Heure;
                            Heuresoccasionne1."Nbre Jour" := "Nombre de jour";
                            Heuresoccasionne1.VALIDATE("Nombre d'heures", Heure);
                        END
                        ELSE BEGIN
                            Heuresoccasionne1."Nombre d'heures" := 0;
                            Heuresoccasionne1."Nbre Jour" := Heure;
                            Heuresoccasionne1.VALIDATE("Nbre Jour", Heure);
                        END;
                        Heuresoccasionne1."Mois de paiement" := DATE2DMY(DatePaie, 2) - 1;
                        Heuresoccasionne1."Année de paiement" := DATE2DMY(DatePaie, 3);
                        Heuresoccasionne1.Quinzaine := Quinzaine;
                        Heuresoccasionne1.Productivité := Productivité;
                        Heuresoccasionne1."Jour indemnité" := "Nombre de jour";
                        Heuresoccasionne1."Nombre Jours Prime Panier" := "Nombre Jour Prime Panier";
                        Heuresoccasionne1.INSERT;
                    END;

                    //Heures Supp15
                    IF "Heure 15" > 0 THEN BEGIN
                        Heuressupm2.RESET;
                        Heuressupm2."N° Ligne" := Heuressupm2."N° Ligne" + 10000;
                        Heuressupm2."N° Salarié" := Matricule;
                        Heuressupm2.VALIDATE("N° Salarié", Matricule);
                        Heuressupm2."Type Jours" := Heuressupm2."Type Jours"::Normal;
                        Heuressupm2.Semaine := IntGsemaine;
                        Heuressupm2."Taux de majoration" := 1.15;
                        Heuressupm2.VALIDATE("Taux de majoration", 1.15);
                        Heuressupm2.VALIDATE("Type Jours", Heuressupm2."Type Jours"::Normal);
                        Heuressupm2.Date := DatePaie;
                        Heuressupm2."Nombre d'heures" := "Heure 15";
                        Heuressupm2.VALIDATE("Nombre d'heures", "Heure 15");
                        Heuressupm2."Mois de paiement" := DATE2DMY(DatePaie, 2) - 1;
                        Heuressupm2."Année de paiement" := DATE2DMY(DatePaie, 3);
                        Heuressupm2.Quinzaine := Quinzaine;
                        Heuressupm2.INSERT;
                    END;

                    //Heures Supp35
                    IF "Heure 35" > 0 THEN BEGIN
                        Heuressupm2.RESET;
                        Heuressupm2."N° Ligne" := Heuressupm2."N° Ligne" + 10000;
                        Heuressupm2."N° Salarié" := Matricule;
                        Heuressupm2.VALIDATE("N° Salarié", Matricule);
                        Heuressupm2."Type Jours" := Heuressupm2."Type Jours"::Normal;
                        Heuressupm2.Semaine := IntGsemaine;
                        Heuressupm2."Taux de majoration" := 1.35;
                        Heuressupm2.VALIDATE("Taux de majoration", 1.35);
                        Heuressupm2.VALIDATE("Type Jours", Heuressupm2."Type Jours"::Normal);
                        Heuressupm2.Date := DatePaie;
                        Heuressupm2."Nombre d'heures" := "Heure 35";
                        Heuressupm2.VALIDATE("Nombre d'heures", "Heure 35");
                        Heuressupm2."Mois de paiement" := DATE2DMY(DatePaie, 2) - 1;
                        Heuressupm2."Année de paiement" := DATE2DMY(DatePaie, 3);
                        Heuressupm2.Quinzaine := Quinzaine;
                        Heuressupm2.INSERT;
                    END;

                    //Heures Supp50
                    IF "Heure 50" > 0 THEN BEGIN
                        Heuressupm2.RESET;
                        Heuressupm2."N° Ligne" := Heuressupm2."N° Ligne" + 10000;
                        Heuressupm2."N° Salarié" := Matricule;
                        Heuressupm2.VALIDATE("N° Salarié", Matricule);
                        Heuressupm2."Type Jours" := Heuressupm2."Type Jours"::Normal;
                        Heuressupm2.Semaine := IntGsemaine;
                        Heuressupm2."Taux de majoration" := 1.5;
                        Heuressupm2.VALIDATE("Taux de majoration", 1.5);
                        Heuressupm2.VALIDATE("Type Jours", Heuressupm2."Type Jours"::Normal);
                        Heuressupm2.Date := DatePaie;
                        Heuressupm2."Nombre d'heures" := "Heure 50";
                        Heuressupm2.VALIDATE("Nombre d'heures", "Heure 50");
                        Heuressupm2."Mois de paiement" := DATE2DMY(DatePaie, 2) - 1;
                        Heuressupm2."Année de paiement" := DATE2DMY(DatePaie, 3);
                        Heuressupm2.Quinzaine := Quinzaine;
                        Heuressupm2.INSERT;
                    END;

                    //Heures Supp60
                    IF "Heure 60" > 0 THEN BEGIN
                        Heuressupm2.RESET;
                        Heuressupm2."N° Ligne" := Heuressupm2."N° Ligne" + 10000;
                        Heuressupm2."N° Salarié" := Matricule;
                        Heuressupm2.VALIDATE("N° Salarié", Matricule);
                        Heuressupm2."Type Jours" := Heuressupm2."Type Jours"::Normal;
                        Heuressupm2.Semaine := IntGsemaine;
                        Heuressupm2."Taux de majoration" := 1.6;
                        Heuressupm2.VALIDATE("Taux de majoration", 1.6);
                        Heuressupm2.VALIDATE("Type Jours", Heuressupm2."Type Jours"::Normal);
                        Heuressupm2.Date := DatePaie;
                        Heuressupm2."Nombre d'heures" := "Heure 60";
                        Heuressupm2.VALIDATE("Nombre d'heures", "Heure 60");
                        Heuressupm2."Mois de paiement" := DATE2DMY(DatePaie, 2) - 1;
                        Heuressupm2."Année de paiement" := DATE2DMY(DatePaie, 3);
                        Heuressupm2.Quinzaine := Quinzaine;
                        Heuressupm2.INSERT;
                    END;

                    //Heures Supp120
                    IF "Heure 120" > 0 THEN BEGIN
                        Heuressupm2.RESET;
                        Heuressupm2."N° Ligne" := Heuressupm2."N° Ligne" + 10000;
                        Heuressupm2."N° Salarié" := Matricule;
                        Heuressupm2.VALIDATE("N° Salarié", Matricule);
                        Heuressupm2."Type Jours" := Heuressupm2."Type Jours"::Normal;
                        Heuressupm2.Semaine := IntGsemaine;
                        Heuressupm2."Taux de majoration" := 2.2;
                        Heuressupm2.VALIDATE("Taux de majoration", 2.2);
                        Heuressupm2.VALIDATE("Type Jours", Heuressupm2."Type Jours"::Normal);
                        Heuressupm2.Date := DatePaie;
                        Heuressupm2."Nombre d'heures" := "Heure 120";
                        Heuressupm2.VALIDATE("Nombre d'heures", "Heure 120");
                        Heuressupm2."Mois de paiement" := DATE2DMY(DatePaie, 2) - 1;
                        Heuressupm2."Année de paiement" := DATE2DMY(DatePaie, 3);
                        Heuressupm2.Quinzaine := Quinzaine;
                        Heuressupm2.INSERT;
                    END;

                    //PRIME DE Panier
                    //DecGMntIndPanier :=0;
                    IF Panier > 0 THEN
                        IF RecGhumainRessource.GET THEN BEGIN
                            RecGIndemnity.RESET;
                            RecGIndemnity.SETRANGE(Code, RecGhumainRessource."Default Panier");
                            IF RecGIndemnity.FIND('-') THEN
                                DecGMntIndPanier := RecGIndemnity."Default amount";
                            RecGDefaultIndemnity.RESET;
                            RecGDefaultIndemnity.SETRANGE("Indemnity Code", RecGhumainRessource."Default Panier");
                            RecGDefaultIndemnity.SETRANGE("Employment Contract Code", Emp."Emplymt. Contract Code");
                            IF RecGDefaultIndemnity.FIND('-') THEN BEGIN
                                //RecGDefaultIndemnity."Default amount" := DecGMntIndPanier* Panier;
                                RecGDefaultIndemnity.Taux := Panier;
                                RecGDefaultIndemnity.MODIFY;
                            END;
                        END;


                    //Conge
                    DecNbJourConge := Congé;
                    DecNbHeureConge := Absence;
                    IF Congé <> 0 THEN BEGIN
                        EmployeeAbsence1."Entry No." := 1;
                        IF EmployeeAbsence1.FIND('+') THEN
                            EmployeeAbsence1."Entry No." := EmployeeAbsence1."Entry No." + 1;
                        EmployeeAbsence1."Employee No." := Matricule;
                        EmployeeAbsence1.VALIDATE("Employee No.", Matricule);
                        M := DATE2DMY(DatePaie, 2);
                        A := DATE2DMY(DatePaie, 3);
                        EmployeeAbsence1."From Date" := DMY2DATE(1, M, A);
                        EmployeeAbsence1.VALIDATE("From Date", DMY2DATE(1, M, A));
                        //EmployeeAbsence1.VALIDATE("Cause of Absence Code",'');
                        EmployeeAbsence1."Line type" := 2;
                        EmployeeAbsence1."Motif D'absence" := 6;
                        EmployeeAbsence1.Quantity := DecNbJourConge;
                        EmployeeAbsence1."Quantity (Base)" := DecNbJourConge;
                        EmployeeAbsence1."Quantity en Hours" := DecNbHeureConge;
                        EmployeeAbsence1.Description := TXT01 + FORMAT(EmployeeAbsence1."From Date");
                        EmployeeAbsence1.Semaine := IntGsemaine;
                        //EmployeeAbsence1.VALIDATE(Quantity,Absence);
                        EmployeeAbsence1.Semaine := IntGsemaine;
                        //IF Emp."Employee's type" = 0 THEN
                        //  EmployeeAbsence1.Unit := EmployeeAbsence1.Unit::"Heure de travail"
                        //else
                        EmployeeAbsence1.Unit := EmployeeAbsence1.Unit::"Journée de travail";
                        EmployeeAbsence1."User ID" := USERID;
                        EmployeeAbsence1."Last Date Modified" := WORKDATE;
                        EmployeeAbsence1."Posting month" := DATE2DMY(DatePaie, 2) - 1;
                        ;
                        EmployeeAbsence1."Posting year" := DATE2DMY(DatePaie, 3);
                        EmployeeAbsence1.INSERT;
                    END;


                    IF Absence <> 0 THEN BEGIN
                        EmployeeAbsence1."Entry No." := 1;
                        IF EmployeeAbsence1.FIND('+') THEN
                            EmployeeAbsence1."Entry No." := EmployeeAbsence1."Entry No." + 1;
                        EmployeeAbsence1."Employee No." := Matricule;
                        EmployeeAbsence1.VALIDATE("Employee No.", Matricule);
                        M := DATE2DMY(DatePaie, 2);
                        A := DATE2DMY(DatePaie, 3);
                        EmployeeAbsence1."From Date" := DMY2DATE(1, M, A);
                        EmployeeAbsence1.VALIDATE("From Date", DMY2DATE(1, M, A));
                        //EmployeeAbsence1.VALIDATE("Cause of Absence Code",'');
                        EmployeeAbsence1."Line type" := 3;
                        EmployeeAbsence1.Quantity := Absence;
                        EmployeeAbsence1."Quantity (Base)" := Absence;
                        EmployeeAbsence1."Motif D'absence" := 5;
                        // EmployeeAbsence1."Quantity en Hours" := DecNbHeureConge;
                        EmployeeAbsence1.Description := TXT01 + FORMAT(EmployeeAbsence1."From Date");
                        EmployeeAbsence1.Semaine := IntGsemaine;
                        EmployeeAbsence1.VALIDATE(Quantity, Absence);
                        EmployeeAbsence1.Semaine := IntGsemaine;
                        //IF Emp."Employee's type" = 0 THEN
                        //  EmployeeAbsence1.Unit := EmployeeAbsence1.Unit::"Heure de travail"
                        //else
                        EmployeeAbsence1.Unit := EmployeeAbsence1.Unit::"Journée de travail";
                        EmployeeAbsence1."User ID" := USERID;
                        EmployeeAbsence1."Last Date Modified" := WORKDATE;
                        EmployeeAbsence1."Posting month" := DATE2DMY(DatePaie, 2) - 1;
                        ;
                        EmployeeAbsence1."Posting year" := DATE2DMY(DatePaie, 3);
                        EmployeeAbsence1.INSERT;
                    END;


                    //DSFT AGA 11/03/10
                    RecGContrat.GET(Matricule);
                    RecGRegime.GET(RecGContrat."Regimes of work");
                    IF Férier <> 0 THEN BEGIN
                        EmployeeAbsence1."Entry No." := 1;
                        IF EmployeeAbsence1.FIND('+') THEN
                            EmployeeAbsence1."Entry No." := EmployeeAbsence1."Entry No." + 1;
                        EmployeeAbsence1."Employee No." := Matricule;
                        EmployeeAbsence1.VALIDATE("Employee No.", Matricule);
                        M := DATE2DMY(DatePaie, 2);
                        A := DATE2DMY(DatePaie, 3);
                        EmployeeAbsence1."From Date" := DMY2DATE(1, M, A);
                        EmployeeAbsence1.VALIDATE("From Date", DMY2DATE(1, M, A));
                        EmployeeAbsence1."Line type" := 11;
                        EmployeeAbsence1.Quantity := Férier;
                        EmployeeAbsence1."Quantity (Base)" := Férier;
                        EmployeeAbsence1."Motif D'absence" := 0;
                        EmployeeAbsence1."Quantity en Hours" := Férier * RecGRegime."From Work day to Work hour";
                        EmployeeAbsence1.Description := TXT02 + FORMAT(EmployeeAbsence1."From Date");
                        EmployeeAbsence1.Semaine := IntGsemaine;
                        EmployeeAbsence1.Semaine := IntGsemaine;
                        EmployeeAbsence1.Unit := EmployeeAbsence1.Unit::"Journée de travail";
                        EmployeeAbsence1."User ID" := USERID;
                        EmployeeAbsence1."Last Date Modified" := WORKDATE;
                        EmployeeAbsence1."Posting month" := DATE2DMY(DatePaie, 2) - 1;
                        ;
                        EmployeeAbsence1."Posting year" := DATE2DMY(DatePaie, 3);
                        EmployeeAbsence1.INSERT;
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                Heuressupm.DELETEALL;
                IF SalaryHeaders.FIND('-') THEN BEGIN
                    EmployeeAbsence.DELETEALL;
                    Heuresoccasionnel.DELETEALL;
                    Heuresoccasionne1.DELETEALL;
                END;
                IF DatePaie = 0D THEN
                    ERROR('Vou devez saisir une date pour la calcule de paie !!!!');

                IntGsemaine := DATE2DWY(DatePaie, 2);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(options)
                {
                    field("CHOISIR LA DATE DE PAIE"; DatePaie)
                    {
                        Caption = 'CHOISIR LA DATE DE PAIE';

                    }
                    field("Choisir la quinzaine"; Quinzaine)
                    {
                        Caption = 'Choisir la quinzaine';

                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin

        MESSAGE('Importaion des données pointage avec succée');
    end;

    var
        DefaultIndemnities: Record "Default Indemnities";
        Heuressupm: Record "Heures sup. m";
        Emp: Record 5200;
        Heuressupm1: Record "Heures sup. m";
        SalaryHeaders: Record "Salary Headers";
        Heuresoccasionnel: Record "Heures occasionnelles";
        Heuresoccasionne1: Record "Heures occasionnelles";
        EmployeeAbsence: Record 5207;
        EmployeeAbsence1: Record 5207;
        M: Integer;
        A: Integer;
        DatePaie: Date;
        EmployeeAbsence2: Record 5207;
        Heuressupm2: Record "Heures sup. m";
        HSU75: Record "Heures sup. m";
        RecGRegime: Record "Regimes of work";
        RecGContrat: Record 5211;
        DecGTauxHS: Decimal;
        DecGNBHeure: Decimal;
        text1: Label 'Vérifier le régime de travail de l''employé %1';
        DecGNBHeureMaj: Integer;
        IntGsemaine: Integer;
        "-----Panier------": Integer;
        RecGhumainRessource: Record 5218;
        RecGDefaultIndemnity: Record "Default Indemnities";
        RecGIndemnity: Record "Indemnity";
        DecGMntIndPanier: Decimal;
        DecNbJourConge: Decimal;
        DecNbHeureConge: Decimal;
        Quinzaine: Option "1er","2ème",Autre;
        PrimeProductivite: Decimal;
        Nombrejour: Decimal;
        Heureoccasionnellesenreg: Record "Heures occa. enreg. m";
        DecGMntIndRF: Decimal;
        DecGMntIndexp: Decimal;
        DecGMntIndSalisure: Decimal;
        DecGMntIndDouche: Decimal;
        congee: Record "Employee's days off Entry";
}

