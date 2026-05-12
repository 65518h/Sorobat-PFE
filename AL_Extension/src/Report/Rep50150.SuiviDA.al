report 50150 "Suivi DA"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/SuiviDA.rdlc';
    ApplicationArea = all;
    UsageCategory = Lists;

    Caption = 'Suivi DA';

    dataset
    {
        dataitem("Purchase Request"; "Purchase Request")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = FILTER(Quote),
                                      "No." = FILTER('DA*'));
            RequestFilterFields = "No.", "Order Date", "Job No.", "Requester ID";
            column(DataItem1000000021; 'Date Début :       ' + FORMAT(GETRANGEMIN("Order Date")) + '       Date Fin :        ' + FORMAT(GETRANGEMAX("Order Date")))
            {
            }
            column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            // column(Sales_Header__Sales_Header___External_Document_No__; "Purchase Request"."External Document No.")
            // {
            // }
            column(Sales_Header__Sales_Header___Order_Date_; "Purchase Request"."Order Date")
            {
            }
            column(Sales_Header__Sales_Header___No__; "Purchase Request"."No.")
            {
            }
            column(Sales_Header__Sales_Header___User_ID_; "Purchase Request"."User ID")
            {
            }
            column(Demarcheur; Demarcheur)
            {
            }
            column(Sales_Header__Sales_Header___Requester_ID_; "Purchase Request"."Requester ID")
            {
            }
            column(Sales_Header__Sales_Header___Description_Engin_; "Purchase Request"."Description Engin")
            {
            }
            column(Date_Saisie_DACaption; Date_Saisie_DACaptionLbl)
            {
            }
            column(N__DACaption; N__DACaptionLbl)
            {
            }
            column(UtilisateurCaption; UtilisateurCaptionLbl)
            {
            }
            column(DemarcheurCaption; DemarcheurCaptionLbl)
            {
            }
            column(N__doc__externeCaption; N__doc__externeCaptionLbl)
            {
            }
            column(SUIVI_DEMANDE_ACHATCaption; SUIVI_DEMANDE_ACHATCaptionLbl)
            {
            }
            column(DemandeurCaption; DemandeurCaptionLbl)
            {
            }
            column(EnginCaption; EnginCaptionLbl)
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }

            column("Commande_AssociéCaption2"; Commande_AssociéCaptionLbl)
            {
            }
            column(Date_CommandeCaption2; Date_CommandeCaptionLbl)
            {
            }
            column(Nbre_BLCaption2; Nbre_BLCaptionLbl)
            {
            }

            column(EntetePurchaseheader; EntetePurchaseheader)
            {

            }
            dataitem("Purchase request Line"; "Purchase request Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    WHERE("Document Type" = FILTER(Quote),
                                          "Document No." = FILTER('DA*'));

                trigger OnAfterGetRecord()
                begin
                    Nombre := Nombre + 1;

                    IF Article <> '' THEN SETRANGE("Purchase request Line"."No.", Article);
                    // RB SORO 17/09/2015
                    //"Purchase Request".CALCFIELDS("Commande Achat Associé");
                    // RecPurchaseLine.SETRANGE("Document No.", "Purchase Request"."Commande Achat Associé");
                    "Purchase Request".CALCFIELDS("Associated Purchase Order");
                    RecPurchaseLine.SETRANGE("Document No.", "Purchase Request"."Associated Purchase Order");
                    RecPurchaseLine.SETRANGE("No.", "Purchase request Line"."No.");
                    RecPurchaseLine.SETRANGE(Description, "Purchase request Line".Description);
                    IF RecPurchaseLine.FINDFIRST THEN BEGIN
                        QtReçue := RecPurchaseLine."Quantity Received";
                    END;
                    // RB SORO 17/09/2015








                    IF Vendor.GET("Vendor No.") THEN;

                    //if Entete.get("Sales Line"."Document No.") then;
                    //Aff := Entete."Job No.";
                    MakeExcelDataBody;
                    // IF ShippingAgent.GET("Purchase Request"."Shipping Agent Code") THEN;
                    // Demarcheur := ShippingAgent.Name;
                    IF ShippingAgent.GET("Purchase Request"."Demarcheur") THEN;
                    Demarcheur := ShippingAgent.Name;
                end;

                trigger OnPreDataItem()
                begin
                    IF Article <> '' THEN SETRANGE("No.", Article);
                end;

            }
            dataitem("Purchase Header"; 38)
            {
                DataItemLink = "N° Demande d'achat" = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.")
                                    WHERE("Document Type" = CONST(Order));
                column(Purchase_Header__No__; "No.")
                {
                }
                column(Purchase_Header__Posting_Date_; "Posting Date")
                {
                }
                column(NbreBL; NbreBL)
                {
                }
                column(Date_CommandeCaption; Date_CommandeCaptionLbl)
                {
                }
                column("Commande_AssociéCaption"; Commande_AssociéCaptionLbl)
                {
                }
                column(Nbre_BLCaption; Nbre_BLCaptionLbl)
                {
                }
                column(Purchase_Header_Document_Type; "Document Type")
                {
                }
                column(Purchase_Header_N__Demande_d_achat; "N° Demande d'achat")
                {
                }
                trigger OnAfterGetRecord()
                var
                begin

                    NbreBL := 0;
                    PurchRcptHeader.SETRANGE(PurchRcptHeader."Order No.", "No.");
                    NbreBL := PurchRcptHeader.COUNT;


                    EntetePurchaseheader := true;






                end;

                trigger OnPreDataItem()
                begin
                    EntetePurchaseheader := false;
                end;
            }
            trigger OnAfterGetRecord()
            var
            begin
                NbreBL := 0;
                DateSaisieCMDA := '';
                RecPurchaseHeader.RESET;
                // IF "Purchase Request"."Commande Achat Associé" <> '' THEN BEGIN
                IF "Purchase Request"."Associated Purchase Order" <> '' THEN BEGIN
                    // RecPurchaseHeader.SETRANGE(RecPurchaseHeader."No.", "Purchase Request"."Commande Achat Associé");
                    RecPurchaseHeader.SETRANGE(RecPurchaseHeader."No.", "Purchase Request"."Associated Purchase Order");
                    RecPurchaseHeader.FINDFIRST;
                    DateCommande := RecPurchaseHeader."Posting Date";
                    DateSaisieCMDA := FORMAT(DateCommande);
                    // PurchRcptHeader.SETRANGE(PurchRcptHeader."Order No.", "Purchase Request"."Commande Achat Associé");
                    PurchRcptHeader.SETRANGE(PurchRcptHeader."Order No.", "Purchase Request"."Associated Purchase Order");
                    NbreBL := PurchRcptHeader.COUNT;
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
        // IF PrintToExcel THEN
        //   CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        // IF PrintToExcel THEN
        //    MakeExcelInfo;
    end;

    var

        Nombre: Integer;
        Vendor: Record 23;
        Entete: Record 36;
        Aff: Text[30];
        Vehicu: Text[30];
        Demand: Text[30];
        AgentSaisie: Text[30];
        Article: Code[20];
        PrintToExcel: Boolean;
        TotalFor: Label 'Total ';
        Text001: Label 'Données';
        Text002: Label 'Etat Mouvement Articles';
        Text003: Label 'Nom de la société';
        Text004: Label 'N° état';
        Text005: Label 'Nom état';
        Text006: Label 'Code utilisateur';
        Text007: Label 'Date';
        ExcelBuf: Record 370 temporary;
        "QtReçue": Decimal;
        RecPurchaseLine: Record 39;
        ShippingAgent: Record 291;
        Demarcheur: Text[100];
        PageConst: Label 'Page';
        PurchRcptHeader: Record 120;
        NbreBL: Integer;
        RecPurchaseHeader: Record 38;
        DateCommande: Date;
        DateSaisieCMDA: Text[30];
        Date_Saisie_DACaptionLbl: Label 'Date Saisie DA';
        N__DACaptionLbl: Label 'N° DA';
        UtilisateurCaptionLbl: Label 'Utilisateur';
        DemarcheurCaptionLbl: Label 'Demarcheur';
        N__doc__externeCaptionLbl: Label 'N° doc. externe';
        SUIVI_DEMANDE_ACHATCaptionLbl: Label 'SUIVI DEMANDE ACHAT';
        DemandeurCaptionLbl: Label 'Demandeur';
        EnginCaptionLbl: Label 'Engin';
        Date_CommandeCaptionLbl: Label 'Date Commande';
        "Commande_AssociéCaptionLbl": Label 'Commande Associé';
        Nbre_BLCaptionLbl: Label 'Nbre BL';
        EntetePurchaseheader: Boolean;

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
        // ExcelBuf.AddInfoColumn(REPORT::"Liste DA",FALSE,FALSE,FALSE,FALSE,'',0);
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
        ExcelBuf.AddColumn('Date', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('N° Document', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('N°', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Designation', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Quantité', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Unité', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Engin', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('N° Commande Achat Associé', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Quantité Reçue', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    end;

    local procedure MakeExcelDataHeader2()
    begin
    end;

    // [Scope('Internal')]
    procedure MakeExcelDataBody()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Purchase Request"."Order Date", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Purchase request Line"."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Purchase request Line"."No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Purchase request Line".Description, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Purchase request Line".Quantity, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Purchase request Line"."Unit of Measure", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Purchase Request".Engin, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        // "Purchase Request".CALCFIELDS("Commande Achat Associé");
        "Purchase Request".CALCFIELDS("Associated Purchase Order");
        // ExcelBuf.AddColumn("Purchase Request"."Commande Achat Associé", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Purchase Request"."Associated Purchase Order", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(QtReçue, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        CLEAR(QtReçue);
    end;

    // [Scope('Internal')]
    procedure CreateExcelbook()
    begin
        // ExcelBuf.CreateBook('Suivi DA');
        //GL2024 ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
        // ExcelBuf.GiveUserControl;
    end;
}

