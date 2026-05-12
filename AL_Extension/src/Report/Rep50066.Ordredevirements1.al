// report 50066 "Ordre de virements1"
// {

//     dataset
//     {
//         dataitem(DataItem6483; Table10865)
//         {
//             CalcFields = Amount (LCY);
//             DataItemTableView = SORTING (No.)
//                                 ORDER(Ascending);
//             RequestFilterFields = "No.";
//             column(Payment_Header__Posting_Date_; "Posting Date")
//             {
//             }
//             column(N________No__; 'N°:   ' + "No.")
//             {
//             }
//             column(TxtDesignationBanque; TxtDesignationBanque)
//             {
//             }
//             column(TxtDesignationBanque_Control1000000008; TxtDesignationBanque)
//             {
//             }
//             column(RecBanque_Agence; RecBanque.Agence)
//             {
//             }
//             column(RecBanque_RIB; RecBanque.RIB)
//             {
//             }
//             column(InfoSoc__Entete_de_page_; InfoSoc."Entete de page")
//             {
//             }
//             column(TextGMnt; TextGMnt)
//             {
//             }
//             column(Payment_Line__Commentaires; "Payment Line".Commentaires)
//             {
//             }
//             column(VEULLEZ_AGREER__MONSIEUR__NOS_SALUTATIONS_LES_MEILLEURS__; ' VEULLEZ AGREER, MONSIEUR, NOS SALUTATIONS LES MEILLEURS ')
//             {
//             }
//             column(Payment_Header__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
//             {
//             }
//             column(ORDRE_DE_VIREMENTS_Caption; ORDRE_DE_VIREMENTS_CaptionLbl)
//             {
//             }
//             column(A_LA_Caption; A_LA_CaptionLbl)
//             {
//             }
//             column(AGENCE__Caption; AGENCE__CaptionLbl)
//             {
//             }
//             column(PAR_LE_BILLET_DE_NOTRE_COMPTE_LE__Caption; PAR_LE_BILLET_DE_NOTRE_COMPTE_LE__CaptionLbl)
//             {
//             }
//             column(VEUILLEZ_EFFECTUER_LE_S__VIREMENT_S__SUIVANT_S___Caption; VEUILLEZ_EFFECTUER_LE_S__VIREMENT_S__SUIVANT_S___CaptionLbl)
//             {
//             }
//             column(BENEFICIAIRECaption; BENEFICIAIRECaptionLbl)
//             {
//             }
//             column(RIBCaption; RIBCaptionLbl)
//             {
//             }
//             column(MONTANTCaption; MONTANTCaptionLbl)
//             {
//             }
//             column(ARRETE_LE_PRESENT_VIREMENT_A_LA_SOMME_DE__Caption; ARRETE_LE_PRESENT_VIREMENT_A_LA_SOMME_DE__CaptionLbl)
//             {
//             }
//             column(OBJET_Caption; OBJET_CaptionLbl)
//             {
//             }
//             column(Service_FinacierCaption; Service_FinacierCaptionLbl)
//             {
//             }
//             column(LE_PRESIDENT_DIRECTEUR_GENERALCaption; LE_PRESIDENT_DIRECTEUR_GENERALCaptionLbl)
//             {
//             }
//             column(Payment_Header_No_; "No.")
//             {
//             }
//             dataitem(DataItem3474; Table10866)
//             {
//                 DataItemLink = No.=FIELD(No.);
//                 column(NomVend; NomVend)
//                 {
//                 }
//                 column(ABS_Amount_; ABS(Amount))
//                 {
//                     DecimalPlaces = 0 : 0;
//                 }
//                 column(VendorBankAccount_RIB_________VendorBankAccount_Name; VendorBankAccount.RIB + '  ' + VendorBankAccount.Name)
//                 {
//                 }
//                 column(Payment_Line_No_; "No.")
//                 {
//                 }
//                 column(Payment_Line_Line_No_; "Line No.")
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     IF "Account Type" = "Account Type"::Customer THEN BEGIN
//                         RecEcritureClient.SETRANGE("Applies-to ID", "Applies-to ID");
//                         IF RecEcritureClient.FIND('-') THEN
//                             REPEAT
//                             // Facture+=RecEcritureClient."External Document No.";
//                             UNTIL RecEcritureClient.NEXT = 0;
//                     END;
//                     IF PayLine."Account Type" = "Account Type"::Vendor THEN BEGIN
//                         RecEcritureFornisseur.SETRANGE("Applies-to ID", PayLine."Applies-to ID");
//                         IF RecEcritureFornisseur.FIND('-') THEN
//                             REPEAT
//                             // DocLettrage+= RecEcritureFornisseur."External Document No." + ' , ';
//                             UNTIL RecEcritureFornisseur.NEXT = 0;
//                     END;
//                     IF VendorBankAccount.GET("Account No.", "Bank Account Code") THEN;
//                     IF RecBanque.GET("Header Account No.") THEN TxtDesignationBanque := RecBanque."Bank Branch No.";
//                     VERIFTYPE();

//                     IF Vend.GET("Account No.") THEN BEGIN
//                         NVend := Vend."No.";
//                         NomVend := Vend.Name;
//                         FormatAdresse.Vendor(FnsAdr, Vend);
//                     END;

//                     DocLettrage := '';
//                     IF "Applies-to ID" <> '' THEN BEGIN

//                         IF PayLine."Account Type" = "Account Type"::Vendor THEN BEGIN
//                             RecEcritureFornisseur.SETRANGE("Applies-to ID", PayLine."Applies-to ID");

//                             IF RecEcritureFornisseur.FIND('-') THEN
//                                 REPEAT
//                                     DocLettrage += RecEcritureFornisseur."External Document No." + ' , ';
//                                 UNTIL RecEcritureFornisseur.NEXT = 0;
//                         END;
//                     END;
//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     InfoSoc.GET;
//                     FormatAdresse.Company(AdrSoc, InfoSoc);
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 //>>IBK DSFT 13 12 2010
//                 IF RecBanque.GET("Account No.") THEN TxtDesignationBanque := RecBanque.Name;

//                 //<<IBK DSFT 13 12 2010

//                 //IMS
//                 VERIFTYPE();
//                 //IMS
//                 PayClass := '';
//                 PayClass := "Payment Class";
//                 PayLine.RESET;
//                 PayLine.SETFILTER(PayLine."No.", "Payment Header"."No.");
//                 //PayLine.SETRANGE(PayLine."Account Type",PayLine."Account Type"::Vendor);
//                 IF PayLine.FINDFIRST THEN BEGIN
//                     Nbre := PayLine.COUNT;
//                     //IMS
//                     IF ("Payment Header"."Payment Class" = 'DECAISS EFFET') OR ("Payment Header"."Payment Class" = 'ENCAISS EFFET') THEN
//                         DatEch := 'Date Echéance                           ' + FORMAT(PayLine."Due Date");
//                     IF PayLine."Type de compte" = 2 THEN BEGIN
//                         IF Vend.GET(PayLine."Account No.") THEN BEGIN
//                             NVend := Vend."No.";
//                             NomVend := Vend.Name;
//                             FormatAdresse.Vendor(FnsAdr, Vend);
//                         END;
//                     END ELSE BEGIN
//                         NVend := PayLine."Account No.";
//                         NomVend := PayLine.Libellé;
//                     END;

//                     IF NomVend = '' THEN
//                         NomVend := PayLine."Drawee Reference";

//                     //IMS
//                     //IBK DSFT 23 05 2011
//                     DocLettrage := '';
//                     //>>DSFT 13 07 2010
//                     IF PayLine."Applies-to ID" <> '' THEN BEGIN

//                         IF PayLine."Account Type" = "Account Type"::Vendor THEN BEGIN
//                             RecEcritureFornisseur.SETRANGE("Applies-to ID", PayLine."Applies-to ID");

//                             IF RecEcritureFornisseur.FIND('-') THEN
//                                 REPEAT
//                                     DocLettrage += RecEcritureFornisseur."External Document No." + ' , ';
//                                 UNTIL RecEcritureFornisseur.NEXT = 0;
//                         END;
//                     END;
//                     //IBK DSFT 23 05 2011
//                 END;
//             end;

//             trigger OnPreDataItem()
//             begin

//                 //InfoSoc.TESTFIELD("Default Bank Account No.");
//                 //CpteBqe.GET(InfoSoc."Default Bank Account No.");
//                 FormatAdresse.Company(AdrSoc, InfoSoc);
//                 CurrReport.CREATETOTALS(Amount);
//                 //FormatAdresse.BankAcc(Bnad,BqeSociete);
//                 //IF BqeSociete.GET(NumcompteB) THEN;
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnInitReport()
//     begin
//         afficherdetail := 2;
//     end;

//     trigger OnPreReport()
//     begin
//         //IF NumcompteB ='' THEN
//         //ERROR('Vous devez renseigner un compte bancaire');
//     end;

//     var
//         VendorBankAccount: Record "288";
//         InfoSoc: Record "79";
//         CpteBqe: Record "270";
//         EnTeteFactAchat: Record "122";
//         FormatAdresse: Codeunit "365";
//         AdrSoc: array[8] of Text[80];
//         FnsAdr: array[8] of Text[80];
//         DateSel: Date;
//         Conv: Codeunit "50001";
//         Bnad: array[8] of Text[80];
//         BqeSociete: Record "270";
//         EcrtFrs: Record "25";
//         Numfact: Code[20];
//         NumcompteB: Code[20];
//         Modereg: Record "289";
//         Dep: Code[10];
//         PayHeader: Record "10865";
//         Vend: Record "23";
//         NVend: Code[20];
//         NomVend: Text[80];
//         PayClass: Text[80];
//         Nbre: Decimal;
//         PayLine: Record "10866";
//         Nbre1: Decimal;
//         DocLettrage: Text[500];
//         EcrFrs: Record "25";
//         CodeU: Codeunit "50005";
//         TextGMnt: Text[250];
//         DatEch: Text[50];
//         Type: Text[30];
//         NumDoc: Text[30];
//         RecEcritureFornisseur: Record "25";
//         Facture: Text[500];
//         RecEcritureClient: Record "21";
//         RecBanque: Record "270";
//         TxtDesignationBanque: Text[50];
//         afficherdetail: Decimal;
//         PayementLine: Record "10866";
//         datdoc: Text[30];
//         ORDRE_DE_VIREMENTS_CaptionLbl: Label 'ORDRE DE VIREMENTS ';
//         A_LA_CaptionLbl: Label 'A LA ';
//         AGENCE__CaptionLbl: Label 'AGENCE :';
//         PAR_LE_BILLET_DE_NOTRE_COMPTE_LE__CaptionLbl: Label 'PAR LE BILLET DE NOTRE COMPTE LE :';
//         VEUILLEZ_EFFECTUER_LE_S__VIREMENT_S__SUIVANT_S___CaptionLbl: Label 'VEUILLEZ EFFECTUER LE(S) VIREMENT(S) SUIVANT(S) :';
//         BENEFICIAIRECaptionLbl: Label 'BENEFICIAIRE';
//         RIBCaptionLbl: Label 'RIB';
//         MONTANTCaptionLbl: Label 'MONTANT';
//         ARRETE_LE_PRESENT_VIREMENT_A_LA_SOMME_DE__CaptionLbl: Label 'ARRETE LE PRESENT VIREMENT A LA SOMME DE :';
//         OBJET_CaptionLbl: Label 'OBJET ';
//         Service_FinacierCaptionLbl: Label 'Service Finacier';
//         LE_PRESIDENT_DIRECTEUR_GENERALCaptionLbl: Label 'LE PRESIDENT DIRECTEUR GENERAL';

//     [Scope('Internal')]
//     procedure VERIFTYPE()
//     begin
//         //IMS
//         IF "Payment Header"."Payment Class" IN ['DECAISS CHEQUE MULTIPLE', 'DECAISS CHEQUE', 'ENCAISS CHEQUE'] THEN
//             Type := 'Chèque N°';
//         IF "Payment Header"."Payment Class" IN ['DECAISS EFFET', 'ENCAISS EFFET'] THEN
//             Type := 'Traite N°';
//         IF "Payment Header"."Payment Class" IN ['DECAISS ESPECE', 'ENCAISS ESPECE'] THEN
//             Type := 'Espèce N°';
//         IF "Payment Header"."Payment Class" IN ['DECAISS VIREMENT', 'ENCAISS VIREMENT'] THEN
//             Type := 'Virement N°';
//         //IMS
//     end;
// }

