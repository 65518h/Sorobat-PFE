report 50311 "Pièce de Paiements copy"
{
    //GL2024 NEW REPORT dans nav"10869"
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/PiècedePaiementscopy.rdlc';

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
            dataitem("Payment Line"; 10866)
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.", "Line No.");
                column(Payment_Line__Posting_Date_; "Posting Date")
                {
                }
                column(N________No__; 'N°:   ' + "No.")
                {
                }
                column(COMPANYNAME; COMPANYNAME)
                {
                }
                column(NomVend; NomVend)
                {
                }
                column(Payment_Line__Payment_Class_; "Payment Class")
                {
                }
                column(Payment_Line__External_Document_No__; "External Document No.")
                {
                }
                column(Payment_Line__Due_Date_; "Due Date")
                {
                }
                column(ABS_Amount_; ABS(Amount))
                {
                    DecimalPlaces = 3 : 3;
                }
                column("Payment_Line_Libellé"; Libellé)
                {
                }
                column(Payment_Line__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
                {
                }
                column(BORDEREAUX_DE_PAIEMENTCaption; BORDEREAUX_DE_PAIEMENTCaptionLbl)
                {
                }
                column(BENEFICIAIRECaption; BENEFICIAIRECaptionLbl)
                {
                }
                column(MODE_REGLEMENTCaption; MODE_REGLEMENTCaptionLbl)
                {
                }
                column(N__CHEQUE_Caption; N__CHEQUE_CaptionLbl)
                {
                }
                column(ECHEANCECaption; ECHEANCECaptionLbl)
                {
                }
                column(MONTANTCaption; MONTANTCaptionLbl)
                {
                }
                column(LIBELLE__Caption; LIBELLE__CaptionLbl)
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
                    IF "Account Type" = "Account Type"::Customer THEN BEGIN
                        RecEcritureClient.SETRANGE("Applies-to ID", "Applies-to ID");
                        IF RecEcritureClient.FIND('-') THEN
                            REPEAT
                            // Facture+=RecEcritureClient."External Document No.";
                            UNTIL RecEcritureClient.NEXT = 0;
                    END;
                    IF PayLine."Account Type" = "Account Type"::Vendor THEN BEGIN
                        RecEcritureFornisseur.SETRANGE("Applies-to ID", PayLine."Applies-to ID");
                        IF RecEcritureFornisseur.FIND('-') THEN
                            REPEAT
                            // DocLettrage+= RecEcritureFornisseur."External Document No." + ' , ';
                            UNTIL RecEcritureFornisseur.NEXT = 0;
                    END;

                    IF RecBanque.GET("Header Account No.") THEN
                        //GL2024                    TxtDesignationBanque := RecBanque."Nom Banque Etat";

                        TxtDesignationBanque := RecBanque."Bank Branch No.";
                    VERIFTYPE();
                    IF Vend.GET("Account No.") THEN BEGIN
                        NVend := Vend."No.";
                        NomVend := Vend.Name;
                        FormatAdresse.Vendor(FnsAdr, Vend);
                    END;

                    DocLettrage := '';
                    IF "Applies-to ID" <> '' THEN BEGIN

                        IF PayLine."Account Type" = "Account Type"::Vendor THEN BEGIN
                            RecEcritureFornisseur.SETRANGE("Applies-to ID", PayLine."Applies-to ID");

                            IF RecEcritureFornisseur.FIND('-') THEN
                                REPEAT
                                    DocLettrage += RecEcritureFornisseur."External Document No." + ' , ';
                                UNTIL RecEcritureFornisseur.NEXT = 0;
                        END;
                    END;


                    CodeU."Montant en texte sans millimes"(TextGMnt, Amount);
                end;

                trigger OnPreDataItem()
                begin
                    InfoSoc.GET;
                    FormatAdresse.Company(AdrSoc, InfoSoc);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //>>IBK DSFT 13 12 2010
                IF RecBanque.GET("Account No.") THEN TxtDesignationBanque := RecBanque.Name;

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
        BORDEREAUX_DE_PAIEMENTCaptionLbl: Label 'BORDEREAUX DE PAIEMENT';
        BENEFICIAIRECaptionLbl: Label 'BENEFICIAIRE';
        MODE_REGLEMENTCaptionLbl: Label 'MODE REGLEMENT';
        N__CHEQUE_CaptionLbl: Label 'N° CHEQUE ';
        ECHEANCECaptionLbl: Label 'ECHEANCE';
        MONTANTCaptionLbl: Label 'MONTANT';
        LIBELLE__CaptionLbl: Label 'LIBELLE :';


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

