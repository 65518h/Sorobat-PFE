report 8004157 "Impaye Fournisseur"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/ImpayeFournisseur.rdlc';

    // dataset
    // {
    //     dataitem("Vendor Ledger Entry"; 25)
    //     {
    //         DataItemTableView = SORTING("Vendor No.", "Posting Date", "Currency Code")
    //                             WHERE("Document No." = FILTER('BORTRTIMPFRS*' | 'AVAN*'),
    //                                   Description = FILTER('*IMPAY*'),
    //                                   "Remaining Amount" = FILTER(<> 0));
    //         RequestFilterFields = "Vendor No.", "Posting Date", "Due Date";
    //         column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(Vendor_Ledger_Entry__Due_Date_; "Due Date")
    //         {
    //         }
    //         column(Vendor_Ledger_Entry__Vendor_Ledger_Entry___Remaining_Amount_; "Vendor Ledger Entry"."Remaining Amount")
    //         {
    //         }
    //         column(Vendor_Ledger_Entry__External_Document_No__; "External Document No.")
    //         {
    //         }
    //         column(NomFournisseur; NomFournisseur)
    //         {
    //         }
    //         column(NomBanque; NomBanque)
    //         {
    //         }
    //         column(Vendor_Ledger_Entry__Vendor_Ledger_Entry___Remaining_Amount__Control1000000027; "Vendor Ledger Entry"."Remaining Amount")
    //         {
    //         }
    //         column("TOTAL_Impayé_du_Fournisseur_______NomFournisseur"; 'TOTAL Impayé du Fournisseur :   ' + NomFournisseur)
    //         {
    //         }
    //         column("Etat_des_Impayés_FournisseurCaption"; Etat_des_Impayés_FournisseurCaptionLbl)
    //         {
    //         }
    //         column(BanqueCaption; BanqueCaptionLbl)
    //         {
    //         }
    //         column("Date_d_échéanceCaption"; Date_d_échéanceCaptionLbl)
    //         {
    //         }
    //         column(Nom_FournisseurCaption; Nom_FournisseurCaptionLbl)
    //         {
    //         }
    //         column(MontantCaption; MontantCaptionLbl)
    //         {
    //         }
    //         column("N__Piéce_de_PaiementCaption"; N__Piéce_de_PaiementCaptionLbl)
    //         {
    //         }
    //         column(Vendor_Ledger_Entry_Entry_No_; "Entry No.")
    //         {
    //         }
    //         column(Vendor_Ledger_Entry_Vendor_No_; "Vendor No.")
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             NomFournisseur := '';
    //             NomBanque := '';
    //             RecVendor.RESET;
    //             IF RecVendor.GET("Vendor No.") THEN NomFournisseur := RecVendor.Name;

    //             RecPaymentHeader.RESET;
    //             RecPaymentHeader.SETRANGE("No.", "Document No.");
    //             IF RecPaymentHeader.FINDFIRST THEN BEGIN
    //                 RecBankAccount.RESET;
    //                 IF RecBankAccount.GET(RecPaymentHeader."Account No.") THEN NomBanque := FORMAT(RecBankAccount.Banque);

    //             END;
    //             "Vendor Ledger Entry".CALCFIELDS(Amount);
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             LastFieldNo := FIELDNO("Vendor No.");
    //         end;
    //     }
    // }

    // requestpage
    // {

    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(Options)
    //             {
    //                 field(Banque; Banque)
    //                 {
    //                     ApplicationArea = all;
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

    // var
    //     PageConst: Label 'Page';
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     TotalFor: Label 'Total ';
    //     RecVendor: Record 23;
    //     RecPaymentHeader: Record 10865;
    //     RecBankAccount: Record 270;
    //     NomFournisseur: Text[150];
    //     NomBanque: Text[30];
    //     Banque: Option " ",ATB,ATTIJARI,BNA,BH,BT,BTE,BTL,BTK,QNB,STB,IUB,UBCI,ZITOUNA,BIAT,STUCID,TSB;
    //     "Etat_des_Impayés_FournisseurCaptionLbl": Label 'Etat des Impayés Fournisseur';
    //     BanqueCaptionLbl: Label 'Banque';
    //     "Date_d_échéanceCaptionLbl": Label 'Date d''échéance';
    //     Nom_FournisseurCaptionLbl: Label 'Nom Fournisseur';
    //     MontantCaptionLbl: Label 'Montant';
    //     "N__Piéce_de_PaiementCaptionLbl": Label 'N° Piéce de Paiement';
}

