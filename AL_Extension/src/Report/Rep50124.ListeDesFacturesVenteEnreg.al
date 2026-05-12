report 50124 "Liste Des Factures Vente Enreg"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ListeDesFacturesVenteEnreg.rdlc';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("No." = FILTER('*BT*|FAV+*'),
                                      "User ID" = FILTER('D.HANEN|H.NAWRES|A.KHOULOUD|B.SIWAR|S.WAEL'));
            RequestFilterFields = "Posting Date", "Sell-to Customer No.", "Job No.";
            column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column("Période_Du________FORMAT_GETRANGEMIN__Posting_Date_________Au________FORMAT_GETRANGEMAX__Posting_Date___"; 'Période Du :   ' + FORMAT(GETRANGEMIN("Posting Date")) + '  Au :   ' + FORMAT(GETRANGEMAX("Posting Date")))
            {
            }
            column(Compteur; Compteur)
            {
            }
            column(Sales_Invoice_Header__No__; "No.")
            {
            }
            column(Sales_Invoice_Header__Posting_Date_; "Posting Date")
            {
            }
            column(Sales_Invoice_Header__Sales_Invoice_Header___Sell_to_Customer_Name_; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(Sales_Invoice_Header__Sales_Invoice_Header___Amount_Including_VAT_; "Sales Invoice Header"."Amount Including VAT")
            {
            }
            column(NumReglement; NumReglement)
            {
            }
            column(Total; Total)
            {
            }
            column(Liste_Des_FacturesCaption; Liste_Des_FacturesCaptionLbl)
            {
            }
            column(Numero_FactureCaption; Numero_FactureCaptionLbl)
            {
            }
            column("JournéeCaption"; JournéeCaptionLbl)
            {
            }
            column(Raison_SocialeCaption; Raison_SocialeCaptionLbl)
            {
            }
            column(MontantCaption; MontantCaptionLbl)
            {
            }
            column(Num_ReglementCaption; Num_ReglementCaptionLbl)
            {
            }
            column(N_Caption; N_CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Total := Total + "Sales Invoice Header"."Amount Including VAT";
                TotalQte := 0;
                CustLedgerEntry.RESET;
                ReCustLedgerEntry.RESET;
                CustLedgerEntry.SETRANGE(CustLedgerEntry."Document No.", "Sales Invoice Header"."No.");
                IF CustLedgerEntry.FINDFIRST THEN;
                IF CustLedgerEntry."Closed by Entry No." = 0 THEN BEGIN
                    ReCustLedgerEntry.SETRANGE(ReCustLedgerEntry."Closed by Entry No.", CustLedgerEntry."Entry No.");
                    IF ReCustLedgerEntry.FINDFIRST THEN
                        NumReglement := ReCustLedgerEntry."Document No."
                    ELSE
                        NumReglement := '';

                END
                ELSE IF CustLedgerEntry."Closed by Entry No." > 0 THEN BEGIN
                    ReCustLedgerEntry.SETRANGE(ReCustLedgerEntry."Entry No.", CustLedgerEntry."Closed by Entry No.");
                    IF ReCustLedgerEntry.FINDFIRST THEN
                        NumReglement := ReCustLedgerEntry."Document No."
                    ELSE
                        NumReglement := '';

                END;

                RecSalesInvoiceLine.RESET;
                RecSalesInvoiceLine.SETRANGE(RecSalesInvoiceLine."Document No.", "Sales Invoice Header"."No.");
                RecSalesInvoiceLine.SETRANGE(RecSalesInvoiceLine.Type, RecSalesInvoiceLine.Type::Item);
                IF RecSalesInvoiceLine.FINDFIRST THEN
                    REPEAT
                        TotalQte += RecSalesInvoiceLine.Quantity;
                    UNTIL RecSalesInvoiceLine.NEXT = 0;


                /*IF COPYSTR(NumReglement, 1, 3) = 'GDH' THEN NumReglement := '';
                                IF COPYSTR(NumReglement, 1, 4) = '2015' THEN NumReglement := ''; */
                IF NumReglement <> '' THEN NumReglement := 'REGLER' ELSE NumReglement := ' ';
                Compteur += 1;
                IF PrintToExcel THEN BEGIN
                    MakeExcelDataBody;
                END;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Posting Date");
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

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        IF PrintToExcel THEN
            MakeExcelInfo;
    end;

    var
        PageConst: Label 'Page';
        TotalFor: Label 'Total ';
        Text001: Label 'Données';
        Text002: Label 'Liste Des Factures';
        Text003: Label 'Nom de la société';
        Text004: Label 'N° état';
        Text005: Label 'Nom état';
        Text006: Label 'Code utilisateur';
        Text007: Label 'Date';
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        SalesLine: Record 37;
        DecAmountIncludingVAt: Decimal;
        Total: Decimal;
        "//MH SORO 06-08-2015": Integer;
        PrintToExcel: Boolean;
        ExcelBuf: Record 370 temporary;
        CustLedgerEntry: Record 21;
        ReCustLedgerEntry: Record 21;
        NumReglement: Text[50];
        Compteur: Integer;
        RecSalesInvoiceLine: Record 113;
        TotalQte: Decimal;
        Liste_Des_FacturesCaptionLbl: Label 'Liste Des Factures';
        Numero_FactureCaptionLbl: Label 'Numero Facture';
        "JournéeCaptionLbl": Label 'Journée';
        Raison_SocialeCaptionLbl: Label 'Raison Sociale';
        MontantCaptionLbl: Label 'Montant';
        Num_ReglementCaptionLbl: Label 'Num Reglement';
        N_CaptionLbl: Label 'N°';


    procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text003), FALSE, TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text005), FALSE, TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddInfoColumn(FORMAT(Text002), FALSE, FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text004), FALSE, TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddInfoColumn(REPORT::"Suivi Mouvement Transfert", FALSE, FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006), FALSE, TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007), FALSE, TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', 0);
        //ExcelBuf.NewRow;
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Numero Facture', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Journée', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Raison Sociale', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Montant', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Num Reglement', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Total Qte', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    end;

    local procedure MakeExcelDataHeader2()
    begin
        //ExcelBuf.NewRow;
        //ExcelBuf.AddColumn('N° Vehicule :'+"Item Ledger Entry"."N° Véhicule",FALSE,'',TRUE,FALSE,TRUE,'',0);
        //ExcelBuf.AddColumn('Description :' +"Item Ledger Entry".Description,FALSE,'',TRUE,FALSE,TRUE,'',0);
        //ExcelBuf.AddColumn('N° Serie :'+Numserie,FALSE,'',TRUE,FALSE,TRUE,'',0);
    end;


    procedure MakeExcelDataBody()
    begin
        /*IF Item.GET("Item Ledger Entry"."Item No.") THEN;
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Item Ledger Entry"."Posting Date",FALSE,'',FALSE,FALSE,FALSE,'',0);
        ExcelBuf.AddColumn("Item Ledger Entry"."Item No.",FALSE,'',FALSE,FALSE,FALSE,'',0);
        ExcelBuf.AddColumn(Item.Description,FALSE,'',FALSE,FALSE,FALSE,'',0);
        ExcelBuf.AddColumn("Item Ledger Entry".Quantity,FALSE,'',FALSE,FALSE,FALSE,'',0);
        ExcelBuf.AddColumn(Montant,FALSE,'',FALSE,FALSE,FALSE,'',0);
        ExcelBuf.AddColumn("Item Ledger Entry"."Location Code",FALSE,'',FALSE,FALSE,FALSE,'',0);
        ExcelBuf.AddColumn("Item Ledger Entry"."N° Véhicule",FALSE,'',FALSE,FALSE,FALSE,'',0);
        ExcelBuf.AddColumn("Item Ledger Entry"."Document No.",FALSE,'',FALSE,FALSE,FALSE,'',0); */


        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Sales Invoice Header"."No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Sales Invoice Header"."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Sales Invoice Header"."Sell-to Customer Name", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Sales Invoice Header"."Amount Including VAT", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(NumReglement, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(TotalQte, FALSE, '', FALSE, FALSE, FALSE, '', 0);

    end;


    procedure CreateExcelbook()
    begin
        // ExcelBuf.CreateBook('Liste Des Factures Vente Enreg');
        //GL2024 ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
        // ExcelBuf.GiveUserControl;
        ERROR('');
    end;
}

