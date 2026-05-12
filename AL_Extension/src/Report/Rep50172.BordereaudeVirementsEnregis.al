report 50172 "Bordereau de Virements Enregis"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/BordereaudeVirementsEnregis.rdlc';

    // dataset
    // {
    //     dataitem("Rec. Salary Lines"; 52048901)
    //     {
    //         DataItemTableView = SORTING(Month, Year, Employee)
    //                             WHERE(RIB = FILTER(<> ''),
    //                                   "Code Mode Réglement" = FILTER("Virement"));
    //         RequestFilterFields = Month, Year, Affectation, "Lot Virement Salaire";
    //         column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(Rec__Salary_Lines_Month; Month)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Year; Year)
    //         {
    //         }
    //         column(CompanyInformation_Name; CompanyInformation.Name)
    //         {
    //         }
    //         column(RecBankAccountLotPaie_RIB; RecBankAccountLotPaie.RIB)
    //         {
    //         }
    //         column(RecBankAccountLotPaie_Name; RecBankAccountLotPaie.Name)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Name; Name)
    //         {
    //         }
    //         column(Rec__Salary_Lines__Net_salary_cashed_; "Net salary cashed")
    //         {
    //         }
    //         column(Rec__Salary_Lines_RIB; RIB)
    //         {
    //         }
    //         column(NomBq; NomBq)
    //         {
    //         }
    //         column(Rec__Salary_Lines__Net_salary_cashed__Control1000000032; "Net salary cashed")
    //         {
    //         }
    //         column(Nbre; Nbre)
    //         {
    //         }
    //         column(ORDRE_DE_VIREMENTCaption; ORDRE_DE_VIREMENTCaptionLbl)
    //         {
    //         }
    //         column(BANQUE__Caption; BANQUE__CaptionLbl)
    //         {
    //         }
    //         column(RIB_DONNEUR_D_ORDRE__Caption; RIB_DONNEUR_D_ORDRE__CaptionLbl)
    //         {
    //         }
    //         column(NOM_PRENOM___RS__Caption; NOM_PRENOM___RS__CaptionLbl)
    //         {
    //         }
    //         column(MOTIF_DU_VIREMENT__Caption; MOTIF_DU_VIREMENT__CaptionLbl)
    //         {
    //         }
    //         column(VIREMENT_SALAIRE_Caption; VIREMENT_SALAIRE_CaptionLbl)
    //         {
    //         }
    //         column("Résérvé_au_virement_permanentCaption"; Résérvé_au_virement_permanentCaptionLbl)
    //         {
    //         }
    //         column("Date_Dernière_Exécution__Caption"; Date_Dernière_Exécution__CaptionLbl)
    //         {
    //         }
    //         column("Périodicité__M_T_S_A___Caption"; Périodicité__M_T_S_A___CaptionLbl)
    //         {
    //         }
    //         column("Date_1ére__Exécution__Caption"; Date_1ére__Exécution__CaptionLbl)
    //         {
    //         }
    //         column(Nom_et_PrenomCaption; Nom_et_PrenomCaptionLbl)
    //         {
    //         }
    //         column("Net_à_payerCaption"; Net_à_payerCaptionLbl)
    //         {
    //         }
    //         column(Rec__Salary_Lines_RIBCaption; FIELDCAPTION(RIB))
    //         {
    //         }
    //         column(BqCaption; BqCaptionLbl)
    //         {
    //         }
    //         column("Total_à_Payer__Caption"; Total_à_Payer__CaptionLbl)
    //         {
    //         }
    //         column(Nb_Caption; Nb_CaptionLbl)
    //         {
    //         }
    //         column(Important__Caption; Important__CaptionLbl)
    //         {
    //         }
    //         column("V1__Cet_Ordre_ne_sera_executé_que_si_la_situation_du_donneur_d_ordre_le_permet_Caption"; V1__Cet_Ordre_ne_sera_executé_que_si_la_situation_du_donneur_d_ordre_le_permet_CaptionLbl)
    //         {
    //         }
    //         column(DataItem1000000039; V2__Le_donneur_d_ordre_dégage_d_ores)
    //         {
    //         }
    //         column(Signature_du_ClientCaption; Signature_du_ClientCaptionLbl)
    //         {
    //         }
    //         column(AgenceCaption; AgenceCaptionLbl)
    //         {
    //         }
    //         column(Rec__Salary_Lines_No_; "No.")
    //         {
    //         }
    //         column(Rec__Salary_Lines_Employee; Employee)
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin

    //                 IF CompanyInformation.GET THEN;
    //                 IF EnteteLotPaie.GET("Rec. Salary Lines"."Lot Virement Salaire") THEN;
    //                 EnteteLotPaie.FINDFIRST;
    //                 CodeBanque := EnteteLotPaie."Code Banque";

    //                 BankAccount.SETRANGE(BankAccount."No.", CodeBanque);
    //                 IF BankAccount.FINDFIRST THEN;
    //                 RibBank := BankAccount.RIB;
    //                 Banque := FORMAT(BankAccount.Banque);

    //                 Nbre := Nbre + 1;

    //             CodeBanqueRIB := COPYSTR("Rec. Salary Lines".RIB, 1, 2);
    //             IF CodeBanqueRIB = '01' THEN
    //                 NomBq := 'ATB'
    //             ELSE IF CodeBanqueRIB = '02' THEN
    //                 NomBq := 'BFT'
    //             ELSE IF CodeBanqueRIB = '03' THEN
    //                 NomBq := 'BNA'
    //             ELSE IF CodeBanqueRIB = '04' THEN
    //                 NomBq := 'ATTB'
    //             ELSE IF CodeBanqueRIB = '05' THEN
    //                 NomBq := 'BT'
    //             ELSE IF CodeBanqueRIB = '07' THEN
    //                 NomBq := 'AB'
    //             ELSE IF CodeBanqueRIB = '08' THEN
    //                 NomBq := 'BIAT'
    //             ELSE IF CodeBanqueRIB = '09' THEN
    //                 NomBq := 'BDET'
    //             ELSE IF CodeBanqueRIB = '10' THEN
    //                 NomBq := 'STB'
    //             ELSE IF CodeBanqueRIB = '11' THEN
    //                 NomBq := 'UBCI'
    //             ELSE IF CodeBanqueRIB = '12' THEN
    //                 NomBq := 'UIB'
    //             ELSE IF CodeBanqueRIB = '14' THEN
    //                 NomBq := 'BH'
    //             ELSE IF CodeBanqueRIB = '16' THEN
    //                 NomBq := 'CITIBANK'
    //             ELSE IF CodeBanqueRIB = '17' THEN
    //                 NomBq := 'CCP'
    //             ELSE IF CodeBanqueRIB = '18' THEN
    //                 NomBq := 'BNDT'
    //             ELSE IF CodeBanqueRIB = '20' THEN
    //                 NomBq := 'BTK'
    //             ELSE IF CodeBanqueRIB = '21' THEN
    //                 NomBq := 'STUSID'
    //             ELSE IF CodeBanqueRIB = '23' THEN
    //                 NomBq := 'QNB'
    //             ELSE IF CodeBanqueRIB = '24' THEN
    //                 NomBq := 'BTE'
    //             ELSE IF CodeBanqueRIB = '25' THEN
    //                 NomBq := 'BZ'
    //             ELSE IF CodeBanqueRIB = '26' THEN
    //                 NomBq := 'BTL'
    //             ELSE IF CodeBanqueRIB = '27' THEN
    //                 NomBq := 'BTS'
    //             ELSE IF CodeBanqueRIB = '28' THEN
    //                 NomBq := 'ABC ON SHOR'
    //             ELSE IF CodeBanqueRIB = '29' THEN
    //                 NomBq := 'BFPME'
    //             ELSE IF CodeBanqueRIB = '31' THEN
    //                 NomBq := 'BCMA'
    //             ELSE IF CodeBanqueRIB = '32' THEN
    //                 NomBq := 'BEST'
    //             ELSE IF CodeBanqueRIB = '33' THEN
    //                 NomBq := 'NAIB'
    //             ELSE IF CodeBanqueRIB = '34' THEN
    //                 NomBq := 'TAAB'
    //             ELSE IF CodeBanqueRIB = '35' THEN
    //                 NomBq := 'ALUBAF'
    //             ELSE IF CodeBanqueRIB = '45' THEN
    //                 NomBq := 'IM BANK'
    //             ELSE IF CodeBanqueRIB = '72' THEN
    //                 NomBq := 'UTB'
    //             ELSE IF CodeBanqueRIB = '73' THEN
    //                 NomBq := 'TIB'
    //             ELSE IF CodeBanqueRIB = '74' THEN
    //                 NomBq := 'LINK'
    //             ELSE IF CodeBanqueRIB = '75' THEN
    //                 NomBq := 'CITBANK OFF'
    //             ELSE IF CodeBanqueRIB = '78' THEN
    //                 NomBq := 'ABC OFF SHOR'
    //             ELSE IF CodeBanqueRIB = '90' THEN
    //                 NomBq := 'BTC'
    //             ELSE IF CodeBanqueRIB = '97' THEN
    //                 NomBq := 'ABC'
    //             ELSE
    //                 NomBq := '';
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             LastFieldNo := FIELDNO(Year);
    //             CodeLotVirement := "Rec. Salary Lines".GETFILTER("Lot Virement Salaire");
    //             RecEnteteLotPaie.SETRANGE(Code, CodeLotVirement);
    //             IF RecEnteteLotPaie.FINDFIRST THEN BEGIN
    //                 CodeBanqueLotPaie := RecEnteteLotPaie."Code Banque";
    //             END;
    //             IF RecBankAccountLotPaie.GET(CodeBanqueLotPaie) THEN;
    //         end;
    //     }
    // }

    // requestpage
    // {

    //     layout
    //     {
    //     }

    //     actions
    //     {
    //     }
    // }

    // labels
    // {
    // }

    // var
    //     PageConst: Label 'Page';
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     TotalFor: Label 'Total ';
    //     CompanyInformation: Record 79;
    //     Nbre: Integer;
    //     EnteteLotPaie: Record 52048956;
    //     CodeBanque: Code[10];
    //     BankAccount: Record 270;
    //     RibBank: Text[40];
    //     Banque: Text[30];
    //     NomBq: Text[12];
    //     CodeBanqueRIB: Text[2];
    //     CodeLotVirement: Code[20];
    //     CodeBanqueLotPaie: Code[20];
    //     RecEnteteLotPaie: Record 52048956;
    //     RecBankAccountLotPaie: Record 270;
    //     ORDRE_DE_VIREMENTCaptionLbl: Label 'ORDRE DE VIREMENT';
    //     BANQUE__CaptionLbl: Label 'BANQUE :';
    //     RIB_DONNEUR_D_ORDRE__CaptionLbl: Label 'RIB DONNEUR D''ORDRE :';
    //     NOM_PRENOM___RS__CaptionLbl: Label 'NOM PRENOM / RS :';
    //     MOTIF_DU_VIREMENT__CaptionLbl: Label 'MOTIF DU VIREMENT :';
    //     VIREMENT_SALAIRE_CaptionLbl: Label 'VIREMENT SALAIRE ';
    //     "Résérvé_au_virement_permanentCaptionLbl": Label 'Résérvé au virement permanent';
    //     "Date_Dernière_Exécution__CaptionLbl": Label 'Date Dernière Exécution :';
    //     "Périodicité__M_T_S_A___CaptionLbl": Label 'Périodicité (M/T/S/A) :';
    //     "Date_1ére__Exécution__CaptionLbl": Label 'Date 1ére  Exécution :';
    //     Nom_et_PrenomCaptionLbl: Label 'Nom et Prenom';
    //     "Net_à_payerCaptionLbl": Label 'Net à payer';
    //     BqCaptionLbl: Label 'Bq';
    //     "Total_à_Payer__CaptionLbl": Label 'Total à Payer :';
    //     Nb_CaptionLbl: Label 'Nb.';
    //     Important__CaptionLbl: Label 'Important :';
    //     "V1__Cet_Ordre_ne_sera_executé_que_si_la_situation_du_donneur_d_ordre_le_permet_CaptionLbl": Label '1. Cet Ordre ne sera executé que si la situation du donneur d''ordre le permet,';
    //     "V2__Le_donneur_d_ordre_dégage_d_ores": Label '2. Le donneur d''ordre dégage d''ores et déja la responsabilité de la banque pour les conséquences découlant du libellé d''un RIB:RIP erroné.';
    //     Signature_du_ClientCaptionLbl: Label 'Signature du Client';
    //     AgenceCaptionLbl: Label 'Agence';
}

