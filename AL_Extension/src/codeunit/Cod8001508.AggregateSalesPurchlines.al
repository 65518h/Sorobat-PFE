Codeunit 8001508 "Aggregate, Sales/Purch. lines"
{
    //GL2024  ID dans Nav 2009 : "8001308"
    // //STATSEXPLORER STATSEXPLORER 01/10/01 Aggregate, Sales and Purchase lines
    // //STATSEXPLORER STATSEXPLORER 01/07/02 "Line Amount" and not "Amount" is now used for this aggregate
    //                    ML 17/11/06 Maj des critères statistiques des documents de vente


    trigger OnRun()
    begin
        //#6572
        if GuiAllowed then
            //#6572//
            Window.Open('#1##############################\\' +
                      Text002 +
                      Text003);

        StatsExplorerTools.CreateTypeArray(TextType, WorkType, SearchDim, PeriodBasis, LastEntryNo);
        StatisticAggregate1.Reset;

        if not StatisticAggregate1.IsEmpty then
            if StatisticAggregate1.FindLast then
                NextEntry := StatisticAggregate1."Entry No." + 1
            else
                NextEntry := 1;

        if WorkType[68] then
            SearchSales(68);
        if WorkType[69] then
            SearchSales(69);
        if WorkType[70] then
            SearchSales(70);
        if WorkType[71] then
            SearchSales(71);

        if WorkType[73] then
            SearchPurch(73);
        if WorkType[74] then
            SearchPurch(74);
        if WorkType[75] then
            SearchPurch(75);
        if WorkType[76] then
            SearchPurch(76);
        //#6572
        if GuiAllowed then
            //#6572//
            Window.Close;
    end;

    var
        StatisticAggregate1: Record "Statistic aggregate";
        StatisticAggregate2: Record "Statistic aggregate";
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
        SearchDim: array[100] of Boolean;
        FieldEnabled: array[100, 250] of Boolean;
        NbRead: Integer;
        NbCreated: Integer;
        NextEntry: Integer;
        LastEntryNo: array[100] of Integer;
        Text002: label 'Read:                    #2#####\';
        Text003: label 'Created:                 #3#####\';


    procedure InitRequest(wStartDate: Date; wEndDate: Date; wBasePeriod: Option Day,Week,Month,Quarter,Year,Period)
    begin
        //StartDate := wStartDate;
        EndDate := wEndDate;
        BasePeriod := wBasePeriod;
    end;


    procedure SearchSales(NoType: Integer)
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        StartD: Date;
        EndD: Date;
        i: Integer;
        Result: array[20] of Decimal;
        QtyStat: Decimal;
        lSalesHeaderTmp: Record "Sales Header" temporary;
        lPostingDate: Date;
    begin
        //#6572
        if GuiAllowed then
            //#6572//
            Window.Update(1, SalesLine.TableCaption + ', ' + TextType[NoType]);
        NbCreated := 0;
        with SalesLine do begin
            SetFilter(Type, '<>%1', Type::" ");
            //#7840

            lSalesHeaderTmp.DeleteAll;

            case NoType of
                68:
                    SalesHeader.SetFilter("Document Type", '%1', "document type"::Quote);
                69:
                    SalesHeader.SetFilter("Document Type", '%1', "document type"::"Blanket Order");
                70, 71:
                    SalesHeader.SetFilter("Document Type", '%1|%2|%3', "document type"::Order, "document type"::Invoice,
                                          "document type"::"Credit Memo");
            end;

            if not SalesHeader.IsEmpty then begin
                SalesHeader.FindSet;
                repeat
                    lSalesHeaderTmp := SalesHeader;
                    lSalesHeaderTmp.Insert;
                until SalesHeader.Next = 0;
            end;

            lSalesHeaderTmp.SetRange("Posting Date", 0D);
            if not lSalesHeaderTmp.IsEmpty then begin
                lSalesHeaderTmp.FindFirst;
                repeat
                    if lSalesHeaderTmp."Document Date" <> 0D then
                        lSalesHeaderTmp."Posting Date" := lSalesHeaderTmp."Document Date"
                    else
                        if lSalesHeaderTmp."Order Date" <> 0D then
                            lSalesHeaderTmp."Posting Date" := lSalesHeaderTmp."Order Date"
                        else
                            lSalesHeaderTmp."Posting Date" := WorkDate;
                    lSalesHeaderTmp.Modify;
                until lSalesHeaderTmp.Next = 0;
            end;

            lSalesHeaderTmp.SetRange("Posting Date", StartDate, EndDate);

            if not lSalesHeaderTmp.IsEmpty then begin
                lSalesHeaderTmp.FindFirst;
                repeat
                    SetRange("Document Type", lSalesHeaderTmp."Document Type");
                    SetRange("Document No.", lSalesHeaderTmp."No.");
                    if not IsEmpty then begin
                        FindFirst;
                        repeat
                            NbRead := NbRead + 1;
                            //#6572
                            if GuiAllowed then
                                //#6572//
                                Window.Update(2, NbRead);
                            QtyStat := 0;
                            case NoType of
                                68, 69:
                                    if ("Quantity (Base)" <> 0) and ("Shipment No." = '') then
                                        QtyStat := "Quantity (Base)";
                                70:
                                    if ("Outstanding Qty. (Base)" <> 0) and ("Shipment No." = '') then
                                        QtyStat := "Outstanding Qty. (Base)";
                                71:
                                    if ("Qty. Shipped Not Invd. (Base)" <> 0) and ("Shipment No." = '') then
                                        QtyStat := "Qty. Shipped Not Invd. (Base)";
                            end;

                            if (QtyStat <> 0) then begin
                                //#7308
                                lPostingDate := fGetPostingDate(lSalesHeaderTmp, SalesLine);
                                StartD := StatsExplorerTools.StartDateCalc(BasePeriod, lPostingDate);
                                EndD := StatsExplorerTools.EndDateCalc(BasePeriod, lPostingDate);
                                //StartD := StatsExplorerTools.StartDateCalc(BasePeriod,lSalesHeaderTmp."Posting Date");
                                //EndD := StatsExplorerTools.EndDateCalc(BasePeriod,lSalesHeaderTmp."Posting Date");
                                //#7308//
                                StatisticAggregate1.Init;
                                StatisticAggregate1."Entry No." := NextEntry;
                                StatisticAggregate1."Period Length" := BasePeriod;
                                StatisticAggregate1."Ending Date" := EndD;
                                StatisticAggregate1."Entry Type" := TextType[NoType];
                                StatisticAggregate1.Type := Type - 1;
                                StatisticAggregate1."No." := "No.";
                                StatisticAggregate1."Source Type" := StatisticAggregate1."source type"::Customer;
                                StatisticAggregate1."Source No." := "Sell-to Customer No.";
                                StatisticAggregate1."Location Code" := "Location Code";
                                StatisticAggregate1."Source Posting Group" := lSalesHeaderTmp."Customer Posting Group";
                                StatisticAggregate1."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
                                StatisticAggregate1."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
                                StatisticAggregate1."Salespers./Purch. Code" := lSalesHeaderTmp."Salesperson Code";
                                StatisticAggregate1."Global Dimension 1 Code" := "Shortcut Dimension 1 Code";
                                StatisticAggregate1."Global Dimension 2 Code" := "Shortcut Dimension 2 Code";
                                StatisticAggregate1."Reason Code" := lSalesHeaderTmp."Reason Code";
                                StatisticAggregate1."Job No." := "Job No.";
                                StatisticAggregate1."Job Task Code" := "Job Task No.";
                                StatisticAggregate1."Work Type Code" := "Work Type Code";
                                StatisticAggregate1."Campaign No." := lSalesHeaderTmp."Campaign No.";
                                //DEVIS
                                StatisticAggregate1."Job criteria 1" := lSalesHeaderTmp."Criteria 1";
                                StatisticAggregate1."Job criteria 2" := lSalesHeaderTmp."Criteria 2";
                                StatisticAggregate1."Job criteria 3" := lSalesHeaderTmp."Criteria 3";
                                StatisticAggregate1."Job criteria 4" := lSalesHeaderTmp."Criteria 4";
                                StatisticAggregate1."Job criteria 5" := lSalesHeaderTmp."Criteria 5";
                                StatisticAggregate1."Job criteria 6" := lSalesHeaderTmp."Criteria 6";
                                StatisticAggregate1."Job criteria 7" := lSalesHeaderTmp."Criteria 7";
                                StatisticAggregate1."Job criteria 8" := lSalesHeaderTmp."Criteria 8";
                                StatisticAggregate1."Job criteria 9" := lSalesHeaderTmp."Criteria 9";
                                StatisticAggregate1."Job criteria 10" := lSalesHeaderTmp."Criteria 10";
                                //DEVIS//
                                if "Document Type" <> "document type"::"Credit Memo" then
                                    StatisticAggregate1.Quantity := QtyStat
                                else
                                    StatisticAggregate1.Quantity := -QtyStat;
                                if "Quantity (Base)" = 0 then
                                    "Quantity (Base)" := 1;
                                if lSalesHeaderTmp."Currency Factor" = 0 then
                                    StatisticAggregate1.Amount := ROUND(("Line Amount" * StatisticAggregate1.Quantity) / "Quantity (Base)")
                                else
                                    StatisticAggregate1.Amount := ROUND(("Line Amount" * StatisticAggregate1.Quantity) /
                                                                         "Quantity (Base)" / lSalesHeaderTmp."Currency Factor");
                                StatisticAggregate1.Cost := StatisticAggregate1.Quantity * "Unit Cost (LCY)";

                                UpdateDefaultValues.Run(StatisticAggregate1);
                                if SearchDim[NoType] then
                                    //GL2024     StatsExplorerTools.SearchDocumentDimension(StatisticAggregate1, 37, "Document Type", "Document No.", "Line No.");
                                    if not StatsExplorerTools.SearchAndModifyAggregate(StatisticAggregate1, StatisticAggregate2, SearchDim[NoType], NoType)
                                   then begin
                                        StatisticAggregate1.Insert;
                                        NextEntry := NextEntry + 1;
                                        NbCreated := NbCreated + 1;
                                    end;
                                //#6572
                                if GuiAllowed then
                                    //#6572//
                                    Window.Update(3, NbCreated);
                            end;
                        until SalesLine.Next = 0;
                    end;
                until lSalesHeaderTmp.Next = 0;
            end;
        end;
    end;


    procedure SearchPurch(NoType: Integer)
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        StartD: Date;
        EndD: Date;
        i: Integer;
        Result: array[20] of Decimal;
        QtyStat: Decimal;
        lPurchHeaderTmp: Record "Purchase Header" temporary;
        lPostingDate: Date;
    begin
        //#6572
        if GuiAllowed then
            //#6572//
            Window.Update(1, PurchaseLine.TableCaption + ', ' + TextType[NoType]);
        NbCreated := 0;
        with PurchaseLine do begin
            SetFilter(Type, '<>%1', Type::" ");

            //#7840
            lPurchHeaderTmp.DeleteAll;

            case NoType of
                73:
                    PurchaseHeader.SetFilter("Document Type", '%1', "document type"::Quote);
                74:
                    PurchaseHeader.SetFilter("Document Type", '%1', "document type"::"Blanket Order");
                75, 76:
                    PurchaseHeader.SetFilter("Document Type", '%1|%2|%3', "document type"::Order, "document type"::Invoice,
                    "document type"::"Credit Memo");
            end;

            if not PurchaseHeader.IsEmpty then begin
                PurchaseHeader.FindSet;
                repeat
                    lPurchHeaderTmp := PurchaseHeader;
                    //#8526
                    lPurchHeaderTmp.Insert;
                //#8526//
                until PurchaseHeader.Next = 0;
            end;

            lPurchHeaderTmp.SetRange("Posting Date", 0D);
            if not lPurchHeaderTmp.IsEmpty then begin
                lPurchHeaderTmp.FindFirst;
                repeat
                    if lPurchHeaderTmp."Document Date" <> 0D then
                        lPurchHeaderTmp."Posting Date" := lPurchHeaderTmp."Document Date"
                    else
                        if lPurchHeaderTmp."Order Date" <> 0D then
                            lPurchHeaderTmp."Posting Date" := lPurchHeaderTmp."Order Date"
                        else
                            lPurchHeaderTmp."Posting Date" := WorkDate;
                    lPurchHeaderTmp.Modify;
                until lPurchHeaderTmp.Next = 0;
            end;

            lPurchHeaderTmp.SetRange("Posting Date", StartDate, EndDate);

            if not lPurchHeaderTmp.IsEmpty then begin
                lPurchHeaderTmp.FindFirst;
                repeat
                    SetRange("Document Type", lPurchHeaderTmp."Document Type");
                    SetRange("Document No.", lPurchHeaderTmp."No.");
                    if not IsEmpty then begin
                        FindFirst;
                        repeat
                            NbRead := NbRead + 1;
                            //#6572
                            if GuiAllowed then
                                //#6572//
                                Window.Update(2, NbRead);
                            QtyStat := 0;
                            case NoType of
                                73, 74:
                                    if ("Quantity (Base)" <> 0) and ("Receipt No." = '') then
                                        QtyStat := "Quantity (Base)";
                                75:
                                    if ("Outstanding Qty. (Base)" <> 0) and ("Receipt No." = '') then
                                        QtyStat := "Outstanding Qty. (Base)";
                                76:
                                    if ("Qty. Rcd. Not Invoiced (Base)" <> 0) and ("Receipt No." = '') then
                                        QtyStat := "Qty. Rcd. Not Invoiced (Base)";
                            end;

                            if (QtyStat <> 0) then begin
                                //#7308
                                lPostingDate := fGetPurchPostingDate(lPurchHeaderTmp, PurchaseLine);
                                StartD := StatsExplorerTools.StartDateCalc(BasePeriod, lPostingDate);
                                EndD := StatsExplorerTools.EndDateCalc(BasePeriod, lPostingDate);
                                //StartD := StatsExplorerTools.StartDateCalc(BasePeriod,lPurchHeaderTmp."Posting Date");
                                //EndD := StatsExplorerTools.EndDateCalc(BasePeriod,lPurchHeaderTmp."Posting Date");
                                //#7308//

                                StatisticAggregate1.Init;
                                StatisticAggregate1."Entry No." := NextEntry;
                                StatisticAggregate1."Period Length" := BasePeriod;
                                StatisticAggregate1."Ending Date" := EndD;
                                StatisticAggregate1."Entry Type" := TextType[NoType];
                                StatisticAggregate1.Type := Type - 1;
                                StatisticAggregate1."No." := "No.";
                                StatisticAggregate1."Source Type" := StatisticAggregate1."source type"::Vendor;
                                StatisticAggregate1."Source No." := "Buy-from Vendor No.";
                                StatisticAggregate1."Location Code" := "Location Code";

                                StatisticAggregate1."Source Posting Group" := lPurchHeaderTmp."Vendor Posting Group";
                                StatisticAggregate1."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
                                StatisticAggregate1."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
                                StatisticAggregate1."Salespers./Purch. Code" := lPurchHeaderTmp."Purchaser Code";
                                StatisticAggregate1."Global Dimension 1 Code" := "Shortcut Dimension 1 Code";
                                StatisticAggregate1."Global Dimension 2 Code" := "Shortcut Dimension 2 Code";
                                StatisticAggregate1."Reason Code" := lPurchHeaderTmp."Reason Code";
                                StatisticAggregate1."Job No." := "Job No.";
                                StatisticAggregate1."Job Task Code" := "Job Task No.";
                                StatisticAggregate1."Campaign No." := lPurchHeaderTmp."Campaign No.";
                                if "Document Type" <> "document type"::"Credit Memo" then
                                    StatisticAggregate1.Quantity := QtyStat
                                else
                                    StatisticAggregate1.Quantity := -QtyStat;
                                if "Quantity (Base)" = 0 then
                                    "Quantity (Base)" := 1;
                                if lPurchHeaderTmp."Currency Factor" = 0 then
                                    StatisticAggregate1.Amount := ROUND(("Line Amount" * StatisticAggregate1.Quantity) / "Quantity (Base)")
                                else
                                    StatisticAggregate1.Amount := ROUND(("Line Amount" * StatisticAggregate1.Quantity) /
                                                                         "Quantity (Base)" / lPurchHeaderTmp."Currency Factor");
                                StatisticAggregate1.Cost := StatisticAggregate1.Quantity * "Unit Cost (LCY)";
                                UpdateDefaultValues.Run(StatisticAggregate1);
                                if SearchDim[NoType] then
                                    //GL2024    StatsExplorerTools.SearchDocumentDimension(StatisticAggregate1, 39, "Document Type", "Document No.", "Line No.");
                                    if not StatsExplorerTools.SearchAndModifyAggregate(StatisticAggregate1, StatisticAggregate2, SearchDim[NoType], NoType)
                                   then begin
                                        StatisticAggregate1.Insert;
                                        NextEntry := NextEntry + 1;
                                        NbCreated := NbCreated + 1;
                                    end;
                                //#6572
                                if GuiAllowed then
                                    //#6572//
                                    Window.Update(3, NbCreated);
                            end;
                        until PurchaseLine.Next = 0;
                    end;
                until lPurchHeaderTmp.Next = 0;
            end;
        end;
    end;


    procedure fGetPostingDate(pSalesHeader: Record "Sales Header"; pSalesLine: Record "Sales Line") retour: Date
    begin
        //#7308
        //#8663
        if ((pSalesHeader."Order Date" <> pSalesLine."Order Date") and
           (pSalesLine."Order Date" <> 0D)) then begin
            //#8663//
            retour := pSalesLine."Order Date";
        end else begin
            retour := pSalesHeader."Order Date";
        end;
        //#7308//
    end;


    procedure fGetPurchPostingDate(pPurchHeader: Record "Purchase Header"; pPurchLine: Record "Purchase Line") retour: Date
    begin
        //#7308
        //#8663
        if (pPurchHeader."Order Date" = 0D) or
           ((pPurchHeader."Order Date" <> pPurchLine."Order Date") and
           (pPurchLine."Order Date" <> 0D)) then begin
            //#8663//
            retour := pPurchHeader."Posting Date";
        end else begin
            retour := pPurchHeader."Order Date";
        end;
        //#7308//
    end;
}

