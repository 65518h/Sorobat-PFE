//HS
xmlport 50108 "Disquette Virement STB"
{


    // DefaultFieldsValidation = false;
    // Direction = Export;
    // Format = FixedText;
    // TableSeparator = '<NewLine>';
    // schema
    // {
    //     textelement(NodeName1)
    //     {
    //         tableelement(Entete; "Entete Lot Paie")
    //         {
    //             SourceTableView = SORTING(Code);
    //             AutoSave = TRUE;
    //             AutoUpdate = TRUE;
    //             // MinOccurs = Zero;
    //             textelement(Sens)
    //             {
    //                 Width = 100;
    //             }


    //             trigger OnPreXmlItem()
    //             begin

    //                 Entete.SETRANGE(Code, CodeLotVirement);

    //             end;

    //             trigger OnAfterGetRecord()
    //             begin


    //                 Entete.CALCFIELDS("Mantant Net");
    //                 infosoc.GET;
    //                 Raisonsociale := infosoc.Name;
    //                 ParamCpta.GET;
    //                 //--------------------------------DEBUT ENREGISTREMENT GLOBALE---------------
    //                 RecBankAccount.RESET;
    //                 RecBankAccount.SETRANGE("No.", CodeBanque);
    //                 IF RecBankAccount.FIND('-') THEN
    //                     RibSoc := RecBankAccount.RIB + 'TDA';

    //                 infosoc.GET;
    //                 IF 1 = 1 THEN BEGIN
    //                     TotalL := ROUND(Entete."Mantant Net", ParamCpta."Amount Rounding Precision") * 1000;
    //                     MntText := DELCHR(FORMAT(TotalL), '=', '0|1|2|3|4|5|6|7|8|9');
    //                     Montantcum := DELCHR(FORMAT(TotalL), '=', '.|,|;| ');
    //                     Montantcum := DELCHR(Montantcum, '=', MntText);
    //                 END;
    //                 // EnteteSalaire.setrange("No."
    //                 // mois  := EnteteSalaire.Month +1;
    //                 // Année := EnteteSalaire.Year;
    //                 // IF mois < 9 THEN
    //                 //  MoisM := FORMAT(0)+FORMAT(mois)
    //                 // ELSE
    //                 //  MoisM :=FORMAT(mois);
    //                 LigneLotPaie.SETRANGE(Code, CodeLotVirement);
    //                 NbrEnrg := FORMAT(LigneLotPaie.COUNT);
    //                 Total1 := FORMAT(ROUND(Entete."Mantant Net", ParamCpta."Amount Rounding Precision") * 1000);

    //                 Total1 := DELCHR(Total1, '=', ' ');
    //                 Total := Total1;





    //                 /*EnteteSalaire.RESET;
    //                                     IF EnteteSalaire.FIND('-') THEN BEGIN
    //                                         EnteteSalaire.CALCFIELDS("Net salary cashed");
    //                                         EnteteSalaire.CALCFIELDS("Salary lines");
    //                                         NumPaie := '';
    //                                         NumPaie := EnteteSalaire."No.";

    //                                         mois := EnteteSalaire.Month + 1;
    //                                         Année := EnteteSalaire.Year;
    //                                         IF mois < 9 THEN
    //                                             MoisM := FORMAT(0) + FORMAT(mois)
    //                                         ELSE
    //                                             MoisM := FORMAT(mois);

    //                                         NbrEnrg := FORMAT(SalaryLines.COUNT);
    //                                         Total1 := FORMAT(ROUND(SalaireNet(Entete."No."), ParamCpta."Amount Rounding Precision") * 1000);

    //                                         Total1 := DELCHR(Total1, '=', ' ');
    //                                         Total := Total1;
    //                                     END;*/
    //                 //--------------------Nombre enregistrement-------------
    //                 difNbrEnrg := (7 - STRLEN(NbrEnrg));
    //                 IF difNbrEnrg <> 0 THEN
    //                     REPEAT
    //                         NbrEnrg := INSSTR(NbrEnrg, '0', 1);
    //                         difNbrEnrg := difNbrEnrg - 1;
    //                     UNTIL difNbrEnrg = 0;
    //                 AnnéeM := COPYSTR(FORMAT(Année), 1, 4);
    //                 //--------------------Montant Virrement-------------
    //                 DiffMnt := (15 - STRLEN(Montantcum));
    //                 IF DiffMnt <> 0 THEN
    //                     REPEAT
    //                         Montantcum := INSSTR(Montantcum, '0', 1);
    //                         DiffMnt := DiffMnt - 1;
    //                     UNTIL DiffMnt = 0;
    //                 FILT := '';
    //                 //--------------------------------FIN ENREGISTREMENT GLOBALE  ---------------

    //             end;
    //         }
    //         tableelement(Entete2; "Entete Lot Paie")
    //         {

    //             SourceTableView = SORTING(Code);
    //             AutoSave = TRUE;
    //             AutoUpdate = TRUE;

    //             textattribute(Sens5)
    //             {
    //                 Width = 1;
    //             }

    //             textattribute(RibSoc)
    //             {
    //                 Width = 23;
    //             }

    //             textattribute(Marge)
    //             {
    //                 Width = 22;
    //             }

    //             textattribute(Montantcum)
    //             {
    //                 Width = 15;
    //             }

    //             textattribute(Sens3)
    //             {
    //                 Width = 4;
    //             }



    //             trigger OnPreXmlItem()
    //             begin
    //                 Entete2.SETRANGE(Code, CodeLotVirement);

    //             end;

    //             trigger OnAfterGetRecord()
    //             begin


    //             end;

    //         }
    //         tableelement("LigneLotPaieElement"; "Ligne Lot Paie")
    //         {

    //             SourceTableView = SORTING(Code, "Matricule Salarié");
    //             AutoSave = TRUE;
    //             AutoUpdate = TRUE;

    //             textattribute(Sens2)
    //             {
    //                 Width = 1;
    //             }

    //             textattribute(RibSal)
    //             {
    //                 Width = 20;
    //             }

    //             textattribute(NomSaL)
    //             {
    //                 Width = 25;
    //             }

    //             textattribute(MontantVir)
    //             {
    //                 Width = 15;
    //             }

    //             textattribute(Sens3Line)
    //             {
    //                 Width = 4;
    //             }

    //             trigger OnPreXmlItem()
    //             begin

    //                 LigneLotPaieElement.SETRANGE(Code, CodeLotVirement);

    //             end;

    //             trigger OnAfterGetRecord()
    //             begin

    //                 RibSal := '';
    //                 SitRes := 0;
    //                 TypeCpt := 1;
    //                 NatCptB := '';
    //                 DossEch := 1;
    //                 MATSAL := '';
    //                 FilDet := '';
    //                 NomSaL := '';
    //                 MontantN := '';
    //                 MontantN1 := '';
    //                 MontantN2 := '';
    //                 DiffMontantN := 0;
    //                 Filler1 := '000';
    //                 SalaryLines.RESET;
    //                 SalaryLines.SETRANGE("No.", NumPaie);
    //                 SalaryLines.SETRANGE(Employee, LigneLotPaieElement."Matricule Salarié");
    //                 IF SalaryLines.FINDFIRST THEN;
    //                 // AGA SalaryLines.SETRANGE("Payment Method Code","Payment Method Code"::Virement);
    //                 //SalaryLines.SETRANGE(Employee,Employee);


    //                 IF 1 = 1 THEN BEGIN
    //                     IF (LigneLotPaieElement.RIB <> '') THEN BEGIN

    //                         i := i + 1;
    //                         MATSAL := LigneLotPaieElement."Matricule Salarié";
    //                         DiffMontantN := 0;
    //                         MontantN := '';
    //                         MontantVir := '';
    //                         DiffNum := 0;
    //                         NumN := '';
    //                         NumVir := '';
    //                         MotifOpr := 'VIREMENT SALAIRE ' + FORMAT(SalaryLines.Month) + ' ' + FORMAT(SalaryLines.Year);//KG
    //                         RecBankAccount.RESET;
    //                         RecBankAccount.SETRANGE("No.", CodeBanque);
    //                         IF RecBankAccount.FIND('-') THEN
    //                             RibSoc := RecBankAccount.RIB;
    //                         CdeInsDes := infosoc."Bank Branch No.";
    //                         // AGA    CdeCentRegAgence := infosoc."Code Agence";

    //                         RibSal := LigneLotPaieElement.RIB;
    //                         NomSaL := LigneLotPaieElement."Nom Salarie";
    //                         MontantN1 := FORMAT(ROUND(ROUND(LigneLotPaieElement."Montant Net", 0.001), ParamCpta."Amount Rounding Precision") * 1000);
    //                         // RB SORO 10/05/2016
    //                         MntTextSal := DELCHR(FORMAT(MontantN1), '=', '0|1|2|3|4|5|6|7|8|9');
    //                         MontantN2 := DELCHR(FORMAT(MontantN1), '=', '.|,|;| ');
    //                         MontantN2 := DELCHR(MontantN2, '=', MntTextSal);
    //                         // RB SORO 10/05/2016
    //                         DiffMontantN := (15 - STRLEN(FORMAT(MontantN2)));
    //                         IF DiffMontantN <> 0 THEN
    //                             REPEAT
    //                                 MontantN := INSSTR(MontantN, '0', 1);
    //                                 DiffMontantN := DiffMontantN - 1;
    //                             UNTIL DiffMontantN = 0;
    //                         MontantVir := MontantN + MontantN2;
    //                         DiffNum := (7 - STRLEN(FORMAT(i)));
    //                         IF DiffNum <> 0 THEN
    //                             REPEAT
    //                                 NumN := INSSTR(NumN, '0', 1);
    //                                 DiffNum := DiffNum - 1;
    //                             UNTIL DiffNum = 0;
    //                         NumVir := NumN + FORMAT(i);
    //                         //MESSAGE('numero de ligne est %1',NumVir);
    //                         CdeEnregCompl := '0';
    //                         NbEnregComp := '00';
    //                         DateComp := '00000';
    //                         MotifRejet := '00000';

    //                         // SalaryHeaders.RESET;
    //                         // SalaryHeaders.FIND('-');
    //                     END
    //                     ELSE
    //                         currXMLport.SKIP;
    //                 END
    //                 ELSE
    //                     currXMLport.SKIP;

    //             end;

    //         }
    //         tableelement(EnteteFin; "Entete Lot Paie")
    //         {

    //             SourceTableView = SORTING(Code);
    //             AutoSave = TRUE;
    //             AutoUpdate = TRUE;

    //             textattribute(Sens4)
    //             {
    //                 Width = 100;
    //             }




    //             trigger OnPreXmlItem()
    //             begin
    //                 EnteteFin.SETRANGE(Code, CodeLotVirement);

    //             end;

    //             trigger OnAfterGetRecord()
    //             begin


    //             end;

    //         }

    //     }
    // }

    // requestpage
    // {
    //     layout
    //     {
    //         area(content)
    //         {
    //             group(Genaral)
    //             {

    //                 field(CodeBanque; CodeBanque)
    //                 {
    //                     Caption = 'Code Banque BNA';
    //                     TableRelation = "Bank Account";
    //                     ApplicationArea = all;

    //                 }
    //                 field(CodeLotVirement; CodeLotVirement)
    //                 {
    //                     Caption = 'Code Lot Virement';
    //                     TableRelation = "Entete Lot Paie";
    //                     ApplicationArea = all;

    //                 }
    //             }
    //         }
    //     }

    //     actions
    //     {
    //         area(processing)
    //         {


    //         }
    //     }
    // }

    // procedure SalaireNet(No: Code[20]) netsalary: Decimal
    // var

    //     LigneSalaire: Record "Rec. Salary Lines";
    // begin

    //     netsalary := 0;
    //     LigneSalaire.SETFILTER("No.", No);
    //     // AGA LigneSalaire.SETFILTER("Payment Method Code",'%1',2);
    //     IF LigneSalaire.FIND('-') THEN
    //         REPEAT
    //             netsalary := netsalary + LigneSalaire."Net salary cashed";
    //         UNTIL LigneSalaire.NEXT = 0;

    // end;

    // procedure TEST()
    // begin


    // end;

    // trigger OnPostXmlPort()
    // begin
    //     //  COMMIT;
    // end;

    // trigger OnInitXmlPort()
    // begin

    // end;

    // trigger OnPreXmlPort()
    // begin

    //     currXMLport.FILENAME := STRSUBSTNO('VIREMENT');

    //     IF CodeBanque = '' THEN
    //         ERROR('Précisez la banque');
    //     IF CodeLotVirement = '' THEN
    //         ERROR('Précisez le Lot de Virement');

    //     //Debut Mehdi
    //     Sens := 'DEBUT FICHIER ' + FORMAT(TODAY);
    //     Sens4 := 'FIN FICHIER ' + FORMAT(TODAY);
    //     Sens2 := 'B';
    //     Sens5 := 'D';
    //     CodeEspace := ' ';
    //     Sens3 := 'VOSA';
    //     Sens3Line := 'VOSA';
    //     //NatureRemettant:='1';
    //     //CodeRemettant:='00';
    //     //CodeCentreRegional:='000';
    //     DateOp := FORMAT(TODAY, 8, '<year4><Month,2><day,2>');
    //     CodeEspace20 := ' ';
    //     NumLot := '0001';
    //     CodeEspace3 := ' ';

    //     //CodeEnre:='11';
    //     CodeDev := '788';
    //     Rang := '0000000';
    //     //Filler:=' ';
    //     //Filler1:=' ';
    //     //Filler2:=' ';
    //     //CodeEnreDet:='21';
    //     i := 0;

    //     CodeComplimentaire := '000';
    //     CodeZoneLibre := '      ';
    //     //Fin Mehdi


    // end;





    // procedure GetFILTER(VarLot: Code[20]; VarCode: Code[20]): Code[110]
    // begin
    //     CodeLotVirement := VarLot;
    //     CodeBanque := VarCode;

    // end;

    // var
    //     CodeLotVir, CodeBank : Code[20];
    //     LigneLotPaie: Record "Ligne Lot Paie";
    //     AnnéeM: Text[4];
    //     MoisM: Text[2];
    //     // Montantcum: Code[15];
    //     Année: Integer;
    //     Total: Code[15];
    //     mois: Integer;
    //     infosoc: Record "Company Information";
    //     mm: Text[10];
    //     Mnt: Text[10];
    //     EnteteSalaire: Record "Salary Headers";
    //     NomSociete: Code[30];
    //     NbrEnrg: Code[7];
    //     FILT: Code[110];
    //     difNbrEnrg: Integer;
    //     DiffMnt: Integer;
    //     NomSoc: Code[60];
    //     MontantN: Code[15];
    //     DiffMontantN: Integer;
    //     MotifOp: Code[45];
    //     SitRes: Integer;
    //     TypeCpt: Integer;
    //     NatCptB: Code[1];
    //     DossEch: Integer;
    //     FilDet: Code[3];
    //     Total1: Code[15];
    //     MontantN1: Code[15];
    //     SalaryHeaders: Record "Salary Headers";
    //     SalaryLines: Record "Salary Lines";
    //     MontantN2: Code[15];
    //     // Sens: Code[100];
    //     NatureRemettant: Code[100];
    //     CodeRemettant: Code[2];
    //     CodeCentreRegional: Code[3];
    //     DateOp: Code[8];
    //     NumLot: Code[4];
    //     CodeEnre: Code[2];
    //     CodeDev: Code[3];
    //     Rang: Code[7];
    //     Filler: Code[155];
    //     CodeEnreDet: Code[2];
    //     // MontantVir: Code[15];
    //     NumVir: Code[7];
    //     // RibSoc: Code[25];
    //     CdeInsDes: Code[2];
    //     CdeCentRegAgence: Code[3];
    //     // RibSal: Code[20];
    //     // NomSaL: Code[50];
    //     RefPaiment: Code[20];
    //     CdeEnregCompl: Code[2];
    //     NbEnregComp: Code[2];
    //     MotifOpr: Code[100];
    //     DateComp: Code[8];
    //     MotifRejet: Code[8];
    //     Filler1: Code[3];
    //     Raisonsociale: Code[30];
    //     DiffNum: Integer;
    //     NumN: Code[7];
    //     comptebq: Record "Bank Account";
    //     ParamCpta: Record "General Ledger Setup";
    //     NumPaie: Code[20];
    //     comptebqSal: Record "Employee Bank Account";
    //     RecBankAccount: Record "Bank Account";
    //     CodeBanque: Code[10];
    //     MATSAL: Code[20];
    //     Filler2: Code[113];
    //     i: Integer;
    //     TotalL: Decimal;
    //     CodeEspace: Code[2];
    //     CodeEspace20: Code[20];
    //     CodeEspace3: Code[3];
    //     CodeZoneLibre139: Code[139];
    //     // Sens2: Code[2];
    //     CodeComplimentaire: Code[3];
    //     CodeZoneLibre: Code[6];
    //     CodeLotVirement: Code[20];
    //     MntText: Text[30];
    //     MntTextSal: Text[30];
    // // Sens3: Code[4];
    // // Sens4: Text[100];
    // // Sens5: Code[4];


}