Page 58000 "RTC Res. Gp Plan Matrix"
{


    Caption = 'RTC Res. Gp Plan Matrix';
    DeleteAllowed = false;
    InsertAllowed = false;
    MultipleNewLines = false;
    PageType = Card;
    SaveValues = true;
    SourceTable = "Resource Group";
    SourceTableView = sorting("No.");
    ApplicationArea = all;
    UsageCategory = Administration;


    layout
    {
        area(content)
        {
            group(Display)
            {
                Caption = 'Display';
                group(Control800390000)
                {
                    Caption = 'Display';
                    field(ShowOption; ShowOption)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show';
                        // DecimalPlaces = 0:2;
                        OptionCaption = 'Work Load (h),Description,,,Job Name,Job No.,Count,Capacity,Availability,Load %';

                        trigger OnValidate()
                        begin
                            //PeriodType := PeriodType::Day;
                            if ShowOption = Showoption::Availability then begin
                                RecFilters.CopyFilters(Rec);
                                //??  SETRANGE("Job Filter");
                            end else if xShowOption = Showoption::Availability then
                                    rec.CopyFilters(RecFilters);
                            xShowOption := ShowOption;
                            ShowOptionOnAfterValidate;
                        end;
                    }
                    field(HighLightJob; HighLightJob)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Highlight Job';
                        TableRelation = Job;

                        trigger OnValidate()
                        var
                            lPlanning: Record 8004130;
                        begin
                            //IF ShowOption = ShowOption::Availability THEN
                            //  ERROR(tFilterDisable);
                            lPlanning.SetFilter("Job No.", HighLightJob);
                        end;
                    }
                    field(HighLightProdPostingGroup; HighLightProdPostingGroup)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Highlight Prod. Posting Group';
                        TableRelation = "Gen. Product Posting Group";

                        trigger OnValidate()
                        var
                            lPlanning: Record 8004130;
                        begin
                            lPlanning.SetFilter("Prod. Posting Group", HighLightProdPostingGroup);
                            HighLightProdPostingGroupOnAft;
                        end;
                    }
                    field(HighLightQuantity; HighLightQuantity)
                    {
                        ApplicationArea = Basic;
                        Caption = 'HighLight Quantity';

                        trigger OnValidate()
                        var
                            lPlanning: Record 8004130;
                        begin
                            lPlanning.SetFilter(Quantity, HighLightQuantity);
                        end;
                    }
                }
                group(Allocation)
                {
                    Caption = 'Allocation';
                    field("Default.""Job No."""; Default."Job No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Job No.';
                    }
                    field("Default.Description"; Default.Description)
                    {
                        ApplicationArea = Basic;
                        // BlankZero = true;
                        Caption = 'Description';
                        // DecimalPlaces = 0:2;
                    }
                    field("Default.""No."""; Default."No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Resource No.';
                        TableRelation = Resource."No." where(Type = filter(Person | Machine));
                    }
                    field("Default.Quantity"; Default.Quantity)
                    {
                        ApplicationArea = Basic;
                        BlankZero = true;
                        Caption = 'Quantity';
                        DecimalPlaces = 0 : 2;
                    }
                }
            }
            group(Options)
            {
                Caption = 'Options';
                group("Lines Filters")
                {
                    Caption = 'Lines Filters';
                    field(ResourceTypeFilter; ResourceTypeFilter)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Resource Type';
                        // DecimalPlaces = 0:2;
                        OptionCaption = ' ,Person,Machine';

                        trigger OnValidate()
                        begin
                            if ResourceTypeFilter = 0 then
                                rec.SetRange(Type)
                            else
                                rec.SetRange(Type, ResourceTypeFilter - 1);
                            if rec.Find('-') then;
                        end;
                    }
                }
                group(Matrix)
                {
                    Caption = 'Matrix';
                    field(PeriodType; PeriodType)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Period';
                        OptionCaption = 'Day,Week,Month,Quarter,Year';

                        trigger OnValidate()
                        begin
                            SetColumns(Setwanted::Initial);
                        end;
                    }
                    field(ColumnSet; ColumnSet)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Column Set';
                        Editable = false;
                    }
                    field(QtyType; QtyType)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Balance Type';
                        OptionCaption = 'Net Change,Balance at Date';
                    }
                }
            }
            repeater(Control800390024)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Default Time per Day (h)"; rec."Default Time per Day (h)")
                {
                    ApplicationArea = Basic;
                }
                field("Planning Time (h)"; rec."Planning Time (h)")
                {
                    ApplicationArea = Basic;
                }
                field(Field1; ColumnValue[1])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MatrixColumnCaptions[1];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(1);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(1);
                        ColumnValue1OnAfterValidate;
                    end;
                }
                field(Field2; ColumnValue[2])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MatrixColumnCaptions[2];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(2);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(2);
                        ColumnValue2OnAfterValidate;
                    end;
                }
                field(Field3; ColumnValue[3])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MatrixColumnCaptions[3];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(3);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(3);
                        ColumnValue3OnAfterValidate;
                    end;
                }
                field(Field4; ColumnValue[4])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MatrixColumnCaptions[4];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(4);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(4);
                        ColumnValue4OnAfterValidate;
                    end;
                }
                field(Field5; ColumnValue[5])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MatrixColumnCaptions[5];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(5);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(5);
                        ColumnValue5OnAfterValidate;
                    end;
                }
                field(Field6; ColumnValue[6])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MatrixColumnCaptions[6];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(6);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(6);
                        ColumnValue6OnAfterValidate;
                    end;
                }
                field(Field7; ColumnValue[7])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MatrixColumnCaptions[7];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(7);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(7);
                        ColumnValue7OnAfterValidate;
                    end;
                }
                field(Field8; ColumnValue[8])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MatrixColumnCaptions[8];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(8);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(8);
                        ColumnValue8OnAfterValidate;
                    end;
                }
                field(Field9; ColumnValue[9])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MatrixColumnCaptions[9];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(9);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(9);
                        ColumnValue9OnAfterValidate;
                    end;
                }
                field(Field10; ColumnValue[10])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MatrixColumnCaptions[10];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(10);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(10);
                        ColumnValue10OnAfterValidate;
                    end;
                }
                field(Field11; ColumnValue[11])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MatrixColumnCaptions[11];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(11);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(11);
                        ColumnValue11OnAfterValidate;
                    end;
                }
                field(Field12; ColumnValue[12])
                {
                    ApplicationArea = Basic;
                    CaptionClass = '3,' + MatrixColumnCaptions[12];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(12);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(12);
                        ColumnValue12OnAfterValidate;
                    end;
                }
            }

        }
    }

    actions
    {
        area(Promoted)
        {
            group("Plan&ning1")
            {
                Caption = 'Plan&ning';
                actionref(Allocate11; Allocate1) { }
                actionref(Delete1; Delete) { }
                actionref(Cut1; Cut) { }
                actionref("Copy (&C)1"; "Copy (&C)") { }
                actionref(Paste11; Paste1) { }
                actionref("&Allocate1"; "&Allocate") { }
            }
            actionref("Previous Set1"; "Previous Set") { }
            actionref("Previous Column1"; "Previous Column") { }
            actionref("Next Column1"; "Next Column") { }
            actionref("Next Set1"; "Next Set") { }
        }
        area(navigation)
        {
            /*GL2024 group("Res. &Group")
             {
                 Caption = 'Res. &Group';
                 action(Resources)
                 {
                     ApplicationArea = Basic;
                     Caption = 'Resources';
                     RunFormLink = "Resource group No."="FIELD"(No.);
                     RunObject = Page 8004131;
                 }
             }*/
            group("Plan&ning")
            {
                Caption = 'Plan&ning';
                action(Allocate1)
                {
                    ApplicationArea = Basic;
                    Caption = 'Allocate';

                    trigger OnAction()
                    begin
                        if (gPeriodIndex <> 0) then
                            Paste(gPeriodIndex, Default)
                        else
                            Error(tSelectPeriod);
                    end;
                }
                action(Delete)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delete';

                    trigger OnAction()
                    var
                        lPlanning: Record 8004130;
                    begin
                        //SetCellFilters(lPlanning);
                        if lPlanning.Count <> 1 then
                            Error(tMustBeUnique, lPlanning.TableCaption);
                        lPlanning.Find('-');
                        lPlanning.Delete;
                    end;
                }
                action(Cut)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cut';
                    ShortCutKey = 'Shift+F4';

                    trigger OnAction()
                    var
                        lPlanning: Record 8004130;
                    begin
                        //SetCellFilters(lPlanning);
                        if lPlanning.Count <> 1 then
                            Error(tMustBeUnique, lPlanning.TableCaption);
                        lPlanning.Find('-');
                        HoldPlanning := lPlanning;
                        Cut := true;
                    end;
                }
                action("Copy (&C)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Copy (&C)';

                    trigger OnAction()
                    var
                        lPlanning: Record 8004130;
                    begin
                        //SetCellFilters(lPlanning);
                        if lPlanning.Count <> 1 then
                            Error(tMustBeUnique, lPlanning.TableCaption);
                        lPlanning.Find('-');
                        HoldPlanning := lPlanning;
                    end;
                }
                action(Paste1)
                {
                    ApplicationArea = Basic;
                    Caption = 'Paste';
                    ShortCutKey = 'Shift+F3';

                    trigger OnAction()
                    begin
                        if (gPeriodIndex <> 0) then begin
                            if Cut then begin
                                HoldPlanning.Delete;
                                Cut := false;
                            end;
                            Paste(gPeriodIndex, HoldPlanning)
                        end else
                            Error(tSelectPeriod);
                    end;
                }
                action("&Allocate")
                {
                    ApplicationArea = Basic;
                    Caption = '&Allocate';
                    ShortCutKey = 'Shift+Ctrl+L';

                    trigger OnAction()
                    begin
                        if (gPeriodIndex <> 0) then
                            Allocate(gPeriodIndex)
                        else
                            Error(tSelectPeriod);
                    end;
                }
            }
        }
        area(processing)
        {
            action("Previous Set")
            {
                ApplicationArea = Basic;
                Caption = 'Previous Set';
                Image = PreviousSet;

                ToolTip = 'Previous Set';

                trigger OnAction()
                begin
                    SetColumns(Setwanted::Previous);
                end;
            }
            action("Previous Column")
            {
                ApplicationArea = Basic;
                Caption = 'Previous Column';
                Image = PreviousRecord;

                ToolTip = 'Previous Column';

                trigger OnAction()
                begin
                    SetColumns(Setwanted::PreviousColumn);
                end;
            }
            action("Next Column")
            {
                ApplicationArea = Basic;
                Caption = 'Next Column';
                Image = NextRecord;

                ToolTip = 'Next Column';

                trigger OnAction()
                begin
                    SetColumns(Setwanted::NextColumn);
                end;
            }
            action("Next Set")
            {
                ApplicationArea = Basic;
                Caption = 'Next Set';
                Image = NextSet;

                ToolTip = 'Next Set';

                trigger OnAction()
                begin
                    SetColumns(Setwanted::Next);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        lIndex: Integer;
    begin
        lIndex := 0;
        while (lIndex < CurrSetLength) do begin
            lIndex += 1;
            MATRIX_OnAfterGetRecord(lIndex);
        end;
    end;

    trigger OnOpenPage()
    begin
        QtyType := Qtytype::"Net Change";
        PlanningMgt.Setup;
        xShowOption := ShowOption;

        gPeriodIndex := 0;

        SetColumns(Setwanted::Initial);
        //  Currpage.UPDATECONTROLS;
    end;

    var
        SalesLinePlanning: Record 8004130;
        Default: Record 8004130;
        HoldPlanning: Record 8004130;
        RecFilters: Record 152;
        PeriodFormMgt: Codeunit PeriodPageManagement;
        PlanningMgt: Codeunit 8004130;
        CalendarMgt: Codeunit 7600;
        PeriodType: Option Day,Week,Month,Quarter,Year;
        QtyType: Option "Net Change","Balance at Date";
        CellText: Text[250];
        HidePrivate: Boolean;
        ShowOption: Option Quantity,Description,"Resource Name","Resource No.","Job Name","Job No.","Count",Capacity,Availability,"Load %";
        tPeriodType: label 'Show mode must be in day period.';
        tMustBeUnique: label '%1 must be alone.';
        xShowOption: Integer;
        HighLightQuantity: Text[30];
        HighLightJob: Text[30];
        HighLightProdPostingGroup: Text[30];
        ResourceTypeFilter: Option " ",Person,Machine;
        Cut: Boolean;
        tFilterDisable: label 'Filtrers disable with current show option';
        tSyntaxError: label 'Syntax error';
        tDisableForShowOption: label 'Not enable for this showoption %1';
        "------": Integer;
        gMatrixPeriods: array[32] of Record Date;
        ColumnValue: array[12] of Text[255];
        MatrixColumnCaptions: array[32] of Text[1024];
        ColumnSet: Text[1024];
        CurrSetLength: Integer;
        SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        PKFirstRecInCurrSet: Text[100];
        gPeriodIndex: Integer;
        tSelectPeriod: label 'You must selected a period';

    local procedure SetDateFilter(pColumnID: Integer)
    begin
        if QtyType = Qtytype::"Net Change" then
            if gMatrixPeriods[pColumnID]."Period Start" = gMatrixPeriods[pColumnID]."Period End" then
                rec.SetRange("Date Filter", gMatrixPeriods[pColumnID]."Period Start")
            else
                rec.SetRange("Date Filter", gMatrixPeriods[pColumnID]."Period Start", gMatrixPeriods[pColumnID]."Period End")
        else
            rec.SetRange("Date Filter", 0D, gMatrixPeriods[pColumnID]."Period End");
    end;


    procedure SetCellFilters(pColumnID: Integer; var pPlanning: Record 8004130)
    begin
        pPlanning.SetCurrentkey("Resource Group No.", Date);
        //pPlanning.SETRANGE(Type,pPlanning.Type::Person);
        pPlanning.SetRange("Resource Group No.", rec."No.");
        if gMatrixPeriods[pColumnID]."Period Start" = gMatrixPeriods[pColumnID]."Period End" then
            pPlanning.SetRange(Date, gMatrixPeriods[pColumnID]."Period Start")
        else
            pPlanning.SetRange(Date, gMatrixPeriods[pColumnID]."Period Start", gMatrixPeriods[pColumnID]."Period End");
        //COPYFILTER("Job No. Filter",pPlanning."Job No.");
        //COPYFILTER("Prod. Posting Group Filter",pPlanning."Prod. Posting Group");
    end;


    procedure MatrixUpdate(pQtyType: Integer; pPeriodType: Integer)
    begin
        QtyType := pQtyType;
        PeriodType := pPeriodType;
        CurrPage.Update(false);
    end;


    procedure InitRequest(var pSalesLine: Record 37; pDate: Date)
    begin
        /*??
        SalesLinePlanning.VALIDATE("Job No.",pSalesLine."Job No.");
        SalesLinePlanning."Job Task No." := pSalesLine."Job Task No.";
        SalesLinePlanning."Sales Document Type" := pSalesLine."Document Type";
        SalesLinePlanning."Sales Document No." := pSalesLine."Document No.";
        SalesLinePlanning."Sales Line No." := pSalesLine."Line No.";
        SalesLinePlanning."Presentation Code" := pSalesLine."Presentation Code";
        SalesLinePlanning.Description := pSalesLine.Description;
        */
        //CurrForm.Matrix.MatrixRec."Period Start" := pDate;

    end;


    procedure Paste(pColumnID: Integer; pPlanning: Record 8004130)
    var
        lPlanning: Record 8004130;
        lPlanningQuantity: Record 8004130;
        lResCapacityEntry: Record 160;
    begin
        lPlanning := pPlanning;
        if rec.Type = rec.Type::Person then
            lPlanning.Type := lPlanning.Type::Person
        else
            lPlanning.Type := lPlanning.Type::Machine;
        lPlanning.Date := gMatrixPeriods[pColumnID]."Period Start";
        lPlanning."Resource Group No." := rec."No.";
        lPlanning."Prod. Posting Group" := rec."Gen. Prod. Posting Group";
        lPlanning."Job No." := Default."Job No.";
        PlanningMgt.CheckInsert(lPlanning, gMatrixPeriods[pColumnID]."Period Start", Default);
    end;


    procedure Allocate(pColumnID: Integer)
    begin
        //SalesLinePlanning.TESTFIELD("Sales Document No.");
        //IF PeriodType <> PeriodType::Day THEN
        //  ERROR(tPeriodType);
        SalesLinePlanning.Quantity := Default.Quantity;
        Paste(pColumnID, SalesLinePlanning);
    end;


    procedure SetColumns(pPeriodType: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MatrixMgt: Codeunit 9200;
        DateFilter: Text[30];
        lIndex: Integer;
    begin
        MatrixMgt.GeneratePeriodMatrixData(pPeriodType, ArrayLen(ColumnValue), false, PeriodType, '',
          PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, gMatrixPeriods);
        for lIndex := 1 to CurrSetLength do begin
            fFormatCaption(MatrixColumnCaptions[lIndex], gMatrixPeriods[lIndex]);
        end;
    end;

    local procedure MATRIX_OnAfterGetRecord(pColumnID: Integer)
    begin
        SetDateFilter(pColumnID);
        rec.CalcFields(Capacity, "Period Planning Time (h)");
        ColumnValue[pColumnID] := fCalcValue(pColumnID);
    end;


    procedure MatrixOnDrillDown(ColumnID: Integer)
    var
        lPlanning: Record 8004130;
    begin
        SetCellFilters(ColumnID, lPlanning);
        //GL2024  page.Run(page::"Planning Detail",lPlanning);
    end;


    procedure fCalcValue(pColumnID: Integer) Return: Text[255]
    var
        lPlanning: Record 8004130;
        lTemporary: Record 8004130 temporary;
        lForeColor: Integer;
        lFontBold: Boolean;
        lDecimal: Decimal;
        lOK: Boolean;
        lResLedgEntry: Record 203;
    begin
        if (PeriodType <> Periodtype::Day) or
          (ShowOption in [Showoption::Quantity, Showoption::Capacity, Showoption::Availability, Showoption::"Load %"]) then begin
            Return := '';
            case ShowOption of
                Showoption::Quantity:
                    lDecimal := rec."Period Planning Time (h)";
                Showoption::Capacity:
                    lDecimal := rec.Capacity;
                Showoption::Availability:
                    lDecimal := rec.Capacity - rec."Period Planning Time (h)";
                Showoption::"Load %":
                    if rec.Capacity <> 0 then
                        lDecimal := ROUND(rec."Period Planning Time (h)" / rec.Capacity * 100, 0.1)
                    else if rec."Period Planning Time (h)" <> 0 then
                        Return := Format(rec."Period Planning Time (h)") + '/0'
            end;
            if lDecimal <> 0 then
                if ShowOption = Showoption::"Load %" then
                    Return := Format(lDecimal) + '%'
                else if PeriodType <> Periodtype::Day then
                    Return := Format(lDecimal, 0, '<Precision,0:0><Standard Format,0>')
                else
                    Return := Format(lDecimal);
            if (HighLightQuantity <> '') and (Return <> '') then begin
                lTemporary.Quantity := lDecimal;
                lTemporary.Insert;
                lTemporary.SetFilter(Quantity, HighLightQuantity);
            end;
        end else begin
            SetCellFilters(pColumnID, lPlanning);

            if HidePrivate then
                lPlanning.SetRange(Private, false)
            else
                lPlanning.SetRange(Private);

            if lPlanning.IsEmpty then begin
            end
            else if ShowOption = Showoption::Count then
                Return := Format(lPlanning.Count)
            else
                Return := PlanningMgt.Description(lPlanning, lResLedgEntry, ShowOption, lForeColor, lFontBold, false);
        end;

        if (Return <> '') and ((HighLightJob <> '') or (HighLightProdPostingGroup <> '') or (HighLightQuantity <> '')) then begin
            SetCellFilters(pColumnID, lPlanning);
            if HighLightJob <> '' then
                lPlanning.SetFilter("Job No.", HighLightJob);
            if HighLightProdPostingGroup <> '' then
                lPlanning.SetFilter("Prod. Posting Group", HighLightProdPostingGroup);
            lOK := true;
            if (HighLightQuantity <> '') and (lDecimal <> 0) then
                lOK := lTemporary.Find('-');
        end;

        if (Return = '') and gMatrixPeriods[pColumnID].Mark then
            Return := '-----';
    end;


    procedure fSetPeriodIndex(pColumnID: Integer)
    begin
        gPeriodIndex := 0;
    end;


    procedure MatrixOnValidate(pColumnID: Integer)
    begin
        if ShowOption = Showoption::Capacity then
            Error(tDisableForShowOption);
        //SalesLinePlanning.TESTFIELD("Sales Document No.");
        //??IF (SalesLinePlanning."Sales Document No." = '') AND (SalesLinePlanning.Description = '') THEN
        SalesLinePlanning.Description := Default.Description;
        if ColumnValue[pColumnID] = '' then
            SalesLinePlanning.Quantity := Default.Quantity
        else
            Evaluate(SalesLinePlanning.Quantity, ColumnValue[pColumnID]);
        Paste(pColumnID, SalesLinePlanning);
    end;


    procedure fInitialiseValue(pColumnID: Integer)
    begin
        ColumnValue[pColumnID] := '';
    end;


    procedure fFormatCaption(var pCaption: Text[255]; var pDate: Record Date)
    var
        lForeColor: Integer;
    begin
        if PeriodType = Periodtype::Day then begin
            PlanningMgt.DateTitle(pDate, pCaption, lForeColor);
            if lForeColor <> 0 then begin
                pDate.Mark(true);
            end;
        end;
    end;















    local procedure ShowOptionOnAfterValidate()
    begin
        CurrPage.Update(false);
    end;

    local procedure HighLightProdPostingGroupOnAft()
    begin
        CurrPage.Update;
    end;

    local procedure ColumnValue1OnAfterValidate()
    begin
        fInitialiseValue(1);
    end;

    local procedure ColumnValue2OnAfterValidate()
    begin
        fInitialiseValue(2);
    end;

    local procedure ColumnValue3OnAfterValidate()
    begin
        fInitialiseValue(3);
    end;

    local procedure ColumnValue4OnAfterValidate()
    begin
        fInitialiseValue(4);
    end;

    local procedure ColumnValue5OnAfterValidate()
    begin
        fInitialiseValue(5);
    end;

    local procedure ColumnValue6OnAfterValidate()
    begin
        fInitialiseValue(6);
    end;

    local procedure ColumnValue7OnAfterValidate()
    begin
        fInitialiseValue(7);
    end;

    local procedure ColumnValue8OnAfterValidate()
    begin
        fInitialiseValue(8);
    end;

    local procedure ColumnValue9OnAfterValidate()
    begin
        fInitialiseValue(9);
    end;

    local procedure ColumnValue10OnAfterValidate()
    begin
        fInitialiseValue(10);
    end;

    local procedure ColumnValue11OnAfterValidate()
    begin
        fInitialiseValue(11);
    end;

    local procedure ColumnValue12OnAfterValidate()
    begin
        fInitialiseValue(12);
    end;

    local procedure NoOnActivate()
    begin
        fSetPeriodIndex(0);
    end;

    local procedure NameOnActivate()
    begin
        fSetPeriodIndex(0);
    end;

    local procedure DefaultTimeperDayhOnActivate()
    begin
        fSetPeriodIndex(0);
    end;

    local procedure PlanningTimehOnActivate()
    begin
        fSetPeriodIndex(0);
    end;

    local procedure ColumnValue1OnActivate()
    begin
        fSetPeriodIndex(1);
    end;

    local procedure ColumnValue2OnActivate()
    begin
        fSetPeriodIndex(2);
    end;

    local procedure ColumnValue3OnActivate()
    begin
        fSetPeriodIndex(3);
    end;

    local procedure ColumnValue4OnActivate()
    begin
        fSetPeriodIndex(4);
    end;

    local procedure ColumnValue5OnActivate()
    begin
        fSetPeriodIndex(5);
    end;

    local procedure ColumnValue6OnActivate()
    begin
        fSetPeriodIndex(6);
    end;

    local procedure ColumnValue7OnActivate()
    begin
        fSetPeriodIndex(7);
    end;

    local procedure ColumnValue8OnActivate()
    begin
        fSetPeriodIndex(8);
    end;

    local procedure ColumnValue9OnActivate()
    begin
        fSetPeriodIndex(9);
    end;

    local procedure ColumnValue10OnActivate()
    begin
        fSetPeriodIndex(10);
    end;

    local procedure ColumnValue11OnActivate()
    begin
        fSetPeriodIndex(11);
    end;

    local procedure ColumnValue12OnActivate()
    begin
        fSetPeriodIndex(12);
    end;
}

