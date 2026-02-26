Page 58024 "RTC Res. Work Type Analysis"
{
    // //POINTAGE CW 04/12/04 Contrôle pointage par type de travail

    Caption = 'RTC Res. Work Type Analysis';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SaveValues = true;
    SourceTable = 200;
    SourceTableView = sorting("Work Time Type", Code);
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                group(Display)
                {
                    Caption = 'Display';
                    field(ShowOption; ShowOption)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show';
                        // DecimalPlaces = 0:2;
                        OptionCaption = 'Both,Posted,Job Journal Line';

                        trigger OnValidate()
                        begin
                            /*
                            PeriodType := PeriodType::Day;
                            IF ShowOption = ShowOption::Availability THEN BEGIN
                              RecFilters.COPYFILTERS(Rec);
                              SETRANGE("Job No. Filter");
                            //  SETRANGE("Phase Filter");
                            //  SETRANGE("Task Filter");
                            //  SETRANGE("Step Filter");
                              SETRANGE("Prod. Posting Group Filter");
                            END ELSE IF xShowOption = ShowOption::Availability THEN
                              COPYFILTERS(RecFilters);
                            END ELSE BEGIN
                              IF RecFilters."Job No. Filter" <> '' THEN
                                SETRANGE("Job No. Filter",RecFilters."Job No. Filter");
                            //  SETRANGE("Phase Filter",RecFilters."Phase Filter");
                            //  SETRANGE("Task Filter",RecFilters."Task Filter");
                            //  SETRANGE("Step Filter",RecFilters."Step Filter");
                              IF RecFilters."Prod. Posting Group Filter" <> '' THEN
                                SETRANGE("Prod. Posting Group Filter",RecFilters."Prod. Posting Group Filter");
                            END;
                            */
                            xShowOption := ShowOption;
                            ShowOptionOnAfterValidate;

                        end;
                    }
                    field("Resource Filter"; rec."Resource Filter")
                    {
                        ApplicationArea = Basic;

                        trigger OnValidate()
                        begin
                            ResourceFilterOnAfterValidate;
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
                        TableRelation = "Gen. Product Posting Group" where("Resource Type" = filter(<> " "));

                        trigger OnValidate()
                        var
                            lPlanning: Record 8004130;
                        begin
                            lPlanning.SetFilter("Prod. Posting Group", HighLightProdPostingGroup);
                            CurrPage.UPDATE;
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
                        TableRelation = Job;

                        trigger OnValidate()
                        var
                            lJob: Record job;
                        begin
                            if lJob.Get(Default."Job No.") then
                                Default.Description := lJob."Description 2";
                        end;
                    }
                    field("Default.Description"; Default.Description)
                    {
                        ApplicationArea = Basic;
                        //BlankZero = true;
                        Caption = 'Description';
                        // DecimalPlaces = 0:2;
                    }
                    field("Default.""Posting Group"""; Default."Posting Group")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Prod. Posting Group';
                        TableRelation = "Gen. Product Posting Group" where("Resource Type" = filter(<> " "));
                    }
                    field("Default.Quantity"; Default.Quantity)
                    {
                        ApplicationArea = Basic;
                        //BlankZero = true;
                        Caption = 'Quantity';
                        DecimalPlaces = 0 : 2;
                    }
                }
            }
            group(Filters)
            {
                Caption = 'Filters';
                group("Lines Filters")
                {
                    Caption = 'Lines Filters';
                    field(TypeFilter; TypeFilter)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Type';
                        //  DecimalPlaces = 0:2;
                        OptionCaption = ' ,Producted Hours,Unproduced Hours,Absence Hours,Premium,Transport,Meal';

                        trigger OnValidate()
                        begin
                            if TypeFilter = 0 then
                                rec.SetRange("Work Time Type")
                            else
                                rec.SetRange("Work Time Type", TypeFilter);
                            TypeFilterOnAfterValidate;
                        end;
                    }
                }
                group("Matrix Options")
                {
                    Caption = 'Matrix Options';
                    field(PeriodType; PeriodType)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Period';
                        OptionCaption = 'Day,Week,Month,Quarter,Year,Accounting Period';

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
                        Caption = 'Quantity Type';
                        OptionCaption = 'Net Change,Balance at Date';
                    }
                }
            }
            repeater(Control800390014)
            {
                ShowCaption = false;
                field("Work Time Type"; rec."Work Time Type")
                {
                    ApplicationArea = Basic;
                }
                field("Code"; rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = Basic;
                }
                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[1];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(1);
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[2];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(2);
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[3];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(3);
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[4];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(4);
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[5];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(5);
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[6];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(6);
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[7];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(7);
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[8];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(8);
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[9];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(9);
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[10];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(10);
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[11];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(11);
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[12];
                    DrillDown = false;
                    Editable = false;
                    MultiLine = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(12);
                    end;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[13];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(13);
                    end;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[14];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(14);
                    end;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[15];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(15);
                    end;
                }
                field(Field16; MATRIX_CellData[15])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[16];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(16);
                    end;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[17];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(17);
                    end;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[18];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(18);
                    end;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[19];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(19);
                    end;
                }
                field(Field20; MATRIX_CellData[20])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[20];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(20);
                    end;
                }
                field(Field21; MATRIX_CellData[21])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[21];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(21);
                    end;
                }
                field(Field22; MATRIX_CellData[22])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[22];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(22);
                    end;
                }
                field(Field23; MATRIX_CellData[23])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[23];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(23);
                    end;
                }
                field(Field24; MATRIX_CellData[24])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[24];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(24);
                    end;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[25];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(25);
                    end;
                }
                field(Field26; MATRIX_CellData[26])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[26];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(26);
                    end;
                }
                field(Field27; MATRIX_CellData[27])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[27];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(27);
                    end;
                }
                field(Field28; MATRIX_CellData[28])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[28];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(28);
                    end;
                }
                field(Field29; MATRIX_CellData[29])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[29];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(29);
                    end;
                }
                field(Field30; MATRIX_CellData[30])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[30];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(30);
                    end;
                }
                field(Field31; MATRIX_CellData[31])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[31];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(31);
                    end;
                }
                field(Field32; MATRIX_CellData[32])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[32];
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(32);
                    end;
                }
            }

        }
    }

    actions
    {
        area(Promoted)
        {
            group("&Resource1")
            {
                Caption = '&Resource';
                actionref(Card1; Card) { }
                actionref(Statistics1; Statistics) { }
                actionref("Co&mments1"; "Co&mments") { }
                actionref(Dimensions1; Dimensions) { }
            }

            group("Plan&ning1")
            {
                Caption = 'Plan&ning';
                actionref(Delete1; Delete) { }
                actionref(Cut1; Cut) { }
                actionref("Copy (&C)1"; "Copy (&C)") { }
            }

            actionref("Previous Set1"; "Previous Set") { }
            actionref("Previous Column1"; "Previous Column") { }
            actionref("Next Column1"; "Next Column") { }
            actionref("Next Set1"; "Next Set") { }
        }
        area(navigation)
        {
            group("&Resource")
            {
                Caption = '&Resource';
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = EditLines;
                    RunPageLink = "No." = FIELD("Resource Filter"), "Date Filter" = FIELD("Date Filter");
                    RunObject = Page 76;
                    ShortCutKey = 'Shift+F7';
                }
                action(Statistics)
                {
                    ApplicationArea = Basic;
                    Caption = 'Statistics';
                    Image = Statistics;

                    RunPageLink = "No." = FIELD("Resource Filter"), "Date Filter" = FIELD("Date Filter");
                    RunObject = Page 223;
                    ShortCutKey = 'F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunPageLink = "Table Name" = CONST(Resource), Code = FIELD("Resource Filter");
                    RunObject = Page 124;
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunPageLink = "Table ID" = CONST(156), "No." = FIELD("Resource Filter");
                    RunObject = Page 540;
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                /*GL2024   action("Ledger E&ntries")
                   {
                       ApplicationArea = Basic;
                       Caption = 'Ledger E&ntries';
                       RunPageLink = "No." = FIELD("Resource Filter");
                       RunpageView = SORTING(Type, "No.", "Posting Date", "Job No.", "Work Type Code") WHERE(Type = CONST(Resource));
                       RunObject = Page 8004162;
                   }
                   action(Availability)
                   {
                       ApplicationArea = Basic;
                       Caption = 'Availability';
                       RunPageLink = "No." = FIELD("Resource Filter");
                       RunObject = Page 8004171;
                       ShortCutKey = 'Ctrl+F7';
                   }*/
            }
            group("Plan&ning")
            {
                Caption = 'Plan&ning';
                action(Delete)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delete';

                    trigger OnAction()
                    var
                        lRec: record 210;
                    begin
                        if (gCellActive <= 0) and (gCellActive > CurrSetLength) then
                            exit;

                        SetCellFilters(gCellActive, lRec);
                        if lRec.Count <> 1 then
                            Error(tMustBeUnique, lRec.TableCaption);
                        lRec.Find('-');
                        lRec.Delete;
                    end;
                }
                action(Cut)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cut';
                    ShortCutKey = 'Shift+F4';

                    trigger OnAction()
                    var
                        lRec: record 210;
                    begin
                        if (gCellActive <= 0) and (gCellActive > CurrSetLength) then
                            exit;

                        SetCellFilters(gCellActive, lRec);
                        if lRec.Count <> 1 then
                            Error(tMustBeUnique, lRec.TableCaption);
                        lRec.Find('-');
                        Hold := lRec;
                        Cut := true;
                    end;
                }
                action("Copy (&C)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Copy (&C)';

                    trigger OnAction()
                    var
                        lRec: record 210;
                    begin
                        if (gCellActive <= 0) and (gCellActive > CurrSetLength) then
                            exit;

                        SetCellFilters(gCellActive, lRec);
                        if lRec.Count <> 1 then
                            Error(tMustBeUnique, lRec.TableCaption);
                        lRec.Find('-');
                        Hold := lRec;
                    end;
                }
            }
        }
        area(processing)
        {
            /*GL2024 group("F&unctions")
             {
                 Caption = 'F&unctions';
                 action("P&ost")
                 {
                     ApplicationArea = Basic;
                     Caption = 'P&ost';
                     Image = Post;
                     Promoted = true;
                     PromotedCategory = Process;
                     PromotedIsBig = true;
                     ShortCutKey = 'F9';

                     trigger OnAction()
                     var
                         lPlanningPosting: Report 8004130;
                     begin
                         lPlanningPosting.RunModal;
                         CurrPage.Update;
                     end;
                 }
             }*/
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
        fInitialise();

        SetColumns(Setwanted::Initial);
    end;

    var
        Default: record 210;
        Hold: record 210;
        RecFilters: Record 156;
        PlanningSetup: Record 8004133;
        TempJobJnlLine: record 210 temporary;
        PeriodFormMgt: Codeunit PeriodPageManagement;
        PlanningMgt: Codeunit 8004130;
        CalendarMgt: Codeunit 7600;
        CreateJobJnlLine: Codeunit 8004000;
        PeriodType: Option Day,Week,Month,Quarter,Year;
        QtyType: Option "Net Change","Balance at Date";
        ShowOption: Option Both,PostedQuantity,JournalLineQuantity;
        ResourceStatusFilter: Option " ",Internal,External,Generic;
        TypeFilter: Option " ","Producted Hours","Unproduced Hours","Absence Hours",Premium,Transport,Meal;
        HidePrivate: Boolean;
        tPeriodType: label 'Show mode must be in day period.';
        tMustBeUnique: label '%1 must be alone.';
        Cut: Boolean;
        xShowOption: Integer;
        CellText: Text[250];
        HighLightQuantity: Text[30];
        HighLightJob: Text[30];
        HighLightProdPostingGroup: Text[30];
        ResProdPostGroupFilter: Text[80];
        tFilterDisable: label 'Filtrers disable with current show option';
        tSyntaxError: label 'Syntax error';
        tDisableForShowOption: label 'Not enable for this showoption %1';
        PeriodStart: Date;
        PeriodEnd: Date;
        PlanningQty: Decimal;
        "-----": Integer;
        gMatrixPeriods: array[32] of Record Date;
        MatrixColumnCaptions: array[32] of Text[1024];
        ColumnSet: Text[1024];
        CurrSetLength: Integer;
        SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        PKFirstRecInCurrSet: Text[100];
        MatrixBoldValue: array[32] of Boolean;
        MATRIX_CellData: array[32] of Text[1024];
        gCellActive: Integer;

    local procedure SetDateFilter(pColumnID: Integer)
    begin
        if QtyType = Qtytype::"Net Change" then
            //  IF CurrForm.Matrix.MatrixRec."Period Start" = CurrForm.Matrix.MatrixRec."Period End" THEN
            if (gMatrixPeriods[pColumnID]."Period Start" = gMatrixPeriods[pColumnID]."Period End") then
                rec.SetRange("Date Filter", gMatrixPeriods[pColumnID]."Period Start")
            else
                rec.SetRange("Date Filter", gMatrixPeriods[pColumnID]."Period Start", gMatrixPeriods[pColumnID]."Period End")
        else
            rec.SetRange("Date Filter", 0D, gMatrixPeriods[pColumnID]."Period End");

        //#5403
        PlanningQty := CreateJobJnlLine.fCalcQtyPerWorkType(Rec, TempJobJnlLine);
        //#5403//
    end;


    procedure SetCellFilters(pColumnID: Integer; var pRec: record 210)
    begin
        pRec.SetCurrentkey(Type, "No.", "Posting Date");
        pRec.SetRange(Type, pRec.Type::Resource);
        pRec.SetRange("No.", rec.GetFilter("Resource Filter"));
        pRec.SetRange(pRec."Work Type Code", rec.Code);
        if gMatrixPeriods[pColumnID]."Period Start" = gMatrixPeriods[pColumnID]."Period End" then
            pRec.SetRange("Posting Date", gMatrixPeriods[pColumnID]."Period Start")
        else
            pRec.SetRange("Posting Date", gMatrixPeriods[pColumnID]."Period Start", gMatrixPeriods[pColumnID]."Period End");
    end;


    procedure MatrixUpdate(pQtyType: Integer; pPeriodType: Integer)
    begin
        QtyType := pQtyType;
        PeriodType := pPeriodType;
        CurrPage.Update(false);
    end;


    procedure SetColumns(pPeriodType: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MatrixMgt: Codeunit 9200;
        DateFilter: Text[30];
        lIndex: Integer;
    begin
        //MatrixMgt.GeneratePeriodMatrixData(pPeriodType, ARRAYLEN(ColumnValue) ,FALSE,PeriodType,'',
        //  PKFirstRecInCurrSet,MatrixColumnCaptions,ColumnSet,CurrSetLength,gMatrixPeriods);
        MatrixMgt.GeneratePeriodMatrixData(pPeriodType, ArrayLen(MATRIX_CellData), false, PeriodType, '',
          PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, gMatrixPeriods);

        for lIndex := 1 to CurrSetLength do begin
            fFormatCaption(MatrixColumnCaptions[lIndex], gMatrixPeriods[lIndex]);
        end;
    end;

    local procedure MATRIX_OnAfterGetRecord(ColumnID: Integer)
    begin
        SetDateFilter(ColumnID);
        //CALCFIELDS("Posted Quantity");
        //ColumnValue[ColumnID] := Rec."Posted Quantity";

        MATRIX_CellData[ColumnID] := fSetValue(ColumnID);

        //CurrForm.UPDATECONTROLS;
    end;


    procedure fInitialise()
    begin
        QtyType := Qtytype::"Net Change";
        PlanningSetup.Get;
        xShowOption := ShowOption;

        //IF CurrForm.Matrix.MatrixRec."Period Start" = 0D THEN
        //  CurrForm.Matrix.MatrixRec."Period Start" := WORKDATE;
        //PeriodStart := CALCDATE('<-CW-1W>',CurrForm.Matrix.MatrixRec."Period Start");
        PeriodEnd := Today + 6;

        //#5403
        CreateJobJnlLine.wInsertTmpJnlLine(TempJobJnlLine);
        //#5403//
    end;


    procedure Matrix_OnDrillDown(pColumnID: Integer)
    begin
        //CreateJobJnlLine.fDrillDown(TempJobJnlLine,GETFILTER("Resource Filter"),Code,GETFILTER("Date Filter"),ShowOption);
        CreateJobJnlLine.fDrillDown(TempJobJnlLine, rec.GetFilter("Resource Filter"), rec.Code,
            Format(gMatrixPeriods[pColumnID]."Period Start") + '..' + Format(gMatrixPeriods[pColumnID]."Period End"), ShowOption);
        //CurrForm.UPDATE(TRUE);
    end;


    procedure Matrix_OnActivate(pColumnID: Integer)
    begin
        gCellActive := pColumnID;
    end;


    procedure fSetValue(pColumnID: Integer) Return: Text[255]
    var
        lTemporary: record 210 temporary;
        lForeColor: Integer;
        lFontBold: Boolean;
        lDecimal: Decimal;
        lOK: Boolean;
        lQty: Decimal;
        "---": InStream;
        lRec: record 210;
    begin
        Return := '';

        rec.CalcFields("Posted Quantity");
        case ShowOption of
            Showoption::PostedQuantity:
                lDecimal := rec."Posted Quantity";
            Showoption::JournalLineQuantity:
                lDecimal := PlanningQty;
            Showoption::Both:
                lDecimal := rec."Posted Quantity" + PlanningQty;
        end;

        if lDecimal <> 0 then
            Return := Format(lDecimal);

        if (Return <> '') and
            ((HighLightJob <> '') or (HighLightProdPostingGroup <> '') or (HighLightQuantity <> '')) then begin
            SetCellFilters(pColumnID, lRec);
            if HighLightJob <> '' then
                lRec.SetFilter("Job No.", HighLightJob);
            if HighLightProdPostingGroup <> '' then
                lRec.SetFilter("Posting Group", HighLightProdPostingGroup);
            lOK := true;
            //IF (HighLightQuantity <> '') AND (lDecimal <> 0) THEN
            //  lOK := lTemporary.FIND('-');
            //CurrForm.Cell.UPDATESELECTED(lRec.FIND('-') AND lOK);
        end;

        if (Return = '') and gMatrixPeriods[pColumnID].Mark then
            Return := '-----';


        /*
        //IF (NOT wPerDate) THEN BEGIN
        //  CALCFIELDS("Period Planning Quantity",Capacity);
        //  lQty := "Period Planning Quantity";
        //END ELSE BEGIN
          MatrixRecords[pColumnID].CALCFIELDS("Posted Quantity");
          lQty := MatrixRecords[pColumnID]."Period Planning Quantity";
          Capacity := MatrixRecords[pColumnID].Capacity;
        //END;
        
        IF (ShowOption IN [ShowOption::Quantity,ShowOption::Capacity,ShowOption::Availability,ShowOption::"Load %"]) THEN BEGIN
          Return := '';
          CASE ShowOption OF
            ShowOption::Quantity:
              lDecimal := lQty;
            ShowOption::Capacity:
              lDecimal :=Capacity;
            ShowOption::Availability:
              lDecimal := Capacity - lQty;
            ShowOption::"Load %":
              IF Capacity <> 0 THEN
                lDecimal := ROUND(lQty / Capacity * 100,0.1)
              ELSE IF lQty <> 0 THEN
                Return := FORMAT(lQty) + '/0'
          END;
          IF lDecimal <> 0 THEN
            IF ShowOption = ShowOption::"Load %" THEN
              Return := FORMAT(lDecimal) + '%'
            ELSE
              Return := FORMAT(lDecimal);
          IF (HighLightQuantity <> '') AND (Return <> '') THEN BEGIN
            lTemporary.Quantity := lDecimal;
            lTemporary.INSERT;
            lTemporary.SETFILTER(Quantity,HighLightQuantity);
          END;
        END ELSE BEGIN
          SetCellFilters(pColumnID, lPlanning);
        
          IF HidePrivate THEN
            lPlanning.SETRANGE(Private,FALSE)
          ELSE
            lPlanning.SETRANGE(Private);
        
          IF lPlanning.ISEMPTY THEN
            BEGIN END
          ELSE IF ShowOption = ShowOption::Count THEN
            Return := FORMAT(lPlanning.COUNT)
          ELSE
            Return := PlanningMgt.Description(lPlanning,ShowOption,lForeColor,lFontBold);
        END;
        
        IF (Return <> '') AND ((HighLightJob <> '') OR (HighLightProdPostingGroup <> '')
           OR (HighLightQuantity <> '')) THEN BEGIN
          SetCellFilters(pColumnID, lPlanning);
          IF HighLightJob <> '' THEN
            lPlanning.SETFILTER("Job No.",HighLightJob);
          IF HighLightProdPostingGroup <> '' THEN
            lPlanning.SETFILTER("Prod. Posting Group",HighLightProdPostingGroup);
          lOK := TRUE;
          IF (HighLightQuantity <> '') AND (lDecimal <> 0) THEN
            lOK := NOT lTemporary.ISEMPTY;
        END;
        IF (NOT wPerDate) AND (Return = '') AND gMatrixPeriods[pColumnID].MARK THEN
          Return := '-----';
        */

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

        /*
        IF (PeriodType = PeriodType::Day) THEN BEGIN
          PlanningMgt.DateTitle(CurrForm.Matrix.MatrixRec,Text,lForeColor);
          IF lForeColor <> 0 THEN BEGIN
            CurrForm.MatrixTitle.UPDATEFORECOLOR(lForeColor);
            CurrForm.Matrix.MatrixRec.MARK(TRUE);
          END;
        END;
        IF (WORKDATE >= CurrForm.Matrix.MatrixRec."Period Start") AND
           (WORKDATE <= CurrForm.Matrix.MatrixRec."Period End") THEN
          CurrForm.MatrixTitle.UPDATESELECTED(TRUE);
        */

    end;

    local procedure ShowOptionOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure ResourceFilterOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure HighLightProdPostingGroupOnAft()
    begin
        CurrPage.Update;
    end;

    local procedure TypeFilterOnAfterValidate()
    begin
        CurrPage.Update(false);
    end;

    local procedure MATRIXCellData1OnActivate()
    begin
        Matrix_OnActivate(1);
    end;

    local procedure MATRIXCellData2OnActivate()
    begin
        Matrix_OnActivate(2);
    end;

    local procedure MATRIXCellData3OnActivate()
    begin
        Matrix_OnActivate(3);
    end;

    local procedure MATRIXCellData4OnActivate()
    begin
        Matrix_OnActivate(4);
    end;

    local procedure MATRIXCellData5OnActivate()
    begin
        Matrix_OnActivate(5);
    end;

    local procedure MATRIXCellData6OnActivate()
    begin
        Matrix_OnActivate(6);
    end;

    local procedure MATRIXCellData7OnActivate()
    begin
        Matrix_OnActivate(7);
    end;

    local procedure MATRIXCellData8OnActivate()
    begin
        Matrix_OnActivate(8);
    end;

    local procedure MATRIXCellData9OnActivate()
    begin
        Matrix_OnActivate(9);
    end;

    local procedure MATRIXCellData10OnActivate()
    begin
        Matrix_OnActivate(10);
    end;

    local procedure MATRIXCellData11OnActivate()
    begin
        Matrix_OnActivate(11);
    end;

    local procedure MATRIXCellData12OnActivate()
    begin
        Matrix_OnActivate(12);
    end;

    local procedure MATRIXCellData13OnActivate()
    begin
        Matrix_OnActivate(13);
    end;

    local procedure MATRIXCellData14OnActivate()
    begin
        Matrix_OnActivate(14);
    end;

    local procedure MATRIXCellData15C800390047OnAc()
    begin
        Matrix_OnActivate(15);
    end;

    local procedure MATRIXCellData15C800390049OnAc()
    begin
        Matrix_OnActivate(16);
    end;

    local procedure MATRIXCellData17OnActivate()
    begin
        Matrix_OnActivate(17);
    end;

    local procedure MATRIXCellData18OnActivate()
    begin
        Matrix_OnActivate(18);
    end;

    local procedure MATRIXCellData19OnActivate()
    begin
        Matrix_OnActivate(19);
    end;

    local procedure MATRIXCellData20OnActivate()
    begin
        Matrix_OnActivate(20);
    end;

    local procedure MATRIXCellData21OnActivate()
    begin
        Matrix_OnActivate(21);
    end;

    local procedure MATRIXCellData22OnActivate()
    begin
        Matrix_OnActivate(22);
    end;

    local procedure MATRIXCellData23OnActivate()
    begin
        Matrix_OnActivate(23);
    end;

    local procedure MATRIXCellData24OnActivate()
    begin
        Matrix_OnActivate(24);
    end;

    local procedure MATRIXCellData25OnActivate()
    begin
        Matrix_OnActivate(25);
    end;

    local procedure MATRIXCellData26OnActivate()
    begin
        Matrix_OnActivate(26);
    end;

    local procedure MATRIXCellData27OnActivate()
    begin
        Matrix_OnActivate(27);
    end;

    local procedure MATRIXCellData28OnActivate()
    begin
        Matrix_OnActivate(28);
    end;

    local procedure MATRIXCellData29OnActivate()
    begin
        Matrix_OnActivate(29);
    end;

    local procedure MATRIXCellData30OnActivate()
    begin
        Matrix_OnActivate(30);
    end;

    local procedure MATRIXCellData31OnActivate()
    begin
        Matrix_OnActivate(31);
    end;

    local procedure MATRIXCellData32OnActivate()
    begin
        Matrix_OnActivate(32);
    end;
}

