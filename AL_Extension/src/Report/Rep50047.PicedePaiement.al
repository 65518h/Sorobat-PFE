report 50047 "Pièce de Paiement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PiècedePaiement.rdlc';

    dataset
    {
        dataitem("Payment Header"; 10865)
        {
            CalcFields = "Amount (LCY)", Amount;
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.";
            column(Payment_Header_No_; "No.")
            {
            }
            column(Payment_Posting_Date; "Posting Date")
            {
            }
            column(Payment_Amount; Amount)
            {
            }
            column(picture; InfoSoc2.Picture) { }



            dataitem(PaymentH; 10865)
            {
                CalcFields = "Amount (LCY)", Amount;
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.")
                                    ORDER(Ascending);
                column(PaymentH_No_; "No.")
                {
                }
                dataitem("Payment Line"; 10866)
                {
                    DataItemLink = "No." = FIELD("No.");
                    DataItemTableView = SORTING("No.", "Line No.");
                    column(STRSUBSTNO___1_Le___2__InfoSoc_City_WORKDATE_; STRSUBSTNO('%1 Le  %2', InfoSoc.City, WORKDATE))
                    {
                    }
                    column(COMPANYNAME; CompanyRec."Display Name")
                    {
                    }
                    column(Payment_Class; "Payment Class")
                    {
                    }
                    column(Payment_Currency; "Currency Code")
                    {
                    }
                    column(Payment_AmountLCY; "Amount (LCY)")
                    {
                    }
                    column(Payment_ExternalDocument; "External Document No.")
                    {
                    }
                    column(InfoSocEntetedepage; InfoSoc."Entete de page")
                    {
                    }
                    column(Commentaires; Commentaires)
                    {
                    }
                    column(Payment_Line__Payment_Line__Amount; "Payment Line".Amount)
                    {
                        AutoFormatType = 1;
                        DecimalPlaces = 0 : 3;
                    }
                    column(BankAccountRIB; BankAccount.RIB)
                    {
                    }
                    column(BankAccountNomBanqueEtat; BankAccount."Bank Branch No.")
                    {
                    }
                    column(MatriculeFiscal; MatriculeFiscal)
                    {
                    }
                    column(NomVend; NomVend)
                    {
                    }

                    column("Payment_Line_Libellé"; Libellé)
                    {
                    }
                    column(EmptyString; '----------------------------------------------------------------------------------------------------------------------------------------------------------')
                    {
                    }
                    column(DocLettrage; DocLettrage)
                    {
                    }
                    column(TextGMnt; TextGMnt)
                    {
                    }
                    column(N________No__; 'N°:   ' + "No.")
                    {
                    }
                    column(NumDoc; NumDoc)
                    {
                    }
                    column(STRSUBSTNO___1___Due_Date__; STRSUBSTNO('%1', "Due Date"))
                    {
                    }
                    column(Payment_Line_Banque; Banque)
                    {
                    }
                    column(ModePaiement___N____; ModePaiement + ' N° :')
                    {
                        AutoFormatType = 1;
                    }
                    column(InfoSoc_Address; InfoSoc.Address)
                    {
                    }
                    column(TextDocument; TextDocument + '. . . . . . . . . . . . . . . . . . . . . . .  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ')
                    {
                    }
                    column(Payment_Line_Commentaires; Commentaires + '. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ')
                    {
                    }
                    column(NomBanque2; NomBanque2)
                    {
                    }
                    column(TextGMnt_Control1000000062; TextGMnt)
                    {
                    }
                    column(STRSUBSTNO___1_Le___2__InfoSoc_City_WORKDATE__Control1000000091; STRSUBSTNO('%1 Le  %2', InfoSoc.City, WORKDATE))
                    {
                    }
                    column(Payment_Line__Payment_Line__Amount_Control1000000095; "Payment Line".Amount)
                    {
                        AutoFormatType = 1;
                        DecimalPlaces = 0 : 3;
                    }
                    column("Payment_Line_Libellé_Control1000000098"; Libellé)
                    {
                    }
                    column(DocLettrage_Control1000000013; DocLettrage)
                    {
                    }
                    column(N________No___Control1102752004; 'N°:   ' + "No.")
                    {
                    }
                    column(NumDoc_Control1102752007; NumDoc)
                    {
                    }
                    column(STRSUBSTNO___1___Due_Date___Control1102752011; STRSUBSTNO('%1', "Due Date"))
                    {
                    }
                    column(Payment_Line_Banque_Control1000000069; Banque)
                    {
                    }
                    column(ModePaiement___N_____Control1000000025; ModePaiement + ' N° :')
                    {
                        AutoFormatType = 1;
                    }
                    column(NomBanque2_Control1000000018; NomBanque2)
                    {
                    }
                    column(ORDRE_DE_PAIEMENTCaption; ORDRE_DE_PAIEMENTCaptionLbl)
                    {
                    }
                    column("La_Direction_Générale_autorise_le_paiement_designé_ci_après__Caption"; La_Direction_Générale_autorise_le_paiement_designé_ci_après__CaptionLbl)
                    {
                    }
                    column(TotalCaption; TotalCaptionLbl)
                    {
                    }
                    column(BENEFICIAIRECaption; BENEFICIAIRECaptionLbl)
                    {
                    }
                    column(PAIEMENT_EFFECTUE_PAR__Caption; PAIEMENT_EFFECTUE_PAR__CaptionLbl)
                    {
                    }
                    column(DIRECTEUR_FINANCIERCaption; DIRECTEUR_FINANCIERCaptionLbl)
                    {
                    }
                    column(SERVICE_FINANCIERCaption; SERVICE_FINANCIERCaptionLbl)
                    {
                    }
                    column(BENEFICIAIRECaption_Control1000000052; BENEFICIAIRECaption_Control1000000052Lbl)
                    {
                    }
                    column(LA_SOMME_DE_Caption; LA_SOMME_DE_CaptionLbl)
                    {
                    }
                    column(BANQUE__Caption; BANQUE__CaptionLbl)
                    {
                    }
                    column("Echéance__Caption"; Echéance__CaptionLbl)
                    {
                    }
                    column(Observations_Caption; Observations_CaptionLbl + ' . . . . . . . . ')
                    {
                    }
                    column(EmptyStringCaption; EmptyStringCaptionLbl)
                    {
                    }
                    column(CONTROLEUR_FINANCIERCaption; CONTROLEUR_FINANCIERCaptionLbl)
                    {
                    }
                    column(ORDRE_DE_PAIEMENTCaption_Control1000000093; ORDRE_DE_PAIEMENTCaption_Control1000000093Lbl)
                    {
                    }
                    column("La_Direction_Générale_autorise_le_paiement_designé_ci_après__Caption_Control1000000094"; La_Direction_Générale_autorise_le_paiement_designé_ci_après__Caption_Control1000000094Lbl)
                    {
                    }
                    column(TotalCaption_Control1000000096; TotalCaption_Control1000000096Lbl)
                    {
                    }
                    column(BENEFICIAIRECaption_Control1000000099; BENEFICIAIRECaption_Control1000000099Lbl)
                    {
                    }
                    column(PAIEMENT_EFFECTUE_PAR__Caption_Control1000000100; PAIEMENT_EFFECTUE_PAR__Caption_Control1000000100Lbl)
                    {
                    }
                    column(LA_SOMME_DE_Caption_Control1000000063; LA_SOMME_DE_Caption_Control1000000063Lbl)
                    {
                    }
                    column(BANQUE__Caption_Control1000000068; BANQUE__Caption_Control1000000068Lbl)
                    {
                    }
                    column("Echéance__Caption_Control1000000046"; Echéance__Caption_Control1000000046Lbl)
                    {
                    }
                    column(CONTROLEUR_FINANCIERCaption_Control1000000032; CONTROLEUR_FINANCIERCaption_Control1000000032Lbl)
                    {
                    }
                    column(DIRECTEUR_FINANCIERCaption_Control1000000034; DIRECTEUR_FINANCIERCaption_Control1000000034Lbl)
                    {
                    }
                    column(SERVICE_FINANCIERCaption_Control1000000036; SERVICE_FINANCIERCaption_Control1000000036Lbl)
                    {
                    }
                    column(BENEFICIAIRECaption_Control1000000038; BENEFICIAIRECaption_Control1000000038Lbl)
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

                        IF BankAccount.GET("Compte Entete") THEN;

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
                        //<<MH SORO 29-08-2023

                        TextGMnt := '';
                        "Payment Header".CALCFIELDS("Amount (LCY)");

                        IF "Currency Code" = '' THEN
                            CodeU."Montant en texte sans millimes"(TextGMnt, "Payment Header"."Amount (LCY)")
                        ELSE
                            CodeU."Montant en texteDevise"(TextGMnt, Amount, "Currency Code");
                        //MBY 06/01/2012
                    end;

                    trigger OnPreDataItem()
                    begin
                        InfoSoc.GET;
                        InfoSoc.CalcFields("Entete de page");
                        // IF GNumLigne <> 0 THEN SETRANGE("Line No.", GNumLigne);
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
                        IF PayLine."Applies-to ID" <> '' THEN BEGIN
                                                    IF PayLine."Account Type" = "Account Type"::Vendor THEN BEGIN
                                                        //EcrFrs.RESET;
                                                        //EcrFrs.SETRANGE("Vendor No.",PayLine."Account No.");
                                                        EcrFrs.SETRANGE("Applies-to ID", PayLine."Applies-to ID");
                                                        IF EcrFrs.FINDFIRST THEN
                                                            REPEAT
                                                                DocLettrage += RecEcritureFornisseur."External Document No." + ' , ';
                                                            UNTIL EcrFrs.NEXT = 0;
                                                    END;
                                                END;
                        */
                    END;
                    //MESSAGE('%1', Nbre);
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

                    //MESSAGE('%1', Nbre);

                    /*GL2025  IF afficherdetail = true THEN
                          IF BqeSociete.Banque = 3 THEN
                              BQ := 'BNA'
                          ELSE IF BqeSociete.Banque = 4 THEN
                              BQ := 'BH'
                          ELSE IF BqeSociete.Banque = 6 THEN
                              BQ := 'BTE'
                          ELSE IF BqeSociete.Banque = 13 THEN
                              BQ := 'ZITOUNA'
                          ELSE IF BqeSociete.Banque = 2 THEN
                              BQ := 'ATTIJARI'
                          ELSE IF BqeSociete.Banque = 10 THEN
                              BQ := 'STB'
                          ELSE IF BqeSociete.Banque = 9 THEN
                              BQ := 'QNB'
                          ELSE IF BqeSociete.Banque = 1 THEN
                              BQ := 'ATB'
                          ELSE IF BqeSociete.Banque = 7 THEN
                              BQ := 'BTL'
                          ELSE IF BqeSociete.Banque = 8 THEN
                              BQ := 'BTK'
                          ELSE IF BqeSociete.Banque = 5 THEN
                              BQ := 'BT'
                          ELSE IF BqeSociete.Banque = 11 THEN
                              BQ := 'UIB'
                          ELSE IF BqeSociete.Banque = 12 THEN
                              BQ := 'UBCI';*/


                    // IF NomVend ='' THEN
                    //   NomVend := "Drawee Reference";
                    // IF Benificiaire<>'' THEN NomVend:=Libellé + ' : ' + Commentaires;
                    // IF Salarier.Get(Benificiaire) THEN IF NomVend ='' THEN NomVend:=Salarier."Nom Et Prenom";

                    //MBY 06/01/2012
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
            var

            begin

                InfoSoc.GET;
                InfoSoc2.GET;
                InfoSoc2.CalcFields(Picture);

                InfoSoc.CalcFields("Entete de page");
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
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("Date Impression"; DateSel)
                    {
                        ApplicationArea = All;
                        Caption = 'Date Impression';
                        ToolTip = 'Date d''impression du document.';
                        ShowCaption = true;
                        Visible = true;
                        Editable = true;
                        Importance = Additional;
                    }
                    field("afficher total"; afficherTotal)
                    {
                        ApplicationArea = All;
                        Caption = 'Afficher le total';
                        ToolTip = 'Afficher le total des lignes de paiement.';
                        ShowCaption = true;
                        Visible = true;
                        Editable = true;
                        Importance = Additional;
                        trigger OnValidate()
                        begin
                            if afficherTotal = true then begin
                                afficherdetail := false;
                            end;
                        end;

                    }
                    field("Affichage Détail"; afficherdetail)
                    {
                        ApplicationArea = All;
                        Caption = 'Afficher Détail';
                        ToolTip = 'Afficher le détail des lignes de paiement.';
                        ShowCaption = true;
                        Visible = true;
                        Editable = true;
                        Importance = Additional;
                        trigger OnValidate()
                        begin
                            if afficherdetail = true then begin
                                afficherTotal := false;
                            end;
                        end;
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
        afficherdetail := true;
        afficherTotal := false;
    end;

    trigger OnPreReport()
    begin
        //IF NumcompteB ='' THEN
        //ERROR('Vous devez renseigner un compte bancaire');
        CompanyRec.Get(CompanyName);
    end;



    var
        InfoSoc2: Record "Company Information";
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
        Nbre: Integer;
        PayLine: Record 10866;
        Nbre1: Integer;
        DocLettrage: Text[1000];
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
        afficherdetail: Boolean;
        afficherTotal: Boolean;
        PayementLine: Record 10866;
        datdoc: Text[30];
        GNumLigne: Integer;
        BQ: Text[30];
        ModePaiement: Text[30];
        Salarier: Record 50020;
        TextDocument: Text[30];
        NomBanque2: Text[30];
        NomBanque3: Text[30];
        RecBanque2: Record 270;
        MatriculeFiscal: Code[20];
        ORDRE_DE_PAIEMENTCaptionLbl: Label 'ORDRE DE PAIEMENT';
        "La_Direction_Générale_autorise_le_paiement_designé_ci_après__CaptionLbl": Label 'La Direction Générale autorise le paiement designé ci-après :';
        TotalCaptionLbl: Label 'Total . . . . . . .';
        BENEFICIAIRECaptionLbl: Label 'BENEFICIAIRE';
        PAIEMENT_EFFECTUE_PAR__CaptionLbl: Label 'PAIEMENT EFFECTUE PAR :';
        DIRECTEUR_FINANCIERCaptionLbl: Label 'DIRECTEUR FINANCIER';
        SERVICE_FINANCIERCaptionLbl: Label 'SERVICE FINANCIER';
        BENEFICIAIRECaption_Control1000000052Lbl: Label 'BENEFICIAIRE';
        LA_SOMME_DE_CaptionLbl: Label 'LA SOMME DE ';
        BANQUE__CaptionLbl: Label 'BANQUE :';
        "Echéance__CaptionLbl": Label 'Echéance :';
        Observations_CaptionLbl: Label 'Observations';
        EmptyStringCaptionLbl: Label '.';
        CONTROLEUR_FINANCIERCaptionLbl: Label 'CONTROLEUR FINANCIER';
        ORDRE_DE_PAIEMENTCaption_Control1000000093Lbl: Label 'ORDRE DE PAIEMENT';
        "La_Direction_Générale_autorise_le_paiement_designé_ci_après__Caption_Control1000000094Lbl": Label 'La Direction Générale autorise le paiement designé ci-après :';
        TotalCaption_Control1000000096Lbl: Label 'Total';
        BENEFICIAIRECaption_Control1000000099Lbl: Label 'BENEFICIAIRE';
        PAIEMENT_EFFECTUE_PAR__Caption_Control1000000100Lbl: Label 'PAIEMENT EFFECTUE PAR :';
        LA_SOMME_DE_Caption_Control1000000063Lbl: Label 'LA SOMME DE ';
        BANQUE__Caption_Control1000000068Lbl: Label 'BANQUE :';
        "Echéance__Caption_Control1000000046Lbl": Label 'Echéance :';
        CONTROLEUR_FINANCIERCaption_Control1000000032Lbl: Label 'CONTROLEUR FINANCIER';
        DIRECTEUR_FINANCIERCaption_Control1000000034Lbl: Label 'DIRECTEUR FINANCIER';
        SERVICE_FINANCIERCaption_Control1000000036Lbl: Label 'SERVICE FINANCIER';
        BENEFICIAIRECaption_Control1000000038Lbl: Label 'BENEFICIAIRE';

        BankAccount: Record "Bank Account";
        CompanyRec: Record Company;

    // [Scope('Internal')]
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

    // [Scope('Internal')]
    procedure GetNumberLIne(ParaNumLigne: Integer)
    begin
        GNumLigne := ParaNumLigne;
    end;
}

