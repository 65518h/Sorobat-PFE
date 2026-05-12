report 50121 "Suivi Client"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/SuiviClient.rdlc';

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = SORTING("Date Comptabilisation")
                                ORDER(Ascending)
                                WHERE("Document Type" = FILTER(Order),
                                      "User ID" = FILTER('D.RIM|D.HANEN|H.NAWRES|A.KHOULOUD|B.SIWAR|S.WAEL'));
            RequestFilterFields = "Sell-to Customer No.", "Date Comptabilisation";
            column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(NomClient; NomClient)
            {
            }
            column(DataItem1000000010; 'Journée Du :   ' + FORMAT(GETRANGEMIN("Date Comptabilisation")) + '  Au :   ' + FORMAT(GETRANGEMAX("Date Comptabilisation")))
            {
            }
            column(Sales_Line__Date_Comptabilisation_; "Date Comptabilisation")
            {
            }
            column(Sales_Line_Quantity; Quantity)
            {
            }
            column(Sales_Line_Description; Description)
            {
            }
            column(Sales_Line__Job_No__; "Job No.")
            {
            }
            column(NumBL; NumBL)
            {
            }
            column(Total; Total)
            {
            }
            column(Client__Caption; Client__CaptionLbl)
            {
            }
            column(Suivi_ClientCaption; Suivi_ClientCaptionLbl)
            {
            }
            column("JournéeCaption"; JournéeCaptionLbl)
            {
            }
            column(Sales_Line_QuantityCaption; FIELDCAPTION(Quantity))
            {
            }
            column(Sales_Line_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(CentraleCaption; CentraleCaptionLbl)
            {
            }
            column("NuméroCaption"; NuméroCaptionLbl)
            {
            }
            column(Sales_Line_Document_Type; "Document Type")
            {
            }
            column(Sales_Line_Document_No_; "Document No.")
            {
            }
            column(Sales_Line_Line_No_; "Line No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                NumBL := '';
                SalesHeader.RESET;
                IF SalesHeader.GET("Document Type", "Document No.") THEN NumBL := SalesHeader."External Document No.";


                IF Customer.GET("Sales Line"."Sell-to Customer No.") THEN;
                NomClient := Customer.Name;

                Total := Total + "Sales Line".Quantity;
                IF PrintToExcel THEN BEGIN
                    MakeExcelDataBody;
                END;
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
        SalesHeader: Record 36;
        NumBL: Text[30];
        Customer: Record 18;
        NomClient: Text[150];
        Total: Decimal;
        Numserie: Text[30];
        "//MH SORO 06-08-2015": Integer;
        PrintToExcel: Boolean;
        ExcelBuf: Record 370 temporary;
        Montant: Decimal;
        TotalFor: Label 'Total ';
        Text001: Label 'Données';
        Text002: Label 'Nom de la société';
        Text003: Label 'Nom de la société';
        Text004: Label 'N° état';
        Text005: Label 'Nom état';
        Text006: Label 'Code utilisateur';
        Text007: Label 'Date';
        Item: Record 27;
        "Journée": Date;
        NumExpedition: Text[30];
        utilisateur: Text[30];
        NbreLigne: Integer;
        TotalQte: Decimal;
        Client__CaptionLbl: Label 'Client :';
        Suivi_ClientCaptionLbl: Label 'Suivi Client';
        "JournéeCaptionLbl": Label 'Journée';
        CentraleCaptionLbl: Label 'Centrale';
        "NuméroCaptionLbl": Label 'Numéro';

    // [Scope('Internal')]
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
        ExcelBuf.AddColumn('Journée', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('N° BL', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Quantité', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Désignation Article', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Centrale', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    end;

    local procedure MakeExcelDataHeader2()
    begin
        //ExcelBuf.NewRow;
        //ExcelBuf.AddColumn('N° Vehicule :'+"Item Ledger Entry"."N° Véhicule",FALSE,'',TRUE,FALSE,TRUE,'',0);
        //ExcelBuf.AddColumn('Description :' +"Item Ledger Entry".Description,FALSE,'',TRUE,FALSE,TRUE,'',0);
        //ExcelBuf.AddColumn('N° Serie :'+Numserie,FALSE,'',TRUE,FALSE,TRUE,'',0);
    end;

    // [Scope('Internal')]
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

        IF Item.GET("Sales Line"."No.") THEN;
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Sales Line"."Date Comptabilisation", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(NumBL, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Sales Line".Quantity, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Sales Line".Description, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Sales Line"."Job No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);

    end;

    //[Scope('Internal')]
    procedure CreateExcelbook()
    begin
        //   ExcelBuf.CreateBook('Suivi Client');
        //GL2024 ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
        // ExcelBuf.GiveUserControl;
        ERROR('');
    end;
}

