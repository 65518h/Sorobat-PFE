Codeunit 8001502 "Aggregate, Res. and G/L"
{
    //GL2024  ID dans Nav 2009 : "8001302"
    // #6572 SD 25/03/10
    // //+STA+ STATSEXPLORER 01/10/01 Statistic Aggregate, invoices and purchases resource and G/L
    // //+STA+ AC 03/05/07 Attention ce flux ne prend pas en compte l'affaire et la tache affaire pour éviter de doubler les chiffres
    //                     avec le flux vente affaire.


    trigger OnRun()
    begin
        //#6572
        if GuiAllowed then begin
            //#6572//
            Window.Open('#1##############################\\' +
                        Text002 +
                        Text003);
            Window.Update(1, Treatment);
            //#6572
        end;
        //#6572//
        StatisticsSetup.Get;
        StatsExplorerTools.CreateTypeArray(TextType, WorkType, SearchDim, PeriodBasis, LastEntryNo);
        if not StatisticAggregate1.IsEmpty then
            if StatisticAggregate1.FindLast then
                NextEntry := StatisticAggregate1."Entry No." + 1
            else
                NextEntry := 1;

        if DocumentType = Documenttype::All then begin
            if WorkType[5] then begin
                SearchSalesInvoice;
                SearchSalesCredit;
            end;
            if WorkType[10] then begin
                SearchPurchaseInvoice;
                SearchPurchaseCredit;
            end;
        end else begin
            if StatisticsSetup."Period total basis" <> StatisticsSetup."period total basis"::"According to every flow" then begin
                BasePeriod := StatisticsSetup."Period total basis";
                SearchEntry;
            end else begin
                repeat
                    i := i + 1;
                    if PeriodBasis[5, i] or PeriodBasis[10, i] or PeriodBasis[40, i] or PeriodBasis[45, i] or PeriodBasis[50, i] then begin
                        BasePeriod := i - 1;
                        SearchEntry;
                    end;
                until i = 5;
            end;
        end;
        //#6572
        if GuiAllowed then
            //#6572//
            Window.Close;
    end;

    var
        //GL2024 License "Object": Record "Object";
        //GL2024 License
        "Object": Record AllObj;
        //GL2024 License

        StatisticAggregate1: Record "Statistic aggregate";
        StatisticAggregate2: Record "Statistic aggregate";
        StatisticsSetup: Record "Statistics setup";
        "Code": Record Code;
        StatsExplorerTools: Codeunit "StatsExplorer, Tools";
        UpdateDefaultValues: Codeunit "Aggr., Update default values";
        Window: Dialog;
        TextType: array[100] of Text[30];
        WorkType: array[100] of Boolean;
        PeriodBasis: array[100, 6] of Boolean;
        StartDate: Date;
        EndDate: Date;
        BasePeriod: Option Day,Week,Month,Quarter,Year,Period;
        FieldEnabled: array[100, 250] of Boolean;
        SearchDim: array[100] of Boolean;
        Treatment: label 'Resource and ledger account';
        NbRead: Integer;
        NbCreated: Integer;
        NextEntry: Integer;
        DocumentType: Option All,"Sales invoice","Sales Credit","Purchase Invoice","Purchase Credit";
        DocumentNo: Code[20];
        LineNo: Integer;
        EntryNo: Integer;
        LastEntryNo: array[100] of Integer;
        i: Integer;
        Text002: label 'Read:                    #2#####\';
        Text003: label 'Created:                 #3#####\';


    procedure InitRequest(wStartDate: Date; wEndDate: Date; wBasePeriod: Option Day,Week,Month,Quarter,Year,Period; wDocumentType: Option All,"Sales invoice","Sales Credit","Purchase Invoice","Purchase Credit"; wDocumentNo: Code[20]; wLineNo: Integer)
    begin
        StartDate := wStartDate;
        EndDate := wEndDate;
        BasePeriod := wBasePeriod;
        DocumentType := wDocumentType;
        DocumentNo := wDocumentNo;
        LineNo := wLineNo;
    end;


    procedure SearchEntry()
    begin
        case DocumentType of
            Documenttype::"Sales invoice":
                if WorkType[5] then
                    SearchSalesInvoice;
            Documenttype::"Sales Credit":
                if WorkType[5] then
                    SearchSalesCredit;
            Documenttype::"Purchase Invoice":
                if WorkType[10] then
                    SearchPurchaseInvoice;
            Documenttype::"Purchase Credit":
                if WorkType[10] then
                    SearchPurchaseCredit;
        end;
    end;


    procedure SearchSalesInvoice()
    var
        InvoiceHeader: Record "Sales Invoice Header";
        InvoiceLine: Record "Sales Invoice Line";
        ArretTraitement: Boolean;
        StartD: Date;
        EndD: Date;
        i: Integer;
        Resultat: array[20] of Decimal;
    begin
        with InvoiceLine do begin
            InvoiceHeader.SetRange("Posting Date", StartDate, EndDate);
            if DocumentType <> Documenttype::All then begin
                InvoiceHeader.SetRange("No.", DocumentNo);
                SetRange("Document No.", DocumentNo);
                SetRange("Line No.", LineNo);
            end;

            if not InvoiceHeader.IsEmpty then begin
                InvoiceHeader.FindSet;
                repeat
                    NbRead := NbRead + 1;
                    //#6572
                    if GuiAllowed then
                        //#6572//
                        Window.Update(2, NbRead);
                    SetRange("Document No.", InvoiceHeader."No.");
                    SetFilter(Type, '%1|%2', Type::"G/L Account", Type::Resource);
                    if not IsEmpty then begin
                        FindSet;
                        repeat
                            NbRead := NbRead + 1;
                            //#6572
                            if GuiAllowed then
                                //#6572//
                                Window.Update(2, NbRead);
                            if (Quantity <> 0) or (Amount <> 0) or ("Unit Cost (LCY)" <> 0) then begin
                                StartD := StatsExplorerTools.StartDateCalc(BasePeriod, InvoiceHeader."Posting Date");
                                EndD := StatsExplorerTools.EndDateCalc(BasePeriod, InvoiceHeader."Posting Date");
                                StatisticAggregate1.Init;
                                StatisticAggregate1."Entry No." := NextEntry;
                                StatisticAggregate1."Period Length" := BasePeriod;
                                StatisticAggregate1."Ending Date" := EndD;
                                StatisticAggregate1."Entry Type" := TextType[5];
                                StatisticAggregate1.Type := Type - 1;
                                StatisticAggregate1."No." := "No.";
                                StatisticAggregate1."Source Type" := StatisticAggregate1."source type"::Customer;
                                StatisticAggregate1."Source No." := "Sell-to Customer No.";
                                StatisticAggregate1."Location Code" := "Location Code";
                                StatisticAggregate1."Source Posting Group" := InvoiceHeader."Customer Posting Group";
                                StatisticAggregate1."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
                                StatisticAggregate1."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
                                StatisticAggregate1."Salespers./Purch. Code" := InvoiceHeader."Salesperson Code";
                                StatisticAggregate1."Global Dimension 1 Code" := "Shortcut Dimension 1 Code";
                                StatisticAggregate1."Global Dimension 2 Code" := "Shortcut Dimension 2 Code";
                                StatisticAggregate1."Reason Code" := InvoiceHeader."Reason Code";
                                StatisticAggregate1."Variant Code" := "Variant Code";
                                StatisticAggregate1."Return Reason Code" := "Return Reason Code";
                                StatisticAggregate1."Campaign No." := InvoiceHeader."Campaign No.";
                                //#AC
                                StatisticAggregate1."Work Type Code" := "Work Type Code";
                                //#AC//
                                StatisticAggregate1.Quantity := Quantity;
                                if "Quantity (Base)" = 0 then
                                    "Quantity (Base)" := 1;
                                if InvoiceHeader."Currency Factor" = 0 then
                                    StatisticAggregate1.Amount := ROUND((Amount * StatisticAggregate1.Quantity) / "Quantity (Base)")
                                else
                                    StatisticAggregate1.Amount := ROUND((Amount * StatisticAggregate1.Quantity) / "Quantity (Base)" /
                                                                         InvoiceHeader."Currency Factor");
                                StatisticAggregate1.Cost := Quantity * "Unit Cost (LCY)";
                                UpdateDefaultValues.Run(StatisticAggregate1);
                                /*  GL2024  if SearchDim[5] then
                                        StatsExplorerTools.SearchPostedDocumentDimension(StatisticAggregate1, 113, "Document No.", "Line No.");*/
                                if not StatsExplorerTools.SearchAndModifyAggregate(StatisticAggregate1, StatisticAggregate2, SearchDim[5], 5) then begin
                                    StatisticAggregate1.Insert;
                                    NextEntry := NextEntry + 1;
                                    NbCreated := NbCreated + 1;
                                end;
                                //#6572
                                if GuiAllowed then
                                    //#6572//
                                    Window.Update(3, NbCreated);
                            end;
                        until InvoiceLine.Next = 0;
                    end;
                until InvoiceHeader.Next = 0;
            end;
        end;
    end;


    procedure SearchSalesCredit()
    var
        InvoiceHeader: Record "Sales Cr.Memo Header";
        InvoiceLine: Record "Sales Cr.Memo Line";
        ArretTraitement: Boolean;
        StartD: Date;
        EndD: Date;
        i: Integer;
    begin
        with InvoiceLine do begin
            InvoiceHeader.SetRange("Posting Date", StartDate, EndDate);
            if DocumentType <> Documenttype::All then begin
                InvoiceHeader.SetRange("No.", DocumentNo);
                SetRange("Document No.", DocumentNo);
                SetRange("Line No.", LineNo);
            end;
            if not InvoiceHeader.IsEmpty then begin
                InvoiceHeader.FindSet;
                repeat
                    NbRead := NbRead + 1;
                    //#6572
                    if GuiAllowed then
                        //#6572//
                        Window.Update(2, NbRead);
                    SetRange("Document No.", InvoiceHeader."No.");
                    SetFilter(Type, '%1|%2', Type::"G/L Account", Type::Resource);
                    if not IsEmpty then begin
                        FindSet;
                        repeat
                            if (Quantity <> 0) or (Amount <> 0) or ("Unit Cost (LCY)" <> 0) then begin
                                StartD := StatsExplorerTools.StartDateCalc(BasePeriod, InvoiceHeader."Posting Date");
                                EndD := StatsExplorerTools.EndDateCalc(BasePeriod, InvoiceHeader."Posting Date");
                                StatisticAggregate1.Init;
                                StatisticAggregate1."Entry No." := NextEntry;
                                StatisticAggregate1."Period Length" := BasePeriod;
                                StatisticAggregate1."Ending Date" := EndD;
                                StatisticAggregate1."Entry Type" := TextType[5];
                                StatisticAggregate1.Type := Type - 1;
                                StatisticAggregate1."No." := "No.";
                                StatisticAggregate1."Source Type" := StatisticAggregate1."source type"::Customer;
                                StatisticAggregate1."Source No." := "Sell-to Customer No.";
                                StatisticAggregate1."Location Code" := "Location Code";
                                StatisticAggregate1."Source Posting Group" := InvoiceHeader."Customer Posting Group";
                                StatisticAggregate1."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
                                StatisticAggregate1."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
                                StatisticAggregate1."Salespers./Purch. Code" := InvoiceHeader."Salesperson Code";
                                StatisticAggregate1."Global Dimension 1 Code" := "Shortcut Dimension 1 Code";
                                StatisticAggregate1."Global Dimension 2 Code" := "Shortcut Dimension 2 Code";
                                StatisticAggregate1."Reason Code" := InvoiceHeader."Reason Code";
                                StatisticAggregate1."Variant Code" := "Variant Code";
                                StatisticAggregate1."Return Reason Code" := "Return Reason Code";
                                StatisticAggregate1."Campaign No." := InvoiceHeader."Campaign No.";
                                //#AC
                                StatisticAggregate1."Work Type Code" := "Work Type Code";
                                //#AC//
                                StatisticAggregate1.Quantity := -Quantity;
                                if "Quantity (Base)" = 0 then
                                    "Quantity (Base)" := 1;
                                if InvoiceHeader."Currency Factor" = 0 then
                                    StatisticAggregate1.Amount := ROUND((Amount * StatisticAggregate1.Quantity) / "Quantity (Base)")
                                else
                                    StatisticAggregate1.Amount := ROUND((Amount * StatisticAggregate1.Quantity) / "Quantity (Base)" /
                                                                         InvoiceHeader."Currency Factor");
                                StatisticAggregate1.Cost := -Quantity * "Unit Cost (LCY)";
                                UpdateDefaultValues.Run(StatisticAggregate1);
                                /*  GL2024   if SearchDim[5] then
                                   StatsExplorerTools.SearchPostedDocumentDimension(StatisticAggregate1, 115, "Document No.", "Line No.");*/
                                if not StatsExplorerTools.SearchAndModifyAggregate(StatisticAggregate1, StatisticAggregate2, SearchDim[5], 5) then begin
                                    StatisticAggregate1.Insert;
                                    NextEntry := NextEntry + 1;
                                    NbCreated := NbCreated + 1;
                                end;
                                //#6572
                                if GuiAllowed then
                                    //#6572//
                                    Window.Update(3, NbCreated);
                            end;
                        until InvoiceLine.Next = 0;
                    end;
                until InvoiceHeader.Next = 0;
            end;
        end;
    end;


    procedure SearchPurchaseInvoice()
    var
        InvoiceHeader: Record "Purch. Inv. Header";
        InvoiceLine: Record "Purch. Inv. Line";
        ArretTraitement: Boolean;
        StartD: Date;
        EndD: Date;
        i: Integer;
        Resultat: array[20] of Decimal;
    begin
        with InvoiceLine do begin
            InvoiceHeader.SetRange("Posting Date", StartDate, EndDate);
            if DocumentType <> Documenttype::All then begin
                InvoiceHeader.SetRange("No.", DocumentNo);
                SetRange("Document No.", DocumentNo);
                SetRange("Line No.", LineNo);
            end;
            if not InvoiceHeader.IsEmpty then begin
                InvoiceHeader.FindSet;
                repeat
                    NbRead := NbRead + 1;
                    //#6572
                    if GuiAllowed then
                        //#6572//
                        Window.Update(2, NbRead);
                    SetRange("Document No.", InvoiceHeader."No.");
                    //GL2024 SetFilter(Type, '%1|%2', Type::"G/L Account", Type::"3");
                    SetFilter(Type, '%1|%2', Type::"G/L Account", Type::Resource);
                    if not IsEmpty then begin
                        FindSet;
                        repeat
                            if (Quantity <> 0) or (Amount <> 0) or ("Unit Cost (LCY)" <> 0) then begin
                                StartD := StatsExplorerTools.StartDateCalc(BasePeriod, InvoiceHeader."Posting Date");
                                EndD := StatsExplorerTools.EndDateCalc(BasePeriod, InvoiceHeader."Posting Date");
                                StatisticAggregate1.Init;
                                StatisticAggregate1."Entry No." := NextEntry;
                                StatisticAggregate1."Period Length" := BasePeriod;
                                StatisticAggregate1."Ending Date" := EndD;
                                StatisticAggregate1."Entry Type" := TextType[10];
                                StatisticAggregate1.Type := Type - 1;
                                StatisticAggregate1."No." := "No.";
                                StatisticAggregate1."Source Type" := StatisticAggregate1."source type"::Vendor;
                                StatisticAggregate1."Source No." := "Buy-from Vendor No.";
                                StatisticAggregate1."Location Code" := "Location Code";
                                StatisticAggregate1."Source Posting Group" := InvoiceHeader."Vendor Posting Group";
                                StatisticAggregate1."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
                                StatisticAggregate1."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
                                StatisticAggregate1."Salespers./Purch. Code" := InvoiceHeader."Purchaser Code";
                                StatisticAggregate1."Global Dimension 1 Code" := "Shortcut Dimension 1 Code";
                                StatisticAggregate1."Global Dimension 2 Code" := "Shortcut Dimension 2 Code";
                                StatisticAggregate1."Reason Code" := InvoiceHeader."Reason Code";
                                StatisticAggregate1."Variant Code" := "Variant Code";
                                StatisticAggregate1."Return Reason Code" := "Return Reason Code";
                                StatisticAggregate1.Quantity := Quantity;
                                if "Quantity (Base)" = 0 then
                                    "Quantity (Base)" := 1;
                                if InvoiceHeader."Currency Factor" = 0 then
                                    StatisticAggregate1.Amount := ROUND((Amount * StatisticAggregate1.Quantity) / "Quantity (Base)")
                                else
                                    StatisticAggregate1.Amount := ROUND((Amount * StatisticAggregate1.Quantity) / "Quantity (Base)" /
                                                                           InvoiceHeader."Currency Factor");
                                StatisticAggregate1.Cost := Quantity * "Unit Cost (LCY)";
                                UpdateDefaultValues.Run(StatisticAggregate1);
                                /*  GL2024  if SearchDim[10] then
                                    StatsExplorerTools.SearchPostedDocumentDimension(StatisticAggregate1, 123, "Document No.", "Line No.");*/
                                if not StatsExplorerTools.SearchAndModifyAggregate(StatisticAggregate1, StatisticAggregate2, SearchDim[10], 10) then begin
                                    StatisticAggregate1.Insert;
                                    NextEntry := NextEntry + 1;
                                    NbCreated := NbCreated + 1;
                                end;
                                //#6572
                                if GuiAllowed then
                                    //#6572//
                                    Window.Update(3, NbCreated);
                            end;
                        until InvoiceLine.Next = 0;
                    end;
                until InvoiceHeader.Next = 0;
            end;
        end;
    end;


    procedure SearchPurchaseCredit()
    var
        InvoiceHeader: Record "Purch. Cr. Memo Hdr.";
        InvoiceLine: Record "Purch. Cr. Memo Line";
        ArretTraitement: Boolean;
        StartD: Date;
        EndD: Date;
        i: Integer;
    begin
        with InvoiceLine do begin
            if DocumentType <> Documenttype::All then begin
                InvoiceHeader.SetRange("No.", DocumentNo);
                SetRange("Document No.", DocumentNo);
                SetRange("Line No.", LineNo);
            end;
            InvoiceHeader.SetRange("Posting Date", StartDate, EndDate);
            if not InvoiceHeader.IsEmpty then begin
                InvoiceHeader.FindSet;
                repeat
                    SetRange("Document No.", InvoiceHeader."No.");
                    //GL2024   SetFilter(Type, '%1|%2', Type::"G/L Account", Type::"3");
                    SetFilter(Type, '%1|%2', Type::"G/L Account", Type::Resource);
                    if not IsEmpty then begin
                        FindSet;
                        repeat
                            NbRead := NbRead + 1;
                            //#6572
                            if GuiAllowed then
                                //#6572//
                                Window.Update(2, NbRead);
                            if (Quantity <> 0) or (Amount <> 0) or ("Unit Cost (LCY)" <> 0) then begin
                                StartD := StatsExplorerTools.StartDateCalc(BasePeriod, InvoiceHeader."Posting Date");
                                EndD := StatsExplorerTools.EndDateCalc(BasePeriod, InvoiceHeader."Posting Date");
                                StatisticAggregate1.Init;
                                StatisticAggregate1."Entry No." := NextEntry;
                                StatisticAggregate1."Period Length" := BasePeriod;
                                StatisticAggregate1."Ending Date" := EndD;
                                StatisticAggregate1."Entry Type" := TextType[10];
                                StatisticAggregate1.Type := Type - 1;
                                StatisticAggregate1."No." := "No.";
                                StatisticAggregate1."Source Type" := StatisticAggregate1."source type"::Vendor;
                                StatisticAggregate1."Source No." := "Buy-from Vendor No.";
                                StatisticAggregate1."Location Code" := "Location Code";
                                StatisticAggregate1."Source Posting Group" := InvoiceHeader."Vendor Posting Group";
                                StatisticAggregate1."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
                                StatisticAggregate1."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
                                StatisticAggregate1."Salespers./Purch. Code" := InvoiceHeader."Purchaser Code";
                                StatisticAggregate1."Global Dimension 1 Code" := "Shortcut Dimension 1 Code";
                                StatisticAggregate1."Global Dimension 2 Code" := "Shortcut Dimension 2 Code";
                                StatisticAggregate1."Reason Code" := InvoiceHeader."Reason Code";
                                StatisticAggregate1."Variant Code" := "Variant Code";
                                StatisticAggregate1."Return Reason Code" := "Return Reason Code";
                                StatisticAggregate1.Quantity := -Quantity;
                                if "Quantity (Base)" = 0 then
                                    "Quantity (Base)" := 1;
                                if InvoiceHeader."Currency Factor" = 0 then
                                    StatisticAggregate1.Amount := ROUND((Amount * StatisticAggregate1.Quantity) / "Quantity (Base)")
                                else
                                    StatisticAggregate1.Amount := ROUND((Amount * StatisticAggregate1.Quantity) / "Quantity (Base)" /
                                                                         InvoiceHeader."Currency Factor");
                                StatisticAggregate1.Cost := -Quantity * "Unit Cost (LCY)";
                                /* GL2024 if SearchDim[10] then
                                      StatsExplorerTools.SearchPostedDocumentDimension(StatisticAggregate1, 125, "Document No.", "Line No.");*/
                                UpdateDefaultValues.Run(StatisticAggregate1);
                                if not StatsExplorerTools.SearchAndModifyAggregate(StatisticAggregate1, StatisticAggregate2, SearchDim[10], 10) then begin
                                    StatisticAggregate1.Insert;
                                    NextEntry := NextEntry + 1;
                                    NbCreated := NbCreated + 1;
                                end;
                                //#6572
                                if GuiAllowed then
                                    //#6572//
                                    Window.Update(3, NbCreated);
                            end;
                        until InvoiceLine.Next = 0;
                    end;
                until InvoiceHeader.Next = 0;
            end;
        end;
    end;
}

