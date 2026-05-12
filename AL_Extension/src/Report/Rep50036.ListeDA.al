Report 50036 "Liste DA"
{
    RDLCLayout = './Layouts/ListeDA.RDL';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Purchase Request"; "Purchase Request")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = filter(Quote));
            RequestFilterFields = Engin, "Order Date", "Job No.", "Requester ID", "Posting Date", "No.";


            column(SalesLineFIELDCAPTION_Description; "Purchase request Line".FieldCaption(Description))
            {
            }
            column(TODAY_0_4; Format(Today, 0, 4))
            {
            }

            column(DateDebut__FORMAT_GETRANGEMIN_OrderDate__DateFin__FORMAT_GET; 'Date Début :	   ' + Format(GetRangeMin("Order Date")) + '	   Date Fi n :		' + Format(GetRangemax("Order Date")))
            {
            }
            column(SalesLineFIELDCAPTION_UnitofMeasure; "Purchase request Line".FieldCaption("Unit of Measure"))
            {
            }
            column(SalesLineFIELDCAPTION_Quantity; "Purchase request Line".FieldCaption(Quantity))
            {
            }
            column(No_; "No.") { }
            column(Order_Date; "Order Date") { }
            column(User_ID; "User ID") { }
            column(Requester_ID; "Requester ID") { }
            dataitem("Purchase request Line"; "Purchase request Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.") where("Document Type" = filter(Quote));

                column(SalesHeaderEngin___SalesHeaderDescriptionEngin; "Purchase Request".Engin + ' :  ' + "Purchase Request"."Description Engin")
                {
                }
                column(Demarcheur; Demarcheur)
                {
                }
                column(SalesHeaderUserID; "Purchase Request"."User ID")
                {
                }
                column(ItemNo_; "No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Unit_of_Measure_Code; "Unit of Measure Code") { }
                trigger OnPreDataItem();
                begin
                    if Article <> '' then SetRange("No.", Article);

                end;

                trigger OnAfterGetRecord();
                begin
                    Nombre := Nombre + 1;
                    if Article <> '' then SetRange("Purchase request Line"."No.", Article);
                    // RB SORO 17/09/2015
                    //   "Purchase request Line".CalcFields("Associated Purchase Order");
                    RecPurchaseLine.SetRange("Document No.", "Purchase request Line"."Associated Purchase Order");
                    RecPurchaseLine.SetRange("No.", "Purchase request Line"."No.");
                    //RecPurchaseLine.SETRANGE(Description,"Sales Line".Description);
                    if RecPurchaseLine.FindFirst then begin
                        QtReçue := RecPurchaseLine."Quantity Received";
                    end;
                    // RB SORO 17/09/2015

                    IF Vendor.GET("Vendor No.") THEN;

                    //if Entete.get("Sales Line"."Document No.") then;
                    //Aff := Entete."Job No.";
                    MakeExcelDataBody;
                    // IF ShippingAgent.GET("Purchase Request"."Requester ID") THEN;
                    // Demarcheur := ShippingAgent.Name;
                end;

            }
            trigger OnPreDataItem();
            begin
                FilterDate := "Purchase Request".GetFilter("Order Date");
                if FilterDate = '' then "Purchase Request".SetRange("Order Date", 0D, WorkDate);
                if StatusDA <> StatusDA::" " then
                    SetRange(Statut, StatusDA);

            end;

            trigger OnAfterGetRecord();
            begin
                Clear(Vehicule);
                if Vehicule.Get(Engin) then;
                i := 0;
                Commande[1] := '';
                Commande[2] := '';
                Commande[3] := '';
                Commande[4] := '';
                Commande[5] := '';
                PurchaseHeader.SetCurrentkey("N° Demande d'achat");
                PurchaseHeader.SetRange("N° Demande d'achat", "No.");
                PurchaseHeader.SetRange("Document Type", PurchaseHeader."document type"::Order);
                if PurchaseHeader.FindFirst then
                    repeat
                        i += 1;
                        Commande[i] := PurchaseHeader."No.";
                    until PurchaseHeader.Next = 0;
            end;

        }
    }
    requestpage
    {
        SaveValues = false;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(StatusDA; StatusDA)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Status';
                        ToolTip = 'Select the status of the purchase request to filter the report.';

                    }
                    field(Article; Article)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Article';
                        TableRelation = Item;
                    }
                    field(PrintToExcel; PrintToExcel)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Export excel';
                    }
                }
            }
        }

    }

    trigger OnPostReport()
    begin
        if PrintToExcel then
            CreateExcelbook;

    end;

    trigger OnPreReport()
    begin
        if PrintToExcel then
            MakeExcelInfo;


    end;

    trigger OnInitReport()
    begin

        StatusDA := StatusDA::" ";
    end;

    var
        StatusDA: Enum "Dys Purchase Request status";
        Nombre: Integer;
        Vendor: Record Vendor;
        Entete: Record "Sales Header";
        Aff: Text[30];
        Vehicu: Text[30];
        Demand: Text[30];
        AgentSaisie: Text[30];
        Article: Code[20];
        PrintToExcel: Boolean;
        TotalFor: label 'Total ';
        Text001: label 'Données';
        Text002: label 'Etat Mouvement Articles';
        Text003: label 'Nom de la société';
        Text004: label 'N° état';
        Text005: label 'Nom état';
        Text006: label 'Code utilisateur';
        Text007: label 'Date';
        ExcelBuf: Record "Excel Buffer" temporary;
        "QtReçue": Decimal;
        RecPurchaseLine: Record "Purchase Line";
        ShippingAgent: Record "Shipping Agent";
        Demarcheur: Text[100];
        PageConst: label 'Page';
        FilterDate: Text[10];
        Vehicule: Record "Véhicule";
        RecPurchaseentete: Record "Purch. Rcpt. Header";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        Commande: array[100] of Code[20];
        i: Integer;
        j: Integer;
        NumCommande: Code[20];
        LqteRecue: Decimal;

    procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(Format(Text003), false, true, false, false, '', 0);
        ExcelBuf.AddInfoColumn(COMPANYNAME, false, false, false, false, '', 0);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text005), false, true, false, false, '', 0);
        ExcelBuf.AddInfoColumn(Format(Text002), false, false, false, false, '', 0);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text004), false, true, false, false, '', 0);
        ExcelBuf.AddInfoColumn(Report::"Liste DA", false, false, false, false, '', 0);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text006), false, true, false, false, '', 0);
        ExcelBuf.AddInfoColumn(UserId, false, false, false, false, '', 0);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text007), false, true, false, false, '', 0);
        ExcelBuf.AddInfoColumn(Today, false, false, false, false, '', 0);
        //ExcelBuf.NewRow;
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Date', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('N° Document', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('N°', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Designation', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Quantité', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Unité', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Engin', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Designation', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Immatriculation', false, '', true, false, true, '', 0);
        for j := 1 to 5 do begin
            ExcelBuf.AddColumn('Commande Achat Associé N°', false, '', true, false, true, '', 0);
        end;
        ExcelBuf.AddColumn('Quantité Reçue', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Affaire', false, '', true, false, true, '', 0);
        ExcelBuf.AddColumn('Fournisseur', false, '', true, false, true, '', 0);
    end;

    local procedure MakeExcelDataHeader2()
    begin
    end;

    procedure MakeExcelDataBody()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Purchase Request"."Order Date", false, '', false, false, false, '', 0);
        ExcelBuf.AddColumn("Purchase request Line"."Document No.", false, '', false, false, false, '', 0);
        ExcelBuf.AddColumn("Purchase request Line"."No.", false, '', false, false, false, '', 0);
        ExcelBuf.AddColumn("Purchase request Line".Description, false, '', false, false, false, '', 0);
        ExcelBuf.AddColumn("Purchase request Line".Quantity, false, '', false, false, false, '', 0);
        ExcelBuf.AddColumn("Purchase request Line"."Unit of Measure", false, '', false, false, false, '', 0);
        ExcelBuf.AddColumn("Purchase Request".Engin, false, '', false, false, false, '', 0);
        ExcelBuf.AddColumn(Vehicule.Désignation, false, '', false, false, false, '', 0);
        ExcelBuf.AddColumn(Vehicule.Immatriculation, false, '', false, false, false, '', 0);
        for j := 1 to 5 do begin
            QtReçue := 0;
            if Commande[j] <> '' then begin
                NumCommande := Commande[j];
                Clear(PurchaseLine);
                PurchaseLine.SetRange("Document No.", Commande[j]);
                PurchaseLine.SetRange("No.", "Purchase request Line"."No.");
                if not PurchaseLine.FindFirst then
                    NumCommande := ''
                else begin
                    QtReçue := PurchaseLine."Quantity Received";
                    // message(format( QtReçue));
                end;
            end
            else begin
                NumCommande := '';
                Clear(PurchaseLine);
            end;
            ExcelBuf.AddColumn(NumCommande, false, '', true, false, true, '', 0);
            ExcelBuf.AddColumn(QtReçue, false, '', false, false, false, '', 0);
        end;
        ExcelBuf.AddColumn("Purchase Request"."Job No.", false, '', false, false, false, '', 0);
        ExcelBuf.AddColumn(Vendor.Name, false, '', false, false, false, '', 0);
        Clear(QtReçue);
    end;

    procedure CreateExcelbook()
    begin
        // ExcelBuf.CreateBook();
        // ExcelBuf.CreateSheet(Text001, Text002, COMPANYNAME, UserId);
        // ExcelBuf.GiveUserControl;
    end;



    local procedure OnPreSectionSalesLine_Body5(var "Sales Line": Record "Sales Line");
    begin
        with "Purchase request Line" do begin
            if Vendor.Get("Vendor No.") then;
            //if Entete.get("Sales Line"."Document No.") then;
            //Aff := Entete."Job No.";
            MakeExcelDataBody;
            if ShippingAgent.Get("Purchase Request"."Requester ID") then;
            Demarcheur := ShippingAgent.Name;
        end;
    end;
    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        //  ReportForNav: Codeunit "ForNAV Report Management";
        ReportForNavTotalsCausedBy: Integer;
        ReportForNavInitialized: Boolean;
        ReportForNavShowOutput: Boolean;





    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
