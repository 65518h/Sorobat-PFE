Page 58023 "RTC Job Working Time per Job"
{
    // //POINTAGE GESWAY 07/06/02 Saisie des pointages

    Caption = 'RTC Job Working Time per Job';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SaveValues = true;
    SourceTable = job;
    SourceTableView = sorting("No.")
                      where(Blocked = const(" "));

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
                    field("LineDef.""No."""; LineDef."No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Resource No.';
                        TableRelation = Resource where("WT Allowed" = const(true), Type = filter(Person | Machine));

                        trigger OnValidate()
                        begin
                            LineDefNoOnAfterValidate;
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
                    field(Filtre; Filtre)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Values Is Filter';

                        trigger OnValidate()
                        begin
                            FiltreOnAfterValidate;
                        end;
                    }
                    field("LineDef.""Resource Group No."""; LineDef."Resource Group No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Default Resource Group No.';
                        TableRelation = "Resource Group";

                        trigger OnValidate()
                        begin
                            LineDefResourceGroupNoOnAfterValidate;
                        end;
                    }
                    field(CurrentJnlBatchName; CurrentJnlBatchName)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Batch Name';
                        Lookup = true;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            //#6725
                            CurrPage.Update(true);
                            LineDef.SetFilter("Journal Batch Name", CurrentJnlBatchName);//GETRANGEMAX("Journal Batch Name Filter")
                            LineDef.SetFilter("Journal Template Name", rec.GetRangemax("Journal Template Name Filter"));
                            JobJnlManagement.LookupName(CurrentJnlBatchName, LineDef);
                            Rec.SetFilter("Journal Batch Name Filter", CurrentJnlBatchName);
                            CurrPage.Update(false);
                        end;

                        trigger OnValidate()
                        begin
                            //#6725
                            if CurrentJnlBatchName <> '' then
                                JobJnlManagement.CheckName(CurrentJnlBatchName, LineDef);
                            CurrentJnlBatchNameOnAfterValidate;
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
                IndentationColumn = DescriptionIndent;
                IndentationControls = Description;
                ShowCaption = false;
                field("No."; rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Field1; ColumnValue[1])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[1];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(1);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(1);
                    end;
                }
                field(Field2; ColumnValue[2])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[2];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(2);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(2);
                    end;
                }
                field(Field3; ColumnValue[3])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[3];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(3);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(3);
                    end;
                }
                field(Field4; ColumnValue[4])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[4];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(4);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(4);
                    end;
                }
                field(Field5; ColumnValue[5])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[5];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(5);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(5);
                    end;
                }
                field(Field6; ColumnValue[6])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[6];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(6);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(6);
                    end;
                }
                field(Field7; ColumnValue[7])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[7];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(7);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(7);
                    end;
                }
                field(Field8; ColumnValue[8])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[8];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(8);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(8);
                    end;
                }
                field(Field9; ColumnValue[9])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[9];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(9);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(9);
                    end;
                }
                field(Field10; ColumnValue[10])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[10];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(10);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(10);
                    end;
                }
                field(Field11; ColumnValue[11])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[11];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(11);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(11);
                    end;
                }
                field(Field12; ColumnValue[12])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + MatrixColumnCaptions[12];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(12);
                    end;

                    trigger OnValidate()
                    begin
                        MatrixOnValidate(12);
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
                Caption = '&Job';
                actionref(Dimensions1; Dimensions) { }
            }

            group(Functions1)
            {
                Caption = 'Functions';
                actionref("Suggest Work Activity1"; "Suggest Work Activity") { }

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
            group("&Job")
            {
                Caption = '&Job';
                /*GL2024     action("&Card")
                   {
                       ApplicationArea = Basic;
                       Caption = '&Card';
                       Image = EditLines;
                       RunpageLink = "No."=FIELD("No.");
                       RunObject = Page 8003901;
                       ShortCutKey = 'Shift+F7';
                   }*/
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunpageLink = "Table ID" = CONST(8004160), "No." = FIELD("No.");
                    RunObject = Page 540;
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                /*GL2024   action("Ledger E&ntries")
                   {
                       ApplicationArea = Basic;
                       Caption = 'Ledger E&ntries';
                       RunpageLink = "Job No."=FIELD("No.");
                       RunpageView = SORTING("Job No.","Posting Dat"e);
                       RunObject = Page 8004162;
                       ShortCutKey = 'Ctrl+F7';
                   }
                   separator(Action1000000013)
                   {
                   }
                   action("Phases Statistics")
                   {
                       ApplicationArea = Basic;
                       Caption = 'Phases Statistics';
                       RunpageLink = Code=FIELD("No.");
                       RunObject = Page 8003961;
                       ShortCutKey = 'F7';
                   }*/
            }
        }
        area(processing)
        {
            /*GL2024   action("&Prices")
               {
                   ApplicationArea = Basic;
                   Caption = '&Prices';
                   Image = ResourcePrice;
                   Promoted = true;
                   PromotedCategory = Process;
                   RunpageLink = "Job No."=FIELD("No.");
                   RunObject = Page 204;
                   Visible = false;
               }*/
            group(Functions)
            {
                Caption = 'Functions';
                /*GL2024  action("Resource A&vailability")
                  {
                      ApplicationArea = Basic;
                      Caption = 'Resource A&vailability';
                      RunpageLink = No.="FIELD"("FILTER"(Resource "Filter"));
                      RunObject = Page 8004171;
                      Visible = false;
                  }*/
                action("Suggest Work Activity")
                {
                    ApplicationArea = Basic;
                    Caption = 'Suggest Work Activity';

                    trigger OnAction()
                    var
                        lLigneChantier: record 210;
                        lLigneAffaire: record 210;
                    //GL2024    PropPoint: Report 8004030;
                    begin
                        lLigneAffaire.SetRange("Journal Template Name", rec.GetRangemax("Journal Template Name Filter"));
                        lLigneAffaire.SetRange("Journal Batch Name", rec.GetRangemax("Journal Batch Name Filter"));
                        if lLigneAffaire.Find('+') then;
                        lLigneAffaire."Journal Template Name" := rec.GetRangemax("Journal Template Name Filter");
                        lLigneAffaire."Journal Batch Name" := rec.GetRangemax("Journal Batch Name Filter");
                        lLigneAffaire."Work Type Code" := LineDef."Work Type Code";
                        //GL2024       PropPoint.InitRequest(lLigneAffaire);
                        //GL2024    PropPoint.RunModal;
                    end;
                }
            }
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
                        if rec.GetFilter("Resource Filter") <> '' then
                            rec.Copyfilter("Resource Filter", LigFeuille."No.");
                        if LineDef."No." <> '' then
                            LigFeuille."No." := LineDef."No.";
                        if rec.GetFilter("No.") <> '' then
                            rec.Copyfilter("No.", LigFeuille."Job No.");
                        /*
                        IF GETFILTER("Phase Filter") <> '' THEN
                          COPYFILTER("Phase Filter",LigFeuille."Phase Code");
                        IF GETFILTER("Task Filter") <> '' THEN
                          COPYFILTER("Task Filter",LigFeuille."Task Code");
                        IF GETFILTER("Step Filter") <> '' THEN
                          COPYFILTER("Step Filter",LigFeuille."Step Code");
                        */
                        if rec.GetFilter("Work Type Filter") <> '' then
                            rec.Copyfilter("Work Type Filter", LigFeuille."Work Type Code");
                        LigFeuille.SetRange("Journal Template Name", rec.GetRangemax("Journal Template Name Filter"));
                        LigFeuille."Journal Template Name" := rec.GetRangemax("Journal Template Name Filter");
                        LigFeuille.SetRange("Journal Batch Name", CurrentJnlBatchName);
                        LigFeuille."Journal Batch Name" := CurrentJnlBatchName;
                        //GL2024    JobJnlReconcile.SetJobJnlLine(LigFeuille);
                        //GL2024   JobJnlReconcile.Run;

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
                        if rec.GetFilter("Resource Filter") <> '' then
                            rec.Copyfilter("Resource Filter", LigFeuille."No.");
                        if rec.GetFilter("No.") <> '' then
                            rec.Copyfilter("No.", LigFeuille."Job No.");
                        /*
                        IF GETFILTER("Phase Filter") <> '' THEN
                          COPYFILTER("Phase Filter",LigFeuille."Phase Code");
                        IF GETFILTER("Task Filter") <> '' THEN
                          COPYFILTER("Task Filter",LigFeuille."Task Code");
                        IF GETFILTER("Step Filter") <> '' THEN
                          COPYFILTER("Step Filter",LigFeuille."Step Code");
                        */
                        if rec.GetFilter("Work Type Filter") <> '' then
                            LigFeuille.SetRange("Journal Template Name", rec.GetRangemax("Journal Template Name Filter"));
                        LigFeuille."Journal Template Name" := rec.GetRangemax("Journal Template Name Filter");
                        LigFeuille.SetRange("Journal Batch Name", CurrentJnlBatchName);
                        LigFeuille."Journal Batch Name" := CurrentJnlBatchName;
                        rec.Copyfilter("Work Type Filter", LigFeuille."Work Type Code");
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
                        if rec.GetFilter("Resource Filter") <> '' then
                            rec.Copyfilter("Resource Filter", LigFeuille."No.");
                        if rec.GetFilter("No.") <> '' then
                            rec.Copyfilter("No.", LigFeuille."Job No.");
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
                        if rec.GetFilter("Resource Filter") <> '' then
                            rec.Copyfilter("Resource Filter", LigFeuille."No.");
                        if rec.GetFilter("No.") <> '' then
                            rec.Copyfilter("No.", LigFeuille."Job No.");
                        /*
                        IF GETFILTER("Phase Filter") <> '' THEN
                          COPYFILTER("Phase Filter",LigFeuille."Phase Code");
                        IF GETFILTER("Task Filter") <> '' THEN
                          COPYFILTER("Task Filter",LigFeuille."Task Code");
                        IF GETFILTER("Step Filter") <> '' THEN
                          COPYFILTER("Step Filter",LigFeuille."Step Code");
                        */
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
        DescriptionIndent := 0;
        for lIndex := 1 to CurrSetLength do begin
            MATRIX_OnAfterGetRecord(lIndex);
        end;
        NoOnFormat;
        DescriptionOnFormat;
    end;

    trigger OnOpenPage()
    begin
        //GL2024  fInitialise();
        SetColumns(Setwanted::Initial);
    end;

    var
        LineDef: record 210;
        PrincCal: Record 7600;
        PeriodFormMgt: Codeunit PeriodPageManagement;
        JobJnlManagement: Codeunit 8004171;
        CalendarMgmt: Codeunit 7600;
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        QtyType: Option "Net Change","Balance at Date";
        wQte: array[12] of Decimal;
        wQteOld: array[12] of Decimal;
        wText: array[12] of Text[1024];
        Filtre: Boolean;
        PhaseDefault: Boolean;
        CurrentJnlBatchName: Code[10];
        Text8003900: label 'Do you want transfer the lines to %1?';
        Text8003901: label 'The journal lines %1 were successfully transfered.';
        Text8003902: label 'The resource %1 is not %2.';
        wDocNo: Code[20];
        ForeColor: Integer;
        FontBold: Boolean;
        wWorkType: Record 200;
        "-----": Integer;
        ColumnValue: array[12] of Decimal;
        gMatrixPeriods: array[32] of Record Date;
        MatrixColumnCaptions: array[32] of Text[1024];
        ColumnSet: Text[1024];
        CurrSetLength: Integer;
        SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        PKFirstRecInCurrSet: Text[100];
        MatrixBoldValue: array[12] of Boolean;
        [InDataSet]
        "No.Emphasize": Boolean;
        [InDataSet]
        DescriptionEmphasize: Boolean;
        [InDataSet]
        DescriptionIndent: Integer;

    local procedure SetDateFilter(pColumnID: Integer)
    begin
        if QtyType = Qtytype::"Net Change" then
            if gMatrixPeriods[pColumnID]."Period Start" = gMatrixPeriods[pColumnID]."Period End" then
                rec.SetRange("Posting Date Filter", gMatrixPeriods[pColumnID]."Period Start")
            else
                rec.SetRange("Posting Date Filter", gMatrixPeriods[pColumnID]."Period Start", gMatrixPeriods[pColumnID]."Period End")
        else
            rec.SetRange("Posting Date Filter", 0D, gMatrixPeriods[pColumnID]."Period End");
    end;


    procedure SetFilters()
    begin
        if Filtre then begin
            if LineDef."No." <> '' then
                rec.SetRange("Resource Filter", LineDef."No.")
            else
                rec.SetRange("Resource Filter");
            if LineDef."Work Type Code" <> '' then
                rec.SetRange("Work Type Filter", LineDef."Work Type Code")
            else
                rec.SetRange("Work Type Filter");
        end
        else begin
            rec.SetRange("Resource Filter");
            rec.SetRange("Work Type Filter");
            rec.SetRange("No.");
        end;
        if LineDef."Job No." <> '' then
            rec.SetRange("No.", LineDef."Job No.")
        else
            rec.SetRange("No.");
    end;


    procedure Transfert(NomFS: Code[20]; Modele: Code[20]; var LigLoc: record 210)
    var
        LigneFeuilleTransfert: record 210;
        LigneFeuilleLoc: record 210;
        NoLigne: Integer;
        lFromJnlLineDim: Record 356;
    //GL2024 lToJnlLineDim: Record 356;
    begin
        LigneFeuilleLoc.CopyFilters(LigLoc);
        //#6725
        //CODEUNIT.RUN(CODEUNIT::201,LigLoc);
        Codeunit.Run(Codeunit::"Job Jnl.-Check Line", LigLoc);
        //#6725//
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
                /* //GL2024       lFromJnlLineDim.SetRange("Table ID", Database::"Job Journal Line");
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
                      end; //GL2024 */
                //#5924//
                LigneFeuilleLoc.Delete;
            until LigneFeuilleLoc.Next = 0;
        Message(Text8003901, NomFS);
    end;


    procedure wFormatField()
    begin
        ForeColor := 0;
        FontBold := rec.Summarize;
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
        rec.CalcFields("Working Time Res. Qty.");
        ColumnValue[ColumnID] := Rec."Working Time Res. Qty.";

        wText[ColumnID] := Format(ColumnValue[ColumnID]);
        if wText[ColumnID] <> '' then
            Evaluate(wQteOld[ColumnID], wText[ColumnID])
        else
            wQteOld[ColumnID] := 0;


        /*
        //OFE
        wText := Text;
        IF Text <> '' THEN
          EVALUATE(ColumnValue[ColumnID],Text)
        ELSE
          ColumnValue[ColumnID] := 0;
        //OFE//
        */

    end;


    procedure fInitialise()
    var
        lJobJnlLine: record 210;
        lJnlSelected: Boolean;
    begin
        //#6138
        //JobJnlManagement.wTemplateSelectionNaviBat(1,FORM::"Job Working Time per Job",FALSE,lJobJnlLine,lJnlSelected);
        //GL2024  JobJnlManagement.TemplateSelection(page::"Job Journal Working Time", false, lJobJnlLine, lJnlSelected);
        //#6138//
        if not lJnlSelected then
            Error('');
        if rec.GetFilter("Journal Batch Name Filter") = '' then begin
            JobJnlManagement.OpenJnl(CurrentJnlBatchName, lJobJnlLine);
            rec.SetRange("Journal Template Name Filter", lJobJnlLine.GetRangemax("Journal Template Name"));
            rec.FilterGroup(2);
            rec.SetRange("Journal Batch Name Filter", CurrentJnlBatchName);
            rec.FilterGroup(0);
        end;
        if rec.GetFilter("Resource Filter") <> '' then
            LineDef."No." := rec.GetFilter("Resource Filter");
        SetFilters;
        if PrincCal.Find('-') then;
    end;


    procedure MatrixOnAfterInput(pColumnID: Integer; var pText: Text[1024])
    begin
        if pText <> '' then
            Evaluate(wQte[pColumnID], pText)
        else
            wQte[pColumnID] := 0;
        rec."Working Time Res. Qty." := xRec."Working Time Res. Qty.";
        pText := wText[pColumnID];
    end;


    procedure MatrixOnValidate(pColumnID: Integer)
    var
        wLigneChantier: record 210;
        wLigneAffaire: record 210;
        wNoLine: Integer;
        wControl: Codeunit 8003911;
        wFeuille: Record "Job Journal Template";
        lResResGroup: Record 8004031;
    begin
        SetDateFilter(pColumnID);
        wNoLine := 10000;
        wDocNo := '';
        wLigneAffaire.SetRange("Journal Template Name", rec.GetRangemax("Journal Template Name Filter"));
        wLigneAffaire.SetRange("Journal Batch Name", rec.GetRangemax("Journal Batch Name Filter"));
        if wLigneAffaire.Find('+') then begin
            wNoLine := wLigneAffaire."Line No." + 10000;
            wDocNo := wLigneAffaire."Document No.";
        end;
        wLigneAffaire.Init;
        wLigneAffaire."Journal Template Name" := rec.GetRangemax("Journal Template Name Filter");
        wLigneAffaire."Journal Batch Name" := rec.GetRangemax("Journal Batch Name Filter");
        if wFeuille.Get(wLigneAffaire."Journal Template Name") then
            wLigneAffaire."Source Code" := wFeuille."Source Code";
        wLigneAffaire."Document No." := wDocNo;
        wLigneAffaire.SetUpNewLine(wLigneAffaire/*GL2024, true*/);
        wLigneAffaire."Line No." := wNoLine;
        LineDef.TestField("No.");
        wLigneAffaire.Validate("Job No.", rec."No.");
        wLigneAffaire.Validate("Posting Date", rec.GetRangeMin("Posting Date Filter"));
        wLigneAffaire.Validate(Type, wLigneAffaire.Type::Resource);
        wLigneAffaire.Validate("No.", LineDef."No.");
        if wLigneAffaire."Resource Group No." = '' then
            if LineDef."Resource Group No." <> '' then
                if not lResResGroup.Get(wLigneAffaire."No.", LineDef."Resource Group No.") then
                    Error(Text8003902, wLigneAffaire."No.", LineDef."Resource Group No.")
                else
                    wLigneAffaire.Validate("Resource Group No.", LineDef."Resource Group No.");
        wLigneAffaire.Validate("Work Type Code", LineDef."Work Type Code");
        //wLigneAffaire.VALIDATE("Task Code",LineDef."Task Code");
        //wLigneAffaire.VALIDATE("Step Code",LineDef."Step Code");
        wControl.Run(wLigneAffaire);
        wLigneAffaire.Validate(Quantity, wQte[pColumnID] - wQteOld[pColumnID]);
        wLigneAffaire.TestField("Work Type Code");
        wLigneAffaire.Insert;
        rec."Working Time Res. Qty." := xRec."Working Time Res. Qty.";
    end;


    procedure MatrixOnDrillDown(pColumnID: Integer)
    var
        wLigneChantier: record 210;
        wLigneAffaire: record 210;
    begin
        SetDateFilter(pColumnID);
        wLigneAffaire.FilterGroup(2);
        wLigneAffaire.SetRange("Journal Template Name", rec.GetRangemax("Journal Template Name Filter"));
        wLigneAffaire.SetRange("Journal Batch Name", rec.GetRangemax("Journal Batch Name Filter"));
        wLigneAffaire.SetRange("Posting Date", gMatrixPeriods[pColumnID]."Period Start", gMatrixPeriods[pColumnID]."Period End");
        wLigneAffaire.SetRange(Type, wLigneAffaire.Type::Resource);
        wLigneAffaire.SetFilter("Job No.", rec."No.");
        wLigneAffaire.SetFilter("No.", rec.GetFilter("Resource Filter"));
        wLigneAffaire.SetFilter("Work Type Code", rec.GetFilter("Work Type Filter"));
        wLigneAffaire.FilterGroup(0);
        //GL2024   page.RunModal(page::"Working Time Lines", wLigneAffaire);
        rec.CalcFields("Working Time Res. Qty.");
        if Format(rec."Working Time Res. Qty.") <> wText[pColumnID] then begin
            wText[pColumnID] := Format(rec."Working Time Res. Qty.");
            CurrPage.Update(true);
        end;
    end;

    local procedure LineDefNoOnAfterValidate()
    begin
        //LineDef."Phase Code" := '';
        SetFilters;
        CurrPage.Update(false);
    end;

    local procedure LineDefWorkTypeCodeOnAfterValidate()
    begin
        SetFilters;
        CurrPage.Update(false);
    end;

    local procedure FiltreOnAfterValidate()
    begin
        SetFilters;
        CurrPage.Update(false);
    end;

    local procedure LineDefResourceGroupNoOnAfterValidate()
    begin
        SetFilters;
        CurrPage.Update;
    end;

    local procedure CurrentJnlBatchNameOnAfterValidate()
    var
        lJobJnlLine: record 210;
        lJnlSelected: Boolean;
    begin
        //#6725
        CurrPage.Update(true);
        if rec.GetFilter("Journal Batch Name Filter") = '' then begin
            //GL2024     JobJnlManagement.TemplateSelection(page::"Job Journal Working Time", false, lJobJnlLine, lJnlSelected);
            JobJnlManagement.OpenJnl(CurrentJnlBatchName, lJobJnlLine);
            rec.SetRange("Journal Template Name Filter", lJobJnlLine.GetRangemax("Journal Template Name"));
            rec.SetRange("Journal Batch Name Filter", CurrentJnlBatchName);
        end else begin
            JobJnlManagement.SetName(CurrentJnlBatchName, LineDef);
            Rec.SetFilter("Journal Batch Name Filter", CurrentJnlBatchName);
        end;
        CurrPage.Update(false);
    end;

    local procedure ColumnValue1OnAfterInput(var Text: Text[1024])
    begin
        MatrixOnAfterInput(1, Text);
    end;

    local procedure ColumnValue2OnAfterInput(var Text: Text[1024])
    begin
        MatrixOnAfterInput(2, Text);
    end;

    local procedure ColumnValue3OnAfterInput(var Text: Text[1024])
    begin
        MatrixOnAfterInput(3, Text);
    end;

    local procedure ColumnValue4OnAfterInput(var Text: Text[1024])
    begin
        MatrixOnAfterInput(4, Text);
    end;

    local procedure ColumnValue5OnAfterInput(var Text: Text[1024])
    begin
        MatrixOnAfterInput(5, Text);
    end;

    local procedure ColumnValue6OnAfterInput(var Text: Text[1024])
    begin
        MatrixOnAfterInput(6, Text);
    end;

    local procedure ColumnValue7OnAfterInput(var Text: Text[1024])
    begin
        MatrixOnAfterInput(7, Text);
    end;

    local procedure ColumnValue8OnAfterInput(var Text: Text[1024])
    begin
        MatrixOnAfterInput(8, Text);
    end;

    local procedure ColumnValue9OnAfterInput(var Text: Text[1024])
    begin
        MatrixOnAfterInput(9, Text);
    end;

    local procedure ColumnValue10OnAfterInput(var Text: Text[1024])
    begin
        MatrixOnAfterInput(10, Text);
    end;

    local procedure ColumnValue11OnAfterInput(var Text: Text[1024])
    begin
        MatrixOnAfterInput(11, Text);
    end;

    local procedure ColumnValue12OnAfterInput(var Text: Text[1024])
    begin
        MatrixOnAfterInput(12, Text);
    end;

    local procedure NoOnFormat()
    begin
        //LEVEL
        wFormatField;
        "No.Emphasize" := FontBold;
        //LEVEL//
    end;

    local procedure DescriptionOnFormat()
    var
        lIndent: Integer;
    begin
        if (ISSERVICETIER) then
            lIndent := rec.Level
        else
            lIndent := rec.Level * 220;
        DescriptionIndent := lIndent;
        wFormatField;
        DescriptionEmphasize := FontBold;
    end;
}

