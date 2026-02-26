report 52048907 "Clients Impayés"
{

    // //GL2024 ID DANS NAV2009 104
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/ClientsImpayés.rdlc';

    // dataset
    // {
    //     dataitem("G/L Entry"; "G/L Entry")
    //     {
    //         DataItemTableView = SORTING("Source No.", "G/L Account No.", "Posting Date")
    //                             WHERE(Letter = FILTER(''),
    //                                   "G/L Account No." = CONST('41600000'));
    //         RequestFilterFields = "Source Type", "Source No.", "Posting Date";
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(CurrReport_PAGENO; CurrReport.PAGENO)
    //         {
    //         }
    //         column(USERID; USERID)
    //         {
    //         }
    //         column(Source_No__________Customer_Name; "Source No." + ' : ' + Customer.Name)
    //         {
    //         }
    //         column(G_L_Entry_Amount; Amount)
    //         {
    //         }
    //         column(G_L_Entry__Posting_Date_; "Posting Date")
    //         {
    //         }
    //         column(G_L_Entry__External_Document_No__; "External Document No.")
    //         {
    //         }
    //         column(ModeReglement; ModeReglement)
    //         {
    //         }
    //         column(NomBank; NomBank)
    //         {
    //         }
    //         column(G_L_Entry_Amount_Control1000000007; Amount)
    //         {
    //         }
    //         column(G_L_Entry_Amount_Control1000000011; Amount)
    //         {
    //         }
    //         column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
    //         {
    //         }
    //         column(ETAT_DES_CLIENTS_IMPAYESCaption; ETAT_DES_CLIENTS_IMPAYESCaptionLbl)
    //         {
    //         }
    //         column(G_L_Entry_AmountCaption; FIELDCAPTION(Amount))
    //         {
    //         }
    //         column(DateCaption; DateCaptionLbl)
    //         {
    //         }
    //         column(N__PieceCaption; N__PieceCaptionLbl)
    //         {
    //         }
    //         column(ClientCaption; ClientCaptionLbl)
    //         {
    //         }
    //         column(Mode_ReglementCaption; Mode_ReglementCaptionLbl)
    //         {
    //         }
    //         column(BanqueCaption; BanqueCaptionLbl)
    //         {
    //         }
    //         column(TOTAL_GENERALCaption; TOTAL_GENERALCaptionLbl)
    //         {
    //         }
    //         column(G_L_Entry_Entry_No_; "Entry No.")
    //         {
    //         }
    //         column(G_L_Entry_Source_No_; "Source No.")
    //         {
    //         }
    //         trigger OnAfterGetRecord()
    //         var

    //         begin
    //             IF Customer.GET("G/L Entry"."Source No.") THEN;

    //             PaymentLine.SETRANGE("No.", "Document No.");
    //             PaymentLine.SETRANGE("Account No.", "Source No.");
    //             IF PaymentLine.FINDFIRST THEN BEGIN
    //                 IF PaymentLine."Payment Class" = 'ENC-CHEQUE' THEN ModeReglement := 'CHEQUE';
    //                 IF PaymentLine."Payment Class" = 'ENC-TRAITE' THEN ModeReglement := 'EFFET';
    //             END;

    //             PaymentHeader.SETRANGE(PaymentHeader."No.", "G/L Entry"."Document No.");
    //             IF PaymentHeader.FINDFIRST THEN BEGIN
    //                 NumBank := PaymentHeader."Account No.";
    //                 BankAccount.SETRANGE(BankAccount."No.", NumBank);
    //                 IF BankAccount.FINDFIRST THEN NomBank := FORMAT(BankAccount.Banque);
    //             END;

    //             IF PrintToExcel THEN BEGIN
    //                 MakeExcelDataBody;
    //             END;
    //         end;

    //         trigger OnPreDataItem()
    //         var
    //             rfrf: report 10806;
    //         begin
    //             LastFieldNo := FIELDNO("Source No.");
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

    // trigger OnPostReport()
    // begin
    //     IF PrintToExcel THEN
    //         CreateExcelbook;
    // end;

    // trigger OnPreReport()
    // begin
    //     IF PrintToExcel THEN
    //         MakeExcelInfo;
    // end;

    // var
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     TotalFor: Label 'Total ';
    //     Customer: Record 18;
    //     PaymentLine: Record 10866;
    //     ModeReglement: Text[10];
    //     PaymentHeader: Record 10865;
    //     BankAccount: Record 270;
    //     NumBank: Code[10];
    //     NomBank: Text[100];
    //     PrintToExcel: Boolean;
    //     ExcelBuf: Record 370 temporary;
    //     Text001: Label 'Données';
    //     Text002: Label 'ETAT DES CLIENTS IMPAYES';
    //     Text003: Label 'Nom de la société';
    //     Text004: Label 'N° état';
    //     Text005: Label 'Nom état';
    //     Text006: Label 'Code utilisateur';
    //     Text007: Label 'Date';
    //     CurrReport_PAGENOCaptionLbl: Label 'Page';
    //     ETAT_DES_CLIENTS_IMPAYESCaptionLbl: Label 'ETAT DES CLIENTS IMPAYES';
    //     DateCaptionLbl: Label 'Date';
    //     N__PieceCaptionLbl: Label 'N° Piece';
    //     ClientCaptionLbl: Label 'Client';
    //     Mode_ReglementCaptionLbl: Label 'Mode Reglement';
    //     BanqueCaptionLbl: Label 'Banque';
    //     TOTAL_GENERALCaptionLbl: Label 'TOTAL GENERAL';


    // procedure MakeExcelInfo()
    // begin

    //     ExcelBuf.SetUseInfoSheet;
    //     ExcelBuf.AddInfoColumn(FORMAT(Text003), FALSE, TRUE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddInfoColumn(FORMAT(Text005), FALSE, TRUE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddInfoColumn(FORMAT(Text002), FALSE, FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddInfoColumn(FORMAT(Text004), FALSE, TRUE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddInfoColumn(REPORT::"Suivi Mouvement Transfert", FALSE, FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddInfoColumn(FORMAT(Text006), FALSE, TRUE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddInfoColumn(FORMAT(Text007), FALSE, TRUE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', 0);
    //     //ExcelBuf.NewRow;
    //     ExcelBuf.ClearNewRow;
    //     MakeExcelDataHeader;
    // end;

    // local procedure MakeExcelDataHeader()
    // begin

    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn('Client', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Banque', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Date', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Mode Reglement', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('N° Piéce', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Montant', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    // end;

    // local procedure MakeExcelDataHeader2()
    // begin
    // end;


    // procedure MakeExcelDataBody()
    // begin

    //     IF CurrReport.TOTALSCAUSEDBY = "G/L Entry".FIELDNO("Source No.") THEN
    //         IF Customer.GET("G/L Entry"."Source No.") THEN;

    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn("G/L Entry"."Source No." + ' : ' + Customer.Name, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(NomBank, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("G/L Entry"."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(ModeReglement, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("G/L Entry"."External Document No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("G/L Entry".Amount, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    // end;


    // procedure CreateExcelbook()
    // begin

    //     // ExcelBuf.CreateBook;
    //     // ExcelBuf.CreateSheet(Text001, Text002, COMPANYNAME, USERID);
    //     // ExcelBuf.GiveUserControl;
    //     // ERROR('');
    // end;
}

