report 50117 "Remise Espece"
{
    DefaultLayout = RDLC;

    RDLCLayout = './Layouts/RemiseEspece.rdlc';

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
                    column(COMPANYNAME; COMPANYNAME)
                    {
                    }
                    column(TODAY; TODAY)
                    {
                    }
                    column(Payment_Line_Amount; Amount)
                    {
                    }
                    column("Payment_Line_Libellé"; Libellé)
                    {
                    }
                    column(Payment_Line_Commentaires; Commentaires)
                    {
                    }
                    column(TextGMnt; TextGMnt)
                    {
                    }
                    column(Payment_Line__Currency_Code_; "Currency Code")
                    {
                    }
                    column(BankAccount_Name; BankAccount.Name)
                    {
                    }
                    column(InfoSoc__Entete_de_page_; InfoSoc."Picture")
                    {
                    }
                    column(PIECE_DE_REGLEMENT_EN_ESPECESCaption; PIECE_DE_REGLEMENT_EN_ESPECESCaptionLbl)
                    {
                    }
                    column(Ouaga_le__Caption; Ouaga_le__CaptionLbl)
                    {
                    }
                    column("BénèficaireCaption"; BénèficaireCaptionLbl)
                    {
                    }
                    column(MontantCaption; MontantCaptionLbl)
                    {
                    }
                    column("Libellé__Caption"; Libellé__CaptionLbl)
                    {
                    }
                    column("Vérifier_et_approuvé_le_directeur_financierCaption"; Vérifier_et_approuvé_le_directeur_financierCaptionLbl)
                    {
                    }
                    column("Direction_génèraleCaption"; Direction_génèraleCaptionLbl)
                    {
                    }
                    column("BénèficiaireCaption"; BénèficiaireCaptionLbl)
                    {
                    }
                    column("Nom_et_prénomCaption"; Nom_et_prénomCaptionLbl)
                    {
                    }
                    column(CACHETCaption; CACHETCaptionLbl)
                    {
                    }
                    column(CIN_N_Caption; CIN_N_CaptionLbl)
                    {
                    }
                    column(DUCaption; DUCaptionLbl)
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
                            CodeU."Montant en texte sans millimes"(TextGMnt, Amount)
                        ELSE
                            CodeU."Montant en texteDevise"(TextGMnt, Amount, "Currency Code");
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
        Nbre: Integer;
        PayLine: Record 10866;
        Nbre1: Integer;
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
        afficherdetail: Integer;
        PayementLine: Record 10866;
        datdoc: Text[30];
        MatriculeFiscal: Code[20];
        PIECE_DE_REGLEMENT_EN_ESPECESCaptionLbl: Label 'PIECE DE REGLEMENT EN ESPECES';
        Ouaga_le__CaptionLbl: Label 'Ouaga le :';
        "BénèficaireCaptionLbl": Label 'Bénèficaire';
        MontantCaptionLbl: Label 'Montant';
        "Libellé__CaptionLbl": Label 'Libellé :';
        "Vérifier_et_approuvé_le_directeur_financierCaptionLbl": Label 'Vérifier et approuvé le directeur financier';
        "Direction_génèraleCaptionLbl": Label 'Direction génèrale';
        "BénèficiaireCaptionLbl": Label 'Bénèficiaire';
        "Nom_et_prénomCaptionLbl": Label 'Nom et prénom';
        CACHETCaptionLbl: Label 'CACHET';
        CIN_N_CaptionLbl: Label 'CIN N°';
        DUCaptionLbl: Label 'DU';


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

