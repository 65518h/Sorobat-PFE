report 50123 "Liste Des Factures Vente"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ListeDesFacturesVente.rdlc';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Posting Date")
                                WHERE("Document Type" = FILTER(Invoice));
            RequestFilterFields = "Posting Date", "Job No.";
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
            column(Sales_Header__No__; "No.")
            {
            }
            column(Sales_Header__Posting_Date_; "Posting Date")
            {
            }
            column(Sales_Header__Bill_to_Name_; "Bill-to Name")
            {
            }
            column(DecAmountIncludingVAt; DecAmountIncludingVAt)
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
            column(Sales_Header_Document_Type; "Document Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                DecAmountIncludingVAt := 0;
                SalesLine.RESET;
                SalesLine.SETRANGE(SalesLine."Document No.", "Sales Header"."No.");
                IF SalesLine.FINDFIRST THEN
                    REPEAT
                        DecAmountIncludingVAt += SalesLine."Amount Including VAT"
                    UNTIL SalesLine.NEXT = 0;
                Total := Total + DecAmountIncludingVAt;

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
        Liste_Des_FacturesCaptionLbl: Label 'Liste Des Factures';
        Numero_FactureCaptionLbl: Label 'Numero Facture';
        "JournéeCaptionLbl": Label 'Journée';
        Raison_SocialeCaptionLbl: Label 'Raison Sociale';
        MontantCaptionLbl: Label 'Montant';


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
        ExcelBuf.AddColumn("Sales Header"."No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Sales Header"."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Sales Header"."Sell-to Customer Name", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(DecAmountIncludingVAt, FALSE, '', FALSE, FALSE, FALSE, '', 0);

    end;


    procedure CreateExcelbook()
    begin
        //   ExcelBuf.CreateBook('Liste Des Factures Vente');
        //GL2024 ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
        // ExcelBuf.GiveUserControl;
        ERROR('');
    end;
}

