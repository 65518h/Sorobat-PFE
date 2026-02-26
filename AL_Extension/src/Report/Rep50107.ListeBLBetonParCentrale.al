report 50107 "Liste BL Beton Par Centrale"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ListeBLBetonParCentrale.rdlc';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Job No.")
                                WHERE("User ID" = FILTER('D.RIM|D.HANEN|H.NAWRES|A.KHOULOUD|B.SIWAR|S.WAEL'),
                                      "Document Type" = FILTER(Order),
                                      "External Document No." = FILTER('<>ANNULER'),
                                      "Sell-to Customer No." = FILTER('<>CL00001|CPV-0999|CL00025'));
            RequestFilterFields = "Sell-to Customer No.", "Posting Date", "Job No.";
            column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column("Journée_Du________FORMAT_GETRANGEMIN__Posting_Date_________Au________FORMAT_GETRANGEMAX__Posting_Date___"; 'Journée Du :   ' + FORMAT(GETRANGEMIN("Posting Date")) + '  Au :   ' + FORMAT(GETRANGEMAX("Posting Date")))
            {
            }
            column(Sales_Header__Sales_Header___Job_No__; "Sales Header"."Job No.")
            {
            }
            column(TotalQteCentrale; TotalQteCentrale)
            {
            }
            column(Total_Qte_du____Sales_Header___Job_No________; 'Total Qte du ' + "Sales Header"."Job No." + '  :')
            {
            }
            column(TotalQte; TotalQte)
            {
            }
            column(NbreLigne; NbreLigne)
            {
            }
            column(Etat_des_Bons_de_Livraison_par_CentraleCaption; Etat_des_Bons_de_Livraison_par_CentraleCaptionLbl)
            {
            }
            column("JournéeCaption"; JournéeCaptionLbl)
            {
            }
            column(N__BLCaption; N__BLCaptionLbl)
            {
            }
            column("N__ExpéditionCaption"; N__ExpéditionCaptionLbl)
            {
            }
            column(Raison_socialCaption; Raison_socialCaptionLbl)
            {
            }
            column(ArticleCaption; ArticleCaptionLbl)
            {
            }
            column("QtéCaption"; QtéCaptionLbl)
            {
            }
            column(CentraleCaption; CentraleCaptionLbl)
            {
            }
            column(Centrale__Caption; Centrale__CaptionLbl)
            {
            }
            column("Total_Quantité__Caption"; Total_Quantité__CaptionLbl)
            {
            }
            column(Nbre_Ligne__Caption; Nbre_Ligne__CaptionLbl)
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("No.");
                column(Sales_Line_Description; Description)
                {
                }
                column("Journée"; Journée)
                {
                }
                column(NumBL; NumBL)
                {
                }
                column(NumExpedition; NumExpedition)
                {
                }
                column(NomClient; NomClient)
                {
                }
                column(Sales_Line__Sales_Line__Quantity; "Sales Line".Quantity)
                {
                }
                column(Centrale; Centrale)
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
                    IF "Date Comptabilisation" <> "Sales Header"."Posting Date" THEN BEGIN
                        "Date Comptabilisation" := "Sales Header"."Posting Date";
                        MODIFY;
                    END;
                    RecSalesHeader.RESET;
                    RecSalesHeader.SETRANGE(RecSalesHeader."No.", "Sales Line"."Document No.");
                    RecSalesHeader.FINDFIRST;
                    Journée := RecSalesHeader."Posting Date";
                    NumBL := RecSalesHeader."External Document No.";
                    NumExpedition := RecSalesHeader."Last Shipping No.";
                    NomClient := RecSalesHeader."Sell-to Customer Name";
                    utilisateur := RecSalesHeader."User ID";
                    Centrale := RecSalesHeader."Job No.";
                    NbreLigne += 1;
                    TotalQte := TotalQte + "Sales Line".Quantity;
                    TotalQteCentrale := TotalQteCentrale + "Sales Line".Quantity;
                    IF PrintToExcel THEN BEGIN
                        MakeExcelDataBody;
                    END;
                end;
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Sell-to Customer No.");
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        RecSalesHeader: Record 36;
        "Journée": Date;
        NumBL: Text[30];
        NumExpedition: Text[30];
        NomClient: Text[150];
        utilisateur: Text[30];
        Centrale: Text[30];
        NbreLigne: Integer;
        TotalQte: Decimal;
        Numserie: Text[30];
        "//MH SORO 06-08-2015": Integer;
        PrintToExcel: Boolean;
        ExcelBuf: Record 370 temporary;
        Montant: Decimal;
        Item: Record 27;
        TotalFor: Label 'Total ';
        Text001: Label 'Données';
        Text002: Label 'Etat des Bons de Livraison par Centrale';
        Text003: Label 'Nom de la société';
        Text004: Label 'N° état';
        Text005: Label 'Nom état';
        Text006: Label 'Code utilisateur';
        Text007: Label 'Date';
        TotalQteCentrale: Decimal;
        Etat_des_Bons_de_Livraison_par_CentraleCaptionLbl: Label 'Etat des Bons de Livraison par Centrale';
        "JournéeCaptionLbl": Label 'Journée';
        N__BLCaptionLbl: Label 'N° BL';
        "N__ExpéditionCaptionLbl": Label 'N° Expédition';
        Raison_socialCaptionLbl: Label 'Raison social';
        ArticleCaptionLbl: Label 'Article';
        "QtéCaptionLbl": Label 'Qté';
        CentraleCaptionLbl: Label 'Centrale';
        Centrale__CaptionLbl: Label 'Centrale :';
        "Total_Quantité__CaptionLbl": Label 'Total Quantité :';
        Nbre_Ligne__CaptionLbl: Label 'Nbre Ligne :';

    //[Scope('Internal')]
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
        ExcelBuf.AddColumn('Centrale', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Journée', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('N° BL', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('N° Expedition', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Raison Social', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Quantité', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Désignation Article', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    end;

    local procedure MakeExcelDataHeader2()
    begin
        //ExcelBuf.NewRow;
        //ExcelBuf.AddColumn('N° Vehicule :'+"Item Ledger Entry"."N° Véhicule",FALSE,'',TRUE,FALSE,TRUE,'',0);
        //ExcelBuf.AddColumn('Description :' +"Item Ledger Entry".Description,FALSE,'',TRUE,FALSE,TRUE,'',0);
        //ExcelBuf.AddColumn('N° Serie :'+Numserie,FALSE,'',TRUE,FALSE,TRUE,'',0);
    end;

    //[Scope('Internal')]
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
        ExcelBuf.AddColumn("Sales Line"."Job No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(Journée, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(NumBL, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(NumExpedition, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(NomClient, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Sales Line".Quantity, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Sales Line".Description, FALSE, '', FALSE, FALSE, FALSE, '', 0);

    end;

    // [Scope('Internal')]
    procedure CreateExcelbook()
    begin
        // ExcelBuf.CreateBook('Liste BL Beton Par Centrale');
        //GL2024 ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
        //ExcelBuf.GiveUserControl;
        ERROR('');
    end;
}

