Page 58004 "RTC Job Planning Matrix"
{
    // #8225 AC 15/09/10
    // //PLANNING GESWAY 12/02/04 Planning affaire (inspiré du form 221)

    Caption = 'Planning affaire';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SaveValues = true;
    SourceTable = Job;
    SourceTableView = where(Status = filter(<> Completed));

    layout
    {
        area(content)
        {
            group(Display)
            {
                Caption = 'Affichage';
                field(ShowOption; ShowOption)
                {
                    ApplicationArea = Basic;
                    Caption = 'Afficher';
                    //GL2024 DecimalPlaces = 0 : 2;
                    OptionCaption = 'Quantity,Description,Resource Name,Resource No.,Count';
                }
                field("Resource Gr. Filter"; rec."Resource Gr. Filter")
                {
                    Caption = 'Filtre gpe ressources';
                    ApplicationArea = Basic;
                }
                field("Resource Filter"; rec."Resource Filter")
                {
                    Caption = 'Filtre ressource';
                    ApplicationArea = Basic;
                }
            }
            group(Allocation)
            {
                Caption = 'Affectation';
                field("Default.Type"; Default.Type)
                {
                    ApplicationArea = Basic;
                    Caption = 'Type de ressource';
                    OptionCaption = 'Homme,Matériel';

                    trigger OnValidate()
                    begin
                        DefaultTypeOnAfterValidate;
                    end;
                }
                field("Default.""No."""; Default."No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'N° ressource';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        wInitResourceFilter;
                        wResource.SetRange(Blocked, false);
                        if wResource.Get(Default."No.") then;
                        if page.RunModal(page::"Resource List", wResource) = Action::LookupOK then
                            Default."No." := wResource."No.";
                        ValidateResource;
                    end;

                    trigger OnValidate()
                    begin
                        DefaultNoOnAfterValidate;
                    end;
                }
                field("Default.""Prod. Posting Group"""; Default."Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                    Caption = 'Code nature';
                    TableRelation = "Gen. Product Posting Group";
                }
                field("Default.Quantity"; Default.Quantity)
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    Caption = 'Quantité';
                    DecimalPlaces = 0 : 2;
                }
                field("Default.Description"; Default.Description)
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    Caption = 'Désignation';
                    //GL2024      DecimalPlaces = 0 : 2;
                }
            }
            group("Options Matrix")
            {
                Caption = 'Options';
                field(PeriodType; PeriodType)
                {
                    ApplicationArea = Basic;
                    Caption = 'Période';
                    OptionCaption = 'Jour,Semaine,Mois,Trimestre,Année';

                    trigger OnValidate()
                    begin
                        SetColumns(Setwanted::Initial);
                    end;
                }
                field(ColumnSet; ColumnSet)
                {
                    ApplicationArea = Basic;
                    Caption = 'Période';
                    Editable = false;
                }
                field(QtyType; QtyType)
                {
                    ApplicationArea = Basic;
                    Caption = 'Type de quantité';
                    OptionCaption = 'Net Change,Balance at Date';
                }
            }
            repeater(Control800390010)
            {
                ShowCaption = false;
                field("No."; rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bill-to Name"; rec."Bill-to Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Person Responsible"; rec."Person Responsible")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Job Posting Group"; rec."Job Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Posted Quantity (Base)"; rec."Posted Quantity (Base)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(gQtyPlanning; gQtyPlanning)
                {
                    ApplicationArea = Basic;
                    Caption = 'Qté à planifier';
                    Editable = false;
                }
                field("Planning Quantity"; rec."Planning Quantity")
                {
                    ApplicationArea = Basic;
                    DrillDown = false;
                    Editable = true;
                    Visible = false;
                }
                field("Starting Date"; rec."Starting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Ending Date"; rec."Ending Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
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
                        MatrixValidate(1);
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
                        MatrixValidate(2);
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
                        MatrixValidate(3);
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
                        MatrixValidate(4);
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
                        MatrixValidate(5);
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
                        MatrixValidate(6);
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
                        MatrixValidate(7);
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
                        MatrixValidate(8);
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
                        MatrixValidate(9);
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
                        MatrixValidate(10);
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
                        MatrixValidate(11);
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
                }
            }

        }
    }

    actions
    {
        area(Promoted)
        {
            group("&Job1")
            {
                Caption = '&Affaire';

                actionref("Co&mments1"; "Co&mments") { }
                actionref(Dimensions1; Dimensions) { }
            }

            group("Plan&ning1")
            {
                Caption = 'Plan&ning';
                actionref(Allocate11; Allocate) { }
                actionref(Delete1; Delete) { }
                actionref(Cut1; Cut) { }
                actionref("Copy (&C)1"; "Copy (&C)") { }
                actionref(Paste11; Paste1) { }

            }
            group("F&unctions1")
            {
                Caption = 'F&onctions';
                actionref("Resource Allocation1"; "Resource Allocation") { }
            }



            actionref("Previous Set1"; "Previous Set") { }
            actionref("Previous Column1"; "Previous Column") { }
            actionref("Next Column1"; "Next Column") { }
            actionref("Next Set1"; "Next Set") { }
        }
        area(navigation)
        {
            group("&Job")
            {
                Caption = '&Affaire';
                /*GL2024    action(Card)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Card';
                        Image = EditLines;
                        RunpageLink = "No."=FIELD("No."),
                                      Resource "Filter"=FIELD(Resource "Filter"),
                                      Posting "Date Filter"=FIELD(Posting "Date Filter"),
                                      Resource Gr. "Filter"=FIELD(Resource Gr. "Filter");
                        RunObject = Page 8004160;
                    }
                    action(Statistics)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Statistics';
                        Image = Statistics;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunpageLink = "No."=FIELD("No.");
                        RunObject = Page 8004195;
                    }*/
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunpageLink = "Table Name" = CONST(Job),
                                  Code = FIELD("No.");
                    RunObject = Page "Comment Sheet";
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunpageLink = "Table ID" = CONST(8004160),
                                  "No." = FIELD("No.");
                    RunObject = Page "Default Dimensions";
                }
                /*GL2024   action("Ledger E&ntries")
                   {
                       ApplicationArea = Basic;
                       Caption = 'Ledger E&ntries';
                       RunpageLink = "Job No."=FIELD("No.");
                       RunpageView = SORTING("Job No.","Posting Date");
                       RunObject = Page 8004162;
                   }*/
            }
            group("Plan&ning")
            {
                Caption = 'Plan&ning';
                action(Allocate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Insérer';

                    trigger OnAction()
                    begin
                        if (gColumnIndex <> 0) then
                            Paste(gColumnIndex, Default)
                        else
                            Error(tErrPeriod);
                    end;
                }
                action(Delete)
                {
                    ApplicationArea = Basic;
                    Caption = 'Supprimer';

                    trigger OnAction()
                    var
                        lPlanning: Record 8004130;
                    begin
                        if (gColumnIndex <> 0) then begin
                            SetCellFilters(gColumnIndex, lPlanning);
                            if lPlanning.Count <> 1 then
                                Error(tMustBeUnique, lPlanning.TableCaption);
                            lPlanning.Find('-');
                            lPlanning.Delete;
                        end else begin
                            Error(tErrPeriod);
                        end;
                    end;
                }
                action(Cut)
                {
                    ApplicationArea = Basic;
                    Caption = 'Couper';

                    trigger OnAction()
                    var
                        lPlanning: Record 8004130;
                    begin
                        if (gColumnIndex <> 0) then begin
                            SetCellFilters(gColumnIndex, lPlanning);
                            if lPlanning.Count <> 1 then
                                Error(tMustBeUnique, lPlanning.TableCaption);
                            lPlanning.Find('-');
                            HoldPlanning := lPlanning;
                            Cut := true;
                        end else begin
                            Error(tErrPeriod);
                        end;
                    end;
                }
                action("Copy (&C)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Copier';

                    trigger OnAction()
                    var
                        lPlanning: Record 8004130;
                    begin
                        if (gColumnIndex <> 0) then begin
                            SetCellFilters(gColumnIndex, lPlanning);
                            if lPlanning.Count <> 1 then
                                Error(tMustBeUnique, lPlanning.TableCaption);
                            lPlanning.Find('-');
                            HoldPlanning := lPlanning;
                        end else begin
                            Error(tErrPeriod);
                        end;
                    end;
                }
                action(Paste1)
                {
                    ApplicationArea = Basic;
                    Caption = 'Coller';

                    trigger OnAction()
                    begin
                        if (gColumnIndex <> 0) then begin
                            if Cut then begin
                                HoldPlanning.Delete;
                                Cut := false;
                            end;
                            Paste(gColumnIndex, HoldPlanning);
                        end else begin
                            Error(tErrPeriod);
                        end;
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'Fonction&s';
                /*GL2024  action(Print)
                  {
                      ApplicationArea = Basic;
                      Caption = 'Imprimer';
                      Ellipsis = true;
                      Image = Print;

                      trigger OnAction()
                      var
                          lRec: Record 8004130;
                          lPlanning: Report 8004132;
                      begin
                          lRec.SetRange("Job No.", "No.");
                          lPlanning.SetTableview(lRec);
                          lPlanning.RunModal;
                      end;
                  }*/
                action("Resource Allocation")
                {
                    ApplicationArea = Basic;
                    Caption = 'Affecter ressources';

                    trigger OnAction()
                    var
                        lSalesLine: Record 37;
                    //GL2024 lResourcePlanning: Page 8004131;
                    begin
                        //lSalesLine."Job No." := "No.";
                        //lSalesLine.Description := Description;
                        //lResourcePlanning.InitRequest(lSalesLine,CurrForm.Matrix.MatrixRec."Period Start");
                        case Default.Type of
                            Default.Type::Person:
                                wResource.SetRange(Type, wResource.Type::Person);
                            Default.Type::Machine:
                                wResource.SetRange(Type, wResource.Type::Machine);
                        end;
                        /*
                        CASE ResourceStatusFilter OF
                          ResourceStatusFilter::Internal :wResource.SETRANGE(Status,wResource.Status::"0");
                          ResourceStatusFilter::External :wResource.SETRANGE(Status,wResource.Status::"1");
                          ResourceStatusFilter::Generic :wResource.SETRANGE(Status,wResource.Status::"2");
                          ELSE wResource.SETRANGE(Status);
                        END;
                        */
                        //GL2024    lResourcePlanning.InitFilters(wResource);
                        //GL2024   lResourcePlanning.RunModal;

                    end;
                }
            }
            action("Previous Set")
            {
                ApplicationArea = Basic;
                Caption = 'Période précédente';
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
                Caption = 'Colonne précédente';
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
                Caption = 'Colonne Suivante';
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
                Caption = 'Période suivante';
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
        wJob.SetPosition(rec.GetPosition);
        wJob.CalcFields("Posted Quantity (Base)", "Period Planning Quantity");
        rec.CalcFields("Posted Quantity (Base)", "Period Planning Quantity");
        gQtyPlanning := rec."Posted Quantity (Base)" - rec."Period Planning Quantity";

        lIndex := 0;
        while (lIndex < CurrSetLength) do begin
            lIndex += 1;
            MATRIX_OnAfterGetRecord(lIndex);
        end;
        OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        QtyType := Qtytype::"Net Change";
        PlanningMgt.Setup;
        wResource.SetRange(Type, Default.Type);

        gColumnIndex := 0;

        SetColumns(Setwanted::Initial);
    end;

    var
        Default: Record 8004130;
        HoldPlanning: Record 8004130;
        PeriodFormMgt: Codeunit PeriodPageManagement;
        PlanningMgt: Codeunit 8004130;
        CalendarMgt: Codeunit "Calendar Management";
        PeriodType: Option Day,Week,Month,Quarter,Year,FiscalYear;
        QtyType: Option "Net Change","Balance at Date";
        ShowOption: Option Quantity,Description,"Resource Name","Resource No.","Job Name","Job No.","Count",Capacity,Availability,"Load %";
        CellText: Text[1000];
        tMustBeUnique: label '%1 doit être unique.';
        Cut: Boolean;
        wResource: Record 156;
        ResourceStatusFilter: Option " ",Internal,External,Generic;
        ForeColor: Integer;
        FontBold: Boolean;
        wJob: Record job;
        "-----": Integer;
        gQtyPlanning: Decimal;
        ColumnValue: array[12] of Text[255];
        gMatrixPeriods: array[32] of Record Date;
        MatrixColumnCaptions: array[32] of Text[1024];
        ColumnSet: Text[1024];
        CurrSetLength: Integer;
        SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        PKFirstRecInCurrSet: Text[100];
        gColumnIndex: Integer;
        tErrPeriod: label 'Vous devez sélectionner une période';
        gForeColor: array[32] of Integer;
        gFontBold: array[32] of Boolean;

    local procedure SetDateFilter(pColumnID: Integer)
    begin
        with wJob do
            if QtyType = Qtytype::"Net Change" then
                if gMatrixPeriods[pColumnID]."Period Start" = gMatrixPeriods[pColumnID]."Period End" then
                    SetRange("Planning Date Filter", gMatrixPeriods[pColumnID]."Period Start")
                else
                    SetRange("Planning Date Filter", gMatrixPeriods[pColumnID]."Period Start", gMatrixPeriods[pColumnID]."Period End")
            else
                SetRange("Planning Date Filter", 0D, gMatrixPeriods[pColumnID]."Period End");
    end;


    procedure SetCellFilters(pColumnID: Integer; var pPlanning: Record 8004130)
    begin
        pPlanning.Reset;
        pPlanning.SetCurrentkey("Job No.", Type, "No.", Date);
        pPlanning.SetRange("Job No.", rec."No.");
        if gMatrixPeriods[pColumnID]."Period Start" = gMatrixPeriods[pColumnID]."Period End" then
            pPlanning.SetRange(Date, gMatrixPeriods[pColumnID]."Period Start")
        else
            pPlanning.SetRange(Date, gMatrixPeriods[pColumnID]."Period Start", gMatrixPeriods[pColumnID]."Period End");
        /*
        IF GETFILTER("Gen. Prod Posting Group Filter") <> '' THEN
          COPYFILTER("Gen. Prod Posting Group Filter",pPlanning."Prod. Posting Group");
        */
        if rec.GetFilter("Resource Gr. Filter") <> '' then
            rec.Copyfilter("Resource Gr. Filter", pPlanning."Resource Group No.");
        if rec.GetFilter("Resource Filter") <> '' then
            rec.Copyfilter("Resource Filter", pPlanning."No.");

    end;


    procedure MatrixUpdate(pQtyType: Integer; pPeriodType: Integer)
    begin
        QtyType := pQtyType;
        PeriodType := pPeriodType;
        CurrPage.Update(false);
    end;


    procedure Paste(pColumnID: Integer; pPlanning: Record 8004130)
    var
        lPlanning: Record 8004130;
        lDate: Date;
    begin
        lPlanning := pPlanning;
        lPlanning.Date := gMatrixPeriods[pColumnID]."Period Start";

        lPlanning.Validate("Job No.", rec."No.");
        lPlanning.Validate("No.");
        if lPlanning.Description = '' then
            lPlanning.Description := rec.Description;
        PlanningMgt.CheckInsert(lPlanning, gMatrixPeriods[pColumnID]."Period Start", Default);
    end;


    procedure ValidateResource()
    var
        lResource: Record 156;
    begin
        if lResource.Get(Default."No.") and (lResource."Gen. Prod. Posting Group" <> '') then begin
            Default."Prod. Posting Group" := lResource."Gen. Prod. Posting Group";
            Default."Resource Group No." := lResource."Resource Group No.";
        end else begin
            Default."Prod. Posting Group" := '';
            Default."Resource Group No." := '';
        end;
        Default.Validate("No.");
    end;


    procedure wFormatField()
    begin
        ForeColor := 0;
        //??FontBold := Summarize;
    end;


    procedure wInitResourceFilter()
    begin
        wResource.Init;
        case Default.Type of
            Default.Type::Person:
                wResource.SetRange(Type, wResource.Type::Person);
            Default.Type::Machine:
                wResource.SetRange(Type, wResource.Type::Machine);
        end;
        if Default."No." <> '' then
            wResource.Validate("No.", Default."No.");
    end;


    procedure SetColumns(pPeriodType: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MatrixMgt: Codeunit "Matrix Management";
        DateFilter: Text[30];
        lIndex: Integer;
    begin
        MatrixMgt.GeneratePeriodMatrixData(pPeriodType, ArrayLen(ColumnValue), false, PeriodType, '',
          PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, gMatrixPeriods);
        for lIndex := 1 to CurrSetLength do begin
            fFormatCaption(MatrixColumnCaptions[lIndex], gMatrixPeriods[lIndex]);
        end;
    end;

    local procedure MATRIX_OnAfterGetRecord(ColumnID: Integer)
    begin
        SetDateFilter(ColumnID);
        wJob.CalcFields("Period Planning Quantity");
        ColumnValue[ColumnID] := fSetValue(ColumnID, gForeColor[ColumnID], gFontBold[ColumnID]);
    end;


    procedure fSetValue(pColumnID: Integer; var pForeColor: Integer; var pFontBold: Boolean) Return: Text[1024]
    var
        lPlanning: Record 8004130;
        lResLedgEntry: Record 203;
    begin
        if (PeriodType <> Periodtype::Day) or (ShowOption = Showoption::Quantity) then begin
            rec.Copyfilter("Resource Filter", wJob."Resource Filter");
            if wJob."Period Planning Quantity" <> 0 then begin
                if PeriodType <> Periodtype::Day then
                    Return := Format(wJob."Period Planning Quantity", 0, '<Precision,0:0><Standard Format,0>')
                else
                    Return := Format(wJob."Period Planning Quantity");
            end;
        end else begin
            SetCellFilters(pColumnID, lPlanning);
            if lPlanning.IsEmpty then begin
            end
            else if ShowOption = Showoption::Count then
                Return := Format(lPlanning.Count)
            else
                Return := PlanningMgt.Description(lPlanning, lResLedgEntry, ShowOption, pForeColor, pFontBold, false);
        end;
        if (Return = '') and gMatrixPeriods[pColumnID].Mark then
            Return := '-----';
    end;


    procedure MatrixValidate(pColumnID: Integer)
    var
        lPlanning: Record 8004130;
        lQuantity: Decimal;
    begin
        if ColumnValue[pColumnID] = '' then
            lQuantity := 0
        else
            Evaluate(lQuantity, ColumnValue[pColumnID]);

        if (lQuantity <> 0) then begin
            lPlanning := Default;
            if ColumnValue[pColumnID] = '' then
                lPlanning.Quantity := Default.Quantity
            else
                Evaluate(lPlanning.Quantity, ColumnValue[pColumnID]);
            if lPlanning."No." = '' then
                lPlanning."No." := Default."No.";
            Paste(pColumnID, lPlanning);
        end;
        //#6891//
    end;


    procedure MatrixOnAfterValidate(pColumnID: Integer)
    begin
        ColumnValue[pColumnID] := '';
    end;


    procedure MatrixActivate(pColumnID: Integer)
    begin
        gColumnIndex := pColumnID
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


    procedure MatrixOnDrillDown(pColumnID: Integer)
    var
        lPlanningTemp: Record 8004130 temporary;

    begin
        SetCellFilters(pColumnID, lPlanningTemp);
        if Default.Quantity <> 0 then
            lPlanningTemp.SetRange(Quantity, Default.Quantity);
        if Default.Description <> '' then
            lPlanningTemp.SetRange(Description, Default.Description);
        //GL2024  page.Run(page::"Planning Detail", lPlanningTemp);
        CurrPage.Update;
    end;

    local procedure DefaultNoOnAfterValidate()
    var
        lResource: Record 156;
    begin
        ValidateResource;
    end;

    local procedure DefaultTypeOnAfterValidate()
    var
        lResource: Record 156;
        lOptionType: Option;
    begin
        lOptionType := Default.Type;
        Default.Init;
        Default.Validate(Type, lOptionType);
        wResource.SetRange(Type, Default.Type);
    end;

    local procedure ColumnValue1OnAfterValidate()
    begin
        MatrixOnAfterValidate(1);
    end;

    local procedure ColumnValue2OnAfterValidate()
    begin
        MatrixOnAfterValidate(2);
    end;

    local procedure ColumnValue3OnAfterValidate()
    begin
        MatrixOnAfterValidate(3);
    end;

    local procedure ColumnValue4OnAfterValidate()
    begin
        MatrixOnAfterValidate(4);
    end;

    local procedure ColumnValue5OnAfterValidate()
    begin
        MatrixOnAfterValidate(6);
    end;

    local procedure ColumnValue6OnAfterValidate()
    begin
        MatrixOnAfterValidate(6);
    end;

    local procedure ColumnValue7OnAfterValidate()
    begin
        MatrixOnAfterValidate(7);
    end;

    local procedure ColumnValue8OnAfterValidate()
    begin
        MatrixOnAfterValidate(8);
    end;

    local procedure ColumnValue9OnAfterValidate()
    begin
        MatrixOnAfterValidate(9);
    end;

    local procedure ColumnValue10OnAfterValidate()
    begin
        MatrixOnAfterValidate(10);
    end;

    local procedure ColumnValue11OnAfterValidate()
    begin
        MatrixOnAfterValidate(11);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        wJob.SetPosition(rec.GetPosition);
        wJob.CalcFields("Posted Quantity (Base)", "Period Planning Quantity");
    end;

    local procedure NoOnActivate()
    begin
        MatrixActivate(0);
    end;

    local procedure BilltoNameOnActivate()
    begin
        MatrixActivate(0);
    end;

    local procedure DescriptionOnActivate()
    begin
        MatrixActivate(0);
    end;

    local procedure PersonResponsibleOnActivate()
    begin
        MatrixActivate(0);
    end;

    local procedure JobPostingGroupOnActivate()
    begin
        MatrixActivate(0);
    end;

    local procedure PostedQuantityBaseOnActivate()
    begin
        MatrixActivate(0);
    end;

    local procedure gQtyPlanningOnActivate()
    begin
        MatrixActivate(0);
    end;

    local procedure PlanningQuantityOnActivate()
    begin
        MatrixActivate(0);
    end;

    local procedure StartingDateOnActivate()
    begin
        MatrixActivate(0);
    end;

    local procedure EndingDateOnActivate()
    begin
        MatrixActivate(0);
    end;

    local procedure ColumnValue1OnActivate()
    begin
        MatrixActivate(1);
    end;

    local procedure ColumnValue2OnActivate()
    begin
        MatrixActivate(2);
    end;

    local procedure ColumnValue3OnActivate()
    begin
        MatrixActivate(3);
    end;

    local procedure ColumnValue4OnActivate()
    begin
        MatrixActivate(4);
    end;

    local procedure ColumnValue5OnActivate()
    begin
        MatrixActivate(5);
    end;

    local procedure ColumnValue6OnActivate()
    begin
        MatrixActivate(6);
    end;

    local procedure ColumnValue7OnActivate()
    begin
        MatrixActivate(7);
    end;

    local procedure ColumnValue8OnActivate()
    begin
        MatrixActivate(8);
    end;

    local procedure ColumnValue9OnActivate()
    begin
        MatrixActivate(9);
    end;

    local procedure ColumnValue10OnActivate()
    begin
        MatrixActivate(10);
    end;

    local procedure ColumnValue11OnActivate()
    begin
        MatrixActivate(11);
    end;
}

