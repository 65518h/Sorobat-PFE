report 50082 "Déclaration Trimestr  salaire"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/DéclarationTrimestrsalaire.rdlc';
    // TransactionType = UpdateNoLocks;

    // dataset
    // {
    //     dataitem("Company Information"; 79)
    //     {
    //         DataItemTableView = SORTING("Primary Key");
    //         column("FORMAT_Année_"; FORMAT(Année))
    //         {
    //         }
    //         column(FORMAT__xTrimestre_; FORMAT(xTrimestre))
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(CompanyInformation_Name; CompanyInformation.Name)
    //         {
    //         }
    //         column(Company_Information__Company_Information__Address; "Company Information".Address)
    //         {
    //         }
    //         column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(CompanyInformation__N__CNSS_; CompanyInformation."N° CNSS")
    //         {
    //         }
    //         column(DECLARATION_TRIMESTRIELLE_DES_SALAIRESCaption; DECLARATION_TRIMESTRIELLE_DES_SALAIRESCaptionLbl)
    //         {
    //         }
    //         column(Mle_CNSS__Caption; Mle_CNSS__CaptionLbl)
    //         {
    //         }
    //         column(Company_Information_Primary_Key; "Primary Key")
    //         {
    //         }
    //         dataitem(Employee; 5200)
    //         {
    //             DataItemTableView = SORTING("Social Security No.")
    //                                 ORDER(Ascending)
    //                                 WHERE("Employee's Type Contrat" = FILTER(CDD | CDI));
    //             PrintOnlyIfDetail = false;
    //             RequestFilterFields = "No.", "Exclu De Dec Trim CNSS", "Collège";
    //             column(V1erMois_; "1erMois")
    //             {
    //             }
    //             column(LinesPrinted; LinesPrinted)
    //             {
    //             }
    //             column(V2emeMois_; "2emeMois")
    //             {
    //             }
    //             column(V3emeMois_; "3emeMois")
    //             {
    //             }
    //             column(TotalRep; TotalRep)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(SommeRep3; SommeRep3)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(SommeRep2; SommeRep2)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(SommeRep1; SommeRep1)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(SommeLigne; SommeLigne)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(mois3; mois3)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(mois2; mois2)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(mois1; mois1)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column("Employee_Employee_Collège"; Employee.Collège)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(Employee_Employee__No__; Employee."No.")
    //             {
    //             }
    //             column(First_Name_________Last_Name_; "First Name" + ' ' + "Last Name")
    //             {
    //             }
    //             column(NumSecuriteSocial; NumSecuriteSocial)
    //             {
    //             }
    //             column(Num; Num)
    //             {
    //             }
    //             column(TotalPage; TotalPage)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(SommePage3; SommePage3)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(SommePage2; SommePage2)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(SommePage1; SommePage1)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             // column(CotisationPatronal; CotisationPatronal)
    //             // {
    //             //     AutoFormatType = 2;
    //             // }
    //             // column(CotisationPersonnel; CotisationPersonnel)
    //             // {
    //             //     AutoFormatType = 2;
    //             // }
    //             // column(AccidentTravail; AccidentTravail)
    //             // {
    //             //     AutoFormatType = 2;
    //             // }
    //             // column(CotisationGlobal; CotisationGlobal)
    //             // {
    //             //     AutoFormatType = 2;
    //             // }
    //             // column(TextGMnt; TextGMnt)
    //             // {
    //             //     AutoFormatType = 2;
    //             // }
    //             // column(TotalPage_Control1000000015; TotalPage)
    //             // {
    //             //     AutoFormatType = 2;
    //             // }
    //             column(TotalE3; TotalE3)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(TotalE2; TotalE2)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(TotalE1; TotalE1)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(TotalPage_Control1000000060; TotalPage)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(SommePage3_Control1000000062; SommePage3)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(SommePage2_Control1000000063; SommePage2)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(SommePage1_Control1000000064; SommePage1)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(Cotisation_du_Personnel______FORMAT_RecHumanSetup__Taux_Part_salariale_CNSS____________; 'Cotisation du Personnel (' + FORMAT(RecHumanSetup."Taux Part salariale CNSS") + ' %) :')
    //             {
    //             }
    //             column(Cotisation_Patronale______FORMAT_RecHumanSetup__Taux_Part_patronale_CNSS____________; 'Cotisation Patronale (' + FORMAT(RecHumanSetup."Taux Part patronale CNSS") + ' %) :')
    //             {
    //             }
    //             column(Accident_de_Travail______FORMAT_RecHumanSetup__Taux_Accidents_du_travail_CNSS____________; 'Accident de Travail (' + FORMAT(RecHumanSetup."Taux Accidents du travail CNSS") + ' %) :')
    //             {
    //             }
    //             column(Cotisation_Globale________FORMAT_RecHumanSetup__Total_Cotisation_CNSS____________; 'Cotisation Globale  ( ' + FORMAT(RecHumanSetup."Total Cotisation CNSS") + ' %) :')
    //             {
    //             }
    //             column(Matr__CNSSCaption; Matr__CNSSCaptionLbl)
    //             {
    //             }
    //             column(MatriculeCaption; MatriculeCaptionLbl)
    //             {
    //             }
    //             column(NOM_ET_PRENOMCaption; NOM_ET_PRENOMCaptionLbl)
    //             {
    //             }
    //             column("Catég_Caption"; Catég_CaptionLbl)
    //             {
    //             }
    //             column(TOTALCaption; TOTALCaptionLbl)
    //             {
    //             }
    //             column(RENUMERATIONCaption; RENUMERATIONCaptionLbl)
    //             {
    //             }
    //             column(N_Caption; N_CaptionLbl)
    //             {
    //             }
    //             column(R_____E_____P_____O_____R_____T_____SCaption; R_____E_____P_____O_____R_____T_____SCaptionLbl)
    //             {
    //             }
    //             column(R_____E_____P_____O_____R_____T_____SCaption_Control1000000057; R_____E_____P_____O_____R_____T_____SCaption_Control1000000057Lbl)
    //             {
    //             }
    //             column(Cotisation_du_Personnel__9_18_____Caption; Cotisation_du_Personnel__9_18_____CaptionLbl)
    //             {
    //             }
    //             column(Cotisation_du_Patronale__16_57_____Caption; Cotisation_du_Patronale__16_57_____CaptionLbl)
    //             {
    //             }
    //             column(Accident_de_Travail__3_80_____Caption; Accident_de_Travail__3_80_____CaptionLbl)
    //             {
    //             }
    //             column(Cotisation_Globale___29_55_____Caption; Cotisation_Globale___29_55_____CaptionLbl)
    //             {
    //             }
    //             column("Arrêtée_la_présente_déclaration_à_la_somme_de___Caption"; Arrêtée_la_présente_déclaration_à_la_somme_de___CaptionLbl)
    //             {
    //             }
    //             column(T__O__T__A__LCaption; T__O__T__A__LCaptionLbl)
    //             {
    //             }
    //             column(R_____E_____P_____O_____R_____T_____SCaption_Control1000000059; R_____E_____P_____O_____R_____T_____SCaption_Control1000000059Lbl)
    //             {
    //             }
    //             column("Faite_à______________________________Le________________________Caption"; Faite_à______________________________Le________________________CaptionLbl)
    //             {
    //             }
    //             column(Employee_Social_Security_No_; "Social Security No.")
    //             {
    //             }



    //             trigger OnPostDataItem()
    //             begin


    //             end;

    //             trigger OnAfterGetRecord()

    //             begin
    //                 CLEAR(LigneSalaireEnreg);
    //                 CLEAR(LigneSalaireEnreg1);
    //                 CLEAR(LigneSalaireEnreg2);
    //                 CLEAR(LigneSalaireEnreg3);
    //                 LigneSalaireEnreg.RESET;
    //                 mois1 := 0;
    //                 mois2 := 0;
    //                 mois3 := 0;
    //                 NJ1 := 0;
    //                 NJ2 := 0;
    //                 NJ3 := 0;
    //                 Total2 := Total2 + Total3;
    //                 IF Employee."No." = '02073' THEN BEGIN
    //                     fk := 1;
    //                     fg := 1;
    //                 END;
    //                 CLEAR(Cnt);
    //                 IF Cnt.GET("Emplymt. Contract Code") THEN;
    //                 CNSS.RESET;
    //                 IF 1 = 1 THEN BEGIN
    //                     LigneSalaireEnreg.RESET;
    //                     LigneSalaireEnreg.SETRANGE(Employee, "No.");
    //                     LigneSalaireEnreg.SETRANGE(Year, Année);

    //                     CASE xTrimestre OF
    //                         0:
    //                             BEGIN
    //                                 LigneSalaireEnreg1.COPYFILTERS(LigneSalaireEnreg);
    //                                 LigneSalaireEnreg1.SETRANGE("Posting Date", DMY2DATE(1, 1, Année), DMY2DATE(31, 1, Année));
    //                                 LigneSalaireEnreg2.COPYFILTERS(LigneSalaireEnreg);
    //                                 LigneSalaireEnreg2.SETRANGE("Posting Date", DMY2DATE(1, 2, Année), CALCDATE('+FM', DMY2DATE(1, 2, Année)));
    //                                 LigneSalaireEnreg3.COPYFILTERS(LigneSalaireEnreg);
    //                                 LigneSalaireEnreg3.SETRANGE("Posting Date", DMY2DATE(1, 3, Année), DMY2DATE(31, 3, Année));

    //                             END;

    //                         1:
    //                             BEGIN
    //                                 LigneSalaireEnreg1.COPYFILTERS(LigneSalaireEnreg);
    //                                 LigneSalaireEnreg1.SETRANGE("Posting Date", DMY2DATE(1, 4, Année), DMY2DATE(30, 4, Année));
    //                                 LigneSalaireEnreg2.COPYFILTERS(LigneSalaireEnreg);
    //                                 LigneSalaireEnreg2.SETRANGE("Posting Date", DMY2DATE(1, 5, Année), DMY2DATE(31, 5, Année));
    //                                 LigneSalaireEnreg3.COPYFILTERS(LigneSalaireEnreg);
    //                                 LigneSalaireEnreg3.SETRANGE("Posting Date", DMY2DATE(1, 6, Année), DMY2DATE(30, 6, Année));

    //                             END;

    //                         2:
    //                             BEGIN
    //                                 LigneSalaireEnreg1.COPYFILTERS(LigneSalaireEnreg);
    //                                 LigneSalaireEnreg1.SETRANGE("Posting Date", DMY2DATE(1, 7, Année), DMY2DATE(31, 7, Année));
    //                                 LigneSalaireEnreg2.COPYFILTERS(LigneSalaireEnreg);
    //                                 LigneSalaireEnreg2.SETRANGE("Posting Date", DMY2DATE(1, 8, Année), DMY2DATE(31, 8, Année));
    //                                 LigneSalaireEnreg3.COPYFILTERS(LigneSalaireEnreg);
    //                                 LigneSalaireEnreg3.SETRANGE("Posting Date", DMY2DATE(1, 9, Année), DMY2DATE(30, 9, Année));

    //                             END;

    //                         3:
    //                             BEGIN
    //                                 LigneSalaireEnreg1.COPYFILTERS(LigneSalaireEnreg);
    //                                 LigneSalaireEnreg1.SETRANGE("Posting Date", DMY2DATE(1, 10, Année), DMY2DATE(31, 10, Année));
    //                                 LigneSalaireEnreg2.COPYFILTERS(LigneSalaireEnreg);
    //                                 LigneSalaireEnreg2.SETRANGE("Posting Date", DMY2DATE(1, 11, Année), DMY2DATE(30, 11, Année));
    //                                 LigneSalaireEnreg3.COPYFILTERS(LigneSalaireEnreg);
    //                                 LigneSalaireEnreg3.SETRANGE("Posting Date", DMY2DATE(1, 12, Année), DMY2DATE(31, 12, Année));

    //                             END;
    //                     END;


    //                     // IF "No."<>'09050' THEN
    //                     // BEGIN

    //                     IF LigneSalaireEnreg1.FIND('-') THEN BEGIN
    //                         REPEAT
    //                             IF COPYSTR(LigneSalaireEnreg1.Catégorie, 1, 2) <> 'SV' THEN BEGIN
    //                                 TotCnss += LigneSalaireEnreg1."Gross Salary";
    //                                 Total1 := Total1 + LigneSalaireEnreg1."Gross Salary";
    //                                 mois1 += LigneSalaireEnreg1."Gross Salary";
    //                                 NJ1 := LigneSalaireEnreg1."Paied days";
    //                             END;
    //                         UNTIL LigneSalaireEnreg1.NEXT = 0
    //                     END;
    //                     //END;

    //                     //IF "No."<>'10985'  THEN
    //                     //  BEGIN

    //                     IF LigneSalaireEnreg2.FIND('-') THEN BEGIN
    //                         REPEAT
    //                             IF COPYSTR(LigneSalaireEnreg2.Catégorie, 1, 2) <> 'SV' THEN BEGIN
    //                                 TotCnss += LigneSalaireEnreg2."Gross Salary";
    //                                 Total2 := Total2 + LigneSalaireEnreg2."Gross Salary";
    //                                 mois2 += LigneSalaireEnreg2."Gross Salary";
    //                                 NJ2 := LigneSalaireEnreg2."Paied days";
    //                             END;
    //                         UNTIL LigneSalaireEnreg2.NEXT = 0
    //                     END;
    //                     //END;


    //                     //IF ("No."<>'05254') AND ("No."<>'05515')  THEN
    //                     // BEGIN

    //                     IF LigneSalaireEnreg3.FIND('-') THEN BEGIN
    //                         REPEAT
    //                             IF COPYSTR(LigneSalaireEnreg3.Catégorie, 1, 2) <> 'SV' THEN BEGIN
    //                                 TotCnss += LigneSalaireEnreg3."Gross Salary";
    //                                 Total3 := Total3 + LigneSalaireEnreg3."Gross Salary";
    //                                 mois3 += LigneSalaireEnreg3."Gross Salary";
    //                                 NJ3 := LigneSalaireEnreg3."Paied days";
    //                             END;
    //                         UNTIL LigneSalaireEnreg3.NEXT = 0
    //                     END;
    //                     //END;

    //                 END;
    //                 IF K < 11 THEN BEGIN
    //                     TFmois1 := TFmois1 + mois1;
    //                     TFmois2 := TFmois2 + mois2;
    //                     TFmois3 := TFmois3 + mois3;
    //                 END;
    //                 // RB SORO 07/04/2016
    //                 IF (mois1 + mois2 + mois3) <> 0 THEN BEGIN
    //                     "Declarer CNSS" := TRUE;
    //                     MODIFY;
    //                 END;
    //                 IF (mois1 + mois2 + mois3) = 0 THEN
    //                     CurrReport.SKIP;
    //                 // RB SORO 07/04/2016

    //                 LinesPrinted := 1;
    //                 SommePage1 := SommeRep1;
    //                 SommePage2 := SommeRep2;
    //                 SommePage3 := SommeRep3;
    //                 TotalPage := TotalPage;
    //                 IF CurrReport.PAGENO = 1 THEN BEGIN
    //                     Num := 0;
    //                     NouvellePage := FALSE;
    //                 END
    //                 ELSE
    //                     Num := 1;

    //                 // CurrReport.SHOWOUTPUT((mois1 + mois2 + mois3) <> 0);
    //                 if (mois1 + mois2 + mois3) = 0 then
    //                     CurrReport.SKIP;
    //                 IF (mois1 + mois2 + mois3) <> 0 THEN BEGIN
    //                     Effectif += 1;
    //                     Num += 1;
    //                     // RB SORO 07/04/2016
    //                     IF LinesPrinted = 13 THEN BEGIN
    //                         CurrReport.NEWPAGE;
    //                         NouvellePage := TRUE;
    //                     END
    //                     ELSE
    //                         NouvellePage := FALSE;
    //                     LinesPrinted := LinesPrinted + 1;
    //                     SommePage1 += mois1;
    //                     SommePage2 += mois2;
    //                     SommePage3 += mois3;
    //                     TotalPage += mois1 + mois2 + mois3;
    //                     // RB SORO 07/04/2016
    //                 END;
    //                 SommeLigne := 0;
    //                 SommeLigne := mois1 + mois2 + mois3;
    //                 IF COPYSTR("Social Security No.", 1, 8) = '00000000' THEN
    //                     NumSecuriteSocial := '0000000000' ELSE
    //                     NumSecuriteSocial := "Social Security No.";


    //                 //***********MH SOROUBAT 16/09/2016*************
    //                 IF (mois1 + mois2 + mois3) <> 0 THEN BEGIN

    //                     Declarationsalaires.Matricule := Employee."No.";
    //                     Declarationsalaires.Année := Année;
    //                     Declarationsalaires.Trimestre := xTrimestre + 1;
    //                     Declarationsalaires."N° Page" := CurrReport.PAGENO;
    //                     Declarationsalaires."N° Ligne" := Num;
    //                     Declarationsalaires."Mantant Mois 1" := mois1;
    //                     Declarationsalaires."Mantant Mois 2" := mois2;
    //                     Declarationsalaires."Mantant Mois 3" := mois3;
    //                     Declarationsalaires."Total Mantant" := SommeLigne;
    //                     Declarationsalaires."Nom et Prénom" := "First Name" + ' ' + "Last Name";
    //                     Declarationsalaires."N° CNSS" := NumSecuriteSocial;
    //                     Declarationsalaires."Exclu De Dec Trim CNSS" := Employee."Exclu De Dec Trim CNSS";
    //                     Declarationsalaires.Collège := Employee.Collège;
    //                     CASE xTrimestre OF
    //                         0:
    //                             BEGIN
    //                                 "1erMois" := 'Janvier';
    //                                 "2emeMois" := 'Fevrier';
    //                                 "3emeMois" := 'Mars';
    //                             END;

    //                         1:
    //                             BEGIN
    //                                 "1erMois" := 'Avril';
    //                                 "2emeMois" := 'Mai';
    //                                 "3emeMois" := 'Juin';
    //                             END;

    //                         2:
    //                             BEGIN
    //                                 "1erMois" := 'Juillet';
    //                                 "2emeMois" := 'Aout';
    //                                 "3emeMois" := 'Septembre';
    //                             END;

    //                         3:
    //                             BEGIN
    //                                 "1erMois" := 'Octobre';
    //                                 "2emeMois" := 'Novembre';
    //                                 "3emeMois" := 'Decembre';
    //                             END;
    //                     END;
    //                     Declarationsalaires."N° Mois 1" := "1erMois";
    //                     Declarationsalaires."N° Mois 2" := "2emeMois";
    //                     Declarationsalaires."N° Mois 3" := "3emeMois";

    //                     tmp.CLE := Num;
    //                     tmp.salarie := Employee."No.";
    //                     tmp.numncss := NumSecuriteSocial;

    //                     IF NOT Declarationsalaires.MODIFY THEN IF Declarationsalaires.INSERT THEN;
    //                 END;
    //                 //**************MH SOROUBAT 16/09/2016************

    //                 // AccidentTravail := ROUND((TotalPage * (RecHumanSetup."Taux Accidents du travail CNSS")) / 100);
    //                 // CotisationPatronal := ROUND((TotalPage * (RecHumanSetup."Taux Part patronale CNSS")) / 100);
    //                 // CotisationPersonnel := ROUND((TotalPage * (RecHumanSetup."Taux Part salariale CNSS")) / 100);
    //                 // CotisationGlobal := AccidentTravail + CotisationPatronal + CotisationPersonnel;
    //                 //   CodeU."Montant en texte sans millimes"(TextGMnt, CotisationGlobal);

    //                 // RB SORO 07/04/2016
    //                 IF LinesPrinted = 13 THEN
    //                     CurrReport.SHOWOUTPUT(TRUE)
    //                 ELSE
    //                     CurrReport.SHOWOUTPUT(FALSE);

    //                 // RB SORO 07/04/2016
    //             end;

    //             trigger OnPreDataItem()
    //             begin
    //                 RecEmplyee.SETRANGE("Declarer CNSS", TRUE);
    //                 RecEmplyee.MODIFYALL("Declarer CNSS", FALSE);
    //                 LastFieldNo := FIELDNO("No.");
    //                 Total2 := 0;
    //                 //*** HK DSFT
    //                 TFmois1 := 0;
    //                 TFmois2 := 0;
    //                 TFmois3 := 0;
    //                 //*** HK DSFT
    //                 i := 0;
    //                 j := 0;
    //                 m := 0;
    //                 //*** HK DSFT
    //                 GLSetup.GET;
    //                 DMin := GLSetup."Allow Posting From";
    //                 An := DATE2DMY(DMin, 3);

    //                 CASE xTrimestre OF
    //                     0:
    //                         BEGIN
    //                             LibMois1 := FORMAT(CALCDATE('+0M', DMin), 0, '<Month text>');
    //                             LibMois2 := FORMAT(CALCDATE('+1M', DMin), 0, '<Month text>');
    //                             LibMois3 := FORMAT(CALCDATE('+2M', DMin), 0, '<Month text>');
    //                         END;

    //                     1:
    //                         BEGIN
    //                             LibMois1 := FORMAT(CALCDATE('+3M', DMin), 0, '<Month text>');
    //                             LibMois2 := FORMAT(CALCDATE('+4M', DMin), 0, '<Month text>');
    //                             LibMois3 := FORMAT(CALCDATE('+5M', DMin), 0, '<Month text>');

    //                         END;
    //                     2:
    //                         BEGIN
    //                             LibMois1 := FORMAT(CALCDATE('+6M', DMin), 0, '<Month text>');
    //                             LibMois2 := FORMAT(CALCDATE('+7M', DMin), 0, '<Month text>');
    //                             LibMois3 := FORMAT(CALCDATE('+8M', DMin), 0, '<Month text>');

    //                         END;

    //                     3:
    //                         BEGIN
    //                             LibMois1 := FORMAT(CALCDATE('+9M', DMin), 0, '<Month text>');
    //                             LibMois2 := FORMAT(CALCDATE('+10M', DMin), 0, '<Month text>');
    //                             LibMois3 := FORMAT(CALCDATE('+11M', DMin), 0, '<Month text>');

    //                         END;
    //                 END;
    //             end;
    //         }
    //         dataitem(SautPage; 2000000026)
    //         {
    //             DataItemTableView = SORTING(Number)
    //                                         ORDER(Ascending)
    //                                         WHERE(Number = CONST(1));

    //             column(CotisationPatronal; CotisationPatronal)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(TextGMnt; TextGMnt) { }
    //             column(CotisationPersonnel; CotisationPersonnel)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(AccidentTravail; AccidentTravail)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(CotisationGlobal; CotisationGlobal)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             column(TotalPage_Control1000000015; TotalPage)
    //             {
    //                 AutoFormatType = 2;
    //             }
    //             trigger OnAfterGetRecord()
    //             begin
    //                 CodeU."Montant en texte sans millimes"(TextGMnt, CotisationGlobal);
    //             end;


    //             trigger OnPreDataItem()
    //             begin
    //                 //  SautPage.SetRange(Number, 1);
    //                 RecHumanSetup.GET();
    //                 AccidentTravail := ROUND((TotalPage * (RecHumanSetup."Taux Accidents du travail CNSS")) / 100);
    //                 CotisationPatronal := ROUND((TotalPage * (RecHumanSetup."Taux Part patronale CNSS")) / 100);
    //                 CotisationPersonnel := ROUND((TotalPage * (RecHumanSetup."Taux Part salariale CNSS")) / 100);
    //                 CotisationGlobal := AccidentTravail + CotisationPatronal + CotisationPersonnel;

    //                 //    CodeU."Montant en texte sans millimes"(TextGMnt, CotisationGlobal);
    //                 //SETRANGE(Number,1,(12-LinesPrinted));
    //             end;
    //         }
    //         trigger OnAfterGetRecord()
    //         begin
    //             CLEAR(LigneSalaireEnreg);
    //             CLEAR(LigneSalaireEnreg1);
    //             CLEAR(LigneSalaireEnreg2);
    //             CLEAR(LigneSalaireEnreg3);

    //             LigneSalaireEnreg.RESET;
    //             LigneSalaireEnreg.SETRANGE(Year, Année);

    //             CASE xTrimestre OF
    //                 0:
    //                     BEGIN
    //                         LigneSalaireEnreg1.COPYFILTERS(LigneSalaireEnreg);
    //                         LigneSalaireEnreg1.SETRANGE("Posting Date", DMY2DATE(1, 1, Année), DMY2DATE(31, 1, Année));
    //                         LigneSalaireEnreg2.COPYFILTERS(LigneSalaireEnreg);
    //                         LigneSalaireEnreg2.SETRANGE("Posting Date", DMY2DATE(1, 2, Année), CALCDATE('+FM', DMY2DATE(1, 2, Année)));
    //                         LigneSalaireEnreg3.COPYFILTERS(LigneSalaireEnreg);
    //                         LigneSalaireEnreg3.SETRANGE("Posting Date", DMY2DATE(1, 3, Année), DMY2DATE(31, 3, Année));

    //                         LigneSalaireEnreg4.COPYFILTERS(LigneSalaireEnreg);
    //                         LigneSalaireEnreg4.SETRANGE("Posting Date", DMY2DATE(1, 1, Année), DMY2DATE(31, 3, Année));
    //                         "1erMois" := 'Janvier';
    //                         "2emeMois" := 'Fevrier';
    //                         "3emeMois" := 'Mars';
    //                     END;

    //                 1:
    //                     BEGIN
    //                         LigneSalaireEnreg1.COPYFILTERS(LigneSalaireEnreg);
    //                         LigneSalaireEnreg1.SETRANGE("Posting Date", DMY2DATE(1, 4, Année), DMY2DATE(30, 4, Année));
    //                         LigneSalaireEnreg2.COPYFILTERS(LigneSalaireEnreg);
    //                         LigneSalaireEnreg2.SETRANGE("Posting Date", DMY2DATE(1, 5, Année), DMY2DATE(31, 5, Année));
    //                         LigneSalaireEnreg3.COPYFILTERS(LigneSalaireEnreg);
    //                         LigneSalaireEnreg3.SETRANGE("Posting Date", DMY2DATE(1, 6, Année), DMY2DATE(30, 6, Année));

    //                         LigneSalaireEnreg4.COPYFILTERS(LigneSalaireEnreg);
    //                         LigneSalaireEnreg4.SETRANGE("Posting Date", DMY2DATE(1, 4, Année), DMY2DATE(30, 6, Année));
    //                         "1erMois" := 'Avril';
    //                         "2emeMois" := 'Mai';
    //                         "3emeMois" := 'Juin';

    //                     END;

    //                 2:
    //                     BEGIN
    //                         LigneSalaireEnreg1.COPYFILTERS(LigneSalaireEnreg);
    //                         LigneSalaireEnreg1.SETRANGE("Posting Date", DMY2DATE(1, 7, Année), DMY2DATE(31, 7, Année));
    //                         LigneSalaireEnreg2.COPYFILTERS(LigneSalaireEnreg);
    //                         LigneSalaireEnreg2.SETRANGE("Posting Date", DMY2DATE(1, 8, Année), DMY2DATE(31, 8, Année));
    //                         LigneSalaireEnreg3.COPYFILTERS(LigneSalaireEnreg);
    //                         LigneSalaireEnreg3.SETRANGE("Posting Date", DMY2DATE(1, 9, Année), DMY2DATE(30, 9, Année));

    //                         LigneSalaireEnreg4.COPYFILTERS(LigneSalaireEnreg);
    //                         LigneSalaireEnreg4.SETRANGE("Posting Date", DMY2DATE(1, 7, Année), DMY2DATE(30, 9, Année));
    //                         "1erMois" := 'Juillet';
    //                         "2emeMois" := 'Aout';
    //                         "3emeMois" := 'Septembre';


    //                     END;

    //                 3:
    //                     BEGIN
    //                         LigneSalaireEnreg1.COPYFILTERS(LigneSalaireEnreg);
    //                         LigneSalaireEnreg1.SETRANGE("Posting Date", DMY2DATE(1, 10, Année), DMY2DATE(31, 10, Année));
    //                         LigneSalaireEnreg2.COPYFILTERS(LigneSalaireEnreg);
    //                         LigneSalaireEnreg2.SETRANGE("Posting Date", DMY2DATE(1, 11, Année), DMY2DATE(30, 11, Année));
    //                         LigneSalaireEnreg3.COPYFILTERS(LigneSalaireEnreg);
    //                         LigneSalaireEnreg3.SETRANGE("Posting Date", DMY2DATE(1, 12, Année), DMY2DATE(31, 12, Année));

    //                         LigneSalaireEnreg4.COPYFILTERS(LigneSalaireEnreg);
    //                         LigneSalaireEnreg4.SETRANGE("Posting Date", DMY2DATE(1, 10, Année), DMY2DATE(31, 12, Année));
    //                         "1erMois" := 'Octobre';
    //                         "2emeMois" := 'Novembre';
    //                         "3emeMois" := 'Decembre';


    //                     END;
    //             END;
    //             TmpEmployee := '';
    //             EffectifEntete := 0;
    //             RecEmployeeAvg.RESET;
    //             LigneSalaireEnreg4.SETCURRENTKEY(Employee);
    //             IF LigneSalaireEnreg4.FINDFIRST THEN
    //                 REPEAT
    //                     IF TmpEmployee <> LigneSalaireEnreg4.Employee THEN BEGIN
    //                         EffectifEntete += 1;
    //                         TmpEmployee := LigneSalaireEnreg4.Employee;
    //                     END;
    //                 UNTIL LigneSalaireEnreg4.NEXT = 0;
    //             IF LigneSalaireEnreg1.FIND('-') THEN BEGIN
    //                 REPEAT
    //                     IF RecEmployeeAvg.GET(LigneSalaireEnreg1.Employee) THEN;
    //                     RecEmployeeAvg.CALCFIELDS("Employee's Type Contrat");
    //                     IF (NOT RecEmployeeAvg."Exclu De Dec Trim CNSS") AND
    //                     ((RecEmployeeAvg."Employee's Type Contrat" = RecEmployeeAvg."Employee's Type Contrat"::CDI) OR
    //                     (RecEmployeeAvg."Employee's Type Contrat" = RecEmployeeAvg."Employee's Type Contrat"::CDD)) THEN
    //                         TotalE1 := TotalE1 + LigneSalaireEnreg1."Gross Salary";
    //                 UNTIL LigneSalaireEnreg1.NEXT = 0
    //             END;
    //             RecEmployeeAvg.RESET;
    //             IF LigneSalaireEnreg2.FIND('-') THEN BEGIN
    //                 REPEAT
    //                     IF RecEmployeeAvg.GET(LigneSalaireEnreg2.Employee) THEN;
    //                     RecEmployeeAvg.CALCFIELDS("Employee's Type Contrat");
    //                     IF NOT RecEmployeeAvg."Exclu De Dec Trim CNSS" AND
    //                     ((RecEmployeeAvg."Employee's Type Contrat" = RecEmployeeAvg."Employee's Type Contrat"::CDI) OR
    //                     (RecEmployeeAvg."Employee's Type Contrat" = RecEmployeeAvg."Employee's Type Contrat"::CDD)) THEN
    //                         TotalE2 := TotalE2 + LigneSalaireEnreg2."Gross Salary";
    //                 UNTIL LigneSalaireEnreg2.NEXT = 0
    //             END;
    //             RecEmployeeAvg.RESET;
    //             IF LigneSalaireEnreg3.FIND('-') THEN BEGIN
    //                 REPEAT
    //                     IF RecEmployeeAvg.GET(LigneSalaireEnreg3.Employee) THEN;
    //                     RecEmployeeAvg.CALCFIELDS("Employee's Type Contrat");
    //                     IF NOT RecEmployeeAvg."Exclu De Dec Trim CNSS" AND
    //                     ((RecEmployeeAvg."Employee's Type Contrat" = RecEmployeeAvg."Employee's Type Contrat"::CDI) OR
    //                     (RecEmployeeAvg."Employee's Type Contrat" = RecEmployeeAvg."Employee's Type Contrat"::CDD)) THEN
    //                         TotalE3 := TotalE3 + LigneSalaireEnreg3."Gross Salary";
    //                 UNTIL LigneSalaireEnreg3.NEXT = 0

    //             END;

    //             //*****MH SOROUBAT
    //             // RB SORO 12/04/2016 MODIFICATIO CALCUL DU TAUX
    //             RecHumanSetup.GET();
    //             Total := TotalE1 + TotalE2 + TotalE3;
    //             /*
    //             AccidentTravail:=ROUND((Total*(3.8))/100);
    //             CotisationPatronal:=ROUND((Total*(16.57))/100);
    //             CotisationPersonnel:=ROUND((Total*(9.18))/100);
    //             */
    //             /* AccidentTravail := ROUND((Total * (RecHumanSetup."Taux Accidents du travail CNSS")) / 100);
    //              CotisationPatronal := ROUND((Total * (RecHumanSetup."Taux Part patronale CNSS")) / 100);
    //              CotisationPersonnel := ROUND((Total * (RecHumanSetup."Taux Part salariale CNSS")) / 100);
    //              CotisationGlobal := AccidentTravail + CotisationPatronal + CotisationPersonnel;*/


    //         end;

    //         trigger OnPreDataItem()
    //         begin

    //             IF CompanyInformation.GET THEN;
    //             /*Declarationsalaires.RESET;
    //             Declarationsalaires.SETRANGE(Declarationsalaires.Année,Année);
    //             Declarationsalaires.SETRANGE(Declarationsalaires.Trimestre,xTrimestre+1);
    //             Declarationsalaires.SETRANGE(Cloturer,TRUE);

    //             IF Declarationsalaires.FINDFIRST THEN ERROR(Text001,Année,xTrimestre+1);*/

    //         end;
    //     }
    // }


    // requestpage
    // {
    //     layout
    //     {
    //         area(content)
    //         {
    //             group("Filtres")
    //             {
    //                 field(Année; Année)
    //                 {
    //                     Caption = 'Année';
    //                     ApplicationArea = All;
    //                 }
    //                 field(xTrimestre; xTrimestre)
    //                 {
    //                     ApplicationArea = All;
    //                     Caption = 'Trimestre';
    //                 }
    //             }
    //         }
    //     }
    //     actions
    //     {
    //     }
    // }

    // labels
    // {
    // }

    // trigger OnInitReport()
    // begin
    //     Année := DATE2DMY(WORKDATE, 3);

    //     xTrimestre := (DATE2DMY(WORKDATE, 2) - 1) DIV 3;
    // end;

    // var
    //     RecEmplyee: Record 5200;
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     LigneSalaireEnreg: Record 52048901;
    //     LigneSalaireEnreg1: Record 52048901;
    //     LigneSalaireEnreg2: Record 52048901;
    //     LigneSalaireEnreg3: Record 52048901;
    //     LigneSalaireEnreg4: Record 52048901;
    //     CompanyInformation: Record 79;
    //     RecSocialContribution: Record 52048903;
    //     xTrimestre: Option "Premier Trimestre","Deuxiéme Trimestre","Troisième Trimestre","Quatrième Trimestre";
    //     "Année": Integer;
    //     Total1: Decimal;
    //     Total2: Decimal;
    //     Total3: Decimal;
    //     TotalE1: Decimal;
    //     TotalE2: Decimal;
    //     TotalE3: Decimal;
    //     Total: Decimal;
    //     CotisationPersonnel: Decimal;
    //     CotisationPatronal: Decimal;
    //     AccidentTravail: Decimal;
    //     CotisationGlobal: Decimal;
    //     Convert: Codeunit 50001;
    //     Comp: Text[30];
    //     CNSS: Record 52048885;
    //     mois1: Decimal;
    //     mois2: Decimal;
    //     mois3: Decimal;
    //     SommeLigne: Decimal;
    //     i: Integer;
    //     j: Integer;
    //     m: Integer;
    //     Cnt: Record 5211;
    //     LibMois1: Text[30];
    //     LibMois2: Text[30];
    //     LibMois3: Text[30];
    //     DMin: Date;
    //     An: Integer;
    //     GLSetup: Record 98;
    //     TFmois1: Decimal;
    //     TFmois2: Decimal;
    //     TFmois3: Decimal;
    //     K: Integer;
    //     NJ1: Decimal;
    //     NJ2: Decimal;
    //     NJ3: Decimal;
    //     Effectif: Integer;
    //     EffectifEntete: Integer;
    //     TmpEmployee: Code[20];
    //     CodeU: Codeunit 50005;
    //     TextGMnt: Text[600];
    //     "1erMois": Text[30];
    //     "2emeMois": Text[30];
    //     "3emeMois": Text[30];
    //     PageConst: Label 'Page';
    //     Num: Integer;
    //     "// RB SORO": Integer;
    //     LinesPrinted: Integer;
    //     SommePage1: Decimal;
    //     SommePage2: Decimal;
    //     SommePage3: Decimal;
    //     TotalPage: Decimal;
    //     NouvellePage: Boolean;
    //     SommeRep1: Decimal;
    //     SommeRep2: Decimal;
    //     SommeRep3: Decimal;
    //     TotalRep: Decimal;
    //     RecHumanSetup: Record 5218;
    //     RecEmployeeAvg: Record 5200;
    //     NumSecuriteSocial: Code[20];
    //     fk: Integer;
    //     fg: Integer;
    //     TotCnss: Decimal;
    //     Declarationsalaires: Record 52048919;
    //     Text001: Label 'Declaration Année %1, Trimestre %2 Deja Integrer et Cloturer';
    //     Supprimer: Boolean;
    //     tmp: Record 59993;
    //     DECLARATION_TRIMESTRIELLE_DES_SALAIRESCaptionLbl: Label 'DECLARATION TRIMESTRIELLE DES SALAIRES';
    //     Mle_CNSS__CaptionLbl: Label 'Mle CNSS :';
    //     Matr__CNSSCaptionLbl: Label 'Matr. CNSS';
    //     MatriculeCaptionLbl: Label 'Matricule';
    //     NOM_ET_PRENOMCaptionLbl: Label 'NOM ET PRENOM';
    //     "Catég_CaptionLbl": Label 'Catég.';
    //     TOTALCaptionLbl: Label 'TOTAL';
    //     RENUMERATIONCaptionLbl: Label 'RENUMERATION';
    //     N_CaptionLbl: Label 'N°';
    //     R_____E_____P_____O_____R_____T_____SCaptionLbl: Label 'R     E     P     O     R     T     S';
    //     R_____E_____P_____O_____R_____T_____SCaption_Control1000000057Lbl: Label 'R     E     P     O     R     T     S';
    //     Cotisation_du_Personnel__9_18_____CaptionLbl: Label 'Cotisation du Personnel (9,18 %) :';
    //     Cotisation_du_Patronale__16_57_____CaptionLbl: Label 'Cotisation du Patronale (16,57 %) :';
    //     Accident_de_Travail__3_80_____CaptionLbl: Label 'Accident de Travail (3,80 %) :';
    //     Cotisation_Globale___29_55_____CaptionLbl: Label 'Cotisation Globale  (29,55 %) :';
    //     "Arrêtée_la_présente_déclaration_à_la_somme_de___CaptionLbl": Label 'Arrêtée la présente déclaration à la somme de  :';
    //     T__O__T__A__LCaptionLbl: Label 'T  O  T  A  L';
    //     R_____E_____P_____O_____R_____T_____SCaption_Control1000000059Lbl: Label 'R     E     P     O     R     T     S';
    //     "Faite_à______________________________Le________________________CaptionLbl": Label 'Faite à ............................ Le .......................';
}

