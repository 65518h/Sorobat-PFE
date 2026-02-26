//HS
xmlport 50107 "Disquette Virement BTE 02"
{


    // DefaultFieldsValidation = false;
    // Direction = Export;
    // Format = FixedText;
    // TableSeparator = '<NewLine>';
    // schema
    // {
    //     textelement(NodeName1)
    //     {
    //         tableelement(RecSalaryHeaders; "Rec. Salary Headers")
    //         {
    //             SourceTableView = SORTING("No.") WHERE("No." = FILTER('<>SIMULATION'));
    //             AutoSave = TRUE;
    //             AutoUpdate = TRUE;
    //             // MinOccurs = Zero;
    //             textelement(Sens)
    //             {
    //                 Width = 2;
    //             }

    //             textelement(CodeEspace)
    //             {
    //                 Width = 2;
    //             }

    //             textelement(RibSoc)
    //             {
    //                 Width = 20;
    //             }

    //             textelement(DateOp)
    //             {
    //                 Width = 8;
    //             }

    //             textelement(CodeEspace20)
    //             {
    //                 Width = 20;
    //             }

    //             textelement(DateOp2) // renommé pour éviter doublon
    //             {
    //                 Width = 8;
    //             }

    //             textelement(NumLot)
    //             {
    //                 Width = 4;
    //             }

    //             textelement(CodeEspace3)
    //             {
    //                 Width = 3;
    //             }

    //             textelement(NbrEnrg)
    //             {
    //                 Width = 7;
    //             }

    //             textelement(CodeEspace3_2) // renommé pour éviter doublon
    //             {
    //                 Width = 3;
    //             }

    //             textelement(CodeDev)
    //             {
    //                 Width = 3;
    //             }

    //             textelement(CodeEspace3_3) // renommé pour éviter doublon
    //             {
    //                 Width = 3;
    //             }

    //             textelement(Montantcum)
    //             {
    //                 Width = 18;
    //             }

    //             textelement(CodeZoneLibre139)
    //             {
    //                 Width = 139;
    //             }


    //             trigger OnPreXmlItem()
    //             begin


    //                 LigneLotPaie.SETRANGE(Code, CodeLotVirement);
    //                 IF LigneLotPaie.FINDFIRST THEN
    //                     RecSalaryHeaders.SETRANGE("No.", LigneLotPaie."Num Paie");

    //                 TEST();


    //             end;

    //             trigger OnAfterGetRecord()
    //             begin



    //             end;
    //         }
    //         tableelement("RecSalaryLines"; "Rec. Salary Lines")
    //         {

    //             SourceTableView = SORTING("No.", Employee) ORDER(Ascending) WHERE("No." = FILTER('<>SIMULATION'));
    //             AutoSave = TRUE;
    //             AutoUpdate = TRUE;
    //             textelement(Sens2)
    //             {
    //                 Width = 2;
    //             }

    //             textelement(CodeEspaceLine)
    //             {
    //                 Width = 2;
    //             }

    //             textelement(RibSocLine)
    //             {
    //                 Width = 20;
    //             }

    //             textelement(RibSal)
    //             {
    //                 Width = 20;
    //             }

    //             textelement(NomSaL)
    //             {
    //                 Width = 50;
    //             }

    //             textelement(DateOpLine)
    //             {
    //                 Width = 8;
    //             }

    //             textelement(NumLotLine)
    //             {
    //                 Width = 4;
    //             }

    //             textelement(NumVir)
    //             {
    //                 Width = 7;
    //             }

    //             textelement(CodeComplimentaire)
    //             {
    //                 Width = 3;
    //             }

    //             textelement(MotifOpr)
    //             {
    //                 Width = 100;
    //             }

    //             textelement(MontantVir)
    //             {
    //                 Width = 18;
    //             }

    //             textelement(CodeZoneLibre)
    //             {
    //                 Width = 6;
    //             }

    //             trigger OnPreXmlItem()
    //             begin


    //                 RecSalaryLines.SETFILTER("No.", NumPaie);
    //                 RecSalaryLines.SETFILTER("Ordre Virement Salaire", CodeLotVirement);
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
    //                 // AGA SalaryLines.SETRANGE("Payment Method Code","Payment Method Code"::Virement);
    //                 SalaryLines.SETRANGE(Employee, RecSalaryLines.Employee);

    //                 IF SalaryLines.FIND('-') THEN BEGIN
    //                     IF (SalaryLines.RIB <> '') THEN BEGIN
    //                         i := i + 1;
    //                         MATSAL := SalaryLines.Employee;
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
    //                         RibSocLine := RecBankAccount.RIB;
    //                         CdeInsDes := infosoc."Bank Branch No.";
    //                         // AGA    CdeCentRegAgence := infosoc."Code Agence";

    //                         RibSal := SalaryLines.RIB;
    //                         NomSaL := SalaryLines.Name;
    //                         MontantN1 := FORMAT(ROUND(ROUND(RecSalaryLines."Net salary cashed", 0.001), ParamCpta."Amount Rounding Precision") * 1000);
    //                         // RB SORO 10/05/2016
    //                         MntTextSal := DELCHR(FORMAT(MontantN1), '=', '0|1|2|3|4|5|6|7|8|9');
    //                         MontantN2 := DELCHR(FORMAT(MontantN1), '=', '.|,|;| ');
    //                         MontantN2 := DELCHR(MontantN2, '=', MntTextSal);
    //                         // RB SORO 10/05/2016
    //                         DiffMontantN := (18 - STRLEN(FORMAT(MontantN2)));
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
    //                         DateComp := '00000000';
    //                         MotifRejet := '00000000';

    //                         SalaryHeaders.RESET;
    //                         SalaryHeaders.FIND('-');
    //                     END
    //                     ELSE
    //                         currXMLport.SKIP;
    //                 END
    //                 ELSE
    //                     currXMLport.SKIP;
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


    //     infosoc.GET;
    //     Raisonsociale := infosoc.Name;
    //     ParamCpta.GET;

    //     //--------------------------------DEBUT ENREGISTREMENT GLOBALE---------------
    //     RecBankAccount.RESET;
    //     RecBankAccount.SETRANGE("No.", CodeBanque);
    //     IF RecBankAccount.FIND('-') THEN
    //         RibSoc := RecBankAccount.RIB;
    //     RibSocLine := RecBankAccount.RIB;
    //     infosoc.GET;
    //     EnteteSalaire.RESET;
    //     EnteteSalaire.SETRANGE("No.", CodePaieEnreg);
    //     //IF EnteteSalaire.FIND('-') THEN
    //     IF EnteteSalaire.FINDFIRST THEN BEGIN
    //         SalaryLines.RESET;
    //         SalaryLines.SETRANGE("No.", EnteteSalaire."No.");
    //         SalaryLines.SETRANGE("Ordre Virement Salaire", CodeLotVirement);
    //         IF SalaryLines.FIND('-') THEN
    //             REPEAT
    //                 TotalL += ROUND(SalaryLines."Net salary cashed", ParamCpta."Amount Rounding Precision") * 1000;
    //             UNTIL SalaryLines.NEXT = 0;
    //         // RB SORO 10/05/2016
    //         MntText := DELCHR(FORMAT(TotalL), '=', '0|1|2|3|4|5|6|7|8|9');
    //         Montantcum := DELCHR(FORMAT(TotalL), '=', '.|,|;| ');
    //         Montantcum := DELCHR(Montantcum, '=', MntText);
    //         //MESSAGE('le montant global est %1',Montantcum);
    //         // RB SORO 10/05/2016

    //     END;




    //     EnteteSalaire.RESET;
    //     EnteteSalaire.SETRANGE("No.", CodePaieEnreg);
    //     //IF EnteteSalaire.FIND('-') THEN
    //     IF EnteteSalaire.FINDFIRST THEN BEGIN
    //         EnteteSalaire.CALCFIELDS("Net salary cashed");
    //         EnteteSalaire.CALCFIELDS("Salary lines");
    //         NumPaie := '';
    //         NumPaie := EnteteSalaire."No.";

    //         mois := EnteteSalaire.Month + 1;
    //         Année := EnteteSalaire.Year;
    //         IF mois < 9 THEN
    //             MoisM := FORMAT(0) + FORMAT(mois)
    //         ELSE
    //             MoisM := FORMAT(mois);

    //         NbrEnrg := FORMAT(SalaryLines.COUNT);
    //         Total1 := FORMAT(ROUND(SalaireNet("RecSalaryHeaders"."No."), ParamCpta."Amount Rounding Precision") * 1000);

    //         Total1 := DELCHR(Total1, '=', ' ');
    //         Total := Total1;
    //     END;
    //     //--------------------Nombre enregistrement-------------
    //     difNbrEnrg := (7 - STRLEN(NbrEnrg));
    //     IF difNbrEnrg <> 0 THEN
    //         REPEAT
    //             NbrEnrg := INSSTR(NbrEnrg, '0', 1);
    //             difNbrEnrg := difNbrEnrg - 1;
    //         UNTIL difNbrEnrg = 0;
    //     AnnéeM := COPYSTR(FORMAT(Année), 1, 4);
    //     //--------------------Montant Virrement-------------
    //     DiffMnt := (18 - STRLEN(Montantcum));
    //     IF DiffMnt <> 0 THEN
    //         REPEAT
    //             Montantcum := INSSTR(Montantcum, '0', 1);
    //             DiffMnt := DiffMnt - 1;
    //         UNTIL DiffMnt = 0;
    //     FILT := '';
    //     //--------------------------------FIN ENREGISTREMENT GLOBALE  ---------------
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

    //     // BR SORO 18/02/2017 MODIF SALAIRE ENREGESTRIE
    //     CodePaieEnreg := '';
    //     RecSalaryLinesLot.SETRANGE("Ordre Virement Salaire", CodeLotVirement);
    //     IF RecSalaryLinesLot.FINDFIRST THEN CodePaieEnreg := RecSalaryLinesLot."No.";
    //     // BR SORO 18/02/2017 MODIF SALAIRE ENREGESTRIE
    //     //Debut Mehdi
    //     Sens := 'V1';
    //     Sens2 := 'V2';
    //     CodeEspace := ' ';
    //     CodeEspaceLine := ' ';
    //     //NatureRemettant:='1';
    //     //CodeRemettant:='00';
    //     //CodeCentreRegional:='000';
    //     DateOp := FORMAT(TODAY, 8, '<year4><Month,2><day,2>');
    //     DateOp2 := FORMAT(TODAY, 8, '<year4><Month,2><day,2>');
    //     DateOpLine := FORMAT(TODAY, 8, '<year4><Month,2><day,2>');
    //     CodeEspace20 := ' ';
    //     NumLot := '0001';
    //     NumLotLine := '0001';
    //     CodeEspace3 := ' ';
    //     CodeEspace3_2 := ' ';
    //     CodeEspace3_3 := ' ';
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
    //     AnnéeM: Text[4];
    //     MoisM: Text[2];
    //     //    Montantcum: Code[18];
    //     Année: Integer;
    //     Total: Code[15];
    //     mois: Integer;
    //     infosoc: Record "Company Information";
    //     mm: Text[10];
    //     Mnt: Text[10];
    //     EnteteSalaire: Record "Rec. Salary Headers";
    //     NomSociete: Code[30];
    //     // NbrEnrg: Code[7];
    //     FILT: Code[110];
    //     difNbrEnrg: Integer;
    //     DiffMnt: Integer;
    //     NomSoc: Code[60];
    //     MontantN: Code[18];
    //     DiffMontantN: Integer;
    //     MotifOp: Code[45];
    //     SitRes: Integer;
    //     TypeCpt: Integer;
    //     NatCptB: Code[1];
    //     DossEch: Integer;
    //     FilDet: Code[3];
    //     Total1: Code[15];
    //     MontantN1: Code[18];
    //     SalaryHeaders: Record "Rec. Salary Headers";
    //     SalaryLines: Record "Rec. Salary Lines";
    //     MontantN2: Code[18];
    //     // Sens: Code[2];
    //     NatureRemettant: Code[1];
    //     CodeRemettant: Code[2];
    //     CodeCentreRegional: Code[3];
    //     // DateOp: Code[8];
    //     // NumLot: Code[4];
    //     CodeEnre: Code[2];
    //     // CodeDev: Code[3];
    //     Rang: Code[7];
    //     Filler: Code[155];
    //     CodeEnreDet: Code[2];
    //     // MontantVir: Code[18];
    //     // NumVir: Code[7];
    //     // RibSoc: Code[20];
    //     CdeInsDes: Code[2];
    //     CdeCentRegAgence: Code[3];
    //     // RibSal: Code[20];
    //     // NomSaL: Code[50];
    //     RefPaiment: Code[20];
    //     CdeEnregCompl: Code[2];
    //     NbEnregComp: Code[2];
    //     // MotifOpr: Code[100];
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
    //     // CodeEspace: Code[2];
    //     // CodeEspace20: Code[20];
    //     // CodeEspace3: Code[3];
    //     // CodeZoneLibre139: Code[139];
    //     // Sens2: Code[2];
    //     // CodeComplimentaire: Code[3];
    //     // CodeZoneLibre: Code[6];
    //     CodeLotVirement: Code[20];
    //     MntText: Text[30];
    //     MntTextSal: Text[30];
    //     RecSalaryLinesLot: Record "Rec. Salary Lines";
    //     CodePaieEnreg: Code[20];
    //     LigneLotPaie: Record "Ligne Lot Paie";


}