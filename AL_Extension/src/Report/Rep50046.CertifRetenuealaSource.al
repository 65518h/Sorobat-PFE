report 50046 "Certif. Retenue a la Source"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/CertifRetenuealaSource.rdlc';

    // dataset
    // {
    //     dataitem("Payment Header"; 10865)
    //     {
    //         CalcFields = Amount;
    //         DataItemTableView = SORTING("No.")
    //                             ORDER(Ascending);
    //         PrintOnlyIfDetail = true;
    //         RequestFilterFields = "No.";
    //         column(Payment_Header_No_; "No.")
    //         {
    //         }
    //         dataitem("Payment Line"; 10866)
    //         {
    //             DataItemLink = "No." = FIELD("No.");
    //             DataItemTableView = SORTING("Account No.", "Due Date")
    //                                 ORDER(Ascending)
    //                                 WHERE(Amount = FILTER(<> 0),
    //                                       "Account Type" = CONST(Vendor));
    //             PrintOnlyIfDetail = false;
    //             RequestFilterFields = "Line No.";
    //             column(InfoSoc_Name; InfoSoc.Name)
    //             {
    //             }
    //             column(InfoSoc_Address; InfoSoc.Address)
    //             {
    //             }
    //             column(COPYSTR_InfoSoc__VAT_Registration_No___1_1_; COPYSTR(InfoSoc."VAT Registration No.", 1, 1))
    //             {
    //             }
    //             column(COPYSTR_InfoSoc__VAT_Registration_No____9_1_; COPYSTR(InfoSoc."VAT Registration No.", 9, 1))
    //             {
    //             }
    //             column(COPYSTR_InfoSoc__VAT_Registration_No___10_1_; COPYSTR(InfoSoc."VAT Registration No.", 10, 1))
    //             {
    //             }
    //             column(COPYSTR_InfoSoc__VAT_Registration_No___11_1_; COPYSTR(InfoSoc."VAT Registration No.", 11, 1))
    //             {
    //             }
    //             column(COPYSTR_InfoSoc__VAT_Registration_No___12_1_; COPYSTR(InfoSoc."VAT Registration No.", 12, 1))
    //             {
    //             }
    //             column(COPYSTR_InfoSoc__VAT_Registration_No___13_1_; COPYSTR(InfoSoc."VAT Registration No.", 13, 1))
    //             {
    //             }
    //             column(COPYSTR_InfoSoc__VAT_Registration_No___2_1_; COPYSTR(InfoSoc."VAT Registration No.", 2, 1))
    //             {
    //             }
    //             column(COPYSTR_InfoSoc__VAT_Registration_No___4_1_; COPYSTR(InfoSoc."VAT Registration No.", 4, 1))
    //             {
    //             }
    //             column(COPYSTR_InfoSoc__VAT_Registration_No___6_1_; COPYSTR(InfoSoc."VAT Registration No.", 6, 1))
    //             {
    //             }
    //             column(COPYSTR_InfoSoc__VAT_Registration_No___3_1_; COPYSTR(InfoSoc."VAT Registration No.", 3, 1))
    //             {
    //             }
    //             column(COPYSTR_InfoSoc__VAT_Registration_No___5_1_; COPYSTR(InfoSoc."VAT Registration No.", 5, 1))
    //             {
    //             }
    //             column(COPYSTR_InfoSoc__VAT_Registration_No___7_1_; COPYSTR(InfoSoc."VAT Registration No.", 7, 1))
    //             {
    //             }
    //             column(COPYSTR_InfoSoc__VAT_Registration_No___8_1_; COPYSTR(InfoSoc."VAT Registration No.", 8, 1))
    //             {
    //             }
    //             column(Payment_Header___Folio_N__RS_; "Payment Header"."Folio N° RS")
    //             {
    //             }
    //             column(Payment_Line__Montant_Initial_DS_; "Montant Initial DS")
    //             {
    //                 AutoFormatType = 1;
    //             }
    //             column(FORMAT_Taux_____; FORMAT(Taux) + '%')
    //             {
    //             }
    //             column(Payment_Line__Payment_Line___Montant_Retenue_; "Payment Line"."Montant Retenue")
    //             {
    //                 AutoFormatType = 1;
    //             }
    //             column(Payment_Line__Payment_Line___Amount__LCY__; "Payment Line"."Amount (LCY)")
    //             {
    //                 AutoFormatType = 1;
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(TxtDesignation; TxtDesignation)
    //             {
    //             }
    //             column(FORMAT_Taux______Control1000000088; FORMAT(Taux) + '%')
    //             {
    //             }
    //             column(DecTotBAseRetenuT; DecTotBAseRetenuT)
    //             {
    //                 AutoFormatType = 1;
    //             }
    //             column(DecTotMontantRetenuT; DecTotMontantRetenuT)
    //             {
    //                 AutoFormatType = 1;
    //             }
    //             column(DecTotMontantNetT; DecTotMontantNetT)
    //             {
    //                 AutoFormatType = 1;
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(TxtDesignation_Control1000000096; TxtDesignation)
    //             {
    //             }
    //             column(DecTotBAseRetenu; DecTotBAseRetenu)
    //             {
    //                 AutoFormatType = 1;
    //             }
    //             column(DecTotMontantRetenu; DecTotMontantRetenu)
    //             {
    //                 AutoFormatType = 1;
    //             }
    //             column(DecTotMontantNet; DecTotMontantNet)
    //             {
    //                 AutoFormatType = 1;
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(FORMAT_Taux______Control1000000074; FORMAT(Taux) + '%')
    //             {
    //             }
    //             column(TxtDesignation_Control1000000076; TxtDesignation)
    //             {
    //             }
    //             column(InfoSoc_City___Le_____FORMAT_WORKDATE___; InfoSoc.City + ' Le : ' + FORMAT(WORKDATE()))
    //             {
    //             }
    //             column(Frnsr_Address; Frnsr.Address)
    //             {
    //             }
    //             column("Payment_Line__Payment_Line__Libellé"; "Payment Line".Libellé)
    //             {
    //             }
    //             column(CIN; CIN)
    //             {
    //             }
    //             column(COPYSTR_Frnsr__VAT_Registration_No___1_1_; COPYSTR(Frnsr."VAT Registration No.", 1, 1))
    //             {
    //             }
    //             column(COPYSTR_Frnsr__VAT_Registration_No___9_1_; COPYSTR(Frnsr."VAT Registration No.", 9, 1))
    //             {
    //             }
    //             column(COPYSTR_Frnsr__VAT_Registration_No___10_1_; COPYSTR(Frnsr."VAT Registration No.", 10, 1))
    //             {
    //             }
    //             column(COPYSTR_Frnsr__VAT_Registration_No___11_1_; COPYSTR(Frnsr."VAT Registration No.", 11, 1))
    //             {
    //             }
    //             column(Facture; Facture)
    //             {
    //                 AutoFormatType = 1;
    //             }
    //             column(COPYSTR_Frnsr__VAT_Registration_No___12_1_; COPYSTR(Frnsr."VAT Registration No.", 12, 1))
    //             {
    //             }
    //             column(COPYSTR_Frnsr__VAT_Registration_No___13_1_; COPYSTR(Frnsr."VAT Registration No.", 13, 1))
    //             {
    //             }
    //             column(COPYSTR_Frnsr__VAT_Registration_No___2_1_; COPYSTR(Frnsr."VAT Registration No.", 2, 1))
    //             {
    //             }
    //             column(COPYSTR_Frnsr__VAT_Registration_No___3_1_; COPYSTR(Frnsr."VAT Registration No.", 3, 1))
    //             {
    //             }
    //             column(COPYSTR_Frnsr__VAT_Registration_No___4_1_; COPYSTR(Frnsr."VAT Registration No.", 4, 1))
    //             {
    //             }
    //             column(COPYSTR_Frnsr__VAT_Registration_No___5_1_; COPYSTR(Frnsr."VAT Registration No.", 5, 1))
    //             {
    //             }
    //             column(COPYSTR_Frnsr__VAT_Registration_No___6_1_; COPYSTR(Frnsr."VAT Registration No.", 6, 1))
    //             {
    //             }
    //             column(COPYSTR_Frnsr__VAT_Registration_No___7_1_; COPYSTR(Frnsr."VAT Registration No.", 7, 1))
    //             {
    //             }
    //             column(COPYSTR_Frnsr__VAT_Registration_No___8_1_; COPYSTR(Frnsr."VAT Registration No.", 8, 1))
    //             {
    //             }
    //             column(N__Etab_SecondaireCaption; N__Etab_SecondaireCaptionLbl)
    //             {
    //             }
    //             column(Article_52_du_code_de_l_IRPP___de_l_IS__Caption; Article_52_du_code_de_l_IRPP___de_l_IS__CaptionLbl)
    //             {
    //             }
    //             column(CERTIFICAT_DE_RETENUE_D_IMPOT_SUR_LES_REVENUS_OU_D_IMPOTS_SUR_LES_SOCIETESCaption; CERTIFICAT_DE_RETENUE_D_IMPOT_SUR_LES_REVENUS_OU_D_IMPOTS_SUR_LES_SOCIETESCaptionLbl)
    //             {
    //             }
    //             column("Code_Catégorie2Caption"; Code_Catégorie2CaptionLbl)
    //             {
    //             }
    //             column(Code_TVACaption; Code_TVACaptionLbl)
    //             {
    //             }
    //             column(REPUBLIQUE_TUNISIENNE_MINISTERE_DES_FINANCESCaption; REPUBLIQUE_TUNISIENNE_MINISTERE_DES_FINANCESCaptionLbl)
    //             {
    //             }
    //             column(DIRECTION_GENERALE_DU_CONTROLE_FISCALCaption; DIRECTION_GENERALE_DU_CONTROLE_FISCALCaptionLbl)
    //             {
    //             }
    //             column(A___PERSONNE_OU_ORGANISME_PAYEURCaption; A___PERSONNE_OU_ORGANISME_PAYEURCaptionLbl)
    //             {
    //             }
    //             column("Dénomination_de_la_personne_ou_l_organisme_payeur__Caption"; Dénomination_de_la_personne_ou_l_organisme_payeur__CaptionLbl)
    //             {
    //             }
    //             column(Adresse__Caption; Adresse__CaptionLbl)
    //             {
    //             }
    //             column(Matricule_FiscaleCaption; Matricule_FiscaleCaptionLbl)
    //             {
    //             }
    //             column(IDENTIFIANTCaption; IDENTIFIANTCaptionLbl)
    //             {
    //             }
    //             column(B___RETENUES_EFFECTUEES_SURCaption; B___RETENUES_EFFECTUEES_SURCaptionLbl)
    //             {
    //             }
    //             column(TauxCaption; TauxCaptionLbl)
    //             {
    //             }
    //             column(Base_RetenueCaption; Base_RetenueCaptionLbl)
    //             {
    //             }
    //             column(Montant_retenueCaption; Montant_retenueCaptionLbl)
    //             {
    //             }
    //             column(Montant_NetCaption; Montant_NetCaptionLbl)
    //             {
    //             }
    //             column(Cachet_et_signature__du_payeurCaption; Cachet_et_signature__du_payeurCaptionLbl)
    //             {
    //             }
    //             column(DataItem1000000079; Le_soussigné__certifie_exacts_les_renseignements)
    //             {
    //             }
    //             column(Adresse_Professionnelle_Caption; Adresse_Professionnelle_CaptionLbl)
    //             {
    //             }
    //             column("Nom__Prénom_ou_Raison_Sociale__Caption"; Nom__Prénom_ou_Raison_Sociale__CaptionLbl)
    //             {
    //             }
    //             column(Ou_N__C_I_N___Caption; Ou_N__C_I_N___CaptionLbl)
    //             {
    //             }
    //             column(C___BENEFICIAIRECaption; C___BENEFICIAIRECaptionLbl)
    //             {
    //             }
    //             column(Factures_objet_de_retenues__Caption; Factures_objet_de_retenues__CaptionLbl)
    //             {
    //             }
    //             column(N__Etab_SecondaireCaption_Control1000000001; N__Etab_SecondaireCaption_Control1000000001Lbl)
    //             {
    //             }
    //             column("Code_Catégorie2Caption_Control1000000002"; Code_Catégorie2Caption_Control1000000002Lbl)
    //             {
    //             }
    //             column(Code_TVACaption_Control1000000009; Code_TVACaption_Control1000000009Lbl)
    //             {
    //             }
    //             column(Matricule_FiscaleCaption_Control1000000011; Matricule_FiscaleCaption_Control1000000011Lbl)
    //             {
    //             }
    //             column(IDENTIFIANTCaption_Control1000000052; IDENTIFIANTCaption_Control1000000052Lbl)
    //             {
    //             }
    //             column(Payment_Line_No_; "No.")
    //             {
    //             }
    //             column(Payment_Line_Line_No_; "Line No.")
    //             {
    //             }
    //             column(Payment_Line_Account_No_; "Account No.")
    //             {
    //             }

    //             trigger OnAfterGetRecord()
    //             begin
    //                 Facture := '';
    //                 Frnsr.GET("Account No.");
    //                 Adr := Frnsr.Address;
    //                 //  Matr:=Frnsr."Date Création";
    //                 //  CIN := Frnsr."Code en Douane";
    //                 //$END;

    //                 EcrFrs.RESET;

    //                 //>> SODKI CODE ERRONE!!!!

    //                 //>>SODKI DSFT 26022009
    //                 //IBK 23/04/2010

    //                 ///////////////////
    //                 Retenu.SETRANGE(Code, "Code Retenue à la Source");
    //                 IF Retenu.FIND('-') THEN BEGIN
    //                     REPEAT
    //                         Taux := Retenu."% Retenue";
    //                         TxtDesignation := Retenu.Designation;
    //                     UNTIL Retenu.NEXT = 0;
    //                 END;
    //                 IF "Payment Line"."Applies-to ID" <> '' THEN BEGIN

    //                     IF "Account Type" = "Account Type"::Vendor THEN BEGIN
    //                         RecEcritureFornisseur.SETRANGE("Applies-to ID", "Applies-to ID");

    //                         IF RecEcritureFornisseur.FIND('-') THEN BEGIN
    //                             REPEAT
    //                                 Facture += RecEcritureFornisseur."External Document No." + ' , ';
    //                             UNTIL RecEcritureFornisseur.NEXT = 0;
    //                         END;
    //                     END;

    //                     IF "Account Type" = "Account Type"::Customer THEN BEGIN

    //                         RecEcritureClient.SETRANGE("Applies-to ID", "Applies-to ID");
    //                         IF RecEcritureClient.FIND('-') THEN BEGIN
    //                             REPEAT
    //                                 Facture += RecEcritureClient."External Document No.";
    //                             UNTIL RecEcritureClient.NEXT = 0;
    //                         END;
    //                     END;
    //                 END;
    //                 //****************TOTAL************
    //                 RecPayementLine.SETRANGE("Account No.", "Account No.");
    //                 DecTotBAseRetenuT := 0;
    //                 DecTotMontantRetenuT := 0;
    //                 DecTotMontantNetT := 0;
    //                 RecPayementLine.SETRANGE("Code Retenue à la Source", "Code Retenue à la Source");
    //                 IF RecPayementLine.FINDFIRST THEN
    //                     REPEAT
    //                         DecTotBAseRetenuT += RecPayementLine."Montant Initial DS" + RecPayementLine."Montant Retenue G. DS";
    //                         DecTotMontantRetenuT += RecPayementLine."Montant Retenue DS";
    //                         DecTotMontantNetT += RecPayementLine."Amount (LCY)";
    //                     UNTIL RecPayementLine.NEXT = 0;

    //                 //Modification affichage RS Folio
    //                 // RB SORO 27/04/2015   FOLIO N° RS
    //                 IF "Payment Line"."Folio N° RS" = '' THEN BEGIN
    //                     "Payment Line"."Folio N° RS" := FolioRS;
    //                     "Payment Line".MODIFY;
    //                 END;
    //                 // RB SORO 27/04/2015   FOLIO N° RS
    //             end;

    //             trigger OnPreDataItem()
    //             begin
    //                 // RB SORO 10/09/2015 Ipression Certificat reteune a la source pour le type de reglement "Avance Fournisseur"
    //                 IF ("Payment Header"."Payment Class" = 'AVANCE-FRS') THEN BEGIN
    //                     IF "Payment Line"."Montant Retenue Validé" <> 0 THEN
    //                         "Payment Line".SETFILTER("Montant Retenue Validé", '<> %1', 0)
    //                     ELSE
    //                         IF "Payment Line"."Montant Retenue" <> 0 THEN
    //                             "Payment Line".SETFILTER("Montant Retenue", '<> %1', 0)
    //                 END
    //                 ELSE BEGIN
    //                     "Payment Line".SETFILTER("Montant Retenue DS", '<> %1', 0)
    //                 END;
    //                 // RB SORO 10/09/2015
    //             end;
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             // Frnsr.GET("Account No.");
    //             /*
    //             PayLine.SETRANGE("No.","No.");
    //             BEGIN
    //               PayLine.SETFILTER("Montant Retenue",'0');
    //               IF PayLine.FINDFIRST THEN
    //                 CurrReport.SKIP
    //             END;
    //              */
    //             //Modification Affichage RS Folio

    //             // RB SORO 27/04/2015 FOLIO N° RS

    //             IF RecGLSetup.GET THEN;
    //             IF "Folio N° RS" = '' THEN BEGIN
    //                 FolioRS := NoSeriesMgt.GetNextNo(RecGLSetup."Souche Retenue Source", TODAY, TRUE);
    //                 "Folio N° RS" := FolioRS;
    //                 MODIFY;
    //             END;

    //             // RB SORO 27/04/2015
    //             //JB 

    //             //     IF ("Payment Header"."Payment Class" = 'AVANCE-FRS') THEN BEGIN
    //             //         IF "Payment Line"."Montant Retenue Validé" <> 0 THEN BEGIN
    //             //             DecTotBAseRetenu += "Montant Initial";
    //             //             DecTotMontantRetenu += "Montant Retenue Validé";
    //             //             DecTotMontantNet += "Amount (LCY)";
    //             //         END
    //             //         ELSE IF "Payment Line"."Montant Retenue" <> 0 THEN BEGIN
    //             //             DecTotBAseRetenu += "Montant Initial DS";
    //             //             DecTotMontantRetenu += "Montant Retenue";
    //             //             DecTotMontantNet += "Amount (LCY)";
    //             //         END;
    //             //     END
    //             //     ELSE BEGIN
    //             //         DecTotBAseRetenu += "Montant Initial DS";
    //             //         DecTotMontantRetenu += "Montant Retenue DS";
    //             //         DecTotMontantNet += "Amount (LCY)";
    //             //     END;
    //             //     // RB SORO 10/09/2015


    //             //     IF "Payment Line"."Montant Retenue Validé" <> 0 THEN
    //             //         "Payment Line".SETFILTER("Montant Retenue Validé", '<> %1', 0)
    //             //     ELSE IF "Payment Line"."Montant Retenue" <> 0 THEN
    //             //         "Payment Line".SETFILTER("Montant Retenue", '<> %1', 0)
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             InfoSoc.GET;
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

    // trigger OnInitReport()
    // begin
    //     afficherdetail := 2;
    // end;

    // var
    //     Frnsr: Record 23;
    //     Nom: Text[100];
    //     Adr: Text[100];
    //     Matr: Code[20];
    //     CIN: Code[10];
    //     Cmpt: Code[10];
    //     NChq: Integer;
    //     Convert: Codeunit 80;
    //     N: Integer;
    //     I: Integer;
    //     PayLine: Record 10866;
    //     "Marché": Text[100];
    //     Retenu: Record 50002;
    //     Taux: Decimal;
    //     InfoSoc: Record 79;
    //     "LibeléRetenue": Text[100];
    //     BaseRetenue: Decimal;
    //     MontantRetenue: Decimal;
    //     MontantNet: Decimal;
    //     EcrFrs: Record 25;
    //     Facture: Text[500];
    //     TxtDesignation: Text[50];
    //     RecEcritureFornisseur: Record 25;
    //     RecEcritureClient: Record 21;
    //     DecTotBAseRetenu: Decimal;
    //     DecTotMontantRetenu: Decimal;
    //     DecTotMontantNet: Decimal;
    //     afficherdetail: Integer;
    //     RecPayementLine: Record 10866;
    //     DEcTotTaux: Decimal;
    //     DecTotBAseRetenuT: Decimal;
    //     DecTotMontantRetenuT: Decimal;
    //     DecTotMontantNetT: Decimal;
    //     "// RB SORO 27/04/2015": Integer;
    //     FolioRS: Code[20];
    //     RecGLSetup: Record 98;
    //     NoSeriesMgt: Codeunit 396;
    //     RecPaymentLineRS: Record 10866;
    //     N__Etab_SecondaireCaptionLbl: Label 'N° Etab Secondaire';
    //     Article_52_du_code_de_l_IRPP___de_l_IS__CaptionLbl: Label '( Article 52 du code de l''IRPP & de l''IS )';
    //     CERTIFICAT_DE_RETENUE_D_IMPOT_SUR_LES_REVENUS_OU_D_IMPOTS_SUR_LES_SOCIETESCaptionLbl: Label 'CERTIFICAT DE RETENUE D''IMPOT SUR LES REVENUS OU D''IMPOTS SUR LES SOCIETES';
    //     "Code_Catégorie2CaptionLbl": Label 'Code Catégorie2';
    //     Code_TVACaptionLbl: Label 'Code TVA';
    //     REPUBLIQUE_TUNISIENNE_MINISTERE_DES_FINANCESCaptionLbl: Label 'REPUBLIQUE TUNISIENNE MINISTERE DES FINANCES';
    //     DIRECTION_GENERALE_DU_CONTROLE_FISCALCaptionLbl: Label 'DIRECTION GENERALE DU CONTROLE FISCAL';
    //     A___PERSONNE_OU_ORGANISME_PAYEURCaptionLbl: Label 'A - PERSONNE OU ORGANISME PAYEUR';
    //     "Dénomination_de_la_personne_ou_l_organisme_payeur__CaptionLbl": Label 'Dénomination de la personne ou l''organisme payeur :';
    //     Adresse__CaptionLbl: Label 'Adresse :';
    //     Matricule_FiscaleCaptionLbl: Label 'Matricule Fiscale';
    //     IDENTIFIANTCaptionLbl: Label 'IDENTIFIANT';
    //     B___RETENUES_EFFECTUEES_SURCaptionLbl: Label 'B - RETENUES EFFECTUEES SUR';
    //     TauxCaptionLbl: Label 'Taux';
    //     Base_RetenueCaptionLbl: Label 'Base Retenue';
    //     Montant_retenueCaptionLbl: Label 'Montant retenue';
    //     Montant_NetCaptionLbl: Label 'Montant Net';
    //     Cachet_et_signature__du_payeurCaptionLbl: Label 'Cachet et signature  du payeur';
    //     "Le_soussigné__certifie_exacts_les_renseignements": Label 'Le soussigné, certifie exacts les renseignements figurant sur le présent certificat et m''expose aux sanctions par la loi pour toute inexactitude.';
    //     Adresse_Professionnelle_CaptionLbl: Label 'Adresse Professionnelle:';
    //     "Nom__Prénom_ou_Raison_Sociale__CaptionLbl": Label 'Nom, Prénom ou Raison Sociale :';
    //     Ou_N__C_I_N___CaptionLbl: Label 'Ou N° C.I.N. :';
    //     C___BENEFICIAIRECaptionLbl: Label 'C - BENEFICIAIRE';
    //     Factures_objet_de_retenues__CaptionLbl: Label 'Factures objet de retenues :';
    //     N__Etab_SecondaireCaption_Control1000000001Lbl: Label 'N° Etab Secondaire';
    //     "Code_Catégorie2Caption_Control1000000002Lbl": Label 'Code Catégorie2';
    //     Code_TVACaption_Control1000000009Lbl: Label 'Code TVA';
    //     Matricule_FiscaleCaption_Control1000000011Lbl: Label 'Matricule Fiscale';
    //     IDENTIFIANTCaption_Control1000000052Lbl: Label 'IDENTIFIANT';
}

