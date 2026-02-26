Page 58005 "RTC Sales Invoice Planning"
{
    Caption = 'RTC Sales Invoice Planning';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SaveValues = true;
    SourceTable = Job;
    SourceTableView = sorting("No.")
                      where("Job Type" = const(External));

    layout
    {
        area(content)
        {
            group(Filters)
            {
                Caption = 'Filters';
                field("Gen. Prod Posting Group Filter"; rec."Gen. Prod Posting Group Filter")
                {
                    ApplicationArea = Basic;
                }
                field(TypeDocFilter; TypeDocFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Doc. Type Filter';
                    OptionCaption = 'All,,Order,Invoice,Credit Memo';

                    trigger OnValidate()
                    begin
                        if TypeDocFilter <> Typedocfilter::All then
                            rec.SetRange("Document Type Filter", TypeDocFilter - 1)
                        else
                            rec.SetFilter("Document Type Filter", '<>%1', Typedocfilter::Quote - 1);
                    end;
                }
                field(FiltreSolde; FiltreSolde)
                {
                    ApplicationArea = Basic;
                    Caption = 'Not Finished';

                    trigger OnValidate()
                    begin
                        FiltreSoldeOnPush;
                    end;
                }
                field(ShowView; ShowView)
                {
                    ApplicationArea = Basic;
                    Caption = 'Show';
                    OptionCaption = 'Forcast Not Invoiced ,Forcast,Invoiced';
                }
                field(SalespersonFilter; SalespersonFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Salesperson Filter';
                    TableRelation = "Salesperson/Purchaser";

                    trigger OnValidate()
                    begin
                        rec.SetFilter("Salesperson Code", SalespersonFilter);
                    end;
                }
            }
            group("Options Matrix")
            {
                Caption = 'Options Matrix';
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
                    Caption = 'Quantity Type';
                    OptionCaption = 'Net Change,Balance at Date';
                }
            }
            repeater(Control800390011)
            {
                ShowCaption = false;
                field("No."; rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Bill-to Customer No."; rec."Bill-to Customer No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Distribution Type (Planning)"; rec."Distribution Type (Planning)")
                {
                    ApplicationArea = Basic;
                }
                field("Starting Date"; rec."Starting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Ending Date"; rec."Ending Date")
                {
                    ApplicationArea = Basic;
                }
                field(BudgetTot; BudgetTot)
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = wAmountGetCaptionClass(1);
                    Caption = 'Budgeted Price';
                    Editable = false;

                    trigger OnAssistEdit()
                    var
                        lJobBudgetEntry: Record 1003;
                    begin
                        //NAV5.0 lJobBudgetEntry.SETCURRENTKEY("Job No.","Phase Code","Gen. Prod. Posting Group","Task Code","Step Code");
                        lJobBudgetEntry.SetCurrentkey("Job No.", "Job Task No.", "Gen. Prod. Posting Group");
                        lJobBudgetEntry.SetRange("Job No.", rec."No.");
                        //NAV5.0 COPYFILTER("Phase Filter",lJobBudgetEntry."Phase Code");
                        //NAV5.0 COPYFILTER("Task Filter",lJobBudgetEntry."Task Code");
                        //NAV5.0 COPYFILTER("Step Filter",lJobBudgetEntry."Step Code");
                        lJobBudgetEntry.SetFilter("Total Price", '<>0');
                        //NAV5.0 COPYFILTER("Type Filter",lJobBudgetEntry.Type);
                        rec.Copyfilter("Gen. Prod Posting Group Filter", lJobBudgetEntry."Gen. Prod. Posting Group");
                        if lJobBudgetEntry.Find('-') then
                            page.RunModal(0, lJobBudgetEntry, lJobBudgetEntry."Total Price");
                    end;
                }
                field(gRestDistribute; gRestDistribute)
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = wAmountGetCaptionClass(2);
                    Caption = 'Rest to Distribute';
                    Editable = false;
                }
                field(PF; InvoicedTot)
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    CaptionClass = wAmountGetCaptionClass(3);
                    Caption = 'Invoiced Price';
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        lJobLedgerEntry: Record 169;
                    begin
                        //NAV5.0 lJobLedgerEntry.SETCURRENTKEY("Entry Type",Type,"Job No.","Gen. Prod. Posting Group","Phase Code","Task Code","Step Code",
                        //#6104
                        //lJobLedgerEntry.SETCURRENTKEY("Entry Type",Type,"Job No.","Gen. Prod. Posting Group",
                        //                              "Work Time Type","Work Type Code","Resource Group No.","No.",
                        //                              "Global Dimension 1 Code","Global Dimension 2 Code","Reason Code","Posting Date");
                        lJobLedgerEntry.SetCurrentkey("Job No.", "Entry Type", Type, "No.");
                        //#6104//
                        lJobLedgerEntry.SetRange("Job No.", rec."No.");
                        lJobLedgerEntry.SetRange("Entry Type", lJobLedgerEntry."entry type"::Sale);
                        //NAV5.0 COPYFILTER("Phase Filter",lJobLedgerEntry."Phase Code");
                        //NAV5.0 COPYFILTER("Task Filter",lJobLedgerEntry."Task Code");
                        //NAV5.0 COPYFILTER("Step Filter",lJobLedgerEntry."Step Code");
                        //NAV5.0 COPYFILTER("Type Filter",lJobLedgerEntry.Type);
                        //NAV5.0 COPYFILTER("Gen. Prod Posting Group Filter",lJobLedgerEntry."Gen. Prod. Posting Group");
                        if lJobLedgerEntry.Find('-') then
                            //#6104
                            //  page.RunModal(0,lJobLedgerEntry,lJobLedgerEntry."Total Price (LCY)");
                            page.RunModal(0, lJobLedgerEntry, lJobLedgerEntry."Line Amount (LCY)");
                        //#6104//
                    end;
                }
                field(Field1; ColumnValue[1])
                {
                    ApplicationArea = Basic;
                    //BlankZero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[1];
                    Editable = Field1Editable;

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
                    //BlankZero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[2];
                    Editable = Field2Editable;

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
                    //BlankZero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[3];
                    Editable = Field3Editable;

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
                    //BlankZero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[4];
                    Editable = Field4Editable;

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
                    //BlankZero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[5];
                    Editable = Field5Editable;

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
                    //BlankZero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[6];
                    Editable = Field6Editable;

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
                    //BlankZero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[7];
                    Editable = Field7Editable;

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
                    //BlankZero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[8];
                    Editable = Field8Editable;

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
                    //BlankZero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[9];
                    Editable = Field9Editable;

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
                    //BlankZero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[10];
                    Editable = Field10Editable;

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
                    //BlankZero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[11];
                    Editable = Field11Editable;

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
                    //BlankZero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[12];
                    Editable = Field12Editable;

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

                actionref("Co&mments1"; "Co&mments") { }
                actionref(Dimensions1; Dimensions) { }

                actionref("Customer Outstanding1"; "Customer Outstanding") { }
                actionref("Job Outstanding1"; "Job Outstanding") { }

                actionref(Folder1; Folder) { }
                actionref("&Reports1"; "&Reports") { }
            }


            group("F&unctions1")
            {
                Caption = 'F&unctions';
                actionref("Suggest Distribution1"; "Suggest Distribution") { }
                actionref("Re-Post the forcast not invoiced1"; "Re-Post the forcast not invoiced") { }
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
                /*GL2024   action("&Card")
                   {
                       ApplicationArea = Basic;
                       Caption = '&Card';
                       Image = EditLines;
                       RunpageLink = "No." = FIELD("No.");
                       RunObject = Page 8003901;
                       ////  ShortCutKey = 'Maj+F5';
                   }
              /*GL2024   action(Statistics)
                {
                    ApplicationArea = Basic;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                      Visible = false;
                    PromotedCategory = Process;
                    RunpageLink = Field1 = FIELD("No."),
                                  Field50 = FIELD(Resource "Filter"),
                                  Field51=FIELD(Posting "Date Filter"),
                                  Field52=FIELD(Field52),
                                  Field53=FIELD(Field53),
                                  Field54=FIELD(Field54),
                                  Field55=FIELD(Resource Gr. "Filter");
                    RunObject = Page 222;

                }*/
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunpageLink = "Table Name" = CONST(Job),
                                      "No." = FIELD("No.");
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
                    ////  ShortCutKey = 'Maj+Ctrl+D';
                }
                /*GL2024 action(Budget)
                 {
                     ApplicationArea = Basic;
                     Caption = 'Budget';
                     RunpageLink = Job "No."=FIELD("No.");
                     RunObject = Page 8004192;
                 }*/

                /*GL2024     action(Action1100282022)
                     {
                         ApplicationArea = Basic;
                         Caption = 'Ledger E&ntries';
                         RunpageLink = Job "No."=FIELD("No.");
                         RunpageView = SORTING(Job No.,Posting Date);
                         RunObject = Page 8004162;
                                       ////  ShortCutKey = 'Ctrl+F7';
                     }*/
                action("Customer Outstanding")
                {
                    ApplicationArea = Basic;
                    Caption = 'Customer Outstanding';
                    RunpageLink = "Customer No." = FIELD("Bill-to Customer No.");
                    RunpageView = SORTING("Customer No.", Open, Positive, "Due Date", "Currency Code")
                                          WHERE(Open = CONST(true));
                    RunObject = Page "Customer Ledger Entries";
                }
                action("Job Outstanding")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Outstanding';
                    RunpageLink = "Job No." = FIELD("No.");
                    RunpageView = SORTING("Job No.", "Customer No.", Open, Positive, "Due Date", "Currency Code")
                                          WHERE(Open = CONST(true));
                    RunObject = Page "Customer Ledger Entries";
                }

                action(Folder)
                {
                    ApplicationArea = Basic;
                    Caption = 'Folder';

                    trigger OnAction()
                    var
                        lFolderManagement: Codeunit 8001414;
                    begin
                        //FOLDER
                        lFolderManagement.Job(Rec);
                        //FOLDER//
                    end;
                }
                action("&Reports")
                {
                    ApplicationArea = Basic;
                    Caption = '&Reports';

                    trigger OnAction()
                    var
                        lReportList: Record 8001428;
                        lId: Integer;
                        lRecRef: RecordRef;
                    begin
                        with lReportList do begin
                            //GL2024 Evaluate(lId, Format(page::"NaviBat Job Card"));
                            lRecRef.GetTable(Rec);
                            lRecRef.SetRecfilter;
                            SetRecordRef(lRecRef, true);
                            ShowList(lId);
                        end;
                    end;
                }
                /*GL2024   separator(Action1100282027)
                   {
                   }
                   action("Phases Statistics")
                   {
                       ApplicationArea = Basic;
                       Caption = 'Phases Statistics';
                       RunpageLink = Job "Filter"=FIELD("No."),
                                     Job Totaling=FIELD("FILTER"(Job Totaling));
                       RunObject = Page 8003961;
                     ////  ShortCutKey = 'F7';
                   }
                   action(Contacts)
                   {
                       ApplicationArea = Basic;
                       Caption = 'Contacts';
                       RunpageLink = Job "No."=FIELD("No.");
                       RunpageView = SORTING(Job No.);
                       RunObject = Page 8004052;
                   }
                   separator(Action1100282030)
                   {
                   }
                   action("Production Completion")
                   {
                       ApplicationArea = Basic;
                       Caption = 'Production Completion';
                       RunpageLink = Job "No."=FIELD("No.");
                       RunpageView = SORTING(Order Type,Document Type,Document No.,Presentation Code,Structure Line No.,Job No.)
                                     WHERE(Document Type=CONST(Order),
                                           Structure Line "No."=CONST(0));
                       RunObject = Page 8003984;
                   }
                   action("Job Physical Inventory")
                   {
                       ApplicationArea = Basic;
                       Caption = 'Job Physical Inventory';
                       RunpageLink = Job "No."=FIELD("No.");
                       RunObject = Page 8003967;
                   }*/
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Suggest Distribution")
                {
                    ApplicationArea = Basic;
                    Caption = 'Suggest Distribution';

                    trigger OnAction()
                    var
                        lJob: Record Job;
                        lJobBudgetEntry: Record 1003;
                        lType: Integer;
                        lDocNo: Code[20];
                    begin
                        lJob.Copy(Rec);
                        CurrPage.SetSelectionFilter(lJob);
                        if lJob.Find('-') then
                            repeat
                                lJobBudgetEntry.SetCurrentkey("Document Type", "Document No.");
                                lJobBudgetEntry.SetRange("Job No.", lJob."No.");
                                lJobBudgetEntry.SetFilter("Total Price", '<>0');
                                if lJobBudgetEntry.Find('-') then
                                    repeat
                                        if (lType <> lJobBudgetEntry."Document Type") or (lDocNo <> lJobBudgetEntry."Document No.") then
                                            CalcEst.CalcAmount(lJob, lJobBudgetEntry."Document Type", lJobBudgetEntry."Document No.");
                                        lType := lJobBudgetEntry."Document Type";
                                        lDocNo := lJobBudgetEntry."Document No.";
                                    until lJobBudgetEntry.Next = 0;
                            until lJob.Next = 0;
                    end;
                }
                action("Re-Post the forcast not invoiced")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re-Post the forcast not invoiced';

                    trigger OnAction()
                    var
                        lJob: Record Job;
                    begin
                        lJob.Copy(Rec);
                        CurrPage.SetSelectionFilter(lJob);
                        if lJob.Find('-') then
                            repeat
                                CalcEst.RePostDiff(lJob);
                            until lJob.Next = 0;
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
        //NAV5.0 CALCFIELDS("Budgeted Price","Invoiced Price","Estimated invoicing");
        //#6890
        //CALCFIELDS("Schedule (Total Price)","Usage (Total Price)","Estimated invoicing");
        rec.CalcFields("Schedule (Total Price)", "Usage (Total Price)", "Estimated invoicing", "Contract (Invoiced Price)");
        //#6890//
        BudgetTot := rec."Schedule (Total Price)";
        InvoicedTot := rec."Contract (Invoiced Price)";
        EstTot := rec."Estimated invoicing";

        gRestDistribute := ROUND(BudgetTot - EstTot, gRound);

        lIndex := 0;
        while (lIndex < CurrSetLength) do begin
            lIndex += 1;
            MATRIX_OnAfterGetRecord(lIndex);
        end;
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        Field12Editable := true;
        Field11Editable := true;
        Field10Editable := true;
        Field9Editable := true;
        Field8Editable := true;
        Field7Editable := true;
        Field6Editable := true;
        Field5Editable := true;
        Field4Editable := true;
        Field3Editable := true;
        Field2Editable := true;
        Field1Editable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    var
        LigFeuille: record 210;
        lJobJnlLine: record 210;
        lJnlSelected: Boolean;
    begin
        gRound := 1;

        if PrincCal.Find('-') then;
        if TypeDocFilter <> Typedocfilter::All then
            rec.SetRange("Document Type Filter", TypeDocFilter - 1)
        else
            rec.SetFilter("Document Type Filter", '<>%1', Typedocfilter::Quote - 1);
        Job.CopyFilters(Rec);
        UpdateTempTable;

        SetColumns(Setwanted::Initial);
        //#6890//
    end;

    var
        PeriodFormMgt: Codeunit PeriodPageManagement;
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        QtyType: Option "Net Change","Balance at Date";
        wQte: Decimal;
        wQteOld: Decimal;
        wText: Text[1024];
        JobJnlManagement: Codeunit 8004171;
        CalendarMgmt: Codeunit "Calendar Management";
        PrincCal: Record 7600;
        BudgetTot: Decimal;
        InvoicedTot: Decimal;
        EstTot: Decimal;
        TypeDocFilter: Option All,Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        ShowView: Option "Forcast Not Invoiced ",Forcast,Invoiced;
        CalcEst: Codeunit 8004055;
        EstDet: Decimal;
        SalespersonFilter: Text[30];
        EstTemp: Record 8003948 temporary;
        JobLedgentryTemp: Record 169 temporary;
        Job: Record Job;
        TextPB: label 'Budgeted Price';
        TextPF: label 'Invoiced Price';
        TextRR: label 'Rest to Distribute';
        JobBudgetTemp: Record 1003 temporary;
        FiltreSolde: Boolean;
        gRound: Decimal;
        "---------": Integer;
        gRestDistribute: Decimal;
        ColumnValue: array[12] of Decimal;
        gMatrixPeriods: array[32] of Record Date;
        MatrixColumnCaptions: array[32] of Text[1024];
        ColumnSet: Text[1024];
        CurrSetLength: Integer;
        SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        PKFirstRecInCurrSet: Text[100];
        [InDataSet]
        Field1Editable: Boolean;
        [InDataSet]
        Field2Editable: Boolean;
        [InDataSet]
        Field3Editable: Boolean;
        [InDataSet]
        Field4Editable: Boolean;
        [InDataSet]
        Field5Editable: Boolean;
        [InDataSet]
        Field6Editable: Boolean;
        [InDataSet]
        Field7Editable: Boolean;
        [InDataSet]
        Field8Editable: Boolean;
        [InDataSet]
        Field9Editable: Boolean;
        [InDataSet]
        Field10Editable: Boolean;
        [InDataSet]
        Field11Editable: Boolean;
        [InDataSet]
        Field12Editable: Boolean;

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


    procedure UpdateTempTable()
    var
        lEst: Record 8003948;
        lJobLedgEntry: Record 169;
        lJobBudget: Record 1003;
    begin
        Job.CopyFilters(Rec);
        EstTemp.Reset;
        EstTemp.DeleteAll;
        JobLedgentryTemp.Reset;
        JobLedgentryTemp.DeleteAll;
        JobBudgetTemp.Reset;
        JobBudgetTemp.DeleteAll;
        if Job.Find('-') then
            repeat
                lEst.SetCurrentkey("Job No.");
                lEst.SetRange("Job No.", Job."No.");
                if lEst.Find('-') then
                    repeat
                        EstTemp := lEst;
                        EstTemp.Insert;
                    until lEst.Next = 0;
                lJobLedgEntry.SetCurrentkey("Job No.");
                lJobLedgEntry.SetRange("Job No.", Job."No.");
                if lJobLedgEntry.Find('-') then
                    repeat
                        JobLedgentryTemp := lJobLedgEntry;
                        JobLedgentryTemp.Insert;
                    until lJobLedgEntry.Next = 0;
                lJobBudget.SetCurrentkey("Job No.");
                lJobBudget.SetRange("Job No.", Job."No.");
                if lJobBudget.Find('-') then
                    repeat
                        JobBudgetTemp := lJobBudget;
                        JobBudgetTemp.Insert;
                    until lJobBudget.Next = 0;
            until Job.Next = 0;
    end;

    local procedure wAmountGetCaptionClass(FieldNumber: Integer): Text[80]
    var
        lValue: Decimal;
    begin
        lValue := 0;
        EstTemp.Reset;
        JobLedgentryTemp.Reset;
        JobBudgetTemp.Reset;
        case FieldNumber of
            2:
                begin
                    //NAV5.0    JobBudgetTemp.SETCURRENTKEY("Job No.","Phase Code","Gen. Prod. Posting Group");
                    JobBudgetTemp.SetCurrentkey("Gen. Prod. Posting Group");
                    rec.Copyfilter("Gen. Prod Posting Group Filter", JobBudgetTemp."Gen. Prod. Posting Group");
                    //#6890
                    //    COPYFILTER("Document Type Filter",JobBudgetTemp."Document Type");
                    //    JobBudgetTemp.CALCSUMS("Total Price (LCY)");
                    //    lValue := JobBudgetTemp."Total Price (LCY)";
                    if TypeDocFilter <> Typedocfilter::All then
                        rec.Copyfilter("Document Type Filter", JobBudgetTemp."Document Type");
                    JobBudgetTemp.CalcSums("Line Amount (LCY)");
                    lValue := JobBudgetTemp."Line Amount (LCY)";
                    //6890//
                    EstTemp.SetCurrentkey("Job No.");
                    rec.Copyfilter("Gen. Prod Posting Group Filter", EstTemp."Gen. Prod. Posting Group");
                    EstTemp.SetFilter("Doc. Type", '<>%1', EstTemp."doc. type"::Quote);
                    EstTemp.CalcSums(Amount);
                    //#6890
                    //    lValue := JobBudgetTemp."Total Price" + EstTemp.Amount;
                    lValue := lValue - EstTemp.Amount;
                    //#6890//
                end;
            1:
                begin
                    //NAV5.0    JobBudgetTemp.SETCURRENTKEY("Job No.","Phase Code","Gen. Prod. Posting Group");
                    JobBudgetTemp.SetCurrentkey("Gen. Prod. Posting Group");
                    rec.Copyfilter("Gen. Prod Posting Group Filter", JobBudgetTemp."Gen. Prod. Posting Group");
                    //#6890
                    //    COPYFILTER("Document Type Filter",JobBudgetTemp."Document Type");
                    //    JobBudgetTemp.CALCSUMS("Total Price (LCY)");
                    //    lValue := JobBudgetTemp."Total Price (LCY)";
                    if TypeDocFilter <> Typedocfilter::All then
                        rec.Copyfilter("Document Type Filter", JobBudgetTemp."Document Type");
                    JobBudgetTemp.CalcSums("Line Amount (LCY)");
                    lValue := JobBudgetTemp."Line Amount (LCY)";
                    //#6890//
                end;
            3:
                begin
                    JobLedgentryTemp.SetCurrentkey(
                      "Job No.", "Gen. Prod. Posting Group", "Entry Type", "Work Type Code", Type, "Resource Type", "No.", "Posting Date");
                    rec.Copyfilter("Gen. Prod Posting Group Filter", JobLedgentryTemp."Gen. Prod. Posting Group");
                    JobLedgentryTemp.SetRange("Entry Type", JobLedgentryTemp."entry type"::Sale);
                    //#6104
                    //    JobLedgentryTemp.CALCSUMS("Total Price (LCY)");
                    //    lValue := - JobLedgentryTemp."Total Price (LCY)";
                    JobLedgentryTemp.CalcSums("Line Amount (LCY)");
                    lValue := -JobLedgentryTemp."Line Amount (LCY)";
                    //#6104//
                end;
            else
                ;
        end;
        case FieldNumber of
            1:
                exit('8004050,' + TextPB + '\ ' + Format(lValue));
            2:
                exit('8004050,' + TextRR + '\ ' + Format(lValue));
            3:
                exit('8004050,' + TextPF + '\ ' + Format(lValue));
            else
        end;
    end;


    procedure SetColumns(pPeriodType: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MatrixMgt: Codeunit "Matrix Management";
        DateFilter: Text[30];
    begin
        MatrixMgt.GeneratePeriodMatrixData(pPeriodType, ArrayLen(ColumnValue), false, PeriodType, '',
          PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, gMatrixPeriods);
    end;

    local procedure MATRIX_OnAfterGetRecord(ColumnID: Integer)
    var
        lEditable: Boolean;
    begin
        SetDateFilter(ColumnID);
        //CALCFIELDS("Estimated invoicing","Invoiced Price");
        rec.CalcFields("Estimated invoicing", "Contract (Invoiced Price)");
        ColumnValue[ColumnID] := fCalcValue(lEditable);
        fSetEditableField(ColumnID, lEditable);
    end;


    procedure MatrixOnDrillDown(ColumnID: Integer)
    var
        lEstInv: Record 8003948;
        lJobLedgEntry: Record 169;
    begin
        if ShowView <> Showview::Invoiced then begin
            //#6942
            if ShowView = Showview::Forcast then begin
                //#6942//
                lEstInv.SetCurrentkey("Job No.");
                lEstInv.SetRange("Job No.", rec."No.");
                rec.Copyfilter("Document Type Filter", lEstInv."Doc. Type");
                rec.Copyfilter("Gen. Prod Posting Group Filter", lEstInv."Gen. Prod. Posting Group");
                lEstInv.SetRange("Posting Date", gMatrixPeriods[ColumnID]."Period Start", gMatrixPeriods[ColumnID]."Period End");
                page.RunModal(0, lEstInv);
                CurrPage.Update;
            end;
        end else begin
            //#6942
            lJobLedgEntry.SetCurrentkey("Job No.", "Job Task No.", "Entry Type", "Posting Date");
            lJobLedgEntry.SetRange("Job No.", rec."No.");
            lJobLedgEntry.SetRange("Entry Type", lJobLedgEntry."entry type"::Sale);
            lJobLedgEntry.SetRange("Posting Date", gMatrixPeriods[ColumnID]."Period Start", gMatrixPeriods[ColumnID]."Period End");
            page.RunModal(0, lJobLedgEntry);
            CurrPage.Update;
            //6942//
        end;
    end;


    procedure fCalcValue(var pEditable: Boolean) Return: Decimal
    begin
        pEditable := true;
        case ShowView of
            Showview::"Forcast Not Invoiced ":
                //NAV5.0     lSolde := ROUND("Estimated invoicing" - "Invoiced Price",gRound);
                Return := ROUND(rec."Estimated invoicing" - rec."Contract (Invoiced Price)", gRound);
            Showview::Forcast:
                Return := ROUND(rec."Estimated invoicing", gRound);
            Showview::Invoiced:
                begin
                    //NAV5.0    lSolde := ROUND("Invoiced Price",gRound);
                    Return := ROUND(rec."Contract (Invoiced Price)", gRound);
                    pEditable := false;
                end;
            else
                ;
        end;
    end;


    procedure fSetEditableField(pIndex: Integer; pEditable: Boolean)
    begin
        case (pIndex) of
            1:
                Field1Editable := pEditable;
            2:
                Field2Editable := pEditable;
            3:
                Field3Editable := pEditable;
            4:
                Field4Editable := pEditable;
            5:
                Field5Editable := pEditable;
            6:
                Field6Editable := pEditable;
            7:
                Field7Editable := pEditable;
            8:
                Field8Editable := pEditable;
            9:
                Field9Editable := pEditable;
            10:
                Field10Editable := pEditable;
            11:
                Field11Editable := pEditable;
            12:
                Field12Editable := pEditable;
        end;
    end;


    procedure MatrixOnValidate(pColumnID: Integer)
    var
        lEstInv: Record 8003948;
        lOK: Boolean;
        lJobBudgetEntry: Record 1003;
    begin
        lOK := false;
        case ShowView of
            Showview::"Forcast Not Invoiced ":
                //NAV5.0    lOK := EstDet <> ROUND("Estimated invoicing" - "Invoiced Price",gRound);
                lOK := ColumnValue[pColumnID] <> ROUND(rec."Estimated invoicing" - rec."Contract (Invoiced Price)", gRound);
            Showview::Forcast:
                lOK := ColumnValue[pColumnID] <> ROUND(rec."Estimated invoicing", gRound);
            else
                ;
        end;
        if lOK then begin
            lEstInv.SetCurrentkey("Job No.");
            lEstInv.SetRange("Job No.", rec."No.");
            rec.Copyfilter("Gen. Prod Posting Group Filter", lEstInv."Gen. Prod. Posting Group");
            rec.Copyfilter("Posting Date Filter", lEstInv."Posting Date");
            if TypeDocFilter <> Typedocfilter::All then
                lEstInv.SetRange("Doc. Type", TypeDocFilter - 1);
            lEstInv.CalcSums(Amount);
            lEstInv."Entry No." := 0;
            lEstInv."Job No." := rec."No.";
            if rec.GetFilter("Gen. Prod Posting Group Filter") <> '' then
                lEstInv."Gen. Prod. Posting Group" := rec.GetRangeMin("Gen. Prod Posting Group Filter");
            lEstInv."Posting Date" := gMatrixPeriods[pColumnID]."Period End";
            lJobBudgetEntry.Init;
            //#6668
            //  lJobBudgetEntry.SETCURRENTKEY(Status,Type,"No.","Planning Date");
            lJobBudgetEntry.SetCurrentkey(Status, "Schedule Line", Type, "No.", "Planning Date");
            //#6668//
            lJobBudgetEntry.SetRange("Job No.", rec."No.");
            lJobBudgetEntry.SetFilter("Total Price", '<>0');
            if TypeDocFilter <> Typedocfilter::All then
                lJobBudgetEntry.SetRange("Document Type", TypeDocFilter - 1);
            lEstInv."Doc. Type" := lJobBudgetEntry."document type"::Order;
            if lJobBudgetEntry.Find('+') then begin
                lEstInv."Doc. Type" := lJobBudgetEntry."Document Type";
                lEstInv."Doc. No." := lJobBudgetEntry."Document No.";
            end;
            case ShowView of
                //NAV5.0    ShowView::"Forcast Not Invoiced " : lEstInv.Amount := ROUND(EstDet + "Invoiced Price",gRound) - lEstInv.Amount;
                Showview::"Forcast Not Invoiced ":
                    lEstInv.Amount := ROUND(ColumnValue[pColumnID] +
                                            rec."Contract (Invoiced Price)", gRound) - lEstInv.Amount;
                Showview::Forcast:
                    lEstInv.Amount := ROUND(ColumnValue[pColumnID], gRound) - lEstInv.Amount;
                else
                    ;
            end;
            if lEstInv.Amount <> 0 then
                lEstInv.Insert(true);
            CurrPage.Update;
        end;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        if Job.GetFilters <> rec.GetFilters then begin
            UpdateTempTable;
        end;
    end;

    local procedure FiltreSoldeOnPush()
    begin
        if FiltreSolde then
            rec.SetRange(Finished, not FiltreSolde)
        else
            rec.SetRange(Finished);
    end;
}

