//HS
xmlport 50103 "Disquette Virement Model"
{

    ///ID Nav 39001401
    DefaultFieldsValidation = false;
    Direction = Export;
    Format = FixedText;
    schema
    {
        textelement(NodeName1)
        {
            tableelement("SalaryHeaders"; "Salary Headers")
            {
                SourceTableView = WHERE("No." = FILTER('<>SIMULATION'));
                RequestFilterFields = "No.";
                AutoSave = TRUE;
                AutoUpdate = TRUE;
                // MinOccurs = Zero;

                textattribute(Sens)
                {
                    Width = 1;
                }

                textattribute(CodeValeur)
                {
                    Width = 2;
                }

                textattribute(RibSoc)
                {
                    Width = 20;
                }

                textattribute(DateOp)
                {
                    Width = 8;
                }

                textattribute(NumLot)
                {
                    Width = 4;
                }

                textattribute(CodeEnre)
                {
                    Width = 2;
                }

                textattribute(CodeDev)
                {
                    Width = 3;
                }

                textattribute(Rang)
                {
                    Width = 5;
                }

                textattribute(Montantcum)
                {
                    Width = 12;
                }

                textattribute(NbrEnrg)
                {
                    Width = 10;
                }

                textattribute(Raisonsociale)
                {
                    Width = 30;
                }

                textattribute(RefPaiment)
                {
                    Width = 20;
                }

                textattribute(DateOp2)
                {
                    Width = 8;
                }

                textattribute(Filler)
                {
                    Width = 155;
                }
                trigger OnPreXmlItem()
                begin

                    IF CodeBanque = '' THEN
                        ERROR('Précisez la banque');
                    TEST();
                end;

                trigger OnAfterGetRecord()
                begin

                end;
            }
            tableelement("SalaryLinesElement"; "Salary Lines")
            {
                SourceTableView = SORTING("No.", Employee) ORDER(Ascending) WHERE("No." = FILTER('<>SIMULATION'));


                AutoSave = TRUE;
                AutoUpdate = TRUE;
                // MinOccurs = Zero;

                textattribute(SensLine)
                {
                    Width = 1;
                }

                textattribute(codevaleurLine)
                {
                    Width = 2;
                }

                textattribute(RibSocLine)
                {
                    Width = 20;
                }

                textattribute(DateOpLine)
                {
                    Width = 8;
                }

                textattribute(NumLotLine)
                {
                    Width = 4;
                }

                textattribute(CodeEnreDet)
                {
                    Width = 2;
                }

                textattribute(CodeDevLine)
                {
                    Width = 3;
                }

                textattribute(RangLine)
                {
                    Width = 5;
                }

                textattribute(MontantVir)
                {
                    Width = 12;
                }

                textattribute(NumVir)
                {
                    Width = 7;
                }

                textattribute(RibSal)
                {
                    Width = 20;
                }

                textattribute(NomSaL)
                {
                    Width = 30;
                }

                textattribute(MATSAL)
                {
                    Width = 20;
                }

                textattribute(Filler1)
                {
                    Width = 3;
                }

                textattribute(MotifOpr)
                {
                    Width = 30;
                }

                textattribute(Filler2)
                {
                    Width = 113;
                }
                trigger OnPreXmlItem()
                begin
                    SalaryLinesElement.SETFILTER("No.", NumPaie)
                end;

                trigger OnAfterGetRecord()
                begin

                    RibSal := '';
                    SitRes := 0;
                    TypeCpt := 1;
                    NatCptB := '';
                    DossEch := 1;
                    MATSAL := '';
                    FilDet := '';
                    NomSaL := '';
                    MontantN := '';
                    MontantN1 := '';
                    MontantN2 := '';
                    DiffMontantN := 0;
                    Filler1 := '000';
                    SalaryLines.RESET;
                    SalaryLines.SETRANGE("No.", NumPaie);
                    // AGA SalaryLines.SETRANGE("Payment Method Code","Payment Method Code"::Virement);
                    SalaryLines.SETRANGE(Employee, SalaryLinesElement.Employee);

                    IF SalaryLines.FIND('-') THEN BEGIN
                        IF (SalaryLines."Bank Account Code" <> '') THEN BEGIN
                            i := i + 1;
                            MATSAL := SalaryLines.Employee;
                            DiffMontantN := 0;
                            MontantN := '';
                            MontantVir := '';
                            DiffNum := 0;
                            NumN := '';
                            NumVir := '';
                            MotifOpr := 'VIREMENT SALAIRE ' + FORMAT(SalaryLines.Month) + ' ' + FORMAT(SalaryLines.Year);//KG
                            RecBankAccount.RESET;
                            RecBankAccount.SETRANGE("No.", CodeBanque);
                            IF RecBankAccount.FIND('-') THEN
                                RibSoc := RecBankAccount."Bank Branch No." + COPYSTR(RecBankAccount."Agency Code", 3, 3) +
                                       RecBankAccount."Bank Account No." + FORMAT(RecBankAccount."RIB Key");
                            RibSocLine := RecBankAccount."Bank Branch No." + COPYSTR(RecBankAccount."Agency Code", 3, 3) +
                                      RecBankAccount."Bank Account No." + FORMAT(RecBankAccount."RIB Key");
                            CdeInsDes := infosoc."Bank Branch No.";
                            // AGA    CdeCentRegAgence := infosoc."Code Agence";
                            comptebqSal.RESET;
                            comptebqSal.SETRANGE("Employee No.", SalaryLines.Employee);
                            comptebqSal.SETRANGE(Code, SalaryLines."Bank Account Code");

                            IF comptebqSal.FIND('-') THEN
                                RibSal := comptebqSal."Bank Account No.";// AGA + FORMAT(comptebqSal."Clé RIB");
                            NomSaL := SalaryLinesElement.Name;
                            MontantN1 := FORMAT(ROUND(ROUND(SalaryLinesElement."Net salary cashed", 0.001) * 1000, ParamCpta."Amount Rounding Precision") * 1000);
                            MontantN2 := DELCHR(MontantN1, '=', '.');
                            MontantN2 := DELCHR(MontantN2, '=', ',');
                            MontantN2 := DELCHR(MontantN2, '=', ' ');

                            DiffMontantN := (15 - STRLEN(FORMAT(MontantN2)));
                            IF DiffMontantN <> 0 THEN
                                REPEAT
                                    MontantN := INSSTR(MontantN, '0', 1);
                                    DiffMontantN := DiffMontantN - 1;
                                UNTIL DiffMontantN = 0;
                            MontantVir := MontantN + MontantN2;
                            DiffNum := (7 - STRLEN(FORMAT(i)));
                            IF DiffNum <> 0 THEN
                                REPEAT
                                    NumN := INSSTR(NumN, '0', 1);
                                    DiffNum := DiffNum - 1;
                                UNTIL DiffNum = 0;
                            NumVir := NumN + FORMAT(i);
                            CdeEnregCompl := '0';
                            NbEnregComp := '00';
                            DateComp := '00000000';
                            MotifRejet := '00000000';

                            SalaryHeaders.RESET;
                            SalaryHeaders.FIND('-');
                        END
                        ELSE
                            currXMLport.SKIP;
                    END
                    ELSE
                        currXMLport.SKIP;
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Genaral)
                {

                    field(CodeBanque; CodeBanque)
                    {
                        ApplicationArea = all;
                        Caption = 'Code Banque BIAT';
                        TableRelation = "Bank Account";
                    }

                }
            }
        }

        actions
        {
            area(processing)
            {


            }
        }
    }
    trigger OnPostXmlPort()
    begin
        //  COMMIT;
    end;

    trigger OnInitXmlPort()
    begin
        Année := DATE2DWY(WORKDATE, 3);
    end;

    trigger OnPreXmlPort()
    begin

        //Debut Mehdi
        Sens := '1';
        codevaleur := '10';
        codevaleurLine := '10';
        NatureRemettant := '1';
        CodeRemettant := '00';
        CodeCentreRegional := '000';
        DateOp := FORMAT(TODAY, 8, '<year4><Month,2><day,2>');
        DateOp2 := FORMAT(TODAY, 8, '<year4><Month,2><day,2>');
        DateOpLine := FORMAT(TODAY, 8, '<year4><Month,2><day,2>');
        NumLot := '0001';
        NumLotLine := '0001';
        CodeEnre := '11';
        CodeDev := '788';
        CodeDevLine := '788';
        Rang := '00000';
        RangLine := '00000';
        Filler := ' ';
        Filler1 := ' ';
        Filler2 := ' ';
        CodeEnreDet := '21';
        i := 0;
        currXMLport.FILENAME := STRSUBSTNO('VIREMENTBIAT');
        //Fin Mehdi

    end;

    procedure TEST()
    begin

        infosoc.GET;
        Raisonsociale := infosoc.Name;
        ParamCpta.GET;

        //--------------------------------DEBUT ENREGISTREMENT GLOBALE---------------
        RecBankAccount.RESET;
        RecBankAccount.SETRANGE("No.", CodeBanque);
        IF RecBankAccount.FIND('-') THEN
            RibSoc := RecBankAccount."Bank Branch No." + COPYSTR(RecBankAccount."Agency Code", 3, 3) +
                      RecBankAccount."Bank Account No." + FORMAT(RecBankAccount."RIB Key");
        RibSocLine := RecBankAccount."Bank Branch No." + COPYSTR(RecBankAccount."Agency Code", 3, 3) +
                             RecBankAccount."Bank Account No." + FORMAT(RecBankAccount."RIB Key");
        infosoc.GET;
        EnteteSalaire.RESET;
        IF EnteteSalaire.FIND('-') THEN BEGIN


            SalaryLines.RESET;
            SalaryLines.SETRANGE("No.", EnteteSalaire."No.");
            SalaryLines.SETFILTER("Bank Account Code", '<>%1', '');
            // AGA SalaryLines.SETFILTER("Payment Method Code",'%1',2);
            IF SalaryLines.FIND('-') THEN
                REPEAT
                    TotalL += ROUND(SalaryLines."Net salary cashed", ParamCpta."Amount Rounding Precision") * 1000;
                UNTIL SalaryLines.NEXT = 0;
            Total1 := FORMAT(TotalL);
            Total1 := DELCHR(Total1, '=', ' ');
            Total1 := DELCHR(Total1, '=', '.');
            Total1 := DELCHR(Total1, '=', ',');
            Total1 := DELCHR(Total1, '=', ';');
            Montantcum := Total1;


        END;




        EnteteSalaire.RESET;
        IF EnteteSalaire.FIND('-') THEN BEGIN
            EnteteSalaire.CALCFIELDS("Net salary cashed");
            EnteteSalaire.CALCFIELDS("Salary lines");
            NumPaie := '';
            NumPaie := EnteteSalaire."No.";

            mois := EnteteSalaire.Month + 1;
            Année := EnteteSalaire.Year;
            IF mois < 9 THEN
                MoisM := FORMAT(0) + FORMAT(mois)
            ELSE
                MoisM := FORMAT(mois);

            NbrEnrg := FORMAT(SalaryLines.COUNT);
            Total1 := FORMAT(ROUND(SalaireNet("SalaryHeaders"."No."), ParamCpta."Amount Rounding Precision") * 1000);

            Total1 := DELCHR(Total1, '=', ' ');
            Total := Total1;
        END;
        //--------------------Nombre enregistrement-------------
        difNbrEnrg := (10 - STRLEN(NbrEnrg));
        IF difNbrEnrg <> 0 THEN
            REPEAT
                NbrEnrg := INSSTR(NbrEnrg, '0', 1);
                difNbrEnrg := difNbrEnrg - 1;
            UNTIL difNbrEnrg = 0;
        AnnéeM := COPYSTR(FORMAT(Année), 1, 4);
        //--------------------Montant Virrement-------------
        DiffMnt := (12 - STRLEN(Montantcum));
        IF DiffMnt <> 0 THEN
            REPEAT
                Montantcum := INSSTR(Montantcum, '0', 1);
                DiffMnt := DiffMnt - 1;
            UNTIL DiffMnt = 0;
        FILT := '';
        //--------------------------------FIN ENREGISTREMENT GLOBALE  ---------------
    end;

    procedure SalaireNet(No: Code[20]) netsalary: Decimal
    var

        LigneSalaire: Record "Salary Lines";
    begin

        netsalary := 0;
        LigneSalaire.SETFILTER("No.", No);
        // AGA LigneSalaire.SETFILTER("Payment Method Code",'%1',2);
        IF LigneSalaire.FIND('-') THEN
            REPEAT
                netsalary := netsalary + LigneSalaire."Net salary cashed";
            UNTIL LigneSalaire.NEXT = 0;
    end;

    var
        AnnéeM: Text[4];
        MoisM: Text[2];

        Année: Integer;
        Total: Code[15];
        mois: Integer;
        infosoc: Record "Company Information";
        mm: Text[10];
        Mnt: Text[10];
        EnteteSalaire: Record "Salary Headers";
        NomSociete: Code[30];
        //  NbrEnrg: Code[10];
        FILT: Code[110];
        difNbrEnrg: Integer;
        DiffMnt: Integer;
        NomSoc: Code[60];
        MontantN: Code[15];
        DiffMontantN: Integer;
        MotifOp: Code[45];
        SitRes: Integer;
        TypeCpt: Integer;
        NatCptB: Code[1];
        DossEch: Integer;
        FilDet: Code[3];
        Total1: Code[15];
        MontantN1: Code[15];
        //    SalaryHeaders: Record "Salary Headers";
        SalaryLines: Record "Salary Lines";
        MontantN2: Code[15];
        "---Mehdi MSF---": Integer;         // Renommé car "---Mehdi MSF---" invalide
        "---Global---": Integer;         // Renommé car "---Global---" invalide


        NatureRemettant: Code[1];
        CodeRemettant: Code[2];
        CodeCentreRegional: Code[3];


        "---Detail---": Integer;         // Renommé car "---Detail---" invalide
        // CodeEnreDet: Code[2];
        // MontantVir: Code[15];
        // NumVir: Code[7];

        CdeInsDes: Code[2];
        CdeCentRegAgence: Code[3];
        //    RibSal: Code[20];
        //   NomSaL: Code[30];

        CdeEnregCompl: Code[2];
        NbEnregComp: Code[2];
        //   MotifOpr: Code[75];
        DateComp: Code[8];
        MotifRejet: Code[8];
        //   Filler1: Code[3];

        DiffNum: Integer;
        NumN: Code[7];

        comptebq: Record "Bank Account";
        ParamCpta: Record "General Ledger Setup";
        NumPaie: Code[20];
        comptebqSal: Record "Employee Bank Account";
        RecBankAccount: Record "Bank Account";
        CodeBanque: Code[10];
        // MATSAL: Code[20];
        // Filler2: Code[113];

        i: Integer;
        TotalL: Decimal;


}