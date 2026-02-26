//report 52048897 "Attestation de Salaire"
//{
// //Dynamix Services 2025  ID dans Nav 2009 : "39001478"
// UsageCategory = ReportsAndAnalysis;
// ApplicationArea = All;
// DefaultLayout = RDLC;
// RDLCLayout = './Layouts/AttestationdeSalaire.rdlc';

// dataset
// {
//     dataitem(Employee; 5200)
//     {
//         CalcFields = "Total Indemnité Par Defaut";
//         DataItemTableView = SORTING("No.")
//                             ORDER(Ascending);
//         RequestFilterFields = "No.";
//         column(REF_____CodeATT_Control1000000033; 'REF : ' + CodeATT)
//         {
//         }
//         column(Employee__First_And_Last_Name__Control1000000038; "First Name")
//         {
//         }
//         column(Employee__No___Control1000000041; "No.")
//         {
//         }
//         column(Employee__N__CIN__Control1000000045; "N° CIN")
//         {
//         }
//         column(WORKDATE_Control1000000048; WORKDATE)
//         {
//         }
//         column(TT; 'Est Employé titulaire au sein de notre société .')
//         {
//         }
//         column(Il_occupe_actuellement_le_poste_de_____FORMAT__Description_Qualification________Control1000000049; 'Il occupe actuellement le poste de   ' + FORMAT("Description Qualification") + ' .')
//         {
//         }
//         column(NonTitulaire2; 'attestons par la présente que Mr  ' + "First Name" + '  ayant le matricule   ' + "No." + '  , est ' + Situation + ' au sein de notre société à ce jour.')
//         {
//         }
//         column(REF_____CodeATT2; 'REF : ' + CodeATT)
//         {
//         }
//         column(DataItem1000000023; 'Il occupe actuellement le poste de   ' + FORMAT("Description Qualification") + '  et il perçoit un salaire brut mensuel  de  ' + FORMAT(ROUND(SalaireBrut)) + '  Dinars.')
//         {
//         }
//         column(WORKDATE; WORKDATE)
//         {
//         }
//         column(REF_____CodeATT_Control1000000015; 'REF : ' + CodeATT)
//         {
//         }
//         column(WORKDATE_Control1000000019; WORKDATE)
//         {
//         }
//         column(DataItem1000000028; 'attestons par la présente que Mr  ' + "First Name" + '  ayant le matricule   ' + "No." + '  , est ' + Situation + ' au sein de notre société.')
//         {
//         }
//         column(DataItem1000000030; 'Il occupe actuellement le poste de   ' + FORMAT("Description Qualification") + '  et il ne bénéficie d aucun prêt auprès de la SOROUBAT ')
//         {
//         }
//         column(WORKDATE_Control1120010; WORKDATE)
//         {
//         }
//         column(Employee__First_And_Last_Name_; "First Name")
//         {
//         }
//         column(Employee__No__; "No.")
//         {
//         }
//         column(Employee__N__CIN_; "N° CIN")
//         {
//         }
//         column(NTT; 'Est Employé contractuel au sein de notre société .')
//         {
//         }
//         column(Il_occupe_actuellement_le_poste_de_____FORMAT__Description_Qualification_______; 'Il occupe actuellement le poste de   ' + FORMAT("Description Qualification") + ' .')
//         {
//         }
//         column(REF_____CodeATT_Control1000000009; 'REF : ' + CodeATT)
//         {
//         }
//         column(ATTESTATION_DE_TRAVAILCaption_Control1000000034; ATTESTATION_DE_TRAVAILCaption_Control1000000034Lbl)
//         {
//         }
//         column(DataItem1000000034; Nous_soussignés__la_direction_du_personnel)
//         {
//         }
//         column(MrCaption_Control1000000036; MrCaption_Control1000000036Lbl)
//         {
//         }
//         column(EmptyStringCaption_Control1000000037; EmptyStringCaption_Control1000000037Lbl)
//         {
//         }
//         column(MatriculeCaption_Control1000000039; MatriculeCaption_Control1000000039Lbl)
//         {
//         }
//         column(EmptyStringCaption_Control1000000040; EmptyStringCaption_Control1000000040Lbl)
//         {
//         }
//         column(Megrine_leCaption_Control1000000042; Megrine_leCaption_Control1000000042Lbl)
//         {
//         }
//         column(C_I_NCaption_Control1000000043; C_I_NCaption_Control1000000043Lbl)
//         {
//         }
//         column(EmptyStringCaption_Control1000000044; EmptyStringCaption_Control1000000044Lbl)
//         {
//         }
//         column(DataItem1000000048; Cette_attestation_est_délivrée_à_l_intéressé__sur_sa_demande)
//         {
//         }
//         column("La_Direction_GénéraleCaption"; La_Direction_GénéraleCaptionLbl)
//         {
//         }
//         column(ATTESTATION_DE_SALAIRECaption; ATTESTATION_DE_SALAIRECaptionLbl)
//         {
//         }
//         column(DataItem1000000021; Nous_soussignés__la_direction_du_personnel_de_la_Société)
//         {
//         }
//         column(Megrine_leCaption; Megrine_leCaptionLbl)
//         {
//         }
//         column("Cette_attestation_est_délivrée_à_l_intéressé__sur_sa_demande__pour_servir_et_valoir_ce_que_de_droit_Caption"; Cette_attestation_est_délivrée_à_l_intéressé__sur_sa_demande__pour_servir_et_valoir_ce_que_de_droit_CaptionLbl)
//         {
//         }
//         column("La_Direction_GénéraleCaption_Control1000000027"; La_Direction_GénéraleCaption_Control1000000027Lbl)
//         {
//         }
//         column(ATTESTATION_DE_NON_BENEFICIERE_DE_PRETCaption; ATTESTATION_DE_NON_BENEFICIERE_DE_PRETCaptionLbl)
//         {
//         }
//         column(Megrine_leCaption_Control1000000017; Megrine_leCaption_Control1000000017Lbl)
//         {
//         }
//         column(DataItem1000000031; Cette_attestation_est_délivrée_à_l_intéressé__sur_sa_demande__pour_servir)
//         {
//         }
//         column(DataItem1000000051; Nous_soussignés__la_direction_du_personnel_de_la_Société_de_Routes)
//         {
//         }
//         column("La_Direction_GénéraleCaption_Control1000000050"; La_Direction_GénéraleCaption_Control1000000050Lbl)
//         {
//         }
//         column(ATTESTATION_DE_TRAVAILCaption; ATTESTATION_DE_TRAVAILCaptionLbl)
//         {
//         }
//         column(Megrine_leCaption_Control1120009; Megrine_leCaption_Control1120009Lbl)
//         {
//         }
//         column(DataItem1000000001; Nous_soussignés__la_direction_du_personnel_de_la_Société_de_Routes_et_de_Bâtiments___SOROUBAT)
//         {
//         }
//         column(MrCaption; MrCaptionLbl)
//         {
//         }
//         column(MatriculeCaption; MatriculeCaptionLbl)
//         {
//         }
//         column(C_I_NCaption; C_I_NCaptionLbl)
//         {
//         }
//         column(EmptyStringCaption; EmptyStringCaptionLbl)
//         {
//         }
//         column(EmptyStringCaption_Control1000000006; EmptyStringCaption_Control1000000006Lbl)
//         {
//         }
//         column(EmptyStringCaption_Control1000000007; EmptyStringCaption_Control1000000007Lbl)
//         {
//         }
//         column(DataItem1000000012; Cette_attestation_est_délivrée_à_l_intéressé__sur_sa_demande__pour_servir_et_valoir_ce_que_de_droit_Caption)
//         {
//         }
//         column(ATT; ATT)
//         {
//         }
//         column(Titulaire; Titulaire) { }
//         column(ATNB; ATNB) { }
//         column(ATTSAL; ATTSAL) { }
//         column("La_Direction_GénéraleCaption_Control1000000055"; La_Direction_GénéraleCaption_Control1000000055Lbl)
//         {
//         }


//         trigger OnAfterGetRecord()
//         begin

//             Employee.CALCFIELDS("Description Qualification");
//             Employee.CALCFIELDS("Indemnité imposable");
//             Employee.CALCFIELDS("Total Indemnité Par Defaut");
//             IF "Salaire De Base Horaire" = 0 THEN
//                 SalaireBrut := "Total Indemnité Par Defaut" + "Basis salary"
//             ELSE
//                 SalaireBrut := "Total Indemnité Par Defaut" + "Salaire De Base Horaire";
//         end;

//         trigger OnPreDataItem()
//         begin
//             CodeATT := '';
//             IF ATT = TRUE THEN CodeATT := NoSeriesMgt.GetNextNo('ATT-TRAV', 0D, TRUE);
//             IF ATNB = TRUE THEN CodeATT := NoSeriesMgt.GetNextNo('ATT-NBP', 0D, TRUE);
//             IF ATTSAL = TRUE THEN CodeATT := NoSeriesMgt.GetNextNo('ATT-SAL', 0D, TRUE);
//             IF Titulaire = TRUE THEN Situation := 'Employé titulaire' ELSE Situation := 'Employé contractuel ';
//         end;
//     }
// }

// requestpage
// {

//     layout
//     {
//         area(Content)
//         {
//             group(General)
//             {
//                 Caption = 'Général';
//                 field(ATT; ATT)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Attestation de travail';
//                     ToolTip = 'Attestation de travail';
//                     trigger OnValidate()
//                     begin

//                         ATTSAL := FALSE;
//                         ATT := TRUE;
//                         ATNB := FALSE;
//                     end;
//                 }

//                 field(ATTSAL; ATTSAL)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Attestation de salaire';
//                     ToolTip = 'Attestation de salaire';
//                     trigger OnValidate()
//                     begin

//                         ATTSAL := TRUE;
//                         ATT := FALSE;
//                         ATNB := FALSE;

//                     end;
//                 }
//                 field(ATNB; ATNB)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Attestation de non bénéficiaire de prêt';
//                     ToolTip = 'Attestation de non bénéficiaire de prêt';
//                     trigger OnValidate()
//                     begin

//                         ATTSAL := FALSE;
//                         ATT := FALSE;
//                         ATNB := TRUE;
//                     end;
//                 }
//                 field(Titulaire; Titulaire)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Titulaire';
//                     ToolTip = 'Titulaire';
//                     trigger OnValidate()
//                     begin
//                         ATTSAL := FALSE;
//                         ATT := FALSE;
//                         ATNB := TRUE;
//                     end;
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
//     ATTSAL := FALSE;
//     ATT := TRUE;
//     ATNB := FALSE;
// end;

// var
//     texte001: Label 'Nous soussignés,';
//     texte002: Label ' sise à ';
//     texte003: Label 'Attestons que :';
//     texte004: Label 'à';
//     texte005: Label 'perçoit un revenu annuel brut de ';
//     texte006: Label 'Cette attestation est délivrée à la demande de l''intéressée pour servir et valoir ce que de droit.';
//     C: Text[30];
//     il: Text[5];
//     E: Text[30];
//     texte007: Label 'CIN N° :';
//     Mnttexte: Text[100];
//     affichtext: Codeunit 50000;
//     "Rec_Employment Contract": Record 5211;
//     "Nbrementualité": Integer;
//     SalaireAnnuelleBrut: Decimal;
//     TxtNom: Text[60];
//     "Rec_Human Resources Setup": Record 5218;
//     RecEmployee: Record 5200;
//     CUconvert: Codeunit 50001;
//     NoSeriesMgt: Codeunit 396;
//     CodeATT: Code[20];
//     ATTSAL: Boolean;
//     ATT: Boolean;
//     ATNB: Boolean;
//     SalaireBrut: Decimal;
//     Titulaire: Boolean;
//     Situation: Text[30];
//     ATTESTATION_DE_TRAVAILCaption_Control1000000034Lbl: Label 'ATTESTATION DE TRAVAIL';
//     "Nous_soussignés__la_direction_du_personnel": Label 'Nous soussignés, la Société de Routes et de Bâtiments " SOROUBAT " sise face à la gare de Mégrine Riadh, attestons par la présente que :';
//     MrCaption_Control1000000036Lbl: Label 'Mr';
//     EmptyStringCaption_Control1000000037Lbl: Label ':';
//     MatriculeCaption_Control1000000039Lbl: Label 'Matricule';
//     EmptyStringCaption_Control1000000040Lbl: Label ':';
//     Megrine_leCaption_Control1000000042Lbl: Label 'Megrine le';
//     C_I_NCaption_Control1000000043Lbl: Label 'C.I.N';
//     EmptyStringCaption_Control1000000044Lbl: Label ':';
//     "Cette_attestation_est_délivrée_à_l_intéressé__sur_sa_demande": Label 'Cette attestation est délivrée à l''intéressé, sur sa demande, pour servir et valoir ce que de droit.';
//     "La_Direction_GénéraleCaptionLbl": Label 'La Direction Générale';
//     ATTESTATION_DE_SALAIRECaptionLbl: Label 'ATTESTATION DE SALAIRE';
//     "Nous_soussignés__la_direction_du_personnel_de_la_Société": Label 'Nous soussignés, la Société de Routes et de bâtiments " SOROUBAT " sise face à la gare Mégrine Riadh,';
//     Megrine_leCaptionLbl: Label 'Megrine le';
//     "Cette_attestation_est_délivrée_à_l_intéressé__sur_sa_demande__pour_servir_et_valoir_ce_que_de_droit_CaptionLbl": Label 'Cette attestation est délivrée à l''intéressé, sur sa demande, pour servir et valoir ce que de droit.';
//     "La_Direction_GénéraleCaption_Control1000000027Lbl": Label 'La Direction Générale';
//     ATTESTATION_DE_NON_BENEFICIERE_DE_PRETCaptionLbl: Label 'ATTESTATION DE NON BENEFICIERE DE PRET';
//     Megrine_leCaption_Control1000000017Lbl: Label 'Megrine le';
//     "Cette_attestation_est_délivrée_à_l_intéressé__sur_sa_demande__pour_servir": Label 'Cette attestation est délivrée à l''intéressé, sur sa demande, pour servir et valoir ce que de droit.';
//     "Nous_soussignés__la_direction_du_personnel_de_la_Société_de_Routes": Label 'Nous soussignés, la Société de Routes et de bâtiments " SOROUBAT " sise face à la gare Mégrine Riadh,';
//     "La_Direction_GénéraleCaption_Control1000000050Lbl": Label 'La Direction Générale';
//     ATTESTATION_DE_TRAVAILCaptionLbl: Label 'ATTESTATION DE TRAVAIL';
//     Megrine_leCaption_Control1120009Lbl: Label 'Megrine le';
//     "Nous_soussignés__la_direction_du_personnel_de_la_Société_de_Routes_et_de_Bâtiments___SOROUBAT": Label 'Nous soussignés, la Société de Routes et de Bâtiments " SOROUBAT " sise face à la gare de Mégrine Riadh, attestons par la présente que :';
//     MrCaptionLbl: Label 'Mr';
//     MatriculeCaptionLbl: Label 'Matricule';
//     C_I_NCaptionLbl: Label 'C.I.N';
//     EmptyStringCaptionLbl: Label ':';
//     EmptyStringCaption_Control1000000006Lbl: Label ':';
//     EmptyStringCaption_Control1000000007Lbl: Label ':';
//     "Cette_attestation_est_délivrée_à_l_intéressé__sur_sa_demande__pour_servir_et_valoir_ce_que_de_droit_Caption": Label 'Cette attestation est délivrée à l''intéressé, sur sa demande, pour servir et valoir ce que de droit.';
//     "La_Direction_GénéraleCaption_Control1000000055Lbl": Label 'La Direction Générale';
//}

