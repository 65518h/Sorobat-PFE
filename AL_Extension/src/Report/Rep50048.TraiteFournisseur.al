report 50048 "* Traite Fournisseur"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/TraiteFournisseur.rdl';

    dataset
    {
        dataitem("Payment Header"; 10865)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(Payment_Header_No_; "No.")
            {
            }
            dataitem("Payment Line"; 10866)
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE("Account Type" = FILTER(Vendor),
                                          "Mode Paiement" = CONST(Traite));
                column(STR____; '#' + STR + '#')
                {
                }
                column(FORMAT__TOT_0___Precision_3___Standard_format_0________; '#' + FORMAT(TOT, 0, '<Precision,3:><Standard format,0>') + '#')
                {
                    // DecimalPlaces = 3:3;
                }
                column(Payment_Line__Due_Date_; "Due Date")
                {
                }
                column(FORMAT__TOT_0___Precision_3___Standard_format_0_________Control1000000011; '#' + FORMAT(TOT, 0, '<Precision,3:><Standard format,0>') + '#')
                {
                    // DecimalPlaces = 3:3;
                }
                column(CompanyInfo_Name_______CompanyInfo_Address_______CompanyInfo__Address_2_; CompanyInfo.Name + '   ' + CompanyInfo.Address + '   ' + CompanyInfo."Address 2")
                {
                }
                column(Frs_Name; Frs.Name)
                {
                }
                column(Payment_Line__Due_Date__Control1000000023; "Due Date")
                {
                }
                column(Payment_Header___Document_Date_; "Payment Header"."Document Date")
                {
                }
                column(Payment_Line__Currency_Code_; "Currency Code")
                {
                }
                column(AdresseB; AdresseB)
                {
                }
                column(Frs_Name_Control1000000028; Frs.Name)
                {
                }
                column(CompanyInfo_City; CompanyInfo.City)
                {
                }
                column(Payment_Header___Document_Date__Control1000000031; "Payment Header"."Document Date")
                {
                }
                column(designation; designation)
                {
                }
                column(CompanyInfo_Name; CompanyInfo.Name)
                {
                }
                column(COPYSTR_CompBank_RIB_1_2_; COPYSTR(CompBank.RIB, 1, 2))
                {
                }
                column(COPYSTR_CompBank_RIB_6_13_; COPYSTR(CompBank.RIB, 6, 13))
                {
                }
                column(COPYSTR_CompBank_RIB_3_3_; COPYSTR(CompBank.RIB, 3, 3))
                {
                }
                column(COPYSTR_CompBank_RIB_19_2_; COPYSTR(CompBank.RIB, 19, 2))
                {
                }
                column(COPYSTR_CompBank_RIB_6_13__Control1000000003; COPYSTR(CompBank.RIB, 6, 13))
                {
                }
                column(COPYSTR_CompBank_RIB_19_2__Control1000000006; COPYSTR(CompBank.RIB, 19, 2))
                {
                }
                column(COPYSTR_CompBank_RIB_3_3__Control1000000008; COPYSTR(CompBank.RIB, 3, 3))
                {
                }
                column(COPYSTR_CompBank_RIB_1_2__Control1000000013; COPYSTR(CompBank.RIB, 1, 2))
                {
                }
                column(CompanyInfo_Name_Control1000000002; CompanyInfo.Name)
                {
                }
                column(Adresse2B; Adresse2B)
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
                    Frs.GET("Account No.");
                    STR := '';
                    TOT := ROUND("Payment Line"."Debit Amount", 0.001);
                    //Convert."Montant en texte"(STR,"Payment Line"."Debit Amount");
                    Convert."Montant en texte"(STR, TOT);
                    IF CompBank.GET("Payment Line"."Compte Bancaire") THEN;
                    AdresseB := CompBank.Address;
                    Adresse2B := CompBank."Address 2";

                    //CurrReport.SHOWOUTPUT:=FALSE;
                    CompBank.RESET;
                    IF CompBank.GET("Compte Bancaire") THEN;
                    //Convert."Montant en texte"(STR,Amount);
                end;

                trigger OnPreDataItem()
                begin
                    TOT := 0;
                    IF GNumLigne <> 0 THEN SETRANGE("Line No.", GNumLigne);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.GET;
                IF "Payment Header"."Currency Code" = '' THEN
                    Devise := 'EUR'
                ELSE
                    Devise := "Currency Code";
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
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
        afficherdetail := 1;
    end;

    var
        CompanyInfo: Record 79;
        FormatAddr: Codeunit 365;
        CompanyAddr: array[8] of Text[50];
        Frs: Record 23;
        Bank: Record 288;
        NomBq: Text[30];
        Compteur: Integer;
        Convert: Codeunit 50005;
        TOT: Decimal;
        NBank: Text[30];
        Nligne: Integer;
        Res: Integer;
        Compte: Integer;
        Devise: Code[10];
        Etab: Text[30];
        Cagence: Text[30];
        CompBank: Record 270;
        BankInfo: Text[250];
        BankInfo2: Text[250];
        RIB: Text[30];
        MT: Decimal;
        STR: Text[250];
        afficherdetail: Integer;
        PaymentLine: Record 10866;
        designation: Text[50];
        GNumLigne: Integer;
        AdresseB: Text[100];
        Adresse2B: Text[100];

    // [Scope('Internal')]
    procedure GetNumberLIne(ParaNumLigne: Integer)
    begin
        GNumLigne := ParaNumLigne;
    end;
}

