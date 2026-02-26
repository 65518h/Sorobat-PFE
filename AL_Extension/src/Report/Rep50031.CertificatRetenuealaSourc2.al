report 50031 "Certificat Retenue a la Sourc2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/CertificatRetenuealaSourc2.rdlc';

    dataset
    {
        dataitem("Payment Header"; 10865)
        {
            CalcFields = "Amount (LCY)";
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.";
            column(Payment_Header_No_; "No.")
            {
            }
            dataitem(PaymentH; 10865)
            {
                CalcFields = "Amount (LCY)";
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.") ORDER(Ascending);
                column(PaymentH_No_; "No.")
                {
                }
                dataitem("Payment Line"; 10866)
                {
                    DataItemLink = "No." = FIELD("No.");
                    column(InfoSoc_Name; InfoSoc.Name)
                    {
                    }
                    column(TODAY; TODAY)
                    {
                    }
                    column(InfoSoc_Activite; InfoSoc.Activite)
                    {
                    }
                    column(InfoSoc_Address________InfoSoc__Address_2____InfoSoc__Post_Code________InfoSoc_City; InfoSoc.Address + ' ' + InfoSoc."Address 2" + InfoSoc."Post Code" + ' ' + InfoSoc.City)
                    {
                    }
                    column(InfoSoc__VAT_Registration_No__; InfoSoc."VAT Registration No.")
                    {
                    }
                    column(TextGMnt; TextGMnt)
                    {
                    }
                    column(Vend_Name; Vend.Name)
                    {
                    }
                    column("Vend_Activité"; Vend.Activité)
                    {
                    }
                    column(Vend_Address; Vend.Address)
                    {
                    }
                    column(Vend__VAT_Registration_No__; Vend."VAT Registration No.")
                    {
                    }
                    column("Vend_Activité_Control1000000037"; Vend.Activité)
                    {
                    }
                    column(Payment_Line__Montant_Retenue_; "Montant Retenue")
                    {
                    }
                    column(DIRECTION_DES_GENERALE_DES_IMPOTSCaption; DIRECTION_DES_GENERALE_DES_IMPOTSCaptionLbl)
                    {
                    }
                    column(A_OUAGA_LE_Caption; A_OUAGA_LE_CaptionLbl)
                    {
                    }
                    column(A________________________________________LE_________________________________________Caption; A________________________________________LE_________________________________________CaptionLbl)
                    {
                    }
                    column(RECETTE_DES_IMPOTSCaption; RECETTE_DES_IMPOTSCaptionLbl)
                    {
                    }
                    column(CACHETS_DU_SERVICECaption; CACHETS_DU_SERVICECaptionLbl)
                    {
                    }
                    column(ATTESTATION_INDIVIDUELLE_DE_RETENUE_A_LA_SOURCE_SUR_LES_Caption; ATTESTATION_INDIVIDUELLE_DE_RETENUE_A_LA_SOURCE_SUR_LES_CaptionLbl)
                    {
                    }
                    column(SOMMES_VERSEES_AUX_PRESTATAIRES_ETABLISCaption; SOMMES_VERSEES_AUX_PRESTATAIRES_ETABLISCaptionLbl)
                    {
                    }
                    column(AU_BURKINA_FASOCaption; AU_BURKINA_FASOCaptionLbl)
                    {
                    }
                    column(Article_84_quinquets_du_code_des_impots_Caption; Article_84_quinquets_du_code_des_impots_CaptionLbl)
                    {
                    }
                    column(CADRE_RESEVE_AU_REDEVABLECaption; CADRE_RESEVE_AU_REDEVABLECaptionLbl)
                    {
                    }
                    column("Le_soussignéCaption"; Le_soussignéCaptionLbl)
                    {
                    }
                    column("Nom_et_prénom_ou_raison_socialeCaption"; Nom_et_prénom_ou_raison_socialeCaptionLbl)
                    {
                    }
                    column("Activité_ou_ProfessionCaption"; Activité_ou_ProfessionCaptionLbl)
                    {
                    }
                    column("Adresse_Géographique_et_postaleCaption"; Adresse_Géographique_et_postaleCaptionLbl)
                    {
                    }
                    column(N_IFUCaption; N_IFUCaptionLbl)
                    {
                    }
                    column("Certifie_avoir_retenu_à_la_sourceCaption"; Certifie_avoir_retenu_à_la_sourceCaptionLbl)
                    {
                    }
                    column("Sur_les_sommes_versées_à__Caption"; Sur_les_sommes_versées_à__CaptionLbl)
                    {
                    }
                    column("Nom_et_prénom_ou_raison_socialeCaption_Control1000000016"; Nom_et_prénom_ou_raison_socialeCaption_Control1000000016Lbl)
                    {
                    }
                    column("Activité_ou_ProfessionCaption_Control1000000017"; Activité_ou_ProfessionCaption_Control1000000017Lbl)
                    {
                    }
                    column("Adresse_Géographique_et_postaleCaption_Control1000000018"; Adresse_Géographique_et_postaleCaption_Control1000000018Lbl)
                    {
                    }
                    column(N_IFUCaption_Control1000000020; N_IFUCaption_Control1000000020Lbl)
                    {
                    }
                    column(Nature_des_prestations_fourniesCaption; Nature_des_prestations_fourniesCaptionLbl)
                    {
                    }
                    column(Cachet__signature_et_nom_du_signataireCaption; Cachet__signature_et_nom_du_signataireCaptionLbl)
                    {
                    }
                    column(CADRE_RESEVE_A_L_ADMINISTRATIONCaption; CADRE_RESEVE_A_L_ADMINISTRATIONCaptionLbl)
                    {
                    }
                    column(DataItem1000000038; Le_receveur_des_impôts_soussigné_certifie_avoir_pris_en_recette_le___Lbl)
                    {
                    }
                    column(DataItem1000000039; Sous_les_références_comptables_suivantes___Lbl)
                    {
                    }
                    column(Quittance_N_Caption; Quittance_N___Lbl)
                    {
                    }
                    column(La_somme_en_lettre_et_en_chiffre_Caption; La_somme__en_lettre_et_en_chiffre__Lbl)
                    {
                    }
                    column(EmptyStringCaption; EmptyStringCaptionLbl)
                    {
                    }
                    column(EmptyStringCaption_Control1000000046; EmptyStringCaption_Control1000000046Lbl)
                    {
                    }
                    column(DataItem1000000050; Représentant_les_retenues_à_la_source_opérées_par_le_redevable_ci_déssus_désigné_au_cours_du_mois_de___Lbl)
                    {
                    }
                    column(Cachet__signature_et_nom_du_signataire_Caption; Cachet__signature_et_nom_du_signataire_CaptionLbl)
                    {
                    }
                    column(Payment_Line_No_; "No.")
                    {
                    }
                    column(Payment_Line_Line_No_; "Line No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Type = 'Chèque N°' THEN
                            NumDoc := FORMAT("Payment Line"."N° chèque")
                        ELSE
                            NumDoc := FORMAT("Payment Line"."External Document No.");
                        Facture := '';
                        //>>DSFT 13 07 2010
                        IF "Payment Line"."Applies-to ID" <> '' THEN BEGIN

                            IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                                RecEcritureFornisseur.SETRANGE("Applies-to ID", "Applies-to ID");

                                IF RecEcritureFornisseur.FIND('-') THEN BEGIN
                                    REPEAT
                                        Facture += RecEcritureFornisseur."External Document No." + ' , ';
                                    UNTIL RecEcritureFornisseur.NEXT = 0;
                                END;
                            END;

                            IF "Account Type" = "Account Type"::Customer THEN BEGIN

                                RecEcritureClient.SETRANGE("Applies-to ID", "Applies-to ID");
                                IF RecEcritureClient.FIND('-') THEN BEGIN
                                    REPEAT
                                        Facture += RecEcritureClient."External Document No.";
                                    UNTIL RecEcritureClient.NEXT = 0;
                                END;
                            END;
                        END;


                        //<<DSFT 13 07 2010

                        IF BankAccount.GET("Compte Entete") THEN;
                        IF "Currency Code" = '' THEN
                            CodeU."Montant en texte sans millimes"(TextGMnt, ABS("Montant Retenue"))
                        ELSE
                            CodeU."Montant en texteDevise"(TextGMnt, ABS("Montant Retenue"), "Currency Code");

                        IF Vend.GET("Account No.") THEN;
                        InfoSoc.GET;
                        InfoSoc.CALCFIELDS("Picture");

                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    PayClass := '';
                    PayClass := "Payment Class";
                    PayLine.RESET;
                    PayLine.SETFILTER(PayLine."No.", "Payment Header"."No.");
                    // PayLine.SETRANGE(PayLine."Account Type",PayLine."Account Type"::Vendor);
                    IF PayLine.FINDFIRST THEN BEGIN
                        Nbre1 := PayLine.COUNT;
                        IF PayLine."Type de compte" = 2 THEN BEGIN
                            IF Vend.GET(PayLine."Account No.") THEN BEGIN
                                NVend := Vend."No.";
                                NomVend := Vend.Name;
                                MatriculeFiscal := Vend."VAT Registration No.";
                                FormatAdresse.Vendor(FnsAdr, Vend);
                            END;
                        END ELSE BEGIN
                            NVend := '';//PayLine."Account No.";
                            NomVend := PayLine.Libellé;
                        END;

                        IF Nbre = 1 THEN BEGIN

                        END;
                        /*
                       IF PayLine."Applies-to ID" <> '' THEN
                       BEGIN
                         IF PayLine."Account Type" = "Account Type" :: Vendor THEN
                         BEGIN
                       //EcrFrs.RESET;
                       //EcrFrs.SETRANGE("Vendor No.",PayLine."Account No.");
                       EcrFrs.SETRANGE("Applies-to ID",PayLine."Applies-to ID");
                       IF EcrFrs.FINDFIRST THEN
                        REPEAT
                          DocLettrage +=RecEcritureFornisseur."External Document No." + ' , ';
                        UNTIL EcrFrs.NEXT=0;
                       END;END;
                       */
                    END;
                    //MESSAGE('%1', Nbre);

                end;

                trigger OnPreDataItem()
                begin
                    InfoSoc.GET;
                    //InfoSoc.TESTFIELD("Default Bank Account No.");
                    //CpteBqe.GET(InfoSoc."Default Bank Account No.");
                    FormatAdresse.Company(AdrSoc, InfoSoc);
                    CurrReport.CREATETOTALS(Amount);
                    //FormatAdresse.BankAcc(Bnad,BqeSociete);
                    //IF BqeSociete.GET(NumcompteB) THEN;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //>>IBK DSFT 13 12 2010
                RecBanque.SETRANGE("No.", "Account No.");
                IF RecBanque.FINDFIRST THEN
                    REPEAT
                        TxtDesignationBanque := RecBanque.Name;
                    UNTIL RecBanque.NEXT = 0;
                //<<IBK DSFT 13 12 2010

                //IMS
                VERIFTYPE();
                //IMS
                PayClass := '';
                PayClass := "Payment Class";
                PayLine.RESET;
                PayLine.SETFILTER(PayLine."No.", "Payment Header"."No.");
                //PayLine.SETRANGE(PayLine."Account Type",PayLine."Account Type"::Vendor);
                IF PayLine.FINDFIRST THEN BEGIN
                    Nbre := PayLine.COUNT;
                    //IMS
                    IF ("Payment Header"."Payment Class" = 'DECAISS EFFET') OR ("Payment Header"."Payment Class" = 'ENCAISS EFFET') THEN
                        DatEch := 'Date Echéance                           ' + FORMAT(PayLine."Due Date");
                    IF PayLine."Type de compte" = 2 THEN BEGIN
                        IF Vend.GET(PayLine."Account No.") THEN BEGIN
                            NVend := Vend."No.";
                            NomVend := Vend.Name;
                            FormatAdresse.Vendor(FnsAdr, Vend);
                        END;
                    END ELSE BEGIN
                        NVend := PayLine."Account No.";
                        NomVend := PayLine.Libellé;
                    END;

                    IF NomVend = '' THEN
                        NomVend := PayLine."Drawee Reference";

                    //IMS
                    //IBK DSFT 23 05 2011
                    DocLettrage := '';
                    //>>DSFT 13 07 2010
                    IF PayLine."Applies-to ID" <> '' THEN BEGIN

                        IF PayLine."Account Type" = "Account Type"::Vendor THEN BEGIN
                            RecEcritureFornisseur.SETRANGE("Applies-to ID", PayLine."Applies-to ID");

                            IF RecEcritureFornisseur.FIND('-') THEN
                                REPEAT
                                    DocLettrage += RecEcritureFornisseur."External Document No." + ' , ';
                                UNTIL RecEcritureFornisseur.NEXT = 0;
                        END;
                    END;
                    //IBK DSFT 23 05 2011
                END;
            end;

            trigger OnPreDataItem()
            begin
                InfoSoc.GET;
                InfoSoc.CALCFIELDS("Picture");
                //InfoSoc.TESTFIELD("Default Bank Account No.");
                //CpteBqe.GET(InfoSoc."Default Bank Account No.");
                FormatAdresse.Company(AdrSoc, InfoSoc);
                CurrReport.CREATETOTALS(Amount);
                //FormatAdresse.BankAcc(Bnad,BqeSociete);
                //IF BqeSociete.GET(NumcompteB) THEN;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("Date d'impression"; DateSel)
                    {
                        ApplicationArea = all;
                        Caption = 'Date d''impression';

                    }
                    field("Afficher Total"; afficherdetail)
                    {
                        ApplicationArea = all;
                        Caption = 'Afficher Total';

                    }
                    field("Afficher Detail"; afficherdetail)
                    {
                        ApplicationArea = all;
                        Caption = 'Afficher Detail';

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

    trigger OnInitReport()
    begin
        afficherdetail := 2;
    end;

    trigger OnPreReport()
    begin
        //IF NumcompteB ='' THEN
        //ERROR('Vous devez renseigner un compte bancaire');
    end;

    var
        InfoSoc: Record 79;
        CpteBqe: Record 270;
        EnTeteFactAchat: Record 122;
        FormatAdresse: Codeunit 365;
        AdrSoc: array[8] of Text[80];
        FnsAdr: array[8] of Text[80];
        DateSel: Date;
        Conv: Codeunit 50001;
        Bnad: array[8] of Text[80];
        BqeSociete: Record 270;
        BankAccount: Record 270;
        EcrtFrs: Record 25;
        Numfact: Code[20];
        NumcompteB: Code[20];
        Modereg: Record 289;
        Dep: Code[10];
        PayHeader: Record 10865;
        Vend: Record 23;
        NVend: Code[20];
        NomVend: Text[80];
        PayClass: Text[80];
        Nbre: Decimal;
        PayLine: Record 10866;
        Nbre1: Decimal;
        DocLettrage: Text[500];
        EcrFrs: Record 25;
        CodeU: Codeunit 50005;
        TextGMnt: Text[250];
        DatEch: Text[50];
        Type: Text[30];
        NumDoc: Text[30];
        RecEcritureFornisseur: Record 25;
        Facture: Text[500];
        RecEcritureClient: Record 21;
        RecBanque: Record 270;
        TxtDesignationBanque: Text[50];
        afficherdetail: Decimal;
        PayementLine: Record 10866;
        datdoc: Text[30];
        MatriculeFiscal: Code[20];
        ActiviteVend: Text[50];
        DIRECTION_DES_GENERALE_DES_IMPOTSCaptionLbl: Label 'DIRECTION DES GENERALE DES IMPOTS';
        A_OUAGA_LE_CaptionLbl: Label 'A OUAGA LE ';
        A________________________________________LE_________________________________________CaptionLbl: Label 'A .................................................... LE ....................................................';
        RECETTE_DES_IMPOTSCaptionLbl: Label 'RECETTE DES IMPOTS';
        CACHETS_DU_SERVICECaptionLbl: Label 'CACHETS DU SERVICE';
        ATTESTATION_INDIVIDUELLE_DE_RETENUE_A_LA_SOURCE_SUR_LES_CaptionLbl: Label 'ATTESTATION INDIVIDUELLE DE RETENUE A LA SOURCE SUR LES ';
        SOMMES_VERSEES_AUX_PRESTATAIRES_ETABLISCaptionLbl: Label 'SOMMES VERSEES AUX PRESTATAIRES ETABLIS';
        AU_BURKINA_FASOCaptionLbl: Label 'AU BURKINA FASO';
        Article_84_quinquets_du_code_des_impots_CaptionLbl: Label '(Article 84 quinquets du code des impots)';
        CADRE_RESEVE_AU_REDEVABLECaptionLbl: Label 'CADRE RESEVE AU REDEVABLE';
        "Le_soussignéCaptionLbl": Label 'Le soussigné';
        "Nom_et_prénom_ou_raison_socialeCaptionLbl": Label 'Nom et prénom ou raison sociale';
        "Activité_ou_ProfessionCaptionLbl": Label 'Activité ou Profession';
        "Adresse_Géographique_et_postaleCaptionLbl": Label 'Adresse Géographique et postale';
        N_IFUCaptionLbl: Label 'N°IFU';
        "Certifie_avoir_retenu_à_la_sourceCaptionLbl": Label 'Certifie avoir retenu à la source';
        "Sur_les_sommes_versées_à__CaptionLbl": Label 'Sur les sommes versées à :';
        "Nom_et_prénom_ou_raison_socialeCaption_Control1000000016Lbl": Label 'Nom et prénom ou raison sociale';
        "Activité_ou_ProfessionCaption_Control1000000017Lbl": Label 'Activité ou Profession';
        "Adresse_Géographique_et_postaleCaption_Control1000000018Lbl": Label 'Adresse Géographique et postale';
        N_IFUCaption_Control1000000020Lbl: Label 'N°IFU';
        Nature_des_prestations_fourniesCaptionLbl: Label 'Nature des prestations fournies';
        Cachet__signature_et_nom_du_signataireCaptionLbl: Label 'Cachet, signature et nom du signataire';
        CADRE_RESEVE_A_L_ADMINISTRATIONCaptionLbl: Label 'CADRE RESEVE A L''ADMINISTRATION';
        "Le_receveur_des_impôts_soussigné_certifie_avoir_pris_en_recette_le___Lbl": Label 'Le receveur des impôts soussigné certifie avoir pris en recette le :..........................................................................................................................................';
        "Sous_les_références_comptables_suivantes___Lbl": Label 'Sous les références comptables suivantes :..........................................................................................................................................................................';
        Quittance_N___Lbl: Label 'Quittance N°  :.........................................................................................................................................................................................................................';
        La_somme__en_lettre_et_en_chiffre__Lbl: Label 'La somme (en lettre et en chiffre)  :...........................................................................................................................................................................................';
        EmptyStringCaptionLbl: Label '....................................................................................................................................................................................................................................................';
        EmptyStringCaption_Control1000000046Lbl: Label '....................................................................................................................................................................................................................................................';
        "Représentant_les_retenues_à_la_source_opérées_par_le_redevable_ci_déssus_désigné_au_cours_du_mois_de___Lbl": Label 'Représentant les retenues à la source opérées par le redevable ci-déssus désigné au cours du mois de .............................................................................';
        Cachet__signature_et_nom_du_signataire_CaptionLbl: Label '(Cachet, signature et nom du signataire)';


    procedure VERIFTYPE()
    begin
        //IMS
        IF "Payment Header"."Payment Class" IN ['DECAISS CHEQUE MULTIPLE', 'DECAISS CHEQUE', 'ENCAISS CHEQUE'] THEN
            Type := 'Chèque N°';
        IF "Payment Header"."Payment Class" IN ['DECAISS EFFET', 'ENCAISS EFFET'] THEN
            Type := 'Traite N°';
        IF "Payment Header"."Payment Class" IN ['DECAISS ESPECE', 'ENCAISS ESPECE'] THEN
            Type := 'Espèce N°';
        IF "Payment Header"."Payment Class" IN ['DECAISS VIREMENT', 'ENCAISS VIREMENT'] THEN
            Type := 'Virement N°';
        //IMS
    end;
}

