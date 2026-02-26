Page 58022 "RTC Job Working Time/resource"
{
    // //#5898 link
    // //POINTAGE GESWAY 07/06/02 Saisie des pointages
    //                   22/05/03 Ajout Export et import Excel sur bouton pointage
    // //OUVRAGE GESWAY 22/04/05 Avoir la fiche qui correspond au type

    Caption = 'RTC Job Working Time/resource';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SaveValues = true;
    SourceTable = 156;
    SourceTableView = sorting(Type, "Bal. Job No.", "No.")
                      where(Type = filter(Person | Machine), Status = filter(<> Generic), "WT Allowed" = const(true));



    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                group("Default Values")
                {
                    Caption = 'Default Values';
                    field("LineDef.""Job No."""; LineDef."Job No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Job No';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            lJob: Record job;
                        begin
                            //#5898
                            if lJob.Get(LineDef."Job No.") then;
                            //GL2024   Clear(JobListSimplified);
                            //GL2024   JobListSimplified.wSetJob(Text, false);
                            //JobListSimplified.UPDATECONTROLS;
                            //#8309
                            //GL2024     JobListSimplified.LookupMode := true;
                            /*   //GL2024  if JobListSimplified.RunModal = Action::LookupOK then begin
                                  //IF JobListSimplified.RUNMODAL = ACTION::OK THEN BEGIN
                                  //#8309//
                                  JobListSimplified.GetRecord(lJob);
                                  LineDef."Job No." := lJob."No.";
                                  CurrPage.Update(false);
                              end;*/
                            //#5898//
                        end;

                        trigger OnValidate()
                        begin
                            //#5898
                            //GL2024   Clear(JobListSimplified);
                            //GL2024    if not JobListSimplified.wSetJob(LineDef."Job No.", true) then
                            //GL2024     Error('');
                            //#5898//
                            LineDefJobNoOnAfterValidate;
                        end;
                    }
                    field("LineDef.""Work Type Code"""; LineDef."Work Type Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Work Type Code';
                        TableRelation = "Work Type";

                        trigger OnValidate()
                        begin
                            if LineDef."Work Type Code" <> '' then begin
                                wWorkType.Get(LineDef."Work Type Code");
                                wWorkType.TestField("Job Absence No.", '');
                            end;
                            LineDefWorkTypeCodeOnAfterValidate;
                        end;
                    }
                    field("LineDef.""Resource Group No."""; LineDef."Resource Group No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Resource Group No. Code';
                        TableRelation = "Resource Group";

                        trigger OnValidate()
                        begin
                            LineDefResourceGroupNoOnAfterValidate;
                        end;
                    }
                    field(Filtre; Filtre)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Values Is Filter';

                        trigger OnValidate()
                        begin
                            FiltreOnAfterValidate;
                        end;
                    }
                    field(CurrentJnlBatchName; CurrentJnlBatchName)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Batch Name';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            //#7906
                            LineDef.SetFilter("Journal Batch Name", CurrentJnlBatchName);//GETRANGEMAX("Journal Batch Name Filter")
                            LineDef.SetFilter("Journal Template Name", rec.GetRangemax("Journal Template Name Filter"));
                            JobJnlManagement.LookupName(CurrentJnlBatchName, LineDef);

                            JobJnlManagement.OpenJnl(CurrentJnlBatchName, JobJnlLine);
                            rec.SetRange("Journal Template Name Filter", JobJnlLine.GetRangemax("Journal Template Name"));
                            rec.FilterGroup(2);
                            rec.SetRange("Journal Batch Name Filter", CurrentJnlBatchName);
                            rec.FilterGroup(0);
                            SetFilters;
                            CurrPage.Update(false);
                            //#7906//
                        end;

                        trigger OnValidate()
                        begin
                            CurrentJnlBatchNameOnAfterValidate;
                        end;
                    }
                }
                group(Filters)
                {
                    Caption = 'Filters';
                    field("ResDef.""Resource Group No."""; ResDef."Resource Group No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Resource Group No. Filter';
                        TableRelation = "Resource Group";

                        trigger OnValidate()
                        begin
                            ResDefResourceGroupNoOnAfterValidate;
                        end;
                    }
                    field("ResDef.""Responsible No."""; ResDef."Responsible No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Responsible Filter';
                        TableRelation = Resource;

                        trigger OnValidate()
                        begin
                            ResDefResponsibleNoOnAfterValidate;
                        end;
                    }
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
            repeater(Control800390014)
            {
                ShowCaption = false;
                field("No."; rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Field1; ColumnValue[1])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[1];

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(1);
                    end;

                    trigger OnValidate()
                    begin
                        //#8309
                        Matrix_OnPostValidate(1);
                        //#8309//
                        Matrix_OnValidate(1);
                    end;
                }
                field(Field2; ColumnValue[2])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[2];

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(2);
                    end;

                    trigger OnValidate()
                    begin
                        //#8309
                        Matrix_OnPostValidate(2);
                        //#8309//
                        Matrix_OnValidate(2);
                    end;
                }
                field(Field3; ColumnValue[3])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[3];

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(3);
                    end;

                    trigger OnValidate()
                    begin
                        //#8309
                        Matrix_OnPostValidate(3);
                        //#8309//
                        Matrix_OnValidate(3);
                    end;
                }
                field(Field4; ColumnValue[4])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[4];

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(4);
                    end;

                    trigger OnValidate()
                    begin
                        //#8309
                        Matrix_OnPostValidate(4);
                        //#8309//
                        Matrix_OnValidate(4);
                    end;
                }
                field(Field5; ColumnValue[5])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[5];

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(5);
                    end;

                    trigger OnValidate()
                    begin
                        //#8309
                        Matrix_OnPostValidate(5);
                        //#8309//
                        Matrix_OnValidate(5);
                    end;
                }
                field(Field6; ColumnValue[6])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[6];

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(6);
                    end;

                    trigger OnValidate()
                    begin
                        //#8309
                        Matrix_OnPostValidate(6);
                        //#8309//
                        Matrix_OnValidate(6);
                    end;
                }
                field(Field7; ColumnValue[7])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[7];

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(7);
                    end;

                    trigger OnValidate()
                    begin
                        //#8309
                        Matrix_OnPostValidate(7);
                        //#8309//
                        Matrix_OnValidate(7);
                    end;
                }
                field(Field8; ColumnValue[8])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[8];

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(8);
                    end;

                    trigger OnValidate()
                    begin
                        //#8309
                        Matrix_OnPostValidate(8);
                        //#8309//
                        Matrix_OnValidate(8);
                    end;
                }
                field(Field9; ColumnValue[9])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[9];

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(9);
                    end;

                    trigger OnValidate()
                    begin
                        //#8309
                        Matrix_OnPostValidate(9);
                        //#8309//
                        Matrix_OnValidate(9);
                    end;
                }
                field(Field10; ColumnValue[10])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[10];

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(10);
                    end;

                    trigger OnValidate()
                    begin
                        //#8309
                        Matrix_OnPostValidate(10);
                        //#8309//
                        Matrix_OnValidate(10);
                    end;
                }
                field(Field11; ColumnValue[11])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[11];

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(11);
                    end;

                    trigger OnValidate()
                    begin
                        //#8309
                        Matrix_OnPostValidate(11);
                        //#8309//
                        Matrix_OnValidate(11);
                    end;
                }
                field(Field12; ColumnValue[12])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[12];

                    trigger OnDrillDown()
                    begin
                        Matrix_OnDrillDown(12);
                    end;

                    trigger OnValidate()
                    begin
                        //#8309
                        Matrix_OnPostValidate(12);
                        //#8309//
                        Matrix_OnValidate(12);
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
                actionref("Ledger E&ntries1"; "Ledger E&ntries") { }
            }
            group("&Working Time1")
            {
                Caption = '&Working Time';
                actionref("Suggest Work Activity1"; "Suggest Work Activity") { }
                actionref("Resource &Working Time per Job1"; "Resource &Working Time per Job") { }
                actionref("&Set Capacity1"; "&Set Capacity") { }
            }
            group("P&osting1")
            {
                Caption = 'P&osting';
                actionref(Reconcile1; Reconcile) { }
                actionref("Test Report1"; "Test Report") { }
                actionref("P&ost1"; "P&ost") { }
                actionref("Post and &Print1"; "Post and &Print") { }
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
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        case rec.Type of
                            rec.Type::Person:
                                page.RunModal(page::"Resource Card", Rec);
                            //GL2024     rec.Type::Machine: page.RunModal(page::"Machine Resource",Rec);
                            //GL2024   rec.Type::Structure: page.RunModal(page::"Structure Card",Rec);
                            else
                                ;
                        end;
                    end;
                }
                action(Statistics)
                {
                    ApplicationArea = Basic;
                    Caption = 'Statistics';
                    Image = Statistics;

                    RunpageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Unit of Measure Filter" = FIELD("Base Unit of Measure"), "Chargeable Filter" = FIELD("Chargeable Filter");
                    RunObject = Page 223;
                    ShortCutKey = 'F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunpageLink = "Table Name" = CONST(Resource), "No." = FIELD("No.");
                    RunObject = Page 124;
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunpageLink = "Table ID" = CONST(156), "No." = FIELD("No.");
                    RunObject = Page 540;
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ledger E&ntries';
                    RunpageLink = "Resource No." = FIELD("No.");
                    RunpageView = SORTING("Resource No.");
                    RunObject = Page 202;
                    ShortCutKey = 'Ctrl+F7';
                }
            }
            group("&Working Time")
            {
                Caption = '&Working Time';
                action("Suggest Work Activity")
                {
                    ApplicationArea = Basic;
                    Caption = 'Suggest Work Activity';

                    trigger OnAction()
                    var
                        //GL2024    PropPoint: Report 8004030;
                        lLigneChantier: record 210;
                        lLigneAffaire: record 210;
                    begin
                        lLigneAffaire.SetRange("Journal Template Name", rec.GetRangemax("Journal Template Name Filter"));
                        lLigneAffaire.SetRange("Journal Batch Name", rec.GetRangemax("Journal Batch Name Filter"));
                        if lLigneAffaire.Find('+') then;
                        lLigneAffaire."Journal Template Name" := rec.GetRangemax("Journal Template Name Filter");
                        lLigneAffaire."Journal Batch Name" := rec.GetRangemax("Journal Batch Name Filter");
                        lLigneAffaire."Work Type Code" := LineDef."Work Type Code";
                        //GL2024     PropPoint.InitRequest(lLigneAffaire);
                        //GL2024    PropPoint.RunModal;
                    end;
                }
                separator(Action1100280013)
                {
                }
                action("Resource &Working Time per Job")
                {
                    ApplicationArea = Basic;
                    Caption = 'Resource &Working Time per Job';

                    trigger OnAction()
                    var
                        lJob: Record job;
                    begin
                        lJob.SetFilter("Resource Filter", rec."No.");
                        rec.Copyfilter("Job No. Filter", lJob."No.");
                        rec.Copyfilter("Work Type Filter", lJob."Work Type Filter");
                        lJob.SetRange("Journal Template Name Filter", rec.GetRangemax("Journal Template Name Filter"));
                        //COPYFILTER("Journal Template Name Filter",lJob."Journal Template Name Filter");
                        lJob.SetRange("Journal Batch Name Filter", rec.GetRangemax("Journal Batch Name Filter"));
                        //COPYFILTER("Journal Batch Name Filter",lJob."Journal Batch Name Filter");
                        //GL2024    page.RunModal(Page::"Job Working Time per Job",lJob);
                    end;
                }
                action("&Set Capacity")
                {
                    ApplicationArea = Basic;
                    Caption = '&Set Capacity';
                    RunpageLink = "No." = FIELD("No.");
                    RunObject = Page 6013;
                    Visible = false;
                }
                /*GL2024   action("Resource A&vailability")
                   {
                       ApplicationArea = Basic;
                       Caption = 'Resource A&vailability';
                       RunpageLink = "No."="FIELD"(No.),Unit of Measure "Filter"="FIELD"(Base Unit of Measure),Chargeable "Filter"="FIELD"(Chargeable "Filter");
                       RunObject = Page 8004171;
                       Visible = false;
                   }*/
                separator(Action1100282000)
                {
                }
                /*  //GL2024    action("Export to Excel")
                   {
                       ApplicationArea = Basic;
                       Caption = 'Export to Excel';

                       trigger OnAction()
                       var
                         //GL2024     lExportWorkingTime: Report 8004036;
                       begin
                           //POINTAGE
                           Clear(lExportWorkingTime);
                           lExportWorkingTime.InitRequest(
                             rec.GetRangemax("Journal Template Name Filter"),
                             rec.GetRangemax("Journal Batch Name Filter"));
                           lExportWorkingTime.RunModal;
                           //POINTAGE//
                       end;
                   }*/
            }
        }
        area(processing)
        {
            group("P&osting")
            {
                Caption = 'P&osting';
                action(Reconcile)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reconcile';
                    Image = Reconcile;
                    ShortCutKey = 'Ctrl+F11';

                    trigger OnAction()
                    var
                        LigFeuille: record 210;
                    //GL2024    JobJnlReconcile: page 8004180;
                    begin
                        LigFeuille.SetFilter("No.", rec."No.");
                        LigFeuille."No." := rec."No.";
                        if rec.GetFilter("Resource Group No.") <> '' then
                            rec.Copyfilter("Resource Group No.", LigFeuille."Resource Group No.");
                        if rec.GetFilter("Job No. Filter") <> '' then
                            rec.Copyfilter("Job No. Filter", LigFeuille."Job No.");
                        if rec.GetFilter("Work Type Filter") <> '' then
                            rec.Copyfilter("Work Type Filter", LigFeuille."Work Type Code");
                        LigFeuille.SetRange("Journal Template Name", rec.GetRangemax("Journal Template Name Filter"));
                        LigFeuille.SetRange("Journal Batch Name", CurrentJnlBatchName);
                        //GL2024    JobJnlReconcile.SetJobJnlLine(LigFeuille);
                        //GL2024    JobJnlReconcile.Run;
                    end;
                }
                action("Test Report")
                {
                    ApplicationArea = Basic;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    var
                        LigFeuille: record 210;
                        ReportPrint: Codeunit "Test Report-Print";
                    begin
                        if rec.GetFilter("No.") <> '' then
                            rec.Copyfilter("No.", LigFeuille."No.");
                        if rec.GetFilter("Resource Group No.") <> '' then
                            rec.Copyfilter("Resource Group No.", LigFeuille."Resource Group No.");
                        if rec.GetFilter("Job No. Filter") <> '' then
                            rec.Copyfilter("Job No. Filter", LigFeuille."Job No.");
                        if rec.GetFilter("Work Type Filter") <> '' then
                            rec.Copyfilter("Work Type Filter", LigFeuille."Work Type Code");
                        LigFeuille.SetRange("Journal Template Name", rec.GetRangemax("Journal Template Name Filter"));
                        LigFeuille."Journal Template Name" := rec.GetRangemax("Journal Template Name Filter");
                        LigFeuille.SetRange("Journal Batch Name", CurrentJnlBatchName);
                        LigFeuille."Journal Batch Name" := CurrentJnlBatchName;
                        //GL2024    ReportPrint.PrintJobJnlLine(LigFeuille);
                    end;
                }
                action("P&ost")
                {
                    ApplicationArea = Basic;
                    Caption = 'P&ost';
                    Image = Post;

                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        NomFeuille: Record 8004167;
                        LigFeuille: record 210;
                    begin
                        if rec.GetFilter("No.") <> '' then
                            rec.Copyfilter("No.", LigFeuille."No.");
                        if rec.GetFilter("Resource Group No.") <> '' then
                            rec.Copyfilter("Resource Group No.", LigFeuille."Resource Group No.");
                        if rec.GetFilter("Job No. Filter") <> '' then
                            rec.Copyfilter("Job No. Filter", LigFeuille."Job No.");
                        if rec.GetFilter("Work Type Filter") <> '' then
                            rec.Copyfilter("Work Type Filter", LigFeuille."Work Type Code");
                        LigFeuille.SetRange("Journal Template Name", rec.GetRangemax("Journal Template Name Filter"));
                        LigFeuille."Journal Template Name" := rec.GetRangemax("Journal Template Name Filter");
                        LigFeuille.SetRange("Journal Batch Name", CurrentJnlBatchName);
                        LigFeuille."Journal Batch Name" := CurrentJnlBatchName;
                        if LigFeuille.Find('-') then;
                        //POINTAGE
                        if NomFeuille.Get(LigFeuille."Journal Template Name", LigFeuille."Journal Batch Name") then
                            if NomFeuille."Transfer Journal Name" <> '' then begin
                                if Confirm(Text8003900, false, NomFeuille."Transfer Journal Name") then
                                    Transfert(NomFeuille."Transfer Journal Name", NomFeuille."Journal Template Name", LigFeuille);
                            end
                            else
                                //POINTAGE//
                                Codeunit.Run(Codeunit::"Job Jnl.-Post", LigFeuille);

                        CurrentJnlBatchName := rec.GetRangemax("Journal Batch Name Filter");
                        CurrPage.Update(false);
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post and &Print';
                    Image = PostPrint;

                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    var
                        NomFeuille: Record 8004167;
                        LigFeuille: record 210;
                    begin
                        if rec.GetFilter("No.") <> '' then
                            rec.Copyfilter("No.", LigFeuille."No.");
                        if rec.GetFilter("Resource Group No.") <> '' then
                            rec.Copyfilter("Resource Group No.", LigFeuille."Resource Group No.");
                        if rec.GetFilter("Job No. Filter") <> '' then
                            rec.Copyfilter("Job No. Filter", LigFeuille."Job No.");
                        if rec.GetFilter("Work Type Filter") <> '' then
                            rec.Copyfilter("Work Type Filter", LigFeuille."Work Type Code");
                        LigFeuille.SetRange("Journal Template Name", rec.GetRangemax("Journal Template Name Filter"));
                        LigFeuille."Journal Template Name" := rec.GetRangemax("Journal Template Name Filter");
                        LigFeuille.SetRange("Journal Batch Name", CurrentJnlBatchName);
                        LigFeuille."Journal Batch Name" := CurrentJnlBatchName;
                        if LigFeuille.Find('-') then;
                        //POINTAGE
                        if NomFeuille.Get(LigFeuille.GetFilter("Journal Template Name"), LigFeuille.GetFilter("Journal Batch Name")) then
                            if NomFeuille."Transfer Journal Name" <> '' then begin
                                if Confirm(Text8003900, false, NomFeuille."Transfer Journal Name") then
                                    Transfert(NomFeuille."Transfer Journal Name", NomFeuille."Journal Template Name", LigFeuille);
                            end
                            else
                                //POINTAGE//
                                Codeunit.Run(Codeunit::"Job Jnl.-Post+Print", LigFeuille);

                        CurrentJnlBatchName := rec.GetRangemax("Journal Batch Name Filter");
                        CurrPage.Update(false);
                    end;
                }
            }
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
        //GL2024 error open page   fInitialise();

        SetColumns(Setwanted::Initial);
    end;

    var
        JobJnlLine: record 210;
        LineDef: record 210;
        ResDef: Record 156;
        PrincCal: Record 7600;
        //GL2024     JobListSimplified: page 8004159;
        PeriodFormMgt: Codeunit PeriodPageManagement;
        JobJnlManagement: Codeunit 8004171;
        CalendarMgmt: Codeunit 7600;
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        QtyType: Option "Net Change","Balance at Date";
        wQte: array[12] of Decimal;
        wQteOld: array[12] of Decimal;
        wText: array[12] of Text[1024];
        Filtre: Boolean;
        CurrentJnlBatchName: Code[10];
        Text8003900: label 'Do you want transfer the lines to %1?';
        Text8003901: label 'The journal lines %1 were successfully transfered.';
        Text8003902: label 'The value is not correct.';
        Text8003903: label 'Resource &Working Time per';
        wNoDoc: Code[20];
        wWorkType: Record 200;
        gJobNo: Code[20];
        Text8004159: label 'L''affaire %1 n''existe pas';
        "-----": Integer;
        ColumnValue: array[12] of Decimal;
        gMatrixPeriods: array[32] of Record Date;
        MatrixColumnCaptions: array[32] of Text[1024];
        ColumnSet: Text[1024];
        CurrSetLength: Integer;
        SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        PKFirstRecInCurrSet: Text[100];
        MatrixBoldValue: array[12] of Boolean;

    local procedure SetDateFilter(pColumnID: Integer)
    begin
        if QtyType = Qtytype::"Net Change" then
            if (gMatrixPeriods[pColumnID]."Period Start" = gMatrixPeriods[pColumnID]."Period End") then
                rec.SetRange("Date Filter", gMatrixPeriods[pColumnID]."Period Start")
            else
                rec.SetRange("Date Filter", gMatrixPeriods[pColumnID]."Period Start", gMatrixPeriods[pColumnID]."Period End")
        else
            rec.SetRange("Date Filter", 0D, gMatrixPeriods[pColumnID]."Period End");
    end;


    procedure SetFilters()
    begin
        if Filtre then begin
            if LineDef."Job No." <> '' then
                rec.SetRange("Job No. Filter", LineDef."Job No.")
            else
                rec.SetRange("Job No. Filter");
            if LineDef."Work Type Code" <> '' then
                rec.SetRange("Work Type Filter", LineDef."Work Type Code")
            else
                rec.SetRange("Work Type Filter");
            if LineDef."Resource Group No." <> '' then begin
                rec.SetFilter("Res. Group Filter", LineDef."Resource Group No.");
                rec.CalcFields("In Res. Group");
                rec.SetRange("In Res. Group", true);
            end else
                rec.SetRange("In Res. Group");
        end
        else begin
            rec.SetRange("Job No. Filter");
            rec.SetRange("Work Type Filter");
            rec.SetRange("In Res. Group");
        end;

        if ResDef."Resource Group No." <> '' then begin
            rec.SetFilter("Res. Group Filter", ResDef."Resource Group No.");
            rec.CalcFields("In Res. Group");
            rec.SetRange("In Res. Group", true);
        end;
        //#6043
        // ELSE
        //  SETRANGE(Skill);
        //#6043//
        if ResDef."Responsible No." <> '' then
            rec.SetFilter("Responsible No.", ResDef."Responsible No.")
        else
            rec.SetRange("Responsible No.");
    end;


    procedure Transfert(NomFS: Code[20]; Modele: Code[20]; var LigLoc: record 210)
    var
        LigneFeuilleTransfert: record 210;
        LigneFeuilleLoc: record 210;
        NoLigne: Integer;
        lFromJnlLineDim: Record 356;
        lToJnlLineDim: Record 356;
    begin
        LigneFeuilleLoc.CopyFilters(LigLoc);
        //GL2024  Codeunit.Run(Codeunit::Codeunit201, LigLoc);
        LigneFeuilleTransfert.SetRange("Journal Template Name", Modele);
        LigneFeuilleTransfert.SetRange("Journal Batch Name", NomFS);
        LigneFeuilleTransfert.LockTable;
        if LigneFeuilleTransfert.Find('+') then
            NoLigne := LigneFeuilleTransfert."Line No.";
        if LigneFeuilleLoc.Find('-') then
            repeat
                NoLigne += 10000;
                LigneFeuilleTransfert := LigneFeuilleLoc;
                LigneFeuilleTransfert."Journal Batch Name" := NomFS;
                LigneFeuilleTransfert."Line No." := NoLigne;
                LigneFeuilleTransfert.Insert;
                //#5924
                /*GL2024  lFromJnlLineDim.SetRange("Table ID", Database::"Job Journal Line");
                  lFromJnlLineDim.SetRange("Journal Template Name", LigneFeuilleLoc."Journal Template Name");
                  lFromJnlLineDim.SetRange("Journal Batch Name", LigneFeuilleLoc."Journal Batch Name");
                  lFromJnlLineDim.SetRange("Journal Line No.", LigneFeuilleLoc."Line No.");
                  if not lFromJnlLineDim.IsEmpty then begin
                      lFromJnlLineDim.FindSet(true, true);
                      repeat
                          lToJnlLineDim.TransferFields(lFromJnlLineDim, true);
                          lToJnlLineDim."Journal Template Name" := LigneFeuilleTransfert."Journal Template Name";
                          lToJnlLineDim."Journal Batch Name" := NomFS;
                          lToJnlLineDim."Journal Line No." := NoLigne;

                          lToJnlLineDim.Insert;
                      until lFromJnlLineDim.Next = 0;
                      lFromJnlLineDim.DeleteAll;
                  end;*/
                //#5924//
                LigneFeuilleLoc.Delete;
            until LigneFeuilleLoc.Next = 0;
        Message(Text8003901, NomFS);
    end;


    procedure SetColumns(pPeriodType: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MatrixMgt: Codeunit 9200;
        DateFilter: Text[30];
        lIndex: Integer;
    begin
        MatrixMgt.GeneratePeriodMatrixData(pPeriodType, ArrayLen(ColumnValue), false, PeriodType, '',
          PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, gMatrixPeriods);
    end;

    local procedure MATRIX_OnAfterGetRecord(ColumnID: Integer)
    begin

        SetDateFilter(ColumnID);
        rec.CalcFields("Working Time");
        //#8309
        //wText := FORMAT(Rec."Working Time");
        //IF wText <> '' THEN
        //  EVALUATE(ColumnValue[ColumnID],wText)
        //ELSE
        //  ColumnValue[ColumnID] := 0;
        //CurrForm.UPDATECONTROLS;
        wText[ColumnID] := Format(Rec."Working Time");
        if wText[ColumnID] <> '' then
            Evaluate(ColumnValue[ColumnID], wText[ColumnID])
        else
            ColumnValue[ColumnID] := 0;
        //#8309//
    end;


    procedure fInitialise()
    var
        lJobJnlLine: record 210;
        lJnlSelected: Boolean;
    begin
        //#6138
        //JobJnlManagement.wTemplateSelectionNaviBat(1,FORM::"Job Working Time / resource",FALSE,JobJnlLine,lJnlSelected);
        //GL2024   JobJnlManagement.TemplateSelection(page::"Job Journal Working Time", false, JobJnlLine, lJnlSelected);
        //#6138//
        if not lJnlSelected then
            Error('');
        if rec.GetFilter("Journal Batch Name Filter") = '' then begin
            JobJnlManagement.OpenJnl(CurrentJnlBatchName, JobJnlLine);
            //#6138
            //  IF NOT JobJnlManagement.LookupName(CurrentJnlBatchName,JobJnlLine) THEN
            //    CurrForm.CLOSE;
            //#6138//
            rec.SetRange("Journal Template Name Filter", JobJnlLine.GetRangemax("Journal Template Name"));
            rec.FilterGroup(2);
            rec.SetRange("Journal Batch Name Filter", CurrentJnlBatchName);
            rec.FilterGroup(0);
        end;
        SetFilters;
        if PrincCal.Find('-') then;
    end;


    procedure Matrix_OnActivate(pColumnID: Integer)
    begin
    end;


    procedure Matrix_OnFormat(pColumnID: Integer)
    begin
    end;


    procedure Matrix_OnAfterInput(pColumnID: Integer; var pText: Text[1024])
    begin
        //#8309
        if pText <> '' then
            Evaluate(wQte[pColumnID], pText)
        else
            wQte[pColumnID] := 0;
        rec."Working Time" := xRec."Working Time";
        pText := wText[pColumnID];
        //#8309//
    end;


    procedure Matrix_OnValidate(pColumnID: Integer)
    var
        wLigneChantier: record 210;
        wLigneAffaire: record 210;
        wNoLine: Integer;
        wControl: Codeunit 8003911;
        wFeuille: Record "Job Journal Template";
        lDecimalValue: Decimal;
    begin
        //#8309
        SetDateFilter(pColumnID);
        //#8309//
        wNoLine := 10000;
        wNoDoc := '';
        wLigneAffaire.SetRange("Journal Template Name", rec.GetRangemax("Journal Template Name Filter"));
        wLigneAffaire.SetRange("Journal Batch Name", rec.GetRangemax("Journal Batch Name Filter"));
        if wLigneAffaire.Find('+') then begin
            wNoLine := wLigneAffaire."Line No." + 10000;
            wNoDoc := wLigneAffaire."Document No.";
        end;
        wLigneAffaire.Init;
        wLigneAffaire."Journal Template Name" := rec.GetRangemax("Journal Template Name Filter");
        wLigneAffaire."Journal Batch Name" := rec.GetRangemax("Journal Batch Name Filter");
        if wFeuille.Get(wLigneAffaire."Journal Template Name") then
            wLigneAffaire."Source Code" := wFeuille."Source Code";
        wLigneAffaire."Document No." := wNoDoc;
        wLigneAffaire.SetUpNewLine(wLigneAffaire/*GL2024, true*/);
        wLigneAffaire."Line No." := wNoLine;
        LineDef.TestField("Job No.");
        wLigneAffaire.Validate("Job No.", LineDef."Job No.");
        //#8290 wLigneAffaire.VALIDATE("Posting Date",GETRANGEMIN("Date Filter"));
        wLigneAffaire.Validate("Posting Date", rec.GetRangemax("Date Filter"));
        //#8290//
        //#8290
        if (PeriodType <> Periodtype::Day) then begin
            if not fDayIsOk(wLigneAffaire."Posting Date", LineDef."Work Type Code") then begin
                wLigneAffaire."Posting Date" := wLigneAffaire."Posting Date" - 1;
                if not fDayIsOk(wLigneAffaire."Posting Date", LineDef."Work Type Code") then begin
                    wLigneAffaire."Posting Date" := wLigneAffaire."Posting Date" - 1;
                    if not fDayIsOk(wLigneAffaire."Posting Date", LineDef."Work Type Code") then begin
                        wLigneAffaire."Posting Date" := wLigneAffaire."Posting Date" - 1;
                        if not fDayIsOk(wLigneAffaire."Posting Date", LineDef."Work Type Code") then begin
                            wLigneAffaire."Posting Date" := wLigneAffaire."Posting Date" - 1;
                            if not fDayIsOk(wLigneAffaire."Posting Date", LineDef."Work Type Code") then begin
                                wLigneAffaire."Posting Date" := wLigneAffaire."Posting Date" - 1;
                                if not fDayIsOk(wLigneAffaire."Posting Date", LineDef."Work Type Code") then begin
                                    wLigneAffaire."Posting Date" := wLigneAffaire."Posting Date" - 1;
                                end;
                            end;
                        end;
                    end;
                end;
                wLigneAffaire.Validate("Posting Date");
            end;
        end;
        //#8290//
        wLigneAffaire.Validate(Type, wLigneAffaire.Type::Resource);
        wLigneAffaire.Validate("No.", rec."No.");
        if wLigneAffaire."Resource Group No." = '' then
            wLigneAffaire."Resource Group No." := LineDef."Resource Group No.";
        wLigneAffaire.Validate("Work Type Code", LineDef."Work Type Code");
        wControl.Run(wLigneAffaire);
        //#8309
        //wLigneAffaire.VALIDATE(Quantity,wQte - wQteOld);
        wLigneAffaire.Validate(Quantity, wQte[pColumnID] - wQteOld[pColumnID]);
        //#8309//
        wLigneAffaire.Insert;
        rec."Working Time" := xRec."Working Time";
    end;


    procedure Matrix_OnDrillDown(pColumnID: Integer)
    var
        wLigneChantier: record 210;
        wLigneAffaire: record 210;
    begin
        wLigneAffaire.FilterGroup(2);
        wLigneAffaire.SetRange("Journal Template Name", rec.GetRangemax("Journal Template Name Filter"));
        wLigneAffaire.SetRange("Journal Batch Name", rec.GetRangemax("Journal Batch Name Filter"));
        wLigneAffaire.SetRange("Posting Date", gMatrixPeriods[pColumnID]."Period Start", gMatrixPeriods[pColumnID]."Period End");
        wLigneAffaire.SetRange(Type, wLigneAffaire.Type::Resource);
        wLigneAffaire.SetRange("No.", rec."No.");
        wLigneAffaire.SetFilter("Job No.", rec.GetFilter("Job No. Filter"));
        wLigneAffaire.SetFilter("Work Type Code", rec.GetFilter("Work Type Filter"));
        wLigneAffaire.FilterGroup(0);
        //GL2024    page.RunModal(page::"Working Time Lines", wLigneAffaire);
        rec.CalcFields("Working Time");
        //#8309
        //IF FORMAT("Working Time") <> wText THEN BEGIN
        //  wText := FORMAT("Working Time");
        //  CurrForm.UPDATE(TRUE);
        //END;
        if Format(rec."Working Time") <> wText[pColumnID] then begin
            wText[pColumnID] := Format(rec."Working Time");
            CurrPage.Update(true);
        end;
        //#8309
    end;


    procedure fDayIsOk(pDate: Date; pWorkTypeCode: Code[10]): Boolean
    var
        lWorkType: Record 200;
        lDay: Integer;
    begin
        //#8266
        lDay := Date2dwy(pDate, 1);
        if lWorkType.Get(pWorkTypeCode) then begin
            case lDay of
                1:
                    if lWorkType.Monday = true then
                        exit(true)
                    else
                        exit(false);
                2:
                    if lWorkType.Tuesday = true then
                        exit(true)
                    else
                        exit(false);
                3:
                    if lWorkType.Wednesday = true then
                        exit(true)
                    else
                        exit(false);
                4:
                    if lWorkType.Thursday = true then
                        exit(true)
                    else
                        exit(false);
                5:
                    if lWorkType.Friday = true then
                        exit(true)
                    else
                        exit(false);
                6:
                    if lWorkType.Saturday = true then
                        exit(true)
                    else
                        exit(false);
                7:
                    if lWorkType.Sunday = true then
                        exit(true)
                    else
                        exit(false);
            end;
            exit(false);
        end;
        exit(true);
        //#8266//
    end;


    procedure Matrix_OnPostValidate(pColumnID: Integer)
    begin
        //OF
        //IF FORMAT(ColumnValue[pColumnID]) <> '' THEN
        wQte[pColumnID] := ColumnValue[pColumnID];
        //OF\\
    end;

    local procedure LineDefWorkTypeCodeOnAfterValidate()
    begin
        SetFilters;
        CurrPage.Update(false);
    end;

    local procedure LineDefResourceGroupNoOnAfterValidate()
    begin
        SetFilters;
        CurrPage.Update;
    end;

    local procedure FiltreOnAfterValidate()
    begin
        SetFilters;
        CurrPage.Update(false);
    end;

    local procedure LineDefJobNoOnAfterValidate()
    begin
        SetFilters;
        CurrPage.Update(false);
    end;

    local procedure ResDefResourceGroupNoOnAfterValidate()
    begin
        SetFilters;
        CurrPage.Update;
    end;

    local procedure ResDefResponsibleNoOnAfterValidate()
    begin
        SetFilters;
        CurrPage.Update;
    end;

    local procedure CurrentJnlBatchNameOnAfterValidate()
    begin
        //#7906
        JobJnlManagement.OpenJnl(CurrentJnlBatchName, JobJnlLine);
        rec.SetRange("Journal Template Name Filter", JobJnlLine.GetRangemax("Journal Template Name"));
        rec.FilterGroup(2);
        rec.SetRange("Journal Batch Name Filter", CurrentJnlBatchName);
        rec.FilterGroup(0);
        SetFilters;
        CurrPage.Update(false);
        //#7906//
    end;

    local procedure ColumnValue1OnAfterInput(var Text: Text[1024])
    begin
        //#8309
        Matrix_OnAfterInput(1, Text);
        //8309//
    end;

    local procedure ColumnValue2OnAfterInput(var Text: Text[1024])
    begin
        //#8309
        Matrix_OnAfterInput(2, Text);
        //8309//
    end;

    local procedure ColumnValue3OnAfterInput(var Text: Text[1024])
    begin
        //#8309
        Matrix_OnAfterInput(3, Text);
        //8309//
    end;

    local procedure ColumnValue4OnAfterInput(var Text: Text[1024])
    begin
        //#8309
        Matrix_OnAfterInput(4, Text);
        //8309//
    end;

    local procedure ColumnValue5OnAfterInput(var Text: Text[1024])
    begin
        //#8309
        Matrix_OnAfterInput(5, Text);
        //8309//
    end;

    local procedure ColumnValue6OnAfterInput(var Text: Text[1024])
    begin
        //#8309
        Matrix_OnAfterInput(6, Text);
        //8309//
    end;

    local procedure ColumnValue7OnAfterInput(var Text: Text[1024])
    begin
        //#8309
        Matrix_OnAfterInput(7, Text);
        //8309//
    end;

    local procedure ColumnValue8OnAfterInput(var Text: Text[1024])
    begin
        //#8309
        Matrix_OnAfterInput(8, Text);
        //8309//
    end;

    local procedure ColumnValue9OnAfterInput(var Text: Text[1024])
    begin
        //#8309
        Matrix_OnAfterInput(9, Text);
        //8309//
    end;

    local procedure ColumnValue10OnAfterInput(var Text: Text[1024])
    begin
        //#8309
        Matrix_OnAfterInput(10, Text);
        //8309//
    end;

    local procedure ColumnValue11OnAfterInput(var Text: Text[1024])
    begin
        //#8309
        Matrix_OnAfterInput(11, Text);
        //8309//
    end;

    local procedure ColumnValue12OnAfterInput(var Text: Text[1024])
    begin
        //#8309
        Matrix_OnAfterInput(12, Text);
        //8309//
    end;
}

